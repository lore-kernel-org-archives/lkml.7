Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950BECA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 18:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DCA42089C
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 18:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505938AbfJRSlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 14:41:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58209 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730794AbfJRSlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 14:41:21 -0400
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iLXBb-0005D7-Qt; Fri, 18 Oct 2019 20:41:15 +0200
Date:   Fri, 18 Oct 2019 20:41:14 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Michael Zhivich <mzhivich@akamai.com>
cc:     linux-kernel@vger.kernel.org, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, rafael.j.wysocki@intel.com
Subject: Re: [PATCH] clocksource: tsc: respect tsc bootparam for
 clocksource_tsc_early
In-Reply-To: <20191002141553.7682-1-mzhivich@akamai.com>
Message-ID: <alpine.DEB.2.21.1910181953120.1869@nanos.tec.linutronix.de>
References: <20191002141553.7682-1-mzhivich@akamai.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Oct 2019, Michael Zhivich wrote:
> Introduction of clocksource_tsc_early broke functionality of "tsc=reliable"
> and "tsc=nowatchdog" boot params, since clocksource_tsc_early is *always*
> registered with CLOCK_SOURCE_MUST_VERIFY and thus put on the watchdog list.
> 
> If CPU is very busy during boot, the watchdog clocksource may not be
> read frequently enough, resulting in a large difference that is treated as
> "negative" by clocksource_delta() and incorrectly truncated to 0.

What? 

>   clocksource: timekeeping watchdog on CPU1: Marking clocksource
>                'tsc-early' as unstable because the skew is too large:
>   clocksource: 'refined-jiffies' wd_now: fffb7019 wd_last: fffb6e28

    0xfffb7019 - 0xfffb6e28 = 497

What's treated negative there? And what would truncate that to 0?

>                 mask: ffffffff

A 'negative delta' value can only happen when the clocksource is not read
before it advanced more than mask/2. For jiffies this means 2^31
ticks. That would be ~248 days for HZ=100 or ~24 days for HZ=1000.

>   clocksource: 'tsc-early' cs_now: 52c3918b89d6 cs_last: 52c31d736d2e

  0x52c3918b89d6 - 0x52c31d736d2e = 1.94774e+09

Again nothing is treated negative here, but the point is that the TSC
advanced by ~2e9 cycles while jiffies advanced by 497.

How that's related, I can't tell because I don't know the TSC frequency of
your machine. HZ is probably 1000 as the watchdog period is HZ/2.

>                 mask: ffffffffffffffff
>   tsc: Marking TSC unstable due to clocksource watchdog

Even if the watchdog is not read out for a quite some time, the math in
there and in clocksource_delta() can handle pretty large deltas.

The watchdog triggers when

    abs(delta_watchdog - delta_tsc) > 0.0625 seconds

So that has absolutely nothing to do with CPU being busy and watchdog not
being serviced. jiffies and TSC drift apart for some reason, and that
reason wants to be documented in the changelog.

That said, I have no objections against the patch itself, but I'm not going
to apply a patch with a fairy tale changelog.

Thanks,

	tglx
