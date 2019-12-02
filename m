Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB62C432C3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 23:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09A6D20640
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 23:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FcA/0MQ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbfLBXr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 18:47:57 -0500
Received: from mail-yw1-f74.google.com ([209.85.161.74]:39094 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfLBXr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 18:47:56 -0500
Received: by mail-yw1-f74.google.com with SMTP id l12so1056982ywk.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 15:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=69pKtnQoGvZ0fByVpJbH5AHtb1ebW30QFFccpiMwv2w=;
        b=FcA/0MQ4rxfhpOme7QbQbEaRg4XmWquye9/u2yL9JxKrGkj/zA2Ip7egKRur6MxLzw
         Zl4qW8ITMV0ckF4QBPbt6kiKjP6DRQyYd2APH5Xw0AJ24b1SACgstIcDvW+mCd6JwI6N
         hQBkSNQVS6eo1v8HT3j5VFg7CbZLKr/f8mH0W2Ku73McBAWp/yuYKY2qRs+OOxTdUrf4
         DvaFHn+SAhnNEADX2QUycAcx9GmlEHJJ2VOdGfqh/7N0IzBh9z6yvhNH0m78Gkg1B+F0
         PZrx2lcgdSTyDzFEFwJPlBXnb+Btn+qOlc45fPorHrbrRrTzjUX0iR5SZIK5cfvqrX13
         f9pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=69pKtnQoGvZ0fByVpJbH5AHtb1ebW30QFFccpiMwv2w=;
        b=E8RbtqZe0R71QtKHfLa3rtGRFqkQW789Bu25s+BCirL3nsg/ptx/DByu8rkRfNlWqu
         X4YMegAhpPdcGMdBkNg2jLLf/tDmh7sSfmtJ1TLXO40BK9PuT1Id3yJv3dFRqjViVLH7
         4du24bkOUDck/qXmI7GESx0tGnI/W9QhDgl/53qeRiAL6EITfu/N9HGX2Q8wkAByggPU
         XI2l8w0kZzAH47WPJbLy01QG7DEwjEiG8q2AdY3sI0SIaL/sMlbsA2rCWli79pAM5Z4j
         vCJ/8LoxT0LzC56yOymJFZUNTxSEwohMzOWI4l8/5FR7mwctRsHFMfV8O5OPNCabHaYW
         DJcw==
X-Gm-Message-State: APjAAAWZJmauTCSy0ZtQ3eTGMgl/0V8cMNck7NOI95JRrtU9eYYxa3t8
        Dee4WH1OE8NFGWzma/AvUxeB1KgGjeGBB6Pht5OOMQ==
X-Google-Smtp-Source: APXvYqznqT7Y9d1M3sUXhUiBAn58u+h/oOMY4gdrsEm5AY4f7VhGFPYHEJtWnPn/r+qeEaT5Plhguj7L7kq5nCEdX1uvqQ==
X-Received: by 2002:a81:6707:: with SMTP id b7mr1209824ywc.36.1575330475315;
 Mon, 02 Dec 2019 15:47:55 -0800 (PST)
Date:   Mon,  2 Dec 2019 15:47:45 -0800
Message-Id: <20191202234745.138816-1-thomasanderson@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH v2] drm/edid: Add modes from CTA-861-G
From:   Thomas Anderson <thomasanderson@google.com>
To:     Bhawanpreet Lakha <Bhawanpreet.lakha@amd.com>,
        "=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?=" 
        <ville.syrjala@linux.intel.com>,
        Shashank Sharma <shashank.sharma@intel.com>
Cc:     Harry Wentland <hwentlan@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Thomas Anderson <thomasanderson@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new modes are needed for exotic displays such as 8K. Verified that
modes like 8K60 and 4K120 are properly obtained from a Samsung Q900R.

