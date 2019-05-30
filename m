Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD51C28CC3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 09:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8931725630
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 09:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dmyIRlMR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbfE3Jda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 05:33:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40003 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfE3Jd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 05:33:29 -0400
Received: by mail-wr1-f66.google.com with SMTP id t4so3713019wrx.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 02:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=6m1gjqr7LLo5czWaTNxbcS9O7G75X5W+OVxVsjgwdOk=;
        b=dmyIRlMRlkjOTvPMU8h28OONRBSGMbu5OSkC56ceQtI82uyy9wZSUWnAAFvv4qeefD
         1uH+WS2sxeXVRW2DNdtQA1dDIEw6uVypGKzciRZoT6bctV3lMYh+jNP1ZR36djmDCLjw
         VKLc53Cg59P21NX3oLbIHnVwGGcPUG1neQP65J7MTFocgNYwh20lwAGvv3Ngi8M2C82+
         0fvLmrK0jdeSOBNSEQdAbiJWsx3fUupQM0n/aD6hJWbVcLzf+l4XVtOED3rcZchEf3ut
         bVwX3gW/aTaj4Dm6vSGvA5Jlw9ng9ZXieYne8XtFL5y7PF4Y3iBDODeM8v5OEF8Ttnc3
         biHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6m1gjqr7LLo5czWaTNxbcS9O7G75X5W+OVxVsjgwdOk=;
        b=WA0S2xEjN8+W17Raq5xIssaDg+G6lOCQESlZ636DcO7cQkhpETTZmf9CjBhTyp1KI7
         Ngcp4K/eY1760q9IGykRnNu+rZhVUL5UoS/r1EEs+Stn/FH0yY1x0CZQxg6K0+My9FNs
         Yzl3czVMV7uqSpzxrrHtCDLeuN7E5ISwzWcMUoT3RLcFGrsu+Pj5vRQHDhiJDDGWhNzh
         S+y9L60ScoXyQvdFw3ZlncNOc/WLZ+YdZDJZbNiSlABRRMAehExGcFEDlfJkCEnJV8Zp
         0eZv9JP2yLPFl7EzI7fB4Yc9GhlaDzx3vhXvchaWzV+Kf6+CvlGXIeqFY7pLmnbP8afq
         K9ww==
X-Gm-Message-State: APjAAAUDMrsZvf3RL2LFY2m8zkObc/PhOPP14SdouBJSLHttcly8ogN6
        wVwJ8U/0yQ/ZVPjfjw5XiQv4Lw==
X-Google-Smtp-Source: APXvYqxEASlLnIkp5PQbSa4BfrTxFJ6g24r6qZiMp+C9TsnMS8uQxuD/y1DzZGzNDx7DhMVpHGITmg==
X-Received: by 2002:adf:c982:: with SMTP id f2mr1940460wrh.235.1559208808019;
        Thu, 30 May 2019 02:33:28 -0700 (PDT)
Received: from localhost.localdomain ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id a124sm2863900wmh.3.2019.05.30.02.33.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 02:33:26 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v3] media/doc: Allow sizeimage to be set by v4l clients
Date:   Thu, 30 May 2019 12:33:12 +0300
Message-Id: <20190530093312.27562-1-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This changes v4l2_pix_format and v4l2_plane_pix_format sizeimage
field description to allow v4l clients to set bigger image size
in case of variable length compressed data.

Presently s5p-mfc and mtk-vcodec codec drivers use that. Lets
make it obvious in the documentation.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
Changes since v2:
Addressed review comments from Mauro.

 .../media/uapi/v4l/pixfmt-v4l2-mplane.rst         | 15 ++++++++++++++-
 Documentation/media/uapi/v4l/pixfmt-v4l2.rst      | 13 ++++++++++++-
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/Documentation/media/uapi/v4l/pixfmt-v4l2-mplane.rst b/Documentation/media/uapi/v4l/pixfmt-v4l2-mplane.rst
index 5688c816e334..db43dda5aafb 100644
--- a/Documentation/media/uapi/v4l/pixfmt-v4l2-mplane.rst
+++ b/Documentation/media/uapi/v4l/pixfmt-v4l2-mplane.rst
@@ -31,7 +31,20 @@ describing all planes of that format.
 
     * - __u32
       - ``sizeimage``
-      - Maximum size in bytes required for image data in this plane.
+      - Maximum size in bytes required for image data in this plane,
+	set by the driver. When the image consists of variable length
+	compressed data this is the number of bytes required by the
+	codec to support the worst-case compression scenario.
+
+	The driver will set the value for uncompressed images.
+
+	Clients are allowed to set the sizeimage field for variable length
+	compressed data flagged with ``V4L2_FMT_FLAG_COMPRESSED`` at
+	:ref:`VIDIOC_ENUM_FMT`, but the driver may ignore it and set the
+	value itself, or it may modify the provided value based on
+	alignment requirements or minimum/maximum size requirements.
+	If the client wants to leave this to the driver, then it should
+	set sizeimage to 0.
     * - __u32
       - ``bytesperline``
       - Distance in bytes between the leftmost pixels in two adjacent
diff --git a/Documentation/media/uapi/v4l/pixfmt-v4l2.rst b/Documentation/media/uapi/v4l/pixfmt-v4l2.rst
index 71eebfc6d853..da6da2ef139a 100644
--- a/Documentation/media/uapi/v4l/pixfmt-v4l2.rst
+++ b/Documentation/media/uapi/v4l/pixfmt-v4l2.rst
@@ -89,7 +89,18 @@ Single-planar format structure
       - Size in bytes of the buffer to hold a complete image, set by the
 	driver. Usually this is ``bytesperline`` times ``height``. When
 	the image consists of variable length compressed data this is the
-	maximum number of bytes required to hold an image.
+	number of bytes required by the codec to support the worst-case
+	compression scenario.
+
+	The driver will set the value for uncompressed images.
+
+	Clients are allowed to set the sizeimage field for variable length
+	compressed data flagged with ``V4L2_FMT_FLAG_COMPRESSED`` at
+	:ref:`VIDIOC_ENUM_FMT`, but the driver may ignore it and set the
+	value itself, or it may modify the provided value based on
+	alignment requirements or minimum/maximum size requirements.
+	If the client wants to leave this to the driver, then it should
+	set sizeimage to 0.
     * - __u32
       - ``colorspace``
       - Image colorspace, from enum :c:type:`v4l2_colorspace`.
-- 
2.17.1

