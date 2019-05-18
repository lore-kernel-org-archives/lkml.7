Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286D7C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 18:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0551520873
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 18:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729720AbfERS01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 14:26:27 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:54268 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfERS00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 14:26:26 -0400
Received: from p5de0b374.dip0.t-ipconnect.de ([93.224.179.116] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hS42I-0001ix-6A; Sat, 18 May 2019 20:26:22 +0200
Date:   Sat, 18 May 2019 20:26:21 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
cc:     Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] time: validate watchdog clocksource using second
 best candidate
In-Reply-To: <602b155f-4108-2865-3f1c-4e63d73405ed@yandex-team.ru>
Message-ID: <alpine.DEB.2.21.1905182023520.3019@nanos.tec.linutronix.de>
References: <155790645605.1933.906798561802423361.stgit@buzz> <alpine.DEB.2.21.1905181712000.3019@nanos.tec.linutronix.de> <602b155f-4108-2865-3f1c-4e63d73405ed@yandex-team.ru>
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

On Sat, 18 May 2019, Konstantin Khlebnikov wrote:

> On 18.05.2019 18:17, Thomas Gleixner wrote:
> > On Wed, 15 May 2019, Konstantin Khlebnikov wrote:
> > 
> > > Timekeeping watchdog verifies doubtful clocksources using more reliable
> > > candidates. For x86 it likely verifies 'tsc' using 'hpet'. But 'hpet'
> > > is far from perfect too. It's better to have second opinion if possible.
> > > 
> > > We're seeing sudden jumps of hpet counter to 0xffffffff:
> > 
> > On which kind of hardware? A particular type of CPU or random ones?
> 
> In general this is very rare event.
> 
> This exact pattern have been seen ten times or so on several servers with
> Intel(R) Xeon(R) CPU E5-2660 v4 @ 2.00GHz
> (this custom built platform with chipset Intel C610)
> 
> and haven't seen for previous generation
> Intel(R) Xeon(R) CPU E5-2650 v2 @ 2.60GHz
> (this is another custom built platform)

Same chipset? Note the HPET is part of the chipset not of the CPU.

> Link was in patch: https://lore.kernel.org/patchwork/patch/667413/

Hmm. Not really helpful either.

> > > This patch uses second reliable clocksource as backup for validation.
> > > For x86 this is usually 'acpi_pm'. If watchdog and backup are not consent
> > > then other clocksources will not be marked as unstable at this iteration.
> > 
> > The mess you add to the watchdog code is unholy and that's broken as there
> > is no guarantee for acpi_pm (or any other secondary watchdog) being
> > available.
> 
> ACPI power management timer is a pretty standard x86 hardware.

Used to be.

> But my patch should work for any platform with any second reliable
> clocksource.

Which is close to zero if PM timer is not exposed.

> If there is no second clocksource my patch does noting:
> watchdog_backup stays NULL and backup_consent always true.

That still does not justify the extra complexity for a few custom built
systems.

Thanks,

	tglx
