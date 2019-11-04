Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BDCCA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FB7020659
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729608AbfKDVOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 16:14:41 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38912 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728377AbfKDVOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 16:14:35 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iRjgF-0005ZM-Tw; Mon, 04 Nov 2019 22:14:32 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 692A21C0017;
        Mon,  4 Nov 2019 22:14:31 +0100 (CET)
Date:   Mon, 04 Nov 2019 21:14:31 -0000
From:   "tip-bot2 for Cyrill Gorcunov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Use XFEATURE_FP/SSE enum values instead of
 hardcoded numbers
Cc:     Cyrill Gorcunov <gorcunov@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191101130153.GG1615@uranus.lan>
References: <20191101130153.GG1615@uranus.lan>
MIME-Version: 1.0
Message-ID: <157290207104.29376.2447130677768331870.tip-bot2@tip-bot2>
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

Commit-ID:     446e693ca30b7c7c2aaeaf09e90ec224c7538fec
Gitweb:        https://git.kernel.org/tip/446e693ca30b7c7c2aaeaf09e90ec224c7538fec
Author:        Cyrill Gorcunov <gorcunov@gmail.com>
AuthorDate:    Fri, 01 Nov 2019 16:01:53 +03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 04 Nov 2019 22:10:07 +01:00

x86/fpu: Use XFEATURE_FP/SSE enum values instead of hardcoded numbers

When setting up sizes and offsets for legacy header entries the code uses
hardcoded 0/1 instead of the corresponding enum values XFEATURE_FP and
XFEATURE_SSE.

Replace the hardcoded numbers which enhances readability of the code and
also makes this code the first user of those enum values..

Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20191101130153.GG1615@uranus.lan
---
 arch/x86/kernel/fpu/xstate.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index a8bd5c0..319be93 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -254,10 +254,13 @@ static void __init setup_xstate_features(void)
 	 * in the fixed offsets in the xsave area in either compacted form
 	 * or standard form.
 	 */
-	xstate_offsets[0] = 0;
-	xstate_sizes[0] = offsetof(struct fxregs_state, xmm_space);
-	xstate_offsets[1] = xstate_sizes[0];
-	xstate_sizes[1] = FIELD_SIZEOF(struct fxregs_state, xmm_space);
+	xstate_offsets[XFEATURE_FP]	= 0;
+	xstate_sizes[XFEATURE_FP]	= offsetof(struct fxregs_state,
+						   xmm_space);
+
+	xstate_offsets[XFEATURE_SSE]	= xstate_sizes[XFEATURE_FP];
+	xstate_sizes[XFEATURE_SSE]	= FIELD_SIZEOF(struct fxregs_state,
+						       xmm_space);
 
 	for (i = FIRST_EXTENDED_XFEATURE; i < XFEATURE_MAX; i++) {
 		if (!xfeature_enabled(i))
@@ -350,8 +353,9 @@ static void __init setup_xstate_comp(void)
 	 * in the fixed offsets in the xsave area in either compacted form
 	 * or standard form.
 	 */
-	xstate_comp_offsets[0] = 0;
-	xstate_comp_offsets[1] = offsetof(struct fxregs_state, xmm_space);
+	xstate_comp_offsets[XFEATURE_FP] = 0;
+	xstate_comp_offsets[XFEATURE_SSE] = offsetof(struct fxregs_state,
+						     xmm_space);
 
 	if (!boot_cpu_has(X86_FEATURE_XSAVES)) {
 		for (i = FIRST_EXTENDED_XFEATURE; i < XFEATURE_MAX; i++) {
