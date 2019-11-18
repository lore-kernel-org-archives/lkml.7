Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F83EC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1492D2068D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="KjmkIq+x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbfKRLYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 06:24:40 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36731 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbfKRLYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 06:24:35 -0500
Received: by mail-wm1-f65.google.com with SMTP id c22so18351179wmd.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 03:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iA65MKMzLkvpbCJtw1dgfKRTfY/LMh1lX20RtWmEnL4=;
        b=KjmkIq+xQGH3odHbzh8WQ29uNzIeULjrmnEIUn6rJk6d3kPG3Yrdormidcf9MOozuP
         jJjPm4aVw6O7o5m4NM6A/QynyvvjsztfxnHyuBalLbiFxT2tEkouhimouboIfT9wG8Rx
         D3uUNCrpcumEIR0nRoTJWxEdlKOyT4vTPdS3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iA65MKMzLkvpbCJtw1dgfKRTfY/LMh1lX20RtWmEnL4=;
        b=PjYEavNyvtaAG0J+7sjvfQu3SZfcsck0LYFR/LuCf1mq8Q12bs+tGPOQ1pEdGfaQJv
         Jt25CrYr7cgLg5NXzK9ygXT56zhDNbCtaBi+xGB6o1nfy8eKqGW4hfYMmbBz04BLbLjB
         kxGWgKRj5s2ZheKrbFvlEZ1MRDMqBY8pbWzSw1ncNh0WAMvoVZfXaSWwZVQAj0SoUC/f
         uKL8wD8VRZ7XMXzw89VbvJ1o1pug1c+QgVrs8uIJDwAfw6bD1w/vfNI+QLuie0kITwcR
         G5P6bRCbm/kFCg7ZtMhk79+GDFHHC6O/86l3nzl1GUA4kmM+Fp5ta3V2cb8ZIFelaSK5
         Illg==
X-Gm-Message-State: APjAAAUxCxm0rqB5m3nYIkpbW1TwBI6KHut1EQKjZFHEoL19AyV62wY/
        fDuJKaHoa3jVANqYfdjaYwcITg==
X-Google-Smtp-Source: APXvYqymuTf1eyZnezM6aM+hof+hm0Vr9Bfgz8sSkP7x97G19etwlRYffVBDTcw2EHmGvdaGH++2sg==
X-Received: by 2002:a1c:2e0f:: with SMTP id u15mr28930458wmu.47.1574076273195;
        Mon, 18 Nov 2019 03:24:33 -0800 (PST)
Received: from prevas-ravi.prevas.se (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id y2sm21140815wmy.2.2019.11.18.03.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 03:24:32 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        netdev@vger.kernel.org
Subject: [PATCH v5 47/48] net: ethernet: freescale: make UCC_GETH explicitly depend on PPC32
Date:   Mon, 18 Nov 2019 12:23:23 +0100
Message-Id: <20191118112324.22725-48-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
References: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
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

