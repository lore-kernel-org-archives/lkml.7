Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A1BC07542
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 01:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCABF214DA
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 01:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqNvPaBD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbfEZBTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 21:19:51 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:34884 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727651AbfEZBTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 21:19:37 -0400
Received: by mail-ua1-f67.google.com with SMTP id r7so2942529ual.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 18:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Imxy4FIzXGlW8y0z9ilHAlomSGYSr70A21L+In0BBYc=;
        b=eqNvPaBDo/7oaFVzhHSOuqp1POemOSpyAdtznI7ZQXgtOwUagFDUYrAB5fAj94ja7S
         AZqET18vAWsM1Ng8Y8JeooWH2wiLWGz+M9bh4rXIdXQk+nNNec32G+QA27YRA+wHA2gp
         hjEsoAh7dPSwVQ50jGYqOgejH4Z+jX6VkRrdt+4I7eo/H6sPeoWwKmAMSec0xBijR+tx
         zvZuRXPsjKu2E5dNcJDWX28bIQ4EC30LKSvvcezzLdATwmoFB67msbqxLzsMegeMmeWS
         +74n2gkn4noofNgWP2QspJDf0cbLQKiNRrs938ASoU8VsMrt+BfcXGlWWn+zvj5xhZ3r
         12sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Imxy4FIzXGlW8y0z9ilHAlomSGYSr70A21L+In0BBYc=;
        b=ZkCHDDIQEbWuX1R0zNJlCvce/snqpWo2O2OpeNVYWWVqnw2P7tlIcKrtrn4+DakC5k
         mR/7M13jgWoHHFkfyalycbSD59kSU91pdmPyHam3p9PSAcfBH+gCJYhq8cNRYgIIgHGs
         IOrilVvg0yf/kImUe/WTRGSN3dqciu4EFZruS7eDFEoClX81v9U5pSVrGM+GkWEkRVa6
         Cyo2ZVYV6PCHXUi//jaPDcglUp3hBCJf47cJGXfYq9leHz5vQNKYpQkbD/TUiS+SW614
         3VfultQFYjIJeAWxMK/ZXYh3pFvX/GeuJi2ithfUg4qDkaW3/1QvlflNlUxRt2PT9761
         22qA==
X-Gm-Message-State: APjAAAWgrSysgY89bCXuk9qtaiHYFPlNrfdZN35mwaxUNz3j/D7WNthZ
        A1xh7cjrsCVqj/CeXsbIotE=
X-Google-Smtp-Source: APXvYqy7ppjxC9jSRkcnPosK92+pZuTAivGtcR7d9X1YTBX4Us+MU33TMUxM8EdNVlS0r4QTlHQfkw==
X-Received: by 2002:ab0:e08:: with SMTP id g8mr31063665uak.32.1558833576420;
        Sat, 25 May 2019 18:19:36 -0700 (PDT)
Received: from arch-01.home (c-73-132-202-198.hsd1.md.comcast.net. [73.132.202.198])
        by smtp.gmail.com with ESMTPSA id 9sm4593181vkk.43.2019.05.25.18.19.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 25 May 2019 18:19:35 -0700 (PDT)
From:   Geordan Neukum <gneukum1@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Geordan Neukum <gneukum1@gmail.com>
Subject: [PATCH 6/8] staging: kpc2000: kpc_i2c: fail probe if unable to get I/O resource
Date:   Sun, 26 May 2019 01:18:32 +0000
Message-Id: <8b879ef19e5dd7520ac80c3f93c47ff63a8e1b6e.1558832514.git.gneukum1@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558832514.git.gneukum1@gmail.com>
References: <cover.1558832514.git.gneukum1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kpc_i2c driver attempts to map its I/O space without verifying
whether or not the result of platform_get_resource() is NULL. Make the
driver check that platform_get_resource did not return NULL before
attempting to use the value returned to map an I/O space.

Signed-off-by: Geordan Neukum <gneukum1@gmail.com>
---
 drivers/staging/kpc2000/kpc2000_i2c.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/kpc2000/kpc2000_i2c.c b/drivers/staging/kpc2000/kpc2000_i2c.c
index e4bbb91af972..452052bf9476 100644
--- a/drivers/staging/kpc2000/kpc2000_i2c.c
+++ b/drivers/staging/kpc2000/kpc2000_i2c.c
@@ -587,6 +587,9 @@ static int pi2c_probe(struct platform_device *pldev)
 	priv->adapter.algo = &smbus_algorithm;
 
 	res = platform_get_resource(pldev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENXIO;
+
 	priv->smba = (unsigned long)ioremap_nocache(res->start, resource_size(res));
 
 	platform_set_drvdata(pldev, priv);
-- 
2.21.0

