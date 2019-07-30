Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4DA0C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E5F0205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d698hF59"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731415AbfG3ObX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 10:31:23 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44117 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731401AbfG3ObT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 10:31:19 -0400
Received: by mail-io1-f65.google.com with SMTP id s7so128366202iob.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 07:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i1YG6kCqYX+kvrR/utmgPEUkyqV8ZvVNvWgcHogxlHg=;
        b=d698hF59zDxtZytQwsR6EpwE9keRNxhrk3Ayk0D0ZoSxfWBdkfYnQaz6WpVT5ukTXY
         hC6InAams8Rqw4t5iwfzD8W0f0MJQLB834JwUd9LNtohSgltfPgA0f+N5OmVDeFraC5R
         +NA8O4IqgDkD5cOiE8bWQ9eCKyLfd+SBaNAcQwq+3DzYM3n3MMrG237SXER3zsSIgWR2
         Ve3SEWrBHBhuwcyDBhxbyZ0zYg6knmaWepva0TxrC6v0BcvSt5dt0zJIY1H7xAaX+GvK
         jvEoNbPT84DFK0ZLA163P96TKrFch25xuyg81XeyW3QOZQngayDD1HPwl17rprkcq1cZ
         Hd2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i1YG6kCqYX+kvrR/utmgPEUkyqV8ZvVNvWgcHogxlHg=;
        b=h3cveJPk6PtfUnJDzEtxchc3qMWBPtIWyoY7ZH/Dv+9o3R3/P2SGdJdawVbfHIaWVK
         Yac4WrDn5feCx3Un7gwhV1OqxYWvH8g8B9UatQT/FFQBIrkw5MGgNC8QSwBKhJD4y9pb
         xfi0Glz27MRe4WJDS8p87i1Oq4FPeWp3E/rDeqYPqNSGVrtscDLW2MNgbfjXv/95ds5c
         yocGeawTV0RPBfDTq/lnbKNVxSgpe6Xu7Y/RiDq/n3npDjeGcS1KXwwJhJIIdrcx7Vv+
         cbc8v1BUQ2dP3bskfLHz4Qxg0+MdBWvVGSMJyG65LzNT0wAeVRcqZAt/1qlljTUZ3oxv
         vGNw==
X-Gm-Message-State: APjAAAW93EmrKHAoZcY2byek4/u78hO9GuoktDIwK32LBr6OdPNQFwoa
        DgJUwsgMalKOtO1dLaTXgn0=
X-Google-Smtp-Source: APXvYqy6gxWceJb+HPsypSS/lHgI9/f1GKwJy2preCLCpm1Lw+K7APYs7jku5K9eZqCfZILd53HkJw==
X-Received: by 2002:a05:6638:38a:: with SMTP id y10mr4159812jap.104.1564497078526;
        Tue, 30 Jul 2019 07:31:18 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id x22sm46895200ioh.87.2019.07.30.07.31.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 07:31:17 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     kjlu@umn.edu, smccaman@umn.edu, emamd001@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        John Whitmore <johnfwhitmore@gmail.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] rtl8192_init_priv_variable: null check is missing for kzalloc
Date:   Tue, 30 Jul 2019 09:30:58 -0500
Message-Id: <20190730143102.6662-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190725124528.GA21757@kroah.com>
References: <20190725124528.GA21757@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocation for priv->pFirmware may fail, so a null check is necessary.
priv->pFirmware is accessed later in rtl8192_adapter_start. I added the
 check and made appropriate changes to propagate the errno to the caller.

Update: fixed style errors

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index fe1f279ca368..569d02240bf5 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -2096,7 +2096,7 @@ static void rtl8192_SetWirelessMode(struct net_device *dev, u8 wireless_mode)
 }
 
 /* init priv variables here. only non_zero value should be initialized here. */
-static void rtl8192_init_priv_variable(struct net_device *dev)
+static int rtl8192_init_priv_variable(struct net_device *dev)
 {
 	struct r8192_priv *priv = ieee80211_priv(dev);
 	u8 i;
@@ -2223,6 +2223,8 @@ static void rtl8192_init_priv_variable(struct net_device *dev)
 
 	priv->AcmControl = 0;
 	priv->pFirmware = kzalloc(sizeof(rt_firmware), GFP_KERNEL);
+	if (!priv->pFirmware)
+		return -ENOMEM;
 
 	/* rx related queue */
 	skb_queue_head_init(&priv->rx_queue);
@@ -2236,6 +2238,8 @@ static void rtl8192_init_priv_variable(struct net_device *dev)
 	for (i = 0; i < MAX_QUEUE_SIZE; i++)
 		skb_queue_head_init(&priv->ieee80211->skb_drv_aggQ[i]);
 	priv->rf_set_chan = rtl8192_phy_SwChnl;
+
+	return 0;
 }
 
 /* init lock here */
@@ -2605,7 +2609,10 @@ static short rtl8192_init(struct net_device *dev)
 		memcpy(priv->txqueue_to_outpipemap, queuetopipe, 9);
 	}
 #endif
-	rtl8192_init_priv_variable(dev);
+	err = rtl8192_init_priv_variable(dev);
+	if (err)
+		return err;
+
 	rtl8192_init_priv_lock(priv);
 	rtl8192_init_priv_task(dev);
 	rtl8192_get_eeprom_size(dev);
-- 
2.17.1

