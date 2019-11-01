Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E485CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 12:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 524032067D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 12:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="XtQv6hzC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730705AbfKAMoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 08:44:20 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38299 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730657AbfKAMma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 08:42:30 -0400
Received: by mail-lj1-f194.google.com with SMTP id y23so9721509ljc.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 05:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c6cX64DMSTf/KsycxtOgXNPxmcIGKLx/O+3SoX0LMUM=;
        b=XtQv6hzC1U+vzqZPXhtnK5wDiw0aTGiJYCEnTf65KPvrk4UY5M9sJwCqFKgiobocI/
         hAfxqoOu2Ima3hHsEMZqPsg7LwHpsm2+xBRM3tjXq5e+WJX0j4QjO1jL734LqJEs3nyo
         TixuIj9tTS9U2vmA6C9bXfo9jIjl0g0hcmZD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c6cX64DMSTf/KsycxtOgXNPxmcIGKLx/O+3SoX0LMUM=;
        b=W8+CtWSEa4Oh+ja/XfMK/9KVJDRIzRdtSgEIqGm5Je0954wAM4aKK6040ZgI1GM1rK
         7uzkdnHDaBL5Dnd5DOfGGlDcOS8s1uWwGuKKYD0e8B1x8qi8OaQeXDU3k1YPxGrhHT5w
         COYm7yh5ob33HCEMLcPl/cpyPXd5enK5rIhGH0naoDxrnvOIep9spYtO7U+UfwPVEBGU
         VrIX1XM8ZRz1TEZWv21HAxngHjsIkQOB50xftQB09/qkucp34TWjsKuJ4jLg9nXGCZ34
         JgyMVuaM3QBx749iROsBNQ0x4R1oGo3WYGKXfKnIuJxAH0dY2nsokif2oUb4OC0O5op9
         uucw==
X-Gm-Message-State: APjAAAUgMmQv4e0PCJWRToNTpwKYwvsXOTFnG6EFi6Hr5aTBRLmM/w3U
        W/XCh299QzI+W9YYMhAidviP4A==
X-Google-Smtp-Source: APXvYqzjbp/ByJUEKerNFbC/nOacfNTYZA/W3sWiOomBHxR5ClzLXNdj5H8XcCg9tYS2+f2kyz5z4g==
X-Received: by 2002:a05:651c:1103:: with SMTP id d3mr2524158ljo.159.1572612147787;
        Fri, 01 Nov 2019 05:42:27 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id o26sm2458540lfi.57.2019.11.01.05.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 05:42:27 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v3 10/36] soc: fsl: qe: remove pointless sysfs registration in qe_ic.c
Date:   Fri,  1 Nov 2019 13:41:44 +0100
Message-Id: <20191101124210.14510-11-linux@rasmusvillemoes.dk>
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

There's no point in registering with sysfs when that doesn't actually
allow any interaction with the device or driver (no uevents, no sysfs
files that provide information or allow configuration, no nothing).

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/qe_ic.c | 31 -------------------------------
 1 file changed, 31 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe_ic.c b/drivers/soc/fsl/qe/qe_ic.c
index 4b03060d8079..f170926ce4d1 100644
--- a/drivers/soc/fsl/qe/qe_ic.c
+++ b/drivers/soc/fsl/qe/qe_ic.c
@@ -474,34 +474,3 @@ int qe_ic_set_high_priority(unsigned int virq, unsigned int priority, int high)
 
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

