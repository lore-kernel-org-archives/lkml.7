Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7FEC28CC3
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 18:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A804526DF3
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 18:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="NkRCoolV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbfEaSau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 14:30:50 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33025 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbfEaSar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 14:30:47 -0400
Received: by mail-pf1-f194.google.com with SMTP id x10so1584043pfi.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 11:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=VetgGylyMhr4faiTsP3IkOZ01cl3HVxVutPYPa26WFw=;
        b=NkRCoolVMOtHRNeRX+tRMJAJfNezctylvJyewwija9EhQnV5Qv+r5qnbdxLUAq/oh3
         /h/VhrQ0ZqTZuR46enNVDaidkW13Dr+bo57VhH1ybMUAtpzPBJkunvGAuNRcKsV9x4Nd
         LGGQroOyo+oedq5OAihn50GZO1Qefg9Cmou0WGQEv8I2gyybL7y69zfDzqUGT7nRGiLi
         stw/rnbhOUajZlTipAyQt+Up8ii4ABXABDjkKz0UXNQyRcSAeMLP798IEyl98nlOFiAJ
         a5slXMoeOvW4eX1/lPGWwotNruhQFAx7MvtrHnPnU2z8CNr4WWRBvFADW9rtRD/oPb7U
         v81g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=VetgGylyMhr4faiTsP3IkOZ01cl3HVxVutPYPa26WFw=;
        b=jFmLyJdvVUWh7IyDlnL9Qq7nz13Q8bHzUW7ED8xO+Vkc026+319i8Ij/3Ldr9tFfx8
         SXNPHmTeZ+lI4q7O+ciKj9A5n6QWfEvbR0NdTdZUXWUJb0MIVCzXenjughM1oNFAZ466
         p6mWMOcl/kWj9RkWCOG4mluEq148EaeiX0aElrfcpBGMVQcKBGQbGUQMcFbX46iRYm0A
         VzJ/q8KHXq9p/CoGowghbEC4DPFb/vZDi3QhYba3KHEuqvPMPOloVOVjO5KwWoL8QJEQ
         Z6hErDCAw+S+Bi/E7g3dlbdT0IQdSe0zHt244eZppMxCzkAWEJtflS9ApumdcgOIKw/O
         Rp2w==
X-Gm-Message-State: APjAAAUbvC25kto/3H5CfRp4RiGI+o/u/m/2kP+pnTnfiVSqCOd3YwJT
        YkixQupjXgMzhLTSRsOtHElWyA==
X-Google-Smtp-Source: APXvYqyGpaE3AScUpk1vPIbk/cFV7AA8MTtsbFaN4js/+qTjomIkLFrdTjiYlPE0gVCUs3hO07Rz6Q==
X-Received: by 2002:a65:450b:: with SMTP id n11mr10642993pgq.174.1559327446724;
        Fri, 31 May 2019 11:30:46 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id 85sm10039511pgb.52.2019.05.31.11.30.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 31 May 2019 11:30:46 -0700 (PDT)
From:   Sagar Shrikant Kadam <sagar.kadam@sifive.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, peter@korsgaard.com,
        andrew@lunn.ch, palmer@sifive.com, paul.walmsley@sifive.com,
        sagar.kadam@sifive.com, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH REPOST v8 1/3] dt-bindings: i2c: extend existing opencore bindings.
Date:   Sat,  1 Jun 2019 00:00:21 +0530
Message-Id: <1559327423-13001-2-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1559327423-13001-1-git-send-email-sagar.kadam@sifive.com>
References: <1559327423-13001-1-git-send-email-sagar.kadam@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reformatted compatibility strings to one valid combination on
each line.
Add FU540-C000 specific device tree bindings to already available
i2-ocores file. This device is available on
HiFive Unleashed Rev A00 board. Move interrupt under optional
property list as this can be optional.

The FU540-C000 SoC from sifive, has an Opencore's I2C block
reimplementation.

The DT compatibility string for this IP is present in HDL and available at.
https://github.com/sifive/sifive-blocks/blob/master/src/main/scala/devices/i2c/I2C.scala#L73

Signed-off-by: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
---
 Documentation/devicetree/bindings/i2c/i2c-ocores.txt | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-ocores.txt b/Documentation/devicetree/bindings/i2c/i2c-ocores.txt
index 17bef9a..6b25a80 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-ocores.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-ocores.txt
@@ -1,9 +1,13 @@
 Device tree configuration for i2c-ocores
 
 Required properties:
-- compatible      : "opencores,i2c-ocores" or "aeroflexgaisler,i2cmst"
+- compatible      : "opencores,i2c-ocores"
+                    "aeroflexgaisler,i2cmst"
+                    "sifive,fu540-c000-i2c", "sifive,i2c0"
+                    For Opencore based I2C IP block reimplemented in
+                    FU540-C000 SoC. Please refer to sifive-blocks-ip-versioning.txt
+                    for additional details.
 - reg             : bus address start and address range size of device
-- interrupts      : interrupt number
 - clocks          : handle to the controller clock; see the note below.
                     Mutually exclusive with opencores,ip-clock-frequency
 - opencores,ip-clock-frequency: frequency of the controller clock in Hz;
@@ -12,6 +16,7 @@ Required properties:
 - #size-cells     : should be <0>
 
 Optional properties:
+- interrupts      : interrupt number.
 - clock-frequency : frequency of bus clock in Hz; see the note below.
                     Defaults to 100 KHz when the property is not specified
 - reg-shift       : device register offsets are shifted by this value
-- 
1.9.1

