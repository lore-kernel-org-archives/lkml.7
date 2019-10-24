Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 312B1CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 21:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E76EE20684
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 21:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZWe+8JC8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbfJXVcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 17:32:23 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:43526 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbfJXVcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 17:32:23 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9OLSVH7149758;
        Thu, 24 Oct 2019 21:31:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=7VNCm8/h59zAbyDESPWUwTXCjH05vwC9XImN45kK2og=;
 b=ZWe+8JC8tshXEZcb6gNK3DIukQBAeEETMDfC0XT+N8FqGLQdH+2w/5kCuFjMuhYFZfrF
 jmBi5rHi6Gp04aj29Gtkcuipcx3qIlSvzQn65mu6O2Pa9dOs/GymgzHnXfK6kwVO3OfF
 SEScMPC4vddgRHA9rKDDOI/ql3xPgRjrO2Lu6l+H7+yhB0J8kzDEK0PqlnChiJAm3Rz1
 ALRRvJlEHcg0QtxHc6Ved+o1gxypFqjqP5HJty2LtbuGc6o7kJDjmC939b8bZUux993k
 Dfh/uaB77xaC2dXC20VbSg1iTtOuYdOcadr0p7mXpE7My9AXjLmsabANBNw8tyfO2crW eg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2vqteq6c9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Oct 2019 21:31:54 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9OLSQLM014161;
        Thu, 24 Oct 2019 21:31:54 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2vtsk5t3by-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Oct 2019 21:31:54 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9OLVrJF006728;
        Thu, 24 Oct 2019 21:31:53 GMT
Received: from dhcp-10-10-58-254.usdhcp.oraclecorp.com (/10.10.58.254)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 24 Oct 2019 14:31:52 -0700
Subject: Re: [PATCH 4/5] tracing: Handle the trace array ref counter in new
 functions
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Joe Jin <joe.jin@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>,
        Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
References: <1565805327-579-1-git-send-email-divya.indi@oracle.com>
 <1565805327-579-5-git-send-email-divya.indi@oracle.com>
 <20191015190436.65c8c7a3@gandalf.local.home>
 <4cad186e-ba8b-8e1a-731b-4350a095ba5a@oracle.com>
 <20191022225253.4086195c@oasis.local.home>
 <2b08751a-4028-2130-9a70-c2aa2d76a31c@oracle.com>
 <20191024090037.78fe9f30@gandalf.local.home>
From:   Divya Indi <divya.indi@oracle.com>
Message-ID: <74a1af20-5f99-bb64-1e0f-c8405bd68014@oracle.com>
Date:   Thu, 24 Oct 2019 14:31:51 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191024090037.78fe9f30@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9420 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910240202
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9420 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910240202
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

On 10/24/19 6:00 AM, Steven Rostedt wrote:
> On Wed, 23 Oct 2019 15:57:49 -0700
> Divya Indi <divya.indi@oracle.com> wrote:
>
>> Hi Steven,                                                                         
>>                                                                                  
>> A few clarifications on this discussion on reference counter -                   
>>                                                                                  
>> 1) We will still need to export trace_array_put() to be used for every           
>> trace_array_get_by_name() OR trace_array_create() + trace_array_get().        
> I'm fine with exporting trace_array_put, and even trace_array_get.
>       
>>                                                                                  
>> How else will we reduce the reference counter [For eg: When multiple modules     
>> lookup the same trace array (say, reference counter = 4)]?                       
>>                                                                                  
>> 2) tr = trace_array_create("my_tr");                                             
>>    trace_array_get(tr);                                                          
>>                                                                                  
>> Both of these functions will iterate through the list of trace arrays to verify  
>> whether the trace array exists (redundant, but more intuitive? Does this seem    
>> acceptable?)                                                                     
>>                                                                                  
>> To avoid iterating twice, we went with increasing ref_ctr in trace_array_create. 
>> This necessitated a trace_array_put() in instance_mkdir (Or as suggested below,
>> we can do this trace_array_put() in instance_rmdir().)                        
>>                                                                                                                
>>                                                                                  
>> 3) A summary of suggested changes (Let me know if this looks good) -                                              
>>                                                                                  
>> tr = trace_array_get_by_name("foo-bar"); // ref_ctr++.                           
>>                                                                                  
>> if (!tr)                                                                         
>> {                                                                                
>>         // instance_mkdir also causes ref_ctr = 1                                
> You'll need locking for anyone who does this, and check the return
> status below for "foo-bar" existing already (due to another thread
> jumping in here).

Right, Noted! Thanks for the pointer. 

>
> -- Steve
>
>>         tr = trace_array_create("foo-bar"); // ref_ctr = 1                       
>>         trace_array_get(tr); // ref_ctr++                                        
>> }                                                                                
>>                                                                                  
>> trace_array_printk(.....);                                                       
>> trace_array_set_clr_event(......);                                               
>> ...                                                                              
>> ...                                                                              
>> ...                                                                              
>> // Done using the trace array.                                                   
>> trace_array_put(tr); // ref_ctr--                                                
>> ...                                                                              
>> ...                                                                              
>> ...                                                                              
>> // We can now remove the trace array via trace_array_destroy or instance_rmdir()
>> trace_array_destroy(tr); // ref_ctr > 1 returns -EBUSY.
