Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3172CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0045221850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dQcP30GH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbfCTNTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 09:19:33 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33636 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728298AbfCTNTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 09:19:30 -0400
Received: by mail-pg1-f195.google.com with SMTP id b12so1823896pgk.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 06:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=fm65ZPfRVy8TLS4M5vhWmy5kJkboJ+fvo0pgjB8oBQU=;
        b=dQcP30GHRPPju0MN6y8Db/okxfda7Z1No4bPn2lh4jpUBwRxVCzPm11HUC57dcwFPR
         AIdKfMSohhipypGn0UCE6ceUDB9u98rvEtgVe9eFxgvCDiRP8WUylLUiIAsWIxmJaOMJ
         DXTFSpmO5F7kalRiXvKCAIfQUf+WRjKBJpSFt+ED5GZevwojY7QRAos3mUxZROqwJPL0
         MM1PjSCM5pbJk1IlbABFh4NstzTJuVa7gkiS3cleEZQhyBG6oRqajFBFKS3WF3zTOeZ6
         5DVAOD1FgzQ22Ns4UbqUv1uJwVF+NkbgwwwGPoWq2eqO2AuuKyyE91dVCAR2eRJdpepX
         AC5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=fm65ZPfRVy8TLS4M5vhWmy5kJkboJ+fvo0pgjB8oBQU=;
        b=BDzbWGDgnjpfR+2P3W6owrtGJm2tVXTFAbu4Z3KcpJeQESBPgvh13KQGgqFd4wqYdE
         42Pu3h8FgGOx9EKfmvRYRR48Z7sdZGZgv+sx92CTgyeV2UWLxbsfotoPUhiy92o/Husx
         6pxRFF6NTNuMzLa9KCohJB0TE0/CnnGWdiuFNs0UV12E5X2a2ToEHRomBb2IgsnggMoy
         PgF+9MVbC4nP0De0xdLizVAc2It72PmCrO7LdZaKhg73QIuyq0pUvb8fl3bokvHQRqHz
         KWQpyDjvtbKEGcfBK2fD1LGLcoUIr6QjIAotv67qu8PN1jYFeLuw8MqbVeKTk1pawwS3
         D9Sg==
X-Gm-Message-State: APjAAAVx4I23KWajuavSxDNAz6TpNAsV62+zDn1/FXhI57nh9ZGhwIrS
        D15k6swS4/YvT3gGtwRUod9nMcrmR6w=
X-Google-Smtp-Source: APXvYqy1q2+CT5wAIPO5PxGRvd6rKyZxeAOvU4OIUT5P7vZDqpv4r+eo5RBoJG2jzr39G7h7eKRVYQ==
X-Received: by 2002:a65:50c8:: with SMTP id s8mr7323893pgp.308.1553087969883;
        Wed, 20 Mar 2019 06:19:29 -0700 (PDT)
Received: from localhost ([114.143.122.221])
        by smtp.gmail.com with ESMTPSA id r3sm5913429pgb.82.2019.03.20.06.19.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 06:19:29 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCHv3 15/23] drivers: thermal: tsens: Introduce IP-specific max_sensor count
Date:   Wed, 20 Mar 2019 18:47:55 +0530
Message-Id: <5cfa53072a0aa76b1a37c69b64d4ed74633f0000.1553086065.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1553086065.git.amit.kucheria@linaro.org>
References: <cover.1553086065.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1553086065.git.amit.kucheria@linaro.org>
References: <cover.1553086065.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IP can support 'm' sensors while the platform can enable 'n' sensors
of the 'm' where n <= m.

Track maximum sensors supported by the IP so that we can correctly track
what subset of the sensors are supported on the platform.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-common.c | 4 ++--
 drivers/thermal/qcom/tsens-v0_1.c   | 1 +
 drivers/thermal/qcom/tsens-v2.c     | 1 +
 drivers/thermal/qcom/tsens.h        | 2 ++
 4 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index c76f8cfb25a2..5607c5cc635c 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -198,7 +198,7 @@ int __init init_common(struct tsens_priv *priv)
 		goto err_put_device;
 	}
 	/* now alloc regmap_fields in tm_map */
-	for (i = 0, j = LAST_TEMP_0; i < priv->num_sensors; i++, j++) {
+	for (i = 0, j = LAST_TEMP_0; i < priv->feat->max_sensors; i++, j++) {
 		priv->rf[j] = devm_regmap_field_alloc(dev, priv->tm_map,
 						      priv->fields[j]);
 		if (IS_ERR(priv->rf[j])) {
@@ -206,7 +206,7 @@ int __init init_common(struct tsens_priv *priv)
 			goto err_put_device;
 		}
 	}
-	for (i = 0, j = VALID_0; i < priv->num_sensors; i++, j++) {
+	for (i = 0, j = VALID_0; i < priv->feat->max_sensors; i++, j++) {
 		priv->rf[j] = devm_regmap_field_alloc(dev, priv->tm_map,
 						      priv->fields[j]);
 		if (IS_ERR(priv->rf[j])) {
diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
index 431255bfd0ef..b3a63d7b19ea 100644
--- a/drivers/thermal/qcom/tsens-v0_1.c
+++ b/drivers/thermal/qcom/tsens-v0_1.c
@@ -324,6 +324,7 @@ const struct tsens_features tsens_v0_1_feat = {
 	.crit_int	= 0,
 	.adc		= 1,
 	.srot_split	= 1,
+	.max_sensors	= 11,
 };
 
 const struct reg_field tsens_v0_1_regfields[MAX_REGFIELDS] = {
diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index 4b98dbe4e3c3..f3eb8661cf7a 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -88,6 +88,7 @@ const struct tsens_features tsens_v2_feat = {
 	.crit_int	= 1,
 	.adc		= 0,
 	.srot_split	= 1,
+	.max_sensors	= 16,
 };
 
 const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 527c42cfd2d5..080e15a09ac2 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -242,12 +242,14 @@ enum regfield_ids {
  * @adc:      do the sensors only output adc code (instead of temperature)?
  * @srot_split: does the IP neatly splits the register space into SROT and TM,
  *              with SROT only being available to secure boot firmware?
+ * @max_sensors: maximum sensors supported by this version of the IP
  */
 struct tsens_features {
 	unsigned int ver_major;
 	unsigned int crit_int:1;
 	unsigned int adc:1;
 	unsigned int srot_split:1;
+	unsigned int max_sensors;
 };
 
 /**
-- 
2.17.1

