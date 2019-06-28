Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E61DC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 17:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22EC820645
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 17:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oyjcbN2l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfF1RB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 13:01:27 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35715 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfF1RB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 13:01:27 -0400
Received: by mail-pf1-f196.google.com with SMTP id d126so3286551pfd.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 10:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=J2qU6wxItaN+5UOKiNyRuRQUOCoMmYGGmRV9X2UEAB0=;
        b=oyjcbN2lX1WBUwPMzm3jTHw1zIbFhqHIXzZCu18PpVhGMNLZPYKzd2T7h4Olcs5F8h
         OE2N+ycy0wVbbv2X9ysNoTR0+7uSlD+dJlqvLK0GI/mCoT4v5f5uO/7hQxAFRSLclecH
         nEfrVMtwdKtfLnrFT09wf4QAOCaAVPE3p8UobEQ7dG0Rh1F/KLjRDu1SSHucmiw+52i1
         D0SFzEJXe6TqExYmTgVPxxcLn8XKi8ctXt3sWCgxPHcymet84VENF4LOaC8/piXu2j1U
         NUT1Z1x8tvy3/vLS90LXigOiHo9xFU1Y9csh/fNie4Pe18jSgyXtGSQGLU0pFHGv9Pts
         OI2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=J2qU6wxItaN+5UOKiNyRuRQUOCoMmYGGmRV9X2UEAB0=;
        b=T8FKKJd5qqYA1DxzYuQ0iPCmd2/6+T60AaN4Dr2jQqXzICnH/09VqqNSxog8h86l/k
         jiOaVWibbx0AO03+nGzoRVLaSIlKiflKLWAtj92NwH+ZMNy3QxLQu1WRqwObe6FsL/8w
         vFSdlWITZ34Y9kPo3d8bE/jsdxScG2LiXLCXKtT7RK2W11mGEny4Nd1cnGPW/BrtFC94
         bL0n178ftwDP0X559vE/qmJprrmvoQrmoYk5mT391qnRsCwMkTp3qZjsNtqSUclYnlxj
         9qPHzjPlsj9VaCT6HSiZ7NhUvAAs64WykloKV9KoKFB8in0EQf+XKVDMQ3smQ5MgBrdJ
         qwSQ==
X-Gm-Message-State: APjAAAVNHvmAoq1i5KCyH5G5RASP4IhBYHBj7K5eid+foGtxwlkiG5ND
        nFFISeDyPoq8vcvop8tTlek=
X-Google-Smtp-Source: APXvYqx7NUoJjLJ7Ej3UT9NKouWUfnRQFNGJrRhWyW8A2GnpAkqx3LbI9H1vYjMcj1/6UC7Ez2lbBw==
X-Received: by 2002:a17:90a:6097:: with SMTP id z23mr14446976pji.75.1561741286876;
        Fri, 28 Jun 2019 10:01:26 -0700 (PDT)
Received: from localhost.localdomain ([183.83.73.90])
        by smtp.gmail.com with ESMTPSA id 30sm2971033pjk.17.2019.06.28.10.01.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 10:01:26 -0700 (PDT)
From:   Harsh Jain <harshjain32@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, harshjain32@gmail.com,
        harshjain.prof@gmail.com
Subject: [PATCH 1/2] staging:kpc2000:Fix symbol not declared warning
Date:   Fri, 28 Jun 2019 22:30:45 +0530
Message-Id: <20190628170046.3219-2-harshjain32@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190628170046.3219-1-harshjain32@gmail.com>
References: <20190628170046.3219-1-harshjain32@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: root <harshjain32@gmail.com>

It fixes "symbol was not declared. Should it be static?"
sparse warning.

Signed-off-by: Harsh Jain <harshjain32@gmail.com>
---
 drivers/staging/kpc2000/kpc_i2c/i2c_driver.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc_i2c/i2c_driver.c b/drivers/staging/kpc2000/kpc_i2c/i2c_driver.c
index 0fb068b2408d..204f33d0dc69 100644
--- a/drivers/staging/kpc2000/kpc_i2c/i2c_driver.c
+++ b/drivers/staging/kpc2000/kpc_i2c/i2c_driver.c
@@ -614,7 +614,7 @@ static const struct i2c_algorithm smbus_algorithm = {
 /********************************
  *** Part 2 - Driver Handlers ***
  ********************************/
-int pi2c_probe(struct platform_device *pldev)
+static int pi2c_probe(struct platform_device *pldev)
 {
     int err;
     struct i2c_device *priv;
@@ -664,7 +664,7 @@ int pi2c_probe(struct platform_device *pldev)
     return 0;
 }
 
-int pi2c_remove(struct platform_device *pldev)
+static int pi2c_remove(struct platform_device *pldev)
 {
     struct i2c_device *lddev;
     dev_dbg(&pldev->dev, "pi2c_remove(pldev = %p '%s')\n", pldev, pldev->name);
-- 
2.17.1

