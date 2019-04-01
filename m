Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC00C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 13:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E1E4206DD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 13:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Po33D9vx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbfDANjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 09:39:24 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39086 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728355AbfDANjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 09:39:03 -0400
Received: by mail-wr1-f67.google.com with SMTP id j9so12104248wrn.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 06:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W4Q5AbKbln/Fu2EQxLepyTtJKMD+qTIvZtoNE1VnyUg=;
        b=Po33D9vx6Hu6bDHxutnO535NGEcbzTijhog09s4FmNNp8B/ggr0OFm/szBbgu2eGGS
         A7k2zD3bS6uLzH2eNpC/iXM/S1UBMp+WPnrn6cHCJZ8pOtw6H1kdgPm9Fz14cuto98VB
         DTHzNo1BZd2MSZw/cv8/m3ZgrI/wcTy8UwkkGdBv26FDvhcA60Nbj6luDlXyPjH8XWmq
         ychX7Ly7ZzWHvr3+TCW+lOa9JMHWNfOKWlJ+g0PjFQEIo3ukW9VwAmD0u/yBiwo2twz6
         8euI5ZVVVrDLc5U2FXp/KQRcx71jv51k9guoNH/yomhTot+z+kNDskEmvSuSE+BEsyOR
         Ysnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W4Q5AbKbln/Fu2EQxLepyTtJKMD+qTIvZtoNE1VnyUg=;
        b=Byx1n8iUnCjx/jY9/+NoTo45FOiWpEhLu7jdsC/QTJo1CECdjqrOe01RTx0FjwSKP2
         sqvK+3hhelU2m6R5/RAmptL+Oqkr0Df4Z99tFBCwmmmVezp4aDM/4KHnxDKEljZ0az3v
         eAThiQ4SJ1x2MlDdfTp2AdAn5d06dBO8XvA6vRYwZkSBUWFFQ95S6VOQAyt9AVJkNJuL
         bgUmITrxLwHcAQJq14atCB1Y9LWt6Gzx3oYpl/Za4Ywp25bGjpFlbtJQuBFmYZMBdfJ0
         jVQGv0cuZMLBKILCwAxzae8B6q+O9XH6BXXAVyjjt/xZEGJULF0ONfxv5XCtdDM2QKet
         CVqQ==
X-Gm-Message-State: APjAAAVB8Rq8W8GxqgPEYMzSAbCQTMIXB1SZG+JNAKVxvj613BhxDkP9
        EwJTJWTY+DlPT9bhilDPCeAqAw==
X-Google-Smtp-Source: APXvYqxTUchDyD2CapUrfQKpMKZeoRgwiyWB4JZQOimUIVfTCxhqoNIap1rkPJM+AA06ajth/EHnPw==
X-Received: by 2002:a5d:638d:: with SMTP id p13mr40116890wru.202.1554125941395;
        Mon, 01 Apr 2019 06:39:01 -0700 (PDT)
Received: from mjourdan-pc.numericable.fr (abo-99-183-68.mtp.modulonet.fr. [85.68.183.99])
        by smtp.gmail.com with ESMTPSA id v184sm25205996wma.6.2019.04.01.06.39.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 06:39:00 -0700 (PDT)
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
Subject: [PATCH v5 2/4] media: videodev2: add V4L2_FMT_FLAG_FIXED_RESOLUTION
Date:   Mon,  1 Apr 2019 15:38:43 +0200
Message-Id: <20190401133845.4171-3-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401133845.4171-1-mjourdan@baylibre.com>
References: <20190401133845.4171-1-mjourdan@baylibre.com>
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
index 1db220da3bcc..9c8a2d2e7bc6 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -751,8 +751,9 @@ struct v4l2_fmtdesc {
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

