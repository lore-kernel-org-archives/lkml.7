Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C38FEC4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 14:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 939402067B
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 14:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfWRRRQJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731195AbfIROET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 10:04:19 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51715 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbfIROES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 10:04:18 -0400
Received: by mail-wm1-f67.google.com with SMTP id 7so248234wme.1;
        Wed, 18 Sep 2019 07:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cB7wK5jh53B0dhxFCR/qrhHtfE6JVJ/GUCjzuGEyTXc=;
        b=WfWRRRQJVFwRQPzH8aFSxOIHzq/Sk55lYneF69JJ+fF9bQaXq2PK7F79y2tg29gNAl
         qk9O9EBTqLVgXUoyLIQsCvoJQV0X+WLdfXUNHsl5ZueNsONcIV8sHNbxZ6pN5Y6xVPdU
         KgVZZXg1VMY8T00YujYyvhsejrYg0pMbvasPfqtgxTkewS0isJ+ATmYYeq/VKF/nruBa
         SybxcOlnKwT3GF601lim/ZCzAOjt+ms0ywc7pR1h04fi1w0MWUQVyJ26JDA4Mj2BLdl2
         yHkzALwgxeIsBC8uGwjrEcawD6raiE/4uAEeVFCuyRg5Pr4XweuhqsJ+BGhIImCRcGI/
         g3Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cB7wK5jh53B0dhxFCR/qrhHtfE6JVJ/GUCjzuGEyTXc=;
        b=fxGUzieVcpAXODXB/I8VQGFxDIZkoM2YX7KJEpFMPRs42kjRRJNu7gBaziELW8SjwN
         aTJ9g8+XCetJL01Ek7mI6UKh+oir1Euhcc1QY0p7qOtxyyloQ+V62HT2W1WNg9zNFU/M
         pOrOn0T4fUOGkhTwmEhoStD0r/39A9W6TNSyr03wnhqMVIC5C7mcbYkXifEViRNK3nL7
         YV4mVqLRNBrU57KCpZAz8xz2mqTaTxAEn8RNR63oupFMK9utYCYmrhokjlXA1WaN+H4h
         B1KnFKrL4Z6ExLNdNhIJ/pTM902IIJXBwkc6qe765BVoCvjNkG2mVv9USD57cdjZuTK6
         BcwQ==
X-Gm-Message-State: APjAAAUwk2XNzx3H8yi6ODJ585B2L3jLMZCD2C3syASHO2AjKmA9OJUu
        h743BKjOtnS8wBlKg1iX5Gw7pKyzLYo=
X-Google-Smtp-Source: APXvYqzLsTqjT8/wlcD9sqvhOIA8h00p1kZc5mPwnx5tNvtpVAJYor1ocWzY6xTw5xaqNcHJ2WKQAQ==
X-Received: by 2002:a1c:7d8e:: with SMTP id y136mr2984723wmc.83.1568815456240;
        Wed, 18 Sep 2019 07:04:16 -0700 (PDT)
Received: from bfk-3-vm8-e4.cs.niisi.ras.ru (t109.niisi.ras.ru. [193.232.173.109])
        by smtp.gmail.com with ESMTPSA id a13sm13725450wrf.73.2019.09.18.07.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 07:04:15 -0700 (PDT)
From:   Peter Mamonov <pmamonov@gmail.com>
To:     andrew@lunn.ch
Cc:     Peter Mamonov <pmamonov@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net/phy: fix DP83865 10 Mbps HDX loopback disable function
Date:   Wed, 18 Sep 2019 17:03:40 +0300
Message-Id: <20190918140340.21032-1-pmamonov@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the DP83865 datasheet "The 10 Mbps HDX loopback can be
disabled in the expanded memory register 0x1C0.1." The driver erroneously
used bit 0 instead of bit 1.

Signed-off-by: Peter Mamonov <pmamonov@gmail.com>
---
 drivers/net/phy/national.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/national.c b/drivers/net/phy/national.c
index 2addf1d3f619..4892e785dbf3 100644
--- a/drivers/net/phy/national.c
+++ b/drivers/net/phy/national.c
@@ -110,11 +110,14 @@ static void ns_giga_speed_fallback(struct phy_device *phydev, int mode)
 
 static void ns_10_base_t_hdx_loopack(struct phy_device *phydev, int disable)
 {
+	u16 lb_dis = 1 << 1;
+
 	if (disable)
-		ns_exp_write(phydev, 0x1c0, ns_exp_read(phydev, 0x1c0) | 1);
+		ns_exp_write(phydev, 0x1c0,
+			     ns_exp_read(phydev, 0x1c0) | lb_dis);
 	else
 		ns_exp_write(phydev, 0x1c0,
-			     ns_exp_read(phydev, 0x1c0) & 0xfffe);
+			     ns_exp_read(phydev, 0x1c0) & ~lb_dis);
 
 	pr_debug("10BASE-T HDX loopback %s\n",
 		 (ns_exp_read(phydev, 0x1c0) & 0x0001) ? "off" : "on");
-- 
2.23.0

