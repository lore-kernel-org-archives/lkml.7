Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C8DC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 09:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 645B020692
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 09:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="BQF46w0R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfKUJZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 04:25:22 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45966 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfKUJZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 04:25:21 -0500
Received: by mail-lj1-f195.google.com with SMTP id n21so2345666ljg.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 01:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A8TNMtKysU8OhPZLPcM8qBUTWWfHEoNwu7bf36UMtpE=;
        b=BQF46w0R7bKeo8aGuiJhk8yd7hcIFPifuqrbWwLFEM+H9Yduy9FYqJqaQY+n7WUnr2
         BeKreIFKdGXCm0+9ADQBjIUhS1LgQYWGpwuymfb2yM1fL/4CWR9gCinIVz1V3EWkf9UX
         nrhSgrB6qcfu6Qvarw/bNpX/EFXjkkmpPjCNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A8TNMtKysU8OhPZLPcM8qBUTWWfHEoNwu7bf36UMtpE=;
        b=nXtqTwvoQXIvtTbSr2vqhoMNPFWZ8vlNQEdw2x2hmObuf8MYb+Nip5Jztew4gL6bZR
         pfC1Ejy3eWkv5VeDn4gNlWmcW2dVWW6miCChUafV9Xd/rMaSpx08N5A7APf3CkbL5qpE
         rFGXsUOvK7fiquihMyaNmzIhzIAX2ixfUF8hJ4vh4MeEambpHMhUqnDVyFYhDDHMpCfW
         RWpWdXsjQxh02W1TCh+hYgMdIuHOeqqu0Q7sIoRHorC4t0tECuwp3yZoCwJhbIwAierl
         4lYCSCAVs95unPL9OWD+/K7+X6KMFT839NgRTWyOC/beJ91z4ZAnc+sqoaH0qKzhwzrj
         SYFQ==
X-Gm-Message-State: APjAAAW3BwNWMqkT3ddUyyk+uM2+6gecg+IFnakY0hMnlNUsjtjTdZ6c
        EUKE07pn794ZBL//HPrfGJroCg==
X-Google-Smtp-Source: APXvYqxU4JX0Lg3kpsOZ/sjcMhY6/3D7Q/uMmzY0TOSCqFe5D3VN1zYpFj3qRhe87kzoQQajoEJgOQ==
X-Received: by 2002:a2e:93d7:: with SMTP id p23mr6455581ljh.102.1574328319727;
        Thu, 21 Nov 2019 01:25:19 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id y18sm924730lja.12.2019.11.21.01.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 01:25:19 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Li Yang <leoyang.li@nxp.com>, Marc Zyngier <maz@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        kbuild test robot <lkp@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm: avoid cpumask_t typedef in arch_trigger_cpumask_backtrace
Date:   Thu, 21 Nov 2019 10:25:16 +0100
Message-Id: <20191121092516.9041-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was trying to enable a previously PPC-only driver for ARM. That
driver happens to include asm/irq.h without some previous header
recursively pulling in linux/cpumask.h, resulting in kbuild kindly
informing me [1]

   In file included from drivers/soc/fsl/qe/ucc.c:18:0:
>> arch/arm/include/asm/irq.h:34:50: error: unknown type name 'cpumask_t'
    extern void arch_trigger_cpumask_backtrace(const cpumask_t *mask,

Instead of including linux/cpumask.h from asm/irq.h just for the
cpumask_t typedef, use the spelling "struct cpumask" and add a
forward declaration of that. For consistency, update the definition of
the function accordingly.

No functional change.

[1] https://lore.kernel.org/lkml/201911210258.dfd8HF9z%25lkp@intel.com/

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
We're past -rc8, so I probably can't hope for this to make it into
5.4. However, it currently blocks a rather large series of mine from
being picked up and getting time in -next. Would it be ok with the ARM
maintainers if I ask Li Yang to carry this as part of that large
series?

 arch/arm/include/asm/irq.h | 3 ++-
 arch/arm/kernel/smp.c      | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/irq.h b/arch/arm/include/asm/irq.h
index 46d41140df27..d8deb81bc8ce 100644
--- a/arch/arm/include/asm/irq.h
+++ b/arch/arm/include/asm/irq.h
@@ -31,7 +31,8 @@ void handle_IRQ(unsigned int, struct pt_regs *);
 void init_IRQ(void);
 
 #ifdef CONFIG_SMP
-extern void arch_trigger_cpumask_backtrace(const cpumask_t *mask,
+struct cpumask;
+extern void arch_trigger_cpumask_backtrace(const struct cpumask *mask,
 					   bool exclude_self);
 #define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
 #endif
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 4b0bab2607e4..b096200c7436 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -806,7 +806,8 @@ static void raise_nmi(cpumask_t *mask)
 	__smp_cross_call(mask, IPI_CPU_BACKTRACE);
 }
 
-void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
+void arch_trigger_cpumask_backtrace(const struct cpumask *mask,
+				    bool exclude_self)
 {
 	nmi_trigger_cpumask_backtrace(mask, exclude_self, raise_nmi);
 }
-- 
2.23.0

