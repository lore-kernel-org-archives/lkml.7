Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FA7ECE59D
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 22:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9361214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 22:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="P/6kQXWl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390081AbfJOWq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 18:46:27 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40992 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390034AbfJOWq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 18:46:27 -0400
Received: by mail-pf1-f196.google.com with SMTP id q7so13389703pfh.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 15:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jXQ75x3Ps6GKpsIMo1SWrSaRFPmKSk32GCzqs7+6pe0=;
        b=P/6kQXWlOVCud1voSqRWZ+Q/FLISCfhEcnxzA1kQKJBuCMXO3i9Zrl9aEwLxWdOHrn
         Hy78y71wBm+lQ0ztuVByjQajuH31n26CRI2gvQ6nSd4xxj1K+YfMvD8pQkdMpkv2Y+Su
         WIYo5QbTuLi3r74m3PriwuqO/9pxcshaHFHV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jXQ75x3Ps6GKpsIMo1SWrSaRFPmKSk32GCzqs7+6pe0=;
        b=G89WeAVPIQQpB7aIcdT0I3zcUOOTqczfaHo07Wk6cBWR8uyRzSr6lLiWMFMUEV/1cO
         94H2PbE4y+XIkZfs9SOMlU7yUlD8tEFCXuouvV2opb6sRZH1UqhE/YdM1QA1aTCt4CVy
         rUDEMSCezZ8c/pSCo9D/1ax9Zb6CsB1jc44xkahRBP/+c/l7hGdwg8aYijV6/HSE5JCA
         q8KsW1AkJJBXI1NuHJrqubZiFfl6aDyssvhzNx0cPf/OAplgdukdRMaA+6Ez4Gbyj1W8
         SJEMH+hyg9om6i2k73sXsGLPeBrlG6an+IRssu/zjEu6anLiZC0wha2MKBnOQv9QlCRd
         X1jA==
X-Gm-Message-State: APjAAAU2hNq68CusLXnoAb24/MpohuUwyxyBklU3IIFQnAT9tExInSH0
        iaVwxsyIihVBBksZrnXpz+vKzQ==
X-Google-Smtp-Source: APXvYqz6KU+gZooUfpIuIvHLXB5oT6CJz5gH5+PNxONK8L4zbzs3zv6sB2RgKCXackqTvUGhM5Mpkg==
X-Received: by 2002:a63:2f84:: with SMTP id v126mr40879644pgv.100.1571179586096;
        Tue, 15 Oct 2019 15:46:26 -0700 (PDT)
Received: from lbrmn-mmayer.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id e127sm23019837pfe.37.2019.10.15.15.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 15:46:25 -0700 (PDT)
From:   Markus Mayer <mmayer@broadcom.com>
To:     Brian Norris <computersforpeace@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>
Cc:     Markus Mayer <mmayer@broadcom.com>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/8] memory: brcmstb: dpfe: move init_data into brcmstb_dpfe_download_firmware()
Date:   Tue, 15 Oct 2019 15:45:09 -0700
Message-Id: <20191015224513.16969-5-mmayer@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191015224513.16969-1-mmayer@broadcom.com>
References: <20191015224513.16969-1-mmayer@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than declaring our init_data in several places and passing it as
parameter into brcmstb_dpfe_download_firmware(), we declare it inside
brcmstb_dpfe_download_firmware() instead.

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---
 drivers/memory/brcmstb_dpfe.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/memory/brcmstb_dpfe.c b/drivers/memory/brcmstb_dpfe.c
index c10c24a76729..3b61e7108912 100644
--- a/drivers/memory/brcmstb_dpfe.c
+++ b/drivers/memory/brcmstb_dpfe.c
@@ -582,8 +582,7 @@ static int __write_firmware(u32 __iomem *mem, const u32 *fw,
 	return 0;
 }
 
-static int brcmstb_dpfe_download_firmware(struct platform_device *pdev,
-					  struct init_data *init)
+static int brcmstb_dpfe_download_firmware(struct platform_device *pdev)
 {
 	const struct dpfe_firmware_header *header;
 	unsigned int dmem_size, imem_size;
@@ -592,6 +591,7 @@ static int brcmstb_dpfe_download_firmware(struct platform_device *pdev,
 	struct brcmstb_dpfe_priv *priv;
 	const struct firmware *fw;
 	const u32 *dmem, *imem;
+	struct init_data init;
 	const void *fw_blob;
 	int ret;
 
@@ -622,15 +622,15 @@ static int brcmstb_dpfe_download_firmware(struct platform_device *pdev,
 	if (ret)
 		return ret;
 
-	ret = __verify_firmware(init, fw);
+	ret = __verify_firmware(&init, fw);
 	if (ret)
 		return -EFAULT;
 
 	__disable_dcpu(priv);
 
-	is_big_endian = init->is_big_endian;
-	dmem_size = init->dmem_len;
-	imem_size = init->imem_len;
+	is_big_endian = init.is_big_endian;
+	dmem_size = init.dmem_len;
+	imem_size = init.imem_len;
 
 	/* At the beginning of the firmware blob is a header. */
 	header = (struct dpfe_firmware_header *)fw->data;
@@ -648,7 +648,7 @@ static int brcmstb_dpfe_download_firmware(struct platform_device *pdev,
 	if (ret)
 		return ret;
 
-	ret = __verify_fw_checksum(init, priv, header, init->chksum);
+	ret = __verify_fw_checksum(&init, priv, header, init.chksum);
 	if (ret)
 		return ret;
 
@@ -811,16 +811,13 @@ static ssize_t show_dram(struct device *dev, struct device_attribute *devattr,
 
 static int brcmstb_dpfe_resume(struct platform_device *pdev)
 {
-	struct init_data init;
-
-	return brcmstb_dpfe_download_firmware(pdev, &init);
+	return brcmstb_dpfe_download_firmware(pdev);
 }
 
 static int brcmstb_dpfe_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct brcmstb_dpfe_priv *priv;
-	struct init_data init;
 	struct resource *res;
 	int ret;
 
@@ -864,7 +861,7 @@ static int brcmstb_dpfe_probe(struct platform_device *pdev)
 		return -ENOENT;
 	}
 
-	ret = brcmstb_dpfe_download_firmware(pdev, &init);
+	ret = brcmstb_dpfe_download_firmware(pdev);
 	if (ret) {
 		dev_err(dev, "Couldn't download firmware -- %d\n", ret);
 		return ret;
-- 
2.17.1

