Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F36C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 13:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89DD020880
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 13:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390239AbfGRNVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 09:21:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:11922 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727623AbfGRNVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 09:21:11 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B7A0E81DE5;
        Thu, 18 Jul 2019 13:21:10 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 738C21001B12;
        Thu, 18 Jul 2019 13:21:09 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 18 Jul 2019 15:21:10 +0200 (CEST)
Date:   Thu, 18 Jul 2019 15:21:08 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Andrew Fox <afox@redhat.com>,
        Stephen Johnston <sjohnsto@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/cputime: make scale_stime() more precise
Message-ID: <20190718132108.GA22220@redhat.com>
References: <20190718131834.GA22211@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718131834.GA22211@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 18 Jul 2019 13:21:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To simplify the review, see the code with this patch applied:

/*
 * Perform (stime * rtime) / total, but avoid multiplication overflow
 * by losing precision when the numbers are big.
 *
 * NOTE! currently the only user is cputime_adjust() and thus
 *
 *	stime < total && rtime > total
 *
 * this means that the end result is always precise and the additional
 * div64_u64_rem() inside the main loop is called at most once.
 */
static u64 scale_stime(u64 stime, u64 rtime, u64 total)
{
	u64 res = 0, div, rem;

	/* can stime * rtime overflow ? */
	while (ilog2(stime) + ilog2(rtime) > 62) {
		if (stime > rtime)
			swap(rtime, stime);

		if (rtime >= total) {
			/*
			 * (rtime * stime) / total is equal to
			 *
			 *	(rtime / total) * stime +
			 *	(rtime % total) * stime / total
			 *
			 * if nothing overflows. Can the 1st multiplication
			 * overflow? Yes, but we do not care: this can only
			 * happen if the end result can't fit in u64 anyway.
			 *
			 * So the code below does
			 *
			 *	res += (rtime / total) * stime;
			 *	rtime = rtime % total;
			 */
			div = div64_u64_rem(rtime, total, &rem);
			res += div * stime;
			rtime = rem;
			continue;
		}

		/* drop precision */
		rtime >>= 1;
		total >>= 1;
		if (!total)
			return res;
	}

	return res + div64_u64(stime * rtime, total);
}

