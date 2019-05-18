Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD41C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 15:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F63720882
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 15:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbfERP0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 11:26:07 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53960 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727367AbfERP0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 11:26:06 -0400
Received: from p5de0b374.dip0.t-ipconnect.de ([93.224.179.116] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hS1Dm-0008Bp-Kw; Sat, 18 May 2019 17:26:02 +0200
Date:   Sat, 18 May 2019 17:26:01 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Harry Pan <harry.pan@intel.com>
cc:     LKML <linux-kernel@vger.kernel.org>, gs0622@gmail.com,
        Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>, x86@kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2] clocksource: Untrust the clocksource watchdog when
 its interval is too small
In-Reply-To: <20190518141005.1132-1-harry.pan@intel.com>
Message-ID: <alpine.DEB.2.21.1905181718310.3019@nanos.tec.linutronix.de>
References: <20190516090651.1396-1-harry.pan@intel.com> <20190518141005.1132-1-harry.pan@intel.com>
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

On Sat, 18 May 2019, Harry Pan wrote:

> This patch performs a sanity check on the deviation of the clocksource watchdog,

Please read Documentation/process/submitting-patches.rst and search for
'This patch'.

> target to reduce false alarm that incorrectly marks current clocksource unstable
> when there comes discrepancy.
> 
> Say if there is a discrepancy between the current clocksource and watchdog,
> validate the watchdog deviation first, if its interval is too small against
> the expected timer interval, we shall trust the current clocksource.
> 
> It is identified on some Coffee Lake platform w/ PC10 allowed, when the CPU
> entered and exited from PC10 (the residency counter is increased), the HPET
> generates timestamp delay, this causes discrepancy making kernel incorrectly
> untrust the current clocksource (TSC in this case) and re-select the next
> clocksource which is the problematic HPET, this eventually causes a user
> sensible wall clock delay.
> 
> The HPET timestamp delay shall be tackled in firmware domain in order to
> properly handle the timer offload between XTAL and RTC when it enters PC10,
> while this patch is a mitigation to reduce the false alarm of clocksource
> unstable regardless what clocksources are paired.

That's completely wrong. If Intel managed to wreckage the HPET then the
HPET needs to be blacklisted on those platforms and not worked around in
the watchdog code. HPET is exposed by other means as well which means these
interfaces are broken.

If we finally could trust the TSC then we could avoid the watchdog mess
completely, but it's still exposed to possible SMM/BIOS wreckage and the
multi-socket unreliability. Sigh, I'm explaining this for almost two
decades to Intel that the kernel needs a trustable, reliable clocksource,
but all we get are more "features" which make timekeeping a trainwreck.

Thanks,

	tglx
