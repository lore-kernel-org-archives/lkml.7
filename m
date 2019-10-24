Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 761D4CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 13:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50D5B21906
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 13:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502246AbfJXNAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 09:00:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:50548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726484AbfJXNAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 09:00:41 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A16F92166E;
        Thu, 24 Oct 2019 13:00:39 +0000 (UTC)
Date:   Thu, 24 Oct 2019 09:00:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Divya Indi <divya.indi@oracle.com>
Cc:     linux-kernel@vger.kernel.org, Joe Jin <joe.jin@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>,
        Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Subject: Re: [PATCH 4/5] tracing: Handle the trace array ref counter in new
 functions
Message-ID: <20191024090037.78fe9f30@gandalf.local.home>
In-Reply-To: <2b08751a-4028-2130-9a70-c2aa2d76a31c@oracle.com>
References: <1565805327-579-1-git-send-email-divya.indi@oracle.com>
        <1565805327-579-5-git-send-email-divya.indi@oracle.com>
        <20191015190436.65c8c7a3@gandalf.local.home>
        <4cad186e-ba8b-8e1a-731b-4350a095ba5a@oracle.com>
        <20191022225253.4086195c@oasis.local.home>
        <2b08751a-4028-2130-9a70-c2aa2d76a31c@oracle.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Oct 2019 15:57:49 -0700
Divya Indi <divya.indi@oracle.com> wrote:

> Hi Steven,                                                                         
>                                                                                  
> A few clarifications on this discussion on reference counter -                   
>                                                                                  
> 1) We will still need to export trace_array_put() to be used for every           
> trace_array_get_by_name() OR trace_array_create() + trace_array_get().        

I'm fine with exporting trace_array_put, and even trace_array_get.
      
>                                                                                  
> How else will we reduce the reference counter [For eg: When multiple modules     
> lookup the same trace array (say, reference counter = 4)]?                       
>                                                                                  
> 2) tr = trace_array_create("my_tr");                                             
>    trace_array_get(tr);                                                          
>                                                                                  
> Both of these functions will iterate through the list of trace arrays to verify  
> whether the trace array exists (redundant, but more intuitive? Does this seem    
> acceptable?)                                                                     
>                                                                                  
> To avoid iterating twice, we went with increasing ref_ctr in trace_array_create. 
> This necessitated a trace_array_put() in instance_mkdir (Or as suggested below,
> we can do this trace_array_put() in instance_rmdir().)                        
>                                                                                                                
>                                                                                  
> 3) A summary of suggested changes (Let me know if this looks good) -                                              
>                                                                                  
> tr = trace_array_get_by_name("foo-bar"); // ref_ctr++.                           
>                                                                                  
> if (!tr)                                                                         
> {                                                                                
>         // instance_mkdir also causes ref_ctr = 1                                

You'll need locking for anyone who does this, and check the return
status below for "foo-bar" existing already (due to another thread
jumping in here).

-- Steve

>         tr = trace_array_create("foo-bar"); // ref_ctr = 1                       
>         trace_array_get(tr); // ref_ctr++                                        
> }                                                                                
>                                                                                  
> trace_array_printk(.....);                                                       
> trace_array_set_clr_event(......);                                               
> ...                                                                              
> ...                                                                              
> ...                                                                              
> // Done using the trace array.                                                   
> trace_array_put(tr); // ref_ctr--                                                
> ...                                                                              
> ...                                                                              
> ...                                                                              
> // We can now remove the trace array via trace_array_destroy or instance_rmdir()
> trace_array_destroy(tr); // ref_ctr > 1 returns -EBUSY.

