Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF55DC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 23:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A40CD262CB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 23:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uzoRuZew"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfE3XFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 19:05:35 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40435 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfE3XFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 19:05:34 -0400
Received: by mail-ed1-f65.google.com with SMTP id r18so10454143edo.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 16:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b+zhfp2mLlsmTcyYwU+vQigbmWTMuWSVH8iE+gThN3E=;
        b=uzoRuZewUCcPDQJlDJLxMrkdcO9Aba52CApN7ezu5FEu8il6Ypl5p1sa+8eVm6LtMj
         Yu10POMOgrkAqrPmT7QUAyRvhiXAwO8bLzwm1tZOudc/C0JQPrMcRZRtGig/drUVHbAX
         MkNE+3gBJKFBZOjcbjpzNZGG58qqaaCQrSuHsf3eApTeCS1aXKp06ve/ipfqmHwABj+F
         dDwB3kOlKVjVZP0aSkuVIt9u5zRk8AQ5r2aA+towfq8gOG6GUd1tv7U8WKtlt+UdesCT
         DvyLKMPVYNGiarm6R5lAu6g1jhugKPEnIcDW5/eenf5fqM9RkjrQOMvax7W3fH+QQ1DV
         4gmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b+zhfp2mLlsmTcyYwU+vQigbmWTMuWSVH8iE+gThN3E=;
        b=FpV/9/FYi7ILVI2zy7Jj0rFRuTBgvWlu6DQTCNjzovJIrJHGFhR1zG6fpuixyUMcLu
         T0N9+GpsSaSdihEhhjnmTjbQtj3zjxLBh0Oojgo3Vy4XvgTrqgxeGU1oPQJZjOVSMc4M
         w8zAThW4dTBaoGKecXspGZ8z+F7zu/AMlG9G8F6fmwW630mG7BYRjzBvCvaCOM7MFOU8
         P++JhyH4YbaECePjO8vEWCpwz48VgYAlEPkMkU9Ajjt575m/zqutR5qzKkhOlSz+kJHl
         JjSVFO/TYQgXl9yXvHV2Z15x/bla6sOAm44vrMpIhLjrOgDO2EHhveB3enkOBAWaV9jI
         5aBg==
X-Gm-Message-State: APjAAAWf60UVtQf9eqLmL5/OTN6OG1TUn5EJi59zwsfH4RHyV1MUkvhQ
        jwez20FAmRlGabQiiTu4kXI=
X-Google-Smtp-Source: APXvYqx0pj62s9zGLECnIgWhuj1iuXUDyZz2isnGsi4nXi1cuZnAhLZFR8m2Rmluxszy7LTgZwC63g==
X-Received: by 2002:aa7:c919:: with SMTP id b25mr7717655edt.274.1559257532618;
        Thu, 30 May 2019 16:05:32 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d22sm640338ejm.83.2019.05.30.16.05.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 16:05:31 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     marc.zyngier@arm.com, Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] arm64: smp: Include smp_plat.h from smp.h
Date:   Thu, 30 May 2019 16:05:17 -0700
Message-Id: <20190530230518.4334-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190530230518.4334-1-f.fainelli@gmail.com>
References: <20190530230518.4334-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most architectures provide the cpu_logical_map[] definition as part of
asm/smp.h, which is included by linux/smp.h. For irqchip drivers that
work across a variety of platforms (MIPS, ARM, ARM64, etc.), and making
use of cpu_logical_map[] this avoids making any architecture specific
include in those drivers.

smp_plat.h uses -EINVAL, so make sure that header file include
linux/errmo.h.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm64/include/asm/smp.h      | 1 +
 arch/arm64/include/asm/smp_plat.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index 18553f399e08..259135d07a75 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -37,6 +37,7 @@
 #ifndef __ASSEMBLY__
 
 #include <asm/percpu.h>
+#include <asm/smp_plat.h>
 
 #include <linux/threads.h>
 #include <linux/cpumask.h>
diff --git a/arch/arm64/include/asm/smp_plat.h b/arch/arm64/include/asm/smp_plat.h
index af58dcdefb21..eab572cff56c 100644
--- a/arch/arm64/include/asm/smp_plat.h
+++ b/arch/arm64/include/asm/smp_plat.h
@@ -20,6 +20,7 @@
 #define __ASM_SMP_PLAT_H
 
 #include <linux/cpumask.h>
+#include <linux/errno.h>
 
 #include <asm/types.h>
 
-- 
2.17.1

