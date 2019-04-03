Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4F8C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F35D20882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="2TN7MZZf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfDCJBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 05:01:30 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45822 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbfDCJB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 05:01:28 -0400
Received: by mail-wr1-f68.google.com with SMTP id s15so929101wra.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 02:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tkqbMW/H6vEZWtLAP23yj2GkaUbuFs58uiDcw9hRulk=;
        b=2TN7MZZfNKjEq9ytrdQG8+701a4idLOUeuB9j0qR8rhS03eLqO1hnuEhX4vmtuQXNE
         MVlEozdPTeL8kYIJQU0VFlIWFr9Bh3yvbrju95I99xwso+9sfxvwlkgFptbdfr6gpQWt
         XfL19V23yuw2/pShFjepaIDZpKWn4p096YboezF6MMhf2IRUE/E1Z2rpZkUtM3M9IgA+
         4tmhR0FYv1+HiIbW9bx66BV5YBpehy7ESiaKbA5G9t+SGDILbmC35XIIYziz7m3vyPIb
         UqS/+REsXCR8a7OIo6dqmOil2F8JmDJI/+H/JICTqxDedaJ65gix7YyZccc6SyNzoRhT
         D07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tkqbMW/H6vEZWtLAP23yj2GkaUbuFs58uiDcw9hRulk=;
        b=U1p8iLUyspPNXo0+dNLPg93LkPSXh99BUAF9iw8+UOY2VVJ2vLLYj8RKlLY7rzM/rL
         DxFKuJXl6q4adSdJQtEttlVL4zZ5QK9FbRfNRFgpJalqG/sPs9R6JKrZqtz49ZfhGa/l
         +TtOp85PIqom/GPyOljqvrgOlPObNVswF8WppN5MOTIUHRrIza1ORf/Gzl6gkDQLKdx4
         Apo0aDmGgJJZglF744nW+9IRwwg/WtKRd9BHzC7tOeYrlIJRgegzRGjyhPn9Et94dQFX
         gBn21B2nToGbQ2NKmvn7jRegQsmD7dvDYCNIoY6/YiVTA7isgzXc+8+WWWTZGZXO1sGE
         e9uw==
X-Gm-Message-State: APjAAAV4Wovg4rqxzq7BsQPLwS86Xkq1vXekIi57yzCjqU8koRFaCPoc
        he/FIETXBO0+BA+riu+xgHzmcw==
X-Google-Smtp-Source: APXvYqwzicqPWSrskXNcvALbVUuWfdVSOZt7lXkW4YWuyy45jQuz/SnsHMBz2DcH5X72bNVR2FrBiQ==
X-Received: by 2002:adf:f80d:: with SMTP id s13mr47061861wrp.38.1554282086571;
        Wed, 03 Apr 2019 02:01:26 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-29-77.w90-86.abo.wanadoo.fr. [90.86.254.77])
        by smtp.gmail.com with ESMTPSA id v16sm23981998wru.76.2019.04.03.02.01.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 02:01:25 -0700 (PDT)
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
Subject: [PATCH v8 05/11] mfd: core: document mfd_add_devices()
Date:   Wed,  3 Apr 2019 11:01:02 +0200
Message-Id: <20190403090108.24788-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190403090108.24788-1-brgl@bgdev.pl>
References: <20190403090108.24788-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add a kernel doc for mfd_add_devices().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 drivers/mfd/mfd-core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 94e3f32ce935..1ade4c8cc91f 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -269,6 +269,19 @@ static int mfd_add_device(struct device *parent, int id,
 	return ret;
 }
 
+/**
+ * mfd_add_devices - register child devices
+ *
+ * @parent:	Pointer to parent device.
+ * @id:		Can be PLATFORM_DEVID_AUTO to let the Platform API take care
+ *		of device numbering, or will be added to a device's cell_id.
+ * @cells:	Array of (struct mfd_cell)s describing child devices.
+ * @n_devs:	Number of child devices to register.
+ * @mem_base:	Parent register range resource for child devices.
+ * @irq_base:	Base of the range of virtual interrupt numbers allocated for
+ *		this MFD device. Unused if @domain is specified.
+ * @domain:	Interrupt domain to create mappings for hardware interrupts.
+ */
 int mfd_add_devices(struct device *parent, int id,
 		    const struct mfd_cell *cells, int n_devs,
 		    struct resource *mem_base,
-- 
2.21.0

