Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32FAC76186
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 20:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C461B20823
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 20:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0KDOOjD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbfGTU0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 16:26:10 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46666 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfGTU0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 16:26:09 -0400
Received: by mail-io1-f67.google.com with SMTP id i10so65504098iol.13
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2019 13:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=L6zkJb2shIoMSsjRP6Uieh9grvMIGFYjODy/QSL4JrU=;
        b=g0KDOOjDfqQM1SVXauXigqH96DJbMepJ5WqdUPhCEp5LDnjXRRPacV7UUC3f+wBJpn
         +hLXTj51RGI9P7Gxcp0dRiD1M6i3jpfzMZ5QNxmyrjO7kQYJ2bsZ6gIptasYXMEPBvjk
         D7OFEdJUUBWs0Rsnp3EGDq9VQO0CWaVUR33//4iqZVXi8RxYuQ5pDVn1RA5U2rzKZCoL
         L8XdU49aQzJoxsyYkH6nNQeIkOVc8dn7QMKWq7aPuNutcSMriyI12DfDUlrw3LN5oTNn
         PO3ktS8xPFpVL/XdcCZS4Nl5o3xoYSnJu1GQePF50RReZ5W49aJ8Elr2GQI/GeCX+ZW3
         Ub0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=L6zkJb2shIoMSsjRP6Uieh9grvMIGFYjODy/QSL4JrU=;
        b=m8nQRqMcfn/ttsYOG8Y7HLYqkIz9EVFnEeXeuJBWnrftihuep0ri2PbiFAm1rZ4fQf
         GSL7MdViEwC2qfuGlRAErywyUwGu0fI/lCaXXsuq/g3m0txdtz+wBas0+m1wrKYZWrno
         5f+Jqni6/+9ryFV2N9Zpe9PapXGfQc0S/+HB4jamI9qL304c8D3MvuD7OeU18SxRtZhp
         g7hy5xAGE/kucYFnKGmUCx8dx4EKBoruK34+nuhVsVy3JqcVtUixMuyhdOfNQKXL488+
         ADdTyT6ubPsUb474wQS1KVfws2gmPkwLREcUu68xWdk+VbwSLhJuRet3DMLkcXlMwFNZ
         GAsw==
X-Gm-Message-State: APjAAAU9qVjBaQd8SKJfwSjbRKz7FOJ294w4UqqUq45qqCyqcwIZJef4
        QsQs8sWWuZKgHSgfbIWA4Ys=
X-Google-Smtp-Source: APXvYqzGJpIGWM4cBpaVAJfK9fK5SBJ+g0JJIuIsz1owZX5qvAlxcdwjPJBX+j8n8mi9Uypn7oHnqQ==
X-Received: by 2002:a05:6602:1d2:: with SMTP id w18mr40948552iot.157.1563654368775;
        Sat, 20 Jul 2019 13:26:08 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id m10sm61796382ioj.75.2019.07.20.13.26.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Jul 2019 13:26:08 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     kjlu@umn.edu, smccaman@umn.edu, secalert@redhat.com,
        emamd001@umn.edu, Navid Emamdoost <navid.emamdoost@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Whitmore <johnfwhitmore@gmail.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rtl8192_init_priv_variable: null check is missing for kzalloc
Date:   Sat, 20 Jul 2019 15:25:44 -0500
Message-Id: <20190720202546.21111-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocation for priv->pFirmware may fail, so a null check is necessary.
priv->pFirmware is accessed at line 2743. I added the check and made
appropriate changes to propagate the errno to the caller.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_core.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index fe1f279ca368..5fb24b13ce5b 100644
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
@@ -2223,6 +2223,10 @@ static void rtl8192_init_priv_variable(struct net_device *dev)
 
 	priv->AcmControl = 0;
 	priv->pFirmware = kzalloc(sizeof(rt_firmware), GFP_KERNEL);
+	if (!priv->pFirmware) {
+		return -ENOMEM;
+	}
+
 
 	/* rx related queue */
 	skb_queue_head_init(&priv->rx_queue);
@@ -2236,6 +2240,8 @@ static void rtl8192_init_priv_variable(struct net_device *dev)
 	for (i = 0; i < MAX_QUEUE_SIZE; i++)
 		skb_queue_head_init(&priv->ieee80211->skb_drv_aggQ[i]);
 	priv->rf_set_chan = rtl8192_phy_SwChnl;
+
+	return 0;
 }
 
 /* init lock here */
@@ -2605,7 +2611,10 @@ static short rtl8192_init(struct net_device *dev)
 		memcpy(priv->txqueue_to_outpipemap, queuetopipe, 9);
 	}
 #endif
-	rtl8192_init_priv_variable(dev);
+	err = rtl8192_init_priv_variable(dev);
+	if (err) {
+		return err;
+	}
 	rtl8192_init_priv_lock(priv);
 	rtl8192_init_priv_task(dev);
 	rtl8192_get_eeprom_size(dev);
-- 
2.17.1

