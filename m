Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2CDECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A93D220684
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T02r3Jln"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbfJGSnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 14:43:46 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34787 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728242AbfJGSnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 14:43:45 -0400
Received: by mail-pf1-f193.google.com with SMTP id b128so9237588pfa.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 11:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eSk9ZIII9ve+HiZZ6aR0Kr7ZvXDd9PcgJdMXThbLDKc=;
        b=T02r3JlnR5A9zBHffoLJAhEzk+CLKFfdUTn5mp8hEla7H46AUtBI+004AY753G7dIn
         zoWcbusVGDnUG5inQ3VA//l62HxTBJpzQII2+DkFvlmdIyZVaHg/jxlby3gTXTJVKgkb
         1oXoiquwK19L24ZJQI9hTH9tZHef7i5h5EltdgEVMitWEnagC5Qb3e2t15cFQ0XN1cDf
         BZUSt8pXhDNUbSsigTCO/j7Z3TA1GWbOtTqTi/JVrLXQNyTznaVG/Y2vdc4QUlvaPnUA
         xCdm/6T05hIGgLi47nuECLwaGYaK99GF9XN2btulVwrfl00AiDoFar+a1wfLBgu2oEF7
         oWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eSk9ZIII9ve+HiZZ6aR0Kr7ZvXDd9PcgJdMXThbLDKc=;
        b=j7QqsbVArp1O4cnIzZafzVvsYzrcFQdrw0GQEtNBnX4xgAOBugABKceTM0y9OTVHpJ
         hd/ssMLQWXrKyQjFp0C1mGfSFkU47IGuOmFmLBvooqigSF9ld4lbYpw7qvCqiFf66CoG
         ZHDQD6LyjOUuAOM8SgMmJXQKX1CnnlOkGsuvzpBRXDiCs1+R5PLU+siaXeZrW062oYXT
         eK1WNPckVYaLuoIyb2cOf8ZmlpIz1YLmwp1eUXl9C1PvH9iywDwcBdgZNmvpbYcqtHrc
         rX/jXxKw52bX0Ae6iD7VjAXtcysRsw8+Mc7S4cH3hNMHVJV18VAMWTZw/2mAj5yCSFcV
         kwXA==
X-Gm-Message-State: APjAAAUFoLkBVSgJ46Xc1YhWSCH/DToriGjoYpyEHpvTx/PJ0wBs+fUR
        KEGcHOuFX54/yW7M871iuXU=
X-Google-Smtp-Source: APXvYqy/KOdUUpK+G2ttnM3H+QsQNYluyrEqwVfe0LPSKv922VM/I02YlFIRNKGTRApAqfTZa1yt+w==
X-Received: by 2002:a63:2943:: with SMTP id p64mr17066195pgp.98.1570473824669;
        Mon, 07 Oct 2019 11:43:44 -0700 (PDT)
Received: from localhost.localdomain (155-97-232-235.usahousing.utah.edu. [155.97.232.235])
        by smtp.googlemail.com with ESMTPSA id e10sm19201271pfh.77.2019.10.07.11.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 11:43:44 -0700 (PDT)
From:   Tuowen Zhao <ztuowen@gmail.com>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com,
        acelan.kao@canonical.com, bhelgaas@google.com,
        kai.heng.feng@canonical.com, mcgrof@kernel.org,
        Tuowen Zhao <ztuowen@gmail.com>
Subject: [PATCH v2] mfd: intel-lpss: use devm_ioremap_uc for MMIO
Date:   Mon,  7 Oct 2019 12:42:31 -0600
Message-Id: <20191007184231.13256-1-ztuowen@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some BIOS erroneously specifies write-combining BAR for intel-lpss-pci
in MTRR. This will cause the system to hang during boot. If possible,
this bug could be corrected with a firmware update.

This patch adds devm_ioremap_uc as a new managed wrapper to ioremap_uc
and with it overwrite the MTRR settings to force the use of strongly
uncachable pages for intel-lpss.

