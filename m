Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25E9CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9623821D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Ak1M7QhB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504584AbfJYMmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 08:42:35 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35012 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504430AbfJYMlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 08:41:20 -0400
Received: by mail-lj1-f193.google.com with SMTP id m7so2562662lji.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 05:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y+kwl//SoVDAzocBexIsEmz66pzal0ckH4IWTjSFzkk=;
        b=Ak1M7QhBuyHZjE5WQ2jax0Lc1hG2C4sfAdA8o2GByl3nHQYZA8BrncbEkAdONHCS0K
         0pcVPUkKXKtO3vplL4HUoK+2O6ZIg1afec+LTJTSScE/uQt0Rb4aRuEoqjepyYkHyNgq
         kc+/m0Zlgg5E+KctsTCNhX6th/s6KvIRKvPRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y+kwl//SoVDAzocBexIsEmz66pzal0ckH4IWTjSFzkk=;
        b=ehHujH0Hq3beMiWjZqlIQ5Ykznd0EGfJ7T5DcomZdjQBNi9S5Pe9i/wWEP2z9GxXz8
         7Jd+zNpbpaHCo2KgPNxUIzPDyqCbLYgMZ3UjAIyfK3XIhHaa3cRzjl7OprFTlH/ybHhv
         amUqjnsErZRXETvUaZ2YvqL95FnpdOczX7zOeKulGTn3B9mMc8SsiXstKnl3POEY3vtB
         aXUGnxtgNWmPKRRadt4p14/mFbA+UXO0CagcxtQ68Y5bmSxvEjb9PGc65+cxBDTP4E7r
         pKpXaxjLcHEOyfTW2uSbF335LOmMCZ9QJSy+mo4INFqgIHW0DmgvSX+l0gZtl+ign+aI
         OLyA==
X-Gm-Message-State: APjAAAUTeyNWHnOL/6ZEsD2+wvLx8ecbrXBBa1zuS4OdRvEVObsa19sg
        sLKuiyb0/ZKUnEZRFX7caunYbw==
X-Google-Smtp-Source: APXvYqzli6SMC1Z8hQATuoEoXx1WkPPyEoLopU+HdkiAKE9p++1V643MYdrGXfcfqZbuCSF3Q8KXBw==
X-Received: by 2002:a2e:a0c9:: with SMTP id f9mr2381853ljm.77.1572007277982;
        Fri, 25 Oct 2019 05:41:17 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 10sm821028lfy.57.2019.10.25.05.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 05:41:17 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Valentin Longchamp <valentin.longchamp@keymile.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 12/23] soc: fsl: qe: drop assign-only high_active in qe_ic_init
Date:   Fri, 25 Oct 2019 14:40:47 +0200
Message-Id: <20191025124058.22580-13-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191025124058.22580-1-linux@rasmusvillemoes.dk>
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
 <20191025124058.22580-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

high_active is only assigned to but never used. Remove it.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/qe_ic.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe_ic.c b/drivers/soc/fsl/qe/qe_ic.c
index f3659c312e13..61a40e40f3ae 100644
--- a/drivers/soc/fsl/qe/qe_ic.c
+++ b/drivers/soc/fsl/qe/qe_ic.c
@@ -450,7 +450,7 @@ void __init qe_ic_init(struct device_node *node, unsigned int flags,
 {
 	struct qe_ic *qe_ic;
 	struct resource res;
-	u32 temp = 0, ret, high_active = 0;
+	u32 temp = 0, ret;
 
 	ret = of_address_to_resource(node, 0, &res);
 	if (ret)
@@ -496,10 +496,8 @@ void __init qe_ic_init(struct device_node *node, unsigned int flags,
 		temp |= CICR_GRTB;
 
 	/* choose destination signal for highest priority interrupt */
-	if (flags & QE_IC_HIGH_SIGNAL) {
+	if (flags & QE_IC_HIGH_SIGNAL)
 		temp |= (SIGNAL_HIGH << CICR_HPIT_SHIFT);
-		high_active = 1;
-	}
 
 	qe_ic_write(qe_ic->regs, QEIC_CICR, temp);
 
-- 
2.23.0

