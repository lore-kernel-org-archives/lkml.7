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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CDCC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 22:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 424C42087F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 22:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5j8RK7w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387953AbfG3WBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 18:01:52 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45144 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387561AbfG3WBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 18:01:51 -0400
Received: by mail-io1-f67.google.com with SMTP id g20so131741334ioc.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 15:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rME4gSy2TuO6SEgNfnkb7ooplhaDIhLQ2nvkgci5ujs=;
        b=X5j8RK7wVi5TZtivxNXC8QgO31lAinZ4SA8IAlJPp25veaoqXTe+Hlm5dgW7fCie9q
         H7YYuSmSQfyECAxnqS7aKV7lzhqUtghPgufF1yWWoz7/PGpWnJiwCxSU/EOBU3y8rytU
         GWEXocxHDZc4hyNYfejIGHuPhkFDzZB+DC9BsIxFCzwJCr43S76IaJHKAZyg3WDr6jMR
         PpV96n+wiirfLTpW3M9d9IommJHKbZvXxAcrSF9PTVHqvhOFcfND6+FZUX2w6XUNdEh6
         e/wlvali7i8PeM/GHWsi9b2O5+ymahlryJzqPIA/i54/5DzoJxnOhTMfaTpd7vLvGRcu
         MXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rME4gSy2TuO6SEgNfnkb7ooplhaDIhLQ2nvkgci5ujs=;
        b=o8dG2jd+pb1SOvSYJxdK+oehPkpJP4+E0hhbk1optrxTvKx/w3CVzK7cJs37ZDchnQ
         00GAL3dSt718SkyEd2UEgvfmzHNAGUSr1FmQKQYu2HdvSbPTS+xkOGn0THpRcbBDIQfD
         9H+Hnn1pVvf2j0dgIholyDHWasdU7w0A3J0W43kHalZ0SnYp07BPpyexVdhKA/mgMtle
         9AL26aSoS8eKmo9+Hg05KupaBR3mY0g/89WszrELcJSprJ3soq5lgWJ8QZ6a0j/UGDCy
         +Q5E2Odro7NZYblKKQSh+Ilxoutsk3KlsFQaQd7+9l2lP/6AQEIgtVqgQn/t1oxZkX7l
         Kw0Q==
X-Gm-Message-State: APjAAAUQvu90G8SGHdkfcTWFvsouA1SP4Hs0w2i2qTm+sm5hkICoUFd7
        PoebiEtatMmB9wtUa6yPaqI=
X-Google-Smtp-Source: APXvYqyJD7rOEa9cQVfrpNiVU45+A0Q58+y0mpssRej1Kh4ElwGDwbnPRmgQLQAVcHCyx+zeVwVz9g==
X-Received: by 2002:a5e:8b43:: with SMTP id z3mr107727401iom.287.1564524110967;
        Tue, 30 Jul 2019 15:01:50 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id e22sm50247229iob.66.2019.07.30.15.01.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 15:01:50 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     emamd001@umn.edu, kjlu@umn.edu, b.zolnierkie@samsung.com,
        smccaman@umn.edu, Navid Emamdoost <navid.emamdoost@gmail.com>,
        John Whitmore <johnfwhitmore@gmail.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] staging: rtl8192u: null check the kzalloc
Date:   Tue, 30 Jul 2019 17:01:39 -0500
Message-Id: <20190730220141.6608-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190730164304.GA10640@kroah.com>
References: <20190730164304.GA10640@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In rtl8192_init_priv_variable allocation for priv->pFirmware may fail,
so a null check is necessary.priv->pFirmware is accessed later in
rtl8192_adapter_start. I added the check and made appropriate changes
to propagate the errno to the caller.

---
Update v2: fixed style errors
Update V3: fixed prefix

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

