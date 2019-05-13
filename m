Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB44FC04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 03:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC79208CB
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 03:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4CoZCzw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfEMD7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 23:59:24 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41752 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbfEMD7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 23:59:24 -0400
Received: by mail-pg1-f195.google.com with SMTP id z3so6038869pgp.8
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 20:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T/UMdXUy+/44jsihjFncGu0LlYxKfRmwGK/u/aG6gy8=;
        b=D4CoZCzw46wJhjAybuMT63XKBWH3byPbtxhQmXYVCReu7aSxN7P2einVcm1kJLa5Gi
         fMXdsGNhHAY2vESdnGgRukqHkjw4fDD/kXtfS/SZ1VO3ZC4XZfOB/t1Zp2UGUrpFiGPO
         NM2B4rgJDiic0UrR0q/52DlZPLmLrwoqjcOPJYZtrdBLspbL24oqk6Rg3LHzYktRtJY8
         mbZ/5lIJJ6Npp3MeFIcpzM/DjZUEam94oE4DFlJRMtJ6df+O2uqXHo27SvWMJGtjCrVy
         Apf2Jbe9IdhJO49mRrQTKlHL59f8nV1QchHQPo8nGPRkzkmyCvPGdEQGUZUXDE23X2gK
         KcsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T/UMdXUy+/44jsihjFncGu0LlYxKfRmwGK/u/aG6gy8=;
        b=KRT86+XE5qIhAHgy+aQ5o0+kDKJZoRqVWaRk+LSSyihCGITiuL259y9v2Fmr3pg/Xo
         xywJLDjp1oT+O4grObZ5w1/5nF1fv1zbcS7kEYGe3xr9+Mz/ZYglG/+Z78t2mGt4aWRP
         CemgrMya/DlasTwYZO0jJAEj5UbTFViF2u4bmtwXcwqWbmKmBuaccWfiRgZRC6IzyJ7Q
         MQFluS1DY5LAC5zgZV90W29k+R2/g8SWPG63ZUkyHoNFDoArjySd1y+JzSSGQlNcDb+4
         wubYLgViXJCtdALZqwT+zb2g5oN8/Il1EsH0Luqp3QSdAr/7yuD2X7+p+xMYi4AzRy8l
         DLVA==
X-Gm-Message-State: APjAAAUihKIUp3X6YUBvId7nXa2oud2jxQqAMa/xodF2MLhvRV8KcbLx
        LD4K8v8MPOMBzqDfEu09vDM=
X-Google-Smtp-Source: APXvYqyTijGyvIuRdI382Hw/nI2S9C2DPKA1QDQ+pl8IgiEEBjnhjYIvo7+z9vdBC8w9CHbxtDO49g==
X-Received: by 2002:a63:f703:: with SMTP id x3mr27941129pgh.394.1557719962682;
        Sun, 12 May 2019 20:59:22 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id i17sm16042496pfo.103.2019.05.12.20.59.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 12 May 2019 20:59:21 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: dts: vf610-zii-dev: Fix incorrect UART2 pin assignment
Date:   Sun, 12 May 2019 20:59:08 -0700
Message-Id: <20190513035909.30460-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UART2 is connected to PTD22/23, not PTD0/1. Fix corresponding pinmux
node.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm/boot/dts/vf610-zii-dev.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/vf610-zii-dev.dtsi b/arch/arm/boot/dts/vf610-zii-dev.dtsi
index 2d1e9b3203fa..5246c75e848c 100644
--- a/arch/arm/boot/dts/vf610-zii-dev.dtsi
+++ b/arch/arm/boot/dts/vf610-zii-dev.dtsi
@@ -385,8 +385,8 @@
 
 	pinctrl_uart2: uart2grp {
 		fsl,pins = <
-			VF610_PAD_PTD0__UART2_TX	0x21a2
-			VF610_PAD_PTD1__UART2_RX	0x21a1
+			VF610_PAD_PTD23__UART2_TX	0x21a2
+			VF610_PAD_PTD22__UART2_RX	0x21a1
 		>;
 	};
 
-- 
2.21.0

