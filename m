Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADEFFC6194
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 05:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DBE4214DB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 05:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQV4QErw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729989AbfKHFUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 00:20:45 -0500
Received: from mail-pl1-f180.google.com ([209.85.214.180]:45971 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfKHFUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 00:20:44 -0500
Received: by mail-pl1-f180.google.com with SMTP id y24so3253288plr.12;
        Thu, 07 Nov 2019 21:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iGEIDbYmVZa9xwEGk6m/vD8N0Ug2Lhly+4TWkAdqLek=;
        b=DQV4QErwJZi1nk+I+ExV4GgrAt+hvlcVydeGwaA7/epaVfYBs5u+HOBas9IumvCH3N
         JxSoAVsemwQmhL9lwpjUyMccGjyCWAW8DMxKTol2RUQoNpM2zOk91ztHOozH88yCXnyS
         nQiyemAGRfY5zntLTi69NaA4DiECMQuM9cq9WdGTiSpag2j2HasNUGlKW0w9R5revTGH
         wvMIlyXkvzCyDczcv3X6NokPLYkJj8lxtymgsnm77GRivHxrwy3Wi2/uWPUWCQ7ka4u6
         P+8I074TJg0IbfKtoUmk7RQLoOBZytBQn4RkJywcfMiFBonHKqy1FHK7keHZCkf2uKMz
         SZTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=iGEIDbYmVZa9xwEGk6m/vD8N0Ug2Lhly+4TWkAdqLek=;
        b=ekji1qR0um3DPy+zsbaiLTqRLRFnKDvshyv92shtghVDbh0KL/tX/9x5Xnloe2/JtU
         oXAzpV7rhFWf6tNRPLqz7Z+2hqHMVYl1QrnlpHDNq5fcdXVBjtTy9I4XN0FVer+3PC9k
         LHcVBjw2PFOZbpLdDBSSI5VRfWRH45zQdGLr/WNIFOpkEWY9FLFRPegsTWP9LxMkDfyi
         kF2cI460mS2Emws/b2MQ6icmxrJXK4Q3qp40qmBIgZGRW+AIVA/HzrKChxRsYlwnKpOv
         LlOZz0ObCE57bY26xDFjRJm8zD/eiXFmikBqC91q2+5PCPOyEMVZIWRAVPHAZb/5bkJq
         SgyQ==
X-Gm-Message-State: APjAAAUQlaUW3HuCXWRnmzv1b6gN+OOYeCj6reox0nSDxcvl3CxWR+x/
        wfx0kWdufTB6rSbaoCqBdKA=
X-Google-Smtp-Source: APXvYqyJmTdzvKroBystEahMC17uFRguxhlGPq7x/hTDNn3eP4EFiK4iTnSCiGGTzjO5MGvvFRMNEg==
X-Received: by 2002:a17:902:ba91:: with SMTP id k17mr8454858pls.100.1573190443329;
        Thu, 07 Nov 2019 21:20:43 -0800 (PST)
Received: from voyager.ibm.com ([36.255.48.244])
        by smtp.gmail.com with ESMTPSA id v19sm3798443pjr.14.2019.11.07.21.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 21:20:42 -0800 (PST)
From:   Joel Stanley <joel@jms.id.au>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jeremy Kerr <jk@ozlabs.org>
Cc:     Alistar Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsi@lists.ozlabs.org
Subject: [PATCH v2 08/11] dt-bindings: fsi: Add description of FSI master
Date:   Fri,  8 Nov 2019 15:49:42 +1030
Message-Id: <20191108051945.7109-9-joel@jms.id.au>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20191108051945.7109-1-joel@jms.id.au>
References: <20191108051945.7109-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This describes the FSI master present in the AST2600.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 .../bindings/fsi/fsi-master-aspeed.txt        | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fsi/fsi-master-aspeed.txt

diff --git a/Documentation/devicetree/bindings/fsi/fsi-master-aspeed.txt b/Documentation/devicetree/bindings/fsi/fsi-master-aspeed.txt
new file mode 100644
index 000000000000..b758f91914f7
--- /dev/null
+++ b/Documentation/devicetree/bindings/fsi/fsi-master-aspeed.txt
@@ -0,0 +1,24 @@
+Device-tree bindings for AST2600 FSI master
+-------------------------------------------
+
+The AST2600 contains two identical FSI masters. They share a clock and have a
+separate interrupt line and output pins.
+
+Required properties:
+ - compatible: "aspeed,ast2600-fsi-master"
+ - reg: base address and length
+ - clocks: phandle and clock number
+ - interrupts: platform dependent interrupt description
+ - pinctrl-0: phandle to pinctrl node
+ - pinctrl-names: pinctrl state
+
+Examples:
+
+    fsi-master {
+        compatible = "aspeed,ast2600-fsi-master", "fsi-master";
+        reg = <0x1e79b000 0x94>;
+	interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fsi1_default>;
+	clocks = <&syscon ASPEED_CLK_GATE_FSICLK>;
+    };
-- 
2.24.0.rc1

