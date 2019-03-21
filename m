Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E461C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB31C218FC
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ri9YpE7M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbfCUUXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 16:23:07 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38719 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728316AbfCUUXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 16:23:07 -0400
Received: by mail-wm1-f68.google.com with SMTP id a188so83890wmf.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 13:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:reply-to:mime-version
         :content-transfer-encoding;
        bh=w7lxoTd4kVgM2zOdMAkdgeIpfs/YgHMQ3SvnK05tK7E=;
        b=ri9YpE7Mda7HLxRsJl7yOhgIE4ztk0wIdPMecQGObQQdCj4BZE2g4g5embtjjHeICg
         gQ0tW95TF7CH9O7IN5xPqYS4ZlDTOB39lCWF2U23KUECiEX2GLE9qleS50IZnVWc2Vaq
         h63Z3L+DlqbnA/OK38Vbk8YAI5GDl/0bDMD5p/UCNUQl3VQxeB46hdjM1eTa46dErPAw
         lrvZkhNHvvUkM0SJgp1SXZmndAM/6GYk1zEi5mlAIAwQ6JT1VG7ErU3SgvoQR9gQOIgB
         0cp+4dvnzpzZCgYztY4oaEcFEXZPYy9a7L8psvK1o0kzSfm4cZLB9L+RPxzuJPD4HqDp
         HJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :mime-version:content-transfer-encoding;
        bh=w7lxoTd4kVgM2zOdMAkdgeIpfs/YgHMQ3SvnK05tK7E=;
        b=hyHqqBT07NtSh72+p0YeCYH/qdkyd1HaYCDWNWwc74b52T14UIrXjcP1JQDfTfOCb/
         IauR8wIYPlsuNDY33gmIdAl3VtjKVGI6uFH/h9rz+MianpjtUIlzkvJILZvRoISoLZ+B
         1UVufH7m7cN42TfFc86i3L+KcmdX5EatY6D7H+3ECgXZMsr9dCF7iQhxbBRnMuLVTdZ+
         cmClz+L5Ttfq6ukGvdpLTtreeYJujEAefi9Z4cEfMk/74LvVu9WvgmgN491aHfh8FQdK
         HSv48/epNiUqDoPmdzTzNN4Zhz97vMDZakxyaxGdiIzyD21yF0z8MDkqHxzaUEV8Ylpl
         kqAg==
X-Gm-Message-State: APjAAAXc+X5uWsTpGPrmmhAelhP4MK/3qYztTHU9mcWgzCTFQoWOXeSJ
        DcBE4Y5T7sg3Zx1NtKVkRWh2ndbtz54=
X-Google-Smtp-Source: APXvYqxgHWd5aoksSGpHUncdjX0VrYZfQSB5JW/UrghNmWTIBreJBY+Bp1bWJyL6fupeknwUe9Jr2g==
X-Received: by 2002:a1c:21c1:: with SMTP id h184mr704128wmh.128.1553199784181;
        Thu, 21 Mar 2019 13:23:04 -0700 (PDT)
Received: from p200300EEEE2F.fritz.box (p200300C987214D00743638A947E91BBA.dip0.t-ipconnect.de. [2003:c9:8721:4d00:7436:38a9:47e9:1bba])
        by smtp.gmail.com with ESMTPSA id a10sm10170803wrs.19.2019.03.21.13.23.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 13:23:03 -0700 (PDT)
From:   Emanuel Bennici <benniciemanuel78@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Joe Perches <joe@perches.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        NeilBrown <neil@brown.name>,
        Mamta Shukla <mamtashukla555@gmail.com>
Subject: [PATCH] staging: mt7621-pci: Add spaces to Macros in pci-mt7621.c
Date:   Thu, 21 Mar 2019 21:22:56 +0100
Message-Id: <20190321202301.806-1-benniciemanuel78@gmail.com>
X-Mailer: git-send-email 2.19.1
Reply-To: benniciemanuel78@gmail.com
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apply Kernel Coding Style to pci-mt7621.c by adding Tabs

Signed-off-by: Emanuel Bennici <benniciemanuel78@gmail.com>
---
 drivers/staging/mt7621-pci/pci-mt7621.c | 70 ++++++++++++-------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/staging/mt7621-pci/pci-mt7621.c b/drivers/staging/mt7621-pci/pci-mt7621.c
index 379ae780c691..c5d9b7204aef 100644
--- a/drivers/staging/mt7621-pci/pci-mt7621.c
+++ b/drivers/staging/mt7621-pci/pci-mt7621.c
@@ -34,16 +34,16 @@
 #include "../../pci/pci.h"
 
 /* sysctl */
-#define MT7621_CHIP_REV_ID		0x0c
-#define CHIP_REV_MT7621_E2		0x0101
+#define MT7621_CHIP_REV_ID			0x0c
+#define CHIP_REV_MT7621_E2			0x0101
 
 /* MediaTek specific configuration registers */
