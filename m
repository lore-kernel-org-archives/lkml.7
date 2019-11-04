Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78199CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52DAE20659
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbfKDVOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 16:14:35 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38914 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728634AbfKDVOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 16:14:34 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iRjgG-0005ZP-70; Mon, 04 Nov 2019 22:14:32 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C76F11C0426;
        Mon,  4 Nov 2019 22:14:31 +0100 (CET)
Date:   Mon, 04 Nov 2019 21:14:31 -0000
From:   "tip-bot2 for Cyrill Gorcunov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Shrink space allocated for xstate_comp_offsets
Cc:     Cyrill Gorcunov <gorcunov@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191101124228.GF1615@uranus.lan>
References: <20191101124228.GF1615@uranus.lan>
MIME-Version: 1.0
Message-ID: <157290207153.29376.7801513970239330301.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     c08550510ca26bd57eabfe912281635e382193e5
Gitweb:        https://git.kernel.org/tip/c08550510ca26bd57eabfe912281635e382193e5
Author:        Cyrill Gorcunov <gorcunov@gmail.com>
AuthorDate:    Fri, 01 Nov 2019 15:42:28 +03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 04 Nov 2019 22:04:19 +01:00

x86/fpu: Shrink space allocated for xstate_comp_offsets

commit 8ff925e10f2c ("x86/xsaves: Clean up code in xstate offsets
computation in xsave area") introduced an allocation of 64 entries for
xstate_comp_offsets while the code only handles up to XFEATURE_MAX entries.

For this reason xstate_offsets and xstate_sizes are already defined with
the explicit XFEATURE_MAX limit.

Do the same for compressed format for consistency sake.

As the changelog of that commit is not giving any information it's assumed
that the main idea was to cover all possible bits in xfeatures_mask, but
this doesn't explain why other variables such as the non-compacted offsets
and sizes are explicitely limited to XFEATURE_MAX.

For consistency it's better to use the XFEATURE_MAX limit everywhere and
extend it on demand when new features get implemented at the hardware
level and subsequently supported by the kernel.

Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20191101124228.GF1615@uranus.lan

---
 arch/x86/kernel/fpu/xstate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 18ffc6f..a8bd5c0 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -60,7 +60,7 @@ u64 xfeatures_mask __read_mostly;
 
 static unsigned int xstate_offsets[XFEATURE_MAX] = { [ 0 ... XFEATURE_MAX - 1] = -1};
 static unsigned int xstate_sizes[XFEATURE_MAX]   = { [ 0 ... XFEATURE_MAX - 1] = -1};
-static unsigned int xstate_comp_offsets[sizeof(xfeatures_mask)*8];
+static unsigned int xstate_comp_offsets[XFEATURE_MAX] = { [ 0 ... XFEATURE_MAX - 1] = -1};
 
 /*
  * The XSAVE area of kernel can be in standard or compacted format;
@@ -342,7 +342,7 @@ static int xfeature_is_aligned(int xfeature_nr)
  */
 static void __init setup_xstate_comp(void)
 {
-	unsigned int xstate_comp_sizes[sizeof(xfeatures_mask)*8];
+	unsigned int xstate_comp_sizes[XFEATURE_MAX];
 	int i;
 
 	/*
