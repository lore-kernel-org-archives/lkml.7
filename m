Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D24C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 14:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A6E020449
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 14:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LA6lAtNh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbfGaOTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 10:19:41 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46668 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728124AbfGaOTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 10:19:41 -0400
Received: by mail-io1-f65.google.com with SMTP id i10so23282750iol.13
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 07:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LmsfEqE9rSQmbGZDMq4zi+aR2TovlvdbPxBXSE/ln+o=;
        b=LA6lAtNhGfQ+YpcxNb8jwYGQrfWT2i1bdJBZJomQ/TvKoemNn/MxyqESq1TSYglZRz
         05SltvU4JYrBeJgqjhusgXRSjGL16SS++B/M7/FRYC0pJtqBdHRJBdno2uhlUPpFxsbd
         LUJaJtvMcYShLpfP1aWkb1BcL4A0DqIR9XGOCTjpHLTSAw4dl+hnqUDqSAEtrtxkeiH2
         EoAuOD5bO9kO0ed89spip2bSu1iGTKDJPnvrS7zjreD7X6y9o5y8yPHnKn662KM3uVPf
         STCwhD7elqg4ppyfdRb5WYOL09jyL1v/7XAm+tCkBnSWpo+pDR4OGKP4XoGUOYWuCoRZ
         jqVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LmsfEqE9rSQmbGZDMq4zi+aR2TovlvdbPxBXSE/ln+o=;
        b=roloy9XHVCaKAB4Z/CkHUtyjnnaQbXhtw6inVs1z8t9pXEjqz10gbiNxs0saxacoFG
         f7sbHZhLxV0GZIJNyF7XpMaeoQqCnEQsaccMoqzAiD5PMNaLpI3GbcfkoZjLxPrMZjj6
         Y3I75wtlGZONXfcrJpcFvTv3VUFPlodEFOU3XToa2om0GcBymcoa3x156xdZm9ZylFP8
         PCiUKD8oMl+8RDuQ5nBLrISvUzWZOixPpBedtux5p9Cp3Te110iBHzHmFgrUDzE2qx1H
         tLqjfgUKDHWNG+PqiQcs5cB/S+nHk4/XBmgNqVigjpbxFlcWVpE8R5Rze7WeYbgJKuYI
         fS2g==
X-Gm-Message-State: APjAAAWEkI88GTXwt8pf/8YtcoGsaVXbWNOibpKGs1D90LTcjCSzyThP
        27ZNUUKLofv8ZEGbOamGAKs=
X-Google-Smtp-Source: APXvYqyAFe0YvPfoXErQySSDugu3fvmA7rjYbFYVjEOxmD+8hGVOV9dk3hEIZublWvvG5l+uGr0OBg==
X-Received: by 2002:a5d:8c87:: with SMTP id g7mr14293199ion.85.1564582780478;
        Wed, 31 Jul 2019 07:19:40 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id s3sm57124403iob.49.2019.07.31.07.19.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 07:19:39 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     emamd001@umn.edu, kjlu@umn.edu, b.zolnierkie@samsung.com,
        smccaman@umn.edu, Navid Emamdoost <navid.emamdoost@gmail.com>,
        John Whitmore <johnfwhitmore@gmail.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] staging: rtl8192u: null check the kzalloc
Date:   Wed, 31 Jul 2019 09:19:21 -0500
Message-Id: <20190731141925.29268-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190731113642.GA3983@kroah.com>
References: <20190731113642.GA3983@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In rtl8192_init_priv_variable allocation for priv->pFirmware may fail,
so a null check is necessary.priv->pFirmware is accessed later in
rtl8192_adapter_start. I added the check and made appropriate changes
to propagate the errno to the caller.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>

---
Update v2: fixed style errors
Update V3: fixed prefix
Update V4: fixed style
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

