Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DFDFC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 10:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D36920854
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 10:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="jlNUbOfO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfCHK5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 05:57:14 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:34298 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfCHK5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 05:57:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hrliJgZSHEqg0C+vJCT2WhttKwSy9xwOOLnILNV2vOQ=; b=jlNUbOfOmJqVZynxd0YWPJdNk
        nhZIPGREt0fQLiNqqKyajpEFZNm81ffanEaLnb2mOXdrM610XEi1XdIR2tCA/N2KJy/paXV8N0o08
        mmYx6OANvjnIoQme9C0UQW5+/AqDrqD40kryyCe4N+hZasqC9Jg7/WLp17G4Oo4oWGdcFgOPGMj0L
        P5iY1vEvzlK9QlCHg36kBFayMbxCMxR+aLcDbumBAdQlYvhW3YigMUDWb95EUtiOEXI5AYjMMpX4E
        N68edhxxa8/95Iq6ihyKbyXY4NfmshxOMEXYNewFS3jK6rHiZb1cAVTALlwB/FYrFZVwqUE+Ny/4X
        IjHOdGciA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51664)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1h2DBY-0003Np-4s; Fri, 08 Mar 2019 10:57:04 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1h2DBS-0005ht-N7; Fri, 08 Mar 2019 10:56:58 +0000
Date:   Fri, 8 Mar 2019 10:56:58 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Mikael Pettersson <mikpelinux@gmail.com>,
        Mikael Pettersson <mikpe@it.uu.se>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Martin <Dave.Martin@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/2] ARM: futex: make futex_detect_cmpxchg more reliable
Message-ID: <20190308105658.y6ctbfggheavwxs4@shell.armlinux.org.uk>
References: <20190307091514.2489338-1-arnd@arndb.de>
 <20190307091514.2489338-2-arnd@arndb.de>
 <CAKwvOdk=9j2HvtWOpdOEw9sm0Nh2oU3c1c6+hJJ5WMweAM=4EQ@mail.gmail.com>
 <20190307234850.nsbpkfcit3lnmytu@shell.armlinux.org.uk>
 <CAKv+Gu9VM2Vs3Q8+bPLsnt08dOmba6j54gnhiHkk=AHRzG8tVA@mail.gmail.com>
 <20190308095308.hjjrzdp4fzbbtnnv@shell.armlinux.org.uk>
 <CAKv+Gu_szWgw-KJASLYGJ6hJXh5K8WxnUn+UQkm7jUup=rqG6w@mail.gmail.com>
 <CAKv+Gu-4bcnVc_v_syaUFXfbyPeo_LGuh7waWQojdGTSS6TeEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-4bcnVc_v_syaUFXfbyPeo_LGuh7waWQojdGTSS6TeEw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 11:16:47AM +0100, Ard Biesheuvel wrote:
> Compiling the following code
> 
> """
> #include <stdio.h>
> 
> static void foo(void *a, int b)
> {
>     asm("str %0, [%1]" :: "r"(a), "r"(b));
> }
> 
> int main(void)
> {
>     foo(NULL, 0);
> }
> """
> 
> with GCC 6.3 (at -O2) gives me
> 
> .arch armv7-a
> .eabi_attribute 28, 1
> .eabi_attribute 20, 1
> .eabi_attribute 21, 1
> .eabi_attribute 23, 3
> .eabi_attribute 24, 1
> .eabi_attribute 25, 1
> .eabi_attribute 26, 2
> .eabi_attribute 30, 2
> .eabi_attribute 34, 1
> .eabi_attribute 18, 4
> .file "futex.c"
> .section .text.startup,"ax",%progbits
> .align 1
> .p2align 2,,3
> .global main
> .syntax unified
> .thumb
> .thumb_func
> .fpu vfpv3-d16
> .type main, %function
> main:
> @ args = 0, pretend = 0, frame = 0
> @ frame_needed = 0, uses_anonymous_args = 0
> @ link register save eliminated.
> movs r0, #0
> .syntax unified
> @ 6 "/tmp/futex.c" 1
> str r0, [r0]
> @ 0 "" 2
> .thumb
> .syntax unified
> bx lr
> .size main, .-main
> .ident "GCC: (Debian 6.3.0-18) 6.3.0 20170516"
> .section .note.GNU-stack,"",%progbits
> 
> and so GCC definitely behaves similar in this regard.

Let's take this further - a volatile is required for these cases to
avoid gcc eliminating the asm() due to the output not being used:

#define NULL ((void *)0)
static void foo(void *a, int b)
{
    asm volatile("str %1, [%0]" : "=&r" (a) : "0" (a), "r" (b));
}
int main(void)
{
    foo(NULL, 0);
}

produces:

        mov     r3, #0
        mov     r2, r3
        str r2, [r2]

which looks to me to be incorrect to the GCC manual - the '&' on the
output operand should mean that it does not conflict with other input
operands, but clearly 'r2' has ended up being 'b' as well.  I suspect
this is a bug, or if not, is completely counter-intuitive from the
description in the GCC manual.

Using "+r" (a) : "r" (b) also results in:

        mov     r3, #0
        str r3, [r3]

It seems that only using "+&r" (a) : "r" (b) avoids a and b being in
the same register, but I question whether we are stepping into
undefined compiler behaviour with that.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
