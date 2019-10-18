Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E74BCA9EA3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAE4121D80
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="BH2SZAJI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505033AbfJRIJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 04:09:07 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42484 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505006AbfJRIJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 04:09:00 -0400
Received: by mail-io1-f65.google.com with SMTP id r15so2675588iod.9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 01:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BDNARAWoiAFizEyliYmITz0WDECsamFFfEfTjTwse14=;
        b=BH2SZAJI7pzAjQaIWJl0yJG8OFbAURLSsSN2T7bCaujThYLoFQwOn6z4+Yy2Nr2i+7
         VeOFWtmiAtkfd1NjwrjrebM0WUBRv8nJcBFQxeh82F+KKEUrePTE8zrGHu7G7QQ+nCiB
         Qcb/YSUdh+FN2Z/WjhYa/giocNRxKLilLM3aGMBc16ZftLviykl0epsG5X3Pai//FG4P
         68XGtwnDzgtJ1EdabbhJ81T05HwEeiiQJh33FBXeMxf6lj9j9sFxkz1t085zaU8WVa2n
         hvGfdEvhyCGvBxu4rYLb/g6wl5sOfaxorW7fhDuZPD19m3IimT3JiPejWTbVdryCqfiS
         bv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BDNARAWoiAFizEyliYmITz0WDECsamFFfEfTjTwse14=;
        b=lcVRY2idKQ5Was45Vb8QQYj9TraZVDplzhLMjIYFk/LYLfyszUxSi9GaBat3BgyVut
         chowy0xtB/MSoRIHfEpvdfXUi65LbKoq66noNj0+qx6yjLfpQ5sUYfWIfg9H3fOUXaxD
         BZs2D5+D790AB5JPeG7C1fOQzjenUoeZgBvAGLgSnKvaIB/O0zMCaCMq8RpeV1ORDdfx
         RNPUapj7JwET25NevUN0md+PCJmo0uJAH9THJh5rpOFIAW3jQLvUNPIKba5/Ezz+uFzp
         oobYskcBgFxq/y2n2JBrWCTeCO1FTpZJxKc/D7GvDsjqZp6w3I8GPR61pIeYDl67i7WI
         YWrg==
X-Gm-Message-State: APjAAAXcqjBdigklMOi6shE1W6y5hAdnAzSVHOl2qJOAw+gBGXOnjzH2
        aatMqsr8TEYVaigtP7+Egi8XojVM6u0=
X-Google-Smtp-Source: APXvYqy6AwVkDkkhxvbEhidluVWq8r5Xas/hfQEFm/idpPNWew4L2BI8RKV4B8QWgFUYKl9y9I+90Q==
X-Received: by 2002:a02:6508:: with SMTP id u8mr7939505jab.28.1571386139226;
        Fri, 18 Oct 2019 01:08:59 -0700 (PDT)
Received: from viisi.Home ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id z86sm2121026ilf.73.2019.10.18.01.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 01:08:58 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Alan Kao <alankao@andestech.com>
Subject: [PATCH v3 7/8] riscv: fp: add missing __user pointer annotations
Date:   Fri, 18 Oct 2019 01:08:40 -0700
Message-Id: <20191018080841.26712-8-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191018080841.26712-1-paul.walmsley@sifive.com>
References: <20191018080841.26712-1-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __user annotations were removed from the {save,restore}_fp_state()
function signatures by commit 007f5c358957 ("Refactor FPU code in
signal setup/return procedures"), but should be present, and sparse
warns when they are not applied.  Add them back in.

This change should have no functional impact.

Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Fixes: 007f5c358957 ("Refactor FPU code in signal setup/return procedures")
Cc: Alan Kao <alankao@andestech.com>
---
 arch/riscv/kernel/signal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
index 85c700ad47e9..9437167f463e 100644
--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@ -28,7 +28,7 @@ struct rt_sigframe {
 
 #ifdef CONFIG_FPU
 static long restore_fp_state(struct pt_regs *regs,
-			     union __riscv_fp_state *sc_fpregs)
+			     union __riscv_fp_state __user *sc_fpregs)
 {
 	long err;
 	struct __riscv_d_ext_state __user *state = &sc_fpregs->d;
@@ -55,7 +55,7 @@ static long restore_fp_state(struct pt_regs *regs,
 }
 
 static long save_fp_state(struct pt_regs *regs,
-			  union __riscv_fp_state *sc_fpregs)
+			  union __riscv_fp_state __user *sc_fpregs)
 {
 	long err;
 	struct __riscv_d_ext_state __user *state = &sc_fpregs->d;
-- 
2.23.0

