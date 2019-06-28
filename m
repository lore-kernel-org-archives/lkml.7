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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BBDC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 17:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3A2F208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 17:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsggN7ys"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfF1R1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 13:27:53 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:32942 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfF1R1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 13:27:53 -0400
Received: by mail-pl1-f194.google.com with SMTP id c14so3618129plo.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 10:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=b2wN17zlaOXo1nFQxwOfGzjJA08eKhEWDSV+dVCibq0=;
        b=WsggN7ys/SUW8ke0djQCUW82tfxEw/UCjel87xrBD5nq5byykXD9pblR0QjtGhSG9k
         eC1SMy0BJetgEADjjtsdRskVqDg0jLst8re0oTTcDnzZUo8Y9zq83Zk5SUSxqLVx442o
         jKx2nsdFKtC/8WmsaRWdWYZ9puP62JacPrf1fhbvs5QsHtHtdqh8p6RdY/xEjit0pXXd
         wocdDCvSSPpCUaLd2u7hp479pyXfqlj0+9a99vD3nXgh7UELNL6XzCt3z50pJERqHIrr
         ZiQWUp3CsrE/NQ04tbURiOq8j/Z16WTl7kD8inuHxcXXt4WpSeg5K1YkxqpVC2oHS4r8
         Oiuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=b2wN17zlaOXo1nFQxwOfGzjJA08eKhEWDSV+dVCibq0=;
        b=HKi6LhAeCCDAysUgCoL1jofasjN9alDC+7yG9AnFIUbRH04WqFaRyvyzfamdYL4AF1
         /lWc0AQeget0xm4Rkbfp7po0k9qOsCnBx9xH46XiI0IVeTwQ9Psz2jX4IIl7t+s1DS0G
         Dw8yLxEZC1JJ5qZegHUZgRQBX67w7Yazql64GvnUlA2AjtFy1XpRyyUW6p4tGM+MLPH/
         mkp3/jUh7MeUjBek22u35YGfL/PzxbTqdELmOmHnuh71XayQ9ZM9A1dutP9tRf8hNT27
         t1bR2JZoZFcAQOvcjIUKatbVeCGKNinI2mung/vnKaKy5dcJHQ55uvVcs0T5GDPvhd7F
         qC2g==
X-Gm-Message-State: APjAAAWECm/EyDN1JdLYZBg3aPxUMTAalsLTIeCC8C76tITrBTcT6/Uw
        jwRwnQUZSSjcm/qVtupgb30=
X-Google-Smtp-Source: APXvYqwfYH+uqnVMzIEe7KSorliBUJGyOPlBJBtICxnUDGx5/BeL2WoO9U4iOWQc82skwTJkHl5Q8w==
X-Received: by 2002:a17:902:20c8:: with SMTP id v8mr12964478plg.284.1561742872456;
        Fri, 28 Jun 2019 10:27:52 -0700 (PDT)
Received: from localhost.localdomain ([183.83.73.90])
        by smtp.gmail.com with ESMTPSA id k19sm2070490pgl.42.2019.06.28.10.27.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 10:27:52 -0700 (PDT)
From:   Harsh Jain <harshjain32@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, harshjain32@gmail.com,
        harshjain.prof@gmail.com
Subject: [PATCH 1/2] staging:kpc2000:Fix symbol not declared warning
Date:   Fri, 28 Jun 2019 22:57:23 +0530
Message-Id: <20190628172724.2689-2-harshjain32@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190628172724.2689-1-harshjain32@gmail.com>
References: <20190628172724.2689-1-harshjain32@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

