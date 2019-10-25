Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CCDCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 979BC21D82
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571993786;
	bh=oLwgegf6Q1ChDQaB79wa7vkl0pQBYZfYxrtb0pZ5Tck=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=j44hRNzCHkbvWWmv/vvxJsvqClcfOJb5dSdZjPh6PjJ0WCGja71pwojjU0GOSTAYg
	 vTnPV9yP0nQV86HvDteVA8ahpk6EhhzUEYOlUR3i6pkpYphewnM5+ZgDH5qt6UkhZI
	 tJScQkMEk67rHbvRHZhzJ2emXtTVjz7iq2KHDSo4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438083AbfJYI4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 04:56:25 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42962 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393107AbfJYI4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 04:56:25 -0400
Received: by mail-lf1-f66.google.com with SMTP id z12so1068731lfj.9;
        Fri, 25 Oct 2019 01:56:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/pf+TC3UkQxsm1lp9DN6oiz74VjHhrWP2wdjdY3KIeQ=;
        b=dg6Z2mgI4LM/ByPz6/hvLIbxlEydulkdYd2ve9gY/A6Tmp6vVaR6BEcmtBNXQcDT71
         G4s9uXxSlqcITNWQ9jMxcKOvlvbpRzeE9MjIXP2lXijEsNtKG9mftIxNI0NadRIARYGI
         zIdlU/e5+a1xBY/oF+WMXcthR5BLb8/riDwH0/sa3doTYewHNQjHAZc4fVIGxXXmVUPA
         ILxDJaaXfdH752Li7+fgLDW8U7nTkue7BRtZWwzTki+1M2fGpPLuidhOsYKINBujv4hf
         mb7PMaORdo3HTmIZQ0kEzDh68gBMl+lzIw29JX2hAFyflzeISc6Wb1/LrflpqeSxvOZ9
         rGgw==
X-Gm-Message-State: APjAAAWatGy0gEf8CyZfCYolDP5ii+EHEqJIibJdkGAfeGXBQZPaIWwj
        /hi/XbsvLZOkYp09YpMNwYA=
X-Google-Smtp-Source: APXvYqwCbByrEVJHOFUhMkGMI4Ct8W/vGu0UmSOp0hYtipIF4X5VpfmE5dL3HKd/mfD78CTGMsgwFQ==
X-Received: by 2002:a19:ad4c:: with SMTP id s12mr1950403lfd.49.1571993782847;
        Fri, 25 Oct 2019 01:56:22 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id y135sm571393lfa.92.2019.10.25.01.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 01:56:21 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ribalda@kernel.org>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Ricardo Ribalda Delgado <ribalda@kernel.org>
Subject: [PATCH v3] Documentation: media: *_DEFAULT targets for subdevs
Date:   Fri, 25 Oct 2019 10:56:16 +0200
Message-Id: <20191025085617.23132-1-ribalda@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some sensors have optical blanking areas, this is, pixels that are
painted and do not account for light, only noise.

These special pixels are very useful for calibrating the sensor, but
should not be displayed on a DEFAULT target.

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Ricardo Ribalda Delgado <ribalda@kernel.org>
---
 Documentation/media/uapi/v4l/v4l2-selection-targets.rst | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/media/uapi/v4l/v4l2-selection-targets.rst b/Documentation/media/uapi/v4l/v4l2-selection-targets.rst
index f74f239b0510..a69571308a45 100644
--- a/Documentation/media/uapi/v4l/v4l2-selection-targets.rst
+++ b/Documentation/media/uapi/v4l/v4l2-selection-targets.rst
@@ -38,8 +38,10 @@ of the two interfaces they are used.
     * - ``V4L2_SEL_TGT_CROP_DEFAULT``
       - 0x0001
       - Suggested cropping rectangle that covers the "whole picture".
+        This includes only active pixels and excludes other non-active
+        pixels such as black pixels.
+      - Yes
       - Yes
-      - No
     * - ``V4L2_SEL_TGT_CROP_BOUNDS``
       - 0x0002
       - Bounds of the crop rectangle. All valid crop rectangles fit inside
@@ -60,8 +62,8 @@ of the two interfaces they are used.
     * - ``V4L2_SEL_TGT_COMPOSE_DEFAULT``
       - 0x0101
       - Suggested composition rectangle that covers the "whole picture".
-      - Yes
       - No
+      - Yes
     * - ``V4L2_SEL_TGT_COMPOSE_BOUNDS``
       - 0x0102
       - Bounds of the compose rectangle. All valid compose rectangles fit
-- 
2.23.0