Signed-off-by: Thomas Anderson <thomasanderson@google.com>
---
 drivers/gpu/drm/drm_edid.c  | 287 +++++++++++++++++++++++++++++++++++-
 include/drm/drm_connector.h |  16 +-
 2 files changed, 290 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 474ac04d5600..11e63e70274e 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -1378,6 +1378,273 @@ static const struct drm_display_mode edid_cea_modes[] = {
 		   6304, 6600, 0, 2160, 2168, 2178, 2250, 0,
 		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
 	  .vrefresh = 100, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
+	/* 128 - dummy */
+	{ },
+	/* 129 - reserved for native timing 1 */
+	{ },
+	/* 130 - reserved for native timing 2 */
+	{ },
+	/* 131 - reserved for native timing 3 */
+	{ },
+	/* 132 - reserved for native timing 4 */
+	{ },
+	/* 133 - reserved for native timing 5 */
+	{ },
+	/* 134 - reserved for native timing 6 */
+	{ },
+	/* 135 - reserved for native timing 7 */
+	{ },
+	/* 136 - reserved for native timing 8 */
+	{ },
+	/* 137 - reserved for native timing 9 */
+	{ },
+	/* 138 - reserved for native timing 10 */
+	{ },
+	/* 139 - reserved for native timing 11 */
+	{ },
+	/* 140 - reserved for native timing 12 */
+	{ },
+	/* 141 - reserved for native timing 13 */
+	{ },
+	/* 142 - reserved for native timing 14 */
+	{ },
+	/* 143 - reserved for native timing 15 */
+	{ },
+	/* 144 - reserved for native timing 16 */
+	{ },
+	/* 145 - reserved for native timing 17 */
+	{ },
+	/* 146 - reserved for native timing 18 */
+	{ },
+	/* 147 - reserved for native timing 19 */
+	{ },
+	/* 148 - reserved for native timing 20 */
+	{ },
+	/* 149 - reserved for native timing 21 */
+	{ },
+	/* 150 - reserved for native timing 22 */
+	{ },
+	/* 151 - reserved for native timing 23 */
+	{ },
+	/* 152 - reserved for native timing 24 */
+	{ },
+	/* 153 - reserved for native timing 25 */
+	{ },
+	/* 154 - reserved for native timing 26 */
+	{ },
+	/* 155 - reserved for native timing 27 */
+	{ },
+	/* 156 - reserved for native timing 28 */
+	{ },
+	/* 157 - reserved for native timing 29 */
+	{ },
+	/* 158 - reserved for native timing 30 */
+	{ },
+	/* 159 - reserved for native timing 31 */
+	{ },
+	/* 160 - reserved for native timing 32 */
+	{ },
+	/* 161 - reserved for native timing 33 */
+	{ },
+	/* 162 - reserved for native timing 34 */
+	{ },
+	/* 163 - reserved for native timing 35 */
+	{ },
+	/* 164 - reserved for native timing 36 */
+	{ },
+	/* 165 - reserved for native timing 37 */
+	{ },
+	/* 166 - reserved for native timing 38 */
+	{ },
+	/* 167 - reserved for native timing 39 */
+	{ },
+	/* 168 - reserved for native timing 40 */
+	{ },
+	/* 169 - reserved for native timing 41 */
+	{ },
+	/* 170 - reserved for native timing 42 */
+	{ },
+	/* 171 - reserved for native timing 43 */
+	{ },
+	/* 172 - reserved for native timing 44 */
+	{ },
+	/* 173 - reserved for native timing 45 */
+	{ },
+	/* 174 - reserved for native timing 46 */
+	{ },
+	/* 175 - reserved for native timing 47 */
+	{ },
+	/* 176 - reserved for native timing 48 */
+	{ },
+	/* 177 - reserved for native timing 49 */
+	{ },
+	/* 178 - reserved for native timing 50 */
+	{ },
+	/* 179 - reserved for native timing 51 */
+	{ },
+	/* 180 - reserved for native timing 52 */
+	{ },
+	/* 181 - reserved for native timing 53 */
+	{ },
+	/* 182 - reserved for native timing 54 */
+	{ },
+	/* 183 - reserved for native timing 55 */
+	{ },
+	/* 184 - reserved for native timing 56 */
+	{ },
+	/* 185 - reserved for native timing 57 */
+	{ },
+	/* 186 - reserved for native timing 58 */
+	{ },
+	/* 187 - reserved for native timing 59 */
+	{ },
+	/* 188 - reserved for native timing 60 */
+	{ },
+	/* 189 - reserved for native timing 61 */
+	{ },
+	/* 190 - reserved for native timing 62 */
+	{ },
+	/* 191 - reserved for native timing 63 */
+	{ },
+	/* 192 - reserved for native timing 64 */
+	{ },
+	/* 193 - 5120x2160@120Hz 64:27 */
+	{ DRM_MODE("5120x2160", DRM_MODE_TYPE_DRIVER, 1485000, 5120, 5284,
+		   5372, 5500, 0, 2160, 2168, 2178, 2250, 0,
+		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	  .vrefresh = 120, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
+	/* 194 - 7680x4320@24Hz 16:9 */
+	{ DRM_MODE("7680x4320", DRM_MODE_TYPE_DRIVER, 1188000, 7680, 10232,
+		   10408, 11000, 0, 4320, 4336, 4356, 4500, 0,
+		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	  .vrefresh = 24, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_16_9, },
+	/* 195 - 7680x4320@25Hz 16:9 */
+	{ DRM_MODE("7680x4320", DRM_MODE_TYPE_DRIVER, 1188000, 7680, 10032,
+		   10208, 10800, 0, 4320, 4336, 4356, 4400, 0,
+		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	  .vrefresh = 25, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_16_9, },
+	/* 196 - 7680x4320@30Hz 16:9 */
+	{ DRM_MODE("7680x4320", DRM_MODE_TYPE_DRIVER, 1188000, 7680, 8232,
+		   8408, 9000, 0, 4320, 4336, 4356, 4400, 0,
+		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	  .vrefresh = 30, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_16_9, },
+	/* 197 - 7680x4320@48Hz 16:9 */
+	{ DRM_MODE("7680x4320", DRM_MODE_TYPE_DRIVER, 2376000, 7680, 10232,
+		   10408, 11000, 0, 4320, 4336, 4356, 4500, 0,
+		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	  .vrefresh = 48, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_16_9, },
+	/* 198 - 7680x4320@50Hz 16:9 */
+	{ DRM_MODE("7680x4320", DRM_MODE_TYPE_DRIVER, 2376000, 7680, 10032,
+		   10208, 10800, 0, 4320, 4336, 4356, 4400, 0,
+		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	  .vrefresh = 50, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_16_9, },
+	/* 199 - 7680x4320@60Hz 16:9 */
+	{ DRM_MODE("7680x4320", DRM_MODE_TYPE_DRIVER, 2376000, 7680, 8232,
+		   8408, 9000, 0, 4320, 4336, 4356, 4400, 0,
+		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	  .vrefresh = 60, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_16_9, },
+	/* 200 - 7680x4320@100Hz 16:9 */
+	{ DRM_MODE("7680x4320", DRM_MODE_TYPE_DRIVER, 4752000, 7680, 9792,
+		   9968, 10560, 0, 4320, 4336, 4356, 4500, 0,
+		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	  .vrefresh = 100, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_16_9, },
+	/* 201 - 7680x4320@120Hz 16:9 */
+	{ DRM_MODE("7680x4320", DRM_MODE_TYPE_DRIVER, 4752000, 7680, 8032,
+		   8208, 8800, 0, 4320, 4336, 4356, 4500, 0,
+		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	  .vrefresh = 120, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_16_9, },
+	/* 202 - 7680x4320@24Hz 64:27 */
+	{ DRM_MODE("7680x4320", DRM_MODE_TYPE_DRIVER, 1188000, 7680, 10232,
+		   10408, 11000, 0, 4320, 4336, 4356, 4500, 0,
+		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	  .vrefresh = 24, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
+	/* 203 - 7680x4320@25Hz 64:27 */
+	{ DRM_MODE("7680x4320", DRM_MODE_TYPE_DRIVER, 1188000, 7680, 10032,
+		   10208, 10800, 0, 4320, 4336, 4356, 4400, 0,
+		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	  .vrefresh = 25, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
+	/* 204 - 7680x4320@30Hz 64:27 */
+	{ DRM_MODE("7680x4320", DRM_MODE_TYPE_DRIVER, 1188000, 7680, 8232,
+		   8408, 9000, 0, 4320, 4336, 4356, 4400, 0,
+		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	  .vrefresh = 30, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
+	/* 205 - 7680x4320@48Hz 64:27 */
+	{ DRM_MODE("7680x4320", DRM_MODE_TYPE_DRIVER, 2376000, 7680, 10232,
+		   10408, 11000, 0, 4320, 4336, 4356, 4500, 0,
+		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	  .vrefresh = 48, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
+	/* 206 - 7680x4320@50Hz 64:27 */
+	{ DRM_MODE("7680x4320", DRM_MODE_TYPE_DRIVER, 2376000, 7680, 10032,
+		   10208, 10800, 0, 4320, 4336, 4356, 4400, 0,
+		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	  .vrefresh = 50, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
+	/* 207 - 7680x4320@60Hz 64:27 */
+	{ DRM_MODE("7680x4320", DRM_MODE_TYPE_DRIVER, 2376000, 7680, 8232,
+		   8408, 9000, 0, 4320, 4336, 4356, 4400, 0,
+		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	  .vrefresh = 60, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
+	/* 208 - 7680x4320@100Hz 64:27 */
+	{ DRM_MODE("7680x4320", DRM_MODE_TYPE_DRIVER, 4752000, 7680, 9792,
+		   9968, 10560, 0, 4320, 4336, 4356, 4500, 0,
+		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	  .vrefresh = 100, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
+	/* 209 - 7680x4320@120Hz 64:27 */
+	{ DRM_MODE("7680x4320", DRM_MODE_TYPE_DRIVER, 4752000, 7680, 8032,
+		   8208, 8800, 0, 4320, 4336, 4356, 4500, 0,
+		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	  .vrefresh = 120, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
+	/* 210 - 10240x4320@24Hz 64:27 */
+	{ DRM_MODE("10240x4320", DRM_MODE_TYPE_DRIVER, 1485000, 10240, 11732,
+		   11908, 12500, 0, 4320, 4336, 4356, 4950, 0,
+		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	  .vrefresh = 24, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
+	/* 211 - 10240x4320@25Hz 64:27 */
+	{ DRM_MODE("10240x4320", DRM_MODE_TYPE_DRIVER, 1485000, 10240, 12732,
+		   12908, 13500, 0, 4320, 4336, 4356, 4400, 0,
+		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	  .vrefresh = 25, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
+	/* 212 - 10240x4320@30Hz 64:27 */
+	{ DRM_MODE("10240x4320", DRM_MODE_TYPE_DRIVER, 1485000, 10240, 10528,
+		   10704, 11000, 0, 4320, 4336, 4356, 4500, 0,
+		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	  .vrefresh = 30, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
+	/* 213 - 10240x4320@48Hz 64:27 */
+	{ DRM_MODE("10240x4320", DRM_MODE_TYPE_DRIVER, 2970000, 10240, 11732,
+		   11908, 12500, 0, 4320, 4336, 4356, 4950, 0,
+		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	  .vrefresh = 48, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
+	/* 214 - 10240x4320@50Hz 64:27 */
+	{ DRM_MODE("10240x4320", DRM_MODE_TYPE_DRIVER, 2970000, 10240, 12732,
+		   12908, 13500, 0, 4320, 4336, 4356, 4400, 0,
+		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	  .vrefresh = 50, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
+	/* 215 - 10240x4320@60Hz 64:27 */
+	{ DRM_MODE("10240x4320", DRM_MODE_TYPE_DRIVER, 2970000, 10240, 10528,
+		   10704, 11000, 0, 4320, 4336, 4356, 4500, 0,
+		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	  .vrefresh = 60, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
+	/* 216 - 10240x4320@100Hz 64:27 */
+	{ DRM_MODE("10240x4320", DRM_MODE_TYPE_DRIVER, 5940000, 10240, 12432,
+		   12608, 13200, 0, 4320, 4336, 4356, 4500, 0,
+		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	  .vrefresh = 100, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
+	/* 217 - 10240x4320@120Hz 64:27 */
+	{ DRM_MODE("10240x4320", DRM_MODE_TYPE_DRIVER, 5940000, 10240, 10528,
+		   10704, 11000, 0, 4320, 4336, 4356, 4500, 0,
+		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	  .vrefresh = 120, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
+	/* 218 - 4096x2160@100Hz 256:135 */
+	{ DRM_MODE("4096x2160", DRM_MODE_TYPE_DRIVER, 1188000, 4096, 4896,
+		   4984, 5280, 0, 2160, 2168, 2178, 2250, 0,
+		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	  .vrefresh = 100,
+	  .picture_aspect_ratio = HDMI_PICTURE_ASPECT_256_135, },
+	/* 219 - 4096x2160@120Hz 256:135 */
+	{ DRM_MODE("4096x2160", DRM_MODE_TYPE_DRIVER, 1188000, 4096, 4184,
+		   4272, 4400, 0, 2160, 2168, 2178, 2250, 0,
+		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	  .vrefresh = 120,
+	  .picture_aspect_ratio = HDMI_PICTURE_ASPECT_256_135, },
 };
 
 /*
@@ -3131,6 +3398,12 @@ cea_mode_alternate_timings(u8 vic, struct drm_display_mode *mode)
 	return false;
 }
 
+static bool drm_valid_cea_vic(u8 vic)
+{
+	return (vic > 0 && vic < 128) ||
+	       (vic > 192 && vic < ARRAY_SIZE(edid_cea_modes));
+}
+
 static u8 drm_match_cea_mode_clock_tolerance(const struct drm_display_mode *to_match,
 					     unsigned int clock_tolerance)
 {
@@ -3147,6 +3420,9 @@ static u8 drm_match_cea_mode_clock_tolerance(const struct drm_display_mode *to_m
 		struct drm_display_mode cea_mode = edid_cea_modes[vic];
 		unsigned int clock1, clock2;
 
+		if (!drm_valid_cea_vic(vic))
+			continue;
+
 		/* Check both 60Hz and 59.94Hz */
 		clock1 = cea_mode.clock;
 		clock2 = cea_mode_alternate_clock(&cea_mode);
@@ -3186,6 +3462,9 @@ u8 drm_match_cea_mode(const struct drm_display_mode *to_match)
 		struct drm_display_mode cea_mode = edid_cea_modes[vic];
 		unsigned int clock1, clock2;
 
+		if (!drm_valid_cea_vic(vic))
+			continue;
+
 		/* Check both 60Hz and 59.94Hz */
 		clock1 = cea_mode.clock;
 		clock2 = cea_mode_alternate_clock(&cea_mode);
@@ -3204,13 +3483,11 @@ u8 drm_match_cea_mode(const struct drm_display_mode *to_match)
 }
 EXPORT_SYMBOL(drm_match_cea_mode);
 
-static bool drm_valid_cea_vic(u8 vic)
-{
-	return vic > 0 && vic < ARRAY_SIZE(edid_cea_modes);
-}
-
 static enum hdmi_picture_aspect drm_get_cea_aspect_ratio(const u8 video_code)
 {
+	if (!drm_valid_cea_vic(video_code))
+		return HDMI_PICTURE_ASPECT_NONE;
+
 	return edid_cea_modes[video_code].picture_aspect_ratio;
 }
 
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 5f8c3389d46f..e6e02f5853f5 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -188,19 +188,19 @@ struct drm_hdmi_info {
 
 	/**
 	 * @y420_vdb_modes: bitmap of modes which can support ycbcr420
-	 * output only (not normal RGB/YCBCR444/422 outputs). There are total
-	 * 107 VICs defined by CEA-861-F spec, so the size is 128 bits to map
-	 * upto 128 VICs;
+	 * output only (not normal RGB/YCBCR444/422 outputs). The max VIC
+	 * defined by the CEA-861-G spec is 219, so the size is 256 bits to map
+	 * upto 256 VICs.
 	 */
-	unsigned long y420_vdb_modes[BITS_TO_LONGS(128)];
+	unsigned long y420_vdb_modes[BITS_TO_LONGS(256)];
 
 	/**
 	 * @y420_cmdb_modes: bitmap of modes which can support ycbcr420
-	 * output also, along with normal HDMI outputs. There are total 107
-	 * VICs defined by CEA-861-F spec, so the size is 128 bits to map upto
-	 * 128 VICs;
+	 * output also, along with normal HDMI outputs. The max VIC defined by
+	 * the CEA-861-G spec is 219, so the size is 256 bits to map upto 256
+	 * VICs.
 	 */
-	unsigned long y420_cmdb_modes[BITS_TO_LONGS(128)];
+	unsigned long y420_cmdb_modes[BITS_TO_LONGS(256)];
 
 	/** @y420_cmdb_map: bitmap of SVD index, to extraxt vcb modes */
 	u64 y420_cmdb_map;
-- 
2.24.0.393.g34dc348eaf-goog

