Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69835C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 00:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38988216C8
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 00:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfG2AL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 20:11:27 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44651 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbfG2AL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 20:11:27 -0400
Received: by mail-wr1-f68.google.com with SMTP id p17so59827223wrf.11
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 17:11:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VA4nO4VREXkp8GYoBYLdJmNPFBFhMx5Fwe9xzhsD62A=;
        b=PhhB9+drCP9XxGFoqQN9KxudjfF79AIV8FJxeV6nmajYnCbC6kQy/02yDrvBQZU/Mt
         e/li4iA9jG5mnOgMHG8CvTPqsiRMniCrWVFZZQpbJXsp94zG4/RHQi0jiEZjHKdaa0p3
         7+Fo5DjwyZpo2B44YvnbKhKFJQhz4v7dBjRaQU6ZUe9Xs3fuQH9z70DOS0Jb7G2Bum/y
         rDXBy3Cy/4VVqxEDcreh30M7B280rPwEnK9nb5qSGN2wzOTmwh5DH+OaaSo14dATxyPv
         UDBjehBwlaMPT1Z02sEmiovnEuX3RpWdbBfDE+RHCNjspFfN9vNnPJ/G4yq9K2p0vtH6
         rSgg==
X-Gm-Message-State: APjAAAV6UlfpdGO5Fp+jz4gxxl4Pst+wBfXikt8HA5G1+sUy1LBWbA29
        QD8/C15j8rc/6PBshpBAVayKgI/Rj2M+JQ==
X-Google-Smtp-Source: APXvYqxlCPZOCQaX9cCmhJ0AWaUNs3g8toqFhmMxgNhHERKGyTHjZiEBPP1KLVxjF6QUZJbRWiqupQ==
X-Received: by 2002:adf:eec4:: with SMTP id a4mr108237314wrp.85.1564359085228;
        Sun, 28 Jul 2019 17:11:25 -0700 (PDT)
Received: from mcroce-redhat.homenet.telecomitalia.it (host221-208-dynamic.27-79-r.retail.telecomitalia.it. [79.27.208.221])
        by smtp.gmail.com with ESMTPSA id o20sm154140692wrh.8.2019.07.28.17.11.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 28 Jul 2019 17:11:24 -0700 (PDT)
From:   Matteo Croce <mcroce@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH] irqchip/gic-v3: mark expected switch fall-through
Date:   Mon, 29 Jul 2019 02:11:19 +0200
Message-Id: <20190729001119.2478-1-mcroce@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark switch cases where we are expecting to fall through,
fixes the following warnings:

drivers/irqchip/irq-gic-v3.c: In function ‘gic_cpu_sys_reg_init’:
./arch/arm64/include/asm/sysreg.h:853:2: warning: this statement may fall through [-Wimplicit-fallthrough=]
  asm volatile(__msr_s(r, "%x0") : : "rZ" (__val));  \
  ^~~
./arch/arm64/include/asm/arch_gicv3.h:20:29: note: in expansion of macro ‘write_sysreg_s’
 #define write_gicreg(v, r)  write_sysreg_s(v, SYS_ ## r)
                             ^~~~~~~~~~~~~~
drivers/irqchip/irq-gic-v3.c:773:4: note: in expansion of macro ‘write_gicreg’
    write_gicreg(0, ICC_AP0R2_EL1);
    ^~~~~~~~~~~~
drivers/irqchip/irq-gic-v3.c:774:3: note: here
   case 6:
   ^~~~

drivers/irqchip/irq-gic-v3.c:788:3: note: in expansion of macro ‘write_gicreg’
   write_gicreg(0, ICC_AP1R2_EL1);
   ^~~~~~~~~~~~
  CC      net/ipv4/af_inet.o
drivers/irqchip/irq-gic-v3.c:789:2: note: here
  case 6:
  ^~~~

./arch/arm64/include/asm/arch_gicv3.h:20:29: note: in expansion of macro ‘write_sysreg_s’
 #define write_gicreg(v, r)  write_sysreg_s(v, SYS_ ## r)
                             ^~~~~~~~~~~~~~
drivers/irqchip/irq-gic-v3.c:790:3: note: in expansion of macro ‘write_gicreg’
   write_gicreg(0, ICC_AP1R1_EL1);
   ^~~~~~~~~~~~
drivers/irqchip/irq-gic-v3.c:791:2: note: here
  case 5:
  ^~~~

Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 drivers/irqchip/irq-gic-v3.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 9bca4896fa6f..4a5d220698f6 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -771,8 +771,10 @@ static void gic_cpu_sys_reg_init(void)
 		case 7:
 			write_gicreg(0, ICC_AP0R3_EL1);
 			write_gicreg(0, ICC_AP0R2_EL1);
+			/* fallthrough */
 		case 6:
 			write_gicreg(0, ICC_AP0R1_EL1);
+			/* fallthrough */
 		case 5:
 		case 4:
 			write_gicreg(0, ICC_AP0R0_EL1);
@@ -786,8 +788,10 @@ static void gic_cpu_sys_reg_init(void)
 	case 7:
 		write_gicreg(0, ICC_AP1R3_EL1);
 		write_gicreg(0, ICC_AP1R2_EL1);
+		/* fallthrough */
 	case 6:
 		write_gicreg(0, ICC_AP1R1_EL1);
+		/* fallthrough */
 	case 5:
 	case 4:
 		write_gicreg(0, ICC_AP1R0_EL1);
-- 
2.21.0

