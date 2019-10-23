Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC95DCA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 10:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE4CB214B2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 10:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="tmFRNZIK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391096AbfJWKyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 06:54:19 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37153 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390491AbfJWKyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 06:54:19 -0400
Received: by mail-pg1-f195.google.com with SMTP id p1so11935761pgi.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 03:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hd+GeGNy0Z1vTVXDGiFusVZRyBmc3vmXQ8fhFYfc7fA=;
        b=tmFRNZIKMjDMXXKEICvv7mTspe0FDfqvqZoumY9t/1rA17e4oNOY/I2wgnwQzLxnQJ
         apn5i0vev41KH+x/Q9urvc8pkzhZA0Jzo5WvPiEL1lTfuxso+ymm8Mcx8Sx5cUJ0gKpJ
         nh7vWBZF25gjpodwz0iYmRpCQIi3qJjW4UeOQbKlaxNcyB5QT+/FIXKnVLP9q0d8+9zM
         7btqDwTH1iNUni2NL8BRicQPyrFXlr8PkvJ8QhSFb/kpV2VcNb5nz9ucXz4e9sjk1juQ
         lJEe9RMObCcNGd5wZnb9oYbL7sXis9kmf9lZi2Tx1XVc3ZhkqnPXpt0cNNep4hUQ7nVy
         go7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hd+GeGNy0Z1vTVXDGiFusVZRyBmc3vmXQ8fhFYfc7fA=;
        b=lX68tX89ogel0SmaIKPvU60WnekSSAJWum6X/pEVU0ekku7vdPtt0ZxQSv5sDLjYGh
         60xT78i9Kw+A1eebRrWblY52LVXMPq0ZnMLoQ2mncQv+uLBD7I47Gfm2R9Dbxjpbrbz4
         ugjzKVUcHRUXHezgvwpBS7q7RgFYjgA52SH3aCB/VC68sz73y/Ukmqc4l7uh5AwH5upB
         BP/VtaP5xvIs9IaBSbrujGndrRFkD9UDE58/UjUtFFK55+0LjTm4slVfu51j+6S3W2qp
         vIrhBiu+KUsri/746AShmjJbOh33Z/ZwSwHB5XGMhKMFua4Tz2+2uqybiQUfoZInJc9K
         2ojg==
X-Gm-Message-State: APjAAAXFS8orXJLBGQCHV1aq+R9bFKfiJ8IxWsbdzqWPIQVkDCSgBZ0t
        nYp8+10BCI/tYnaGZcEH8M4wWg==
X-Google-Smtp-Source: APXvYqwiRnoRJ9xGk2Dz0oIYEpIv0ONeU2+JcIrkdTuPyyTF/PWbCFu+7hqOwJHVH90dDbf1AWKMaA==
X-Received: by 2002:a17:90a:3608:: with SMTP id s8mr10830077pjb.44.1571828058013;
        Wed, 23 Oct 2019 03:54:18 -0700 (PDT)
Received: from localhost.localdomain (59-127-47-126.HINET-IP.hinet.net. [59.127.47.126])
        by smtp.gmail.com with ESMTPSA id s202sm23774021pfs.24.2019.10.23.03.54.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Oct 2019 03:54:17 -0700 (PDT)
From:   Chris Chiu <chiu@endlessm.com>
To:     Jes.Sorensen@gmail.com, kvalo@codeaurora.org, davem@davemloft.net
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com
Subject: [PATCH] rtl8xxxu: fix warnings for symbol not declared.
Date:   Wed, 23 Oct 2019 18:54:07 +0800
Message-Id: <20191023105407.92131-1-chiu@endlessm.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following sparse warnings.
sparse: symbol 'rtl8723bu_set_coex_with_type' was not declared.
Should it be static?
sparse: symbol 'rtl8723bu_update_bt_link_info' was not declared.
Should it be static?
sparse: symbol 'rtl8723bu_handle_bt_inquiry' was not declared.
Should it be static?
sparse: symbol 'rtl8723bu_handle_bt_info' was not declared.
Should it be static?

Signed-off-by: Chris Chiu <chiu@endlessm.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index f982f91b8bb6..eac91690772b 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -5194,6 +5194,7 @@ static void rtl8xxxu_rx_urb_work(struct work_struct *work)
  * cases which Realtek doesn't provide detail for these settings. Keep
  * this aligned with vendor driver for easier maintenance.
  */
+static
 void rtl8723bu_set_coex_with_type(struct rtl8xxxu_priv *priv, u8 type)
 {
 	switch (type) {
@@ -5245,6 +5246,7 @@ void rtl8723bu_set_coex_with_type(struct rtl8xxxu_priv *priv, u8 type)
 	}
 }
 
+static
 void rtl8723bu_update_bt_link_info(struct rtl8xxxu_priv *priv, u8 bt_info)
 {
 	struct rtl8xxxu_btcoex *btcoex = &priv->bt_coex;
@@ -5311,6 +5313,7 @@ void rtl8723bu_update_bt_link_info(struct rtl8xxxu_priv *priv, u8 bt_info)
 		btcoex->bt_busy = false;
 }
 
+static
 void rtl8723bu_handle_bt_inquiry(struct rtl8xxxu_priv *priv)
 {
 	struct ieee80211_vif *vif;
@@ -5336,6 +5339,7 @@ void rtl8723bu_handle_bt_inquiry(struct rtl8xxxu_priv *priv)
 	}
 }
 
+static
 void rtl8723bu_handle_bt_info(struct rtl8xxxu_priv *priv)
 {
 	struct ieee80211_vif *vif;
-- 
2.20.1

