Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8C3C7618F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 22:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B70D32075B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 22:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfG1WxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 18:53:20 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36885 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfG1WxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 18:53:20 -0400
Received: by mail-wr1-f68.google.com with SMTP id n9so34664070wrr.4
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 15:53:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ftGcDLnR4imQmQ+UkOat+KWbwwjELLyC+CYKk4KZ2MI=;
        b=XGWebNwpY0Pi7CDyTQHuAymLs97b1/inxqms4boNNk/a0WHFHZRU9xIhLW3L/EC5SD
         qflqeJR+NA01y57TLWb+5fPke89vqsPIyqfZMS1uK8qylfshZS/rWwnVO2MP6Xt90rIG
         72alzLlEVfiNI0GvcIcuXph7fmbNdomyqx0cLIx2qEtugXdSLtNGihqbgABI4QikJalP
         p30vtj6K57+gecCz5QKINbVyTBgdq30xuOtSmrjf1PBZtwBWEiJ6hz2Hrl3zZB2nglqE
         v0mkVccgNv2HMTiktUkBLb1LrPENWcPXZil+Ud8Ck1uJf0JvQw1Bl18uVZ4EdO+OZ7HD
         uxjw==
X-Gm-Message-State: APjAAAWnmtKgG860DKtZNz+ZzhBu0/gfwl8GlL4L8WQiCE4Hdh0tdQae
        tcU8jJKg0u7C0uCBAGG4jSzc+fQXm5c=
X-Google-Smtp-Source: APXvYqzXz/uRYLBkINGQsD6hev7BbnvXZn0rdIH9tudJoRoTw/rjgcK0VY1Im/N583+KNY1tUym6uQ==
X-Received: by 2002:a5d:4212:: with SMTP id n18mr112558387wrq.261.1564354397866;
        Sun, 28 Jul 2019 15:53:17 -0700 (PDT)
Received: from mcroce-redhat.homenet.telecomitalia.it (host221-208-dynamic.27-79-r.retail.telecomitalia.it. [79.27.208.221])
        by smtp.gmail.com with ESMTPSA id q193sm45278109wme.8.2019.07.28.15.53.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 28 Jul 2019 15:53:17 -0700 (PDT)
From:   Matteo Croce <mcroce@redhat.com>
To:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Cc:     Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: arm64: mark expected switch fall-through
Date:   Mon, 29 Jul 2019 00:53:11 +0200
Message-Id: <20190728225311.5414-1-mcroce@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark switch cases where we are expecting to fall through,
fixes the following warning:

In file included from ./arch/arm64/include/asm/kvm_emulate.h:19,
                 from arch/arm64/kvm/regmap.c:13:
