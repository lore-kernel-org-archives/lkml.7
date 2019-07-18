Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA14C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 14:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98A982080D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 14:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390509AbfGROzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 10:55:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56602 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbfGROzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 10:55:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1AAFE882FB;
        Thu, 18 Jul 2019 14:55:51 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id CA000608A6;
        Thu, 18 Jul 2019 14:55:49 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 18 Jul 2019 16:55:50 +0200 (CEST)
Date:   Thu, 18 Jul 2019 16:55:49 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Andrew Fox <afox@redhat.com>,
        Stephen Johnston <sjohnsto@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/cputime: make scale_stime() more precise
Message-ID: <20190718145549.GA22902@redhat.com>
References: <20190718131834.GA22211@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718131834.GA22211@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 18 Jul 2019 14:55:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/18, Oleg Nesterov wrote:
>
> + * NOTE! currently the only user is cputime_adjust() and thus
> + *
> + *	stime < total && rtime > total
> + *
> + * this means that the end result is always precise and the additional
> + * div64_u64_rem() inside the main loop is called at most once.

Ah, I just noticed that the comment is not 100% correct... in theory we
can drop the precision and even do div64_u64_rem() more than once, but this
can only happen if stime or total = stime + utime is "really" huge, I don't
think this can happen in practice...

We can probably just do

	static u64 scale_stime(u64 stime, u64 rtime, u64 total)
	{
		u64 res = 0, div, rem;

		if (ilog2(stime) + ilog2(rtime) > 62) {
			div = div64_u64_rem(rtime, total, &rem);
			res += div * stime;
			rtime = rem;

			int shift = ilog2(stime) + ilog2(rtime) - 62;
			if (shift > 0) {
				rtime >>= shift;
				total >>= shitt;
				if (!total)
					return res;
			}
		}

		return res + div64_u64(stime * rtime, total);
	}

but this way the code looks less generic.

Oleg.

