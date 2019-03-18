Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD8AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C53121741
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="H2L+S9Z6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbfCRRmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 13:42:55 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35031 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbfCRRmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 13:42:51 -0400
Received: by mail-wr1-f66.google.com with SMTP id w1so12122292wrp.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 10:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QPEhRdufwgAZYTDdFSZ0zL94MWUicqACK7npR8tFhT0=;
        b=H2L+S9Z6xOtYjw1Q1fOkqA1D/oUrMYed1eqCpDsWzLbkMDQsCOmlvh4cmhlrR0009o
         pMXiCerg1JdNd/ks8U5mfsjvfTlkHcFr9GgeV19LkY4M/cxo1SKUf0i+vZxjzZftaR76
         15MLi0Y+RnbGVK/gsUmU/cqoMWMuAS493bCFfjd0l9jVRmnfctAAEfr44rHcE9kinWCZ
         7u24jTMukDsd+Wr0TamvrP4INXeJCFEiVcR0doC/y8ImpUly6EBnuImBo1vAvi+of/U9
         gGiKuwc9Pp5YGAwFnZ4gUJWGwnSso2Liu2UA+mVzV2tSXedJEfSG7abrcdSdhzR6LGAw
         y/kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QPEhRdufwgAZYTDdFSZ0zL94MWUicqACK7npR8tFhT0=;
        b=uO4fdqM9tYUr67qO7Ug1+EAEfJWlEY8QYqrJjQkbg+xAfpccckk/Bbw49v04NceeqR
         VliA12GxdKotKirh5b+w5LwFzz4/OT3sMOO5E0vx8M3SfIhqA1wR7ClQmeRyoQLt8mu2
         WP/SYv1R0FAFRKsdazITtVlPgiEjRRdWrSODe2GHoy4AqcLqKcfd9QNleNvXM3pIf/6P
         pMRaekMIOQcvxBWDARUTVihlfKQ6tt5bumXglOhj+lxccYyGtt9XlrbrwSzZ9EwQCdTt
         27hlJtkkNdaHP0mQIA+LKQBGd4Wo4f4RBRHx8bn8Jq4gBUGJBCqmlbaMJvywcUJsPZKG
         DhcQ==
X-Gm-Message-State: APjAAAUYB7onXoVqPwcO7FM3PyF6W/vHveO7uqkGsnMuOKmpybq5cgOh
        Irw+j9AGsbULqFWARVUQBsAuXg==
X-Google-Smtp-Source: APXvYqwMIYPvjxS6BYk+Y/kuefrEYGSvx/VKhBWvyJ2frLqtFFHE/x+UGywhhvzIAHiUg5zLnPqKYQ==
X-Received: by 2002:adf:d4c6:: with SMTP id w6mr12957669wrk.65.1552930969488;
        Mon, 18 Mar 2019 10:42:49 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id g24sm14873909wmh.45.2019.03.18.10.42.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 10:42:48 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH v6 11/11] MAINTAINERS: add an entry for max77650 mfd driver
Date:   Mon, 18 Mar 2019 18:42:28 +0100
Message-Id: <20190318174228.18194-12-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190318174228.18194-1-brgl@bgdev.pl>
References: <20190318174228.18194-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

I plan on extending this set of drivers so add myself as maintainer.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e17ebf70b548..6f19949111d5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9397,6 +9397,20 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/sound/max9860.txt
 F:	sound/soc/codecs/max9860.*
 
+MAXIM MAX77650 PMIC MFD DRIVER
+M:	Bartosz Golaszewski <bgolaszewski@baylibre.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/*/*max77650.txt
+F:	Documentation/devicetree/bindings/*/max77650*.txt
+F:	include/linux/mfd/max77650.h
+F:	drivers/mfd/max77650.c
+F:	drivers/regulator/max77650-regulator.c
+F:	drivers/power/supply/max77650-charger.c
+F:	drivers/input/misc/max77650-onkey.c
+F:	drivers/leds/leds-max77650.c
+F:	drivers/gpio/gpio-max77650.c
+
 MAXIM MAX77802 PMIC REGULATOR DEVICE DRIVER
 M:	Javier Martinez Canillas <javier@dowhile0.org>
 L:	linux-kernel@vger.kernel.org
-- 
2.20.1

