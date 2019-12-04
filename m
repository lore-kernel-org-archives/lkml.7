Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB32EC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEB1E20675
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S6ZibFY0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbfLDSn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:43:57 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:49246 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728244AbfLDSn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:43:57 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB4IY6on074545;
        Wed, 4 Dec 2019 18:43:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=iW3p+lMiFZuhMFDcuCH3k9CwOvQRI86to7kQ5iH1Rq4=;
 b=S6ZibFY0lW8ejK3kFSiyqf7Vpdd9fY6E2NTXRsRhCYThgfMRpGz8vcMPSFGZaruvC3hZ
 jgEKyGaGOquOpKxZMjUgyDcx8BXEJ2JNNRm4xm2qHrD6+q11Gqy4YlRlIW3ZX9krO23X
 aIaPgqywANWpQVonrZ0vS/12Gs6nvGNhS0RUsS1cxtoJjZ1FHy7F7XWi1GSgzka2Mc1T
 jH7gnKqm2XA1B3+6+13SGIAUiwXMdTvIUCr/30qGFGcellsnE2VPvbo6ta3MF8V3LZ6+
 06lwveWeAZ/Tf77qBCLVQ5mo600cJW8BB9jWoL2Fn5ZQgb+cXqZdWzjmW6MGydu08aji qw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2wkh2rg5c5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Dec 2019 18:43:16 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB4IhFsD014723;
        Wed, 4 Dec 2019 18:43:16 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2wp17en7cr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Dec 2019 18:43:15 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xB4Igt7S024219;
        Wed, 4 Dec 2019 18:42:56 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 04 Dec 2019 10:42:54 -0800
Date:   Wed, 4 Dec 2019 21:42:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] Silence an uninitialized variable warning
Message-ID: <20191204184247.GG1765@kadam>
References: <20191126121934.kuolgbm55dirfbay@kili.mountain>
 <20191204092640.692c95af@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204092640.692c95af@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9461 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912040151
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9461 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912040150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2019 at 09:26:40AM -0500, Steven Rostedt wrote:
> On Tue, 26 Nov 2019 15:19:34 +0300
> Dan Carpenter <dan.carpenter@oracle.com> wrote:
> 
> > Smatch complains that "ret" could be uninitialized if we don't enter the
> > loop.  I don't know if that's possible, but it's nicer to return a
> > literal zero instead.
> > 
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >  kernel/trace/trace_syscalls.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
> > index 73140d80dd46..63528f458826 100644
> > --- a/kernel/trace/trace_syscalls.c
> > +++ b/kernel/trace/trace_syscalls.c
> > @@ -286,7 +286,7 @@ static int __init syscall_enter_define_fields(struct trace_event_call *call)
> >  		offset += sizeof(unsigned long);
> >  	}
> >  
> > -	return ret;
> > +	return 0;
> >  }
> >  
> >  static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
> 
> The current code has this:
> 
> static int __init syscall_enter_define_fields(struct trace_event_call *call)
> {
> 	struct syscall_trace_enter trace;
> 	struct syscall_metadata *meta = call->data;
> 	int ret;
> 	int i;
> 	int offset = offsetof(typeof(trace), args);
> 
> 	ret = trace_define_field(call, SYSCALL_FIELD(int, nr, __syscall_nr),
> 				 FILTER_OTHER);

In linux-next this ret = trace_define_field() assignment is removed.
That was commit 60fdad00827c ("ftrace: Rework event_create_dir()").

> 	if (ret)
> 		return ret;
> 
> 	for (i = 0; i < meta->nb_args; i++) {
> 		ret = trace_define_field(call, meta->types[i],
> 					 meta->args[i], offset,
> 					 sizeof(unsigned long), 0,
> 					 FILTER_OTHER);
> 		offset += sizeof(unsigned long);
> 	}
> 
> 	return ret;
> }
> 
> 
> How can ret possibly be uninitialized?

I should have written this commit more carefully and verified whether
meta->nb_args can actually be zero instead of just assuming it was a
false positive...

regards,
dan carpenter

