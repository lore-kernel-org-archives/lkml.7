Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E52C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 17:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9B212173E
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 17:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjsEnXYi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfELRq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 13:46:56 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44851 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfELRqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 13:46:20 -0400
Received: by mail-wr1-f67.google.com with SMTP id c5so12680312wrs.11;
        Sun, 12 May 2019 10:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2w/o0YvWj4GW2dKc8xosf8L/TwKxnX3w/M6Sh7NSyHk=;
        b=AjsEnXYimdr8AvydteCtPqKKl4nVXnBE3i0ABKHq/uJCZi98gqAOEJgPbS7s5lnb7d
         8AbtSEb/imSgq1c4/AUmc6O/cboc0TJGeCLfOp5Z3oNlvT9V9iVXZXEKeQQMhr8t1lRM
         YaT2dlb4MSUgf73LLkrdJA19XRmXH41HYOryaYBusMPZZdr04tXBk2k3TPhwIrTwIFL+
         F1JPK6mLy6Fqvl3p0WlAv5jCn2oIU6MEJ3efLRpIq7BrqCaE3nXnVTIKTnt9g9h7kU0W
         9SxtSgkGYN+D7UvI0CpXOQ3IbHf0wsrlQtgOHOeCESbKGDvOgP49Z67LcO6RGwEXR3uA
         ziQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2w/o0YvWj4GW2dKc8xosf8L/TwKxnX3w/M6Sh7NSyHk=;
        b=FDqKn3ZJ+lVYe0txxgyqkkRA8u1cTYoI9+jE892VLAVOGQi5ngBa2M3VKbPMt0s34D
         wi+LzqNxUAKZJsGRtmG1vsOFIg7lfu5mp28AiOl7oSTk8hHnKYEC9dKUYfK+TssWLOfh
         k9qUrt/QJfTdZapUyZmGn5lLdHvMMGkVMXTyy/G2ffZQXxIE01xNnThLI5h2VqC637/+
         GF9xj1JTFfh2OMBgfrslrJFRTt0L8e7elD1HPj5IR1Ac9+Qeh7jvkwWTXEXHKUMZliii
         PXt/RhMz1+b0BhUki0ZjVsEj8VcQ8+w31uUtho8JWMnLqc+HX7Bw5LlzqZvUSEBOmkBx
         mrhA==
X-Gm-Message-State: APjAAAXo66GbhwSWyxOCHa4uIlow4wHJpQB8JU1zQi6C9MaoH3ZJanS3
        Itpxr9hJeYr2lfTxQ+/GyRg=
X-Google-Smtp-Source: APXvYqzvp8ezt6AmI9jIyt2T+HF6x4fAV9SfcMVOJ7+O+OXtpp/dMmSAZ2wvp2VfVb1lYQz+lHV//w==
X-Received: by 2002:a5d:4fd2:: with SMTP id h18mr15357356wrw.117.1557683177903;
        Sun, 12 May 2019 10:46:17 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id d14sm9090558wre.78.2019.05.12.10.46.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 May 2019 10:46:16 -0700 (PDT)
From:   peron.clem@gmail.com
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v4 2/8] dt-bindings: gpu: add bus clock for Mali Midgard GPUs
Date:   Sun, 12 May 2019 19:46:02 +0200
Message-Id: <20190512174608.10083-3-peron.clem@gmail.com>
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

From: Icenowy Zheng <icenowy@aosc.io>

Some SoCs adds a bus clock gate to the Mali Midgard GPU.

Add the binding for the bus clock.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
index 1b1a74129141..2e8bbce35695 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
@@ -31,6 +31,12 @@ Optional properties:
 
 - clocks : Phandle to clock for the Mali Midgard device.
 
+- clock-names : Specify the names of the clocks specified in clocks
+  when multiple clocks are present.
+    * core: clock driving the GPU itself (When only one clock is present,
+      assume it's this clock.)
+    * bus: bus clock for the GPU
+
 - mali-supply : Phandle to regulator for the Mali device. Refer to
   Documentation/devicetree/bindings/regulator/regulator.txt for details.
 
-- 
2.17.1

