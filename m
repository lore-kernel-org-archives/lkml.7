Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBDEC76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 23:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B15742086C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 23:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A5XGb1C/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732536AbfGOXPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 19:15:04 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34300 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731589AbfGOXPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 19:15:02 -0400
Received: by mail-pf1-f193.google.com with SMTP id b13so8131142pfo.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 16:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WTST8xYEYceYV0LXdWiwDDXFT69vjhpN5CuO+9nfLhc=;
        b=A5XGb1C/TSinuAe1zfk7UExKA3J35xN0BfF97rVRF43VNbo3zr6qpvMF8zZVSr0GUc
         m6FavsQAjyxbFZQKB8+hXBKAHggXN5AidzDWtGGykPlnsTUCbL2sEXFNDTZPnf1woSfN
         wi/QsKeZ/soaz5EDJAqOaXm7EynwRt93148QM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WTST8xYEYceYV0LXdWiwDDXFT69vjhpN5CuO+9nfLhc=;
        b=nJMuPd2sLpRWPNBoarlFRjGdfxkpY8PZk2io4two89jd6+kEgq8q0AOh+NgBGhp7Ni
         4zyg/UxLuJSgTJaKFlQSDBBE1VghFsfgIUbb9kzl7ajCZYLExos+54DVmGsPCvlTKLec
         hZXswiIhVyhOhO7QGSJTgNPw9y3v0ToRvrvU/u/SyHPK1DpxplevWH60Xca2LDInluJm
         yHkrXAVFWAUNFaan42pSmpULK1sLsxDVFp48ErinOc5sdByFpgAFsi39Rvzb2h7jLQwj
         Geq5ZNZxwFxTamfsg5JTe+fwOJ15V0o9oS8gP4c4X8NMd+yrFyh7Qd3au4pEGC515WDR
         neSA==
X-Gm-Message-State: APjAAAWntpmEiMrbRtjm0m/jRGlRAdFIhcLoc1EFXKgqKqBT9lr1vYHR
        KV9mk3ikHyvArk6ml+3RNDycT1y8Lnw=
X-Google-Smtp-Source: APXvYqxuWm9+wghenWJCt5B5nPmj83WxzbY6f3N14RcnDevhAzqpobVk9u+nwzI1eQPV0HIKeA63Bg==
X-Received: by 2002:a17:90a:bb8a:: with SMTP id v10mr32530182pjr.78.1563232501601;
        Mon, 15 Jul 2019 16:15:01 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id 97sm17539388pjz.12.2019.07.15.16.15.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 16:15:01 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, bleung@chromium.org,
        enric.balletbo@collabora.com, groeck@chromium.org,
        fabien.lahoudere@collabora.com, dianders@chromium.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v6 2/4] iio: cros_ec_accel_legacy: Fix incorrect channel setting
Date:   Mon, 15 Jul 2019 16:14:52 -0700
Message-Id: <20190715231454.189459-3-gwendal@chromium.org>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
In-Reply-To: <20190715231454.189459-1-gwendal@chromium.org>
References: <20190715231454.189459-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

INFO_SCALE is set both for each channel and all channels.
iio is using all channel setting, so the error was not user visible.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/iio/accel/cros_ec_accel_legacy.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel/cros_ec_accel_legacy.c
index 46bb2e421bb9..ad19d9c716f4 100644
--- a/drivers/iio/accel/cros_ec_accel_legacy.c
+++ b/drivers/iio/accel/cros_ec_accel_legacy.c
@@ -319,7 +319,6 @@ static const struct iio_chan_spec_ext_info cros_ec_accel_legacy_ext_info[] = {
 		.modified = 1,					        \
 		.info_mask_separate =					\
 			BIT(IIO_CHAN_INFO_RAW) |			\
-			BIT(IIO_CHAN_INFO_SCALE) |			\
 			BIT(IIO_CHAN_INFO_CALIBBIAS),			\
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SCALE),	\
 		.ext_info = cros_ec_accel_legacy_ext_info,		\
-- 
2.22.0.510.g264f2c817a-goog

