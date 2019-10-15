Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E22ECE58F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 22:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 415FC205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 22:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MiDaGBSU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390018AbfJOWpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 18:45:55 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36868 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732531AbfJOWpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 18:45:54 -0400
Received: by mail-pl1-f194.google.com with SMTP id u20so10291616plq.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 15:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NszovcrmeizweFufzZjrkW8f6hhK6QnYuVsht4WHchE=;
        b=MiDaGBSUt8KaxANsMCLt/lqC4wjaFlMnpMkUl7eV8BUrp00yAkHdwbpj1MErqfLbtd
         IGrR5a5ucjrZ0ZgOFLgMqVDre1osREK130TeFuIfWhqNhOqezR7cbbCrsvot70LZah4f
         ekQWx4vDVJkOHSiuYF12fYV/JxInqNfT6FcCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NszovcrmeizweFufzZjrkW8f6hhK6QnYuVsht4WHchE=;
        b=K7cnXUXUYfxzmGupoHXfh2EEF7nfYSNHJJ3EflG7/ZV9ncaZthPb4YVZwfk34ssUCi
         TuOx8F+qkRyiEvdK3GiC/OdSY01fcnrmy8ALbbYKe/oFVLAZCX/SdK3G6McHPfXB61De
         vH9lQt4pyY0i5eZ9JMiVKzrK/sP8rVPmiaIYYdn85mg2JRcGQnAIwOYqjZdOOn8emFPF
         FuxwkFcVTT+ScPEWNvz9UetDmF0GzcG3DhyZljk7qK4hjFMzGTCNXh/MGH7F+8jNk45n
         2aozwe2CCdE0cdqPMWbm80dvvzLWaYDTM1UN3MeFSunovpIQ55HK+6Embv5o1rviHv6t
         n3cA==
X-Gm-Message-State: APjAAAX/3KKwGdLnsD5izN5SUZNFCPkzwJ/C2/f6LC3Fg3Ae60zv0Qn0
        pKsZlGTTEOqFPQjwQi9DdrOcFg==
X-Google-Smtp-Source: APXvYqziY7vPjk2T010iyMGZDzq6jJCb4rzcDFVf3OVxNv8oL/5/7Ll+wdzceBfFHS9rEv4TmwI94g==
X-Received: by 2002:a17:902:d204:: with SMTP id t4mr35234943ply.253.1571179553270;
        Tue, 15 Oct 2019 15:45:53 -0700 (PDT)
Received: from lbrmn-mmayer.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id e127sm23019837pfe.37.2019.10.15.15.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 15:45:52 -0700 (PDT)
From:   Markus Mayer <mmayer@broadcom.com>
To:     Brian Norris <computersforpeace@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>
Cc:     Markus Mayer <mmayer@broadcom.com>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/8] memory: brcmstb: dpfe: rename struct private_data
Date:   Tue, 15 Oct 2019 15:45:06 -0700
Message-Id: <20191015224513.16969-2-mmayer@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191015224513.16969-1-mmayer@broadcom.com>
References: <20191015224513.16969-1-mmayer@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid potential (future) conflicts with other data structures we
rename "struct private_data" to "struct brcmstb_dpfe_priv".

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---
 drivers/memory/brcmstb_dpfe.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/memory/brcmstb_dpfe.c b/drivers/memory/brcmstb_dpfe.c
index 6827ed484750..0c4c01d2bf48 100644
--- a/drivers/memory/brcmstb_dpfe.c
+++ b/drivers/memory/brcmstb_dpfe.c
@@ -180,7 +180,7 @@ struct dpfe_api {
 };
 
 /* Things we need for as long as we are active. */
