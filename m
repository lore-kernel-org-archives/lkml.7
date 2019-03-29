Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B7AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0870120643
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="0BSzGfvn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbfC2JeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 05:34:13 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52023 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728743AbfC2Jdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 05:33:46 -0400
Received: by mail-wm1-f68.google.com with SMTP id 4so1780263wmf.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 02:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ze5SSoMthSUJEWILh/6R6Dx6kiGpd0KVEMFuw2rprTY=;
        b=0BSzGfvncOp+if/tJIHLno6MGS9J176p5OuCiUpvRIpwJtY2UTdoe7/x8bZzvQbwUy
         6uov2hdT4bF9A/9E6HpwTs9bu4JOG2GXE8UHxOIHMOwRbapJqNKYArovWz/LB09vYkx7
         Z7YS4oK6a7aOgz4LmJExBeZroq1pWS1YSdDLekZmHY2uPDsG27TckGUfOhQbylpj4Mg0
         8TCWDMTM73KtTcIyofhdWeOx1qqeYqqeRaNzKA7EMrLIZFK9PTTJ4WKbzGfy+R2SVxqk
         Y4ucaijH8aGjkigRxgt7WV8oW7fLIZigBVqP1FcksX4+3DCDLFya+XZlU+QBCy4lNHZ3
         5r6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ze5SSoMthSUJEWILh/6R6Dx6kiGpd0KVEMFuw2rprTY=;
        b=a+0b4rinxRJpCK9GAeeYjbQc1SRJ+lS68lw5WLyVhItIAusLDkyYYlaIGeoCAvXusR
         OWoelVz14y0M9iKOba2/JO7cMF4zSCYXGtMvsXYWvbNGjhPWj14YD7x4O008r3YazQaZ
         Q7Y8IfqwGZPBTggTY1bnBFNzjZUzaZCQu1N2jg2xeWBNgBLUsuMZ/KtTnmsbFr1EwxVr
         i/Kx2IehpbO3UuTd6SkYKZglZzm0GopehiMrCyYYAcZLuOFtBpIF9TasQP0kg3C3LAER
         rEeipXxNOUVd/4k42LPo3CQ8ZKV3EfeTuFQDSZGICu3kE02Cl8AW/+foB0sRTYY+N8Cw
         ilrg==
X-Gm-Message-State: APjAAAUkNiou4xZJf2OTuPtrIDhdYIn91rSIiyY4U7ueV4SUe/8Bhlcz
        ejQr9ItN1yU5ufxwbAlnkfdz2A==
X-Google-Smtp-Source: APXvYqywqsBJ6vOuQI0SVUJ9GDFgyd4nYvY/ygpOvIhNOZKecn56UXso299U5l5WwsmJ3cF2p4HNGg==
X-Received: by 2002:a1c:e085:: with SMTP id x127mr2814871wmg.87.1553852024425;
        Fri, 29 Mar 2019 02:33:44 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-29-77.w90-86.abo.wanadoo.fr. [90.86.254.77])
        by smtp.gmail.com with ESMTPSA id s12sm1957125wmj.42.2019.03.29.02.33.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 02:33:43 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 2/6] usb: ohci-da8xx: let the regulator framework keep track of use count
Date:   Fri, 29 Mar 2019 10:33:30 +0100
Message-Id: <20190329093334.3885-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190329093334.3885-1-brgl@bgdev.pl>
References: <20190329093334.3885-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

There's no reason to have a separate variable to keep track of the
regulator state. The regulator core already does that. Remove
reg_enabled from struct da8xx_ohci_hcd.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/usb/host/ohci-da8xx.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/host/ohci-da8xx.c b/drivers/usb/host/ohci-da8xx.c
index ca8a94f15ac0..9c6d1f03b871 100644
--- a/drivers/usb/host/ohci-da8xx.c
+++ b/drivers/usb/host/ohci-da8xx.c
@@ -40,7 +40,6 @@ struct da8xx_ohci_hcd {
 	struct phy *usb11_phy;
 	struct regulator *vbus_reg;
 	struct notifier_block nb;
-	unsigned int reg_enabled;
 	struct gpio_desc *vbus_gpio;
 	struct gpio_desc *oc_gpio;
 };
@@ -100,21 +99,18 @@ static int ohci_da8xx_set_power(struct usb_hcd *hcd, int on)
 	if (!da8xx_ohci->vbus_reg)
 		return 0;
 
-	if (on && !da8xx_ohci->reg_enabled) {
+	if (on) {
 		ret = regulator_enable(da8xx_ohci->vbus_reg);
 		if (ret) {
 			dev_err(dev, "Failed to enable regulator: %d\n", ret);
 			return ret;
 		}
-		da8xx_ohci->reg_enabled = 1;
-
-	} else if (!on && da8xx_ohci->reg_enabled) {
+	} else if (!on) {
 		ret = regulator_disable(da8xx_ohci->vbus_reg);
 		if (ret) {
 			dev_err(dev, "Failed  to disable regulator: %d\n", ret);
 			return ret;
 		}
-		da8xx_ohci->reg_enabled = 0;
 	}
 
 	return 0;
-- 
2.21.0

