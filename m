Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6105C2D0CD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 22:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B99C621775
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 22:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="DNYpCwjR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfLQWM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 17:12:59 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:38942 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbfLQWM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 17:12:58 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 47cspL2g6wz9vhYW
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 22:12:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0lgM2ZmSJHYb for <linux-kernel@vger.kernel.org>;
        Tue, 17 Dec 2019 16:12:58 -0600 (CST)
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com [209.85.219.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 47cspL1ThZz9vhYD
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 16:12:58 -0600 (CST)
Received: by mail-yb1-f197.google.com with SMTP id a5so10463298ybo.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 14:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0uFNmttIbgEixEQfkRt9NeBoHzK1PNMtttJQCP/z7Fk=;
        b=DNYpCwjR4shJbOjgE5YrLYW9gmNiz47YdUF4F7UbbW9oBFc09y8TVTxyj/xXSZQTbG
         tu5JjDveGOXqvFB61cbxl9ZzOq6e4VRFkS/pEtJahwRbdZ0YeEePl7U5W5sSYaI4IgUv
         GdwmxCk5eRzjDP6jCoTOxk36kGaPiy6tFTNFBXBmJMCYS16H6HVa/61UWdqCI/zt1wG2
         INPelGTZVqVpAcdbScirJLJJ2VJVjgO6pXfH33nGuJcyOxQlK9MUOytCZKXqV5qVF4oN
         syd0FmIBTHcc7IfmR5i2QuQn9im2LV0s7jPkS12KT5Ej3vohnDCXd7J+EZyyTdmCakRT
         PAkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0uFNmttIbgEixEQfkRt9NeBoHzK1PNMtttJQCP/z7Fk=;
        b=fuVQRDr3onA+DvzMDBW5H9rJwXHeOiHebdK6nYkaKK2Yv7BWox699Q3GhaKawnaVVO
         AmeGhdNGeyztE0F10hUfRlIgflSZ1/WcJ6TVkCJpYUpyws6EWlE5N4rbrXsETR+bLOFy
         8NCmiMETArEMA95UFAXXshsOrjNS0fwBDTVKBA7vlbqWYPt9A/itvblBMFhiKHGMXMf0
         enM+x33GB2NTpCoyZFMLyTURr7jTosVVBtFsQl3MpzkWIwU3uQxP2z6pJ4wPfY+Dq93m
         yEA+xQ9yU9QcBrJFvoY71kKoJaDyIrE/9L7A1hIA9TV0wD7PFW8y1ra6iEjzQastbclb
         Gg5g==
X-Gm-Message-State: APjAAAUEfT81ULKpvBpShIIw4LTTtdZbPQtm+Mm5RD9TyvkQrJou2h+z
        4SAeNoRewocqeqi/ffWa3JCTB+Axl0e3x5r46tdIMP0p7gqqyIp0nhjpdWTYbT9PWspRWDu0Y0V
        XICgmP85Mec0VAcv/bTLCJb6zSgbu
X-Received: by 2002:a25:6044:: with SMTP id u65mr282115ybb.520.1576620777654;
        Tue, 17 Dec 2019 14:12:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqzPAFKcOJX5u8YbRerKIyVLj2u2RXfboLCHwoqIDad4F/tedwfp2jbvHuUfyo1GEJGTU7X68A==
X-Received: by 2002:a25:6044:: with SMTP id u65mr282093ybb.520.1576620777428;
        Tue, 17 Dec 2019 14:12:57 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id l74sm80859ywc.45.2019.12.17.14.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 14:12:57 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] media: davinci/vpfe_capture.c: Avoid BUG_ON for register failure
Date:   Tue, 17 Dec 2019 16:12:54 -0600
Message-Id: <20191217221254.1078-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In vpfe_register_ccdc_device(), failure to allocate dev->hw_ops
fields calls BUG_ON(). This patch returns the error to callers
instead of crashing. The issue was identified by a static
analysis tool.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
v1: Fixed the type to a regular variable instead of a pointer,
also added fixes suggested by Ezequiel Garcia.
---
 drivers/media/platform/davinci/vpfe_capture.c | 31 ++++++++++---------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/media/platform/davinci/vpfe_capture.c b/drivers/media/platform/davinci/vpfe_capture.c
index 916ed743d716..a3838a2e173f 100644
--- a/drivers/media/platform/davinci/vpfe_capture.c
+++ b/drivers/media/platform/davinci/vpfe_capture.c
@@ -168,21 +168,22 @@ int vpfe_register_ccdc_device(const struct ccdc_hw_device *dev)
 	int ret = 0;
 	printk(KERN_NOTICE "vpfe_register_ccdc_device: %s\n", dev->name);
 
-	BUG_ON(!dev->hw_ops.open);
-	BUG_ON(!dev->hw_ops.enable);
-	BUG_ON(!dev->hw_ops.set_hw_if_params);
-	BUG_ON(!dev->hw_ops.configure);
-	BUG_ON(!dev->hw_ops.set_buftype);
-	BUG_ON(!dev->hw_ops.get_buftype);
-	BUG_ON(!dev->hw_ops.enum_pix);
-	BUG_ON(!dev->hw_ops.set_frame_format);
-	BUG_ON(!dev->hw_ops.get_frame_format);
-	BUG_ON(!dev->hw_ops.get_pixel_format);
-	BUG_ON(!dev->hw_ops.set_pixel_format);
-	BUG_ON(!dev->hw_ops.set_image_window);
-	BUG_ON(!dev->hw_ops.get_image_window);
-	BUG_ON(!dev->hw_ops.get_line_length);
-	BUG_ON(!dev->hw_ops.getfid);
+	if (!dev->hw_ops.open ||
+			!dev->hw_ops.enable ||
+			!dev->hw_ops.set_hw_if_params ||
+			!dev->hw_ops.configure ||
+			!dev->hw_ops.set_buftype ||
+			!dev->hw_ops.get_buftype ||
+			!dev->hw_ops.enum_pix ||
+			!dev->hw_ops.set_frame_format ||
+			!dev->hw_ops.get_frame_format ||
+			!dev->hw_ops.get_pixel_format ||
+			!dev->hw_ops.set_pixel_format ||
+			!dev->hw_ops.set_image_window ||
+			!dev->hw_ops.get_image_window ||
+			!dev->hw_ops.get_line_length ||
+			!dev->hw_ops.getfid)
+		return -EINVAL;
 
 	mutex_lock(&ccdc_lock);
 	if (!ccdc_cfg) {
-- 
2.20.1

