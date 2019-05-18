Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA52C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 18:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3462620872
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 18:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729776AbfERSVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 14:21:31 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:54252 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbfERSVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 14:21:31 -0400
Received: from p5de0b374.dip0.t-ipconnect.de ([93.224.179.116] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hS3xV-0001gu-Nh; Sat, 18 May 2019 20:21:25 +0200
Date:   Sat, 18 May 2019 20:21:24 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Harry Pan <gs0622@gmail.com>
cc:     Harry Pan <harry.pan@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>, x86@kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2] clocksource: Untrust the clocksource watchdog when
 its interval is too small
In-Reply-To: <CAHECPZMhOmQnvH=usFJoJTmF=Tc74uD+JgE6euWzqwz46LfMMQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1905182015320.3019@nanos.tec.linutronix.de>
References: <20190516090651.1396-1-harry.pan@intel.com> <20190518141005.1132-1-harry.pan@intel.com> <alpine.DEB.2.21.1905181718310.3019@nanos.tec.linutronix.de> <CAHECPZMhOmQnvH=usFJoJTmF=Tc74uD+JgE6euWzqwz46LfMMQ@mail.gmail.com>
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

Harry,

On Sun, 19 May 2019, Harry Pan wrote:

A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

> I just want to point out: it is wrong if a problematic watchdog clocksource
> kicks off the main clocksource while this watchdog mechanism is unable to
> validate itself through a simple interval check;
> there is no any hardwired knowledge in this patch.

The point is, that any clocksource which is not reliable needs to be marked
as such and cannot be used as watchdog clocksource or as clocksource at all.

You're papering over the underlying problem. If HPET is not longer
reliable, then HPET needs to be blacklisted, not only as clocksource, also
as clockevent device and no exposure via the HPET device interface.

Everything else is just cosmetical surgery. And no, we are not going to
verify whether the watchdog clocksource might be wrong simply because you
create a circular dependency of what is watching what.

Please provide a list of SKUs which are affected and we disable HPET on
those.

Thanks,

	tglx
