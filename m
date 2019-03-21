Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB7AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 13:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD8C721901
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 13:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eqt07IO2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbfCUNTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 09:19:33 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44860 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728284AbfCUNTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 09:19:32 -0400
Received: by mail-lj1-f195.google.com with SMTP id n18so5209747ljg.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 06:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9vEE+IWH1UQ/MYCPFbtRTwD8BWeX2JpFTXYc7Ro5vRA=;
        b=eqt07IO2L+GP5NlWtP6wSmasOxMFMm6uR9nrBOshubebkmUQJxXFY2AOn7j8Q5z47f
         WjiRwX6XPBzhPrf7NJnjmC4TLiFg1X3tz8gObiG/6xHvWu0UjA9KdvMY/CnS1/5oSyB1
         cXsV4Xdgx7HMN3A2JcOhNwfBhQTAn2SY6n9TJrMi0g1swSoxjwIUwZo3OWyb1VN9Qza4
         zTNt/ByTGPSifxMDwZNb+30+py3F3OyJZfcUQz0FPgIKe+qZymYwlqVImwKvnH0WiOun
         S1mLNyNxc2bNxc5YZG/s//EmqFebCuUOTn55wDxE8WJjKjaX7EMmVr1YuPPp2p3CZLvj
         CQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9vEE+IWH1UQ/MYCPFbtRTwD8BWeX2JpFTXYc7Ro5vRA=;
        b=TdNzv6SLs3x665yDv6YpwPdz3ijmoT4ynIqCs7Krzc29JfyQtgLAfbsNWKx5WQXh6u
         IAQGH8Ybi2G6F9kuLAEEXbOe6bD93dQrQqvbJuYj8BMia+Z7bA8f2hNYqxaEpICq3f/l
         PQWIOC79tu7QiOseMkb4oj1Im4bam05669BhjV1Kb+1tN7kiUBrttBhvVtU6MJ/77Ubq
         kfWIGRvRku6MY60b9W86SSkJAKC9vvk25LLtAqj8Qjh5VxcIry3InH457KSXrT3B7m4O
         LzZ2YId1v68Z6pRWH0fMy7p+xFDbBAhrtP+s/PPwWXgNBeEe5F811s+PJn2ekuhjvpAs
         9wag==
X-Gm-Message-State: APjAAAXrDUWM5AgfFz3Mbv0wesaBPy+n6o+0mCrz5tsebjnrUHBs4qIB
        n/9/sbPLuFI0JX4wFbl8fkmzWw==
X-Google-Smtp-Source: APXvYqxlhvHaT9akV8SGIwO9h7EwW9p75tBnryeDP9GZ3dd3qD480c5vKuE0KNx5SQBBATXMYE1/ew==
X-Received: by 2002:a2e:97d3:: with SMTP id m19mr2020201ljj.63.1553174370161;
        Thu, 21 Mar 2019 06:19:30 -0700 (PDT)
Received: from localhost (c-573670d5.07-21-73746f28.bbcust.telenor.se. [213.112.54.87])
        by smtp.gmail.com with ESMTPSA id i66sm840726lji.43.2019.03.21.06.19.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 06:19:29 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        matthias.bgg@gmail.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] scsi: ufs-mediatek: fix uninitialized variable
Date:   Thu, 21 Mar 2019 14:19:25 +0100
Message-Id: <20190321131925.27421-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building the ufs-mediatek driver variable 'ret' may be used
uninitialized.

../drivers/scsi/ufs/ufs-mediatek.c: In function ‘ufs_mtk_setup_clocks’:
../drivers/scsi/ufs/ufs-mediatek.c:96:6: warning: ‘ret’ may be used uninitialized in this function [-Wmaybe-uninitialized]
  int ret;
      ^~~

Rework to return directly instead of using a local variable 'ret'.

Fixes: ddd90623ce26 ("scsi: ufs-mediatek: Add UFS support for Mediatek SoC chips")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/scsi/ufs/ufs-mediatek.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/ufs/ufs-mediatek.c b/drivers/scsi/ufs/ufs-mediatek.c
index ce4767784937..330d68871b06 100644
--- a/drivers/scsi/ufs/ufs-mediatek.c
+++ b/drivers/scsi/ufs/ufs-mediatek.c
@@ -93,7 +93,6 @@ static int ufs_mtk_setup_clocks(struct ufs_hba *hba, bool on,
 				enum ufs_notify_change_status status)
 {
 	struct ufs_mtk_host *host = ufshcd_get_variant(hba);
-	int ret;
 
 	/*
 	 * In case ufs_mtk_init() is not yet done, simply ignore.
@@ -106,18 +105,18 @@ static int ufs_mtk_setup_clocks(struct ufs_hba *hba, bool on,
 	switch (status) {
 	case PRE_CHANGE:
 		if (!on)
-			ret = phy_power_off(host->mphy);
+			return phy_power_off(host->mphy);
 		break;
 	case POST_CHANGE:
 		if (on)
-			ret = phy_power_on(host->mphy);
+			return phy_power_on(host->mphy);
 		break;
 	default:
-		ret = -EINVAL;
+		return -EINVAL;
 		break;
 	}
 
-	return ret;
+	return 0;
 }
 
 /**
-- 
2.20.1

