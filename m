Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37B3C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C466220823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="x0+dQKv9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbfCDKtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 05:49:23 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44832 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfCDKtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 05:49:20 -0500
Received: by mail-wr1-f65.google.com with SMTP id w2so4971126wrt.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 02:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/8HPvsAXCJNsQf+UHp2S6e/gJ74ZMMDr55DFvvFeYrc=;
        b=x0+dQKv9iSYij+TlYi4Xm84MJP9yRtYVoiAbTBnNST7MtNCxNJ0WWywAVT/zne2Q1K
         CBFSsb0Lcs1B6vfB7P2xSWRwyQQSnx0aBQm6NYs99AbutR3eYO57pK9ceEi29Ob8Z3lg
         ROAaodAhZh6B/yEQBIsC/bK18TjhLUTlWPYd99UauRJLQ8LSRiwWLkI59GbW0tyyWIGx
         vJtz0QjwNWrZGrmsq4DdMt2NJ7rq5SlK9Bd09txVwSto0SUjwaRCL/zWPE37qAMkm4/s
         0K/WrcV1koXCCURIFKfnhoFNFEz6/isnkFbPVyJ9bgJkfaWKeYyueVFAimxoSnTLt0Nz
         CAMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/8HPvsAXCJNsQf+UHp2S6e/gJ74ZMMDr55DFvvFeYrc=;
        b=MxJBP+mS0e2KWx8e8uqRDSBZET5S2aXNuVhfckrJ0oGA3nieC/IprJxDvsgLcExgep
         XPaGbdvq6GrLezOP3xWf3J7W2Pct+6Z9WCA46VBhtIdZFXUNTUNVXnDTO2Gs6NT2/PdV
         rvYR7uzjtxjDwGXCqr2XsIfwk36HcsM85FNNgHzQKSX/vQBJAgqyhC7y9/gTFy5Yl9XV
         hVBhRprgV7ZEj8+3iww8e1WbowFb5BOklo7E4+AMo4/R+BR/McRoelkDzKjpq6jIcNwo
         rczbFjDXYq8SrK/L4MwVvKwyZe4F3N4ZUqZPDMqxcUDTKpItJJZMtRlCWpo1+Q5q4Xlt
         vJ6w==
X-Gm-Message-State: APjAAAVEou7JlpI0fPoIVaP77xUKkYWZUVlwMIswUbM1pY88NFxKrDQ7
        Avf+fmmeuyjH6gr80KS7H9QUAg==
X-Google-Smtp-Source: APXvYqzvfjgtM7i0QLe/mmfTMiQLOPrziz7zgWS4BKlx0DReXb6R3H1+6a/616j5Wux9C4AnpyO0qg==
X-Received: by 2002:a5d:458b:: with SMTP id p11mr12510415wrq.22.1551696558203;
        Mon, 04 Mar 2019 02:49:18 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id f4sm5848804wrx.68.2019.03.04.02.49.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Mar 2019 02:49:17 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     p.zabel@pengutronix.de
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: reset: meson-g12a: Add missing USB2 PHY resets
Date:   Mon,  4 Mar 2019 11:49:16 +0100
Message-Id: <20190304104916.3937-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The G12A Documentation lacked these 2 reset lines, but they are present and
used for each USB 2 PHYs.

Add them to the dt-bindings for the upcoming USB support.

Fixes: dbfc54534dfc ("dt-bindings: reset: meson: add g12a bindings")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 include/dt-bindings/reset/amlogic,meson-g12a-reset.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/reset/amlogic,meson-g12a-reset.h b/include/dt-bindings/reset/amlogic,meson-g12a-reset.h
index 8063e8314eef..6d487c5eba2c 100644
--- a/include/dt-bindings/reset/amlogic,meson-g12a-reset.h
+++ b/include/dt-bindings/reset/amlogic,meson-g12a-reset.h
@@ -51,7 +51,10 @@
 #define RESET_SD_EMMC_A			44
 #define RESET_SD_EMMC_B			45
 #define RESET_SD_EMMC_C			46
-/*					47-60 */
+/*					47	*/
+#define RESET_USB_PHY20			48
+#define RESET_USB_PHY21			49
+/*					50-60	*/
 #define RESET_AUDIO_CODEC		61
 /*					62-63	*/
 /*	RESET2					*/
-- 
2.20.1

