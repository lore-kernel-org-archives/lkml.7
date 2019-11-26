Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9A6C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 00:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F33220748
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 00:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gT+B4sAI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfKZA1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 19:27:50 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52656 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfKZA1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 19:27:49 -0500
Received: by mail-wm1-f68.google.com with SMTP id l1so1269585wme.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 16:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w2HvsKeCFD6HBoaPqbJtXn7CjyM0CECRFwdo9YUNj3Y=;
        b=gT+B4sAIjJBuOvri7wAXxEcmxlsqytZopHWqjIFbjl2U1L9L03M8pZhKCdG6hAGCwC
         Say+cw/de38Wfxvcjx9mZ/k62+Od80SQHFocB7igvTrxf/tCmLl7kfXcy93zm6tuO7Ag
         uZe4UuAqbmSGg26T1PO6usDHopXNgcFQ8xJnZjDVM/H2abnZt4WBm29wL68j7L3s1kK+
         Z4a+4/LyvRnlQtPHRRVeUU77LlG1Ude100IdxyvBnIp2LpFP9PVTF38jq+buU0pIVE0c
         MvvQGSNMLaUR4oPcNGH76IwdLiCcf3eokAf5c4pOkjFCfvycjxmgtKOqYjJ9kSbVFLhz
         k1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w2HvsKeCFD6HBoaPqbJtXn7CjyM0CECRFwdo9YUNj3Y=;
        b=U9DNEN+4hwnAcapDLJzJZVnrhfweap3Zk9ad7xxrUo+8Af8lyuaJkyMwsUI3Je3jKc
         4VruBW+RY5GH7gSkkvXDkI5Lpveqp9dV5nyudYKKlsM4NNbOQx84Y1hqdcHuDx5DaO+s
         C99+pLitI/EMcGaGdPtAjKcEnlla8H+l08jaDRSa4ndbrzXr4g6biUhm3q/CXrC3w4IW
         Ker5xWKhNhF+F4cmXUODQwfK8fxsdwgxUkoydDKDCuzC5pO6BHFlmw2jVeDW0kjlKcmR
         fbxWKAHkpccImn+uKzORSlruGa8/xfZ9YjJcxtkWnZ4Gkw2RRv7Pzf47JjAc5ZGmuLPT
         vd4A==
X-Gm-Message-State: APjAAAVVRItAmLLx3xW37Pu06h90YsgK4oT49rv9JcnR1OOmOXUPVkFt
        VoSRElC67QrN88Er+Ps2wMmDSXABYWFCMgs=
X-Google-Smtp-Source: APXvYqwq0dJgFHnwkgcbS+bfm6vl2hVD/tM6rcaZk+7ugp8blaXXn5wKcRoWOAAwGiATuXiJ6BnaxQ==
X-Received: by 2002:a1c:6146:: with SMTP id v67mr1313643wmb.102.1574728067477;
        Mon, 25 Nov 2019 16:27:47 -0800 (PST)
Received: from ninjahub.lan (host-2-102-12-67.as13285.net. [2.102.12.67])
        by smtp.googlemail.com with ESMTPSA id e16sm1051291wme.35.2019.11.25.16.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 16:27:46 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     bp@alien8.de, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com,
        mingo@redhat.com, Jules Irenge <jbi.octave@gmail.com>
Subject: [PATCH] cpu: microcode: replace 0 with NULL
Date:   Tue, 26 Nov 2019 00:27:34 +0000
Message-Id: <20191126002734.121905-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace 0 with NULL to fix sparse tool  warning
 warning: Using plain integer as NULL pointer

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 arch/x86/kernel/cpu/microcode/amd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index a0e52bd00ecc..4934aa7c94e7 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -418,7 +418,7 @@ static int __apply_microcode_amd(struct microcode_amd *mc)
 static bool
 apply_microcode_early_amd(u32 cpuid_1_eax, void *ucode, size_t size, bool save_patch)
 {
-	struct cont_desc desc = { 0 };
+	struct cont_desc desc = { NULL };
 	u8 (*patch)[PATCH_MAX_SIZE];
 	struct microcode_amd *mc;
 	u32 rev, dummy, *new_rev;
@@ -543,7 +543,7 @@ load_microcode_amd(bool save, u8 family, const u8 *data, size_t size);
 
 int __init save_microcode_in_initrd_amd(unsigned int cpuid_1_eax)
 {
-	struct cont_desc desc = { 0 };
+	struct cont_desc desc = { NULL };
 	enum ucode_state ret;
 	struct cpio_data cp;
 
-- 
2.23.0

