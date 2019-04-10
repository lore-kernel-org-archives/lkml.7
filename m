Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F025C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 23:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F15AB20820
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 23:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qaDn8zJe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfDJXQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 19:16:12 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42320 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfDJXPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 19:15:33 -0400
Received: by mail-wr1-f66.google.com with SMTP id g3so4807519wrx.9;
        Wed, 10 Apr 2019 16:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0qACYbWibCn2NYEQtyoZ/KKRf3EQ91V9nFYFBIMWmRE=;
        b=qaDn8zJeQZMtdJyivrryOFs3/Rh4tV5pTEHX2ACinGABPsL94hSck0mlvN5XXUdLVO
         2QshiSkH+/F8/C2sVTH2iSq29/ulGT5/Hr0tOMQBcUDzY7DHfqDJ/bxn096IQqaza05w
         xG1ce7D8k67kQA0ddLVhuDerJg9hgksF3+OE0M5Ix62EcHMYic0pZna2iysaAEGS8J7U
         FtBtOb1lvYaEry1Xj0tAqL+RvBPvcm6qvIzeJzFN7f7OKnQFxlD7mcTaM5DLDwjFhZM+
         3YR6jgEC1ry9ZNBgOrn2in5pIa9/Rsfi50i0Ym0C/FVts+Nm24Zwfe+GZpN3GrEZ3A5Y
         lqtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0qACYbWibCn2NYEQtyoZ/KKRf3EQ91V9nFYFBIMWmRE=;
        b=qgI4UWxFeGSUoXuTA/Ian1YKwAR7nlVPFuIydiiZUpKOUpB52sQNDAi6/TUPFCH7aU
         Ud0c3DRneRqD2unkRZSZjM/+K5yy42BL85d7xlBG3zRdmCRNKS/WLugzSPq2LOttX3bt
         9RxvsZaW9vgfZs5JZFSrf1i036PC17S7FZ/+/cAPzvsQxPJ60OSiGlvsnFeodLhcVAgD
         qpO5w/pim9DTkf96KlrcCswG2QeraiGltRiK9Kwr+nKaY1gtqOfWMPQVIcbLcbMkvhB6
         +AHeBFV48+p6SbTYj3SUiduLpvREyMmJAmo00BVfckpL2/eZL7K465fkM4btivWu7pb8
         UJrw==
X-Gm-Message-State: APjAAAViBXFPd+4bBgqTcmwFN94lGBw4Cgzk4B9D/A0SXqVNDsDQ4PUZ
        2r49+dsgkO4VL27GvxFSNRc=
X-Google-Smtp-Source: APXvYqyBZJPAanBgPDdnRGF5zfKp/yROBhDxSLVw7mZSsuMmbwIMSl2mOOMQa9n0FC87k3dd1GJHVQ==
X-Received: by 2002:a5d:530e:: with SMTP id e14mr26166582wrv.18.1554938131542;
        Wed, 10 Apr 2019 16:15:31 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::df7e:4a05])
        by smtp.gmail.com with ESMTPSA id n6sm8504947wmn.48.2019.04.10.16.15.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 16:15:30 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH 2/8] dt-bindings: gpu: add bus clock for Mali Midgard GPUs
Date:   Thu, 11 Apr 2019 01:25:37 +0200
Message-Id: <20190410232543.13297-3-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190410232543.13297-1-peron.clem@gmail.com>
References: <20190410232543.13297-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some SoCs adds a bus clock gate to the Mali Midgard GPU.

Add the binding for the bus clock.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
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

