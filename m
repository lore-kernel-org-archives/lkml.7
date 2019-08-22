Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210D6C3A5A2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6FD52064A
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566494845;
	bh=j3JYLHpF4NIBmPoPHjZ+6njDedYcqo4ggTg6KcrZ9Lw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZmXO9vXF+4nEI2R9tHOlmfeCzfxGMprSrTGVKTrZz7+W0F1rPDbXPABgYYJq/Lmk5
	 nMtv2RtZjjeRX2sjKPZRa3Iu8+cRCbawo1nYoBEmbjRIdVgC8Y8LxrVdf/tj1nwgrY
	 7SbeCpV9QoZBWTk4stwUm7lS70helQH5fKF8QKjQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392020AbfHVR1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:27:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:50226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404527AbfHVRZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:25:55 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E1E72342B;
        Thu, 22 Aug 2019 17:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566494754;
        bh=j3JYLHpF4NIBmPoPHjZ+6njDedYcqo4ggTg6KcrZ9Lw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tqmELVbAe4mUUiwVvn9m3hIyKBulgm9AszyqlhgiC1qNopwn/glaKQcN+zHALJn2M
         ui+NfOdphI2LiMl5gGsSWcCbHpiCa0cfGLgE+y96aofyDWMw8PqMkPmtlg5CWuONoP
         W1BcK51BN+BuO/YpN8H3V2xYm+nflz0UAkB2FerM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anders Roxell <anders.roxell@linaro.org>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH 4.19 54/85] arm64: KVM: regmap: Fix unexpected switch fall-through
Date:   Thu, 22 Aug 2019 10:19:27 -0700
Message-Id: <20190822171733.580567685@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190822171731.012687054@linuxfoundation.org>
References: <20190822171731.012687054@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anders Roxell <anders.roxell@linaro.org>

commit 3d584a3c85d6fe2cf878f220d4ad7145e7f89218 upstream.

When fall-through warnings was enabled by default, commit d93512ef0f0e
("Makefile: Globally enable fall-through warning"), the following
warnings was starting to show up:

In file included from ../arch/arm64/include/asm/kvm_emulate.h:19,
                 from ../arch/arm64/kvm/regmap.c:13:
../arch/arm64/kvm/regmap.c: In function ‘vcpu_write_spsr32’:
../arch/arm64/include/asm/kvm_hyp.h:31:3: warning: this statement may fall
 through [-Wimplicit-fallthrough=]
   asm volatile(ALTERNATIVE(__msr_s(r##nvh, "%x0"), \
   ^~~
../arch/arm64/include/asm/kvm_hyp.h:46:31: note: in expansion of macro ‘write_sysreg_elx’
 #define write_sysreg_el1(v,r) write_sysreg_elx(v, r, _EL1, _EL12)
                               ^~~~~~~~~~~~~~~~
../arch/arm64/kvm/regmap.c:180:3: note: in expansion of macro ‘write_sysreg_el1’
   write_sysreg_el1(v, SYS_SPSR);
   ^~~~~~~~~~~~~~~~
../arch/arm64/kvm/regmap.c:181:2: note: here
  case KVM_SPSR_ABT:
  ^~~~
In file included from ../arch/arm64/include/asm/cputype.h:132,
                 from ../arch/arm64/include/asm/cache.h:8,
                 from ../include/linux/cache.h:6,
                 from ../include/linux/printk.h:9,
                 from ../include/linux/kernel.h:15,
                 from ../include/asm-generic/bug.h:18,
                 from ../arch/arm64/include/asm/bug.h:26,
                 from ../include/linux/bug.h:5,
                 from ../include/linux/mmdebug.h:5,
                 from ../include/linux/mm.h:9,
                 from ../arch/arm64/kvm/regmap.c:11:
../arch/arm64/include/asm/sysreg.h:837:2: warning: this statement may fall
 through [-Wimplicit-fallthrough=]
  asm volatile("msr " __stringify(r) ", %x0"  \
  ^~~
../arch/arm64/kvm/regmap.c:182:3: note: in expansion of macro ‘write_sysreg’
   write_sysreg(v, spsr_abt);
   ^~~~~~~~~~~~
../arch/arm64/kvm/regmap.c:183:2: note: here
  case KVM_SPSR_UND:
  ^~~~

Rework to add a 'break;' in the swich-case since it didn't have that,
leading to an interresting set of bugs.

Cc: stable@vger.kernel.org # v4.17+
Fixes: a892819560c4 ("KVM: arm64: Prepare to handle deferred save/restore of 32-bit registers")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
[maz: reworked commit message, fixed stable range]
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 arch/arm64/kvm/regmap.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/arch/arm64/kvm/regmap.c
+++ b/arch/arm64/kvm/regmap.c
@@ -189,13 +189,18 @@ void vcpu_write_spsr32(struct kvm_vcpu *
 	switch (spsr_idx) {
 	case KVM_SPSR_SVC:
 		write_sysreg_el1(v, spsr);
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
 	}
 }


