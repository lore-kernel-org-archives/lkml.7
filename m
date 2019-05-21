Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCA1C072B5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 21:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEE28217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 21:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558474138;
	bh=2jueTpAz+zhd3gwmmxoelsVYldfazjaD6CaLNhJMr0Y=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ud3u0y3RyS4tklIfzxGMT6g57cZXlL5gjp0Wdhph1sR2sQ0z6O9ZV2qCCZqdJvx24
	 FEShMKRqBulJmZb6ETjvMJXcBlBTxmgjcslV79WMJAAxb4CH19WNEG0jvLsFQ949HN
	 1bMrsmn2fzUCqUuCNQbVXaZWInixvHQ7HW0tk9KY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbfEUV25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 17:28:57 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:45071 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbfEUV25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 17:28:57 -0400
Received: by mail-ot1-f51.google.com with SMTP id t24so124361otl.12;
        Tue, 21 May 2019 14:28:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YVpYMWqaeHjf+WP1pc19ZZ2oqY67Z/jyFT9ovLtihjE=;
        b=jQwwEvwEiEDyBz07rAxfbIjsVjI2IF2otcEun0RMFiY79F2kO8FfElcPkK+A4Gs+4j
         ASksQTJhR0oM/yfzw34mnxOSbJwNazjBRLdWPgPn6XPJIiM9KDB6tg1mNHV7LdAOlaDb
         uy8mVbIDpPrufy9K4eYwREIshV7aKkr3tRm9Gx6Vl0LCPcvSdvTH4VBe8hh3R6JHlzNp
         mPZjT6R7WJhcurCNVLMBxzPLnnBRDnrdczNIy4FurDh/0818AcnmdUL3fjaWcoHkSKP1
         K0c+ecwTbA499ufNZlDEUFCR18bAgHNPerIuij2p9MY048LJ2Tv6j6PvZ7H5sIT3k8Ql
         L7TA==
X-Gm-Message-State: APjAAAXAxq9zy8D0o7DlTauLG58/nJScesDouVY9qOo6kpsruzeDcENY
        tt0ZQvfJyx4MJ1BpRUQnuA==
X-Google-Smtp-Source: APXvYqyxXFnhWCSFCuy1ryuUUJjgLIwzRd05/GvddjQoORKVTC2tePT5LJ0J0UzBzZIYXWdlo1rdwg==
X-Received: by 2002:a05:6830:118b:: with SMTP id u11mr36908284otq.280.1558474136523;
        Tue, 21 May 2019 14:28:56 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id k3sm3244631otf.42.2019.05.21.14.28.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 21 May 2019 14:28:55 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Subject: [PATCH] dt-bindings: interrupt-controller: arm,gic: Fix schema errors in example
Date:   Tue, 21 May 2019 16:28:54 -0500
Message-Id: <20190521212854.24902-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Validating the examples against the schema have a few errors:

arm,gic.example.dt.yaml: 'ranges' does not match any of the regexes: '^v2m@[0-9a-f]+$', 'pinctrl-[0-9]+'
arm,gic.example.dt.yaml: #address-cells:0:0: 2 is not one of [0, 1]
arm,gic.example.dt.yaml: #size-cells:0:0: 1 was expected

'ranges' is valid, but missing from the schema, so add it. The reg
addresses and sizes don't match the schema requirements and the example
template. We could just override the example template to use 64-bit
addresses, but there's not really any value showing that in the example.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../interrupt-controller/arm,gic.yaml         | 24 ++++++++++---------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic.yaml b/Documentation/devicetree/bindings/interrupt-controller/arm,gic.yaml
index 5011d9be2d57..3d2a58ac296b 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic.yaml
@@ -91,6 +91,8 @@ properties:
     minItems: 2
     maxItems: 4
 
+  ranges: true
+
   interrupts:
     description: Interrupt source of the parent interrupt controller on
       secondary GICs, or VGIC maintenance interrupt on primary GIC (see
@@ -196,28 +198,28 @@ examples:
     interrupt-controller@e1101000 {
       compatible = "arm,gic-400";
       #interrupt-cells = <3>;
-      #address-cells = <2>;
-      #size-cells = <2>;
+      #address-cells = <1>;
+      #size-cells = <1>;
       interrupt-controller;
       interrupts = <1 8 0xf04>;
-      ranges = <0 0 0 0xe1100000 0 0x100000>;
-      reg = <0x0 0xe1110000 0 0x01000>,
-            <0x0 0xe112f000 0 0x02000>,
-            <0x0 0xe1140000 0 0x10000>,
-            <0x0 0xe1160000 0 0x10000>;
+      ranges = <0 0xe1100000 0x100000>;
+      reg = <0xe1110000 0x01000>,
+            <0xe112f000 0x02000>,
+            <0xe1140000 0x10000>,
+            <0xe1160000 0x10000>;
 
-      v2m0: v2m@8000 {
+      v2m0: v2m@80000 {
         compatible = "arm,gic-v2m-frame";
         msi-controller;
-        reg = <0x0 0x80000 0 0x1000>;
+        reg = <0x80000 0x1000>;
       };
 
       //...
 
-      v2mN: v2m@9000 {
+      v2mN: v2m@90000 {
         compatible = "arm,gic-v2m-frame";
         msi-controller;
-        reg = <0x0 0x90000 0 0x1000>;
+        reg = <0x90000 0x1000>;
       };
     };
 ...
-- 
2.20.1

