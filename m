Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFD8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D20D206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="uX9rysD+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732203AbfCZRcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:32:33 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:47013 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732147AbfCZRc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 13:32:29 -0400
Received: by mail-wr1-f68.google.com with SMTP id o1so15344644wrs.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 10:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PHnAFw7KtGJWH7IB2Ih89SEfiEryiR66xDAbrjSGim0=;
        b=uX9rysD+atELAXSQzMdpP2+cO9QuRcViArirewQM6HXeybrTvwAmzrVELDom2H5FLY
         rtFQGz1tZCJHHPmuVw4o5hb1R0EVpalCmq7KB5VEOYENDdb/ENsD+gPWk0e1N4LHz52T
         78Kf/moUFvoDp4i44CBxWbzuPX54qc5RmOH9n+eEPlT/JVw20W8xvUYXyui9fVhFzFkD
         psCdo29EjVkknpGElL8vf6FSTk50ftXc+aqcTuLURPy0MGUtyjxa9SoTl+b/VsM4mVsx
         4Oge/jTIzeAoGxs6+xzqbtZsaBeAyu3J5itCaYwbEsNZnfF5Is/vAVxYIKFjOG5H1E+F
         8KLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PHnAFw7KtGJWH7IB2Ih89SEfiEryiR66xDAbrjSGim0=;
        b=DTaUGdUigbTftS85CCElCQ73HMAg3UZizWfmilMCdxuHaQrzcRN6sN0QhF9yRibhsE
         w6KmliNlmKYGLPKpPDZeBJxPbtyzGSOZ/PkxJ4n60wUcC4Ib+IV2isYjxoAyjcHmZWSQ
         fumX9PU83tbYs8Kpsy+UKRWv+HM4yyYBq5XCXG+8Y2+YRDCxbxxvJStvM2vqIURYFXcv
         5SY7T7Z06MzOaiUJm3sAIbyCVEDuVKmkaL4MkuhXiWulxnOEm1R1zfsLD1QpL9UcHTmU
         vibfU0VdjuVngFCRRxzkZ+UFJV5J8TfUpUb1pg9wHqFLLxNu6+sJ/uJLS3u04sHrHvXX
         pu6A==
X-Gm-Message-State: APjAAAUmjGSRHvueBxUDLBDFyeDWFRpBwH3Ka6XjLoJQuGKwpM2lo5FT
        mPngZY0hxuLM89UYPoN8Zj9tFg==
X-Google-Smtp-Source: APXvYqwuO8YMhLtFa0EJiZEw5Bdz2FZmrEuguS45eaXvbnKC2oJCgqQSnivCheO9nvBKOgjuP3SLLQ==
X-Received: by 2002:adf:fd88:: with SMTP id d8mr14336838wrr.320.1553621548143;
        Tue, 26 Mar 2019 10:32:28 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id 4sm2534541wmg.12.2019.03.26.10.32.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 10:32:27 -0700 (PDT)
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
Subject: [PATCH v7 05/11] mfd: core: document mfd_add_devices()
Date:   Tue, 26 Mar 2019 18:32:02 +0100
Message-Id: <20190326173208.30614-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190326173208.30614-1-brgl@bgdev.pl>
References: <20190326173208.30614-1-brgl@bgdev.pl>
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
 drivers/mfd/mfd-core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 94e3f32ce935..0898a8db1747 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -269,6 +269,20 @@ static int mfd_add_device(struct device *parent, int id,
 	return ret;
 }
 
+/**
+ * mfd_add_devices - register a set of child devices
+ *
+ * @parent: Parent device for all sub-nodes.
+ * @id: Platform device id. If >= 0, each sub-device will have its cell_id
+ *      added to this number and use it as the platform device id.
+ * @cells: Array of mfd cells describing sub-devices.
+ * @n_devs: Number of sub-devices to register.
+ * @mem_base: Parent register range resource for sub-devices.
+ * @irq_base: Base of the range of virtual interrupt numbers allocated for
+ *            this MFD device. Unused if @domain is specified.
+ * @domain: Interrupt domain used to create mappings for HW interrupt numbers
+ *          specificed in sub-devices' IRQ resources.
+ */
 int mfd_add_devices(struct device *parent, int id,
 		    const struct mfd_cell *cells, int n_devs,
 		    struct resource *mem_base,
-- 
2.20.1

