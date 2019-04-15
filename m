Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FAA1C282DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2B0021906
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355193;
	bh=R09b3kr1ivf1MAC/4qHfH7zgtpdnFmKoDzQNcgYs3cY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BrEfggU2UI2J7aKj5zTwSLpPu4DQUbprtWfimSGiFJy4mw68JO2ewIsMgrcyKxApC
	 7rrMFMOof7ja2J4WyNuUEvf13O00ldtVpfXAs44Ow/avGsKbFElFaxPgjE350GX1B5
	 EOPejEb7E5UydWu40jiU0+Bx7NjPnJ6VfAHl7EZ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729978AbfDOTGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:06:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:40942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729958AbfDOTGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:06:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09B1720880;
        Mon, 15 Apr 2019 19:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355190;
        bh=R09b3kr1ivf1MAC/4qHfH7zgtpdnFmKoDzQNcgYs3cY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IQJskHn2JQpIy+S1FmnzCRX0Uhpz4VsLWd5wiqTVj5LgnYgjm9HDpPvvmq3oFbHEk
         1Kiz7UIxv/Um9VXYrYGyQNixkdW+lkp8kiFlleJlbfWYxK0C/ArFm+zF6PB1SQZ1B6
         E/XQn84wKXktxMz+ivZNiN2I2vWt6XRq5SJvGpnQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Axel Lin <axel.lin@ingics.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.19 047/101] hwmon: (w83773g) Select REGMAP_I2C to fix build error
Date:   Mon, 15 Apr 2019 20:58:45 +0200
Message-Id: <20190415183743.069158516@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183740.341577907@linuxfoundation.org>
References: <20190415183740.341577907@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Axel Lin <axel.lin@ingics.com>

commit a165dcc923ada2ffdee1d4f41f12f81b66d04c55 upstream.

Select REGMAP_I2C to avoid below build error:
ERROR: "__devm_regmap_init_i2c" [drivers/hwmon/w83773g.ko] undefined!

Fixes: ee249f271524 ("hwmon: Add W83773G driver")
Cc: stable@vger.kernel.org
Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hwmon/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1755,6 +1755,7 @@ config SENSORS_VT8231
 config SENSORS_W83773G
 	tristate "Nuvoton W83773G"
 	depends on I2C
+	select REGMAP_I2C
 	help
 	  If you say yes here you get support for the Nuvoton W83773G hardware
 	  monitoring chip.


