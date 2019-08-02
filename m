Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E65C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 14:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2937420679
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 14:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="ClkjwnuA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390590AbfHBOXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 10:23:40 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36351 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731067AbfHBOXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 10:23:39 -0400
Received: by mail-qk1-f196.google.com with SMTP id g18so54894213qkl.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 07:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=CWdgiiN/Z+VeLUxPy5NDLjA/glfsWptWvE0Hk0bA4Qc=;
        b=ClkjwnuAjyQX4RFGsqAZhTjqGMDy7ocP/0TCroEDlhL07SsQmlRYVGn8aIHaHRwUCf
         utzbV9Rw0J2YHV76T0ve3706m4aR1IZDfRam5C9funveugiRgC8FUpWqlxtq2tFKy7Hd
         VfsToKr4T96EcEkZOa1EYCPGLYzko/sCPdVXxdcyEjThSesEn1Yukp4qAFEBL8pv9AD7
         cQ+rtCtxrN7cT7v5yWDPwKLFyjF7Rnrrjf2zLhORo1f2RRy4znki0byJia/elQpyLyRH
         W9Kr1qkd/1ceoeZGcwQI6LhEwYkuiNtZoZc8nOVzH9lX4xcZnaGp0ETvzemP5soQs71N
         fvgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CWdgiiN/Z+VeLUxPy5NDLjA/glfsWptWvE0Hk0bA4Qc=;
        b=HbnIjTZJmMWlXzrkSrW0NYgbgUfblmMbb04v1kxS/8IOWtxZx2skrabCkSCTGpi3Jv
         to+2Dmur5pDWNXjHhtqS7ttk1qIxh5ENHnhv/A5g1+xikWeBYQu1rVVh4xjyKYqP4CJP
         Hess62MlMipr5R4vDvgB4Evy3eSErHg5yOz4UuxuozXWDYtxLWknsQdJVayLhUGvCT+X
         MRqzYsXLGqi6c9f8EPxoApslmoUCG9OyZlGsvCJ69iiHcDtQMXObhP0yLrcJnzvsu3Ic
         GuZwAvte5mtKE5KCp+x6jDFyUooHMCKdX1licJlt064ey6MpuoyMJqeqidUtd234JiK7
         CUnQ==
X-Gm-Message-State: APjAAAU9M6u8DSJJ8cKZzght9geE2Xonq//iSOjIo9CL7KUuavi2h9Fs
        NaG8IiMkRtTH6JLem6uUwj41/w==
X-Google-Smtp-Source: APXvYqz+KxEnFgHjSy1G4Be0JgFETmApxP1tkP5flW/+UvCcQ+n9HdUVJ9MvLVxmfppI//mnB3tdag==
X-Received: by 2002:a37:2c46:: with SMTP id s67mr92776362qkh.396.1564755818363;
        Fri, 02 Aug 2019 07:23:38 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id v84sm33042439qkb.0.2019.08.02.07.23.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 07:23:37 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     maz@kernel.org
Cc:     james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com, christoffer.dall@linaro.org,
        drjones@redhat.com, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] arm64/kvm: fix -Wimplicit-fallthrough warnings
Date:   Fri,  2 Aug 2019 10:23:08 -0400
Message-Id: <1564755788-28485-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit a892819560c4 ("KVM: arm64: Prepare to handle deferred
save/restore of 32-bit registers") introduced vcpu_write_spsr32() but
seems forgot to add "break" between the switch statements and generates
compilation warnings below. Also, adding a default statement as in
vcpu_read_spsr32().

In file included from ./arch/arm64/include/asm/kvm_emulate.h:19,
                 from arch/arm64/kvm/regmap.c:13:
arch/arm64/kvm/regmap.c: In function 'vcpu_write_spsr32':
./arch/arm64/include/asm/kvm_hyp.h:31:3: warning: this statement may
fall through [-Wimplicit-fallthrough=]
   asm volatile(ALTERNATIVE(__msr_s(r##nvh, "%x0"), \
   ^~~
./arch/arm64/include/asm/kvm_hyp.h:46:31: note: in expansion of macro
'write_sysreg_elx'
 #define write_sysreg_el1(v,r) write_sysreg_elx(v, r, _EL1, _EL12)
                               ^~~~~~~~~~~~~~~~
arch/arm64/kvm/regmap.c:180:3: note: in expansion of macro
'write_sysreg_el1'
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
./arch/arm64/include/asm/sysreg.h:837:2: warning: this statement may
fall through [-Wimplicit-fallthrough=]
  asm volatile("msr " __stringify(r) ", %x0"  \
  ^~~
arch/arm64/kvm/regmap.c:182:3: note: in expansion of macro
'write_sysreg'
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
./arch/arm64/include/asm/sysreg.h:837:2: warning: this statement may
fall through [-Wimplicit-fallthrough=]
  asm volatile("msr " __stringify(r) ", %x0"  \
  ^~~
arch/arm64/kvm/regmap.c:184:3: note: in expansion of macro
'write_sysreg'
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
./arch/arm64/include/asm/sysreg.h:837:2: warning: this statement may
fall through [-Wimplicit-fallthrough=]
  asm volatile("msr " __stringify(r) ", %x0"  \
  ^~~
arch/arm64/kvm/regmap.c:186:3: note: in expansion of macro
'write_sysreg'
   write_sysreg(v, spsr_irq);
   ^~~~~~~~~~~~
arch/arm64/kvm/regmap.c:187:2: note: here
  case KVM_SPSR_FIQ:
  ^~~~

Fixes: a892819560c4 ("KVM: arm64: Prepare to handle deferred save/restore of 32-bit registers")
Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/arm64/kvm/regmap.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/kvm/regmap.c b/arch/arm64/kvm/regmap.c
index 0d60e4f0af66..c94e9bc3e8eb 100644
--- a/arch/arm64/kvm/regmap.c
+++ b/arch/arm64/kvm/regmap.c
@@ -178,13 +178,20 @@ void vcpu_write_spsr32(struct kvm_vcpu *vcpu, unsigned long v)
 	switch (spsr_idx) {
 	case KVM_SPSR_SVC:
 		write_sysreg_el1(v, SYS_SPSR);
+		break;
 	case KVM_SPSR_ABT:
 		write_sysreg(v, spsr_abt);
+		break;
 	case KVM_SPSR_UND:
 		write_sysreg(v, spsr_und);
+		break;
 	case KVM_SPSR_IRQ:
 		write_sysreg(v, spsr_irq);
+		break;
 	case KVM_SPSR_FIQ:
 		write_sysreg(v, spsr_fiq);
+		break;
+	default:
+		BUG();
 	}
 }
-- 
1.8.3.1

