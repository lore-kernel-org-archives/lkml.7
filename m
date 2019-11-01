Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C192CCA9ED1
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 12:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 993F721897
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 12:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Q7l5B4Zz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730878AbfKAMnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 08:43:12 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38625 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730822AbfKAMm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 08:42:58 -0400
Received: by mail-lf1-f65.google.com with SMTP id q28so7153506lfa.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 05:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BB15j+OZLSCqmbjpw6Rixs0w7wUAu62j+M3Q47LEWSI=;
        b=Q7l5B4ZzSFqdTZCb4tJtnGHQpMhdr2CvGmwTVybZhIGX2c4ktEn1SU46jLKTynP5c6
         xws5ATktOjO0yGARdh9e3ppAPSG4uIhGXWJLJb9bFFD7aZJ2kIdOQ/z6ktB1D335VRc0
         X76ZLrmMFUG8IjfB808JNyn/6kr5P9fM6Yovc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BB15j+OZLSCqmbjpw6Rixs0w7wUAu62j+M3Q47LEWSI=;
        b=h9DL8wkmmkvZCAS2Vjwi9vGk8u7PjiKisqbvk32wHS9+NLDi2Lf/A2ptgVnAVGnghL
         Gs8xWpnZLfHXs2OC0pGOZDeZArt9D4KgxxGRnFxe+rFngoLPbAwL85B/Q1fQgcAg42Ky
         eriA0/y7tu4C4iSmgQq6E5k+4E1z+BfH5wsbHE3O/jskUGRLIjsvZiO+SLodSdboA4b9
         yPkhA6s0yXzsoMxIbe6W4au6ftXjISx5cN6jdPkTVO0AN6OdKytwPCJIzq45+cDSzHGX
         +dgzNeghLYDFN9FTuEINEFZejM20KMbhzOg2UIgcb3vfHiU/YFnMfv6hCMH+iDPqSgOV
         JtHQ==
X-Gm-Message-State: APjAAAUXkjI9vDl7tCxTn99BVAsDqRk0cbxJ8aCoFP6kP2mdk6h17/oG
        56v/yF6+O5odRrDfeNpn91fL5w==
X-Google-Smtp-Source: APXvYqxCElUjbfpW6EePME6G+/EpoG3cuPhRw39POP0u7K0TVGS1unxGXbHxq4fCys0zyQmGeY2RWg==
X-Received: by 2002:a19:10:: with SMTP id 16mr7317366lfa.100.1572612176600;
        Fri, 01 Nov 2019 05:42:56 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id o26sm2458540lfi.57.2019.11.01.05.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 05:42:56 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        netdev@vger.kernel.org
Subject: [PATCH v3 34/36] net: ethernet: freescale: make UCC_GETH explicitly depend on PPC32
Date:   Fri,  1 Nov 2019 13:42:08 +0100
Message-Id: <20191101124210.14510-35-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191101124210.14510-1-linux@rasmusvillemoes.dk>
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
 <20191101124210.14510-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, QUICC_ENGINE depends on PPC32, so this in itself does not
change anything. In order to allow removing the PPC32 dependency from
QUICC_ENGINE and avoid allmodconfig build failures, add this explicit
dependency.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/net/ethernet/freescale/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/Kconfig b/drivers/net/ethernet/freescale/Kconfig
index 6a7e8993119f..2bd7ace0a953 100644
--- a/drivers/net/ethernet/freescale/Kconfig
+++ b/drivers/net/ethernet/freescale/Kconfig
@@ -74,7 +74,7 @@ config FSL_XGMAC_MDIO
 
 config UCC_GETH
 	tristate "Freescale QE Gigabit Ethernet"
-	depends on QUICC_ENGINE
+	depends on QUICC_ENGINE && PPC32
 	select FSL_PQ_MDIO
 	select PHYLIB
 	---help---
-- 
2.23.0

