Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C2FC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 10:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34CA124654
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 10:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bwQGX8IP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbfLEKDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 05:03:12 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:42696 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfLEKDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 05:03:11 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB59s8DM008065;
        Thu, 5 Dec 2019 10:02:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=05vzxwu12UNKNbD54baLfuh1gECkS613qjdy5dBFgIM=;
 b=bwQGX8IPVR/KB98qtE61W0h+HQk2zsbbcdvm8dNGdmUghr74ST7VgDqa6kiCjDdAlf3L
 DIWly2HJDk13Xp16BjnodJ1NBmIIpFIlegTjRgC6+uzbaqBx40jeL4uLYz+XPPOMKFQM
 gW48eiz52vzOapFcUlp9w/T++uFXGE58/OUwFGkvcGJuwteqQq9mLWgV1s+CkzWY0/SO
 bYI7ZebdY4/EVCepgV06AE3DHV3swGy9Ip54ZqEC1Boroh1GhoXHuHRbjNorgElPOkfm
 0EWJMOiR7ojmnDKnaQ8hfGMsGUNYN00Ib3zJFIDNaozySRc6SNiLJXJKF0oE2kXZ2Wlm qA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2wkfuum8h6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Dec 2019 10:02:34 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB59s0ki037084;
        Thu, 5 Dec 2019 10:02:33 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2wpp73usc1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Dec 2019 10:02:32 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xB5A2SRk019046;
        Thu, 5 Dec 2019 10:02:30 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 05 Dec 2019 02:02:27 -0800
Date:   Thu, 5 Dec 2019 13:02:20 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] Silence an uninitialized variable warning
Message-ID: <20191205100220.GH1765@kadam>
References: <20191126121934.kuolgbm55dirfbay@kili.mountain>
 <20191204092640.692c95af@gandalf.local.home>
 <20191204184247.GG1765@kadam>
 <20191205093229.GE2810@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205093229.GE2810@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9461 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912050080
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9461 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912050080
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2019 at 10:32:29AM +0100, Peter Zijlstra wrote:
> On Wed, Dec 04, 2019 at 09:42:47PM +0300, Dan Carpenter wrote:
> 
> > > The current code has this:
> > > 
> > > static int __init syscall_enter_define_fields(struct trace_event_call *call)
> > > {
> > > 	struct syscall_trace_enter trace;
> > > 	struct syscall_metadata *meta = call->data;
> > > 	int ret;
> > > 	int i;
> > > 	int offset = offsetof(typeof(trace), args);
> > > 
> > > 	ret = trace_define_field(call, SYSCALL_FIELD(int, nr, __syscall_nr),
> > > 				 FILTER_OTHER);
> > 
> > In linux-next this ret = trace_define_field() assignment is removed.
> > That was commit 60fdad00827c ("ftrace: Rework event_create_dir()").
> 
> Yep, mea culpa.
> 
> > > 	if (ret)
> > > 		return ret;
> > > 
> > > 	for (i = 0; i < meta->nb_args; i++) {
> > > 		ret = trace_define_field(call, meta->types[i],
> > > 					 meta->args[i], offset,
> > > 					 sizeof(unsigned long), 0,
> > > 					 FILTER_OTHER);
> > > 		offset += sizeof(unsigned long);
> > > 	}
> > > 
> > > 	return ret;
> > > }
> > > 
> > > 
> > > How can ret possibly be uninitialized?
> > 
> > I should have written this commit more carefully and verified whether
> > meta->nb_args can actually be zero instead of just assuming it was a
> > false positive...
> 
> Right, I'm thinking this is in fact possible. We have syscalls without
> arguments (sys_sched_yield for exmaple).

Well, it would have triggered a run time bug because of that thing with
GCC where it sometimes initializes variables to zero.

Let me resend properly with a Fixes tag.

regards,
dan carpenter
