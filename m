Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACE5C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 22:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEB62207FD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 22:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uzx/5OMD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbgAFWyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 17:54:19 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44802 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgAFWyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 17:54:18 -0500
Received: by mail-pg1-f196.google.com with SMTP id x7so27521905pgl.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 14:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BpAxESMCcXCSAxL59rFdWBZ2hjtyWfPRAq5lKk8HL34=;
        b=Uzx/5OMDlWzTeV4JmlKm0DoIuyKCpRuLl4uAvP41bNAti42CoSDPWWPDVAkT0QQQRt
         E1qm96M8yKI2LJNaZbc2nf0Fp0T5M8CmkV7RZ3QhEshiYysb0PlMYBlr1q+A9C2Ajb0/
         Ba+Rmg6VahLlkeBvUE8Rpqc/K+vXpyzBA+uK2L4ohV0ffan/ixbvbs8/M8W8JuQw/qhV
         B+2bwLvYCft+JBGlIsW0IMsHxqtCDaE7z/NrtDqfxPlpINKA+vycDTQpl3UOwuWz/30W
         dqwRizizPfvzeDQDX+334l6VmdMOZfa8ZPRJKXpYVPJtryye9f4xp/jk9HNeYf48K901
         7u7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BpAxESMCcXCSAxL59rFdWBZ2hjtyWfPRAq5lKk8HL34=;
        b=bGRAo4duse3wY/47MMzE3SRlE+JezsaGNGw47RXs+n9e+jtgpVQEBaejZ7/pYWOE5i
         l6PYO2gqwcz9Gg3EcCMmPiEA2XplJAakrT82ZOmNxJXkCQ15FWtMgBOgg9G+WJPifcCg
         i8UoEc4ljBVGDjogXGoqbLXW/5ErmMVW87eFT4LypJ1xEe6mQe8IOB0jijqkDPotIoK1
         nU36/tH89yfg66tuH0g6huZqiw6rA8Pb6pF/KRU0OicOQZVDvvOIIBwYfLsdOlWZhjPt
         F7Nd0z4nKvKL0kcyYheTr5TqeEC+e7r3wepnMaNBGiAMaW79qA587G8inHkAYDJ2D1rx
         dQWQ==
X-Gm-Message-State: APjAAAWwIBDW0t3RvXBAcmMc2nxWXgmsx4Fxgb84DjL4KXaJYah2SN8G
        w7tuoC6nO50aOXdgXZrm8/HJsDKg
X-Google-Smtp-Source: APXvYqyxHQVIW/Xd0+lGsJuzbT/d67U8V5k93CSY58F6UFBNM0hzN0bPeyP/NBQuoTa5E2B0U4E7jQ==
X-Received: by 2002:a63:1402:: with SMTP id u2mr112088439pgl.224.1578351258118;
        Mon, 06 Jan 2020 14:54:18 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id r8sm24892569pjo.22.2020.01.06.14.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 14:54:17 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     bcm-kernel-feedback-list@broadcom.com, opendmb@gmail.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Julien Grall <julien.grall@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] arm64: kpti: Add Broadcom Brahma-B53 core to the KPTI whitelist
Date:   Mon,  6 Jan 2020 14:54:12 -0800
Message-Id: <20200106225414.20795-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Broadcom Brahma-B53 CPUs do not implement ID_AA64PFR0_EL1.CSV3 but are
not susceptible to Meltdown, so add all Brahma-B53 part numbers to
kpti_safe_list[].

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm64/kernel/cpufeature.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 04cf64e9f0c9..0427b72c960b 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -975,6 +975,7 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 	static const struct midr_range kpti_safe_list[] = {
 		MIDR_ALL_VERSIONS(MIDR_CAVIUM_THUNDERX2),
 		MIDR_ALL_VERSIONS(MIDR_BRCM_VULCAN),
+		MIDR_ALL_VERSIONS(MIDR_BRAHMA_B53),
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_A35),
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_A53),
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_A55),
-- 
2.17.1

