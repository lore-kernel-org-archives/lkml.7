Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F07C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 23:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50314218A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 23:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552606004;
	bh=RigepHWrfSK+AwwFJlXHPPuWJ7H9V54gH7ztmtuGY5U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=bgco0Vt/Db7FZUYWEj86Rg16ET5rxHBNtYl7+6MpPMiPOl0b172Ie3yzRIcTu8pPT
	 gf0AojBt9EXY/+xSXcnAQGPcNAyietBnUpRBko9PyhjDDy29IGW9ZKaxLr5Rgi6af6
	 AXRTfjrtZw5sUQw+H4gWVDevqcKJlgyYZe17Klo8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbfCNX0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 19:26:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:42398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728035AbfCNX0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 19:26:42 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DB5A2184C;
        Thu, 14 Mar 2019 23:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552606001;
        bh=RigepHWrfSK+AwwFJlXHPPuWJ7H9V54gH7ztmtuGY5U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dRjis4Pl5VRwLYzegPOiBLxjvMzeW3buIgMLJa170RtYdqxspHB8dcnvsgyWEK5Rl
         oCSBIazmnoh3/iCl1IhLCA/6B6qOqQGpnn2LWCJ68XatXVvrkLwZJxcysadNC3+rAQ
         25tLVx2UIQDdsLFp6EzK4yiy+tz+fmRrJ7JvCerQ=
Date:   Fri, 15 Mar 2019 08:26:37 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] tracing: initialize variable in create_dyn_event()
Message-Id: <20190315082637.e38ff91363ecd57de4015c59@kernel.org>
In-Reply-To: <20190314181908.0af526af@gandalf.local.home>
References: <1548382670-30266-1-git-send-email-frowand.list@gmail.com>
        <2872713a-8b99-5117-27df-eeda824e55a0@gmail.com>
        <20190314181908.0af526af@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank and Steve,

Thank you for pointing it out :)

On Thu, 14 Mar 2019 18:19:08 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 14 Mar 2019 14:05:02 -0700
> Frank Rowand <frowand.list@gmail.com> wrote:
> 
> > Hi Steve,
> > 
> > Ping.
> 
> Thanks, this got buried.
> 
> > >  static int create_dyn_event(int argc, char **argv)
> > >  {
> > >  	struct dyn_event_operations *ops;
> > > -	int ret;
> > > +	int ret = 0;
> 
> Probably should be ret = -ENODEV;
> 
> As if ret doesn't get set, then no dynamic code has been registered,
> and something is truly wrong.

I Agreed to return -ENODEV instead of 0.

Thank you,

> 
> -- Steve
> 
> 
> > >  
> > >  	if (argv[0][0] == '-' || argv[0][0] == '!')
> > >  		return dyn_event_release(argc, argv, NULL);
> > >   
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
