Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0158C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 22:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A75C2080A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 22:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLFgFtlV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbfFQWaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 18:30:13 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46287 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfFQWaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 18:30:12 -0400
Received: by mail-wr1-f66.google.com with SMTP id n4so11691958wrw.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 15:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=EmgnUawf35aS/COYEiBvR/oQX1TKluh8z6aoSb2xf0o=;
        b=gLFgFtlVcDKfDN8uDdSejzgX1wovCYMzQtr78f8oiPm6oQDbxTudonvxj9toElDTVN
         /hOio1Gpja0hS3ADxE+jpsqBjl0MNIcbcw3Fy/u32FIoFfAY43c32gLHv+On0eYSMWWX
         twdOXUOZvLtZYXXrWYiqMsRJ/0RA+uZSTCTswq2GX30X/PLSuU0FEfFA58X4MRc6bfkM
         nS2ZBXs6CbBWIGi2TgL3aDKvqQNrkn3bBfYNeP+GvsmYzKsJvwGmYmn8n5olXWphtEzv
         kwsS7pUgJ35F/oZmpo+HvdGzP+PFjxx2oZ8oN7OIcvErHLDNEctW6oyXLsYkfClU3vs0
         N5Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EmgnUawf35aS/COYEiBvR/oQX1TKluh8z6aoSb2xf0o=;
        b=oTsUGtddP1FI0ctp0uC/W0GlD3jaaypxrzVEEl1eMUAdYwFoDg+f6CjenHrmYe/g5u
         wMzDPulra20He5iPAQa3BisvHbMOXQHv1kxbORAyGRJ9xHfWzAcrR4DXD+Cqsnq22qsc
         ZBqvmPBK+UN/8AnFrketWSMnvOBl76iwcay8Y/9akgly4nXuKeCKguEc+kaSFfvBbjOP
         9t26sXva0bokJEMp2nLieavnoDVH4HUZuaDBvOhDLf7YMi95vyJ0IhCdeEtVPawOQnfU
         5nrXXh7reR9S3eZ3KCLhNoSbeIXE1W/oKgc0cBojLP490A2Au+BLJ3jOLC1Uz+cAsevl
         ousQ==
X-Gm-Message-State: APjAAAXS/CPNro3pwt2qrHmfk60zNuQTGV/cXJdLZ2OzNUIME5K4FCq7
        ih8eXa/6//I+W5hCovjWSfV28Sth
X-Google-Smtp-Source: APXvYqwEbSV3AhfkPcbOPFageFa+KGOeWfUBLZ9Gw2XrE6rApx75LQ3h0Njbij3BVtQ8wF9aCye2pQ==
X-Received: by 2002:adf:e691:: with SMTP id r17mr24374353wrm.67.1560810610247;
        Mon, 17 Jun 2019 15:30:10 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id v204sm501312wma.20.2019.06.17.15.30.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 15:30:09 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     bcm-kernel-feedback-list@broadcom.com, ard.biesheuvel@linaro.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3] arm64: Allow user selection of ARM64_MODULE_PLTS
Date:   Mon, 17 Jun 2019 15:29:59 -0700
Message-Id: <20190617223000.11403-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make ARM64_MODULE_PLTS a selectable Kconfig symbol, since some people
might have very big modules spilling out of the dedicated module area
into vmalloc. Help text is copied from the ARM 32-bit counterpart and
modified to a mention of KASLR and specific ARM errata workaround(s).

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v3:
- take out the part about "The modules will use slightly more memory, but after
  rounding up to page size, the actual memory footprint is usually the same.
- take out the "If unusure say Y", since we would really prefer this to
  be off by default for maximum performance

Changes in v2:

- added Ard's paragraph about KASLR
- added a paragraph about specific workarounds also requiring
  ARM64_MODULE_PLTS

 arch/arm64/Kconfig | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 697ea0510729..9206feaeff07 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1418,8 +1418,26 @@ config ARM64_SVE
 	  KVM in the same kernel image.
 
 config ARM64_MODULE_PLTS
-	bool
+	bool "Use PLTs to allow module memory to spill over into vmalloc area"
 	select HAVE_MOD_ARCH_SPECIFIC
+	help
+	  Allocate PLTs when loading modules so that jumps and calls whose
+	  targets are too far away for their relative offsets to be encoded
+	  in the instructions themselves can be bounced via veneers in the
+	  module's PLT. This allows modules to be allocated in the generic
+	  vmalloc area after the dedicated module memory area has been
+	  exhausted.
+
+	  When running with address space randomization (KASLR), the module
+	  region itself may be too far away for ordinary relative jumps and
+	  calls, and so in that case, module PLTs are required and cannot be
+	  disabled.
+
+	  Specific errata workaround(s) might also force module PLTs to be
+	  enabled (ARM64_ERRATUM_843419).
+
+	  Disabling this is usually safe for small single-platform
+	  configurations.
 
 config ARM64_PSEUDO_NMI
 	bool "Support for NMI-like interrupts"
-- 
2.17.1

