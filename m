Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4810FC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 09:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 127A520838
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 09:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UI8KrHdr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfCBJcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 04:32:18 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37105 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfCBJcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 04:32:18 -0500
Received: by mail-wr1-f68.google.com with SMTP id w6so343077wrs.4
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2019 01:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=joqn5Xs03btRWMSpGDk0Xv5wFbY5lYz8+YUXO2uk0+k=;
        b=UI8KrHdrPaLrIJHC/o21+m8VxoVtLMUTemzGUXZ/lNtHE5tYSFuTiXxGlxwSw55QnY
         ff6ZFPItfRo5JFFyBu2ARSVmpjH1r/7gg3ZDUt4FXNx2rX4cwwH0ElEHBfBP4WTG3Okq
         IhHPYDdJ0GsT41ASQgDFLkTyBLWVpuhsVnoiCL16qK+OhJia4n3s0dTi+oQnTzl6l1PY
         vdUHUE4wZXIS2Z7quiewUW04hrZgVFLljEtlkLWcLftbmBhoMTOX281SyWK1GM9N7aH9
         M1gEgyxQG0STVE6VNiWpSBIaw+KTqeBcZe5UiPPBHbBJc0mfGaJTHzDZgmpYMxGo7GbI
         4RWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=joqn5Xs03btRWMSpGDk0Xv5wFbY5lYz8+YUXO2uk0+k=;
        b=Aqe/sKnYp8K5CtVD9RbhZ2rQICVSezPVXV1NfJF8dZYBYLPz7Gxf7BfqByioSIMEyH
         bAoKtjJb3e4qdbSN39PMBlM0W7BR46UpLWkw8j6ewslyWVOGjqnRPVelYJKe++y3vljr
         qsOaauxs5Za+4HlepmkSwSUMOTY+Ej+EgSfD82CKDtLTikBL/uqSYmkFl+X1zkTQw4G9
         e2e2cUxCkm9f0PoF4z2G8q6X3UjFdxF+Fj0ioR0w/OSHHj/R/aqX47nL64h5Lx/GxK85
         3gORYTYCKOwBdLd6D+fcpsKYJPy4gaQKLDZriiZ5ebqoQPuuzse9ilKbu4/UEQ3MYsQ9
         i8Gg==
X-Gm-Message-State: APjAAAVQdcujVPZCw229lAHtFW0p8mIPVJmp2xDU0zPiDlgv6RPSRaSA
        KaZdBXh7mPt+mfU98gBK95FJZKdc
X-Google-Smtp-Source: APXvYqxsK+HBUvJmZVxhcTHIiEEcKsCllYeJG5ZEHiQ/cHMvJkwLA82Es1GgYzHfdrh1aBfnJn90sw==
X-Received: by 2002:adf:de83:: with SMTP id w3mr6096584wrl.56.1551519136545;
        Sat, 02 Mar 2019 01:32:16 -0800 (PST)
Received: from goyamonster.habana-labs.com ([31.154.181.186])
        by smtp.gmail.com with ESMTPSA id d21sm2104544wrc.44.2019.03.02.01.32.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Mar 2019 01:32:15 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] habanalabs: adjust Kconfig to fix build errors
Date:   Sat,  2 Mar 2019 11:32:12 +0200
Message-Id: <20190302093212.7585-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver use the HWMON framework to display various sensors information.
Therefore, CONFIG_HWMON must be included to prevent build errors.

This patch adds "select HWMON" to the driver's Kconfig file to make sure
HWMON is built. In addition, to avoid breaking dependencies, it adds
dependency on HAS_IOMEM because HWMON is dependent on HAS_IOMEM.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/Kconfig b/drivers/misc/habanalabs/Kconfig
index a7cbc1fb6957..99db2b82ada6 100644
--- a/drivers/misc/habanalabs/Kconfig
+++ b/drivers/misc/habanalabs/Kconfig
@@ -4,10 +4,11 @@
 
 config HABANA_AI
 	tristate "HabanaAI accelerators (habanalabs)"
-	depends on PCI
+	depends on PCI && HAS_IOMEM
 	select FRAME_VECTOR
 	select DMA_SHARED_BUFFER
 	select GENERIC_ALLOCATOR
+	select HWMON
 	help
 	  Enables PCIe card driver for Habana's AI Processors (AIP) that are
 	  designed to accelerate Deep Learning inference and training workloads.
-- 
2.18.0

