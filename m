Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E35C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8363D217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="gYpzShV4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfDKMmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 08:42:33 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40288 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbfDKMm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 08:42:28 -0400
Received: by mail-wr1-f65.google.com with SMTP id h4so7153634wre.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 05:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QumGHYgGUfQaDtIR5geLWZWiBgPfK1JHFl24Y9wsU1E=;
        b=gYpzShV4J6Wc627ki4uaFvs7JkEeCdLpuxdMhDDFxZhA6JDUIMw19Ss1Qu4me0NxwK
         pUCg3DC7iq7eeiDJutvGlAPNyxDaGikkzKYaSd/OrBxUptVK4EVwffswMLw2e/tdO0pB
         +v9TZcOKMYlQ2+RHY+Si1ei9peyWJ6NgVKKvmNtvZgkf48I83gb/xCREVgfW2fdoZO2T
         OJW7pApQbztp3sL0v6+4U3ffPBOgyKh/QlL1PWCjAn4EmbSZvrXeuzdXfLPjhyfF3RnA
         uUsH7A78Vbks5i45rMk0+n98JQuNuxIhOIfvTxcgHQ6ToobeUQAKW+uHFxOFbT0ZPzTr
         4b6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QumGHYgGUfQaDtIR5geLWZWiBgPfK1JHFl24Y9wsU1E=;
        b=EJv/x+6UYn4H18SGPVtoPUTRRQVqe+OxwNiSAhJI8r2GWM096TCHJMq5h7ojrs3iXg
         LfakVCLscpVDfvFVeaECu7hyspTad12GW9t2wxi7L3LGOpFqCU/v0cHePrYtxucHzCpL
         2xISUWz3nMjygKV1PYB2U3pOQhVroP7V4mZ9J7F0OYT65TPylKYAE4ta6PfNcyVNsJy3
         u9JCDgiwFE4OWELFtYsbpZAX8y2VHi+bYwzO+BcnyyOcAb7gQp9i41YooFSoxaHZc+qm
         qxySwrNjqokHtx6IOQeQWSHFAk8+zkQmpfFV3J0JVWYXodLWUWQZUIoF4uaMm06vMQPg
         Sw2g==
X-Gm-Message-State: APjAAAWxovpu0iM3hey08kj740+zYQ6Fp3XTcvsDycE80FaEbL6QLT+8
        TeCaDwuyW+rYKdplW+c47sHnOw==
X-Google-Smtp-Source: APXvYqyYWIFc1Wx664zahKFon7C+c8UtquLTGg9UghCuHQxLzA8gjfvXE/HtG4y9Tf/uiDlWFo0fZQ==
X-Received: by 2002:adf:dd8c:: with SMTP id x12mr3230809wrl.262.1554986547211;
        Thu, 11 Apr 2019 05:42:27 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id d4sm32894510wrv.42.2019.04.11.05.42.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 05:42:26 -0700 (PDT)
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
Subject: [PATCH v9 05/11] mfd: core: document mfd_add_devices()
Date:   Thu, 11 Apr 2019 14:42:06 +0200
Message-Id: <20190411124212.7612-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190411124212.7612-1-brgl@bgdev.pl>
References: <20190411124212.7612-1-brgl@bgdev.pl>
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
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
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

