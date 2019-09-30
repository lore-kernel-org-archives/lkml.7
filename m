Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9BAC32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 10:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F6892190F
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 10:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569838751;
	bh=/khlmvyIF7dnAYuyK6pcvtYPvxWsRxXD/3cTxwU/l58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BkXt5MpM14XjItTV0DCBn3V7iIvLLiTgz3LpVec34T+A28X2nd5u006tI8PP4jDcN
	 QKTZcYA1/gK+CKsPFCE2QTpY4ifDs+PRrH/5huAXvzbrIZTfhByFwYAJmvHCocoOnL
	 DC2Z5FYAmPw7pHuosJim/psOAvIvzgLaT0fppyxI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730766AbfI3KTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 06:19:10 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33247 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730668AbfI3KSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 06:18:54 -0400
Received: by mail-lf1-f66.google.com with SMTP id y127so6602024lfc.0;
        Mon, 30 Sep 2019 03:18:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6p4YV1zw75GWQJusYr45Q284S6H3/JdTSqt0G1D+1gg=;
        b=M5fQQSLcME9hFROXxw7NFTFySwlcu3eObn9Hivaho0qCEKcF8Iy9KoqW4bS1D+/gbL
         JghIs1iIo31Cg0R/mINuo1EzB6StQPc7NpE/w4yprn3v3p+273Sa5twajo6n0ya0dMbe
         Hq87uCQ7RWgG+yaO8wLds95ydVYxKCAEuy1ymrS5/RJWtZ8/FQbcIhECRI2M80tmx7I7
         PXMRz3PRBtywJGRdPZNCfnNPA0xxjlZvVzHR4rEZxkA7aKcNn5PCTSfx50CyJ5PsTkqy
         7xGB9CH8tlIbFWkWXoMuUC7B6KquYGYkLOzzrNdAPuBtwPYI5xg/mTDsD+ppp/UW0hut
         V4mw==
X-Gm-Message-State: APjAAAUyJCf2oeqLfSKQdHGfHilZnSTH5govxYFl/AwdBugjqHBZlSIB
        WH36SJJwxzIu10RROjIju6Y=
X-Google-Smtp-Source: APXvYqw5PMB8dTcf2TZBADy6Q9OcIjv1d+eGxP7zjbmPAS3pWEe6xWdiFeqRLAOlXqt/+oKbkD2+AQ==
X-Received: by 2002:ac2:5633:: with SMTP id b19mr10815385lff.103.1569838732619;
        Mon, 30 Sep 2019 03:18:52 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id z8sm3805970lfg.18.2019.09.30.03.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 03:18:51 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ribalda@kernel.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda Delgado <ribalda@kernel.org>
Subject: [PATCH v8 6/8] Documentation: media: Describe V4L2_CID_UNIT_CELL_SIZE
Date:   Mon, 30 Sep 2019 12:18:39 +0200
Message-Id: <20190930101841.19630-7-ribalda@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190930101841.19630-1-ribalda@kernel.org>
References: <20190930101841.19630-1-ribalda@kernel.org>
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
 Documentation/media/uapi/v4l/ext-ctrls-image-source.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/media/uapi/v4l/ext-ctrls-image-source.rst b/Documentation/media/uapi/v4l/ext-ctrls-image-source.rst
index 2c3ab5796d76..033672dcb43d 100644
--- a/Documentation/media/uapi/v4l/ext-ctrls-image-source.rst
+++ b/Documentation/media/uapi/v4l/ext-ctrls-image-source.rst
@@ -55,3 +55,12 @@ Image Source Control IDs
 
 ``V4L2_CID_TEST_PATTERN_GREENB (integer)``
     Test pattern green (next to blue) colour component.
+
+``V4L2_CID_UNIT_CELL_SIZE (struct)``
+    This control returns the unit cell size in nanometres. The struct
+    :c:type:`v4l2_area` provides the width and the height in separated
+    fields to take into consideration asymmetric pixels and/or hardware
+    binning.
+    The unit cell consists of the whole area of the pixel, sensitive and
+    non-sensitive.
+    This control is required for automatic calibration sensors/cameras.
-- 
2.23.0

