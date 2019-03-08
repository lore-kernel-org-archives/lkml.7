Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9B4C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90D7A2133F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tjywWtwf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfCHM7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:59:37 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:34138 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbfCHM7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:59:36 -0500
Received: by mail-yw1-f66.google.com with SMTP id u205so16218184ywe.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 04:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1hms/5IsZhU5jpk430jeUjgKow1Cl2U2/bwfLiqsmlw=;
        b=tjywWtwfNsRFziPnarakLQeBHqcExzZlpEP69AabIt5Jj00gXL5SLW/FzXDyRUOFrY
         afzvZjnR6Q1GyaMitkg8iy/W1MLsXZ+SGMaoMilCPRNmycasHPwOvYE+aGYPALqiLB2z
         r3Qb7dNoBBT1vmzNmY3MPt3g9NPBjT3WB1Sx3LP6o+v3ku45XQoMTrk8Eh12CTikY9rr
         GNNsibkb0VeMbUb6eO28tE/HcyB1UuDujs2L2p+1nbPfSOYfPGhEJkCKppLSbcPzBXvU
         7VAm8mmhugnDugkz9v8iP0E2aEYB0xdXXobPeo7i702m285GLPTgx34Bl01m2SPj9gxY
         fqsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1hms/5IsZhU5jpk430jeUjgKow1Cl2U2/bwfLiqsmlw=;
        b=rndfOJ31a047sNGQc/HAdSi5VYfL2EcfvTevPfjXQwwUY8f3fEsosNDbvn/0Za33tM
         DvGmuABaoaUmo2kY99+aFGx2jB1Sz+EZwTULN9RGxQPicnHaNx+qMULL0vKrhlhIM1Ks
         Ew0HxvJy9e469bx54i+JkS10bEbWbK25DJ6bKpp75GRMddJnOQdWotFy6Kdgf0rw53v0
         ocEqKmLdfvgGp8uZnjiZW2tnn0Ftngs/Iiciok6rnYRqWAPz8KtTuexrHfkGSsUDTmnf
         XBOlOCNjPDQR2FnVl4qooNio5/VL4yredF8XC1hzngO/i4TU6XxeHOX3HB7ydt0mADjJ
         VlPA==
X-Gm-Message-State: APjAAAVkGMugePUor/CNVudXoo8vAziTGeqyg/4uHCdwgwmRV41kW6+f
        nJU6jVDgs5g6J3jcO/djN/o=
X-Google-Smtp-Source: APXvYqwNPUPyMdsiamr7DILcKDbAoIaAMTBl+CUPESgT+e7+XDlsBJoxx3J9WmXm1ofRVR9OWrd+pA==
X-Received: by 2002:a81:9a8d:: with SMTP id r135mr14065733ywg.188.1552049975020;
        Fri, 08 Mar 2019 04:59:35 -0800 (PST)
Received: from laptop.localdomain ([185.175.33.171])
        by smtp.gmail.com with ESMTPSA id g82sm3057775ywg.60.2019.03.08.04.59.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 04:59:34 -0800 (PST)
From:   Yasha Cherikovsky <yasha.che3@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Cc:     Yasha Cherikovsky <yasha.che3@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] MIPS: Ensure ELF appended dtb is relocated
Date:   Fri,  8 Mar 2019 14:58:51 +0200
Message-Id: <20190308125851.31806-2-yasha.che3@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308125851.31806-1-yasha.che3@gmail.com>
References: <20190308125851.31806-1-yasha.che3@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes booting with the combination of CONFIG_RELOCATABLE=y
and CONFIG_MIPS_ELF_APPENDED_DTB=y.

Sections that appear after the relocation table are not relocated
on system boot (except .bss, which has special handling).

With CONFIG_MIPS_ELF_APPENDED_DTB, the dtb is part of the
vmlinux ELF, so it must be relocated together with everything else.

Fixes: 069fd766271d ("MIPS: Reserve space for relocation table")
Signed-off-by: Yasha Cherikovsky <yasha.che3@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
---
 arch/mips/kernel/vmlinux.lds.S | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
index cb7e9ed7a453..33ee0d18fb0a 100644
--- a/arch/mips/kernel/vmlinux.lds.S
+++ b/arch/mips/kernel/vmlinux.lds.S
@@ -140,6 +140,13 @@ SECTIONS
 	PERCPU_SECTION(1 << CONFIG_MIPS_L1_CACHE_SHIFT)
 #endif
 
+#ifdef CONFIG_MIPS_ELF_APPENDED_DTB
+	.appended_dtb : AT(ADDR(.appended_dtb) - LOAD_OFFSET) {
+		*(.appended_dtb)
+		KEEP(*(.appended_dtb))
+	}
+#endif
+
 #ifdef CONFIG_RELOCATABLE
 	. = ALIGN(4);
 
@@ -164,11 +171,6 @@ SECTIONS
 	__appended_dtb = .;
 	/* leave space for appended DTB */
 	. += 0x100000;
-#elif defined(CONFIG_MIPS_ELF_APPENDED_DTB)
-	.appended_dtb : AT(ADDR(.appended_dtb) - LOAD_OFFSET) {
-		*(.appended_dtb)
-		KEEP(*(.appended_dtb))
-	}
 #endif
 	/*
 	 * Align to 64K in attempt to eliminate holes before the
-- 
2.21.0

