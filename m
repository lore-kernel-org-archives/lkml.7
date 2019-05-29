Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB77C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FA8E22C7D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NDUTPoej"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbfE2Npq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 09:45:46 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42402 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfE2Npp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 09:45:45 -0400
Received: by mail-pg1-f196.google.com with SMTP id 33so1400584pgv.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 06:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SqXIr30zs9BkbQwxZqBClCfv+cPq2d3qcgpjcAvAiGs=;
        b=NDUTPoej8DHpoO6KSmHJxoi0Aqrq9QJZ4odx6zA/FH6TPgcw14FNSc1bsCfcSiD+SL
         MGHrGq6xKY13oPdb50V2kwwdNPPO9K0XKEWk1YyRXDp3soMjQX5cbzMqjlJluGKijyHH
         5w5Dla4hkVxGi5PNWs0hyg0p24jKiPP4aqRjfEQPPh+bCoWCGpP1sxkqO0Nr9rf8zQ5M
         Z9ickGwsa8fR4YJh4a/wTZMiQQnQo12HuYlHQbyUCG79sNpfnp7/9gKEt5HWCHv+Kv7U
         WJbum9Q9Fl+Zzge/ENs/0aIRU7OvS3cAkKMU90v95Ek9yroY9DNkFNi2Cf3bWLCm5SH4
         Rvpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SqXIr30zs9BkbQwxZqBClCfv+cPq2d3qcgpjcAvAiGs=;
        b=isR4sVfUZR31dl0kM62ysBlGQyZh6YBR8EFMsSe4BgCTCs3MAbu3JE7rGCpUEZKml4
         XeB23zpS1NdZSOnCjK+TADy+54CskxyK75EPypGgpEwDkGU6t8Pc0Vdr00mP7BhB5822
         EHuIebnPC4C9FVvkVB+/rtdzEdoJIAi4+6tvY4L4jzYK04Nw5EjIgBcFGWYDTpkQdVd9
         W4ZzkbC2sciQ65eAysyfPxhsPOIbcZJ8sg6W8IGtTrfMDsumqH+zIUa/gmdZe7E2r/C0
         7dIbhYiL9SXfnmwFQYKt0KA/tYRNTsRnMC4OdzXBkCfswrWWMpj3T82yZbNMjv9jztyb
         Zk9w==
X-Gm-Message-State: APjAAAW2+ZN9oCM3Fq+osCwfByJRBKaFesc2wcNGYGH44VDDfaUC5f7T
        hKPfZv5xPl583w6IU+m60m4=
X-Google-Smtp-Source: APXvYqxkBYOuxK0amFtx5a1umiKDE8/BW7SY/HthJ8NUMLVqTshgv/urKr5MVe22K4m0foaujHyOVg==
X-Received: by 2002:aa7:8dcd:: with SMTP id j13mr47144454pfr.107.1559137544927;
        Wed, 29 May 2019 06:45:44 -0700 (PDT)
Received: from localhost.localdomain ([122.163.67.155])
        by smtp.gmail.com with ESMTPSA id e5sm14299344pgh.35.2019.05.29.06.45.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 06:45:43 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     forest@alittletooquiet.net, gregkh@linuxfoundation.org,
        madhumithabiw@gmail.com, brandonbonaby94@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH] staging: vt6655: Change return type of function and remove variable
