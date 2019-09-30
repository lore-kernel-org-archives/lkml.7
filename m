Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC61C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 10:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81C142190F
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 10:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569838757;
	bh=qMDToGj5VuZFZgy2BFaEjk6oXNuX2W7PgD53NHdQzdc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KrCFfotNL4oTrkhGGf59XXKaG+WH5BzdqIVNEzii2Ln+iG3v1AfEFRLn2Q49Ihzkm
	 o2Szm49sz3LaUWaKLqZiVcJVR2XvscrixY5Fy0CS2PlXzknOMOPaiELAmfw9ACfork
	 vPOPNE8IUUVwSylyZ0syw3SWqLwLz34WtrsbZv38=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730779AbfI3KTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 06:19:16 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36340 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730658AbfI3KSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 06:18:54 -0400
Received: by mail-lf1-f67.google.com with SMTP id x80so6596243lff.3;
        Mon, 30 Sep 2019 03:18:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ktnq7xkHoJ1ZWnUKlDDdlNDPJ4T3Et1IvqzPSJZiEIM=;
        b=LEH7siMPLaFgrYanNF0yxqIU+CFS0Lpt3Tjz9wEg4LwfgTUidM6JRuiiluK4zJtAKS
         AoAybinFTQe072XbYhUp443vj3jZXufVHN7gBbN7Fg/dlmPyWGiQ7oWvSeHgoVVQQ/fH
         O0wz3Ck5fLANBWglLITrUmcnraU5oyrLGrqD2U7Jte/qrAZ+uHw1D26gWgSeMQMWLANh
         4SExj3ereKHE8Qo4YEUHha3IrmttDuu/BpKTJoXnvGryP3gJdb1M2Onhge+vk34wZzhg
         lUu55fuUgDRiBtzIwhRUZPeWPDKThUiis3TjzOH8aipRfBruA0FkNXtrrqYd1o/8iYDH
         rgNg==
X-Gm-Message-State: APjAAAVZUMKDubWchMv1jB7nt2M2HHaYBi/NaAHwhfQoLev6Nd/Dvuii
        G5WKonUaiMz1+yL+IYypSBvRN1IiTJU=
X-Google-Smtp-Source: APXvYqxSIdU0NFHDYvRTmjrZkqalsJE7GK7juSzyIwkU1pMHmR3etCLEFYkDfwOxGYu+DymLoat1aw==
X-Received: by 2002:ac2:5966:: with SMTP id h6mr11371739lfp.78.1569838731332;
        Mon, 30 Sep 2019 03:18:51 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id z8sm3805970lfg.18.2019.09.30.03.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 03:18:50 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ribalda@kernel.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda Delgado <ribalda@kernel.org>
Subject: [PATCH v8 5/8] media: add V4L2_CID_UNIT_CELL_SIZE control
Date:   Mon, 30 Sep 2019 12:18:38 +0200
Message-Id: <20190930101841.19630-6-ribalda@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190930101841.19630-1-ribalda@kernel.org>
References: <20190930101841.19630-1-ribalda@kernel.org>
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
index b9a46f536406..f626f9983408 100644
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

