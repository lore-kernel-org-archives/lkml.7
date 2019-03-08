Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4827DC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 01:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 124D82085A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 01:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rbwFRKdT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfCHBB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 20:01:56 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:42701 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbfCHBB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 20:01:56 -0500
Received: by mail-yw1-f68.google.com with SMTP id v201so15008405ywa.9;
        Thu, 07 Mar 2019 17:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=roTGUc/iUtoD/bRzohE1XMQPLiQpUuAxtKFRFE3P4sU=;
        b=rbwFRKdTTXwIKp+ZSdSphtLhRNfPQDyEayw9qlp1GAtpBTScZAd6e99OrcRpmHe86M
         bwjjyfwZFbkTyXXyRLBG7RQ5FOIzt5nZZMHm2XGFWCjcLuctfCeDGUyY+/uA48t/c4P9
         XQeqDd9kpDATf3Rf5fl3XB5KQqAjoDHed/9CL4mx9j+X9/8llywEeHQd7g9gE92H8gqb
         0e+x1+yCrUT/b/aWpnGCeHvAcMsK9r+G5dwrnmTQp/1GtWIarUpkAZt+7C42zcmZsz3g
         FT5z4AQacqzxYJtEq9LRP0EDQkbshiyS5Cb3iJ8D29hegg+XuOZ3YNV9L5gdz/Gi+Y9/
         wMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=roTGUc/iUtoD/bRzohE1XMQPLiQpUuAxtKFRFE3P4sU=;
        b=taOfEXKEqbBjFIHGNLwkTjbSWKz+xelaPFHnpYKqpCJEHbLRF7zxdh6HPT7yte+Q4P
         iW5itPNOlQa2nn1LwT1QpaoI4rdWqF/L9guPfPh0KmtT+98K+XS+dJ8Ppbu3QPQiKHsA
         vkzhaCFo7NjAjwnlusRbK2eJToE4/6qsH/VidtvfoGe9YnAUCEyKg7X08/eHB69q7jx1
         CQDtJ8KIKLKo7XqR4sNmau4InVS9IxwuUBVDqFRM5SIDGko5gz1+1YHFxVd1gXf6k5Cr
         zVRz1AUdgrnQFd6RQlwSzCw9mOYbSAC8DNcS+zphMdYhvRDGkjg4iwlQ3NsEil7peC8P
         VcRA==
X-Gm-Message-State: APjAAAVfYVG3cYBunC65urKFBy/IkGhEySLAZTAmoYH6u9DylfSnfTZM
        aRCZT01NKIKvWRrC3uoXqBY=
X-Google-Smtp-Source: APXvYqyK6SQypWiySbcgzkfJtP3nG2bdYnaBrZYnqmsOSqA+m1YZ2hs8XYRi0afBEfIx7LRaouU2Xw==
X-Received: by 2002:a5b:60f:: with SMTP id d15mr13944910ybq.183.1552006915140;
        Thu, 07 Mar 2019 17:01:55 -0800 (PST)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id v124sm2237176ywc.49.2019.03.07.17.01.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 17:01:54 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Adam Ford <aford173@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: imx6qdl: Enable fsl,sec-v4.0-pwrkey
Date:   Thu,  7 Mar 2019 19:01:48 -0600
Message-Id: <20190308010148.9000-1-aford173@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The imx6q Technical reference manual shows the interrupt is
available to wake from sleep using the power button. The driver
has been available for quite some time, and other variants of the
i.MX6 have it enabled, so this implements it much like the others.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index fe17a3405edc..6b3e48d2e5ec 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -4,6 +4,7 @@
 // Copyright 2011 Linaro Ltd.
 
 #include <dt-bindings/clock/imx6qdl-clock.h>
+#include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
 / {
@@ -833,6 +834,14 @@
 					status = "disabled";
 				};
 
+				snvs_pwrkey: snvs-powerkey {
+					compatible = "fsl,sec-v4.0-pwrkey";
+					regmap = <&snvs>;
+					interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+					linux,keycode = <KEY_POWER>;
+					wakeup-source;
+				};
+
 				snvs_lpgpr: snvs-lpgpr {
 					compatible = "fsl,imx6q-snvs-lpgpr";
 				};
-- 
2.17.1

