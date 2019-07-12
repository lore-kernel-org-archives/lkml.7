Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3913AC742B3
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 09:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FE9D2064B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 09:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="VBrYnU0y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfGLJl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 05:41:29 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37878 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbfGLJlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 05:41:24 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so9274362wrr.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 02:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K7MVo1cgFDsjyODbl6UghYby+bBwKYEV5/hf6CSHL9M=;
        b=VBrYnU0yPv77EIYg1g/dicwzuGQ6nyDmHWmyZLJNEYGqWrydbj9U1R6UMjqTL+Rn64
         bw2Sj2MTumt1Tlg2zcHRP6wDqUzILfMOksRhjy2dHSQ7JVORA3BFGlbPz0UhduB1cVFx
         BLhluNhujbrdgj4kHFIfcDVsalyoAiSJ0vKdFdls/E9CCwdXqNJOcM/EnmsPo6VGb9C5
         NP5DE7EKXioz12MeMD061C+7G5wLQKz1Pl/yiSp/7/HN1W3sBsCISb7DK5Q/QWQYAAuL
         ZWXgEyj4bONMs9I/7xRB0MwXxYrzdsUDgS/yeIQwH1SSRYCqyybl8TMxGhjiLPBC4q4Q
         qMNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K7MVo1cgFDsjyODbl6UghYby+bBwKYEV5/hf6CSHL9M=;
        b=OOqDYmk8K4/xd819yvscdhM09PZAOO7G6kCFlA7EuUGM2t/O5Ys/r5ybY7FXcyHDso
         wL159NoMD270iddZFP/1J78weL/pz8FhBqzyTY7hutKIK1oY7cxLCApe+eit1OGk0dNq
         9jR194qWrIDoZFgwjxT9Q8/XmytbJqr26N3LKx0Oag6ZxWZI8HdBoWokeYkRjJaU6RRw
         Jrni5u5llBpfXWYmt9ZQCmHb1MUtURx3f6UhlOEVROG/C9lve1dpOGX1WrO6VL5/tej6
         NFkSUf11s/h/MopGwJ1kPx7Gzdn0N3jcm2+oVNKZelMLyN7OrT4XiiS+Ad4N94t2IsZn
         fbTg==
X-Gm-Message-State: APjAAAWq6hlEgKgDNi+YbkdDfN5UHHWUVuEJpTqND2sl5x95uZuHNcXV
        2EhNSO+LUmfG/p1VxWpw8DcQkQ==
X-Google-Smtp-Source: APXvYqx4f/6QDHi1/6qjUGikdMhx1yBPBfM4XuV2S++h0JOOo+dTiwzJXxgkTnyMoEJiobPg9Rby7A==
X-Received: by 2002:a5d:4484:: with SMTP id j4mr10788448wrq.143.1562924482650;
        Fri, 12 Jul 2019 02:41:22 -0700 (PDT)
Received: from pop-os.baylibre.local ([2a01:e35:8ad2:2cb0:2dbb:fac9:5ec0:e3ef])
        by smtp.googlemail.com with ESMTPSA id p18sm7310891wrm.16.2019.07.12.02.41.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jul 2019 02:41:22 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, jic23@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        baylibre-upstreaming@groups.io, dmitry.torokhov@gmail.com,
        linux-input@vger.kernel.org,
        Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH v4 2/3] dt-bindings: iio: position: Add docs pat9125
Date:   Fri, 12 Jul 2019 11:40:49 +0200
Message-Id: <20190712094050.17432-3-amergnat@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190712094050.17432-1-amergnat@baylibre.com>
References: <20190712094050.17432-1-amergnat@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the optical tracker PAT9125 and
"position" directory for chip which can provides position data.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 .../bindings/iio/position/pat9125.txt          | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/position/pat9125.txt

diff --git a/Documentation/devicetree/bindings/iio/position/pat9125.txt b/Documentation/devicetree/bindings/iio/position/pat9125.txt
new file mode 100644
index 000000000000..4028aeef9b42
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/position/pat9125.txt
@@ -0,0 +1,18 @@
+PixArt Imaging PAT9125 Optical Tracking Miniature Chip device driver
+
+Required properties:
+	- compatible: must be "pixart,pat9125"
+	- reg: i2c address where to find the device
+	- interrupts: the sole interrupt generated by the device
+
+	Refer to interrupt-controller/interrupts.txt for generic
+	interrupt client node bindings.
+
+Example:
+
+pat9125@75 {
+	compatible = "pixart,pat9125";
+	reg = <0x75>;
+	interrupt-parent = <&gpio3>;
+	interrupts = <12 IRQ_TYPE_EDGE_FALLING>;
+};
-- 
2.17.1

