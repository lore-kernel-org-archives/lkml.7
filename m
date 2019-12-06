Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCF1C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 07:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F9112467B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 07:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFme/k2E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfLFHyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 02:54:44 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41160 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbfLFHyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 02:54:43 -0500
Received: by mail-pg1-f196.google.com with SMTP id x8so2897188pgk.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 23:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BCW5VMW21UdkUKTUCSUYd61ML4nHTS7PPrpSiynrJjw=;
        b=HFme/k2EqX2k998O/GLO4fdZ5etH0xf7xIgs2TLsf+M9Z7XMhH9XY3yZRYKYdE4d+E
         g3axjO1b7DNonM8DtkoK4CHOj+4sX1lRI7MdrpGWm0fJmenVTV5wuiEz9WgznOV4PQ/7
         KfuR25YvdYTGOpc9Sk73EPFCRi5ONvPW4zZ5NUD9pr+KnfqyTcCI4rdkg8eVqlUZiv23
         pjyW4dk4CVkXmz+oW9kRawRESVIaAGzrIYj3rqEgJiyoWeWdH1L2wSFZ2enVUSoS75ac
         uvJxobHDhR7AU/UC5ubmbTreqVw+KofVWr/rRFf4pG9CPNHQBoGZY/rg2dywKxsoqoCT
         pI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BCW5VMW21UdkUKTUCSUYd61ML4nHTS7PPrpSiynrJjw=;
        b=FDICra44f9JtgJq5jbxjuuKSLdbMIOP1tW53TTqPpln10yd8KuCB3kSd7KaqrV8nY9
         srNrPRJLXLL1VZKM4DuJtL/9VbifFehXb04o6ouLXINbDe435BpHVAC0KhgjOm43MlEq
         aHKoDlMblZgULLyms6+GLlfP8KV1ZrPjvnoWxs8gHVCSzmL5BLiWBuRllUQE170c0BO0
         2WykvnaD6W4z8+Zcrc2ytCEVZxkNHFsgWBgF2fti17qegqL0DXjN/5EWr+DbclmjltwH
         TZ7GmZQdpP58HQiRxf8bPduxDQdTKipswzdSscsKgnPYLKsC4ynA9zIHY8a8r6Yos77y
         lbVg==
X-Gm-Message-State: APjAAAVphb0Z1pd3XwBk/pPC6RQNTjiAIS98jCxQVDiWt+2vyTsD8QYx
        UBVUlVfo5yBvr9wlLZhmVL8=
X-Google-Smtp-Source: APXvYqyW+WX0JATiKms6lA2rPwM44L3R+y211/aEe34G6rjCIIEv/qUtnFeVuj1dH+SXVHd2zKtNXA==
X-Received: by 2002:a63:cb:: with SMTP id 194mr2080799pga.163.1575618883018;
        Thu, 05 Dec 2019 23:54:43 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id h5sm16159622pfk.30.2019.12.05.23.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 23:54:42 -0800 (PST)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] mtd: rawnand: denali: add missed pci_release_regions
Date:   Fri,  6 Dec 2019 15:54:32 +0800
Message-Id: <20191206075432.18412-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver forgets to call pci_release_regions() in probe failure
and remove.
Add the missed calls to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/mtd/nand/raw/denali_pci.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/denali_pci.c b/drivers/mtd/nand/raw/denali_pci.c
index d62aa5271753..ca170775b141 100644
--- a/drivers/mtd/nand/raw/denali_pci.c
+++ b/drivers/mtd/nand/raw/denali_pci.c
@@ -77,7 +77,8 @@ static int denali_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	denali->reg = ioremap_nocache(csr_base, csr_len);
 	if (!denali->reg) {
 		dev_err(&dev->dev, "Spectra: Unable to remap memory region\n");
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto out_release_regions;
 	}
 
 	denali->host = ioremap_nocache(mem_base, mem_len);
@@ -121,6 +122,8 @@ static int denali_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	iounmap(denali->host);
 out_unmap_reg:
 	iounmap(denali->reg);
+out_release_regions:
+	pci_release_regions(dev);
 	return ret;
 }
 
@@ -131,6 +134,7 @@ static void denali_pci_remove(struct pci_dev *dev)
 	denali_remove(denali);
 	iounmap(denali->reg);
 	iounmap(denali->host);
+	pci_release_regions(dev);
 }
 
 static struct pci_driver denali_pci_driver = {
-- 
2.24.0

