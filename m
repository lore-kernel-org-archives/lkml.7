Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA08CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 21:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A922C21721
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 21:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eU3Ih22b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbfJ2VJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 17:09:23 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41620 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfJ2VJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 17:09:23 -0400
Received: by mail-qk1-f195.google.com with SMTP id m125so364178qkd.8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 14:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=J8cn+LNGBQlD5QlWJmme2gIbrHVQ0+7rWGrSL4Madoo=;
        b=eU3Ih22bpawbGnzb3bGBkrltarVhNzNANX8Gi9sC1W/1OsqTeSKiQ5X7SFx9v4g5C3
         4QSgxgJ+zrtYy/QE6PnxHOsqRjVV4E2iq0QPATe+6X6DdS8M35i4nIRmes+O0AjhMWfg
         WecszofhOAuQQK57u2rFdRhDj9RXtnBqI37pzfvIlAZKKu2XREGjGfvM1KulrQ5hJoa5
         Pv8plj4m9enFLqbxuAcNtMXb79xKWUVFwvUKE6Y5lSR0LlQjr2DT92MJyVFLW1pjBmN2
         G+K9JKQ91sSg42L5ZJYyoFoevWxIJohi8NFtmguCC49zYia8Xnaov6nO3PdvEHjXcvvv
         kmVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=J8cn+LNGBQlD5QlWJmme2gIbrHVQ0+7rWGrSL4Madoo=;
        b=Xl2HQVhbo8dIwHZ67NbsVQNLJm3sLf8BJg+Usww/LVmmwXuYLaZRZeCt+ptN4GvGtx
         j/bWgnRZorArt9cKRdHL+GE62lM68WsLtRZIwLypGO5a5LkT0QLNmMLr6leZ039T9EEZ
         HO5LIR0b1CFhT/Y1/AwjlI6HvqkOuOofvXKXBJBFitWCb2zGWF93xgA70EW4kf9whhgo
         7rRHIRDcyi2ixQ31vjZn625wyjsAQWphSXwxFiKozIhG16YfZqUOixIAKMChAMmUa1LM
         smcUj4U4XldG2xAoD6zPZzgxzKFk+G7N68PPPCG1c+D5OUn2ksZDfUjgynjqoVp1dw1R
         9Dfw==
X-Gm-Message-State: APjAAAXia1Mi4Pt8MYTzMzWFJCs/ncVdEwwWUuD4ayJ9cUWsqLTq35QR
        z0QjxJP7oCQW3Hb9R2NtFKs=
X-Google-Smtp-Source: APXvYqy4Q80NlhxmpzE820ofaWQtg8/V1FvT3ajwFjjmIjCMUgaNaoADZ61QvHMsoYKopuXyfUTilA==
X-Received: by 2002:a05:620a:14bc:: with SMTP id x28mr23246894qkj.433.1572383361937;
        Tue, 29 Oct 2019 14:09:21 -0700 (PDT)
Received: from cristiane-Inspiron-5420 ([131.100.148.220])
        by smtp.gmail.com with ESMTPSA id 4sm8078335qtf.87.2019.10.29.14.09.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Oct 2019 14:09:21 -0700 (PDT)
Date:   Tue, 29 Oct 2019 18:09:17 -0300
From:   Cristiane Naves <cristianenavescardoso09@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vt6655: Fix lines ending with parentheses
Message-ID: <20191029210917.GA14956@cristiane-Inspiron-5420>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix lines ending with parentheses. Issue found by checkpatch.

Signed-off-by: Cristiane Naves <cristianenavescardoso09@gmail.com>
---
 drivers/staging/vt6655/card.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index eba4ee0..e65c982 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -79,14 +79,10 @@ static void s_vCalculateOFDMRParameter(unsigned char byRate, u8 bb_type,
  *
  * Return Value: none
  */
-static
-void
-s_vCalculateOFDMRParameter(
-	unsigned char byRate,
-	u8 bb_type,
-	unsigned char *pbyTxRate,
-	unsigned char *pbyRsvTime
-)
+static void s_vCalculateOFDMRParameter(unsigned char byRate,
+				       u8 bb_type,
+				       unsigned char *pbyTxRate,
+				       unsigned char *pbyRsvTime)
 {
 	switch (byRate) {
 	case RATE_6M:
@@ -736,8 +732,7 @@ void CARDvSetRSPINF(struct vnt_private *priv, u8 bb_type)
 	VNSvOutPortW(priv->PortOffset + MAC_REG_RSPINF_A_24,
 		     MAKEWORD(byTxRate, byRsvTime));
 	/* RSPINF_a_36 */
-	s_vCalculateOFDMRParameter(CARDwGetOFDMControlRate(
-							   (void *)priv,
+	s_vCalculateOFDMRParameter(CARDwGetOFDMControlRate((void *)priv,
 							   RATE_36M),
 				   bb_type,
 				   &byTxRate,
@@ -745,8 +740,7 @@ void CARDvSetRSPINF(struct vnt_private *priv, u8 bb_type)
 	VNSvOutPortW(priv->PortOffset + MAC_REG_RSPINF_A_36,
 		     MAKEWORD(byTxRate, byRsvTime));
 	/* RSPINF_a_48 */
-	s_vCalculateOFDMRParameter(CARDwGetOFDMControlRate(
-							   (void *)priv,
+	s_vCalculateOFDMRParameter(CARDwGetOFDMControlRate((void *)priv,
 							   RATE_48M),
 				   bb_type,
 				   &byTxRate,
@@ -754,8 +748,7 @@ void CARDvSetRSPINF(struct vnt_private *priv, u8 bb_type)
 	VNSvOutPortW(priv->PortOffset + MAC_REG_RSPINF_A_48,
 		     MAKEWORD(byTxRate, byRsvTime));
 	/* RSPINF_a_54 */
-	s_vCalculateOFDMRParameter(CARDwGetOFDMControlRate(
-							   (void *)priv,
+	s_vCalculateOFDMRParameter(CARDwGetOFDMControlRate((void *)priv,
 							   RATE_54M),
 				   bb_type,
 				   &byTxRate,
@@ -763,8 +756,7 @@ void CARDvSetRSPINF(struct vnt_private *priv, u8 bb_type)
 	VNSvOutPortW(priv->PortOffset + MAC_REG_RSPINF_A_54,
 		     MAKEWORD(byTxRate, byRsvTime));
 	/* RSPINF_a_72 */
-	s_vCalculateOFDMRParameter(CARDwGetOFDMControlRate(
-							   (void *)priv,
+	s_vCalculateOFDMRParameter(CARDwGetOFDMControlRate((void *)priv,
 							   RATE_54M),
 				   bb_type,
 				   &byTxRate,
-- 
2.7.4

