Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88BCC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 14:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FD7121019
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 14:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=essensium-com.20150623.gappssmtp.com header.i=@essensium-com.20150623.gappssmtp.com header.b="P6WoLLKD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732452AbfFLONU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 10:13:20 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35873 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731247AbfFLONO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 10:13:14 -0400
Received: by mail-ed1-f66.google.com with SMTP id k21so22640442edq.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 07:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=essensium-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dnpQA/36f3puBoeFdufMNivJajWtYx7kIb4vLCA2A/8=;
        b=P6WoLLKDEQq28OBHm7SuaGw4zqDlXJ0Z/hMhyJYWPEVHGF/7EksRN/sHsUHVbvBp5q
         JFjOAVpKVtFvlan05c6wb9hjFWT4luqHxi8ZF/PLD1hTksqOzBgO+DUrrg36a6fFH+r+
         NYynLU2AvvrKmT6HcQ43EjcwdxSNZciavMh8iRV9R5iXLPLVDMmJE0WVunA6b+y40cgy
         yweJoXJnHuiODpzHMPGg0P++G+fXQQKzIaRYeSaMNDzCYne6jIuhvCgbC0wGtHPM5X9D
         l2totDj2/6M2qX7IaYXIGjkDtuiKK8YGZEdSrTmeQhATqh7Yjku2qQusF6SnklYSdtje
         6Bew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dnpQA/36f3puBoeFdufMNivJajWtYx7kIb4vLCA2A/8=;
        b=rxPMFOD+eSsbnWByKysSaaNKcS1KLfLbtHl51xRG1ZvdtYcnRs7APrY0BuOIyAwDwM
         5UbRMM0auFQmWEjQOdOcssyYQ6KBbnDnqkX0aiNa4byTOCLdvHmiVFRP6bMfRtgJHMPd
         X5s+qOOG7EWhkv9YzW7OmXINRW7xC0Y3Tj3iIyuRT7us7D1K8CvN3hooUlClvgV0fxp6
         JU6xmilNaF1gNh5yrdbfvlT+i3li6fbTl/EP671BTVNOrh1pgRqnSOxSoN45iElBb7L+
         bu2yKYaPzn4hmL3LvnvwP+QwpJTQL6smkT/DWTpxqr+EJSE04E2z5VmUbzTHxZvM+rQ8
         M5bQ==
X-Gm-Message-State: APjAAAUPggfwPlxzKJH0gPtlVf0dow9vP9Zt40gt0XkXAJEUA+nDHKmv
        YxjIlhbm7/y8MYwXLXXTEb7vGw==
X-Google-Smtp-Source: APXvYqymIjFcPnsVOPoiLyGn8txfd6LD7DvUIFlcft2eqr0A4jj8n4R/d4pucI62iKtfjRDqzotuEg==
X-Received: by 2002:a17:906:e204:: with SMTP id gf4mr29870786ejb.302.1560348793032;
        Wed, 12 Jun 2019 07:13:13 -0700 (PDT)
Received: from localhost.localdomain (ip-188-118-3-185.reverse.destiny.be. [188.118.3.185])
        by smtp.gmail.com with ESMTPSA id g2sm7095eja.23.2019.06.12.07.13.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 07:13:12 -0700 (PDT)
From:   Patrick Havelange <patrick.havelange@essensium.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiubo Li <Li.Xiubo@freescale.com>
Cc:     Patrick Havelange <patrick.havelange@essensium.com>
Subject: [PATCH 2/2] pwm: pwm-fsl-ftm: Use write protection for prescaler & polarity
Date:   Wed, 12 Jun 2019 16:12:46 +0200
Message-Id: <20190612141246.7366-2-patrick.havelange@essensium.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190612141246.7366-1-patrick.havelange@essensium.com>
References: <20190612141246.7366-1-patrick.havelange@essensium.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modifying the prescaler or polarity value must be done with the
write protection disabled. Currently this is working by chance as
the write protection is in a disabled state by default.
This patch makes sure that we enable/disable the write protection
when needed.

Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
---
 drivers/pwm/pwm-fsl-ftm.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
index cd5fe39ab95d..e955b1cdfd2f 100644
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@ -59,6 +59,21 @@ static inline struct fsl_pwm_chip *to_fsl_chip(struct pwm_chip *chip)
 	return container_of(chip, struct fsl_pwm_chip, chip);
 }
 
+static void ftm_clear_write_protection(struct fsl_pwm_chip *fpc)
+{
+	u32 val;
+
+	regmap_read(fpc->regmap, FTM_FMS, &val);
+	if (val & FTM_FMS_WPEN)
+		regmap_update_bits(fpc->regmap, FTM_MODE, FTM_MODE_WPDIS,
+				   FTM_MODE_WPDIS);
+}
+
+static void ftm_set_write_protection(struct fsl_pwm_chip *fpc)
+{
+	regmap_update_bits(fpc->regmap, FTM_FMS, FTM_FMS_WPEN, FTM_FMS_WPEN);
+}
+
 static bool fsl_pwm_periodcfg_are_equal(const struct fsl_pwm_periodcfg *a,
 					const struct fsl_pwm_periodcfg *b)
 {
@@ -253,6 +268,8 @@ static int fsl_pwm_apply_config(struct fsl_pwm_chip *fpc,
 		do_write_period = true;
 	}
 
+	ftm_clear_write_protection(fpc);
+
 	if (do_write_period) {
 		regmap_update_bits(fpc->regmap, FTM_SC, FTM_SC_CLK_MASK,
 				   FTM_SC_CLK(periodcfg.clk_select));
@@ -279,6 +296,8 @@ static int fsl_pwm_apply_config(struct fsl_pwm_chip *fpc,
 					       fpc->period.mod_period + 1);
 	newstate->duty_cycle = fsl_pwm_ticks_to_ns(fpc, duty);
 
+	ftm_set_write_protection(fpc);
+
 	return 0;
 }
 
@@ -359,6 +378,8 @@ static int fsl_pwm_init(struct fsl_pwm_chip *fpc)
 static bool fsl_pwm_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
+	case FTM_FMS:
+	case FTM_MODE:
 	case FTM_CNT:
 		return true;
 	}
-- 
2.19.1

