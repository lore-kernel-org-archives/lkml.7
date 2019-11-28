Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2772BC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFC1E21771
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Fm9J/BPt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfK1O6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 09:58:33 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45892 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbfK1O6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 09:58:08 -0500
Received: by mail-lj1-f195.google.com with SMTP id n21so28799723ljg.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 06:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uJFqdfn2nSDjHf42hirywvV4nKXCcu5QZEHn2MRQUqE=;
        b=Fm9J/BPtzefO6mLtz+s8hghaGLQl9/e0iHtM+c2WZUylSQ5IRCuZvLLrqa9pvESajc
         sgUXiAdEW5ODvwgf/p7K3+6ps2qo4ojoUJEOeaW4+cvwZGzSxZUYdES0IEMWB57Deuf4
         xjUml1c0Urakd08HfwFSCPyXLT1jfJ5CE/vuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uJFqdfn2nSDjHf42hirywvV4nKXCcu5QZEHn2MRQUqE=;
        b=XcZSH7Vz6ciGo2vQnU1PP0od2PuyE71HMLHq9Fmh/M5K8o+AIylRFlsZs6oif4zaE7
         LTQcxjg2zlmnKKMu4WRQmOvq2EDBjXm9bv3//1xqWZL0LnLzSPU8O0IfbcAegf6uYDgD
         m/5M8TDjr5xhk83QYULapHnPmwh0R2wCh3EDpAiL69u0PyZgi7MlRcyoHd6UvV/FKZpy
         aPzfm816t8GEneL2S6pwEQIwz7ickONXg1NyB3PQNUKNxjPQ92rmxNRMvl22nieEQLYj
         fzabZ0YLVV1k3XtE+ekcJCYtQ+XOqeQftt9SQjpQRpW3iI8wZBsdS/7XtKT+d5i/0lZT
         bLXA==
X-Gm-Message-State: APjAAAXcBTKJMUlVtFdMQcuffk+LFlJDsd6pfN0oDB/1c250zK7ISz/6
        EGz02BSeuTr3uA4rlz5WSUVdbQ==
X-Google-Smtp-Source: APXvYqyvULz2Tjp/CvI4s3FOQVWvQSzO1JW8WbB25Ky4p0+qkSxEH1U0IiPoAs0MVz6PY4HNawn0gg==
X-Received: by 2002:a2e:90da:: with SMTP id o26mr1140714ljg.25.1574953085644;
        Thu, 28 Nov 2019 06:58:05 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id u2sm2456803lfl.18.2019.11.28.06.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 06:58:05 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        netdev@vger.kernel.org
Subject: [PATCH v6 47/49] net: ethernet: freescale: make UCC_GETH explicitly depend on PPC32
Date:   Thu, 28 Nov 2019 15:55:52 +0100
Message-Id: <20191128145554.1297-48-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
References: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
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

Also, the QE Ethernet has never been integrated on any non-PowerPC SoC
and most likely will not be in the future.

Reviewed-by: Timur Tabi <timur@kernel.org>
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

