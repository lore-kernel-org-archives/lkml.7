Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B35ECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 10:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B49AB2083B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 10:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="HyO5Tt59"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730245AbfJOKQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 06:16:20 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42299 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbfJOKQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 06:16:20 -0400
Received: by mail-pg1-f194.google.com with SMTP id f14so6734892pgi.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 03:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YyF2qg/Mhc4XEhGEeCU7TNWSjed5NzKyuCiBwgDTeok=;
        b=HyO5Tt59GXKnrGY+7LLGuEkSKL44f7b0LahkEZrWPyGOEgwfP9XhkgKA6vLMD1WZqX
         9NLdthg8oZNElo8bSkoMfzoO8e2rwSsxlVaxeBbj4tonHGiTfZG8UJfuUcYe4xQTc/3O
         b48BI9elpB7LeoPX4mxI15ORrtisztT+hKwLIjW1NrAeadOP6rgghtu5WaQdP7lkCq6B
         R+wdrxm4EJhh8GB3uhfhq4aDpFQ2mopfT4bkGwYQUbca15LR/SO0wpMVlvpvvzLBhWqp
         jmApCL4kHkTCR8OURej7ubIG4YgD/xC5V/ODAZk/Ry72wlzcG/31+qQeejNWadxY5RkX
         fV4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YyF2qg/Mhc4XEhGEeCU7TNWSjed5NzKyuCiBwgDTeok=;
        b=LdrYCP17R3QAdVZ/t/tkCDKZ7t/24sFlkm68NxK+FifvBLEl7ZZu+etUGXcLxxqRye
         f7zhFp7nNSIHvplWCtOgeU/6z66WOkMDjTpDUMV/it+jMDnet/VTwP5+RgFYyNmxR0MK
         78Ra51VrHduWKxGPiybegp3ix/Lq9lJY3OgIWfXzvhdkoAB9dNR9IMX/LrkSRpUTWWO/
         HuP/qWKhrQYzxKzz1tKv65gzCJjzma1rdonMICRInkIkgm/WfOma6rzfw7JTb50P7CM2
         Uk6+OR5+sgvIon2UPCfmhlpw2u4XqU7YwOnydHD8dewYexxB3raMsDip5mXTeFhVUV9P
         TvEg==
X-Gm-Message-State: APjAAAUjDyPUvQotje8VKmyW0LUFNBM+kFBaKIICaNQXcocEg5luEBdR
        thjCTn8VAaQl+BmNRPyY72Hmcg==
X-Google-Smtp-Source: APXvYqy0xGbbo5vxBCjyi2D1txW1Xhaykdn/3hUyo1fQuxdB/nRiboXKJ4vr/m3wedCmwKaVbLlPxA==
X-Received: by 2002:a17:90a:ac12:: with SMTP id o18mr25640079pjq.93.1571134579228;
        Tue, 15 Oct 2019 03:16:19 -0700 (PDT)
Received: from localhost.localdomain (59-127-47-126.HINET-IP.hinet.net. [59.127.47.126])
        by smtp.gmail.com with ESMTPSA id f15sm19639288pfd.141.2019.10.15.03.16.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Oct 2019 03:16:18 -0700 (PDT)
From:   Chris Chiu <chiu@endlessm.com>
To:     Jes.Sorensen@gmail.com, kvalo@codeaurora.org, davem@davemloft.net
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com
Subject: [PATCH] rtl8xxxu: fix connection failure issue after warm reboot
Date:   Tue, 15 Oct 2019 18:16:08 +0800
Message-Id: <20191015101608.4566-1-chiu@endlessm.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h       | 1 +
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c | 1 +
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c  | 3 +++
 3 files changed, 5 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index 22e95b11bfbb..fd2ad7d07335 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -1425,6 +1425,7 @@ struct rtl8xxxu_fileops {
 	u8 has_s0s1:1;
 	u8 has_tx_report:1;
 	u8 gen2_thermal_meter:1;
+        u8 needs_full_init:1;
 	u32 adda_1t_init;
 	u32 adda_1t_path_on;
 	u32 adda_2t_path_on_a;
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
index 9ba661b3d767..fef1a91489a5 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
@@ -1668,6 +1668,7 @@ struct rtl8xxxu_fileops rtl8723bu_fops = {
 	.has_s0s1 = 1,
 	.has_tx_report = 1,
 	.gen2_thermal_meter = 1,
+        .needs_full_init = 1,
 	.adda_1t_init = 0x01c00014,
 	.adda_1t_path_on = 0x01c00014,
 	.adda_2t_path_on_a = 0x01c00014,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index e4c1b08c8070..8420cb269b8d 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -3900,6 +3900,9 @@ static int rtl8xxxu_init_device(struct ieee80211_hw *hw)
 	else
 		macpower = true;
 
+	if (fops->needs_full_init)
+		macpower = false;
+
 	ret = fops->power_on(priv);
 	if (ret < 0) {
 		dev_warn(dev, "%s: Failed power on\n", __func__);
-- 
2.23.0

