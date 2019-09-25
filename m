Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8555AC432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 18:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 547B521655
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 18:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ne1IyYex"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443244AbfIYSm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 14:42:57 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33824 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439865AbfIYSmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 14:42:55 -0400
Received: by mail-io1-f67.google.com with SMTP id q1so1531751ion.1;
        Wed, 25 Sep 2019 11:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Nfx7JTVu0PRWrPasNmIdEHuXDgbsCjZv1S3XWQFYKYg=;
        b=Ne1IyYexGmWAl3Gmd6YygaFJ+CaOKP/8+69myulVINwwdcCJmpXrSiqxVSvcGnVipp
         8597xWEGPKa+zJsDNcrkMnaTDzaPLbKFHI2P4GTQcd3mQg2kHI1kfJ6hx7w13iI4MJEX
         y7JN6wCC7yW7DUksLkOc8lTnL7d3fnwa5lKQlIM0NoL6wqGFQntcjW7vebHkDGuO2scA
         QlJfBI6ABPucYHGzd+a/1qsfsFXNZdVWMp99RBkx/Q1VrPyOumAPN/uG7CG4EvseBlZX
         1lNkYO2e+gaRXWIla01vlV2Oe1vE6pjnfOYPsw4x77JICtQkoADXLXVcwnFqLMrrfpy2
         QBog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Nfx7JTVu0PRWrPasNmIdEHuXDgbsCjZv1S3XWQFYKYg=;
        b=DhDVqTLnvd0Gynsk1WjgvL5n237YijE4U3SvSwEUDugyj737eJQGNO+/w5dgEm/Wqu
         d5V5BuhsLc9p+wcLuajB1x93oVewUgevha4MUimqU5Vpi58K3wJ2j/hUdx1qD1yP+nus
         6AhVRDKoBBgnDT+O4GXHCHMe7dr3rNWxf2ydGoeMZbyomMx31d4QF+4HQm3wUky6jfTh
         lP6nQd6mjIo9rblSg3zTfzjW/8XDgH8uCc6inrD3eNx+R+Tcq6C5JiCytIBlB7u5qC5J
         e6uD7gE8BZlPLXxAAzeRetJGCJrpiKvIOpzWbtl1+fXj1EugAOsJ12Cz/gpLEmI3BOAj
         qHmA==
X-Gm-Message-State: APjAAAWc5BadnPoO6XS47d67pTbqnss0y4BFkQSl69VGADfytEJBYiB7
        Mw5a9XCp5ksuUeJ46hX2caY=
X-Google-Smtp-Source: APXvYqw8uBxXc+QlppeT9+fI+zXI803fXFhEr3c58w/+SY0fM0bf5aP9ub5Nm77ENx5/dzszjPUriQ==
X-Received: by 2002:a05:6602:c9:: with SMTP id z9mr929490ioe.28.1569436974866;
        Wed, 25 Sep 2019 11:42:54 -0700 (PDT)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id q17sm337511ile.5.2019.09.25.11.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 11:42:54 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     adam.ford@logicpd.com, Adam Ford <aford173@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 3/3] ARM: logicpd-torpedo-37xx-devkit-28: Reference new DRM panel
Date:   Wed, 25 Sep 2019 13:42:38 -0500
Message-Id: <20190925184239.22330-3-aford173@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190925184239.22330-1-aford173@gmail.com>
References: <20190925184239.22330-1-aford173@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the removal of the panel-dpi from the omap drivers, the
LCD no longer works.  This patch points the device tree to
a newly created panel named "logicpd,type28"

Fixes: 8bf4b1621178 ("drm/omap: Remove panel-dpi driver")

Signed-off-by: Adam Ford <aford173@gmail.com>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
---
V3:  No change
V2:  Remove legacy 'label' from binding

diff --git a/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit-28.dts b/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit-28.dts
index 07ac99b9cda6..cdb89b3e2a9b 100644
--- a/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit-28.dts
+++ b/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit-28.dts
@@ -11,22 +11,6 @@
 #include "logicpd-torpedo-37xx-devkit.dts"
 
 &lcd0 {
-
-	label = "28";
-
-	panel-timing {
-		clock-frequency = <9000000>;
-		hactive = <480>;
-		vactive = <272>;
-		hfront-porch = <3>;
-		hback-porch = <2>;
-		hsync-len = <42>;
-		vback-porch = <3>;
-		vfront-porch = <2>;
-		vsync-len = <11>;
-		hsync-active = <1>;
-		vsync-active = <1>;
-		de-active = <1>;
-		pixelclk-active = <0>;
-	};
+	/* To make it work, set CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK=4 */
+	compatible = "logicpd,type28";
 };
-- 
2.17.1

