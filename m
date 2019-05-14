Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FCBC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 13:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 143C72166E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 13:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Lac0zP3M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbfENN4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 09:56:24 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51589 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfENN4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 09:56:20 -0400
Received: by mail-wm1-f66.google.com with SMTP id o189so3003655wmb.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 06:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oDHxGsrXeJidj701untt/R6ogKG8h4nrtZU+2E4/fDA=;
        b=Lac0zP3MgQDHm22bQE4nSrkyNe8uukQesol88+EA7fgTIY6grTc10fcGmsh3CQo5NT
         SQDJGdzVXFupyQ8yU+5K4a9W2KYoCjvoMj1wbCM0yMPAgwMAELJFEZAoTLYJaOiHzc4t
         HLolkemGtcdytaw3wngI2rM+VY2A1xnWlyBCifi85baEtTOzFqndDgdxcZiCSaYi8n5z
         ZF+Nz+A05FvWbfUlEwKqXt4cgZ8DppFR33frFEoFlniGFd4qPz8bBPYED51Se9BeC+zl
         p5TeAv5AL/GTHRweqp2FwNWdHSWWfHWShipgGGZ8PnBtQCGQUm4V5SPH8eS1DRt+/v96
         8b8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oDHxGsrXeJidj701untt/R6ogKG8h4nrtZU+2E4/fDA=;
        b=CNE1VHDjQB1H7sqNhLrfwi6cn7CJ/zR3jaNe9yjmEZquMJHxQP0h47YCDpc9KP//0b
         z/IJuxe3xhUP2iemSxRz0SejvHxMhCkHVcK4TC1WZ2HIyPdvuXC8n2AZrDe1FR96YHgf
         T749KVYGB5OPWRjTGjRr+vwvmi4ymUhdNTQbS1Wlgr5/FK63D0t7+4/nTr8XJDHexx+Q
         x7jy92qFds8TduojoDIgR7G++F7HRnkXQy5M4VqprRDWPXHR1f11hAidUfckfrTU9wYB
         ltxg3CBP6VvQ5lGaL6bhOe/m42A3pNMtPz+pghx6tlt9izFYwHN06N38lfSiz8U5tAKA
         yP+Q==
X-Gm-Message-State: APjAAAWHa146oNG1Uv8hWUnUiHoS1495lY3C/eYQMtPY0HhvDWzaYCsY
        5ahsgY4qmbWddf+pdOLQN3k5FQ==
X-Google-Smtp-Source: APXvYqysQhF099GYmS3TpeXdPijkIZtr1HbM/ak442MCB8g0sFSjtVD5TgYPOjSACa7qTnYfThZICw==
X-Received: by 2002:a1c:701a:: with SMTP id l26mr19416389wmc.50.1557842178935;
        Tue, 14 May 2019 06:56:18 -0700 (PDT)
Received: from mjourdan-pc.numericable.fr (abo-99-183-68.mtp.modulonet.fr. [85.68.183.99])
        by smtp.gmail.com with ESMTPSA id d72sm1375764wmd.12.2019.05.14.06.56.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 06:56:18 -0700 (PDT)
From:   Maxime Jourdan <mjourdan@baylibre.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Maxime Jourdan <mjourdan@baylibre.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v6 2/4] media: videodev2: add V4L2_FMT_FLAG_FIXED_RESOLUTION
Date:   Tue, 14 May 2019 15:56:10 +0200
Message-Id: <20190514135612.30822-3-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190514135612.30822-1-mjourdan@baylibre.com>
References: <20190514135612.30822-1-mjourdan@baylibre.com>
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

