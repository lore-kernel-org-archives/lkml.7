Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD2FC47404
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 06:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3D20207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 06:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="VQifTFmz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730063AbfJNGUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 02:20:23 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40426 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfJNGUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 02:20:23 -0400
Received: by mail-pf1-f194.google.com with SMTP id x127so9774681pfb.7
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 23:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zfkaFfsELHYHWazH2W/EZlylQJT2a0eVw5F7g45yZLc=;
        b=VQifTFmzWfwVhZ1UYF0CKr2jgsmqRpjgrgy+Jbl9toi7OZjq2UAPfh0YDiZ4VNIgwf
         lgPVQy4T1pUx/7ZC3zfsjRfaIcHVlR4mA96RUOZQeNRENiO1u5araIYkX4m8NFtjzD67
         TqYgWMVJlwqshJcX6geQnrRMTWzYXUOzZAA+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zfkaFfsELHYHWazH2W/EZlylQJT2a0eVw5F7g45yZLc=;
        b=bTjlHXKrrVeabYIvtdr645uXwAZhBJWGA2PfJKR8gvR8Q9ho7FqK8+1OXjdY+8AiBW
         8Hsm6S6LtHtpCw0Rq8xuP3mH52wH9fVB7NUMuYgRgCIyVrqBOddh5GkBPEA04GxcE0Xr
         Snn9EczRZKKwp18VlJt4b6WCCfWTMMEQ7q117I5asYXo2Tv8FT/HLH0zHN1gs4tespEQ
         8nSfmcZo4NpKNd3PSZmbTSP341TQoyI25a1/d6bL+FuOw6qfmYMT2XlrSxfBM1T0mFpp
         /pUqqHCLnXOe/RjpSqIXwOw6BeSRXZeIVtAFd84PkjacNSruVUuCU4kW2KtgnChEAjJX
         sdwQ==
X-Gm-Message-State: APjAAAWpY/8XpsFpRvjuv6C4K8JPFL0FoOnd/gY9EPVVIWngr2WSfAKx
        DPfRLODLjT9MQvoNCOKw8FyaJQ==
X-Google-Smtp-Source: APXvYqxiggqtc902VST7+e+YJRtDh0InN6+UnzEANAMPlTV0kjrs+Dlo8+XH1gzXkPWfV4eAhlYNUQ==
X-Received: by 2002:a62:5305:: with SMTP id h5mr31867612pfb.121.1571034022320;
        Sun, 13 Oct 2019 23:20:22 -0700 (PDT)
Received: from shiro.work (p1092222-ipngn200709sizuokaden.shizuoka.ocn.ne.jp. [220.106.235.222])
        by smtp.googlemail.com with ESMTPSA id g24sm16874074pfi.81.2019.10.13.23.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2019 23:20:21 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
Cc:     daniel@0x0f.com, Daniel Palmer <daniel@thingy.jp>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Burton <paul.burton@mips.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Doug Anderson <armlinux@m.disordat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Stefan Agner <stefan@agner.ch>,
        Nicolas Pitre <nico@fluxnic.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Sugaya Taichi <sugaya.taichi@socionext.com>,
        Nathan Huckleberry <nhuck15@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] dt-bindings: arm: Initial MStar vendor prefixes and compatible strings
Date:   Mon, 14 Oct 2019 15:15:56 +0900
Message-Id: <20191014061617.10296-1-daniel@0x0f.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a prefix for MStar and thingy.jp and then defines compatible
strings for the first MStar based board.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 .../devicetree/bindings/arm/mstar.yaml        | 22 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  4 ++++
 MAINTAINERS                                   |  6 +++++
 3 files changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/mstar.yaml

diff --git a/Documentation/devicetree/bindings/arm/mstar.yaml b/Documentation/devicetree/bindings/arm/mstar.yaml
new file mode 100644
index 000000000000..0ea5b2b9387f
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mstar.yaml
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: (GPL-2.0+ OR X11)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/mstar.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MStar platforms device tree bindings
+
+maintainers:
+  - Daniel Palmer <daniel@thingy.jp>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+
+      - description: thingy.jp BreadBee
+        items:
+          - const: thingyjp,breadbee
+          - const: mstar,infinity
+          - const: mstar,infinity3
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 967e78c5ec0a..1425468188da 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -617,6 +617,8 @@ patternProperties:
     description: Microsemi Corporation
   "^msi,.*":
     description: Micro-Star International Co. Ltd.
+  "^mstar,.*":
+    description: MStar Semiconductor, Inc.
   "^mti,.*":
     description: Imagination Technologies Ltd. (formerly MIPS Technologies Inc.)
   "^multi-inno,.*":
@@ -943,6 +945,8 @@ patternProperties:
     description: Three Five Corp
   "^thine,.*":
     description: THine Electronics, Inc.
+  "^thingyjp,.*":
+    description: thingy.jp
   "^ti,.*":
     description: Texas Instruments
   "^tianma,.*":
diff --git a/MAINTAINERS b/MAINTAINERS
index a69e6db80c79..8b7913c13f9a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1981,6 +1981,12 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 F:	arch/arm/mach-pxa/mioa701.c
 S:	Maintained
 
+ARM/MStar SoC support
+M:	Daniel Palmer <daniel@thingy.jp>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+F:	Documentation/devicetree/bindings/arm/mstar.yaml
+S:	Maintained
+
 ARM/NEC MOBILEPRO 900/c MACHINE SUPPORT
 M:	Michael Petchkovsky <mkpetch@internode.on.net>
 S:	Maintained
-- 
2.23.0

