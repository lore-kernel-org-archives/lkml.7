Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F089FC433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 13:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF76021655
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 13:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbfG1NUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 09:20:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51648 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfG1NUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 09:20:47 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hrj6R-0003pr-Ib; Sun, 28 Jul 2019 15:20:43 +0200
Message-Id: <20190728131251.622415456@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 28 Jul 2019 15:12:51 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Bolle <pebolle@tiscali.nl>, Will Deacon <will@kernel.org>
Subject: [patch 0/5] lib/vdso,
 x86/vdso: Fix fallout from generic VDSO conversion
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several reporters noticed a regression with the new VDSO. 32bit user space
applications are tripping over seccomp filters with 5.3-rc. The reason is
that the 32bit VDSO syscall fallback uses clock_gettime64()/getres64() for
simplicity reasons. Existing seccomp filters do not enable the new 64bit
syscalls and prevent the applications from working correctly.

The following series addresses this by using the legacy 32bit syscall as
fallback in 32bit VDSOs.

Note, using the legacy syscall fallback is opt-in for now because otherwise
architectures which have their conversion queued in -next would break.

Once all are converted over, the conditional and the 64bit fallback
implementation can be removed.

Thanks,

	tglx

8<--------------
 arch/arm64/include/asm/vdso/compat_gettimeofday.h |   40 +++++++
 arch/x86/include/asm/vdso/gettimeofday.h          |   36 +++++++
 lib/vdso/gettimeofday.c                           |  111 +++++++++++++++-------
 3 files changed, 156 insertions(+), 31 deletions(-)




