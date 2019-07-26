Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7E5C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0DF1229F3
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="paKnIlYr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfGZL2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 07:28:34 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34059 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfGZL2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 07:28:32 -0400
Received: by mail-lj1-f196.google.com with SMTP id p17so51157166ljg.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 04:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jDadNNbYe3LS8LmqydZtAt2j9BxdXP1ro/L0sTrXrfs=;
        b=paKnIlYrTB9mZ1q+76dYucQ2YrQhp3wT5CXmH8bfAUtG8Ql4NHvpKe5oC4CNcCfuUy
         LhtWrUFJNdVYGpkF8FAkY7jEfQ9udtzptzqJZNIydmpLUUW1xLSxXxJZjBb+bl/N4RBk
         9C8U5oYF6kMIpnUc5cnUKl9jvX+UXu6xtAK/jTWro0TccoYZ+5iroP6YQYJ3Ro4nt6IG
         U4x1w1BKn42uZv5A+hdpXdfvXGsgDG8CLAA+MvcqzIVauDAJDNLbBNZJqVX75sd/lmg8
         PUc7T/K9Kc4eN/Ip27nvK3h00kbo4dXNtDsHb7T6qPm9H0CHGmnv9TWnZ4Mzq/Z1L/nB
         CoDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jDadNNbYe3LS8LmqydZtAt2j9BxdXP1ro/L0sTrXrfs=;
        b=S8egWMxblzNtvAdHKywYkRIns5A5nMjOdenNFJBUSvD3Pxk9U7RPH7YLt18aSxjlsL
         ArrSXalAdAXeWwe+nsaQ/ZU1HG4KEJ1SXQ/P67A0R4hxNvx9E71CVIAWoQA2p/OlafjX
         4AskicmhIdZdwIe/eW10uTV5Z2q2FT66VGLJn+ORKiTOf37xU2E4Ksj0+dmETPQC0m8j
         dwtIDth2RxfnpqbJ1WvnpSLe5L3+cPaFIuFi0Ruzy1vChaPODtjWpUFQPMJhB0i8Rx5g
         DZonqIuGrdT/zDMBFJYwi47vTveMp96j8AN4Ero038gynUwyZEqGReFadeISU88dCB3/
         2Mzg==
X-Gm-Message-State: APjAAAUXG6P2ipBxP+6zWd64sbVN8/agTJEM63LZbvCyNzrAMyIUSaWb
        PsFfcKtquACk4f7QAcyRI4vdKw==
X-Google-Smtp-Source: APXvYqzxbrKUQRAM2nkEPFxwSxAymhpssFk1Sh8DZVjufCLoQmmDfw2qCBnAwWR3q8oP1z+HvndRlw==
X-Received: by 2002:a2e:9753:: with SMTP id f19mr48914253ljj.113.1564140511155;
        Fri, 26 Jul 2019 04:28:31 -0700 (PDT)
Received: from localhost (c-243c70d5.07-21-73746f28.bbcust.telenor.se. [213.112.60.36])
        by smtp.gmail.com with ESMTPSA id 72sm9964704ljj.104.2019.07.26.04.28.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 04:28:30 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] irqchip: gic-v3: Mark expected switch fall-through
Date:   Fri, 26 Jul 2019 13:28:26 +0200
Message-Id: <20190726112826.19825-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When fall-through warnings was enabled by default the following warning
was starting to show up:

In file included from ../arch/arm64/include/asm/cputype.h:132,
                 from ../arch/arm64/include/asm/cache.h:8,
                 from ../include/linux/cache.h:6,
                 from ../include/linux/printk.h:9,
                 from ../include/linux/kernel.h:15,
                 from ../include/linux/list.h:9,
                 from ../include/linux/kobject.h:19,
                 from ../include/linux/of.h:17,
                 from ../include/linux/irqdomain.h:35,
                 from ../include/linux/acpi.h:13,
                 from ../drivers/irqchip/irq-gic-v3.c:9:
../drivers/irqchip/irq-gic-v3.c: In function ‘gic_cpu_sys_reg_init’:
../arch/arm64/include/asm/sysreg.h:853:2: warning: this statement may fall
 through [-Wimplicit-fallthrough=]
  asm volatile(__msr_s(r, "%x0") : : "rZ" (__val));  \
  ^~~
../arch/arm64/include/asm/arch_gicv3.h:20:29: note: in expansion of macro ‘write_sysreg_s’
 #define write_gicreg(v, r)  write_sysreg_s(v, SYS_ ## r)
                             ^~~~~~~~~~~~~~
../drivers/irqchip/irq-gic-v3.c:773:4: note: in expansion of macro ‘write_gicreg’
    write_gicreg(0, ICC_AP0R2_EL1);
    ^~~~~~~~~~~~
../drivers/irqchip/irq-gic-v3.c:774:3: note: here
   case 6:
   ^~~~

Rework so that the compiler doesn't warn about fall-through.

Fixes: d93512ef0f0e ("Makefile: Globally enable fall-through warning")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/irqchip/irq-gic-v3.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 9bca4896fa6f..96d927f0f91a 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -771,8 +771,10 @@ static void gic_cpu_sys_reg_init(void)
 		case 7:
 			write_gicreg(0, ICC_AP0R3_EL1);
 			write_gicreg(0, ICC_AP0R2_EL1);
+		/* Fall through */
 		case 6:
 			write_gicreg(0, ICC_AP0R1_EL1);
+		/* Fall through */
 		case 5:
 		case 4:
 			write_gicreg(0, ICC_AP0R0_EL1);
@@ -786,8 +788,10 @@ static void gic_cpu_sys_reg_init(void)
 	case 7:
 		write_gicreg(0, ICC_AP1R3_EL1);
 		write_gicreg(0, ICC_AP1R2_EL1);
+		/* Fall through */
 	case 6:
 		write_gicreg(0, ICC_AP1R1_EL1);
+		/* Fall through */
 	case 5:
 	case 4:
 		write_gicreg(0, ICC_AP1R0_EL1);
-- 
2.20.1