-#define PCIE_FTS_NUM			0x70c
-#define PCIE_FTS_NUM_MASK		GENMASK(15, 8)
-#define PCIE_FTS_NUM_L0(x)		((x) & 0xff << 8)
+#define PCIE_FTS_NUM				0x70c
+#define PCIE_FTS_NUM_MASK			GENMASK(15, 8)
+#define PCIE_FTS_NUM_L0(x)			((x) & 0xff << 8)
 
 /* rt_sysc_membase relative registers */
-#define RALINK_PCIE_CLK_GEN		0x7c
+#define RALINK_PCIE_CLK_GEN			0x7c
 #define RALINK_PCIE_CLK_GEN1		0x80
 
 /* Host-PCI bridge registers */
@@ -51,44 +51,44 @@
 #define RALINK_PCI_PCIMSK_ADDR		0x000C
 #define RALINK_PCI_CONFIG_ADDR		0x0020
 #define RALINK_PCI_CONFIG_DATA		0x0024
-#define RALINK_PCI_MEMBASE		0x0028
-#define RALINK_PCI_IOBASE		0x002C
+#define RALINK_PCI_MEMBASE			0x0028
+#define RALINK_PCI_IOBASE			0x002C
 
 /* PCICFG virtual bridges */
-#define MT7621_BR0_MASK			GENMASK(19, 16)
-#define MT7621_BR1_MASK			GENMASK(23, 20)
-#define MT7621_BR2_MASK			GENMASK(27, 24)
-#define MT7621_BR_ALL_MASK		GENMASK(27, 16)
-#define MT7621_BR0_SHIFT		16
-#define MT7621_BR1_SHIFT		20
-#define MT7621_BR2_SHIFT		24
+#define MT7621_BR0_MASK				GENMASK(19, 16)
+#define MT7621_BR1_MASK				GENMASK(23, 20)
+#define MT7621_BR2_MASK				GENMASK(27, 24)
+#define MT7621_BR_ALL_MASK			GENMASK(27, 16)
+#define MT7621_BR0_SHIFT			16
+#define MT7621_BR1_SHIFT			20
+#define MT7621_BR2_SHIFT			24
 
 /* PCIe RC control registers */
-#define MT7621_PCIE_OFFSET		0x2000
-#define MT7621_NEXT_PORT		0x1000
+#define MT7621_PCIE_OFFSET			0x2000
+#define MT7621_NEXT_PORT			0x1000
 
 #define RALINK_PCI_BAR0SETUP_ADDR	0x0010
 #define RALINK_PCI_IMBASEBAR0_ADDR	0x0018
-#define RALINK_PCI_ID			0x0030
-#define RALINK_PCI_CLASS		0x0034
-#define RALINK_PCI_SUBID		0x0038
-#define RALINK_PCI_STATUS		0x0050
+#define RALINK_PCI_ID				0x0030
+#define RALINK_PCI_CLASS			0x0034
+#define RALINK_PCI_SUBID			0x0038
+#define RALINK_PCI_STATUS			0x0050
 
 /* Some definition values */
-#define PCIE_REVISION_ID		BIT(0)
-#define PCIE_CLASS_CODE			(0x60400 << 8)
-#define PCIE_BAR_MAP_MAX		GENMASK(30, 16)
-#define PCIE_BAR_ENABLE			BIT(0)
-#define PCIE_PORT_INT_EN(x)		BIT(20 + (x))
-#define PCIE_PORT_CLK_EN(x)		BIT(24 + (x))
-#define PCIE_PORT_PERST(x)		BIT(1 + (x))
-#define PCIE_PORT_LINKUP		BIT(0)
-
-#define PCIE_CLK_GEN_EN			BIT(31)
-#define PCIE_CLK_GEN_DIS		0
-#define PCIE_CLK_GEN1_DIS		GENMASK(30, 24)
-#define PCIE_CLK_GEN1_EN		(BIT(27) | BIT(25))
-#define MEMORY_BASE			0x0
+#define PCIE_REVISION_ID			BIT(0)
+#define PCIE_CLASS_CODE				(0x60400 << 8)
+#define PCIE_BAR_MAP_MAX			GENMASK(30, 16)
+#define PCIE_BAR_ENABLE				BIT(0)
+#define PCIE_PORT_INT_EN(x)			BIT(20 + (x))
+#define PCIE_PORT_CLK_EN(x)			BIT(24 + (x))
+#define PCIE_PORT_PERST(x)			BIT(1 + (x))
+#define PCIE_PORT_LINKUP			BIT(0)
+
+#define PCIE_CLK_GEN_EN				BIT(31)
+#define PCIE_CLK_GEN_DIS			0
+#define PCIE_CLK_GEN1_DIS			GENMASK(30, 24)
+#define PCIE_CLK_GEN1_EN			(BIT(27) | BIT(25))
+#define MEMORY_BASE					0x0
 
 /**
  * struct mt7621_pcie_port - PCIe port information
-- 
2.19.1

