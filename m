Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D327DC48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 09:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E292083B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 09:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="G0wG3LIG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbfF0JxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 05:53:00 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37524 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfF0JxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 05:53:00 -0400
Received: by mail-pf1-f196.google.com with SMTP id 19so965181pfa.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 02:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eSti7nNxGlkHMPeNaufOPNsxXSw1/a1T6eOCbwJcR44=;
        b=G0wG3LIGXYb5Tu8AeTGsf4L7a2ukWIRgwZj5WGdhvin5vS27CtwZi3qWiBt6DAntMZ
         lRL1+R4wZpmnsf2s0i9xMo6bDECRfX5BrWTKcUQxSZsS/Sx8MTlQ5jKzYKSIL631srt0
         piCtmwxW1Cajnz/tTWW8MgTwe8yqORSV/3YnC4px811/hmnPbyl4c4WLHYaHQ+SUsz7g
         nI0ZPd7gaJQnuwxcGieVjUKrGogHyOWu1HDhDI8q8iJ5kSCx36x9GKtubm04qvtkKk0/
         Wqt80KKS3s4GEdgSsNuYhyzO+pnSjgjiLJrsD34JCUoP+nTpeUCdC9RpVfGboENcS5Ej
         hCaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eSti7nNxGlkHMPeNaufOPNsxXSw1/a1T6eOCbwJcR44=;
        b=ohWzeZFe4RYJO7O3mFMdo07rhBmAMu3bnSaIKXI+F0cZtLI3/rw+as9nFNXnAxMoxF
         dyc4/KWRVYMrblqLPP/ko6dzTjxzEEE/FSe/C+4csIF2/05J1OphWoyCi47Lm47BqG18
         /0gWRmYe8SSkpuAAnCQTO6qdmgqcbKi8gEKhVtOlGufKclVSNwMZPqytD/CQv05E2RBq
         66zjJy48kYVL4Cz9Kd2WZ0oBfA/wNntBakXaOz8riY5EHSYLXy/o6daDMVfufPfTb2AL
         /ZJ3SZXYP9ZvNihjqek+cAekSmjL4Xu2ErLvyLHeO04DOaMuU7CcDLEcO8lIOF/Ng2Dk
         U8zw==
X-Gm-Message-State: APjAAAXsuuQVZ5dJtK72m++An6MfH1PlPOixW0/YvOh0cwKHT5PQQ1FZ
        7fsORCmtAtLSSRD2auYqF8hRVw==
X-Google-Smtp-Source: APXvYqwThA5c5tolZNtd9PZAt1ZfD9D1vZXSf7f0FwowKXSR7Ra1Wy8QnbI+BmVviA4UB9KjXHwqtA==
X-Received: by 2002:a65:4387:: with SMTP id m7mr2883842pgp.287.1561629179022;
        Thu, 27 Jun 2019 02:52:59 -0700 (PDT)
Received: from localhost.localdomain (220-133-8-232.HINET-IP.hinet.net. [220.133.8.232])
        by smtp.gmail.com with ESMTPSA id p15sm15635118pjf.27.2019.06.27.02.52.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 27 Jun 2019 02:52:58 -0700 (PDT)
From:   Chris Chiu <chiu@endlessm.com>
To:     jes.sorensen@gmail.com, kvalo@codeaurora.org, davem@davemloft.net
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com
Subject: [PATCH] rtl8xxxu: Fix wifi low signal strength issue of RTL8723BU
Date:   Thu, 27 Jun 2019 17:52:47 +0800
Message-Id: <20190627095247.8792-1-chiu@endlessm.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The WiFi tx power of RTL8723BU is extremely low after booting. So
the WiFi scan gives very limited AP list and it always fails to
connect to the selected AP. This module only supports 1x1 antenna
and the antenna is switched to bluetooth due to some incorrect
register settings.

This commit hand over the antenna control to PTA, the wifi signal
will be back to normal and the bluetooth scan can also work at the
same time. However, the btcoexist still needs to be handled under
different circumstances. If there's a BT connection established,
the wifi still fails to connect until disconneting the BT.

Signed-off-by: Chris Chiu <chiu@endlessm.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c | 9 ++++++---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c  | 3 ++-
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
index 3adb1d3d47ac..6c3c70d93ac1 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
@@ -1525,7 +1525,7 @@ static void rtl8723b_enable_rf(struct rtl8xxxu_priv *priv)
 	/*
 	 * WLAN action by PTA
 	 */
-	rtl8xxxu_write8(priv, REG_WLAN_ACT_CONTROL_8723B, 0x04);
+	rtl8xxxu_write8(priv, REG_WLAN_ACT_CONTROL_8723B, 0x0c);
 
 	/*
 	 * BT select S0/S1 controlled by WiFi
@@ -1568,9 +1568,12 @@ static void rtl8723b_enable_rf(struct rtl8xxxu_priv *priv)
 	rtl8xxxu_gen2_h2c_cmd(priv, &h2c, sizeof(h2c.ant_sel_rsv));
 
 	/*
-	 * 0x280, 0x00, 0x200, 0x80 - not clear
+	 * Different settings per different antenna position.
+	 * Antenna switch to BT: 0x280, 0x00 (inverse)
+	 * Antenna switch to WiFi: 0x0, 0x280 (inverse)
+	 * Antenna controlled by PTA: 0x200, 0x80 (inverse)
 	 */
-	rtl8xxxu_write32(priv, REG_S0S1_PATH_SWITCH, 0x00);
+	rtl8xxxu_write32(priv, REG_S0S1_PATH_SWITCH, 0x80);
 
 	/*
 	 * Software control, antenna at WiFi side
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 8136e268b4e6..87b2179a769e 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -3891,12 +3891,13 @@ static int rtl8xxxu_init_device(struct ieee80211_hw *hw)
 
 	/* Check if MAC is already powered on */
 	val8 = rtl8xxxu_read8(priv, REG_CR);
+	val16 = rtl8xxxu_read16(priv, REG_SYS_CLKR);
 
 	/*
 	 * Fix 92DU-VC S3 hang with the reason is that secondary mac is not
 	 * initialized. First MAC returns 0xea, second MAC returns 0x00
 	 */
-	if (val8 == 0xea)
+	if (val8 == 0xea || !(val16 & BIT(11)))
 		macpower = false;
 	else
 		macpower = true;
-- 
2.11.0

