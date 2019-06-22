Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27761C48BE7
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 15:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F27D920675
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 15:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0sidvWU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfFVPPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 11:15:01 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46926 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfFVPO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 11:14:59 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so9287086wrw.13
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2019 08:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GfBi8EfFM0kdy6LN/pUSdo1EwlShROfv4a9we6saYeo=;
        b=X0sidvWUWWQqRq0eSjJL99cNcG56y3R9742cvNj5qWJl6QdEDtLUBPOtYWw02i3i19
         NBiupLMrC/Kn0RZJmheBZ2UmdGfwbMLPQ2VVhsiLW/XZAtOqYBGyxTvGAJ7Od7KhJeqH
         jcDGcWJf1sw8Z9SqiSDb1bbS1ZoYKQfZ0X+bDfJ15zBofdWbCoKFyL5Gbn/S1p+cc9g5
         6lucuUvjEGcpZ1XZS36PN+DqaCGFcE60ZLfJeicoGtf9UIZq05MUWS0mE59P22Xstgnu
         ShedeaUFMvxgyRXOF2PwxNIp7rGGAX+kBcJGOQ/hTvZk8k3q98CBsxb4BcUwlHSSB1Us
         sS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GfBi8EfFM0kdy6LN/pUSdo1EwlShROfv4a9we6saYeo=;
        b=gZKTx/SEB2q8QS8eexYvjVSg/vkv0UdAw+Z9qNmv/tWwfXD0z6LE+5mSQxZeFPabTa
         3hRe1xcDZGmOJIH8kFQoS+1H0NaSPhOZroImZnbuodFCu5sNjbh2JLX16NPKV6FewKQJ
         1fbvgAFzYt+lQxngVAQ0DHcUdtQ8X9duOGYyCcg5SYVOl80q6WKKq5SnEj6mCMUl7Bak
         1Bo95h7xLWsJO/c+esK5Q1lhaP7srmx3fM1E0VeWR+nYzl3pQpYAyGmbE7+iYStj01uo
         kj3yhzO3QwnaIEMl/ZBlZEmFx1ZUZtTXNRs5UrEnr8ePzFCrIcQAdQnOiW3FttEz/TFW
         S8Ew==
X-Gm-Message-State: APjAAAWO/0eEaAQdxDoJpoo6akq7Vnj02aUY3yD8gr/gVBski3fZMFKN
        Mkn0cdt10rKl5fpo/IAL1Lw=
X-Google-Smtp-Source: APXvYqwTD9bh2HXTD+nm7yp3Im0xb+/Nc4c+Wkr0M5w5PgHnM0k/EqVCFiybiLEgRoql9EQ04KOvCw==
X-Received: by 2002:a05:6000:11cc:: with SMTP id i12mr3600173wrx.243.1561216497768;
        Sat, 22 Jun 2019 08:14:57 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96bf:e0ab:2b68:5d76:a12a:e6ba])
        by smtp.gmail.com with ESMTPSA id o126sm7099847wmo.1.2019.06.22.08.14.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 22 Jun 2019 08:14:57 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/2] staging: rtl8188eu: remove hal_init_macaddr()
Date:   Sat, 22 Jun 2019 17:14:49 +0200
Message-Id: <20190622151449.32095-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190622151449.32095-1-straube.linux@gmail.com>
References: <20190622151449.32095-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function hal_init_macaddr() just calls rtw_hal_set_hwreg().
Use rtw_hal_set_hwreg() directly and remove hal_init_macaddr().

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/hal_com.c     | 6 ------
 drivers/staging/rtl8188eu/hal/usb_halinit.c | 3 ++-
 drivers/staging/rtl8188eu/include/hal_com.h | 1 -
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/hal_com.c b/drivers/staging/rtl8188eu/hal/hal_com.c
index ff481fbd074c..95f1b1431373 100644
--- a/drivers/staging/rtl8188eu/hal/hal_com.c
+++ b/drivers/staging/rtl8188eu/hal/hal_com.c
@@ -283,9 +283,3 @@ bool hal_mapping_out_pipe(struct adapter *adapter, u8 numoutpipe)
 	}
 	return result;
 }
-
-void hal_init_macaddr(struct adapter *adapter)
-{
-	rtw_hal_set_hwreg(adapter, HW_VAR_MAC_ADDR,
-			  adapter->eeprompriv.mac_addr);
-}
diff --git a/drivers/staging/rtl8188eu/hal/usb_halinit.c b/drivers/staging/rtl8188eu/hal/usb_halinit.c
index 69008accb015..ac5552050752 100644
--- a/drivers/staging/rtl8188eu/hal/usb_halinit.c
+++ b/drivers/staging/rtl8188eu/hal/usb_halinit.c
@@ -746,7 +746,8 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	_InitDriverInfoSize(Adapter, DRVINFO_SZ);
 
 	_InitInterrupt(Adapter);
-	hal_init_macaddr(Adapter);/* set mac_address */
+	rtw_hal_set_hwreg(Adapter, HW_VAR_MAC_ADDR,
+			  Adapter->eeprompriv.mac_addr);
 	_InitNetworkType(Adapter);/* set msr */
 	_InitWMACSetting(Adapter);
 	_InitAdaptiveCtrl(Adapter);
diff --git a/drivers/staging/rtl8188eu/include/hal_com.h b/drivers/staging/rtl8188eu/include/hal_com.h
index 2f7bdade40a5..93cbbe7ba1fd 100644
--- a/drivers/staging/rtl8188eu/include/hal_com.h
+++ b/drivers/staging/rtl8188eu/include/hal_com.h
@@ -148,5 +148,4 @@ void hal_set_brate_cfg(u8 *brates, u16 *rate_cfg);
 
 bool hal_mapping_out_pipe(struct adapter *adapter, u8 numoutpipe);
 
-void hal_init_macaddr(struct adapter *adapter);
 #endif /* __HAL_COMMON_H__ */
-- 
2.22.0

