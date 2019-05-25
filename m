Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4C0C282E5
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 16:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53B8221707
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 16:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tldWfn+O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfEYQic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 12:38:32 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36968 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbfEYQi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 12:38:29 -0400
Received: by mail-wm1-f65.google.com with SMTP id 7so11947652wmo.2;
        Sat, 25 May 2019 09:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+kaEItJcaTQdesa5AwBphmDXJUwfK0zSJiZ3kKfuxsg=;
        b=tldWfn+OxPKMZx/Oyc1ypAr0UlqU6Gfb3hmG/dfSR1D7w2GpoPTcyQPqYd8+tYpGGw
         b4wcvDj8ybAuteLbUuoZ+aHQiK4l2LsWPlLBVQ0zcV6T7IX8sMcbaTuOh2X1jnrzk/bw
         LQIecJOG389dHZ8bejwGAi0a7Y+IcWLEqmOIcbIDaKfz49mZPUpE69CeSatuusTVC8As
         I7l5xnB9TWjVy36bLabTU3ydRFFbYXoYo5QAh9YrKH0qNBgwBrFGw1cbSdytxM6vGegX
         Ym8FjFr+z8FEPrs40fr0OKNPXaWBCVYGJUep+c5rT0sfOwwq/0wK36OaBFrhRZxQ/wxV
         XX9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+kaEItJcaTQdesa5AwBphmDXJUwfK0zSJiZ3kKfuxsg=;
        b=FD4vgEI9v4P+WZCj2ebgipfmhIcWmoSFgCVfIdB2wTuGo6BTJu0mO9s1N+8xL+53bs
         IgmZKSlMFYE0rIoF0syLsl+UgdtPFdKxD1GU0SZDGa4hGJQMgxR1NvY30FPETX2vPV1l
         a7O7jHgV2ouWy1zmRYqBtIyJQ7kG7fiZRJ8hQl2/Yzc3pvRftgzYC/r1eIS7jpbPtc5A
         Wmj7kOLsWwcyYIHj0NQ50JsR0wBhgpMazOlI8lznxaKCExnmedBXwrXOd0VwYUuudh1i
         cxFQezUrbfHN+b3KpwyPjRgs7IiCTWz/4Z0CgZrcGk0UQN43C9Q8KdKFanEHNnbPtkEQ
         KQ9g==
X-Gm-Message-State: APjAAAUF0wgS17Fk1WTX7RPfvWNWTW5PZjhWYMsqF5jQtWc6eFXp5JCQ
        ICRhPLAMJGvBJAtVLma6dpY=
X-Google-Smtp-Source: APXvYqwB8tQa8yREQBVlZfFZNxC8QpkOD/EKvarkstGMVEuMayTCJjBx4vyzn5n0K91H3QWUM8JSfw==
X-Received: by 2002:a05:600c:28d:: with SMTP id 13mr20072685wmk.15.1558802306796;
        Sat, 25 May 2019 09:38:26 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id f65sm9306498wmg.45.2019.05.25.09.38.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 09:38:26 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 1/7] dt-bindings: arm64: allwinner: h6: Add binding for DMA controller
Date:   Sat, 25 May 2019 18:38:13 +0200
Message-Id: <20190525163819.21055-2-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190525163819.21055-1-peron.clem@gmail.com>
References: <20190525163819.21055-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jernej Skrabec <jernej.skrabec@siol.net>

DMA in H6 is similar to other DMA controller, except it is first which
supports more than 32 request sources and has 16 channels. It also needs
additional clock to be enabled.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 Documentation/devicetree/bindings/dma/sun6i-dma.txt | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/sun6i-dma.txt b/Documentation/devicetree/bindings/dma/sun6i-dma.txt
index 7fccc20d8331..cae31f4e77ba 100644
--- a/Documentation/devicetree/bindings/dma/sun6i-dma.txt
+++ b/Documentation/devicetree/bindings/dma/sun6i-dma.txt
@@ -28,12 +28,17 @@ Example:
 	};
 
 ------------------------------------------------------------------------------
-For A64 DMA controller:
+For A64 and H6 DMA controller:
 
 Required properties:
-- compatible:	"allwinner,sun50i-a64-dma"
+- compatible:	Must be one of
+		  "allwinner,sun50i-a64-dma"
+		  "allwinner,sun50i-h6-dma"
 - dma-channels: Number of DMA channels supported by the controller.
 		Refer to Documentation/devicetree/bindings/dma/dma.txt
+- clocks:	In addition to parent AHB clock, it should also contain mbus
+		clock (H6 only)
+- clock-names:	Should contain "bus" and "mbus" (H6 only)
 - all properties above, i.e. reg, interrupts, clocks, resets and #dma-cells
 
 Optional properties:
-- 
2.20.1

