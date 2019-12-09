Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C97DC2BD09
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 08:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FB432073D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 08:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pP/6yFBS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfLIIjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 03:39:36 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:47066 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbfLIIjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 03:39:22 -0500
Received: by mail-lj1-f196.google.com with SMTP id z17so14539182ljk.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 00:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fdnv5G54kjVyBGm0/gl9gu7nvtpvFPt8yg5pxAgrcmE=;
        b=pP/6yFBSAEaUiUH7CRhehuzaeVIWOjsGGhLeEuAGrVx2W2kXBMCABusQnG2xt+qaa3
         9+6vOi7s+y77yQ6gFflSeY7pd9YAAoWss/Xve7ocv7TpCjMOqVCjJa9RjV9J9Ze9bLbv
         6rEQo5qGbCne/g7FopoIkF7Q97iFLbFh3OyHWPHfzcCwaYpdCD2qfqGj0t2V3BeNv7DP
         g7e2kYRRKvOWqabt4DztTDYSMjopZgfBrN/hARbEtiv2E/bu05Jl4KRmTaaH4aNFlo65
         3Y0yQei9g9/tTcqXsfk2+gm7OplpDCi+a7aim/o5HUzxNWdLWvHRyrJ2FDppvZ/WkOA0
         /zoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fdnv5G54kjVyBGm0/gl9gu7nvtpvFPt8yg5pxAgrcmE=;
        b=T/sjhQUVwCBXrhTADYyG6I6CQpCcvsn6r0h9MikG2s+Of6CnPD1kzuCNijgVRmOkDf
         vf1jNaZ0BAHagZo/0nhIskaE4BfEGfPJPJ02EgcI83OMhvyZDdiM3p7TtaarC+6xH96D
         YnuxFffI64Ieh3ZkelISEA5PdR5FhM2ZJuUPyn3k7fB+WciQZGluNM2a11VcsPRzm0t9
         7w1AjSKkIoSeH1HnUoUpIyJRZDo0u1bjOLnRvSdYzp/qNqPXkDfkB9CRRR2N2ZCCm7Zq
         1QR6+2OamGjnycMLQTFEkLUJ5z+cXMiq609t0pXeflzRB5d1VHnc14y4DLg0rH7KPEtV
         8opg==
X-Gm-Message-State: APjAAAUnqK0FU1BV6qws12ZEWLZ/iIL0o31uz0TJ2vNpN2/KIUV1ePoS
        qNqc9/ifh02st799oR6ZZQAvyQ==
X-Google-Smtp-Source: APXvYqynMar8YEFWbO4Rp+sphv+VAYBcOnLMWnfw760ddHNzTaxqy4s0hXFAhu9ZcxfqEEAKn9wL6Q==
X-Received: by 2002:a2e:9708:: with SMTP id r8mr16116609lji.92.1575880760335;
        Mon, 09 Dec 2019 00:39:20 -0800 (PST)
Received: from localhost.localdomain ([37.157.136.193])
        by smtp.gmail.com with ESMTPSA id r26sm10438971lfm.82.2019.12.09.00.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 00:39:19 -0800 (PST)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH 5/6] v4l: Add source event change for bit-depth
Date:   Mon,  9 Dec 2019 10:38:23 +0200
Message-Id: <20191209083824.806-6-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191209083824.806-1-stanimir.varbanov@linaro.org>
References: <20191209083824.806-1-stanimir.varbanov@linaro.org>
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

