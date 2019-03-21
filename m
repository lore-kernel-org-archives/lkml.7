Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A38EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 190A1218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="QLPV5EyF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbfCUOKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 10:10:21 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34563 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728346AbfCUOKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 10:10:18 -0400
Received: by mail-wm1-f65.google.com with SMTP id o10so2131239wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 07:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Ep/9wE+P/naMBN31BGQ2oBAcO627wlPpUiNIIkI8AI=;
        b=QLPV5EyFTEUMO2j3fSjpFFAjrSGilXu2fqCPGQUh+Gs3fqWW+DTntGKMjrg9W5q9i1
         DgG+sAYd5IxnSAjwod5chERTmuLsCjdgubx9WHHnuEdTIRdRDkPDqIi9WNhn6QIJWXNJ
         kYE7iScVz9M0KGB8XGjjzoeTHKKrTus9D+oupP/5xsgkMgD4Wb1jNhjIvF8rqptYDagp
         DsWuzpfKhq+l8C9PeoLDOkP9ON+HYBIGg4lM8PAWkgNI3foc4ucXxQvtV5swna1qxOvL
         Zh9mtOAXjb1qPkRTkWNlYes8kZ0ZPU6De/hE/NoAmWsw2rt2f5MBWwBmFGLefmp69uEB
         dl2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Ep/9wE+P/naMBN31BGQ2oBAcO627wlPpUiNIIkI8AI=;
        b=e4V7tlTE7+clc4Ec4/1KyZ1mtzhRl0ivi7+hnI4yJtqTxAi3X7yLqBIXEc3dxXaLFd
         n65MmjKI7mxLPse+84LWrxQTYZEAN6uTwjo6fgC0C3OjIici5QAMYO9O76ZqdLLrqrg8
         2/qHWbkWNb77ey2WnK7AALOl5VadBKtT6SMjkPkY3D/iVtrYcLDULCgMRyFq1OfYubRM
         Y1KPZK0LZFb1uRrJwUiaBIIClm3jPp8B3mA5/jEvFlzwOcfNuJA/Td8LNYP8GWU1Twg9
         mP20ZdW1i8tNpc7Yt9OeR8Ew6zZZyC/JVkLFiDHNimpv8TEx7M0ANl0IrFo2y7GucLWk
         tDbA==
X-Gm-Message-State: APjAAAU8kAraaazgpyXeMmrzKZN2Dyv1qqgPad1Mhdue0pNyawnQDrsL
        Lv4AEXkyfLOqVUJKGTmGusscrA==
X-Google-Smtp-Source: APXvYqxkh7EohtGxFt6SumlIko9dmyA276cexLPo6Mz51jmyRuuJqPhtnno/WLmilBMjI0VYNRcIUQ==
X-Received: by 2002:a1c:9684:: with SMTP id y126mr2745111wmd.124.1553177416688;
        Thu, 21 Mar 2019 07:10:16 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-20-74.w90-86.abo.wanadoo.fr. [90.86.223.74])
        by smtp.gmail.com with ESMTPSA id z14sm7513921wrv.78.2019.03.21.07.10.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 07:10:16 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 1/4] ARM: davinci: fix cpufreq registration on da850-evm
Date:   Thu, 21 Mar 2019 15:10:07 +0100
Message-Id: <20190321141010.19612-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190321141010.19612-1-brgl@bgdev.pl>
References: <20190321141010.19612-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The system_rev variable is never set on davinci and is always 0, so
we're using the default max operating point of 300MHz. The cvdd supply
is fixed at 1.2V however, so we can go up to 372MHz. Remove the switch
and always set da850_max_speed to 372000.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-da850-evm.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 1fdc9283a8c5..77d74fb311fa 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -1155,17 +1155,7 @@ static struct edma_rsv_info *da850_edma_rsv[2] = {
 #ifdef CONFIG_CPU_FREQ
 static __init int da850_evm_init_cpufreq(void)
 {
-	switch (system_rev & 0xF) {
-	case 3:
-		da850_max_speed = 456000;
-		break;
-	case 2:
-		da850_max_speed = 408000;
-		break;
-	case 1:
-		da850_max_speed = 372000;
-		break;
-	}
+	da850_max_speed = 372000;
 
 	return da850_register_cpufreq("pll0_sysclk3");
 }
-- 
2.20.1

