Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40723C76194
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 12:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A0652238C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 12:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="UExMW0UU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfGZMqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 08:46:52 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33367 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfGZMqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 08:46:51 -0400
Received: by mail-wr1-f68.google.com with SMTP id n9so54411646wru.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 05:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q2ZYPAYax6bQxbm/1YpeRuib4ukPUXFCF68rf3gTwXE=;
        b=UExMW0UUk/saslNhvncL7VmYbPBukVTDIwiQ9JEDm69304VqE2iV0GPHIMb+GUPi9Q
         XdND6CCt4qIO7Z4R//L+VDKTJAUY+3+Y1HzYcDO2y4mr4QOkGhwHY3+9qwH1jcJt6sgE
         CoiuxUwVJ1pmjRomS01ZwYEr690+g6Hf0aYHNDKua/QYqVCnK8s+lUjCoMqMBGPuokIZ
         gewunm6XF2lbta7rgn6eIKlLbS4HzeUPan8WI9YsybAITkTOZdv07nFpAQE8F/0jpMWr
         1C43R+9oAIwvWjl4yunSxC0lKcsRwrKAEgJ9Muul1S0BDHCmeNzV8cK0Ds3kH/DwncuW
         bJPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q2ZYPAYax6bQxbm/1YpeRuib4ukPUXFCF68rf3gTwXE=;
        b=I5QvXO7uhXnnTaOi2J+tVxl1bRub7xyyCBGeCznUHAoDq2tfcT9QH9zKp5LdjLDGBw
         TyMOqvvWL/vhW7rxTNT2F/UNazD8gJqe7ZjH5NtTsYcxVgDBUP2iLQ/D3vENHftGhDFO
         jTuIwpi6Z6fFcjaqZENpxsURJU1OS3hhLWAK11hINBnuMe0CN7NnEtJ4YrLtLmGAP09G
         YL3TdjQ2Q6u7zKeaAMSb9YD0PIj3ITnACrVVI5M0OTFAvPtjvnjruLXlGV6aOETMpQgN
         1eGAfJjfLswxc7raH/iOQn1w20mBdXlQ/A0vi+Fkbg1vDu5HGNuzuQME6pgTwNp6WCoc
         AtAw==
X-Gm-Message-State: APjAAAWs2kDj7kPCgRpX+fa/5JCVnxEc29q1m7YciQGgxSkM0Lya5Ba3
        hoZe2VMkK545ZgAqbF0WrWnVuw==
X-Google-Smtp-Source: APXvYqwqpHIX1Hp7OItyBHPULfeNjzdPhmgqs5iWOD8M1voMJHDkAIcMIUA10pnpZcFezyDpSX8tag==
X-Received: by 2002:a05:6000:3:: with SMTP id h3mr16592055wrx.114.1564145209279;
        Fri, 26 Jul 2019 05:46:49 -0700 (PDT)
Received: from mjourdan-pc.numericable.fr (abo-99-183-68.mtp.modulonet.fr. [85.68.183.99])
        by smtp.gmail.com with ESMTPSA id x16sm39090124wmj.4.2019.07.26.05.46.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 05:46:48 -0700 (PDT)
From:   Maxime Jourdan <mjourdan@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: media: amlogic,vdec: add default compatible
Date:   Fri, 26 Jul 2019 14:46:37 +0200
Message-Id: <20190726124639.7713-2-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190726124639.7713-1-mjourdan@baylibre.com>
References: <20190726124639.7713-1-mjourdan@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first version of the bindings is missing a generic compatible that
is used by the base node (GX), and then extended by the SoC device trees
(GXBB, GXL, GXM)

Also change the example to use "video-codec" instead of "video-decoder",
as the former is the one used in almost all cases when it comes to video
decode/encode accelerators.

Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
---
 Documentation/devicetree/bindings/media/amlogic,vdec.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/amlogic,vdec.txt b/Documentation/devicetree/bindings/media/amlogic,vdec.txt
index aabdd01bcf32..9b6aace86ca7 100644
--- a/Documentation/devicetree/bindings/media/amlogic,vdec.txt
+++ b/Documentation/devicetree/bindings/media/amlogic,vdec.txt
@@ -26,6 +26,7 @@ Required properties:
 	- GXBB (S905) : "amlogic,gxbb-vdec"
 	- GXL (S905X, S905D) : "amlogic,gxl-vdec"
 	- GXM (S912) : "amlogic,gxm-vdec"
+	followed by the common "amlogic,gx-vdec"
 - reg: base address and size of he following memory-mapped regions :
 	- dos
 	- esparser
@@ -47,8 +48,8 @@ Required properties:
 
 Example:
 
-vdec: video-decoder@c8820000 {
-	compatible = "amlogic,gxbb-vdec";
+vdec: video-codec@c8820000 {
+	compatible = "amlogic,gxbb-vdec", "amlogic,gx-vdec";
 	reg = <0x0 0xc8820000 0x0 0x10000>,
 	      <0x0 0xc110a580 0x0 0xe4>;
 	reg-names = "dos", "esparser";
-- 
2.22.0

