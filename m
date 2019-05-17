Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E2FC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 18:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AC6121848
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 18:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMauM/oR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbfEQSrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 14:47:16 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38780 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbfEQSrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 14:47:11 -0400
Received: by mail-wr1-f66.google.com with SMTP id d18so8166269wrs.5;
        Fri, 17 May 2019 11:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2w/o0YvWj4GW2dKc8xosf8L/TwKxnX3w/M6Sh7NSyHk=;
        b=mMauM/oRgsPGZUvkUT/+QSTeGRj6V4+Bsa6SDx89DACsieftOUcfnpP0PEa41Y7jjx
         vXR0gKI35+II1451PFUMT8qwllnoMQCNopXWWgkKjmFkg97k9NkB0qyU/ITdLnqaNvhm
         7824EGQbsW7XUYg+EzvF7fldSBjWgoGIYtjpilZkMG0t9WLhzSrvsol8kDo+K3T3NCbz
         PtKzNCbAtvYzjHxH1L/LnQ5cuh6R/Ykju94XenD6GIqKrMqbcTl7PRp9x84vws0jG24X
         O0reJu7XDq7JltXMnRyde6v/Fyx4Zr/oaaCH3CSZNg0MmhVKzYSpSwrgTvKQLNFPdlfF
         wbeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2w/o0YvWj4GW2dKc8xosf8L/TwKxnX3w/M6Sh7NSyHk=;
        b=qy2D90BVTc2c7vCID5TbQ1DPbCYSzbGm9zPli5JHlg3Q/PjUjFgKTHZjX/WGNP2IeE
         HIR5D8CPUUVmEOwLZUR8bBRyw6IXEWolBLJvsDtld/lBbe0jfMhnVfKfLTBJcEpTgMjq
         7VaelTvNiHQUBUuTL2bNkLvbirsx/ly0L73kv9pAmJOtsrcY1GOaQUU42WjicW5MmWNk
         udcZ6u4KtRI+19VO/NeZ/XcONrasLOgLYl+Vob1CNB1BS5I+THvi6Ywc4yCWkDlMXnQA
         xLWhIgSYmNWNTGjwicGRlaOuY+YPEs4S8woVVa4exSU0cX6GnMgW3xEEco9IuC5uNicY
         vWpA==
X-Gm-Message-State: APjAAAUlDQzNSinLtzWPVGPQIMB3PwoLJagdIX4u5UNM7Q7NkzBrCH2k
        OXkHgB0M8YXRhtez2lr7YZw=
X-Google-Smtp-Source: APXvYqwJzLvCjxFr10WwtK8XqGQ5+MmNhKYR5eWWQw+nzXOrlwwqnjpWoqW7Z7qd4a37Tuhgl5Jysw==
X-Received: by 2002:adf:eb03:: with SMTP id s3mr29605848wrn.170.1558118829632;
        Fri, 17 May 2019 11:47:09 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id v20sm5801112wmj.10.2019.05.17.11.47.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 11:47:08 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Steven Price <steven.price@arm.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, Icenowy Zheng <icenowy@aosc.io>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v5 3/6] dt-bindings: gpu: add bus clock for Mali Midgard GPUs
Date:   Fri, 17 May 2019 20:46:56 +0200
Message-Id: <20190517184659.18828-4-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190517184659.18828-1-peron.clem@gmail.com>
References: <20190517184659.18828-1-peron.clem@gmail.com>
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

