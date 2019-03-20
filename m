Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56B6C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFDE9213F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9MUwuzL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfCTQui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 12:50:38 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38655 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbfCTQug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 12:50:36 -0400
Received: by mail-ed1-f67.google.com with SMTP id q14so2604205edr.5;
        Wed, 20 Mar 2019 09:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tyrqi2VpAsbHfhRdnfFIe+T46cwj5Y1cH69+XF0QMuY=;
        b=E9MUwuzLFVu5++s8b3AoYfiebC85EfgBVXn3N/tllIs+ScL3cdyEM72c406pr3FAaJ
         HJKWPNfnYWxJR1HYPOfhUqxmlrJuYEwLBJ4aUV0BwEq8Zj9tkslEd+G6RwhX5EtExYWs
         EWDOK+bhHqhhL3ptHzrYCPKxvpSYw7xYLssGD7AF9PLaB8i+UnlPV3M4e7UkAqUHuTHS
         +JU16ZhlWn7od/FLrB8s5oCbWIX/RB26Y5TCNNwKYChirUhXPlDeu/88GQEqYV56bqUn
         Vrv69HMXPBvfeEnVCA1RcUmbIPqrFDjlgV4xSQLHnxnrjbb9Ta3Yziq+hCg3i1CYpAU9
         B52g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tyrqi2VpAsbHfhRdnfFIe+T46cwj5Y1cH69+XF0QMuY=;
        b=R60XLoyxmZXA2h0oU/emQoAerN2YvcvpHL3DEsgpDvV10lhcxnAW+tj8ZTqGNFeL80
         YJj+QcFr9lrINOmvWqvnBKxB2aQAKbQ9cc54fIIH4YjguPcgCEUxIx94+CG4yBU+WWTl
         rv8cqJd1Vuh3Ia10nQ3z7waoqaFunHV8ob07/YGTASBJPTd/+4Xf84szZbTQtyKiFuBn
         GzmQgUOgobCPWW3DbTq8FEoBQWqZRGyd9W9eRcXUD7hJe7q3YNVGzgWoY6N+JYkM47gT
         BXq8MIS+KLHDM8Z45BDg9JlItYTu1gcy+m3WQ5ii2KwKfAxIA6stk8vTLjXI14YcxhSe
         XtqA==
X-Gm-Message-State: APjAAAXzi5BEXUzccbO0vzduIPgB738HomUOyEE1I5/sO89xAa4eFyZL
        SBeZuNIYC6Lz1/BZVk6eMkUsAEeU
X-Google-Smtp-Source: APXvYqz9nidjn4R0j8mLFg5spwEZGsy6ih55MKBnPV2ZLFzlBT1H8uFENk8i6b7WJHIBqJwhaW93mg==
X-Received: by 2002:a17:906:6003:: with SMTP id o3mr8560723ejj.128.1553100634134;
        Wed, 20 Mar 2019 09:50:34 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id f5sm808254ede.94.2019.03.20.09.50.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 09:50:33 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 1/3] net: phy: mdio-bcm-unimac:  Remove print of base address
Date:   Wed, 20 Mar 2019 09:45:15 -0700
Message-Id: <20190320164517.29608-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190320164517.29608-1-f.fainelli@gmail.com>
References: <20190320164517.29608-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
pointers are being hashed when printed. Displaying the virtual memory at
bootup time is not helpful, especially given we use a dev_info() which
already displays the platform device's address.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/phy/mdio-bcm-unimac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/mdio-bcm-unimac.c b/drivers/net/phy/mdio-bcm-unimac.c
index 8295bc7c8c20..3a592629dc7e 100644
--- a/drivers/net/phy/mdio-bcm-unimac.c
+++ b/drivers/net/phy/mdio-bcm-unimac.c
@@ -292,7 +292,7 @@ static int unimac_mdio_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, priv);
 
-	dev_info(&pdev->dev, "Broadcom UniMAC MDIO bus at 0x%p\n", priv->base);
+	dev_info(&pdev->dev, "Broadcom UniMAC MDIO bus\n");
 
 	return 0;
 
-- 
2.17.1