Date:   Wed, 29 May 2019 19:15:29 +0530
Message-Id: <20190529134529.8481-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the function CARDbRadioPowerOff always returns true, and this value
does not appear to be used anywhere, the return variable can be entirely
removed and the function converted to type void.
Issue found with Coccinelle.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
 drivers/staging/vt6655/card.c | 56 ++++++++++++++++-------------------
 drivers/staging/vt6655/card.h |  2 +-
 2 files changed, 27 insertions(+), 31 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index 6ecbe925026d..2aca5b38be5c 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -409,42 +409,38 @@ bool CARDbSetBeaconPeriod(struct vnt_private *priv,
  *  Out:
  *      none
  *
- * Return Value: true if success; otherwise false
+ * Return Value: none
  */
-bool CARDbRadioPowerOff(struct vnt_private *priv)
+void CARDbRadioPowerOff(struct vnt_private *priv)
 {
-	bool bResult = true;
-
-	if (priv->bRadioOff)
-		return true;
-
-	switch (priv->byRFType) {
-	case RF_RFMD2959:
-		MACvWordRegBitsOff(priv->PortOffset, MAC_REG_SOFTPWRCTL,
-				   SOFTPWRCTL_TXPEINV);
-		MACvWordRegBitsOn(priv->PortOffset, MAC_REG_SOFTPWRCTL,
-				  SOFTPWRCTL_SWPE1);
-		break;
+	if (!priv->bRadioOff) {
+		switch (priv->byRFType) {
+		case RF_RFMD2959:
+			MACvWordRegBitsOff(priv->PortOffset, MAC_REG_SOFTPWRCTL,
+					   SOFTPWRCTL_TXPEINV);
+			MACvWordRegBitsOn(priv->PortOffset, MAC_REG_SOFTPWRCTL,
+					  SOFTPWRCTL_SWPE1);
+			break;
 
-	case RF_AIROHA:
-	case RF_AL2230S:
-	case RF_AIROHA7230:
-		MACvWordRegBitsOff(priv->PortOffset, MAC_REG_SOFTPWRCTL,
-				   SOFTPWRCTL_SWPE2);
-		MACvWordRegBitsOff(priv->PortOffset, MAC_REG_SOFTPWRCTL,
-				   SOFTPWRCTL_SWPE3);
-		break;
-	}
+		case RF_AIROHA:
+		case RF_AL2230S:
+		case RF_AIROHA7230:
+			MACvWordRegBitsOff(priv->PortOffset, MAC_REG_SOFTPWRCTL,
+					   SOFTPWRCTL_SWPE2);
+			MACvWordRegBitsOff(priv->PortOffset, MAC_REG_SOFTPWRCTL,
+					   SOFTPWRCTL_SWPE3);
+			break;
+		}
 
-	MACvRegBitsOff(priv->PortOffset, MAC_REG_HOSTCR, HOSTCR_RXON);
+		MACvRegBitsOff(priv->PortOffset, MAC_REG_HOSTCR, HOSTCR_RXON);
 
-	BBvSetDeepSleep(priv, priv->byLocalID);
+		BBvSetDeepSleep(priv, priv->byLocalID);
 
-	priv->bRadioOff = true;
-	pr_debug("chester power off\n");
-	MACvRegBitsOn(priv->PortOffset, MAC_REG_GPIOCTL0,
-		      LED_ACTSET);  /* LED issue */
-	return bResult;
+		priv->bRadioOff = true;
+		pr_debug("chester power off\n");
+		MACvRegBitsOn(priv->PortOffset, MAC_REG_GPIOCTL0,
+			      LED_ACTSET);  /* LED issue */
+	}
 }
 
 /*
diff --git a/drivers/staging/vt6655/card.h b/drivers/staging/vt6655/card.h
index f422fb3c78bd..887c1692e05b 100644
--- a/drivers/staging/vt6655/card.h
+++ b/drivers/staging/vt6655/card.h
@@ -57,7 +57,7 @@ u64 CARDqGetTSFOffset(unsigned char byRxRate, u64 qwTSF1, u64 qwTSF2);
 unsigned char CARDbyGetPktType(struct vnt_private *priv);
 void CARDvSafeResetTx(struct vnt_private *priv);
 void CARDvSafeResetRx(struct vnt_private *priv);
-bool CARDbRadioPowerOff(struct vnt_private *priv);
+void CARDbRadioPowerOff(struct vnt_private *priv);
 bool CARDbRadioPowerOn(struct vnt_private *priv);
 bool CARDbSetPhyParameter(struct vnt_private *priv, u8 bb_type);
 bool CARDbUpdateTSF(struct vnt_private *priv, unsigned char byRxRate,
-- 
2.19.1

