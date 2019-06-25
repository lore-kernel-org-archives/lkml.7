Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58526C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B3CA215EA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730953AbfFYItC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 04:49:02 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33793 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730927AbfFYIs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:48:59 -0400
Received: by mail-pf1-f193.google.com with SMTP id c85so9124998pfc.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 01:48:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=f1EqKr7GJC/8CxAccGmLUlVnbKRyObp1Mx1bLRI3a2c=;
        b=p6YmrTm9NuFYWdlEKcSeMrMGHVED+YiGsuskC3nKpMvRoutpZjbFg9EOSGpJJcGdiW
         e9U5kkolkGdnc7YsvqfvxfxNrcNBTE3ZwoOJKxzLfydtBCP0JVGwqYtSTuOg3dkcdDXO
         UZKGCUJoUWalUy5QO7+IlE+cDdOeZMZEhnnQs5aFX21PJb3G8tGpkkfoWVljVFAHoF3m
         fGO/y8j18DPBh84pdhVMafKwOOTCnjziuML1GeBmdcFVWRM820Ixd4b+dMmLim59SkSp
         ZN4+smLJoHdx0Zjj9Wj2qH6zSyGsBvir5wMTHCV9dQ3mCnhROstHjlZuAaWeUzqcSWd5
         0s/Q==
X-Gm-Message-State: APjAAAVMAMfLbtVV4ljD1Q562WYwfeDHQ7kAoHM0l7MuvjeKzMvF8uXw
        OIji9KRfKMBSBo5hUh0XE4ED9w==
X-Google-Smtp-Source: APXvYqxi11fDTnliRbD2FFe1yfBEWRAkKNciTSRn86oA7mCGILT1K0pRVbT5ADMTCuMKh8BJFb7/Xg==
X-Received: by 2002:a63:d4c:: with SMTP id 12mr9800277pgn.30.1561452538882;
        Tue, 25 Jun 2019 01:48:58 -0700 (PDT)
Received: from localhost (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id f15sm1829014pje.17.2019.06.25.01.48.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 01:48:58 -0700 (PDT)
Subject: [PATCH v2 1/2] net: macb: Kconfig: Make MACB depend on COMMON_CLK
Date:   Tue, 25 Jun 2019 01:48:27 -0700
Message-Id: <20190625084828.540-2-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190625084828.540-1-palmer@sifive.com>
References: <20190625084828.540-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>
From:   Palmer Dabbelt <palmer@sifive.com>
To:     nicolas.ferre@microchip.com, harinik@xilinx.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit c218ad559020 ("macb: Add support for SiFive FU540-C000") added a
dependency on the common clock framework to the macb driver, but didn't
express that dependency in Kconfig.  As a result macb now fails to
compile on systems without COMMON_CLK, which specifically causes a build
failure on powerpc allyesconfig.

This patch adds the dependency, which results in the macb driver no
longer being selectable on systems without the common clock framework.
All known systems that have this device already support the common clock
framework, so this should not cause trouble for any uses.  Supporting
both the FU540-C000 and systems without COMMON_CLK is quite ugly.

I've build tested this on powerpc allyesconfig and RISC-V defconfig
(which selects MACB), but I have not even booted the resulting kernels.

Fixes: c218ad559020 ("macb: Add support for SiFive FU540-C000")
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 drivers/net/ethernet/cadence/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/Kconfig b/drivers/net/ethernet/cadence/Kconfig
index 1766697c9c5a..64d8d6ee7739 100644
--- a/drivers/net/ethernet/cadence/Kconfig
+++ b/drivers/net/ethernet/cadence/Kconfig
@@ -21,7 +21,7 @@ if NET_VENDOR_CADENCE
 
 config MACB
 	tristate "Cadence MACB/GEM support"
-	depends on HAS_DMA
+	depends on HAS_DMA && COMMON_CLK
 	select PHYLIB
 	---help---
 	  The Cadence MACB ethernet interface is found on many Atmel AT32 and
@@ -42,7 +42,7 @@ config MACB_USE_HWSTAMP
 
 config MACB_PCI
 	tristate "Cadence PCI MACB/GEM support"
-	depends on MACB && PCI && COMMON_CLK
+	depends on MACB && PCI
 	---help---
 	  This is PCI wrapper for MACB driver.
 
-- 
2.21.0

