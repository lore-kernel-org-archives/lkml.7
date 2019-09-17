Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64EE9C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 22:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C4C921848
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 22:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SH7v1obY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbfIQWr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 18:47:28 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40309 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbfIQWr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 18:47:27 -0400
Received: by mail-io1-f65.google.com with SMTP id h144so11555632iof.7;
        Tue, 17 Sep 2019 15:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5VqlgmEcpDNl3x/hruHj+kY7JbEaNQvrbJRA/5fQs/E=;
        b=SH7v1obY8TSWmiqpJkDPSLoUDZaN8KB1U7FuZ3C7BoG9V73ytTD1e5J3TX/EYvjTa+
         gFaQxzstHpK2DzA/lN/L1+M8c8bjyDNVLUKfC8GMO51r49kXCuckpJOOvW5f0hw7fEIZ
         RFELv/7kR0jXb5w2sH9v+AlqDmbnvkOMfd1D3fdIiWLUbVHNfLmQaNBI8JRiZrbnpPrD
         a80xNSDVon+UpKY7wQO1wbaZD7qESJZmVOfFld+hRaXBu6ot/Ms2YERsvPtun1WugM+K
         a0FBfDwhYuQO6ipb2VuA5O3tVz9ux0EG/tvLvUAcpIPV0/4Nm4msaDO1HfhNFKBlhooy
         qqMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5VqlgmEcpDNl3x/hruHj+kY7JbEaNQvrbJRA/5fQs/E=;
        b=bhZPBQ0YURdscVNY6LiE2xPsjgqfZx+mn3gxSCLjkin0ZroD+qWeD018aW+mmCAUcC
         ZI9uZGEcn0rfs90w9G6TeerDkUQCvVjUmNscfga8Lmvyh2EdqsvD5DHyu4iH9YxnX4HL
         Pdwe7g5iL9R0D8it/sg14LGaUL7p2/NnNeFzT/Mlcw2yYrsKDhrdeJacpBSOeUq3zXhH
         uvc/IS+koyoj3AKZLlpodPwz4QFk78vu5OZaZswvdUloVwwdpZi9P4Mx/0Z0OnCcjQJ4
         NhgxA8wDNIrcVo7hfEILBZavkBod4BqeKH1mdK+FWRVwydpZmTG40yyTToAPoQI+C4+s
         N1wA==
X-Gm-Message-State: APjAAAW4R1QnBsd5yETMZ7yi1djt4yX22pJvSHmzMXMncfw42U1u9r3K
        0duScv6+bg1QODbFmpF3qEw=
X-Google-Smtp-Source: APXvYqwbItfkQfOpXkoUPdAzexGLX/v678OXhG99WTPyfexi7c41btMn7SPpVuj7QJ8qK1yuACv7cw==
X-Received: by 2002:a05:6638:681:: with SMTP id i1mr1248426jab.127.1568760446971;
        Tue, 17 Sep 2019 15:47:26 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id m9sm1533647ion.65.2019.09.17.15.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 15:47:26 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Harry Morris <h.morris@cascoda.com>,
        Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ieee802154: ca8210: prevent memory leak
Date:   Tue, 17 Sep 2019 17:47:12 -0500
Message-Id: <20190917224713.26371-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ca8210_probe the allocated pdata needs to be assigned to
spi_device->dev.platform_data before calling ca8210_get_platform_data. 
Othrwise when ca8210_get_platform_data fails pdata cannot be released.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/net/ieee802154/ca8210.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index b188fce3f641..229d70a897ca 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -3152,12 +3152,12 @@ static int ca8210_probe(struct spi_device *spi_device)
 		goto error;
 	}
 
+	priv->spi->dev.platform_data = pdata;
 	ret = ca8210_get_platform_data(priv->spi, pdata);
 	if (ret) {
 		dev_crit(&spi_device->dev, "ca8210_get_platform_data failed\n");
 		goto error;
 	}
-	priv->spi->dev.platform_data = pdata;
 
 	ret = ca8210_dev_com_init(priv);
 	if (ret) {
-- 
2.17.1

