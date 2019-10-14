Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149A6C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 15:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE9232067B
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 15:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFGg2+aa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730929AbfJNPgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 11:36:10 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45347 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730550AbfJNPgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 11:36:10 -0400
Received: by mail-pg1-f194.google.com with SMTP id r1so9135565pgj.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 08:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0JzEuZMgcTnB+W99wjyXU7kcGAiddB4Jt5OmZBJQues=;
        b=KFGg2+aadsAmkO3VWYUHKbDZQKie2khKxl5ymHoPu+WG6BiC0fE9TrdzOu+dUoobwd
         +xATgnVFzGGDCatQ12ESIkgqj/BnyfoEiPOsVYWlDo/M71ahNiDeI4Y2c6My5APAcrMy
         Llvq9S3dWaV/yaiIlTjZhMWS8jSamcJAFZ0o1tDlx2gy0beNE/31LGFh1ss0Zj7vhD4L
         DO6bPXLsWL5ubMwzymxtD1/QBKRWSSQovnC9eNvIVsI8nWxCN8Vac2LOx5ckaLbNv9Rq
         w1Ps1TNcmmF3IE1QNBLkohY4XEWOOZ+hs/bBJAcm4BjhT3ZFjmDiU4PqLd3N81VBzXrv
         PaDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0JzEuZMgcTnB+W99wjyXU7kcGAiddB4Jt5OmZBJQues=;
        b=fad0yxPyf4RuzsfY4JKVMH0kJ/WVNy1NXVE33dltketAk1qhdcdiw1i88loHq3O33m
         fmG7JSRtNpiOuuFUi6E4K/inqpk9ghfawssyQhyyU1+ITMDxGUXrDsRuQiFJphoJMmcq
         jPD4B0Dn4MsTxJtehNvbSUvffQ2Vsi73SOFfxlDuuJMVtHQSd28JiqndL4PshkYEixqb
         qtLhJX36+/LymqGq18bAgKFenwH/jLvgu3GA/03WFq1Jly1icMIaJCeYWbXObWOS6pqC
         k5JaLgOwnwei3Hup43d0yE3JXn+n8renjAg+kZbJ+8wYN5IM2IMrufQxcAOcJHn2bGSf
         HQIw==
X-Gm-Message-State: APjAAAXMY6PoD+Fjv27v8YL7itIa6LGxWrHVqXUAQX+CazdNsZBsStnQ
        AwBBszYngZ8RrNY0uKITsivkOvyGpnY=
X-Google-Smtp-Source: APXvYqzjIlrwg+aThNX7ZKbiBHS5SUDfO/Om8705QI56Jee14JSd4k5+4q9tUD/9ZhgR76MaAbylCA==
X-Received: by 2002:a63:d50c:: with SMTP id c12mr12148168pgg.199.1571067369278;
        Mon, 14 Oct 2019 08:36:09 -0700 (PDT)
Received: from localhost.localdomain (155-97-232-235.usahousing.utah.edu. [155.97.232.235])
        by smtp.googlemail.com with ESMTPSA id q76sm41142648pfc.86.2019.10.14.08.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 08:36:08 -0700 (PDT)
From:   Tuowen Zhao <ztuowen@gmail.com>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Cc:     Tuowen Zhao <ztuowen@gmail.com>,
        AceLan Kao <acelan.kao@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v4 1/2] lib: devres: add a helper function for ioremap_uc
Date:   Mon, 14 Oct 2019 09:33:43 -0600
Message-Id: <20191014153344.8996-1-ztuowen@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement a resource managed strongly uncachable ioremap function.

Cc: <stable@vger.kernel.org>
Tested-by: AceLan Kao <acelan.kao@canonical.com>
Signed-off-by: Tuowen Zhao <ztuowen@gmail.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Luis Chamberlain <mcgrof@kernel.org>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
Changes from previous version:

  * Add Cc stable

 .../driver-api/driver-model/devres.rst        |  1 +
 include/linux/io.h                            |  2 ++
 lib/devres.c                                  | 19 +++++++++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index a100bef54952..92628fdc2f11 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -314,6 +314,7 @@ IOMAP
   devm_ioport_unmap()
   devm_ioremap()
   devm_ioremap_nocache()
+  devm_ioremap_uc()
   devm_ioremap_wc()
   devm_ioremap_resource() : checks resource, requests memory region, ioremaps
   devm_iounmap()
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
index 6a0e9bd6524a..17624d35e82d 100644
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
+EXPORT_SYMBOL_GPL(devm_ioremap_uc);
+
 /**
  * devm_ioremap_nocache - Managed ioremap_nocache()
  * @dev: Generic device to remap IO address for
-- 
2.23.0

