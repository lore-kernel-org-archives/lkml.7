Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AAE2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D4732075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbfCKOW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 10:22:29 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:38717 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbfCKOW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 10:22:28 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h3Lov-0006ZV-W0; Mon, 11 Mar 2019 15:22:26 +0100
Date:   Mon, 11 Mar 2019 15:22:25 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Kees Cook <keescook@chromium.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] x86/asm for 5.1
In-Reply-To: <CAHk-=wjNes0wn0KUMMY6dOK_sN69z2TiGpDZ2cyzYF07s64bXQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1903111516190.1691@nanos.tec.linutronix.de>
References: <155221755096.13878.3370977359110476046.tglx@nanos.tec.linutronix.de> <155221755097.13878.5173016541431155948.tglx@nanos.tec.linutronix.de> <CAHk-=wjNes0wn0KUMMY6dOK_sN69z2TiGpDZ2cyzYF07s64bXQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Mar 2019, Linus Torvalds wrote:
> On Sun, Mar 10, 2019 at 4:33 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> Finally, I suspect this is all subtly buggy anyway, because your
> 'cr4_pin' thing is a global variable, but the cr4 bits are per-cpu,
> and I don't see how this works with the different CPU's setting things
> up one after each other, but the first one sets the pinned bits.
> 
> So it basically "pins" the bits on CPU's before they are ready, so the
> secondary CPU's maghically get the bits set _independently_ of running
> the actual setup code to set them. That may *work*, but it sure looks
> iffy.

Which I looked at and it's a non issue. The SMAP/SMEP settings are globally
the same and the non-boot CPUs set the bits very early in the boot process.

Thanks,

	tglx
