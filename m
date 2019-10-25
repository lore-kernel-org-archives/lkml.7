Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA5FCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 09:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E540121929
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 09:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571996833;
	bh=OZe2E93DZvBDteiTc8xYD1vP84vdBkSB4TNdOYApgCs=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=w8uklk3SxnTzyVrD5nIapPQLvk9kHdUEp4c/C+oO3iZA/NNdqIqKS5LPOl8zmsPLY
	 nLtl1Kz3ClQCySDAk1YZZJQcry7n6RJ6ieXB8dhFmIbX4aiUn/FCvyrnwJnu5vIi2d
	 kDjcLA67v+mQ2gbVp72PMUIyRC5u9B6HerH1oAOQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439099AbfJYJrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 05:47:11 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35314 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438836AbfJYJrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 05:47:11 -0400
Received: by mail-lf1-f66.google.com with SMTP id y6so1206889lfj.2;
        Fri, 25 Oct 2019 02:47:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6eirW4NBi16Kvo5Dh5yyQapiDDYkl5K/PGUWrysKXq0=;
        b=Pu2V5WOtgvnwTDPCt1/n3ii0Y6nVoZ6H3ugc70sbV2tKC4G0JJHNb5Sx8f5pWApMnp
         Eu4FbEyJKmLC+aSsS9Dd260N/6vaUXK9wlx2faa3TxV5uK8jUmkHRlXgsLA89AVS8Je9
         bNpMwysi1Vvhw9+1CpqaYynsvTTUCr3bC3F53S1mfDj1wXNdVwX0YHddSj4kDIkjVIhw
         NVSn2o2DMZFxLnz7zTpIAXEVZxPY78mQPD4pDnIxslLQPjZ06bDPvEShBDg1fugjgrGa
         kxcQT7WZPGtvnxnH80R14wied9GYWt/BVOS3/rQ3Qvg/2vZuYjo0A4HjRZlUp7pGKTEj
         CzJQ==
X-Gm-Message-State: APjAAAWqanEG5mJNq3JivSyCAmE7WUSVcoWjRs2LqBoCR/dqQFlVtubS
        qmVzNWzjBcsjryNvkq65uEM=
X-Google-Smtp-Source: APXvYqygr8TZ9oIml7y17u/lHTi2jbAY+LwT+Q2s+sgmZ3TaMDnluE1o1RqVDkDDKjll4Fx0SBX9Ig==
X-Received: by 2002:ac2:5deb:: with SMTP id z11mr938373lfq.35.1571996829137;
        Fri, 25 Oct 2019 02:47:09 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id o196sm573858lff.59.2019.10.25.02.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 02:47:08 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ribalda@kernel.org>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Ricardo Ribalda Delgado <ribalda@kernel.org>
Subject: [PATCH v4] Documentation: media: *_DEFAULT targets for subdevs
Date:   Fri, 25 Oct 2019 11:47:06 +0200
Message-Id: <20191025094706.6490-1-ribalda@kernel.org>
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
 Documentation/media/uapi/v4l/v4l2-selection-targets.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/media/uapi/v4l/v4l2-selection-targets.rst b/Documentation/media/uapi/v4l/v4l2-selection-targets.rst
index f74f239b0510..aae0c0013eb1 100644
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
-- 
2.23.0

