Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9621AC76192
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 15:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71E502173E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 15:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9HjDAtO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbfGQPDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 11:03:05 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37907 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbfGQPDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 11:03:03 -0400
Received: by mail-pf1-f193.google.com with SMTP id y15so10977605pfn.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 08:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EOkS5kDhQCp2QpKFvcqRvsCtdLy33nkr3AyjAFEDqsc=;
        b=L9HjDAtOqAIwTm1Lr6ddDZgSgitwesUyPfW+GKyfk5rR9Cdwl2bZR7Cck92k4ZgD2t
         1fNCgSZLmX6eWT5xahDRSRok3OyY5+sM0wWqnUrIVpyL8Tc+xt84klQuAmg1RNUJ+dI0
         i8SotKUn8Vds8TSGznpmKwo+ObQXvy2uYdYVZhDbT8oZbst2j3Rg0PljSOFMMCJOkklZ
         ZaqAHlIElcwKC0SkHhWBFmg2bo1NHN0wmO15TyPDNN5F4+gNe/gljVI6/1ABXSL6dTjr
         MYJtVhtZIuIZvOvKJU1HPVDq+ASRh5x5F1DAY7QlyoJMKkNqRuv1s6dKxxOJfidG2a8j
         p7WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EOkS5kDhQCp2QpKFvcqRvsCtdLy33nkr3AyjAFEDqsc=;
        b=q8V4CissFJ2pHiYSHeXCeuK+jo+J3uzH1Xz4GdI7XF6FSvVBqt+M1psbbS3V+NRlI/
         H//UitQr8tbb2LEguiUifCaNewcvLJCoGYjxCMxxj+WD3UL6TG+Y8h14n9bM2KCawFx2
         6PJkJziBoF31XhahCQqsvYzLz7gMpneGuFuspthfVTEYQ6NsQyegV/hbK/ZcNO3/9wOo
         d785QUSqlfNyALclX/V+hQxEzpiFbkeGatD0sni6UK4ybuR+yKHehG8Bi40cKT2O+ROT
         0Fd+WJMV4BTx6WU2SJQyaXxEa8UIfAq8EP6egN2WcqO6o3aU2PsZF9WH5pWA1Qz0Ep+2
         rzDw==
X-Gm-Message-State: APjAAAUI+gbHwGk4qEnjonWXTJPQ9IWIforArIAcW8v8Qy0HL0DRgMz6
        FNFsl8/oU1BUFHNu0uPZz35nziHh
X-Google-Smtp-Source: APXvYqxxdOY210KODL0TOfULUp7JPCmDhod340RciukIdE/d0HsJRiE1Gwbfc0pNVYDm7Q8lq19uaA==
X-Received: by 2002:a17:90a:a404:: with SMTP id y4mr46001132pjp.58.1563375782825;
        Wed, 17 Jul 2019 08:03:02 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id b37sm44728961pjc.15.2019.07.17.08.03.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 08:03:01 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Chris Healy <cphealy@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Cory Tusar <cory.tusar@zii.aero>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ARM: dts: vf610-zii-scu4-aib: Drop unused pinctrl_i2c3 pinmux config
Date:   Wed, 17 Jul 2019 08:02:53 -0700
Message-Id: <20190717150253.20107-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190717150253.20107-1-andrew.smirnov@gmail.com>
References: <20190717150253.20107-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pinctrl_i2c3 pinmux config is not used anywhere. Drop it.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Cory Tusar <cory.tusar@zii.aero>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm/boot/dts/vf610-zii-scu4-aib.dts | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm/boot/dts/vf610-zii-scu4-aib.dts b/arch/arm/boot/dts/vf610-zii-scu4-aib.dts
index a64de809299f..666ec27a73e3 100644
--- a/arch/arm/boot/dts/vf610-zii-scu4-aib.dts
+++ b/arch/arm/boot/dts/vf610-zii-scu4-aib.dts
@@ -792,13 +792,6 @@
 		>;
 	};
 
-	pinctrl_i2c3: i2c3grp {
-		fsl,pins = <
-			VF610_PAD_PTA30__I2C3_SCL		0x37ff
-			VF610_PAD_PTA31__I2C3_SDA		0x37ff
-		>;
-	};
-
 	pinctrl_leds_debug: pinctrl-leds-debug {
 		fsl,pins = <
 			 VF610_PAD_PTB26__GPIO_96		0x31c2
-- 
2.21.0

