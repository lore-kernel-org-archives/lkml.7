Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2115ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BD74206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570451138;
	bh=dTgHTwxcPVAY75bpwe5bI35sEPUYww67ozMuUmKVYS0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=LhZuGx5EkUS9IZIUVaJO2/c3S0D8/Q6mbToKRkZacHwVArgNfuMDuKtHZ46NQ+n/s
	 gf/Gq0HDYWWWJi396ImAW3J0ZolsJUNGzQvSwPpkjZTmubm/6TJumePuVd2MfxiqXs
	 Vveq5+L7JnrMqGLurwirkuYAQGSUVFZfp38AeYJg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbfJGMZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 08:25:37 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39808 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727467AbfJGMZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 08:25:36 -0400
Received: by mail-lj1-f194.google.com with SMTP id y3so13417839ljj.6;
        Mon, 07 Oct 2019 05:25:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UMcbJXVkLFQKjwiek+1XAltyAJgo9tN49kR+LoXfqHI=;
        b=ge8M78d3bfAqNVXl1DwcWmrLvSnRkEwrXyJrG2KZ+GfdY3Z/jMDgJ23g+OxaKYpoxO
         8yxWx5kYQVjY6bA7L8XDU7aLxpZJAHWLmFoO1BDRlZVdS6zTVmaiBF/pNf63k8Xi1EfB
         h+bszi7u05pW3JIbnC4N6yoMjesgIX8b5sWopGEcSIzwVTkGOdAp0UqBTHs8kulxQadT
         QEGjstgp0m08bXm5QL4LLvGHh08FBtSIxY2atNBKX1T4fZ3MifCZ8oPpKIwA7LAcR2UE
         g22OGkY8Q8+avLm5cRYuagjohcf3nRozcipIQtPWsioneUI49NlBbH4Hoo894oOSH2wt
         kxZw==
X-Gm-Message-State: APjAAAWg7186LAi11CrV6wDR9t5lV2+S4bIHnXBrHj34Rus04muR0g+A
        FyGsw70yqeUKvFDRTNpeIdo=
X-Google-Smtp-Source: APXvYqxT/vpkVshs1L/GK5+uwIRhnQn5cSYhqQn+v1BFEARpZzqwlc/hcQpweIzR7c2FrVCunFnLiA==
X-Received: by 2002:a2e:4258:: with SMTP id p85mr18187890lja.172.1570451133063;
        Mon, 07 Oct 2019 05:25:33 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id t24sm2667285lfq.13.2019.10.07.05.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 05:25:32 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ribalda@kernel.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda Delgado <ribalda@kernel.org>
Subject: [PATCH v11 6/8] Documentation: media: Describe V4L2_CID_UNIT_CELL_SIZE
Date:   Mon,  7 Oct 2019 14:25:30 +0200
Message-Id: <20191007122530.17059-1-ribalda@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New control to pass to userspace the width/height of a pixel. Which is
needed for calibration and lens selection.

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Ricardo Ribalda Delgado <ribalda@kernel.org>
---
 .../media/uapi/v4l/ext-ctrls-image-source.rst          | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/media/uapi/v4l/ext-ctrls-image-source.rst b/Documentation/media/uapi/v4l/ext-ctrls-image-source.rst
index 2c3ab5796d76..2d3e2b83d6dd 100644
--- a/Documentation/media/uapi/v4l/ext-ctrls-image-source.rst
+++ b/Documentation/media/uapi/v4l/ext-ctrls-image-source.rst
@@ -55,3 +55,13 @@ Image Source Control IDs
 
 ``V4L2_CID_TEST_PATTERN_GREENB (integer)``
     Test pattern green (next to blue) colour component.
+
+``V4L2_CID_UNIT_CELL_SIZE (struct)``
+    This control returns the unit cell size in nanometers. The struct
+    :c:type:`v4l2_area` provides the width and the height in separate
+    fields to take into consideration asymmetric pixels.
+    This control does not take into consideration any possible hardware
+    binning.
+    The unit cell consists of the whole area of the pixel, sensitive and
+    non-sensitive.
+    This control is required for automatic calibration of sensors/cameras.
-- 
2.23.0

