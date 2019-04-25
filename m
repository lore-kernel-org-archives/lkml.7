Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F62C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBFB82146E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hnak5X4E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387647AbfDYTxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:53:19 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39688 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfDYTxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:53:14 -0400
Received: by mail-pg1-f196.google.com with SMTP id l18so363277pgj.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 12:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yUNxZtf++bgU2RFogSdv+irhpIUzYqSjyRPAcofgUZU=;
        b=hnak5X4E/hZZbEFX99+vRgNXoePpmOAP923nVhGZ7MH9BwK2J14Eu3zuanxRnWdAOi
         lLvSLt3sFv8303VxkTXhJsyX+hR31R2JHb3aYUGiWZaF9+QuobQ/bPNEKFofNuk7CAuS
         l/a8BJCWVPsb21p6vIRXFkIBz1N4A1+VkhdkECnV8A0y1oEv9/PFFWNydd956Z43Tmlp
         H7ydOFfEy34NovHwiea7/qn26y73dtLTRsmcoO9AOWBg0FT0H4lXj+LXVEumgg0NgJod
         DZVHXhBeLaiIDiY3GHAFbMFjYPL82wgdvx6+uPKLJO6gPrhAybEeeXa6hX/wypQTvRPL
         vHLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yUNxZtf++bgU2RFogSdv+irhpIUzYqSjyRPAcofgUZU=;
        b=XGJgexlt0PTaCVdkaow+pRCWfBzBkAwn50rjIYt3VIS0ZegNYKzwZidRvrCaFLyUd4
         Q462MDVeWaK95gXbtyHuvFfsiKa/XiIDxMwyqVNwbC480Ig1YM9LMRrLmqQjwMyRkadt
         bpp272alLinnYE1qZgC8n/e5+Og61M9XkDfrg9oXkzqbDI8g9HQRv6AsGA+jnBirF/xp
         azgsZpMey316Iocc72y4BdsLoNR/p29coZD/QcFOj7CFc61Z2lH2I2TNRkW/ySnRc/6i
         cz/T41lb/3/GiJ7RkmJBiFTHUd2Z9SFxJln12DczRnPV4oPVWqRudltmKOZ9//f/Bs16
         ahaQ==
X-Gm-Message-State: APjAAAVBFDzx2Y280pHVzSV0zSbzrHYP5+PQsPRmkklsxePOCqH3bD62
        SsGH7hXwgxCq+BpHUtM7BgtcYQ==
X-Google-Smtp-Source: APXvYqyGJdz1zNDQLN0cTezZDdGJDMX4PbrZ0Plo9kjOOKOPowvgURVdeiHtsK1NLnblSVQHPY0foQ==
X-Received: by 2002:a65:6659:: with SMTP id z25mr38915123pgv.10.1556221993963;
        Thu, 25 Apr 2019 12:53:13 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id t64sm47261961pfa.86.2019.04.25.12.53.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 12:53:13 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/32] coresight: catu: fix clang build warning
Date:   Thu, 25 Apr 2019 13:52:39 -0600
Message-Id: <20190425195310.31562-2-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190425195310.31562-1-mathieu.poirier@linaro.org>
References: <20190425195310.31562-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Clang points out a syntax error, as the etr_catu_buf_ops structure is
declared 'static' before the type is known:

In file included from drivers/hwtracing/coresight/coresight-tmc-etr.c:12:
drivers/hwtracing/coresight/coresight-catu.h:116:40: warning: tentative definition of variable with internal linkage has incomplete non-array type 'const struct etr_buf_operations' [-Wtentative-definition-incomplete-type]
static const struct etr_buf_operations etr_catu_buf_ops;
                                       ^
drivers/hwtracing/coresight/coresight-catu.h:116:21: note: forward declaration of 'struct etr_buf_operations'
static const struct etr_buf_operations etr_catu_buf_ops;

This seems worth fixing in the code, so replace pointer to the empty
constant structure with a NULL pointer. We need an extra NULL pointer
check here, but the result should be better object code otherwise,
avoiding the silly empty structure.

Fixes: 434d611cddef ("coresight: catu: Plug in CATU as a backend for ETR buffer")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
[Fixed line over 80 characters]
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-catu.h    | 5 -----
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 5 +++--
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-catu.h b/drivers/hwtracing/coresight/coresight-catu.h
index 1b281f0dcccc..1d2ad183fd92 100644
--- a/drivers/hwtracing/coresight/coresight-catu.h
+++ b/drivers/hwtracing/coresight/coresight-catu.h
@@ -109,11 +109,6 @@ static inline bool coresight_is_catu_device(struct coresight_device *csdev)
 	return true;
 }
 
-#ifdef CONFIG_CORESIGHT_CATU
 extern const struct etr_buf_operations etr_catu_buf_ops;
-#else
-/* Dummy declaration for the CATU ops */
-static const struct etr_buf_operations etr_catu_buf_ops;
-#endif
 
 #endif
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index f684283890d3..cf7a32ce209d 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -772,7 +772,8 @@ static inline void tmc_etr_disable_catu(struct tmc_drvdata *drvdata)
 static const struct etr_buf_operations *etr_buf_ops[] = {
 	[ETR_MODE_FLAT] = &etr_flat_buf_ops,
 	[ETR_MODE_ETR_SG] = &etr_sg_buf_ops,
-	[ETR_MODE_CATU] = &etr_catu_buf_ops,
+	[ETR_MODE_CATU] = IS_ENABLED(CONFIG_CORESIGHT_CATU)
+						? &etr_catu_buf_ops : NULL,
 };
 
 static inline int tmc_etr_mode_alloc_buf(int mode,
@@ -786,7 +787,7 @@ static inline int tmc_etr_mode_alloc_buf(int mode,
 	case ETR_MODE_FLAT:
 	case ETR_MODE_ETR_SG:
 	case ETR_MODE_CATU:
-		if (etr_buf_ops[mode]->alloc)
+		if (etr_buf_ops[mode] && etr_buf_ops[mode]->alloc)
 			rc = etr_buf_ops[mode]->alloc(drvdata, etr_buf,
 						      node, pages);
 		if (!rc)
-- 
2.17.1

