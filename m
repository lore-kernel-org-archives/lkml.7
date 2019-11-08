Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C438C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E662206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="JPiH6ZKd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731444AbfKHNC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 08:02:58 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38933 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730899AbfKHNC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 08:02:28 -0500
Received: by mail-lj1-f193.google.com with SMTP id p18so6131395ljc.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 05:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BB15j+OZLSCqmbjpw6Rixs0w7wUAu62j+M3Q47LEWSI=;
        b=JPiH6ZKd2ZnUmbFTOFb+zecHncuK5W1rGbGHK2U2HNNwnIhWkIOIPn3+7Ay7T0tzM1
         5EAegX18KxWev95bX7gOYwgvjHEidVs2vmnDI0xounVD1lgao9hp6JuWyqGGmyzDgY1m
         DdQZLrXfOdpXw03FSH6fnD3E4Vvj1RGWqOAVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BB15j+OZLSCqmbjpw6Rixs0w7wUAu62j+M3Q47LEWSI=;
        b=dhG3QH5sXo++mAR7uaitN6kgdoRH1MHbU2iuSlns2M1jR/U3UV1Ly55mWegnHh1JHj
         ROr0TfhOqHesc8B7GCuSLz4O+xGe+2KmyseqCmC0OsnwMW+KDle1vu5yfVxkDGKfl+fw
         BNfKfdsdMVFccxmUherICjkIu1IUxPrDyF9zMDyOVUr6nYRScLc/H/UxvDSCKwwMSbDj
         Lr3AF9DzqAfsK0tihU0rzsSaOrPU2JgMg8D9Ar/j30WIXTuAzk4sJhXcgEF+Yvgv6Xqw
         r/TdR1I8pbZfFufAm+ZElAEiAGk52tnVNA0LJNGx2zytG7v37ZtG7UTonsEQnsWK21Lz
         MeZw==
X-Gm-Message-State: APjAAAX4ZGhbDE3UVJigvZI83c0ZbemLR91TmgkrlOLyH00qI/6WKG9I
        q7DzwUPgT5noLZqoR3Aw7XS+Dw==
X-Google-Smtp-Source: APXvYqxJ5+E/xDqZwwVj1PKuG5R1Tse40MqtXo1j/SjaIDAjgO45IHqu0Kxn9Mf/lNqB6jnMlGV11g==
X-Received: by 2002:a2e:b5a2:: with SMTP id f2mr6613757ljn.108.1573218145233;
        Fri, 08 Nov 2019 05:02:25 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id d28sm2454725lfn.33.2019.11.08.05.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 05:02:24 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        netdev@vger.kernel.org
Subject: [PATCH v4 46/47] net: ethernet: freescale: make UCC_GETH explicitly depend on PPC32
Date:   Fri,  8 Nov 2019 14:01:22 +0100
Message-Id: <20191108130123.6839-47-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
References: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
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

