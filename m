Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE7BCA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 13:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32F02217F9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 13:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZALH4Yfl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfKANB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 09:01:59 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33981 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbfKANB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 09:01:58 -0400
Received: by mail-lf1-f68.google.com with SMTP id f5so7188825lfp.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 06:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=fphXyhWaK8q12drDLe3urhMTSDXA/CeIZ2MBw+pCQgQ=;
        b=ZALH4YflQW6NRCFPOGAxRtjJdDYA3neJtrF+P3iORu7ocUUHKsG1yeXmxEp27f8X6M
         jtu0ExXuqXNam4VcxDmBXvs6tE3hxgn4fO7vpACGw60s8ay5ZW2Uv+O++SuQUq8+P/W+
         /qLyIZGsPIUK1rQ6PZosKR/RTuYYvny923I00YgCCMAdwjnlMCGssOoDQbepPmro1PXi
         BGRS2y8eH5zFXNL6K4aJQ3K/D9vrdu5yZ0xp+4ZUPSGxT9ffAK3WZo9SOzQqO9OekW+I
         Rd+1kaQQSweTORTwGkTysCf60SNqFahZIMogxIdR+sNW5wVPxiDXbKZ4ELj7nHUV7r/H
         46Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=fphXyhWaK8q12drDLe3urhMTSDXA/CeIZ2MBw+pCQgQ=;
        b=HwqxxnqEubzfAxYlPak+jvwNtxVtD2R716SzHlEtiKERbanNNv16jO+FxNQ5RaMR/E
         oUmRHvpg9JJS99kPKJMou0idbXOJ0tkSozuIqS/2vxyLxkK9GMBcvosFDmXW/qEslFkz
         tYoQ/ZK+KMRvg+z98qgyu4vGoemVDJsAdDTO5QWM7G0inL6h7lHQQKSKiXAnIVeZMOfz
         0UtDsmt/GLzgz34JXm2C/ZEINT+4A/v6u8hCevJ7SvbljihPHgfGk7dQp+aeHx18TaQ3
         lb2vzZZy4Qpjq2dVb/kkZnf9CPWU1aG80IxixDIXgOjpncLKLRWFlMQmW6z5D33udhfD
         Dcfw==
X-Gm-Message-State: APjAAAVR5vFOIwdMplAjgeFxqo6a214AutVZm9Ghy5D4fVqpFsyMe1kH
        m1o87+B/Qjk3CK1osvVrc/g=
X-Google-Smtp-Source: APXvYqy401o/VOXjGcPBFVX8rQflVU/g8egFZKHJb7re7KdgLfcxSGtdakMH0LiYf/V46O70zGPsgw==
X-Received: by 2002:a19:6f0e:: with SMTP id k14mr7333425lfc.34.1572613315214;
        Fri, 01 Nov 2019 06:01:55 -0700 (PDT)
Received: from uranus.localdomain ([5.18.199.94])
        by smtp.gmail.com with ESMTPSA id 9sm2473347ljq.104.2019.11.01.06.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 06:01:54 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 6C09446123B; Fri,  1 Nov 2019 16:01:53 +0300 (MSK)
Date:   Fri, 1 Nov 2019 16:01:53 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, X86-ML <x86@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH -tip] x86/fpu: Use XFEATURE_ enum for legacy entries
Message-ID: <20191101130153.GG1615@uranus.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When setting up sizes and offsets for legacy header entries
we can use XFEATURE_FP and XFEATURE_SSE names for better
readability (and finally we have a reference for these
XFEATURE_ in a real code).

Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
CC: Ingo Molnar <mingo@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: H. Peter Anvin <hpa@zytor.com>
---
 arch/x86/kernel/fpu/xstate.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

Index: linux-tip.git/arch/x86/kernel/fpu/xstate.c
===================================================================
--- linux-tip.git.orig/arch/x86/kernel/fpu/xstate.c
+++ linux-tip.git/arch/x86/kernel/fpu/xstate.c
@@ -254,10 +254,13 @@ static void __init setup_xstate_features
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
@@ -350,8 +353,9 @@ static void __init setup_xstate_comp(voi
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
