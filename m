Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D240BC7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 14:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF24F2182B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 14:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390586AbfGWO3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 10:29:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53458 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729666AbfGWO3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 10:29:21 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E03EF81F18;
        Tue, 23 Jul 2019 14:29:20 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 47AC560603;
        Tue, 23 Jul 2019 14:29:19 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 23 Jul 2019 16:29:20 +0200 (CEST)
Date:   Tue, 23 Jul 2019 16:29:18 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Fox <afox@redhat.com>,
        Stephen Johnston <sjohnsto@redhat.com>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stanislaw Gruszka <sgruszka@redhat.com>
Subject: Re: [PATCH] sched/cputime: make scale_stime() more precise
Message-ID: <20190723142918.GC8994@redhat.com>
References: <20190718131834.GA22211@redhat.com>
 <20190719110349.GG3419@hirez.programming.kicks-ass.net>
 <20190719134727.GV3463@hirez.programming.kicks-ass.net>
 <20190719143742.GA32243@redhat.com>
 <20190722195605.GI6698@worktop.programming.kicks-ass.net>
 <20190723140043.GB8994@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723140043.GB8994@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 23 Jul 2019 14:29:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/23, Oleg Nesterov wrote:
>
> > > Yes, statistically the numbers are proportionally divided.
> >
> > This; due to the loss in precision the distribution is like a step
> > function around the actual s:u ratio line, but on average it still is
> > s:u.
>
> You know, I am no longer sure... perhaps it is even worse, I need to recheck.

To clarify, this is probably true even if prev_cputime adds more confusion.
But how many minutes (hours? days?) you need to look at /proc/pid/stat
to get the average which more or less matches the reality?

Oleg.

