Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448A8C2D0BF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 09:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19B882464F
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 09:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ku7cmcS/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbfLEJck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 04:32:40 -0500
Received: from merlin.infradead.org ([205.233.59.134]:40798 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728549AbfLEJck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 04:32:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=k6qzosDA4eixwAD25vNTaqV17qfy2EeIG32nh5n5PvI=; b=Ku7cmcS/d6dg0G8k7Kn7puxHa
        DPzgNm2W9T/6TKenDN63Jc4fqyDw0kY3v/3jZm7OcBEET3Xkuc8r7rdPHjlPiMRgNnpgxyEJio8eu
        DcJmWsWRmHsgqwUCOw5szKPNZZFDlNu1QOUCUt7+KeAf+Ec5nMhcMUt+BRUcWluX2bB15YOwPpPY2
        BZs7P56LFdakUaGL+dcyOAaT+x3l6aq8+nzDAMI9vP9ZtGTDS0bW+RzRJr/t4WDjUpDBrNHn6ub3z
        vhpWdLr5yQgkMKaocMyv3V724fVwOMVUtY7RXK8CTeeSptQdW/Ue6MAKshNr6NG4hTL1PjSp9Tusc
        DUEvcsynA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1icnUu-0002Nm-55; Thu, 05 Dec 2019 09:32:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EA7CA301A6C;
        Thu,  5 Dec 2019 10:31:12 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CC2202B26E207; Thu,  5 Dec 2019 10:32:29 +0100 (CET)
Date:   Thu, 5 Dec 2019 10:32:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] Silence an uninitialized variable warning
Message-ID: <20191205093229.GE2810@hirez.programming.kicks-ass.net>
References: <20191126121934.kuolgbm55dirfbay@kili.mountain>
 <20191204092640.692c95af@gandalf.local.home>
 <20191204184247.GG1765@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204184247.GG1765@kadam>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2019 at 09:42:47PM +0300, Dan Carpenter wrote:

> > The current code has this:
> > 
> > static int __init syscall_enter_define_fields(struct trace_event_call *call)
> > {
> > 	struct syscall_trace_enter trace;
> > 	struct syscall_metadata *meta = call->data;
> > 	int ret;
> > 	int i;
> > 	int offset = offsetof(typeof(trace), args);
> > 
> > 	ret = trace_define_field(call, SYSCALL_FIELD(int, nr, __syscall_nr),
> > 				 FILTER_OTHER);
> 
> In linux-next this ret = trace_define_field() assignment is removed.
> That was commit 60fdad00827c ("ftrace: Rework event_create_dir()").

Yep, mea culpa.

> > 	if (ret)
> > 		return ret;
> > 
> > 	for (i = 0; i < meta->nb_args; i++) {
> > 		ret = trace_define_field(call, meta->types[i],
> > 					 meta->args[i], offset,
> > 					 sizeof(unsigned long), 0,
> > 					 FILTER_OTHER);
> > 		offset += sizeof(unsigned long);
> > 	}
> > 
> > 	return ret;
> > }
> > 
> > 
> > How can ret possibly be uninitialized?
> 
> I should have written this commit more carefully and verified whether
> meta->nb_args can actually be zero instead of just assuming it was a
> false positive...

Right, I'm thinking this is in fact possible. We have syscalls without
arguments (sys_sched_yield for exmaple).
