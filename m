Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FFDC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 11:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FA5B20661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 11:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=essensium-com.20150623.gappssmtp.com header.i=@essensium-com.20150623.gappssmtp.com header.b="jQJjtG85"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730457AbfCFLNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 06:13:09 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34580 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730357AbfCFLMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 06:12:31 -0500
Received: by mail-ed1-f65.google.com with SMTP id a16so10014320edn.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 03:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=essensium-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Eb8QqYRrz4udMhES1PQQVcFV8QXyv6ZjH+to8xVEkfQ=;
        b=jQJjtG85mLXrsJnvSxav5RIgquH5GW9mfXb8hLBzuRXca455TiuI7Y/Nr3GeOos5Ik
         ECEtC+SqM4DuZ3Or45muV3FFQIe87uNu7VI2U8s3b35xxh7jCtMuifd0yvtxvDlCFWtA
         xeh7SF39xYl/UIq6C3c0MYtJdvr47+xzywI6fS5GQl8JgY1EGOJOHWeopNUEMOLAFjgL
         IznuVIOelkZVXy9zQSQNr0fjR/gRghG/0bWHzoYRCBcwslzh2ZKARiWxyHHDikJhHN/0
         BVVqz7Huonn6ProZBX5t6Y5W99dCDhwN4doI8SZLIs1mchAlpfHWAp5f+L6HizCNBx6u
         PNXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Eb8QqYRrz4udMhES1PQQVcFV8QXyv6ZjH+to8xVEkfQ=;
        b=gjThEvuV/6Ih6pAdqfGsxDeclUlzU+NXxC92fImzen0pBlv4opp4J2gMbhfQs6XKru
         46FXNxkSAVpgkqRb6by09/L2wrswp+Krw/pDHRB4a9WVichqCSOyhdeRdv+9yJe3o5Dt
         H8VlIW9YKFuqNQ1ORZjC2Mm+jX9oabD6cRfjfP4ChY/k+TZN1mCEsxrQSvNIIZubKuz6
         8MZf5a5sDIR3Dg4zVXb4aITOZcx/kVj/pvtLWptpC8rlTZ3P1v4vF7gif/Uu9wjeM4nR
         Kcxtzlj4b+pvwwKErhBk3Q34FIDQCk3jX8G/i1/bH9A8koOfH6dUCGt+0QfqIAeVqGLK
         FSFQ==
X-Gm-Message-State: APjAAAUrDySpTIeMecinPN+7+RvMDXpDEmFFlduQAj5b5SqlmXVmqcW6
        xOI3TP/LsO2o0WPfK+k0c0bfqA==
X-Google-Smtp-Source: APXvYqy+UBtAM38g9GKS03KWMHt12mMimEbDT3GdfxQSX/lJLAovXdY1Wl+OiNa9aZbCQqM2Es1/3g==
X-Received: by 2002:a05:6402:184f:: with SMTP id v15mr23541935edy.133.1551870750172;
        Wed, 06 Mar 2019 03:12:30 -0800 (PST)
Received: from ph-ThinkPad-E560.local.ess-mail.com (ip-188-118-3-185.reverse.destiny.be. [188.118.3.185])
        by smtp.gmail.com with ESMTPSA id t25sm277879ejr.30.2019.03.06.03.12.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 03:12:29 -0800 (PST)
From:   Patrick Havelange <patrick.havelange@essensium.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Esben Haabendal <esben@haabendal.dk>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Patrick Havelange <patrick.havelange@essensium.com>
Subject: [PATCH v2 2/7] drivers/pwm: pwm-fsl-ftm: use common header for FlexTimer #defines
Date:   Wed,  6 Mar 2019 12:12:03 +0100
Message-Id: <20190306111208.7454-3-patrick.havelange@essensium.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190306111208.7454-1-patrick.havelange@essensium.com>
References: <20190306111208.7454-1-patrick.havelange@essensium.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This also fixes the wrong value for the previously defined
FTM_MODE_INIT macro (it was not used).

Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
Reviewed-by: Esben Haabendal <esben@haabendal.dk>
---
Changes v2
     - None
---
 drivers/pwm/pwm-fsl-ftm.c | 44 +--------------------------------------
 1 file changed, 1 insertion(+), 43 deletions(-)

diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
index 883378d055c6..f21ea1b97116 100644
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@ -22,51 +22,9 @@
 #include <linux/pwm.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
+#include <linux/fsl/ftm.h>
 
-#define FTM_SC		0x00
-#define FTM_SC_CLK_MASK_SHIFT	3
-#define FTM_SC_CLK_MASK	(3 << FTM_SC_CLK_MASK_SHIFT)
 #define FTM_SC_CLK(c)	(((c) + 1) << FTM_SC_CLK_MASK_SHIFT)
-#define FTM_SC_PS_MASK	0x7
-
-#define FTM_CNT		0x04
-#define FTM_MOD		0x08
-
-#define FTM_CSC_BASE	0x0C
-#define FTM_CSC_MSB	BIT(5)
-#define FTM_CSC_MSA	BIT(4)
-#define FTM_CSC_ELSB	BIT(3)
-#define FTM_CSC_ELSA	BIT(2)
-#define FTM_CSC(_channel)	(FTM_CSC_BASE + ((_channel) * 8))
-
-#define FTM_CV_BASE	0x10
-#define FTM_CV(_channel)	(FTM_CV_BASE + ((_channel) * 8))
-
-#define FTM_CNTIN	0x4C
-#define FTM_STATUS	0x50
-
-#define FTM_MODE	0x54
-#define FTM_MODE_FTMEN	BIT(0)
-#define FTM_MODE_INIT	BIT(2)
-#define FTM_MODE_PWMSYNC	BIT(3)
-
-#define FTM_SYNC	0x58
-#define FTM_OUTINIT	0x5C
-#define FTM_OUTMASK	0x60
-#define FTM_COMBINE	0x64
-#define FTM_DEADTIME	0x68
-#define FTM_EXTTRIG	0x6C
-#define FTM_POL		0x70
-#define FTM_FMS		0x74
-#define FTM_FILTER	0x78
-#define FTM_FLTCTRL	0x7C
-#define FTM_QDCTRL	0x80
-#define FTM_CONF	0x84
-#define FTM_FLTPOL	0x88
-#define FTM_SYNCONF	0x8C
-#define FTM_INVCTRL	0x90
-#define FTM_SWOCTRL	0x94
-#define FTM_PWMLOAD	0x98
 
 enum fsl_pwm_clk {
 	FSL_PWM_CLK_SYS,
-- 
2.19.1

