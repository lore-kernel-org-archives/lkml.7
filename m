Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A2DCA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 12:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B24A21897
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 12:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="aJggUxwL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730851AbfKAMnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 08:43:03 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45692 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730833AbfKAMnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 08:43:00 -0400
Received: by mail-lf1-f67.google.com with SMTP id v8so7100502lfa.12
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 05:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gyqRKyTXLr3cbd727hzyVbLDXzQNlutZJPmZlRbflNM=;
        b=aJggUxwL9FLbxqyLFcy7mPAsdu7B5NE3B0CcDXY5Xq3/1jU1wpEbTBIRlA5TdkovvK
         YrBP1OnWco5wWah9kA7xb6Uul3pCywE5VSldtrcZOf0D9aO5FvHxB4ekLfnZtOcOgaQa
         KXg1qmuWEC/xejE1gjB3RPnrIhT61rNL3oNHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gyqRKyTXLr3cbd727hzyVbLDXzQNlutZJPmZlRbflNM=;
        b=GA577VYzlJ8UZeGaDU1mXLeG25Z9Qy8yxMjbHwSXeiJBounX8Wg3fkfAuJtyCcmUbr
         bnLlA/IH3JJ+iU360S8B4Ka8LM0eXjnV1U+GJrIoDFWP3EWT7vCmdEiMgGXQTu8llZLn
         T5f5lGm6pwUYn5299LOZUB6QyGZu9QSmS4XRwXa4p77XwcXv9A0e+tlkplz4e1UcU2PQ
         taNeHayKR56WLYOo0wf0xJUdMUmIxeE0pmNWD4+20+bEbSyZgT1M5G5msHoprdMowdDD
         TFKlnbtyLFETf9jpTlOnVIqAnHcMooqHkfiEUFyV/VzS2iN62PAFEDhTr1gaDeMcpQ54
         pRsw==
X-Gm-Message-State: APjAAAWSlCe2suERY6ZlYHdrT1hU/Gk28nDDn0NR6WtsE1DQet6Lgula
        qpVgR5cS6fFMXX1suLSzE0nlww==
X-Google-Smtp-Source: APXvYqy4fEEOS681BI9of8caQte+TOAv9T+4kQxBaUmvtiH4cO+gztE83kQOLok3stailVX2gSWAwA==
X-Received: by 2002:ac2:420a:: with SMTP id y10mr7037550lfh.65.1572612177646;
        Fri, 01 Nov 2019 05:42:57 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id o26sm2458540lfi.57.2019.11.01.05.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 05:42:57 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        netdev@vger.kernel.org
Subject: [PATCH v3 35/36] net/wan: make FSL_UCC_HDLC explicitly depend on PPC32
Date:   Fri,  1 Nov 2019 13:42:09 +0100
Message-Id: <20191101124210.14510-36-linux@rasmusvillemoes.dk>
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

Currently, FSL_UCC_HDLC depends on QUICC_ENGINE, which in turn depends
on PPC32. As preparation for removing the latter and thus allowing the
core QE code to be built for other architectures, make FSL_UCC_HDLC
explicitly depend on PPC32.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/net/wan/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wan/Kconfig b/drivers/net/wan/Kconfig
index dd1a147f2971..78785d790bcc 100644
--- a/drivers/net/wan/Kconfig
+++ b/drivers/net/wan/Kconfig
@@ -270,7 +270,7 @@ config FARSYNC
 config FSL_UCC_HDLC
 	tristate "Freescale QUICC Engine HDLC support"
 	depends on HDLC
-	depends on QUICC_ENGINE
+	depends on QUICC_ENGINE && PPC32
 	help
 	  Driver for Freescale QUICC Engine HDLC controller. The driver
 	  supports HDLC in NMSI and TDM mode.
-- 
2.23.0

