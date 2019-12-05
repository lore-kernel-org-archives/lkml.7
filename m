Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2803BC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 02:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F00A521835
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 02:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7lbrt5L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbfLECTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 21:19:55 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:46896 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728829AbfLECTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 21:19:50 -0500
Received: by mail-yb1-f194.google.com with SMTP id v15so850616ybp.13;
        Wed, 04 Dec 2019 18:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oWN4pUn9h8kmkDUvNkkmAbykuZ7BWRxuHrNipagh7j4=;
        b=E7lbrt5LKKXPAltqBhYh1f/OR+N2z7JaAe5xBm+yMPOQ0AW79g2OoajbfGorwR8j+w
         4+culxp+iCxTHyaHTrl0mPe72262t9aHSUdmIWbVQAyflEicAHLSc/KnkJ1uuO27G5sY
         /doMboiyQ2kccwqntyH12UTgFARKPBfi2XPzQ1NuAsECaYij/cDgGwPdpSI3wCosoWJL
         vAmOCf60G4fkyjk/b2fzFKHjQ+qQoocKkP23sTLSrVh5nJ4aA/2/qZ8IpVt/pjke3F+5
         6djv+vG+ymwh+0g0cYBcriE9AK5gpdzNaBEZU6Tp2RUHumtuirmrG6xlMxEeQkVQtNxs
         NHhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oWN4pUn9h8kmkDUvNkkmAbykuZ7BWRxuHrNipagh7j4=;
        b=RrDNb09Hx0Sis2qjRpXlgvpOy5IRr+9SvDSUPf+xOq1svrSumtpg8dtDvjfw6Ai88W
         JlVmnoQtlPZ84LFsgwVjoqWfHsuw7f8ersIXULXIXRazkoRhKBiBCdHUNiQFjjs+FSq1
         pcdTHFwPfW9RIrCvP2iDZF+UMxpkpQ/zxZ+taQdj/mR2zNZabQuyWOkt9HboTXLUjcJ8
         FioXYN2/9UsJXslyJOyckcCEL2T7sqBqoNcRi+szTeutxrXNWEQ8uzQho/O2SGjEq2cg
         Z18BG7eHwGuGQm2Bu9ym1VvU9i0LIU4VuE5vIoZlGy1h6WtoLkmcV8/knlr+NrDFbBKf
         q5fA==
X-Gm-Message-State: APjAAAWR/9qqmD0iLSEk8UUtFX4VFirlfJa/xPzwwtETc3L87yrEHKmX
        xKURQ8O0o94qaOb8F59cSoA=
X-Google-Smtp-Source: APXvYqwa9Nm6yYJ/6HOp8YPmf+4cLZwckeWQu0Kb3li5ZZGizpS8hlXIBirWYlS4HI7DdEYEOXg4bw==
X-Received: by 2002:a25:4144:: with SMTP id o65mr4812334yba.11.1575512388942;
        Wed, 04 Dec 2019 18:19:48 -0800 (PST)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id l6sm4188449ywa.39.2019.12.04.18.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 18:19:48 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Adam Ford <aford173@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] dt-bindings: imx-gpcv2: Update bindings to support i.MX8M Mini
Date:   Wed,  4 Dec 2019 20:19:20 -0600
Message-Id: <20191205021924.25188-5-aford173@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191205021924.25188-1-aford173@gmail.com>
References: <20191205021924.25188-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The with the recent additions to the driver, the GPCv2 driver can
support the i.MX8M Mini, but it needs updated 'compatible' entry
to use the proper table.

This patch adds the i.MX8MM to the compatible list of devices.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 Documentation/devicetree/bindings/power/fsl,imx-gpcv2.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.txt b/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.txt
index 7c7e972aaa42..576a79097a4c 100644
--- a/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.txt
+++ b/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.txt
@@ -9,6 +9,7 @@ Required properties:
 - compatible: Should be one of:
 	- "fsl,imx7d-gpc"
 	- "fsl,imx8mq-gpc"
+	- "fsl,imx8mm-gpc"
 
 - reg: should be register base and length as documented in the
   datasheet
@@ -24,8 +25,9 @@ which, in turn, is expected to contain the following:
 Required properties:
 
 - reg: Power domain index. Valid values are defined in
-  include/dt-bindings/power/imx7-power.h for fsl,imx7d-gpc and
-  include/dt-bindings/power/imx8m-power.h for fsl,imx8mq-gpc
+  include/dt-bindings/power/imx7-power.h for fsl,imx7d-gpc,
+  include/dt-bindings/power/imx8m-power.h for fsl,imx8mq-gpc, and
+  include/dt-bindings/power/imx8m-power.h for fsl,imx8mm-gpc
 
 - #power-domain-cells: Should be 0
 
-- 
2.20.1

