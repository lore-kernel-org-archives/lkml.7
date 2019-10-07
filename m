Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4413DC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15A3E20867
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570448132;
	bh=EInH/vgdsDUyVee6E6f5mXVy6rfJLICDUbdSSURr+hQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cP9mqgy6/iqCIeQ9tn7NCxg1f2xTI0RqNDtH5HFVGN4gAMViprWROh8kFnir99Yxu
	 9eBwLmZRlYtzsSvyBwPlvME8VHYxkiHMY9PJenHgzxVhGzOcLKm3m79U01De3gRPHv
	 Cw3SfRq55kR4ViabXYU9oUFwj4ZcG4vP1O85wq1M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbfJGLfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 07:35:31 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42823 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727799AbfJGLfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 07:35:15 -0400
Received: by mail-lj1-f194.google.com with SMTP id y23so13215460lje.9;
        Mon, 07 Oct 2019 04:35:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gfi7av1677y2cplYp6Mr+tclh8Fz7p32JQ7/mzFpucw=;
        b=RLzs3p/fLRAbLFx0P7dce2696f+CqikL0Qa3r/ho2TjNyeBbjWH10KyKgvOGqJ04sZ
         cpkPdnLLFCrxEpUbzJGWSjFuDomqZd7rqRNfXdWH7DC5O0QeruoJB3VExo23QqBAqR9u
         rSM2kS90dH1xgB0KTattAdeAHKGrkn61HJw7bc/LGZoO3LCz4T/soBzZ9sy1IfEcp+mS
         18KiQyxF3ivUzfB/gwlEauiCULeO3fm343Hc5dU9uU2Ugg6cXvVdwPPmqomFs0lHexz4
         AtBxVlYIp0FXrdaMRFO1XeHVF1vY3ub0dJQpaoI/nJrWpmqu7asHDE7/H7ryFiL+si65
         R2iw==
X-Gm-Message-State: APjAAAWGum/NgBMO/uPrvLRIT46/DymgHieokylMtU04dDiDpsL3qFRy
        dKJ3v35FwGvqSdBhSJsOtIE=
X-Google-Smtp-Source: APXvYqxriWcuCywlzFNFeFfqlrM/bXbs+7FKl8JMpSjGSlHrJBW2KHo36FL2ZqBnDKiaCPLqOkPvxA==
X-Received: by 2002:a05:651c:1132:: with SMTP id e18mr18303142ljo.33.1570448112821;
        Mon, 07 Oct 2019 04:35:12 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id b25sm3666047ljj.36.2019.10.07.04.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 04:35:11 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ribalda@kernel.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda Delgado <ribalda@kernel.org>
Subject: [PATCH v10 5/8] media: add V4L2_CID_UNIT_CELL_SIZE control
Date:   Mon,  7 Oct 2019 13:34:59 +0200
Message-Id: <20191007113502.11746-6-ribalda@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191007113502.11746-1-ribalda@kernel.org>
References: <20191007113502.11746-1-ribalda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This control returns the unit cell size in nanometres. The struct provides
the width and the height in separated fields to take into consideration
asymmetric pixels and/or hardware binning.
This control is required for automatic calibration of sensors/cameras.

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Ricardo Ribalda Delgado <ribalda@kernel.org>
---
 drivers/media/v4l2-core/v4l2-ctrls.c | 5 +++++
 include/uapi/linux/v4l2-controls.h   | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-ctrls.c b/drivers/media/v4l2-core/v4l2-ctrls.c
index 96cab2e173d3..bf50d37ef6c1 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls.c
@@ -996,6 +996,7 @@ const char *v4l2_ctrl_get_name(u32 id)
 	case V4L2_CID_AUTO_FOCUS_RANGE:		return "Auto Focus, Range";
 	case V4L2_CID_PAN_SPEED:		return "Pan, Speed";
 	case V4L2_CID_TILT_SPEED:		return "Tilt, Speed";
+	case V4L2_CID_UNIT_CELL_SIZE:		return "Unit Cell Size";
 
 	/* FM Radio Modulator controls */
 	/* Keep the order of the 'case's the same as in v4l2-controls.h! */
@@ -1377,6 +1378,10 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
 	case V4L2_CID_MPEG_VIDEO_VP8_FRAME_HEADER:
 		*type = V4L2_CTRL_TYPE_VP8_FRAME_HEADER;
 		break;
+	case V4L2_CID_UNIT_CELL_SIZE:
+		*type = V4L2_CTRL_TYPE_AREA;
+		*flags |= V4L2_CTRL_FLAG_READ_ONLY;
+		break;
 	default:
 		*type = V4L2_CTRL_TYPE_INTEGER;
 		break;
diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
index a2669b79b294..5a7bedee2b0e 100644
--- a/include/uapi/linux/v4l2-controls.h
+++ b/include/uapi/linux/v4l2-controls.h
@@ -1034,6 +1034,7 @@ enum v4l2_jpeg_chroma_subsampling {
 #define V4L2_CID_TEST_PATTERN_GREENR		(V4L2_CID_IMAGE_SOURCE_CLASS_BASE + 5)
 #define V4L2_CID_TEST_PATTERN_BLUE		(V4L2_CID_IMAGE_SOURCE_CLASS_BASE + 6)
 #define V4L2_CID_TEST_PATTERN_GREENB		(V4L2_CID_IMAGE_SOURCE_CLASS_BASE + 7)
+#define V4L2_CID_UNIT_CELL_SIZE			(V4L2_CID_IMAGE_SOURCE_CLASS_BASE + 8)
 
 
 /* Image processing controls */
-- 
2.23.0

