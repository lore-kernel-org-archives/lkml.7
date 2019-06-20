Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37045C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 07:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 172B32085A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 07:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730797AbfFTHrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 03:47:09 -0400
Received: from foss.arm.com ([217.140.110.172]:51788 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbfFTHrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 03:47:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F1BF344;
        Thu, 20 Jun 2019 00:47:08 -0700 (PDT)
Received: from brain-police (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 191683F246;
        Thu, 20 Jun 2019 00:47:04 -0700 (PDT)
Date:   Thu, 20 Jun 2019 08:46:58 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     catalin.marinas@arm.com, ard.biesheuvel@linaro.org,
        broonie@kernel.org, mark.rutland@arm.com,
        Olof Johansson <olof@lixom.net>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: defconfig: update and enable CONFIG_RANDOMIZE_BASE
Message-ID: <20190620074640.GA27228@brain-police>
References: <20190620003244.261595-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620003244.261595-1-ndesaulniers@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On Wed, Jun 19, 2019 at 05:32:42PM -0700, Nick Desaulniers wrote:
> Generated via:
> $ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make defconfig
> $ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make menuconfig
> <enable CONFIG_RANDOMIZE_BASE aka KASLR>
> $ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make savedefconfig
> $ mv defconfig arch/arm64/configs/defconfig

Hmm, I'm in two minds about whether we want this on by default. On the plus
side, it gets us extra testing coverage, although the /vast/ majority of
firmware implementations I run into either don't pass a seed or don't
provide a working EFI_RNG. Perhaps that's just a chicken-and-egg problem
which can be solved if we shout loud enough when we fail to randomize; we'll
also eventually be in a better position when CPUs start implementing the
v8.5 RNG instructions (but don't hold your breath unless you have an
unusually high lung capacity).

On the flip side, I worry that it could make debugging more difficult, but I
don't know whether that's a genuine concern or not. I'm assuming you've
debugged your fair share of crashes from KASLR-enabled kernels; how bad is
it? (I'm thinking of the case where somebody mails you part of a panic log
and a .config).

Irrespective of the above, I know Catalin was running into issues with his
automated tests where the kernel would die silently during early boot with
some seeds.  That's a bit rubbish if it's still the case -- Catalin?

Finally, I know that (K)ASLR can be a bit controversial amongst security
folks, with some seeing it as purely a smoke-and-mirrors game with no
tangible benefits other than making us feel better about ourselves. Is it
still the case that it can be trivially bypassed, or do you see it actually
preventing some attacks in production?

Sorry for the barrage of questions, but I think enabling this one by default
is quite a significant thing to do and probably deserves a bit of scrutiny
beforehand.

Cheers,

Will
