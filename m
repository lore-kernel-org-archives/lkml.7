Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D1FC28CC3
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 09:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBADA266DD
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 09:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="eZ5o1iOK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfEaJbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 05:31:41 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43415 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfEaJbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 05:31:34 -0400
Received: by mail-wr1-f67.google.com with SMTP id m6so332778wrj.10
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 02:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oDHxGsrXeJidj701untt/R6ogKG8h4nrtZU+2E4/fDA=;
        b=eZ5o1iOKOmU9ImO+ETCAduVNT36sLs+WQ8dQdJ7NPG7cMC+JkE5CEyy0yxxrR058q6
         cbBygt4YFV4uqu6AS0nSmwion1FztQFXCYEBF9+MKoObTrwoan5UUb38OOjnySOz608H
         lDpvVtjlrDS1dXbS7BbXtH1Xwirui7c9S6ou185LVWF1jSzK+EwSOJ1ukakLdRPFQTg1
         mh5uJbpKwPbcob1V/7wleFI3FxtfoeJ0hKpK/eC3u5a+AL92m3yUyT5CM87zKi80dEuu
         S89IcMPvgiwH93UGEDdkgjFW6Gh+bcs5drh2TC9Awg0CRRLjlM5wPEv18zRKfCd41V72
         5cNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oDHxGsrXeJidj701untt/R6ogKG8h4nrtZU+2E4/fDA=;
        b=QefmL/uVCp7I2Ru6iaoKQmxK/zt7NdpVdridJ4Lux1TkDmPf8H8DaO2rFMfTSFm8dK
         EX6KZQoHcOrYhUbKjdMVJCZXwdGYk4NN6EbZnuO5xfMxtlbgqMdEm0EOJlAAKShgfad8
         igpwG208OkK+7wTvXCsCU7F1EVWPNor5Tfhpu08ujydHljgK9iIwlw6XLwv0uAEKrrce
         Nn/KBmxw1T4YeT6PJOQOrCFLVcgYrGORsNL/YAwBumC16hX7jdC/NEwsdRo0jUJIcXg8
         eId4mxy/DOMJcvt/acax6fr1SawlhK1okk+22fWcjTregcpMijFbsf3rIH/tStA1aj+Z
         m5Dg==
X-Gm-Message-State: APjAAAXezBowVQBOVj7qrGZCY/L61op1KmPVQ2qEqX4L32j4Oti+2hSR
        Xgq8HZpYbc+lxxxE4D6OVHDeEw==
X-Google-Smtp-Source: APXvYqy+FDDF8Pib6Y2BDgETFWEQSTK2um06CcN2NmrEMWrfPEWU/qRyDjEDyw2S9zAZ3x0XMomz8A==
X-Received: by 2002:adf:dc0c:: with SMTP id t12mr5813693wri.101.1559295092871;
        Fri, 31 May 2019 02:31:32 -0700 (PDT)
Received: from mjourdan-pc.numericable.fr (abo-99-183-68.mtp.modulonet.fr. [85.68.183.99])
        by smtp.gmail.com with ESMTPSA id b136sm7187023wme.30.2019.05.31.02.31.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 31 May 2019 02:31:32 -0700 (PDT)
From:   Maxime Jourdan <mjourdan@baylibre.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>
Cc:     Maxime Jourdan <mjourdan@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v7 2/4] media: videodev2: add V4L2_FMT_FLAG_FIXED_RESOLUTION
Date:   Fri, 31 May 2019 11:31:24 +0200
Message-Id: <20190531093126.26956-3-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190531093126.26956-1-mjourdan@baylibre.com>
References: <20190531093126.26956-1-mjourdan@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a v4l2 driver exposes V4L2_EVENT_SOURCE_CHANGE, some (usually
OUTPUT) formats may not be able to trigger this event.

For instance, MPEG2 on Amlogic hardware does not support resolution
switching on the fly, and a decode session must operate at a set
resolution defined before the decoding start.

Add a enum_fmt format flag to tag those specific formats.

Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
---
 Documentation/media/uapi/v4l/vidioc-enum-fmt.rst | 6 ++++++
 include/uapi/linux/videodev2.h                   | 5 +++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/media/uapi/v4l/vidioc-enum-fmt.rst b/Documentation/media/uapi/v4l/vidioc-enum-fmt.rst
index 822d6730e7d2..b11448a1848b 100644
--- a/Documentation/media/uapi/v4l/vidioc-enum-fmt.rst
+++ b/Documentation/media/uapi/v4l/vidioc-enum-fmt.rst
@@ -127,6 +127,12 @@ one until ``EINVAL`` is returned.
       - This format is not native to the device but emulated through
 	software (usually libv4l2), where possible try to use a native
 	format instead for better performance.
+    * - ``V4L2_FMT_FLAG_FIXED_RESOLUTION``
+      - 0x0004
+      - Dynamic resolution switching is not supported for this format,
+        even if the event ``V4L2_EVENT_SOURCE_CHANGE`` is supported by
+        the device.
+
 
 
 Return Value
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 1050a75fb7ef..9b0a7f82dd92 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -768,8 +768,9 @@ struct v4l2_fmtdesc {
 	__u32		    reserved[4];
 };
 
-#define V4L2_FMT_FLAG_COMPRESSED 0x0001
-#define V4L2_FMT_FLAG_EMULATED   0x0002
+#define V4L2_FMT_FLAG_COMPRESSED	0x0001
+#define V4L2_FMT_FLAG_EMULATED		0x0002
+#define V4L2_FMT_FLAG_FIXED_RESOLUTION	0x0004
 
 	/* Frame Size and frame rate enumeration */
 /*
-- 
2.21.0

