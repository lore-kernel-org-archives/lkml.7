Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3E2C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 09:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 496A72082F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 09:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUcdj4+C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfC1Jt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 05:49:26 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:54631 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfC1JtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 05:49:25 -0400
Received: by mail-it1-f196.google.com with SMTP id w18so4931216itj.4;
        Thu, 28 Mar 2019 02:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=rfaELReaxsy67GEXFBzE+ZMN2j38wuvUnAbrDnhjxro=;
        b=LUcdj4+C2Q7RA+dbe3KXPVKiRyS6YfERTAbRSA01sNlNPQaPoyuPIbLk2S+dGBgL4O
         P69CitIflYkSjh/5n/kEGNJ83leJDAy42zSXMMqdgnAElS12OZQZj2nhNYZOuBg1LohU
         1Bz6Qapy1nps/5qP8c4N3/xuXnnw1fyXc30t7Nng8QzenQzmJaVDeNUOR6ihLLi5l9Z6
         HSNPUkBKLJZBJyMuQ8CVz+Nf4Ol4ks1agksJOCZqySRR1sQ7Ee643b8A1zjGwiM4u9+K
         rnL+KM0vu0Nn+LLbdt+lY4FXNnZ+BjV129bM5TMJUUp9op3hvmdpgFkEDH141tR6BpN/
         mYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=rfaELReaxsy67GEXFBzE+ZMN2j38wuvUnAbrDnhjxro=;
        b=Aj8P1GO/X96XsFrj9Ri7KkG29WsX3lBDZvVokF3LK95vwfd223RtaYmmjezQZ/D7IB
         Ty876ObQttEBcwbtK5+yww96b71dG17zb73k524CwRQidNA6oMZSnh6LoIhGoJJ4qrZB
         fpFMbhkcO/BGJmDSNmjWurEfzIo0MgknrbgZGJmo+haOeh7J37gE4Q0RD3k2YRr6ZhRb
         1TPMs/FwmW/UQTM8wGY8nFjYK76sZv6NoiGvuN+PRtzxMWVH+KsDXWBazo7qAWg2y+QL
         4K9nL1pRjqOF5pGGqpGnUeedVx8zqv2bQaQ7VJpi9cgXjjmWPsGKyh23LG8otSdbqrdt
         SuPg==
X-Gm-Message-State: APjAAAV58mWZknRa7VztOeOY/bSwjIhQrvM69Wg+9+kljwRpLX/5ay0J
        z7M4oJsXBElmYMIJNlHS9oc=
X-Google-Smtp-Source: APXvYqwYfonjbu8wn23GLj2DQKJoC3oeIhacxMuWQDcPLwD73S0DD9zcxQdc1NUid7HY/zjw87yEUw==
X-Received: by 2002:a24:7542:: with SMTP id y63mr2621032itc.70.1553766564352;
        Thu, 28 Mar 2019 02:49:24 -0700 (PDT)
Received: from sidong ([220.94.163.20])
        by smtp.gmail.com with ESMTPSA id 14sm1595364ity.24.2019.03.28.02.49.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 02:49:23 -0700 (PDT)
Date:   Thu, 28 Mar 2019 09:49:14 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Michael Straube <straube.linux@gmail.com>,
        Rico Schrage <rico.schrage@gmail.com>,
        Sophie Matter <sophie.matter@web.de>,
        Hugo Lefeuvre <hle@owl.eu.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH v2] staging: pi433: Fix rf69_set_tx_cfg() logic
Message-ID: <20190328094914.GA13981@sidong>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moved code to configure sync to where check enable_sync option before.
There is no need to check enable_sync twice. Configuring sync should be
executed immediately after enabling sync.

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
v2: remove obvious comment. reordered size/value/enable sync functions.

 drivers/staging/pi433/pi433_if.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index 53928af696a6..8fa7b3346170 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -319,6 +319,12 @@ rf69_set_tx_cfg(struct pi433_device *dev, struct pi433_tx_cfg *tx_cfg)
 	}
 
 	if (tx_cfg->enable_sync == OPTION_ON) {
+		ret = rf69_set_sync_size(dev->spi, tx_cfg->sync_length);
+		if (ret < 0)
+			return ret;
+		ret = rf69_set_sync_values(dev->spi, tx_cfg->sync_pattern);
+		if (ret < 0)
+			return ret;
 		ret = rf69_enable_sync(dev->spi);
 		if (ret < 0)
 			return ret;
@@ -348,16 +354,6 @@ rf69_set_tx_cfg(struct pi433_device *dev, struct pi433_tx_cfg *tx_cfg)
 			return ret;
 	}
 
-	/* configure sync, if enabled */
-	if (tx_cfg->enable_sync == OPTION_ON) {
-		ret = rf69_set_sync_size(dev->spi, tx_cfg->sync_length);
-		if (ret < 0)
-			return ret;
-		ret = rf69_set_sync_values(dev->spi, tx_cfg->sync_pattern);
-		if (ret < 0)
-			return ret;
-	}
-
 	return 0;
 }
 
-- 
2.17.1

