Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC61CC76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 22:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D1AC20665
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 22:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C0JCiIlk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732950AbfGOWCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 18:02:13 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40250 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732854AbfGOWCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 18:02:11 -0400
Received: by mail-pf1-f195.google.com with SMTP id p184so8050200pfp.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 15:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WTST8xYEYceYV0LXdWiwDDXFT69vjhpN5CuO+9nfLhc=;
        b=C0JCiIlkjIoM7dBBKQbe6jkeqN3H2ZMTHLhaaezcvcv+9PZy0VaubjEzkp2rbbJzST
         qaWNcI1DRyAbUFak0HyAN+86sVSo+ikIMQsTnLoQu+hZKfqb+0cs132am7rSVPzbcd1H
         oto/B4eZxJQcbxCG/Glo8RRIWhAMLQOSzub4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WTST8xYEYceYV0LXdWiwDDXFT69vjhpN5CuO+9nfLhc=;
        b=PUFaCpwCu8zSsPvQ87XNz3UW37tyx7nWvFcWruS7GsQLCDx+BMb7X/rvPAn26itITj
         KOWZFDObXGwGbHF/ksiETXWVRjyjgepPb6HdNnimKOsxGwD1FB1TcEr98WNJn8m0sc7a
         XQmdYu5ZjV68kmOa781QJ5IqWiVLWMKHcHrNwqN+2AWhB3GiHteyFDqEHL+wSIT5dnA4
         hFUPwTuzt36SCEwLjLtM3rhktZq/fzNAAzb5utk09BElVAKxSMMGezrIuApGOOssvbaW
         PC/NXubPARj1Wgz7okr50Bgfh2Fjf+1fZcvceYdd2MoQOx4M/pG+7l4fY13q9Bg6Orln
         UPdQ==
X-Gm-Message-State: APjAAAXGxwC7nmJpkKpsGD+Wdz4d7ltOOFYuHzjh+2urGxBU1m/sif2c
        Jizgaongw/pCkIDvTFKbwuTglw==
X-Google-Smtp-Source: APXvYqwf4ex7TGcS002tYox0OywvSfJi3qudO4YgAdUlSKvVZly9b6A40Gl82qLexfXyMHxTED9tIg==
X-Received: by 2002:a63:6c46:: with SMTP id h67mr19480868pgc.248.1563228130536;
        Mon, 15 Jul 2019 15:02:10 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id a25sm17117924pfn.1.2019.07.15.15.02.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 15:02:10 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, bleung@chromium.org,
        enric.balletbo@collabora.com, groeck@chromium.org,
        fabien.lahoudere@collabora.com, dianders@chromium.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v5 2/4] iio: cros_ec_accel_legacy: Fix incorrect channel setting
Date:   Mon, 15 Jul 2019 15:01:50 -0700
Message-Id: <20190715220152.119531-3-gwendal@chromium.org>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
In-Reply-To: <20190715220152.119531-1-gwendal@chromium.org>
References: <20190715220152.119531-1-gwendal@chromium.org>
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

