Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79794C48BDC
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 13:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53310206A3
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 13:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TuvJAzVe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbfGGNXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 09:23:19 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53035 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbfGGNXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 09:23:18 -0400
Received: by mail-wm1-f68.google.com with SMTP id s3so13228956wms.2;
        Sun, 07 Jul 2019 06:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=bpMKBCyFHgrQiKy7buB0LlekziIPeofsVDIfjc0AyOM=;
        b=TuvJAzVeDXICNheVzilpNB/Cs3NjzSCvyonFwKOTUrMr+8gYWEw8LkT9BFdAe1/KJa
         RQkDrhcJp8Sa/bGFsb/LmBOqWuB5ku2J+gNg5oQS7sRpoQzvRGrPxTHcKQAvxT+UTMQw
         4y4ZGcVflPIYljz19CoHHcjz0KJOXLc6aMiwD4KkviW/jKYSjbjI/YatERjpWncD5N/v
         Fj7ftbeFtelSd6ou44N8DJnBCHFEsMrPPK+vlagcjnLoKEkrDur5+t3Saty1deT88JGb
         yZqbRWtwrUMRYSoBjl42GHO3xwGxBO68XeHUzV2t0ES43DZcw191TGOUCyq/cAVULQpz
         0mkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=bpMKBCyFHgrQiKy7buB0LlekziIPeofsVDIfjc0AyOM=;
        b=cZLAPJAq/xmK/JrcjRNfqk/du3pypLrIP8qgpTCgPdTEAhmMd+mTHJc4hnyhs414mF
         BD2azeIx8HB9tHkN79zAWC+/UsDL3xPzqO1snr5CrsWmL6C6BFwaZ+iJ/m66V7JUenGr
         ewvGLqSQdmBcc7B96oHkMmB1/Y+cUixQo9JlBX56YPHKJKhHvFFraJyd0xb5sW56nEsZ
         A60K1bb4K8Bu+iMYxZNyhHkblq2psX2bmDfABf6ppeEKNCpr0ALBzMpjl9U19tmgzP/2
         0XnBigqwbSH1C/VgPq/1C9QoSHeNHucqJiI5F/BEbXOgVEUNRNbPSSHTZf1FGLSsjN/n
         Eckg==
X-Gm-Message-State: APjAAAWhOR+X30knTJcDsIMgzOxxMeIPYHs7jjhv8eUiKOE0whJyANMu
        7lLgB33T/j8wZJmn8VUhP64=
X-Google-Smtp-Source: APXvYqw7tff4i83OSNi7Zx1TEI+45avVCAugUXjVfMhkCi2pLfvW3AeorDogqslxlq3WBg+tzU4c5Q==
X-Received: by 2002:a1c:99ca:: with SMTP id b193mr12068007wme.31.1562505796292;
        Sun, 07 Jul 2019 06:23:16 -0700 (PDT)
Received: from arks.localdomain (179.red-83-58-138.dynamicip.rima-tde.net. [83.58.138.179])
        by smtp.gmail.com with ESMTPSA id f2sm11022353wrq.48.2019.07.07.06.23.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 07 Jul 2019 06:23:15 -0700 (PDT)
Date:   Sun, 7 Jul 2019 15:23:13 +0200
From:   Aleix Roca Nonell <kernelrocks@gmail.com>
To:     Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] arm64: dts: realtek: Move rtd1295 memreserve areas from
 the generic rtd129x to its specific dtsi
Message-ID: <20190707132313.GD13340@arks.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two memreserve areas in the rtd1295x description that are not
present in the RTD1296 SoC. This patch moves such areas to the rtd1295
device tree description.

From the commit introducing such memreserves[1]:
 - 0x00030000 is undefined
 - 0x01b00000 is audio related

[1] - commit 72a7786c0a0d65 ("ARM64: dts: Add Realtek RTD1295 and Zidoo X9S")

Signed-off-by: Aleix Roca Nonell <kernelrocks@gmail.com>
---
 arch/arm64/boot/dts/realtek/rtd1295.dtsi | 3 +++
 arch/arm64/boot/dts/realtek/rtd129x.dtsi | 2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/realtek/rtd1295.dtsi b/arch/arm64/boot/dts/realtek/rtd1295.dtsi
index 41d7858da826..586cb1ee8cb8 100644
--- a/arch/arm64/boot/dts/realtek/rtd1295.dtsi
+++ b/arch/arm64/boot/dts/realtek/rtd1295.dtsi
@@ -6,6 +6,9 @@
  * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
  */
 
+/memreserve/	0x0000000000030000 0x00000000000d0000;
+/memreserve/	0x0000000001b00000 0x00000000004be000;
+
 #include "rtd129x.dtsi"
 
 / {
diff --git a/arch/arm64/boot/dts/realtek/rtd129x.dtsi b/arch/arm64/boot/dts/realtek/rtd129x.dtsi
index b9cb92466fc7..9009db909fab 100644
--- a/arch/arm64/boot/dts/realtek/rtd129x.dtsi
+++ b/arch/arm64/boot/dts/realtek/rtd129x.dtsi
@@ -8,8 +8,6 @@
 
 /memreserve/	0x0000000000000000 0x0000000000030000;
 /memreserve/	0x000000000001f000 0x0000000000001000;
-/memreserve/	0x0000000000030000 0x00000000000d0000;
-/memreserve/	0x0000000001b00000 0x00000000004be000;
 /memreserve/	0x0000000001ffe000 0x0000000000004000;
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
-- 
2.21.0

