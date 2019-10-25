Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3808CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB02A222BD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="CHlNbLzn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440344AbfJYMlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 08:41:36 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35993 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504491AbfJYMlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 08:41:21 -0400
Received: by mail-lj1-f194.google.com with SMTP id v24so2560487ljj.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 05:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=25nZvlQO3yC7IxomA1FSL3UVFhWXmdHyCH8gs+B5jDY=;
        b=CHlNbLznCLD+9QqB53UKVxFWZZx6+NuuoSSZ04+l9L/wWDzqpQDRs+hb/7KwGrnUKE
         DXwI+kb2gkU0u8cK+N+oOl6YK5aRBzeHmMaUTEpH2Fbpd/D4tunbyu1e5xE0bT7G1Jgs
         HXleEroGe7pXlS5k2YW9XUhmioLEBexahKruc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=25nZvlQO3yC7IxomA1FSL3UVFhWXmdHyCH8gs+B5jDY=;
        b=A/NyYbiHYx0uFrxrr9csobecVbL7BYCDY/Ew6Vjvl9rZ5mZwAxxvnA0NgJCAQ9v9FG
         rW0D81cryEXt+H3eWWPvGVPcBsX62YPs3qbPoheZIC9aeD+OAKg9ROUiRW7nHgqs/+MC
         SyvF9zfS5p6dbiTbAhXLjlCvzOZHPepT6dQjhz246tCzUy+nvgKG6Qok9Kwln3ILKj0C
         /6bDMvtyzKeC20fK81zthi3ddQrYyMAXkN6eLttNvkiuQHXiF7f+64OiEtW7+k3Kut3n
         OEkDSP+43YxwvKC+wb7diV/NZ3oiWL3zeab9cTb8LlkrNrYxcc9Kkm84lYVAYWx6fSmt
         ldUQ==
X-Gm-Message-State: APjAAAUw8vN0elWnmHOTx8jfK6KlQADcGNd/YncojMFIfQ0V34rezLgs
        CN48uU9KIYsASFK09q0WnI8kBg==
X-Google-Smtp-Source: APXvYqzyE18HLcIQwkmrc5Pv5A6HQWczyLJz1SK8xGVjYLYsbDkY9CpxwHjOUK4P61qt5TGlioKYvg==
X-Received: by 2002:a2e:89d3:: with SMTP id c19mr2340355ljk.201.1572007279184;
        Fri, 25 Oct 2019 05:41:19 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 10sm821028lfy.57.2019.10.25.05.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 05:41:18 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Valentin Longchamp <valentin.longchamp@keymile.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 13/23] soc: fsl: qe: remove pointless sysfs registration in qe_ic.c
Date:   Fri, 25 Oct 2019 14:40:48 +0200
Message-Id: <20191025124058.22580-14-linux@rasmusvillemoes.dk>
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

There's no point in registering with sysfs when that doesn't actually
allow any interaction with the device or driver (no uevents, no sysfs
files that provide information or allow configuration, no nothing).

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/qe_ic.c | 31 -------------------------------
 1 file changed, 31 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe_ic.c b/drivers/soc/fsl/qe/qe_ic.c
index 61a40e40f3ae..6bd6d6fb9696 100644
--- a/drivers/soc/fsl/qe/qe_ic.c
+++ b/drivers/soc/fsl/qe/qe_ic.c
@@ -604,34 +604,3 @@ int qe_ic_set_high_priority(unsigned int virq, unsigned int priority, int high)
 
 	return 0;
 }
-
-static struct bus_type qe_ic_subsys = {
-	.name = "qe_ic",
-	.dev_name = "qe_ic",
-};
-
-static struct device device_qe_ic = {
-	.id = 0,
-	.bus = &qe_ic_subsys,
-};
-
-static int __init init_qe_ic_sysfs(void)
-{
-	int rc;
-
-	printk(KERN_DEBUG "Registering qe_ic with sysfs...\n");
-
-	rc = subsys_system_register(&qe_ic_subsys, NULL);
-	if (rc) {
-		printk(KERN_ERR "Failed registering qe_ic sys class\n");
-		return -ENODEV;
-	}
-	rc = device_register(&device_qe_ic);
-	if (rc) {
-		printk(KERN_ERR "Failed registering qe_ic sys device\n");
-		return -ENODEV;
-	}
-	return 0;
-}
-
-subsys_initcall(init_qe_ic_sysfs);
-- 
2.23.0

