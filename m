Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C288C33C99
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 09:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 376AF20748
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 09:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g+iOhcZr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbfKOJub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 04:50:31 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40830 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727385AbfKOJu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 04:50:28 -0500
Received: by mail-pf1-f195.google.com with SMTP id r4so6362893pfl.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 01:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=00TE3UjkilRir+eBZdBUQADWxjiLoIj6o72iA3B1Sak=;
        b=g+iOhcZrs7UHvseKUzS7H3Gpvuf+nZBEoWW8rYkkCFWMInk9W59sz0xitzhao5Txsi
         WrUHfnBCjiQRmDJ3EAACFoIQ78JL3NwHz6QWOXGmrjik1Fex0wwvpOo4JlBeAboBLH5Z
         O89w7p63Hp9pEwQ3GHEpduv0T3LhEn0JEmdsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=00TE3UjkilRir+eBZdBUQADWxjiLoIj6o72iA3B1Sak=;
        b=Kf/QVw/PGpPlkPEaZtJ/Q4cv/6yu9pz8B+ZEiu8IJU7BKK8Y06+MKAEppuqoecCGo1
         Tr9tLUd3bgYjIQ0mEpQQdJJeQaaB43BfU5Y2ek3+wwg9XXmbqGOmX4kYtoGaZqR1J3Ll
         AhXzJYAGaoqwaO44APbavINrmOtJiTVrxd0xV9+dxhHrxDEOfJKaK6af83nqDZIZAwqO
         2ogpMhrL8JHvpzrQgcuzMpC6FfUA0TtrKo1l5LZTSqouaDgbhxIsGiRgiG8ecebAQ1jh
         G22uONrmF6eOEJfT9D5XLnkguGpDlBIi1J95MTYiZYC4dDuKj9fCxu5Xf2ism8grq2oC
         cfPg==
X-Gm-Message-State: APjAAAV+e93uEFtvzytRvIncU8RsaDMTxwJVLDXC4FJ/u56d5PHgIcg7
        XwFZ8d+gpen/zOSGBmY8TAko8g==
X-Google-Smtp-Source: APXvYqwSf7X2rW+Bxb5/bsjJWmQV2TgPWw6OX5rnxCqpAbf3+Ggth6PILQOMBFyXwlyMU5+ZUMuJjA==
X-Received: by 2002:a63:1f08:: with SMTP id f8mr14240497pgf.145.1573811426996;
        Fri, 15 Nov 2019 01:50:26 -0800 (PST)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id y14sm9792409pff.69.2019.11.15.01.50.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2019 01:50:26 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     dmitry.torokhov@gmail.com, groeck@chromium.org,
        briannorris@chromium.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, lee.jones@linaro.org,
        bleung@chromium.org, enric.balletbo@collabora.com,
        dianders@chromium.org, fabien.lahoudere@collabora.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v5 05/18] platform: chrome: cros_ec: Do not attempt to register a non-positive IRQ number
Date:   Fri, 15 Nov 2019 01:33:59 -0800
Message-Id: <20191115093412.144922-6-gwendal@chromium.org>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
In-Reply-To: <20191115093412.144922-1-gwendal@chromium.org>
References: <20191115093412.144922-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a layer of sanity checking to cros_ec_register against attempting to
register IRQ values that are not strictly greater than 0.

Signed-off-by: Enrico Granata <egranata@chromium.org>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
No changes in v5, v4, v3.
Changes in v2:
  Remove dual Enrico's signature.

 drivers/platform/chrome/cros_ec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index 925f84dbf621..d3dfa27171e6 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -149,7 +149,7 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 		return err;
 	}
 
-	if (ec_dev->irq) {
+	if (ec_dev->irq > 0) {
 		err = devm_request_threaded_irq(dev, ec_dev->irq,
 						ec_irq_handler,
 						ec_irq_thread,
-- 
2.24.0.432.g9d3f5f5b63-goog

