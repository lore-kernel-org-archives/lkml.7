Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFE7ECE58D
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 21:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 152B8222BD
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 21:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qCE2en8Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503691AbfJQVpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 17:45:12 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51658 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503658AbfJQVpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 17:45:11 -0400
Received: by mail-wm1-f68.google.com with SMTP id 7so4064134wme.1;
        Thu, 17 Oct 2019 14:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PCOLljvXe8wEsk3nOLl7b8/nQ9xZqqDiXCyuw9tmtas=;
        b=qCE2en8YiYuWVUHwc9Tg7rYNfIjRkWfJiyxJADJj1L9B9p8kP/aUQpWOKx/c0L54Bb
         lyGNdHi19Xxmfnw+DVm7qDSaWPYZDcpRFL6mAHPkjVhjcJ5TfZp25/Gd/vaChLo2oO8i
         qDWCwbPhy/g+I45MgBuf4vvTDVSghettgzJz9CwRcUKK6YbkbI6EKk8l3/hMQR3QyU/S
         elIaqHFpRxQeNd2mouJBfE13FV5b+wpSUzpDjwtTdSqO1wnF5XtTIyuStC1WgMbgSy3u
         nD0JWISL9+Cuz5CyBkIHi68ktbgxgO9umtFLoKhY2upC4sk2WXbTO0+Cb/0Sv4+X0CYk
         H8aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PCOLljvXe8wEsk3nOLl7b8/nQ9xZqqDiXCyuw9tmtas=;
        b=TQ0F/jQbHCU7G4hKd0NlhSvkHUYr7s0H2oNyVNHT+/0vQva1VLDeBwxTlvWZuodZvE
         I3atH4x4GwkydPDZ06UP8kyY4/JU9cDM9IKl7EWJ06Y0IJeahxeMddmK6xJZKEbB9Fw6
         9fz4ZiBxV/yPqpD2b4zZOKxBW7Siu5VvjRzvK2N0dOu9jmXD03zuJ05KX11zzGZAtCv/
         CrgamOCKwnkDliCpd43uTk9moBSn3aWce2vJJIckn6meR3creGyy+/ReBJVEomc60M1P
         +MS43ORvTUTBcpUreLDgSFdsa/TclmizWzHPGCehzgGwN9q46hShbzH31UEQHiP2uY7D
         yFQw==
X-Gm-Message-State: APjAAAWMj9Q5ytz/RqCQeQNwW9JsqmtcWX3z+dzlZ9sCspv2awww9Bzi
        WkbcR3wagJ90AI+Q5UQ71Nw4wmby
X-Google-Smtp-Source: APXvYqzX4QrkFfkDgpU0MxSueB7cSSaw1LmxiI5JyQv7rVblguFPAky7YkPkJMLGnUTv634UAt8rLw==
X-Received: by 2002:a1c:7ed7:: with SMTP id z206mr4576363wmc.104.1571348708480;
        Thu, 17 Oct 2019 14:45:08 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id t203sm3977294wmf.42.2019.10.17.14.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 14:45:07 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org (open list), hkallweit1@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, olteanv@gmail.com,
        rmk+kernel@armlinux.org.uk, cphealy@gmail.com,
        Jose Abreu <joabreu@synopsys.com>
Subject: [PATCH net-next v2 1/2] net: phy: Use genphy_loopback() by default
Date:   Thu, 17 Oct 2019 14:44:52 -0700
Message-Id: <20191017214453.18934-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191017214453.18934-1-f.fainelli@gmail.com>
References: <20191017214453.18934-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The standard way of putting a PHY device into loopback is most often
suitable for testing. This is going to be necessary in a subsequent
patch that adds RGII debugging capability using the loopback feature.

Clause 45 PHYs are not supported through a generic method yet.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/phy/phy_device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 9d2bbb13293e..7fa728c44632 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1513,8 +1513,10 @@ int phy_loopback(struct phy_device *phydev, bool enable)
 
 	if (phydev->drv && phydrv->set_loopback)
 		ret = phydrv->set_loopback(phydev, enable);
-	else
+	else if (phydev->is_c45)
 		ret = -EOPNOTSUPP;
+	else
+		ret = genphy_loopback(phydev, enable);
 
 	if (ret)
 		goto out;
-- 
2.17.1

