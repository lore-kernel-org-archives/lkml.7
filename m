Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24707C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 23:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBCAB20731
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 23:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="jYk9DRTR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbgAFXUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 18:20:34 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:50260 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgAFXUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 18:20:33 -0500
Received: by mail-pj1-f65.google.com with SMTP id r67so8174427pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 15:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=srz94l2uXXDm8uhaL89NYYkGpBsk/DmmiKVKo8s3kgo=;
        b=jYk9DRTRireyhjENtb52/RKEST50v32C96Gq260txWajZnQCgvUkbcTRp/HvgmsJaT
         zio3OwSDqGdiXCpd48WpezHFzzepUlB+PVpMpQ2My7r9JRq2BJqjNCVI5afWqXSfJoOT
         3g2Y2WuNNxSo1s1b2ffQ/j3mNeveIpYI1/8/ELdrC0kR1Ev2pn7AKndFKjqaBcP1cODK
         imi5R+9ix0WXJOgNuP4sKKLEJZor44iihGN5WQMLFWq8BEIP5Dx2awjyHfD+llAMVE3Q
         MNBFDf1/6nK7oq21s2djuQyxFWtVlh9QIQ4E4guLOcR6mJ1SRg6dMkA4cy1ovcoBpk7U
         Xxsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=srz94l2uXXDm8uhaL89NYYkGpBsk/DmmiKVKo8s3kgo=;
        b=hvP43sxG/HM5Ssj3mnVafNw9bV4i4PFjdo4OiWJi/+sAJTUI9RgmnRwlxhsel5ISMQ
         zhWP2JT7gTinK7mFwvSMMeHXGYdEfxVB0fs1GzigWTgulnR2jtPTnfX/BVirY1t1gx8F
         rg2BeMfBw+nqE2UierNTdYnYcF8jv5TRWvWpEc4JFJmsVrNKg06m//H5XtEoBS8EqW9G
         Nrjpljnu+4St8feaDw7sTVG37Di/xtpGjytFUrXwVjwInScMl7FnxoUVCp7z9s/kpXYy
         VVIQ+zoYhb2XBcD5Hf81Iv6ERymlO4CNTn317sJ0kW5JLFGMwzdXZFZOfMkdnt5GXOqc
         qelA==
X-Gm-Message-State: APjAAAUkuNmC/Zr1j0BDMTRcvxC735eJE38as0ZPh55VzbUIxMdpvQeJ
        X4tnsSB2YTPglG+YAz4XwAd6ig==
X-Google-Smtp-Source: APXvYqyXTzaS5RNfBUvI/u+g1zVhiot57BVfPvtWE5HmMqzI7VmtD21utgVOzkWZoI+sUgG8+/v17w==
X-Received: by 2002:a17:902:b40a:: with SMTP id x10mr90682005plr.64.1578352833142;
        Mon, 06 Jan 2020 15:20:33 -0800 (PST)
Received: from rip.lixom.net (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id u26sm76165686pfn.46.2020.01.06.15.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 15:20:32 -0800 (PST)
From:   Olof Johansson <olof@lixom.net>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH v2] riscv: keep 32-bit kernel to 32-bit phys_addr_t
Date:   Mon,  6 Jan 2020 15:20:24 -0800
Message-Id: <20200106232024.97137-1-olof@lixom.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200106231611.10169-1-olof@lixom.net>
References: <20200106231611.10169-1-olof@lixom.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While rv32 technically has 34-bit physical addresses, no current platforms
use it and it's likely to shake out driver bugs.

Let's keep 64-bit phys_addr_t off on 32-bit builds until one shows up,
since other work will be needed to make such a system useful anyway.

PHYS_ADDR_T_64BIT is def_bool 64BIT, so just remove the select.

Signed-off-by: Olof Johansson <olof@lixom.net>
---

v2: Just remove the select, since it's set by default if CONFIG_64BIT

 arch/riscv/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index a31169b02ec06..569fc6deb94d6 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -12,8 +12,6 @@ config 32BIT
 
 config RISCV
 	def_bool y
-	# even on 32-bit, physical (and DMA) addresses are > 32-bits
-	select PHYS_ADDR_T_64BIT
 	select OF
 	select OF_EARLY_FLATTREE
 	select OF_IRQ
-- 
2.20.1

