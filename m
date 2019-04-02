Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04CF5C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3A5920857
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNhFccOk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbfDBGc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 02:32:26 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40737 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfDBGcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 02:32:25 -0400
Received: by mail-pf1-f196.google.com with SMTP id c207so5832689pfc.7;
        Mon, 01 Apr 2019 23:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i/73y8EqAZm2cFjbN4yCx0AeoLF3+nbdcxL9URDqVac=;
        b=aNhFccOka/xlrRuJPftLIHqXOitZh0phQC2lQ3PkGChkwRIjRosI0XyI9gyfBpmmDh
         mwD6q5eympVCFtuDYDS7MZ5+otFqk/2UhXdKnzDl6faevAwP5SVPK/3Sjhi0Vjd/lV2/
         cJ0M/d7f3FT2nMwwijOhjjdcJwdn14ucBPY1QHIF89s1WyzkVZk+FtQqOko9OPOqCBjd
         JqsLv2KcecLh1gf/BfB7YNn/CntblZz0K6djow3ad6zxsfC8QRjRfEoDJ/HHbqb4028K
         s2T+ut/jh56EHMr77XeLDv6Ebu78ODs5nSYZY65J961NBoghSEgxQiyiZoEaWpfktwAC
         xRqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i/73y8EqAZm2cFjbN4yCx0AeoLF3+nbdcxL9URDqVac=;
        b=ZkyvFnk181PhFFG9mS4mGhm/OmpuCbNJJGSwylJomZp9A5Yx1qEj+3uXvryP3XAHir
         z8cmQaZ8dXbC+enuIcG2zY1mW5pKL/wyZwBPUYlhfzkIA/hheH/aBHcgaWwd0XtO+jPM
         bXO7fbTsrDQmhHOCjVsCbcEU/6mE4WC82Fvi37Z/NLud3jIvjpntej2arJam6FPsVXt7
         u9Sg+wPyKX7QVq2ZCTqqjXx7wPMyz8jjp0MI7kYz5/HWkFqYjZuWEaBtHw6P0KZ7/7Tr
         xd67YCbEBMOeGVMvsdFLBKtOOpZqjnymkukwsIjk1Pkw3Jvx18el7J1PJAkNj/UIVavw
         jDmg==
X-Gm-Message-State: APjAAAX9hHWygFraeeIPWmgcbG1ARrMnXBXb7udq0jeZibY6fk3jpxjE
        1at6rKsE6VwVfWqzvnhTTOU=
X-Google-Smtp-Source: APXvYqyKElm9IyjJOGKMpNBKoxDRtGiq9ucGRXcS1J+WRSWaSRJaHfqwX/9e/qiQu+gpOBtq8j+Zbg==
X-Received: by 2002:a63:e653:: with SMTP id p19mr3469003pgj.284.1554186744528;
        Mon, 01 Apr 2019 23:32:24 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c0a5:4ce0:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id a17sm19327289pfj.123.2019.04.01.23.32.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 23:32:24 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     jic23@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, fabrice.gasnier@st.com,
        benjamin.gaignard@st.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, akpm@linux-foundation.org, david@lechnology.com,
        robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        leoyang.li@nxp.com, daniel.lezcano@linaro.org, tglx@linutronix.de,
        thierry.reding@gmail.com, esben@haabendal.dk,
        linux-pwm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        patrick.havelange@essensium.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v10 13/18] drivers/pwm: pwm-fsl-ftm: use common header for FlexTimer #defines
Date:   Tue,  2 Apr 2019 15:30:48 +0900
Message-Id: <a6b1f0642988c568a545de390ef95ceb9c9f0bf0.1554184734.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1554184734.git.vilhelm.gray@gmail.com>
References: <cover.1554184734.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Havelange <patrick.havelange@essensium.com>

This also fixes the wrong value for the previously defined
FTM_MODE_INIT macro (it was not used).

Reviewed-by: Esben Haabendal <esben@haabendal.dk>
Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
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
2.21.0

