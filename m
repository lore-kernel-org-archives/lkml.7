Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27AF1C072A4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 04:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 044B321019
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 04:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfEVEmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 00:42:44 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:49220 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbfEVEmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 00:42:43 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 278EBA0142;
        Wed, 22 May 2019 06:42:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id E0yK-RppxpLv; Wed, 22 May 2019 06:42:24 +0200 (CEST)
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Nicolai Stange <nstange@suse.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        zfs-devel@list.zfsonlinux.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/fpu: allow kernel_fpu_{begin,end} to be used by non-GPL modules
Date:   Wed, 22 May 2019 14:42:04 +1000
Message-Id: <20190522044204.24207-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prior to [1], all non-GPL modules were able to make use of SIMD on x86
by making use of the __kernel_fpu_* API. Given that __kernel_fpu_* were
both EXPORT_SYMBOL'd and kernel_fpu_* are such trivial wrappers around
the now-static __kernel_fpu_*, it seems to me that there is no reason to
have different licensing rules for them.

In the case of OpenZFS, the lack of SIMD on newer Linux kernels has
caused significant performance problems (since ZFS uses SIMD for
calculation of blkptr checksums as well as raidz calculations).

[1]: commit 12209993e98c ("x86/fpu: Don't export __kernel_fpu_{begin,end}()")

Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 arch/x86/kernel/fpu/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 2e5003fef51a..8de5687a470d 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -127,14 +127,14 @@ void kernel_fpu_begin(void)
 	preempt_disable();
 	__kernel_fpu_begin();
 }
-EXPORT_SYMBOL_GPL(kernel_fpu_begin);
+EXPORT_SYMBOL(kernel_fpu_begin);
 
 void kernel_fpu_end(void)
 {
 	__kernel_fpu_end();
 	preempt_enable();
 }
-EXPORT_SYMBOL_GPL(kernel_fpu_end);
+EXPORT_SYMBOL(kernel_fpu_end);
 
 /*
  * Save the FPU state (mark it for reload if necessary):
-- 
2.21.0

