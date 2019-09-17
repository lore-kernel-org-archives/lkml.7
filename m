Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556F1C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 14:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 242BA214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 14:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtq2O9sK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbfIQOcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 10:32:08 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34557 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbfIQOcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 10:32:07 -0400
Received: by mail-pg1-f196.google.com with SMTP id n9so2143051pgc.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 07:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8SUrqUEd8vhNQrC/UhQr9xGaonvbAM/B+mpfw/Rhjzs=;
        b=dtq2O9sKrO75cEIEu+YdsYP4ioxcIInMpQkLYsEJsng6xTiFCZiuhrn5QCnNfmL6jU
         72e543i04pnFy/CNhLfmBlC7d4PRYfGormxemji2+w+RD8Veu0OAJoGOhGvb7d3GistU
         x0x9BSuV3KJXcvoPfUQB3WFEWJVbHwsMrnreRA1c9+0hpWbmIuZQkECTnFLzA5t19JS4
         Y0TlxBptNV5EUygEMX+3ljLUZHETzqhTRj/dtMyfMMG3fbiKRNbJugwI2SLh8EhOMD39
         v71rqeoi8MLOS45GOJ4zxESGxSWLqaGabBxa3103IiSc46BYArkVMFbbL46blrJvy8xx
         UYbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8SUrqUEd8vhNQrC/UhQr9xGaonvbAM/B+mpfw/Rhjzs=;
        b=XtEXRa3gyFwgNdItyYhJr7Z9r8c2f5ORbhK89SW2ACqWRWYsdam3ZqoJqK/49mvWLY
         xdLRUiE4wnzMjxYDVUYIFKel9HtJ9RMwazq4F2B8AEQoiYc5o0AUBh0FMdJktEtUfw9Z
         q7fXg4qWcnRsETh0PansuiQ4vRPPiUWeKNItjknFEGpafv5+OiXaZPGo0D/cEH3FRM8b
         IDgabH0XMY2e/VKGdPRGiNNY6yiVWywVwkxJiCyJ/CD3W7rhFkpdITYjMaxCYR8JlBsI
         jBSXVTECRAlTKWe6zxXEJz1FHWEg0Vxfa3ETxiqYXTQTVO2MKkAwLtHushqiVNby3ba7
         QVcQ==
X-Gm-Message-State: APjAAAUalp3Q0ITXjuQlTPG/guNES9Ck43ZS/EOdAWFRD+ta7chGvAo0
        C5yjYTW3GPLXhA04j9+DVWU=
X-Google-Smtp-Source: APXvYqy472moAZ9uDaULskoS3Ol1soIvaM24WFqIFB3L85JOB7yXFaGSnQBICSQYnApViT6D3mKIRQ==
X-Received: by 2002:a62:61c5:: with SMTP id v188mr4671549pfb.194.1568730726902;
        Tue, 17 Sep 2019 07:32:06 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1951:77d6:cd84:5e38:4d0a:8c08])
        by smtp.gmail.com with ESMTPSA id s7sm2520335pjr.23.2019.09.17.07.32.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Sep 2019 07:32:06 -0700 (PDT)
From:   Aliasgar Surti <aliasgar.surti500@gmail.com>
X-Google-Original-From: Aliasgar Surti
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Aliasgar Surti <aliasgar.surti500@gmail.com>
Subject: [PATCH] drivers:staging:rtl8723bs: Removed unneeded variables
Date:   Tue, 17 Sep 2019 20:01:31 +0530
Message-Id: <1568730691-954-1-git-send-email-aliasgar.surti500@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aliasgar Surti <aliasgar.surti500@gmail.com>

coccicheck reported warning for unneeded variable used.

This patch removes the unneeded variables.

Signed-off-by: Aliasgar Surti <aliasgar.surti500@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index d1b199e..fa3ffc3 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -2428,8 +2428,7 @@ static  int rtw_drvext_hdl(struct net_device *dev, struct iw_request_info *info,
 static int rtw_mp_ioctl_hdl(struct net_device *dev, struct iw_request_info *info,
 						union iwreq_data *wrqu, char *extra)
 {
-	int ret = 0;
-	return ret;
+	return 0;
 }
 
 static int rtw_get_ap_info(struct net_device *dev,
@@ -4462,24 +4461,21 @@ static int rtw_mp_efuse_get(struct net_device *dev,
 			struct iw_request_info *info,
 			union iwreq_data *wdata, char *extra)
 {
-	int err = 0;
-	return err;
+	return 0;
 }
 
 static int rtw_mp_efuse_set(struct net_device *dev,
 			struct iw_request_info *info,
 			union iwreq_data *wdata, char *extra)
 {
-	int err = 0;
-	return err;
+	return 0;
 }
 
 static int rtw_tdls(struct net_device *dev,
 				struct iw_request_info *info,
 				union iwreq_data *wrqu, char *extra)
 {
-	int ret = 0;
-	return ret;
+	return 0;
 }
 
 
@@ -4487,8 +4483,7 @@ static int rtw_tdls_get(struct net_device *dev,
 				struct iw_request_info *info,
 				union iwreq_data *wrqu, char *extra)
 {
-	int ret = 0;
-	return ret;
+	return 0;
 }
 
 
-- 
2.7.4

