Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CEDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15B1B2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ncentric-com.20150623.gappssmtp.com header.i=@ncentric-com.20150623.gappssmtp.com header.b="oAD2jIYF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbfCRQkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 12:40:12 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40875 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbfCRQkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 12:40:12 -0400
Received: by mail-ed1-f65.google.com with SMTP id h22so3373649edw.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 09:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncentric-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=XbpQuRzoHfQWllFRUJGEeldvpGNt+SBQiUSZFiTIsKs=;
        b=oAD2jIYFEPZebAHCeXs/B+zYh6RlM4dGkGlWvUBokoWXgX/XLX4kPU4bvIVfIJKNw7
         2Tdp8vBSHCa+mnbewHCxP1hBSkkLp/3Wm6347vHhL46vryFdDJMVI5jaSmzRkq4EQq40
         KlZm8I18fOy5kyc+vzOn80jjJGsR/O42HXCV8HEAWRqKmri3iFg65AQFJ1juMxSjRCxX
         Lb2LwEeiLzfz0ix2oZGFdhdBI9hZ6L2NkJ8J2erK9sPnICrfoJ/mHcxmpCWSCGjK5hUm
         TqF4E6K3dfW+QUVjGZhiAYL5gbS9SXln9bLZsIFKj094K1XJVI0QUfy5+2nfqknGi3cA
         kChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XbpQuRzoHfQWllFRUJGEeldvpGNt+SBQiUSZFiTIsKs=;
        b=mx6prjm7KtVDlfQOvFL3GpOIzgBI2FPo/42RCU8wFogDuOZco9cE9GIfOL+nFeHJrY
         sWTV4HXxWm6hFHXj1fiIE1oD1S6pcOjdlHKsbKVOL2f6IsYy50vujj7+RGr+0fJR4qhe
         FsBtJFr5BCaSaOKkoceN1lIUqmkRa0COFcP5yFZMT5TB/MY9IYKBL/i+HPQ7Lq84vIXU
         CWKgst0aD+tPXAFn67L9mjFWbN8Q/q37vWLNxhv1WTUwCwRVUYhYV6Lcjaa2uo+LBUK3
         PMDVjg+vX7AUy+9X4HrHLyESES5/7LtSbWdFqr3rFg27YVdaf4uXaabguJ7em4ef7cC0
         PT3Q==
X-Gm-Message-State: APjAAAXRPQbS1KYmF7gUJLxzG99gcAoCAtfv5MKk3uxUSoPOh3JwYrkL
        IlSmTfH0WWaOMz1dfrJPcPt+K8TOy8fi6XmB
X-Google-Smtp-Source: APXvYqyeNlBOi3jnxlkw4OVowRp/Mg7VX4XzJGxzT1mI+zlbTO1pTEap8IFwEibiiTqrWSWrsljrvg==
X-Received: by 2002:a17:906:5595:: with SMTP id y21mr11489592ejp.209.1552927210159;
        Mon, 18 Mar 2019 09:40:10 -0700 (PDT)
Received: from kvdp-BRIX.cmb.citymesh.com (d515300d8.static.telenet.be. [81.83.0.216])
        by smtp.gmail.com with ESMTPSA id g22sm1861828eds.77.2019.03.18.09.40.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 09:40:09 -0700 (PDT)
From:   Koen Vandeputte <koen.vandeputte@ncentric.com>
To:     linux-media@vger.kernel.org
Cc:     Koen Vandeputte <koen.vandeputte@ncentric.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robin Leblon <robin.leblon@ncentric.com>,
        Rui Miguel Silva <rui.silva@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tim Harvey <tharvey@gateworks.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] media: i2c: tda1997x: select V4L2_FWNODE
Date:   Mon, 18 Mar 2019 17:40:05 +0100
Message-Id: <20190318164005.4070-1-koen.vandeputte@ncentric.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building tda1997x fails now unless V4L2_FWNODE is selected:

drivers/media/i2c/tda1997x.o: in function `tda1997x_parse_dt'
undefined reference to `v4l2_fwnode_endpoint_parse'

While at it, also sort the selections alphabetically

Fixes: 9ac0038db9a7 ("media: i2c: Add TDA1997x HDMI receiver driver")
Signed-off-by: Koen Vandeputte <koen.vandeputte@ncentric.com>
Cc: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Bingbu Cao <bingbu.cao@intel.com>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: Matt Ranostay <matt.ranostay@konsulko.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Robin Leblon <robin.leblon@ncentric.com>
Cc: Rui Miguel Silva <rui.silva@linaro.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org # v4.17+
---
 drivers/media/i2c/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
index 4c936e129500..8b296ae7d68c 100644
--- a/drivers/media/i2c/Kconfig
+++ b/drivers/media/i2c/Kconfig
@@ -60,8 +60,9 @@ config VIDEO_TDA1997X
 	tristate "NXP TDA1997x HDMI receiver"
 	depends on VIDEO_V4L2 && I2C && VIDEO_V4L2_SUBDEV_API
 	depends on SND_SOC
-	select SND_PCM
 	select HDMI
+	select SND_PCM
+	select V4L2_FWNODE
 	---help---
 	  V4L2 subdevice driver for the NXP TDA1997x HDMI receivers.
 
-- 
2.17.1

