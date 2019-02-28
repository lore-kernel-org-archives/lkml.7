Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C42EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 11:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C0C32171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 11:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m52f/5bI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732676AbfB1LoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 06:44:13 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37438 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732618AbfB1Lnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 06:43:53 -0500
Received: by mail-wm1-f67.google.com with SMTP id x10so8550213wmg.2;
        Thu, 28 Feb 2019 03:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mxidLmpesL0UlE1sgx/5oD2kg2MKqV+wltDfTBVHv4k=;
        b=m52f/5bIOYEabp6LPQHwqgq6L6uij1JrgDclYN8qgrM4n/mDA66aZ0hPZ4GFAHFOF3
         DSg2F4m0VHwPp/cxXro8JoT/3OwyYuAhHIsvoTcs5PZsyHLgqVixPZdA5nyBEJpis2NW
         mwynDw51/1hpN6B/YP24xlWuYJeXDOMckcxskOFB1hghHiEL+3K3wuat6tFtyDc3Ptx+
         rmj7nWHyn2mG7iAYKGWo9VIg7Rtp6XsYoDV/rA1cQLzIclU1gc2sPKb/6aU6Y5xQS2wa
         BUlTPayQNPD82cRPBOLSdJ5qkHULlj6MJKETiU9jyQjXXWCKn9GgTTV177a7ZJolT+23
         XJwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mxidLmpesL0UlE1sgx/5oD2kg2MKqV+wltDfTBVHv4k=;
        b=ueBERVRc+TDgNdouq5KXewegoNtQ7isPVLnqbaIQ8xJZ93Sdl9WsB23v0nNa3vVd6u
         mm3fk4m/L9DMgFnia8B9KBhmRK3PrGPhdHE5acXM5Ze7t55qorPNdn7arqLfDAQ6zl5A
         Mw84y9ta0PEEroGlUXoe+eAwjuAWxFIFItuq6eJlPrrpfUpxJfU0Er8UmEI/I858mmu4
         4S5ZEYbHA7XgqJC3xsNf2S9d6kc8DvA4MT18kX5hpSYnrUG47HRbrQ/NkuDXLnOQq97a
         5gEadEuiQTws4r+4J9Mgp77UDcAqfYeyZj2YrOVdxYP6OYA2D45YX9uxZR9Era+tzejj
         QMDA==
X-Gm-Message-State: APjAAAVSYnqJjoGpakVtk5IDmhvDTeLQwyN5ZQK/5wbyaGAHRMl7eNmZ
        lrjF7kwXHBQoHtcIEuIecq4=
X-Google-Smtp-Source: APXvYqzdJ+L9fsYf8ZJTR24UjYDq85y1Kj4y2GVvKCmxNsLrPHYuymy4iReZJU0I3FPX7qMeJPN2mQ==
X-Received: by 2002:a1c:c013:: with SMTP id q19mr2418228wmf.93.1551354232126;
        Thu, 28 Feb 2019 03:43:52 -0800 (PST)
Received: from uks1.vyatta.net ([137.221.143.78])
        by smtp.gmail.com with ESMTPSA id o12sm26022906wrx.53.2019.02.28.03.43.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 03:43:51 -0800 (PST)
From:   Robert Shearman <robertshearman@gmail.com>
To:     Peter Rosin <peda@axentia.se>, Guenter Roeck <linux@roeck-us.net>
Cc:     linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robert Shearman <robert.shearman@att.com>
Subject: [PATCH v4 1/3] i2c: mux: pca954x: remove support for unused platform data
Date:   Thu, 28 Feb 2019 11:43:41 +0000
Message-Id: <20190228114343.36443-2-robertshearman@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190228114343.36443-1-robertshearman@gmail.com>
References: <20190228114343.36443-1-robertshearman@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Shearman <robert.shearman@att.com>

There are no in-tree users of the pca954x platform data and the
per-channel deselect configuration complicates efforts to export the
configuration to user-space in a way that could be applied to other
muxes. Therefore, remove support for the pca954x platform data.

Signed-off-by: Robert Shearman <robert.shearman@att.com>
---
 drivers/i2c/muxes/i2c-mux-pca954x.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index bfabf985e830..e32fef560684 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -46,7 +46,6 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_irq.h>
-#include <linux/platform_data/pca954x.h>
 #include <linux/pm.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -348,14 +347,13 @@ static int pca954x_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
 	struct i2c_adapter *adap = client->adapter;
-	struct pca954x_platform_data *pdata = dev_get_platdata(&client->dev);
 	struct device *dev = &client->dev;
 	struct device_node *np = dev->of_node;
 	bool idle_disconnect_dt;
 	struct gpio_desc *gpio;
-	int num, force, class;
 	struct i2c_mux_core *muxc;
 	struct pca954x *data;
+	int num;
 	int ret;
 
 	if (!i2c_check_functionality(adap, I2C_FUNC_SMBUS_BYTE))
@@ -422,24 +420,9 @@ static int pca954x_probe(struct i2c_client *client,
 
 	/* Now create an adapter for each channel */
 	for (num = 0; num < data->chip->nchans; num++) {
-		bool idle_disconnect_pd = false;
-
-		force = 0;			  /* dynamic adap number */
-		class = 0;			  /* no class by default */
-		if (pdata) {
-			if (num < pdata->num_modes) {
-				/* force static number */
-				force = pdata->modes[num].adap_id;
-				class = pdata->modes[num].class;
-			} else
-				/* discard unconfigured channels */
-				break;
-			idle_disconnect_pd = pdata->modes[num].deselect_on_exit;
-		}
-		data->deselect |= (idle_disconnect_pd ||
-				   idle_disconnect_dt) << num;
+		data->deselect |= idle_disconnect_dt << num;
 
-		ret = i2c_mux_add_adapter(muxc, force, num, class);
+		ret = i2c_mux_add_adapter(muxc, 0, num, 0);
 		if (ret)
 			goto fail_cleanup;
 	}
-- 
2.20.1

