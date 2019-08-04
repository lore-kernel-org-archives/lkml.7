Return-Path: <SRS0=geQ9=WA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D129BC19759
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 03:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A17632075C
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 03:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xa5XhcGO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbfHDDtL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 23:49:11 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46551 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbfHDDtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 23:49:11 -0400
Received: by mail-pg1-f194.google.com with SMTP id w3so778397pgt.13
        for <linux-kernel@vger.kernel.org>; Sat, 03 Aug 2019 20:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=qPpsx0lZXSAze2smB67N23Z3ac9MnBXGfrM+XLrnXhY=;
        b=Xa5XhcGOqYQkHtIrimdKrUWMsV6UxQFF5NYX6yKSzHGH4atjizk4EvZMqs0Gd5TaqS
         FyYWb3okHzvS24/7w9/CdXDQwIYPsVWzvB+KGU+aUWqqEUmYuupI5RRrpk0Gw3ntb2Ux
         vnPJNSWjenG06l3tHrSJqAYe6XkMz1oTW7hMeBaSadW66KcpEgf1I/Ohs2/NNsRTYzUI
         9VW7FJ36K8jJGeEQwqNs867a0Jvofh7lsNpU2NnhmeMPP4z8LPQohcBwVD/bbszwYT7i
         Q8PUKXUir1HdtT4SVOUGDU0qBsnV333B0xXhDzt5rE3FzfB6ccYL/8ee/e3YLrudG1Te
         eWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=qPpsx0lZXSAze2smB67N23Z3ac9MnBXGfrM+XLrnXhY=;
        b=RdEh+Skul8WK+MwwbkvQXVhzX6oIlQPVbW3vB0bHNznDkrFlFwMCfuk+NTWJJ4wXGC
         +cuc19tnizu36/ufkVPHy0+JsC+iO2cmxDIicAfU4vx9EkmD74HBKyKbQaENj1JbNXzV
         adYrzXFZgeik8CwXEQAQEXsN385/p1BOKd+GU+OzSHNrJ2FeSGP6zEcmNBpVt4OpUu0k
         g498AQLWrt6Iv/0YoC3CwAuhxz2UUsrOOyni3YZ8/fvqaDBetwm7zueNvXRku3vtmloG
         nyhzY0YEzOzXi6mWmGh3PRN/PMU1Pgn8VyN221k7qVc1aMWid6ri/LFpradJMhk8KU5O
         4Ifw==
X-Gm-Message-State: APjAAAX8XIfQa5yepqzY7K1Ze3AuAnRG9d4MYJ2sYHRXnkwaJp5f44st
        rWO12L1hXGP5VlmaMYgI8W5gzn8V
X-Google-Smtp-Source: APXvYqzfLPe75VdOmbLiNrGlHAGZ1J4CtJ5f6qfokYi8u1C2tmCEnAHMBaRpHdA2MRaCG8DdPSGIIA==
X-Received: by 2002:a63:3c5:: with SMTP id 188mr128318137pgd.394.1564890550467;
        Sat, 03 Aug 2019 20:49:10 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.86.126])
        by smtp.gmail.com with ESMTPSA id a21sm88482666pfi.27.2019.08.03.20.49.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Aug 2019 20:49:09 -0700 (PDT)
Date:   Sun, 4 Aug 2019 09:19:05 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Whitmore <johnfwhitmore@gmail.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192u: Add NULL check post kzalloc
Message-ID: <20190804034904.GA16513@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Collect returns status of kzalloc.

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_core.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index fe1f279..3240442 100644
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
@@ -2605,7 +2609,11 @@ static short rtl8192_init(struct net_device *dev)
 		memcpy(priv->txqueue_to_outpipemap, queuetopipe, 9);
 	}
 #endif
-	rtl8192_init_priv_variable(dev);
+	err = rtl8192_init_priv_variable(dev);
+	if (err) {
+		DMESG("init private variables failed");
+		return err;
+	}
 	rtl8192_init_priv_lock(priv);
 	rtl8192_init_priv_task(dev);
 	rtl8192_get_eeprom_size(dev);
-- 
2.7.4

