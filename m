Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UPPERCASE_50_75,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA75C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 00:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52AA120675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 00:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjX6GNGU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbfCFAoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 19:44:38 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52725 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbfCFAoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 19:44:38 -0500
Received: by mail-wm1-f68.google.com with SMTP id f65so4257311wma.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 16:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=GeHWi5S5HZml3Q5E55uHKLs7SnT89+/gDRc8H/Sl3CU=;
        b=EjX6GNGUXjHj7hr2zbAwGhk6WT4QMh65dNrE8YUdJcnI5TonL0Bg5XOXidg987Kp5S
         nLsog4KvM7nU8YphTHgY4NyeOS8/KJdJQ3CnYMD4jQeVD1elYbN8ZHZDJXzrQ4TZ4UA9
         bVNvfrQtTeV864LEZR8dwwrCway/PpQ/WcRHC1nPoAL/yQxNK+UpwBzut3ZvBPLR0qRX
         bnkPiS5rU7fRVz9x7Q0QMFSdEy2e/pzHrIS11PAPGtVBfyRBEp9m4ApsL8yAmg6Ba9Ew
         llQX2CSKzsltJWhPoVhzyW50cXLGrtob2T1akai9r1b/9QG/qazu7Psg7IVmX6qwG5f4
         QolQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=GeHWi5S5HZml3Q5E55uHKLs7SnT89+/gDRc8H/Sl3CU=;
        b=ECfSF2jvGf7uXHdcmp2Gv71uHbHj9+zn2CpsdvGTS8baXhEFbiTyjQEEH16Cqsr+42
         HXbGcr5CGyjG6Mq1I5bzRPd8Nn/viHRbgGGp1yIQBkvKFiSd1+pY7AQH7uswJm+SKePp
         PGabwi8yKFMFRqVfQih4hC8Pj3/TobWdxOCFCaZ75zIyzFnVlmtPMqxRXJ7NjygKqmhp
         jXjoKdZb6RWNnv4hvFkJlFKiIMeXYYyxSHNTwIb4qEZE9UANTAnqCRDgHcWjr0bSBvXt
         oK62Trw0hCnm1jpPxDootVKEFSfYiqhJCUQQaUNtQ3vIrvm3b2iY0eVdS0iUhdCTLuzN
         SrIQ==
X-Gm-Message-State: APjAAAWklwo5SAi0RO/CItnfyS/ZcRsJglQV+sOLuGLdVvZdAZgytFsq
        WgWlX6EKFDKTjSAkRNLyeak=
X-Google-Smtp-Source: APXvYqzJdhs9qL9aNt8ZhCo6+xPDRpVLbJGzFmmmqw6n7iBdjyGklUlKPf1/AssecMAWU+jW2mH7Gw==
X-Received: by 2002:a1c:4884:: with SMTP id v126mr663532wma.118.1551833076463;
        Tue, 05 Mar 2019 16:44:36 -0800 (PST)
Received: from darwi-home-pc (ip-109-42-1-86.web.vodafone.de. [109.42.1.86])
        by smtp.gmail.com with ESMTPSA id h10sm497536wmf.2.2019.03.05.16.44.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 05 Mar 2019 16:44:35 -0800 (PST)
Date:   Wed, 6 Mar 2019 01:44:25 +0100
From:   "Ahmed S. Darwish" <darwish.07@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/defconfig: Remove archaic partition tables support
Message-ID: <20190306004425.GA30537@darwi-home-pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On x86 systems, only MSDOS and GPT partition tables are typically
encountered. Remove all the rest.

Signed-off-by: Ahmed S. Darwish <darwish.07@gmail.com>
---

Notes:
    CONFIG_EFI_PARTITION is also removed since it defaults to `y'.

 arch/x86/configs/i386_defconfig   | 12 ------------
 arch/x86/configs/x86_64_defconfig | 12 ------------
 2 files changed, 24 deletions(-)

diff --git a/arch/x86/configs/i386_defconfig b/arch/x86/configs/i386_defconfig
index 4bb95d7ad947..838c49a30738 100644
--- a/arch/x86/configs/i386_defconfig
+++ b/arch/x86/configs/i386_defconfig
@@ -25,18 +25,6 @@ CONFIG_JUMP_LABEL=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
-CONFIG_PARTITION_ADVANCED=y
-CONFIG_OSF_PARTITION=y
-CONFIG_AMIGA_PARTITION=y
-CONFIG_MAC_PARTITION=y
-CONFIG_BSD_DISKLABEL=y
-CONFIG_MINIX_SUBPARTITION=y
-CONFIG_SOLARIS_X86_PARTITION=y
-CONFIG_UNIXWARE_DISKLABEL=y
-CONFIG_SGI_PARTITION=y
-CONFIG_SUN_PARTITION=y
-CONFIG_KARMA_PARTITION=y
-CONFIG_EFI_PARTITION=y
 CONFIG_SMP=y
 CONFIG_X86_GENERIC=y
 CONFIG_HPET_TIMER=y
diff --git a/arch/x86/configs/x86_64_defconfig b/arch/x86/configs/x86_64_defconfig
index 0fed049422a8..05e057efca28 100644
--- a/arch/x86/configs/x86_64_defconfig
+++ b/arch/x86/configs/x86_64_defconfig
@@ -24,18 +24,6 @@ CONFIG_JUMP_LABEL=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
-CONFIG_PARTITION_ADVANCED=y
-CONFIG_OSF_PARTITION=y
-CONFIG_AMIGA_PARTITION=y
-CONFIG_MAC_PARTITION=y
-CONFIG_BSD_DISKLABEL=y
-CONFIG_MINIX_SUBPARTITION=y
-CONFIG_SOLARIS_X86_PARTITION=y
-CONFIG_UNIXWARE_DISKLABEL=y
-CONFIG_SGI_PARTITION=y
-CONFIG_SUN_PARTITION=y
-CONFIG_KARMA_PARTITION=y
-CONFIG_EFI_PARTITION=y
 CONFIG_SMP=y
 CONFIG_CALGARY_IOMMU=y
 CONFIG_NR_CPUS=64
-- 
2.21.0



