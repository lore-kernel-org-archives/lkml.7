Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0607AC04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 17:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA466217D7
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 17:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C87Q+0KZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfELRqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 13:46:25 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50660 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbfELRqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 13:46:21 -0400
Received: by mail-wm1-f68.google.com with SMTP id f204so6170820wme.0;
        Sun, 12 May 2019 10:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EXpuW1H5E6JQJvkk+bffS60LiMlJ6FTGBpL+lRXA+/0=;
        b=C87Q+0KZQadrQrFy/za95yC+j5F9HIcOk+MD/C9HIXG+ocEQapjM4S2ITPa0BLHET0
         TveZfiYQ/0GIB0Q3RDpOCPvI8Dq5yBr0wNvFMerC0oF3tyITvUzD/EMkVuawaWcZUeJW
         Losyzn7J5obpJCtjMEmo4hNYOj5ULqh8Mdo7ZOuLLhrEEMff8cwte3uzAy4fMbRvy94O
         YdhlCq/6M2Vyhu/IoB60ud/+9jDueB89Y3+rz/lRGzS5vw/O/YtZa+uLqVQsxXQ+yUt3
         yyK0Fznt12O+GzSnJ+cMNNwKLT0DYr5HX1QPF3OWWx5m5t/RszjCKfW0+mrczm8pWipQ
         Jn0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EXpuW1H5E6JQJvkk+bffS60LiMlJ6FTGBpL+lRXA+/0=;
        b=U0627i1f9p5dEa0I6BThK6v2LOqhGPOYLJpwiCEhmiV/9QAguQP1SKJaM4ui/VXFs/
         6YhiEBLz/MaNFg0Ym848QeHn8XE62Jn6xBp3TmASgo8c0ctQucl+DhLxGIZFBrmJ4w/z
         PewbxFKv4rIcktzszUzfWYJIvSS1CsfA7E4UX9PMeOlMDaCHNz/3cNJoShlJiqvfkKaD
         cftinl8TmMlFFGTkZ+auVCi2eIfPqUgwNU5qTMyR22btMfzX+/os12unrD0qRF1VNCcF
         LtdvVHRAMkNVgKFiSFKRM1pWsqp9gKux1bjequFIEe+UuiK1jgInsWmk4JyJG9ULVywV
         tqmA==
X-Gm-Message-State: APjAAAXjx6duR90unSDvJskPrk5GYbJo6+WMFojf7jdJH5+IN65aeW2h
        Dk+H+URQuzjySrFcmCWvwDo=
X-Google-Smtp-Source: APXvYqxhB7vibCkxRA4FPfP8y01EU8vmUJIZfLKUu16/cqguHPZ7Vjvf/kWOGAn7GjdIKhCBtdMUHg==
X-Received: by 2002:a1c:7a12:: with SMTP id v18mr13528180wmc.69.1557683179040;
        Sun, 12 May 2019 10:46:19 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id d14sm9090558wre.78.2019.05.12.10.46.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 May 2019 10:46:18 -0700 (PDT)
From:   peron.clem@gmail.com
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v4 3/8] dt-bindings: gpu: mali-midgard: Add H6 mali gpu compatible
Date:   Sun, 12 May 2019 19:46:03 +0200
Message-Id: <20190512174608.10083-4-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190512174608.10083-1-peron.clem@gmail.com>
References: <20190512174608.10083-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Clément Péron <peron.clem@gmail.com>

This add the H6 mali compatible in the dt-bindings to later support
specific implementation.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/gpu/arm,mali-midgard.txt         | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
index 2e8bbce35695..4bf17e1cf555 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
@@ -15,6 +15,7 @@ Required properties:
     + "arm,mali-t860"
     + "arm,mali-t880"
   * which must be preceded by one of the following vendor specifics:
+    + "allwinner,sun50i-h6-mali"
     + "amlogic,meson-gxm-mali"
     + "rockchip,rk3288-mali"
     + "rockchip,rk3399-mali"
@@ -49,9 +50,15 @@ Vendor-specific bindings
 ------------------------
 
 The Mali GPU is integrated very differently from one SoC to
-another. In order to accomodate those differences, you have the option
+another. In order to accommodate those differences, you have the option
 to specify one more vendor-specific compatible, among:
 
+- "allwinner,sun50i-h6-mali"
+  Required properties:
+  - clocks : phandles to core and bus clocks
+  - clock-names : must contain "core" and "bus"
+  - resets: phandle to GPU reset line
+
 - "amlogic,meson-gxm-mali"
   Required properties:
   - resets : Should contain phandles of :
-- 
2.17.1

