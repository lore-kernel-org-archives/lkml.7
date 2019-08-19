Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 276CBC3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 12:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E48A720851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 12:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566217049;
	bh=9UiViFVBEzZm++Oe3b87GbT4CBsUVloSxmxIMDdJSRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l5wL8reA6/vJS0xr5bfkBRS4MN9kfibZTPyGZAl1u7TxAzcuXc3kmmVsfZ69lNOqh
	 5vuEPv46WXsqSEITxdteM+gOywpJGVgaUP7rM9fGBlK6bG0z97xPzp65U+Bt5528yD
	 3EEIdCaHkoIErRvUtC0E2Xz2JL2F4B56pFD4QncE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfHSMR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 08:17:28 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37411 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727301AbfHSMR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 08:17:27 -0400
Received: by mail-ed1-f67.google.com with SMTP id f22so1466013edt.4;
        Mon, 19 Aug 2019 05:17:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9RBGVrQg7lODbDWBtsawmxQ4QY4IjEpFAoyu7OAy/io=;
        b=GVtPfk1W6K28lXmCPbPEgQp14s1d67JLD4IpU4RIJybJvSIm0TJIXIa00bbOGTrYdn
         PjES4ITObpOcfjpXqlpxVq4Url+5ZQ+ZCRggamHiyd+7MELdv11TZQ8ghMgknasFs0gv
         UvI93m2RDwEuAAByidvTAwdnpgUoznXMQAp/LP19COk2gJpR8ugOZ6psceVAGJ5NOjqY
         tRKoYiUnOQiBVIqeoGZcYT8BhI1To0vCHyXQ8J2QOsb1pGT4/KHW2/o0kO9BpSFJGO4B
         D/7Vude9pglDWVkDj5eD/YSb+2EyfJYu+DDYjeji2x6sRS5INyPWyftJd+1lMiYqmp+c
         zlHw==
X-Gm-Message-State: APjAAAWyVcXLNBojXbIZcSNkG2BTiw6y2EqsexTWEpbXIS39QeipgF8v
        YRSYXxaiYZeIRNgWPkiLY7M=
X-Google-Smtp-Source: APXvYqzm6xvitSWj6OBDxjx0kHDaIWwA1oLt8w4SCBv2mR44HNwcKoq7XlYOLIhQoVZ1rlZ1Xs5knA==
X-Received: by 2002:a50:ba81:: with SMTP id x1mr24456369ede.257.1566217046233;
        Mon, 19 Aug 2019 05:17:26 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id b31sm2753639edf.33.2019.08.19.05.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 05:17:25 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ribalda@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda Delgado <ribalda@kernel.org>
Subject: [PATCH 2/3] Documentation: Describe V4L2_CID_PIXEL_SIZE
Date:   Mon, 19 Aug 2019 14:17:19 +0200
Message-Id: <20190819121720.31345-2-ribalda@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190819121720.31345-1-ribalda@kernel.org>
References: <20190819121720.31345-1-ribalda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New control to pass to userspace the width/height of a pixel. Which is
needed for 3D calibration and lens selection.

Signed-off-by: Ricardo Ribalda Delgado <ribalda@kernel.org>
---
 Documentation/media/uapi/v4l/ext-ctrls-camera.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/media/uapi/v4l/ext-ctrls-camera.rst b/Documentation/media/uapi/v4l/ext-ctrls-camera.rst
index 51c1d5c9eb00..670c57a6f622 100644
--- a/Documentation/media/uapi/v4l/ext-ctrls-camera.rst
+++ b/Documentation/media/uapi/v4l/ext-ctrls-camera.rst
@@ -510,6 +510,12 @@ enum v4l2_scene_mode -
     value down. A value of zero stops the motion if one is in progress
     and has no effect otherwise.
 
+``V4L2_CID_PIXEL_SIZE (struct)``
+    This control returns the pixel size in nanometres. The struct provides
+    the width and the height in separated fields to take into consideration
+    asymmetric pixels and/or hardware binning.
+    This control is required for automatic calibration of the sensor.
+
 .. [#f1]
    This control may be changed to a menu control in the future, if more
    options are required.
-- 
2.23.0.rc1