The BIOS bug is present on Dell XPS 13 7390 2-in-1:

[    0.001734]   5 base 4000000000 mask 6000000000 write-combining

4000000000-7fffffffff : PCI Bus 0000:00
  4000000000-400fffffff : 0000:00:02.0 (i915)
  4010000000-4010000fff : 0000:00:15.0 (intel-lpss-pci)

Link: https://bugzilla.kernel.org/show_bug.cgi?id=203485
Signed-off-by: Tuowen Zhao <ztuowen@gmail.com>
---
Changes from previous version:

  * changed commit message

 drivers/mfd/intel-lpss.c |  2 +-
 include/linux/io.h       |  2 ++
 lib/devres.c             | 19 +++++++++++++++++++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/intel-lpss.c b/drivers/mfd/intel-lpss.c
index bfe4ff337581..b0f0781a6b9c 100644
--- a/drivers/mfd/intel-lpss.c
+++ b/drivers/mfd/intel-lpss.c
@@ -384,7 +384,7 @@ int intel_lpss_probe(struct device *dev,
 	if (!lpss)
 		return -ENOMEM;
 
-	lpss->priv = devm_ioremap(dev, info->mem->start + LPSS_PRIV_OFFSET,
+	lpss->priv = devm_ioremap_uc(dev, info->mem->start + LPSS_PRIV_OFFSET,
 				  LPSS_PRIV_SIZE);
 	if (!lpss->priv)
 		return -ENOMEM;
diff --git a/include/linux/io.h b/include/linux/io.h
index accac822336a..a59834bc0a11 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -64,6 +64,8 @@ static inline void devm_ioport_unmap(struct device *dev, void __iomem *addr)
 
 void __iomem *devm_ioremap(struct device *dev, resource_size_t offset,
 			   resource_size_t size);
+void __iomem *devm_ioremap_uc(struct device *dev, resource_size_t offset,
+				   resource_size_t size);
 void __iomem *devm_ioremap_nocache(struct device *dev, resource_size_t offset,
 				   resource_size_t size);
 void __iomem *devm_ioremap_wc(struct device *dev, resource_size_t offset,
diff --git a/lib/devres.c b/lib/devres.c
index 6a0e9bd6524a..beb0a064b891 100644
--- a/lib/devres.c
+++ b/lib/devres.c
@@ -9,6 +9,7 @@
 enum devm_ioremap_type {
 	DEVM_IOREMAP = 0,
 	DEVM_IOREMAP_NC,
+	DEVM_IOREMAP_UC,
 	DEVM_IOREMAP_WC,
 };
 
@@ -39,6 +40,9 @@ static void __iomem *__devm_ioremap(struct device *dev, resource_size_t offset,
 	case DEVM_IOREMAP_NC:
 		addr = ioremap_nocache(offset, size);
 		break;
+	case DEVM_IOREMAP_UC:
+		addr = ioremap_uc(offset, size);
+		break;
 	case DEVM_IOREMAP_WC:
 		addr = ioremap_wc(offset, size);
 		break;
@@ -68,6 +72,21 @@ void __iomem *devm_ioremap(struct device *dev, resource_size_t offset,
 }
 EXPORT_SYMBOL(devm_ioremap);
 
+/**
+ * devm_ioremap_uc - Managed ioremap_uc()
+ * @dev: Generic device to remap IO address for
+ * @offset: Resource address to map
+ * @size: Size of map
+ *
+ * Managed ioremap_uc().  Map is automatically unmapped on driver detach.
+ */
+void __iomem *devm_ioremap_uc(struct device *dev, resource_size_t offset,
+			      resource_size_t size)
+{
+	return __devm_ioremap(dev, offset, size, DEVM_IOREMAP_UC);
+}
+EXPORT_SYMBOL(devm_ioremap_uc);
+
 /**
  * devm_ioremap_nocache - Managed ioremap_nocache()
  * @dev: Generic device to remap IO address for
-- 
2.23.0

