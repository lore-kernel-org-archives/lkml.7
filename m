Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A22AC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 16:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BF2221743
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 16:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfdW1XdD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729086AbfEUQLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 12:11:32 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:47040 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728933AbfEUQLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 12:11:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id r7so19246053wrr.13;
        Tue, 21 May 2019 09:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2w/o0YvWj4GW2dKc8xosf8L/TwKxnX3w/M6Sh7NSyHk=;
        b=DfdW1XdDhItosbvciVXVrDVugIjIifv3cMUMU94Jp8X2FK0ZQxxAZxbv2Qn6Fn5cQw
         49oQd6X322hDf8QS0nhTjEWv5J8P0acGtDtNKgQZuxIKRTV9u11Hl+bRwOWopyqopQ+Y
         Lonri78CM6AFUOHPJRHIFr/dOLafFuQxH2L5XPIYZqgW3eN7bPO9qFdCmfynZBpAgiLx
         Xqs7gEgHeQrAWN7IkS+ExBahYnEL7Dy2Cq0ITBOFdyerMgXruyGZs3ON566JrInM7H17
         YfImRCPSTYENl1tnCSf11UodIQ3LinQlSKeR8WR7i6XeC618r8r7hUfdpgHQDMKqPUrG
         VkoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2w/o0YvWj4GW2dKc8xosf8L/TwKxnX3w/M6Sh7NSyHk=;
        b=sklUUIeJcQJ5RxV7bGgpj5erbJ+RKZBlqgXjIIf0rZcxuG2arC+hTnCjbQbuMvzute
         bQH4WJvgYOkKZSKlo4+KcECuxDw1eV8lNfOyfhPuTqxBjbs/OZhOw3VJv8Va9A2pQoPW
         rJ16E4NKnutHITPMCFXvQkRWU+oOcUHSucTfkEQtTpNKqATfQBAPMgK9YJIvLNNgPtrd
         0njwh4wA9bQdAnvjgmhLx/DmyUx3ipTuTsJGHs88mdMHWzjxX3ccj2UFmcdQvvkwkosk
         hBJkZNLQ9oS+Qg91BEmQzwdok8I8Ccw4J4E8GfDJH/pp7VpRw6Hrz5NwXOy51cpewTKl
         enew==
X-Gm-Message-State: APjAAAUe54fi2+W/Ctux91bXgOrDtb9O2oYIivA5VeI+6DFFq2fsgi8P
        P+3I1vjJ07NY2jQhiy8Nt60=
X-Google-Smtp-Source: APXvYqz4fOGHvkVpsU0vd/YhoaBrRo3VTMc09JZktSMeJdb5LD0oTWIQjOnhKTvCK0VzAq2eMZnopQ==
X-Received: by 2002:adf:f78d:: with SMTP id q13mr1959297wrp.220.1558455071876;
        Tue, 21 May 2019 09:11:11 -0700 (PDT)
Received: from localhost.localdomain (18.189-60-37.rdns.acropolistelecom.net. [37.60.189.18])
        by smtp.gmail.com with ESMTPSA id n63sm3891094wmn.38.2019.05.21.09.11.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 09:11:11 -0700 (PDT)
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
Subject: [PATCH v6 3/6] dt-bindings: gpu: add bus clock for Mali Midgard GPUs
Date:   Tue, 21 May 2019 18:10:59 +0200
Message-Id: <20190521161102.29620-4-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190521161102.29620-1-peron.clem@gmail.com>
References: <20190521161102.29620-1-peron.clem@gmail.com>
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

