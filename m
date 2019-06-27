Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A344EC48BD9
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7962A2082F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561596743;
	bh=+fYedI3f1kkejb9gAaYArLHEJ7GHvHVVcQHQvwI27/0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=TIUebptlsHJOn4ByO1QOaULAkgOA9kCmcoH0i2TXMGjSrty1K/oQPgB364toQyMHM
	 g2w3NgHNDmQ/NpANUhlg81FlbQr9xUgn9EVciieXN+SmIE2YeDfUKY1SZMHHt78SRX
	 kyRdl12SkRNbpc+3bsSYgi/CGPD5n/8gDl+GHi8U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbfF0Ade (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 20:33:34 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33208 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727758AbfF0Ad0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 20:33:26 -0400
Received: by mail-pg1-f193.google.com with SMTP id m4so169110pgk.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 17:33:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t9hxeAIft4GeNwQ57ELlp04njjQpHvGUsvcIVUcZqi8=;
        b=Q7TUf//+SAWgPj8BAwFHz5ovhHzykJ/ggxZiORSq8GxB/7XuSi7BTSCHHQHcGXtyvH
         sf86eGZCwcKBEdavsNwLSioWe9vW74789resF2b+3ZS/k+nAcm0xBcGNb65bixWytdDv
         TMoitIMMganBs9MP2fwgiMld6eLmnc4mqI4MDowMpRV+zJuWLOdqb7SxdT9pkTLB45Ma
         uurG5dDY6I46SnSOHz91Jj8e7KX34bm42gBk53X8EUP0k9Uz6XfcwsXP+Bez1ToKaLAL
         XDAQkrPRmIItGvyH8zh6S5sNY4XHTtyqg+/S4gRRYLh13AJaRl7d+kOSX6CZe2w+J5tk
         oTpg==
X-Gm-Message-State: APjAAAXl82r36LNNkWVZ2i2FNxyOl5TaJToB2gsl58fCEyAXifk5Y/x0
        8hbzZz45OysjW2hDWg1CtRKfX6uDpbc=
X-Google-Smtp-Source: APXvYqyJdg+XYYqogXxOt1f02dDkA791aTYlXwUKt6UHjg7m8a7h7JYXsynZP+RfY/UNAw6eAvDnqQ==
X-Received: by 2002:a17:90a:17c4:: with SMTP id q62mr2403128pja.104.1561595605450;
        Wed, 26 Jun 2019 17:33:25 -0700 (PDT)
Received: from localhost (c-76-21-109-208.hsd1.ca.comcast.net. [76.21.109.208])
        by smtp.gmail.com with ESMTPSA id f64sm430219pfa.115.2019.06.26.17.33.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 17:33:24 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>
Subject: [PATCH] fpga: altera-pr-ip: Make alt_pr_unregister function void
Date:   Wed, 26 Jun 2019 17:33:09 -0700
Message-Id: <20190627003309.27595-1-mdf@kernel.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make alt_pr_unregister function void, since it always returns 0,
and nothing would act on the value anyways.

Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/fpga/altera-pr-ip-core-plat.c  | 4 +++-
 drivers/fpga/altera-pr-ip-core.c       | 4 +---
 include/linux/fpga/altera-pr-ip-core.h | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/fpga/altera-pr-ip-core-plat.c b/drivers/fpga/altera-pr-ip-core-plat.c
index b293d83143f1..99b9cc0e70f0 100644
--- a/drivers/fpga/altera-pr-ip-core-plat.c
+++ b/drivers/fpga/altera-pr-ip-core-plat.c
@@ -32,7 +32,9 @@ static int alt_pr_platform_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 
-	return alt_pr_unregister(dev);
+	alt_pr_unregister(dev);
+
+	return 0;
 }
 
 static const struct of_device_id alt_pr_of_match[] = {
diff --git a/drivers/fpga/altera-pr-ip-core.c b/drivers/fpga/altera-pr-ip-core.c
index a7a3bf0b5202..2cf25fd5e897 100644
--- a/drivers/fpga/altera-pr-ip-core.c
+++ b/drivers/fpga/altera-pr-ip-core.c
@@ -201,15 +201,13 @@ int alt_pr_register(struct device *dev, void __iomem *reg_base)
 }
 EXPORT_SYMBOL_GPL(alt_pr_register);
 
-int alt_pr_unregister(struct device *dev)
+void alt_pr_unregister(struct device *dev)
 {
 	struct fpga_manager *mgr = dev_get_drvdata(dev);
 
 	dev_dbg(dev, "%s\n", __func__);
 
 	fpga_mgr_unregister(mgr);
-
-	return 0;
 }
 EXPORT_SYMBOL_GPL(alt_pr_unregister);
 
diff --git a/include/linux/fpga/altera-pr-ip-core.h b/include/linux/fpga/altera-pr-ip-core.h
index 7d4664730d60..0b08ac20ab16 100644
--- a/include/linux/fpga/altera-pr-ip-core.h
+++ b/include/linux/fpga/altera-pr-ip-core.h
@@ -13,6 +13,6 @@
 #include <linux/io.h>
 
 int alt_pr_register(struct device *dev, void __iomem *reg_base);
-int alt_pr_unregister(struct device *dev);
+void alt_pr_unregister(struct device *dev);
 
 #endif /* _ALT_PR_IP_CORE_H */
-- 
2.22.0

