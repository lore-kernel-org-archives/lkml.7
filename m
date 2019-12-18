Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4970C2D0D3
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 13:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAFF82146E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 13:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jFgeMvSD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfLRNYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 08:24:06 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46777 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbfLRNYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 08:24:02 -0500
Received: by mail-lf1-f67.google.com with SMTP id f15so1661373lfl.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 05:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fdnv5G54kjVyBGm0/gl9gu7nvtpvFPt8yg5pxAgrcmE=;
        b=jFgeMvSDcZBktiP6w0iUj7kL8k5sQjm6mg9k/ps8khr63J+cX9pqqKQmBDnUrdI9gu
         OCDqRaWaj9TWeCld9YrmKJeFymYAvdTB+DMOFSYGWOT1lKPPM7PNz1+mL46/Oqo/zjec
         2cQXB8kZqYvTvrRCRPTBbhecOeMDUyEG5ZQ6IhQVfhTDh4jd2+eqTBs0ska9ydwcQ2/g
         yb+sLpOS+M8i3V+i7FOHlvRywr1cc3y/66aqcbOg6LzLpc+o16HtsbWjAB2fNrLK2HMC
         3Kobzz7C/Ljj7tZR6xXs/0wdvfzY0t8oZVh5uZib95O8vY3MDYE0V5pBEI7yG92n2z0A
         dCUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fdnv5G54kjVyBGm0/gl9gu7nvtpvFPt8yg5pxAgrcmE=;
        b=WKKTdzxpjRgew4jn2WmjULBhcuf62A9M79+FqL3yaLgxQzlwQPG8DuKtN8wSQkxENT
         rFHVeHuMeTI8am9wE2843EV3U+5/G+M5emRGwkyItCkJcDydbyCwiho6a5Q07A9hFhQs
         oSAJSxR16q/UaRlTaUtSA0n4Gr67tJnMUko2M/NIbF+VywFhm+U27BYOB00vaSCXzIz+
         V/cZt5L/6GZE8ZoaPi9hexJTsn8y9WlwiYB6wM7juMFz+/+nVtO60QZuNvmb1n4ep/NP
         UnJnpcM/CMZI0Az4/GXprP0NeIZDDEwyDcMNQ/uEqEyR7S6T+Tjz37SK6jWaH6W1Dv43
         R1yQ==
X-Gm-Message-State: APjAAAWC8FwLb9KRbHI4zWcvmuwPwm8QC3c9MAstj14j1cvqDxo/aQ2v
        wm18tMZSEfiV43iU2TWY9N6Q2g==
X-Google-Smtp-Source: APXvYqzqLzR+5orlUlMv3SgEe06Bkjy+mExbqQ1hrTsMjm2qdbczM8yt5qontFf1NTSwaNHUYQlyMA==
X-Received: by 2002:a19:f006:: with SMTP id p6mr1719027lfc.94.1576675440344;
        Wed, 18 Dec 2019 05:24:00 -0800 (PST)
Received: from localhost.localdomain ([37.157.136.193])
        by smtp.gmail.com with ESMTPSA id z7sm1440667lfa.81.2019.12.18.05.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 05:23:59 -0800 (PST)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Vikash Garodia <vgarodia@codeaurora.org>, dikshita@codeaurora.org,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v2 04/12] v4l: Add source event change for bit-depth
Date:   Wed, 18 Dec 2019 15:22:43 +0200
Message-Id: <20191218132251.24161-5-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191218132251.24161-1-stanimir.varbanov@linaro.org>
References: <20191218132251.24161-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This event indicate that the source color bit-depth is changed
during run-time. The client must get the new format and re-allocate
buffers for it. This can usually happens with video decoder (encoders)
when the bit-stream color bit-depth is changed from 8 to 10bits
or vice versa.

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 Documentation/media/uapi/v4l/vidioc-dqevent.rst | 8 +++++++-
 Documentation/media/videodev2.h.rst.exceptions  | 1 +
 include/uapi/linux/videodev2.h                  | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/media/uapi/v4l/vidioc-dqevent.rst b/Documentation/media/uapi/v4l/vidioc-dqevent.rst
index 42659a3d1705..fad853d440cf 100644
--- a/Documentation/media/uapi/v4l/vidioc-dqevent.rst
+++ b/Documentation/media/uapi/v4l/vidioc-dqevent.rst
@@ -402,7 +402,13 @@ call.
 	that many Video Capture devices are not able to recover from a temporary
 	loss of signal and so restarting streaming I/O is required in order for
 	the hardware to synchronize to the video signal.
-
+    * - ``V4L2_EVENT_SRC_CH_COLOR_DEPTH``
+      - 0x0002
+      - This event gets triggered when color bit-depth change is detected
+	from a video decoder. Applications will have to query the new pixel
+	format and re-negotiate the queue. In most cases the streaming must be
+	stopped and restarted (:ref:`VIDIOC_STREAMOFF <VIDIOC_STREAMON>`
+	followed by :ref:`VIDIOC_STREAMON <VIDIOC_STREAMON>`).
 
 Return Value
 ============
diff --git a/Documentation/media/videodev2.h.rst.exceptions b/Documentation/media/videodev2.h.rst.exceptions
index cb6ccf91776e..209709114378 100644
--- a/Documentation/media/videodev2.h.rst.exceptions
+++ b/Documentation/media/videodev2.h.rst.exceptions
@@ -490,6 +490,7 @@ replace define V4L2_EVENT_CTRL_CH_FLAGS ctrl-changes-flags
 replace define V4L2_EVENT_CTRL_CH_RANGE ctrl-changes-flags
 
 replace define V4L2_EVENT_SRC_CH_RESOLUTION src-changes-flags
+replace define V4L2_EVENT_SRC_CH_COLOR_DEPTH src-changes-flags
 
 replace define V4L2_EVENT_MD_FL_HAVE_FRAME_SEQ :c:type:`v4l2_event_motion_det`
 
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 04481c717fee..2a5138ac6d25 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -2307,6 +2307,7 @@ struct v4l2_event_frame_sync {
 };
 
 #define V4L2_EVENT_SRC_CH_RESOLUTION		(1 << 0)
+#define V4L2_EVENT_SRC_CH_COLOR_DEPTH		(1 << 1)
 
 struct v4l2_event_src_change {
 	__u32 changes;
-- 
2.17.1

