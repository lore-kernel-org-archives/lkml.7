Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA15C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 11:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D65E12083D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 11:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPkNu0WB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732651AbfB1Ln6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 06:43:58 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54944 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732623AbfB1Lnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 06:43:55 -0500
Received: by mail-wm1-f66.google.com with SMTP id a62so8950663wmh.4;
        Thu, 28 Feb 2019 03:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PE+7Rdkz183weryos8UBDXdW0QHWfS8lfsEe1WCiL8E=;
        b=bPkNu0WB7QpcnO/eJlt8dMBiSeHJGrdmqPM9IMMwwweYPkgFmwTguv6dZAU3DWdheP
         XwIk53PRlgJfiIql9ndVe0ew61RYjgaLkbE6HyZo4kmaXXze65Rd9b8x+NWLbg4/3aRp
         MfTL8chXN3qNWT7N82C6xyw7DFeUTuo4k3gUaaZMAvYnYyYEDA4lRibjgGaTyGoa2gqL
         HQf8opfWCx3KyzpICdFHW5m5Of1mL6JYVUgkBTkjLW/IXL71HxYcg5BX6o61ppIaBRf4
         YqZmXpQ4687xLEC6J5YRUzEwC3Wo1FhyMQy8fxMegfc/KO9jvGgW8jfbEaM+FY2qIALt
         CCZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PE+7Rdkz183weryos8UBDXdW0QHWfS8lfsEe1WCiL8E=;
        b=hJmBPPDrvTRy1xFroTzPNOsOsWPZdwD86gUwk5FhMMgtRtEbY1sYYqfR2heQfKf2Zu
         TlR/oW1CYG7/zTUMa2Rrhtla6JRLOO8M+uJYgoX0Pk6zJ1K1gqTPbwA/DLxN8Ygji7DB
         Q5+mZL0iOrA8lKkLVbkiVy17YN+DBJDxMIni382oydjy4JR0XQruK23FdSJf669rkO50
         AxzsReR04eRGoKCYhtARu2Mx/VwFIpfJm2fRek/Gd8HUcUtzwtKAAI1eKR6/vsr4cxqu
         uRz+Bb1pOJfWb3JnC9Nx8rxl7kba8lV0MpS5liCUSz7sNZgE0OU12eWfSK3zRdSSq0yz
         dmSg==
X-Gm-Message-State: AHQUAua0x0Lvwrao5OqbMcgc83/5z6GQCVBiYvmyEppV2sd2uj7N5U2q
        g46blBMCPWsD7OP7r4UNfb0=
X-Google-Smtp-Source: APXvYqxLyytPyOUUfR1hXyX+fXRXZPyb7OhcNUbzETcs0g7/Zva52FSeq3jvRwZy3w/Qnh51av3Lxg==
X-Received: by 2002:a7b:cf03:: with SMTP id l3mr2622292wmg.14.1551354233201;
        Thu, 28 Feb 2019 03:43:53 -0800 (PST)
Received: from uks1.vyatta.net ([137.221.143.78])
        by smtp.gmail.com with ESMTPSA id o12sm26022906wrx.53.2019.02.28.03.43.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 03:43:52 -0800 (PST)
From:   Robert Shearman <robertshearman@gmail.com>
To:     Peter Rosin <peda@axentia.se>, Guenter Roeck <linux@roeck-us.net>
Cc:     linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robert Shearman <robert.shearman@att.com>
Subject: [PATCH v4 2/3] i2c: mux: pca9541: remove support for unused platform data
Date:   Thu, 28 Feb 2019 11:43:42 +0000
Message-Id: <20190228114343.36443-3-robertshearman@gmail.com>
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

There are no in-tree users of the platform data, so remove it to
simplify the code slightly.

Remove the now unused pca954x.h platform data header.

Signed-off-by: Robert Shearman <robert.shearman@att.com>
---
 drivers/i2c/muxes/i2c-mux-pca9541.c   |  8 +----
 include/linux/platform_data/pca954x.h | 48 ---------------------------
 2 files changed, 1 insertion(+), 55 deletions(-)
 delete mode 100644 include/linux/platform_data/pca954x.h

diff --git a/drivers/i2c/muxes/i2c-mux-pca9541.c b/drivers/i2c/muxes/i2c-mux-pca9541.c
index 9e75d6b9140b..50e1fb4aedf5 100644
--- a/drivers/i2c/muxes/i2c-mux-pca9541.c
+++ b/drivers/i2c/muxes/i2c-mux-pca9541.c
@@ -22,7 +22,6 @@
 #include <linux/i2c-mux.h>
 #include <linux/jiffies.h>
 #include <linux/module.h>
-#include <linux/platform_data/pca954x.h>
 #include <linux/slab.h>
 
 /*
@@ -287,10 +286,8 @@ static int pca9541_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
 	struct i2c_adapter *adap = client->adapter;
-	struct pca954x_platform_data *pdata = dev_get_platdata(&client->dev);
 	struct i2c_mux_core *muxc;
 	struct pca9541 *data;
-	int force;
 	int ret;
 
 	if (!i2c_check_functionality(adap, I2C_FUNC_SMBUS_BYTE_DATA))
@@ -306,9 +303,6 @@ static int pca9541_probe(struct i2c_client *client,
 
 	/* Create mux adapter */
 
-	force = 0;
-	if (pdata)
-		force = pdata->modes[0].adap_id;
 	muxc = i2c_mux_alloc(adap, &client->dev, 1, sizeof(*data),
 			     I2C_MUX_ARBITRATOR,
 			     pca9541_select_chan, pca9541_release_chan);
@@ -320,7 +314,7 @@ static int pca9541_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, muxc);
 
-	ret = i2c_mux_add_adapter(muxc, force, 0, 0);
+	ret = i2c_mux_add_adapter(muxc, 0, 0, 0);
 	if (ret)
 		return ret;
 
diff --git a/include/linux/platform_data/pca954x.h b/include/linux/platform_data/pca954x.h
deleted file mode 100644
index 1712677d5904..000000000000
--- a/include/linux/platform_data/pca954x.h
+++ /dev/null
@@ -1,48 +0,0 @@
-/*
- *
- * pca954x.h - I2C multiplexer/switch support
- *
- * Copyright (c) 2008-2009 Rodolfo Giometti <giometti@linux.it>
- * Copyright (c) 2008-2009 Eurotech S.p.A. <info@eurotech.it>
- * Michael Lawnick <michael.lawnick.ext@nsn.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-
-#ifndef _LINUX_I2C_PCA954X_H
-#define _LINUX_I2C_PCA954X_H
-
-/* Platform data for the PCA954x I2C multiplexers */
-
-/* Per channel initialisation data:
- * @adap_id: bus number for the adapter. 0 = don't care
- * @deselect_on_exit: set this entry to 1, if your H/W needs deselection
- *                    of this channel after transaction.
- *
- */
-struct pca954x_platform_mode {
-	int		adap_id;
-	unsigned int	deselect_on_exit:1;
-	unsigned int	class;
-};
-
-/* Per mux/switch data, used with i2c_register_board_info */
-struct pca954x_platform_data {
-	struct pca954x_platform_mode *modes;
-	int num_modes;
-};
-
-#endif /* _LINUX_I2C_PCA954X_H */
-- 
2.20.1

