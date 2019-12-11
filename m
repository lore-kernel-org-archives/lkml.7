Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87905C00454
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 20:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B5602173E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 20:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7yOoaL4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbfLKUcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 15:32:23 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:45791 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbfLKUcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 15:32:00 -0500
Received: by mail-pj1-f66.google.com with SMTP id r11so24632pjp.12;
        Wed, 11 Dec 2019 12:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/SGLTAdZJn5EJy2JzHgzjK5/AJ+qkCVgDvB3ahQxnHQ=;
        b=b7yOoaL4G/ALvz/vNUlr2OeqNIasR8tlfumfduHUCFAHMOnxwtwF3SoUwldWsEaQ4R
         LvW812GkycQioVyIoAeViSehBhLN1Q1fYMklkMS1CLAqfAfhQa7oJFT7DMvMrZaKAb7j
         NmDSJEeyjRRMw6m2gmWMK31DqM0KmM1u85/KojBSQKtdXCVhFcQZgfC3jqKuJ9EC8KLf
         eG1TR6a96w3YAz3FtgejTRo7Cs4j71tlDnUpbI3criKCOOGkRDoPZfN/+hysMy4D7IAw
         CMLHltGp9hLhs0O75keqJ074R+i9CYm6esB68cymsYt+Q3mKtu4NS5r/EJ7VPoC6ETh0
         o+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/SGLTAdZJn5EJy2JzHgzjK5/AJ+qkCVgDvB3ahQxnHQ=;
        b=XrV+3/Vjv1pkCrXwkh7VBg+albzzbjnqI07I7IjDCW55euM8UceZz+CuYtItB7+cG2
         vPlaNjxZqHfF04DR24FOAKsumcFHef1vZtqk/UuevC5u5mXkXG6gZU7GXdXZ/6wEMQZP
         4zNpCV+/mYJq4NNNqGaAtGfpHIUvkDq87Wg3rXA1ZpGSvBUVUSksv6tc1d3NBCm+v3GF
         Y52LPgtYGPJhDDMvHvp6YjAD/FvCNFKyJA1RWZTT9Wk2W342WS22x8ITHZ2aqnIX4S9z
         kDG31OlU0t0LX16uibTJYkqzgKhkxbbGbq5Vs9koqSepCoIaETq1YpPPZuy/HfPBIZGt
         7Tfw==
X-Gm-Message-State: APjAAAUdPsOvitz4tJnF654uN9BRwEgDT8175wjEizA7GOxaRMM5NYC/
        y/T1Ipltx+njiVNv1baGXOg=
X-Google-Smtp-Source: APXvYqx/G7SPF+0fLJkFR2jINi/QVILifYW6VvhXLrfs0TC+JDl93K7sIkMmJpc9bSFgNrKj/zRX8g==
X-Received: by 2002:a17:90a:7bc3:: with SMTP id d3mr5804634pjl.86.1576096319788;
        Wed, 11 Dec 2019 12:31:59 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a19sm917570pju.11.2019.12.11.12.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 12:31:59 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org, daniel.lezcano@linaro.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Markus Mayer <mmayer@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM STB AVS TMON
        DRIVER), Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-pm@vger.kernel.org (open list:BROADCOM STB AVS TMON DRIVER),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 3/6] dt-bindings: thermal: Define BCM7216 thermal sensor compatible
Date:   Wed, 11 Dec 2019 12:31:40 -0800
Message-Id: <20191211203143.2952-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191211203143.2952-1-f.fainelli@gmail.com>
References: <20191211203143.2952-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BCM7216 is a 16nm process STB chip, which requires a different
compatible string to differentiate different temperature formulas.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../devicetree/bindings/thermal/brcm,avs-tmon.txt         | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/brcm,avs-tmon.txt b/Documentation/devicetree/bindings/thermal/brcm,avs-tmon.txt
index 43a9ed545944..74a9ef09db8b 100644
--- a/Documentation/devicetree/bindings/thermal/brcm,avs-tmon.txt
+++ b/Documentation/devicetree/bindings/thermal/brcm,avs-tmon.txt
@@ -3,9 +3,13 @@
 Thermal management core, provided by the AVS TMON hardware block.
 
 Required properties:
-- compatible: must be "brcm,avs-tmon" and/or "brcm,avs-tmon-bcm7445"
+- compatible: must be one of:
+	"brcm,avs-tmon-bcm7216"
+	"brcm,avs-tmon-bcm7445"
+	"brcm,avs-tmon"
 - reg: address range for the AVS TMON registers
-- interrupts: temperature monitor interrupt, for high/low threshold triggers
+- interrupts: temperature monitor interrupt, for high/low threshold triggers,
+	      required except for "brcm,avs-tmon-bcm7216"
 - interrupt-names: should be "tmon"
 
 Example:
-- 
2.17.1

