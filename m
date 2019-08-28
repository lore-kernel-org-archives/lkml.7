Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68EEC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 08:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CFB821883
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 08:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tjb1f4/6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfH1IeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 04:34:17 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56132 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfH1IeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 04:34:16 -0400
Received: by mail-wm1-f65.google.com with SMTP id f72so1784627wmf.5;
        Wed, 28 Aug 2019 01:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tJ4HvhBaOqQ5mX9jjF9JvnIN+/qxCaDx+y5xL+GE6os=;
        b=tjb1f4/6HpYwTo7QiPyOgZMpi5abzmHJBxBJajvA0uTevAG86iDC9yhFBrxjObVEBh
         pzHEmlemLckIjFg1IWnV/iknqGE/8MNWEGkOSAdWFJ2HfQBAfiH3Ft0i/LGj69w9kX5G
         eyNCwJjefNVAGdP8ctsNQiYaaxAIBpTBSDwPyo4W03p8owDYv9cKN0jFxoUcsbpXnlC5
         IK6G1z4Zh5TDg9POATuUU+Uifk2ToKqBqU9vexkmFRBX3FoFSayBbypx516KWZw0BP4v
         73YVVy+HLdhi92r5e75uvzI8jIFA2//3F7eKf7otcnjizBR/sl89mivlYjS/TbDRP6o+
         3MHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tJ4HvhBaOqQ5mX9jjF9JvnIN+/qxCaDx+y5xL+GE6os=;
        b=rEa3DaZPpLY1LL9IBu6uDfYYZZDIj0o5IGAKKlP9XC7E/Of8z+SN4cSbjrpmCbgCyB
         yzBqG172NfqkhxPiRQK0VXkgkNxgoK9S+EeEOln2Q6y6p6GlgvOn+hZ6rnTm4TIoR71i
         cxMfdNkJYJhZPpBjdxZXOG60fe2Dzkc2psx0x+Scqsfb0EQJ3YVj91+R3n69yL3yHWrt
         3RZefX9N39xw4jmc2nl270vAYCrwN2Fo+ov1IPZOYy7Oy1G6uZxfj7atrbQKjKnSNP5c
         dOATO54S5GFuyhOtIbQJFP9TSm+icCdYtGVO5ad/7LTLBUROUSAIuQumHlMlKNebmMAT
         +SMg==
X-Gm-Message-State: APjAAAWLdmon9V3J+6WHZNVn8feB8rEj57nJZhvPQHeQn2P6YHC7Cog6
        d/GHdPPdCTknXyLJyfXLQmI=
X-Google-Smtp-Source: APXvYqw3WsWTir6hcLrW2rc3QjhvTmj2kqvyzQC8ZnbRW0nV/dVqn49aCokv+QKAB+1E1tl+YEpB4Q==
X-Received: by 2002:a1c:6782:: with SMTP id b124mr3469626wmc.143.1566981254070;
        Wed, 28 Aug 2019 01:34:14 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id a141sm7885864wmd.0.2019.08.28.01.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 01:34:13 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Stephen Boyd <swboyd@chromium.org>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] driver core: platform: Introduce platform_get_irq_optional()
Date:   Wed, 28 Aug 2019 10:34:10 +0200
Message-Id: <20190828083411.2496-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

In some cases the interrupt line of a device is optional. Introduce a
new platform_get_irq_optional() that works much like platform_get_irq()
but does not output an error on failure to find the interrupt.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/base/platform.c         | 22 ++++++++++++++++++++++
 include/linux/platform_device.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 8ad701068c11..0dda6ade50fd 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -192,6 +192,28 @@ int platform_get_irq(struct platform_device *dev, unsigned int num)
 }
 EXPORT_SYMBOL_GPL(platform_get_irq);
 
+/**
+ * platform_get_irq_optional - get an optional IRQ for a device
+ * @dev: platform device
+ * @num: IRQ number index
+ *
+ * Gets an IRQ for a platform device. Device drivers should check the return
+ * value for errors so as to not pass a negative integer value to the
+ * request_irq() APIs. This is the same as platform_get_irq(), except that it
+ * does not print an error message if an IRQ can not be obtained.
+ *
+ * Example:
+ *		int irq = platform_get_irq_optional(pdev, 0);
+ *		if (irq < 0)
+ *			return irq;
+ *
+ * Return: IRQ number on success, negative error number on failure.
+ */
+int platform_get_irq_optional(struct platform_device *dev, unsigned int num)
+{
+	return __platform_get_irq(dev, num);
+}
+
 /**
  * platform_irq_count - Count the number of IRQs a platform device uses
  * @dev: platform device
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 37e15a935a42..35bc4355a9df 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -58,6 +58,7 @@ extern void __iomem *
 devm_platform_ioremap_resource(struct platform_device *pdev,
 			       unsigned int index);
 extern int platform_get_irq(struct platform_device *, unsigned int);
+extern int platform_get_irq_optional(struct platform_device *, unsigned int);
 extern int platform_irq_count(struct platform_device *);
 extern struct resource *platform_get_resource_byname(struct platform_device *,
 						     unsigned int,
-- 
2.22.0

