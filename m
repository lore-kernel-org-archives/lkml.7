Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3627CA9EBD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91BE421D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571993793;
	bh=733vHWHIYXweYC4iuRGYt5/idio/gyo3OmJMIckDzzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pPlZiFup6YqbtKrUX00PZrHNG+xIUzCWZvl5X8VXcwS7L7IkeknXD+D/8OXdQWGIO
	 1fL2sRMI3R0+WCQBRB6Cowa0SsyBcNy0kZvw2GAIWPyu+FR8Vw4Cy29nneWRAUF6cz
	 uaT2VB4DLtqPpujxxRUKr/MT/PkUBzBwlRfUsr78=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438139AbfJYI4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 04:56:32 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37984 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438089AbfJYI42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 04:56:28 -0400
Received: by mail-lf1-f65.google.com with SMTP id q28so1080051lfa.5;
        Fri, 25 Oct 2019 01:56:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sw72wAYqdzmW73+eaBS/M1EsPi31nspNdnR6dR+JCgw=;
        b=f5oy8W40Jixa18Tk+DA2vSHle/AAjs/xphrx7R97NgV95AwNuWEfShIN/i2KTydg16
         JSktNIevHKiWYbSfD6xKELYlpebN65kKvDds8ehWVzVKzujdXAu5fc/j8xYXDrjRUHdN
         uPeogcHoHwYNnsdpR/ga5XSh8dqv9VIQbBQhFHDgcW9HjfeiPWaTERhrmoNfWckZhUYe
         Hp/2Hw6mFchJCOmfQ0Q8auEqjxkWUFTX3U59cMJGzvR8gPxPX1/6t2l+2RouD6q/e68J
         knG8wsrfHbDenLONjQC4lIuZgrHN1vvDQCu/mr/wxyPdEaZAv7OGLTnpYKs82HMHd7pB
         NV9A==
X-Gm-Message-State: APjAAAX9W8UChMrM+hfX3xzdtuSyMR9/gqEokIOK3Dp/RiiYIevETA4j
        3jbNe1zx0Le9ILn39eXKU1A=
X-Google-Smtp-Source: APXvYqyQ7GUp4O+ABsDADNWtu/ehNWvPOeqZCH27ye7RkGoQUbiuIw/GIgMClx7n3xwuaHP0K9+vkQ==
X-Received: by 2002:a19:c606:: with SMTP id w6mr1843636lff.71.1571993784709;
        Fri, 25 Oct 2019 01:56:24 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id y135sm571393lfa.92.2019.10.25.01.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 01:56:23 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ribalda@kernel.org>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Ricardo Ribalda Delgado <ribalda@kernel.org>
Subject: [PATCH v3] v4l2-compliance: Allow all the selection targets for subdevs
Date:   Fri, 25 Oct 2019 10:56:17 +0200
Message-Id: <20191025085617.23132-2-ribalda@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191025085617.23132-1-ribalda@kernel.org>
References: <20191025085617.23132-1-ribalda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subdev can also have non-active pixels, and using the _DEFAULT targets
we can capture only the active pixels.

Signed-off-by: Ricardo Ribalda Delgado <ribalda@kernel.org>
---
 utils/v4l2-compliance/v4l2-test-subdevs.cpp | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/utils/v4l2-compliance/v4l2-test-subdevs.cpp b/utils/v4l2-compliance/v4l2-test-subdevs.cpp
index 29987b31..ec4b9512 100644
--- a/utils/v4l2-compliance/v4l2-test-subdevs.cpp
+++ b/utils/v4l2-compliance/v4l2-test-subdevs.cpp
@@ -395,7 +395,7 @@ struct target_info {
 
 static target_info targets[] = {
 	{ V4L2_SEL_TGT_CROP, true },
-	{ V4L2_SEL_TGT_CROP_DEFAULT, false, true },
+	{ V4L2_SEL_TGT_CROP_DEFAULT, true, true },
 	{ V4L2_SEL_TGT_CROP_BOUNDS, true, true },
 	{ V4L2_SEL_TGT_NATIVE_SIZE, true },
 	{ V4L2_SEL_TGT_COMPOSE, true },
-- 
2.23.0