arch/arm64/kvm/regmap.c: In function ‘vcpu_write_spsr32’:
./arch/arm64/include/asm/kvm_hyp.h:31:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
   asm volatile(ALTERNATIVE(__msr_s(r##nvh, "%x0"), \
   ^~~
./arch/arm64/include/asm/kvm_hyp.h:46:31: note: in expansion of macro ‘write_sysreg_elx’
 #define write_sysreg_el1(v,r) write_sysreg_elx(v, r, _EL1, _EL12)
                               ^~~~~~~~~~~~~~~~
arch/arm64/kvm/regmap.c:180:3: note: in expansion of macro ‘write_sysreg_el1’
   write_sysreg_el1(v, SYS_SPSR);
   ^~~~~~~~~~~~~~~~
arch/arm64/kvm/regmap.c:181:2: note: here
  case KVM_SPSR_ABT:
  ^~~~
In file included from ./arch/arm64/include/asm/cputype.h:132,
                 from ./arch/arm64/include/asm/cache.h:8,
                 from ./include/linux/cache.h:6,
                 from ./include/linux/printk.h:9,
                 from ./include/linux/kernel.h:15,
                 from ./include/asm-generic/bug.h:18,
                 from ./arch/arm64/include/asm/bug.h:26,
                 from ./include/linux/bug.h:5,
                 from ./include/linux/mmdebug.h:5,
                 from ./include/linux/mm.h:9,
                 from arch/arm64/kvm/regmap.c:11:
./arch/arm64/include/asm/sysreg.h:837:2: warning: this statement may fall through [-Wimplicit-fallthrough=]
  asm volatile("msr " __stringify(r) ", %x0"  \
  ^~~
arch/arm64/kvm/regmap.c:182:3: note: in expansion of macro ‘write_sysreg’
   write_sysreg(v, spsr_abt);
   ^~~~~~~~~~~~
arch/arm64/kvm/regmap.c:183:2: note: here
  case KVM_SPSR_UND:
  ^~~~
In file included from ./arch/arm64/include/asm/cputype.h:132,
                 from ./arch/arm64/include/asm/cache.h:8,
                 from ./include/linux/cache.h:6,
                 from ./include/linux/printk.h:9,
                 from ./include/linux/kernel.h:15,
                 from ./include/asm-generic/bug.h:18,
                 from ./arch/arm64/include/asm/bug.h:26,
                 from ./include/linux/bug.h:5,
                 from ./include/linux/mmdebug.h:5,
                 from ./include/linux/mm.h:9,
                 from arch/arm64/kvm/regmap.c:11:
./arch/arm64/include/asm/sysreg.h:837:2: warning: this statement may fall through [-Wimplicit-fallthrough=]
  asm volatile("msr " __stringify(r) ", %x0"  \
  ^~~
arch/arm64/kvm/regmap.c:184:3: note: in expansion of macro ‘write_sysreg’
   write_sysreg(v, spsr_und);
   ^~~~~~~~~~~~
arch/arm64/kvm/regmap.c:185:2: note: here
  case KVM_SPSR_IRQ:
  ^~~~
In file included from ./arch/arm64/include/asm/cputype.h:132,
                 from ./arch/arm64/include/asm/cache.h:8,
                 from ./include/linux/cache.h:6,
                 from ./include/linux/printk.h:9,
                 from ./include/linux/kernel.h:15,
                 from ./include/asm-generic/bug.h:18,
                 from ./arch/arm64/include/asm/bug.h:26,
                 from ./include/linux/bug.h:5,
                 from ./include/linux/mmdebug.h:5,
                 from ./include/linux/mm.h:9,
                 from arch/arm64/kvm/regmap.c:11:
./arch/arm64/include/asm/sysreg.h:837:2: warning: this statement may fall through [-Wimplicit-fallthrough=]
  asm volatile("msr " __stringify(r) ", %x0"  \
  ^~~
arch/arm64/kvm/regmap.c:186:3: note: in expansion of macro ‘write_sysreg’
   write_sysreg(v, spsr_irq);
   ^~~~~~~~~~~~
arch/arm64/kvm/regmap.c:187:2: note: here
  case KVM_SPSR_FIQ:
  ^~~~

Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 arch/arm64/kvm/regmap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/kvm/regmap.c b/arch/arm64/kvm/regmap.c
index 0d60e4f0af66..b376b2fdbf51 100644
--- a/arch/arm64/kvm/regmap.c
+++ b/arch/arm64/kvm/regmap.c
@@ -178,12 +178,16 @@ void vcpu_write_spsr32(struct kvm_vcpu *vcpu, unsigned long v)
 	switch (spsr_idx) {
 	case KVM_SPSR_SVC:
 		write_sysreg_el1(v, SYS_SPSR);
+		/* fallthrough */
 	case KVM_SPSR_ABT:
 		write_sysreg(v, spsr_abt);
+		/* fallthrough */
 	case KVM_SPSR_UND:
 		write_sysreg(v, spsr_und);
+		/* fallthrough */
 	case KVM_SPSR_IRQ:
 		write_sysreg(v, spsr_irq);
+		/* fallthrough */
 	case KVM_SPSR_FIQ:
 		write_sysreg(v, spsr_fiq);
 	}
-- 
2.21.0

