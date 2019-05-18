Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D55C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 15:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00E7F2087B
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 15:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729784AbfERPRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 11:17:33 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53950 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728516AbfERPRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 11:17:32 -0400
Received: from p5de0b374.dip0.t-ipconnect.de ([93.224.179.116] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hS15U-00084H-AF; Sat, 18 May 2019 17:17:28 +0200
Date:   Sat, 18 May 2019 17:17:27 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
cc:     Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] time: validate watchdog clocksource using second
 best candidate
In-Reply-To: <155790645605.1933.906798561802423361.stgit@buzz>
Message-ID: <alpine.DEB.2.21.1905181712000.3019@nanos.tec.linutronix.de>
References: <155790645605.1933.906798561802423361.stgit@buzz>
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

On Wed, 15 May 2019, Konstantin Khlebnikov wrote:

> Timekeeping watchdog verifies doubtful clocksources using more reliable
> candidates. For x86 it likely verifies 'tsc' using 'hpet'. But 'hpet'
> is far from perfect too. It's better to have second opinion if possible.
> 
> We're seeing sudden jumps of hpet counter to 0xffffffff:

On which kind of hardware? A particular type of CPU or random ones?

> timekeeping watchdog on CPU56: Marking clocksource 'tsc' as unstable because the skew is too large:
> 'hpet' wd_now: ffffffff wd_last: 19ec5720 mask: ffffffff
> 'tsc' cs_now: 69b8a15f0aed cs_last: 69b862c9947d mask: ffffffffffffffff
> 
> Shaohua Li reported the same case three years ago.
> His patch backlisted this exact value and re-read hpet counter.

Can you provide a reference please? Preferrably a lore.kernel.org/... URL

> This patch uses second reliable clocksource as backup for validation.
> For x86 this is usually 'acpi_pm'. If watchdog and backup are not consent
> then other clocksources will not be marked as unstable at this iteration.

The mess you add to the watchdog code is unholy and that's broken as there
is no guarantee for acpi_pm (or any other secondary watchdog) being
available.

If the only wreckaged value is always ffffffff then I rather reread the
hpet in that case. But not in the watchdog code, we need to do that in the
HPET code as this affects any other HPET user as well.

Thanks,

	tglx
