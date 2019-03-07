Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4F5C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 06:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5395320835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 06:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfCGGl5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 01:41:57 -0500
Received: from linux-libre.fsfla.org ([209.51.188.54]:37030 "EHLO
        linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfCGGl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 01:41:56 -0500
Received: from free.home (home.lxoliva.fsfla.org [172.31.160.164])
        by linux-libre.fsfla.org (8.15.2/8.15.2/Debian-3) with ESMTP id x276fNH6015146;
        Thu, 7 Mar 2019 06:41:26 GMT
Received: from livre (livre.home [172.31.160.2])
        by free.home (8.15.2/8.15.2) with ESMTP id x276f1IA321398;
        Thu, 7 Mar 2019 03:41:04 -0300
From:   Alexandre Oliva <lxoliva@fsfla.org>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>, Tom Li <tomli@tomli.me>,
        James Hogan <jhogan@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] On the Current Troubles of Mainlining Loongson Platform Drivers
Organization: Free thinker, not speaking for FSF Latin America
References: <20190208083038.GA1433@localhost.localdomain>
        <orbm3i5xrn.fsf@lxoliva.fsfla.org>
        <20190211125506.GA21280@localhost.localdomain>
        <orimxq3q9j.fsf@lxoliva.fsfla.org>
        <20190211230614.GB22242@darkstar.musicnaut.iki.fi>
        <orva1jj9ht.fsf@lxoliva.fsfla.org>
        <20190217235951.GA20700@darkstar.musicnaut.iki.fi>
        <orpnrpj2rk.fsf@lxoliva.fsfla.org>
        <alpine.LFD.2.21.1902180227090.15915@eddie.linux-mips.org>
Date:   Thu, 07 Mar 2019 03:41:01 -0300
In-Reply-To: <alpine.LFD.2.21.1902180227090.15915@eddie.linux-mips.org>
        (Maciej W. Rozycki's message of "Mon, 18 Feb 2019 02:41:11 +0000
        (GMT)")
Message-ID: <orlg1ryyo2.fsf@lxoliva.fsfla.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.84
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 17, 2019, "Maciej W. Rozycki" <macro@linux-mips.org> wrote:

>  Is there an MMIO completion barrier missing there somewhere by any chance 
> causing an IRQ that has been handled already to be redelivered because an 
> MMIO write meant to clear the IRQ at its origin at handler's completion 
> has not reached its destination before interrupts have been reenabled in 
> the issuing CPU?  Just a thought.

I've finally got a chance to bisect the IRQ14 (nobody cared) regression
on my yeeloong.  It took me to MIPS: Enforce strong ordering for MMIO
accessors (commit 3d474dacae72ac0f28228b328cfa953b05484b7f).

I've only just started trying to figure out what exactly in the change
leads to problems.  So far, I've determined that changing both uses of
__BUILD_IOPORT_SINGLE so that barrier is passed as 0 rather than 1
removes the undesirable effects, both on top of that patch, and on top
of v5.0:

 #define __BUILD_IOPORT_PFX(bus, bwlq, type)				\
- 	__BUILD_IOPORT_SINGLE(bus, bwlq, type, 1, 0,)			\
- 	__BUILD_IOPORT_SINGLE(bus, bwlq, type, 1, 0, _p)
+	__BUILD_IOPORT_SINGLE(bus, bwlq, type, 0, 0,)			\
+	__BUILD_IOPORT_SINGLE(bus, bwlq, type, 0, 0, _p)
 

Since the barriers didn't seem to be a problem for __BUILD_MEMORY_PFX, I
figured I'd try to enable barriers in the __mem_ variants, but leave
them alone for io, and that worked (without hitting the IRQ14 issue) at
least on the yeeloong:

diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index 845fbbc7a2e34..0a3a327d4e764 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -467,13 +467,13 @@ BUILDIO_MEM(w, u16)
 BUILDIO_MEM(l, u32)
 BUILDIO_MEM(q, u64)
 
-#define __BUILD_IOPORT_PFX(bus, bwlq, type)				\
-	__BUILD_IOPORT_SINGLE(bus, bwlq, type, 1, 0,)			\
-	__BUILD_IOPORT_SINGLE(bus, bwlq, type, 1, 0, _p)
+#define __BUILD_IOPORT_PFX(bus, bwlq, type, barrier)			\
+	__BUILD_IOPORT_SINGLE(bus, bwlq, type, barrier, 0,)		\
+	__BUILD_IOPORT_SINGLE(bus, bwlq, type, barrier, 0, _p)
 
 #define BUILDIO_IOPORT(bwlq, type)					\
-	__BUILD_IOPORT_PFX(, bwlq, type)				\
-	__BUILD_IOPORT_PFX(__mem_, bwlq, type)
+	__BUILD_IOPORT_PFX(, bwlq, type, 0)				\
+	__BUILD_IOPORT_PFX(__mem_, bwlq, type, 1)
 
 BUILDIO_IOPORT(b, u8)
 BUILDIO_IOPORT(w, u16)

-- 
Alexandre Oliva, freedom fighter   https://FSFLA.org/blogs/lxo
Be the change, be Free!         FSF Latin America board member
GNU Toolchain Engineer                Free Software Evangelist
Hay que enGNUrecerse, pero sin perder la terGNUra jamás-GNUChe
