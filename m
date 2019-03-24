Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD25C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 21:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 432B820880
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 21:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="c3m8JyD5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbfCXVuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 17:50:37 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:36658 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728645AbfCXVuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 17:50:37 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 8A84E5C0C14;
        Sun, 24 Mar 2019 22:50:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1553464233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sKSCVhfhuLUr46OoZDx9fJk3XqBqAdb+WaN79PEAo50=;
        b=c3m8JyD5b3T/FtcqYnIMBfYaIoVDbPm0Du5K0moO/OGtDBTTEpQqnthSmp1MsAxcddVkZV
        2ylh00iaX7zsXaGYTMxsDIyK/8LldrzKyutd2Ooj2n8ilkj6icW5QxPus7L9mGh8OyLwkT
        5gCkgylD06F1qVhZJXiMcVDFJUQOgj8=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Sun, 24 Mar 2019 22:50:33 +0100
From:   Stefan Agner <stefan@agner.ch>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] ARM: use arch_extension directive instead of arch
 argument
In-Reply-To: <CAK8P3a0XBN+noCkdGT_TYfPNY1j9CcVH8mTjh_mQL3w+Z6jfaw@mail.gmail.com>
References: <9641c58c03720104186a797a96e30a52ae9805e4.1553356359.git.stefan@agner.ch>
 <CAK8P3a0XBN+noCkdGT_TYfPNY1j9CcVH8mTjh_mQL3w+Z6jfaw@mail.gmail.com>
Message-ID: <b5f1ea23f1e436f2603e0d5993389e8e@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.03.2019 21:06, Arnd Bergmann wrote:
> On Sat, Mar 23, 2019 at 4:52 PM Stefan Agner <stefan@agner.ch> wrote:
>>
>> The LLVM Target parser currently does not allow to specify the security
>> extension as part of -march (see also LLVM Bug 40186 [0]). When trying
>> to use Clang with LLVM's integrated assembler, this leads to a build
>> errors such as this:
>>   clang-8: error: the clang compiler does not support '-Wa,-march=armv7-a+sec'
>>
>> Use ".arch_extension sec" to enable the security extension in a more
>> portable fasion.
>>
>> Note that this is technically not exactly the same as the old code
>> checked for availabilty of the security extension by calling as-instr.
>> However, there are already other sites which use ".arch_extension sec"
>> unconditionally, hence de-facto we need an assembler capable of
>> ".arch_extension sec" already today (arch/arm/mm/proc-v7.S). The
>> arch extension "sec" is available since binutils 2.21 according to
>> its documentation [1].
>>
>> [0] https://bugs.llvm.org/show_bug.cgi?id=40186
>> [1] https://sourceware.org/binutils/docs-2.21/as/ARM-Options.html
>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
> 
> This sounds like a good idea. I think we have platform specific
> minimum toolchain versions elsewhere, but I don't see a problem
> with raising the minimum version for all the armv7ve platforms.
> 
> I've added this patch to my randconfig test queue, but please
> send it to arm@kernel.org for inclusion when you have
> collected more Acks.

Cool, will do!

> 
> Do you have a git tree with other patches required for the
> integrated assembler? I might try that out as well with
> my randconfig tree. At the moment I'm building with
> clang-8 and a small number of patches on top.

I do have some more work in progress patches. I made some rough commits
and pushed the tree here:
https://github.com/ClangBuiltLinux/linux/commits/arm-fixes-hacks-to-make-llvm-integrated-as-work

This tree compiles for me and a test boot with qemu seems to work.

It seems that LLVM's integrated assembler is capable of assembling
almost the whole kernel a lot can be worked around/fixed on kernel side.
There are only about a handful of files where I still use the GNU
assembler. Haven't looked closely at these cases yet.

There is one issue which probably need a change in LLVM:
https://github.com/ClangBuiltLinux/linux/issues/306

I proposed this fix:
https://reviews.llvm.org/D59733


> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thx.

--
Stefan