-struct private_data {
+struct brcmstb_dpfe_priv {
 	void __iomem *regs;
 	void __iomem *dmem;
 	void __iomem *imem;
@@ -343,7 +343,7 @@ static unsigned int get_msg_chksum(const u32 msg[], unsigned int max)
 	return sum;
 }
 
-static void __iomem *get_msg_ptr(struct private_data *priv, u32 response,
+static void __iomem *get_msg_ptr(struct brcmstb_dpfe_priv *priv, u32 response,
 				 char *buf, ssize_t *size)
 {
 	unsigned int msg_type;
@@ -382,7 +382,7 @@ static void __iomem *get_msg_ptr(struct private_data *priv, u32 response,
 	return ptr;
 }
 
-static void __finalize_command(struct private_data *priv)
+static void __finalize_command(struct brcmstb_dpfe_priv *priv)
 {
 	unsigned int release_mbox;
 
@@ -395,7 +395,7 @@ static void __finalize_command(struct private_data *priv)
 	writel_relaxed(0, priv->regs + release_mbox);
 }
 
-static int __send_command(struct private_data *priv, unsigned int cmd,
+static int __send_command(struct brcmstb_dpfe_priv *priv, unsigned int cmd,
 			  u32 result[])
 {
 	const u32 *msg = priv->dpfe_api->command[cmd];
@@ -517,7 +517,7 @@ static int __verify_firmware(struct init_data *init,
 
 /* Verify checksum by reading back the firmware from co-processor RAM. */
 static int __verify_fw_checksum(struct init_data *init,
-				struct private_data *priv,
+				struct brcmstb_dpfe_priv *priv,
 				const struct dpfe_firmware_header *header,
 				u32 checksum)
 {
@@ -578,7 +578,7 @@ static int brcmstb_dpfe_download_firmware(struct platform_device *pdev,
 	unsigned int dmem_size, imem_size;
 	struct device *dev = &pdev->dev;
 	bool is_big_endian = false;
-	struct private_data *priv;
+	struct brcmstb_dpfe_priv *priv;
 	const struct firmware *fw;
 	const u32 *dmem, *imem;
 	const void *fw_blob;
@@ -647,7 +647,7 @@ static int brcmstb_dpfe_download_firmware(struct platform_device *pdev,
 }
 
 static ssize_t generic_show(unsigned int command, u32 response[],
-			    struct private_data *priv, char *buf)
+			    struct brcmstb_dpfe_priv *priv, char *buf)
 {
 	int ret;
 
@@ -665,7 +665,7 @@ static ssize_t show_info(struct device *dev, struct device_attribute *devattr,
 			 char *buf)
 {
 	u32 response[MSG_FIELD_MAX];
-	struct private_data *priv;
+	struct brcmstb_dpfe_priv *priv;
 	unsigned int info;
 	ssize_t ret;
 
@@ -688,7 +688,7 @@ static ssize_t show_refresh(struct device *dev,
 {
 	u32 response[MSG_FIELD_MAX];
 	void __iomem *info;
-	struct private_data *priv;
+	struct brcmstb_dpfe_priv *priv;
 	u8 refresh, sr_abort, ppre, thermal_offs, tuf;
 	u32 mr4;
 	ssize_t ret;
@@ -721,7 +721,7 @@ static ssize_t store_refresh(struct device *dev, struct device_attribute *attr,
 			  const char *buf, size_t count)
 {
 	u32 response[MSG_FIELD_MAX];
-	struct private_data *priv;
+	struct brcmstb_dpfe_priv *priv;
 	void __iomem *info;
 	unsigned long val;
 	int ret;
@@ -747,7 +747,7 @@ static ssize_t show_vendor(struct device *dev, struct device_attribute *devattr,
 			   char *buf)
 {
 	u32 response[MSG_FIELD_MAX];
-	struct private_data *priv;
+	struct brcmstb_dpfe_priv *priv;
 	void __iomem *info;
 	ssize_t ret;
 	u32 mr5, mr6, mr7, mr8, err;
@@ -778,7 +778,7 @@ static ssize_t show_dram(struct device *dev, struct device_attribute *devattr,
 			 char *buf)
 {
 	u32 response[MSG_FIELD_MAX];
-	struct private_data *priv;
+	struct brcmstb_dpfe_priv *priv;
 	ssize_t ret;
 	u32 mr4, mr5, mr6, mr7, mr8, err;
 
@@ -808,7 +808,7 @@ static int brcmstb_dpfe_resume(struct platform_device *pdev)
 static int brcmstb_dpfe_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct private_data *priv;
+	struct brcmstb_dpfe_priv *priv;
 	struct init_data init;
 	struct resource *res;
 	int ret;
@@ -867,7 +867,7 @@ static int brcmstb_dpfe_probe(struct platform_device *pdev)
 
 static int brcmstb_dpfe_remove(struct platform_device *pdev)
 {
-	struct private_data *priv = dev_get_drvdata(&pdev->dev);
+	struct brcmstb_dpfe_priv *priv = dev_get_drvdata(&pdev->dev);
 
 	sysfs_remove_groups(&pdev->dev.kobj, priv->dpfe_api->sysfs_attrs);
 
-- 
2.17.1

