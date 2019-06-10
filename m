Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F46BC282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 10:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 064922085A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 10:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PeTp1CxM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388991AbfFJKAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 06:00:12 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38188 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388056AbfFJKAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 06:00:10 -0400
Received: by mail-pg1-f195.google.com with SMTP id v11so4768880pgl.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 03:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xLE9IGDGdclf5seO4s6mk7AfmrPI38Ub2I2BNpgZVTo=;
        b=PeTp1CxMq+zR12KX2wkiABCPYzSqQIDnWSVpSvstVkPPWnBZyDWVTL4H8QSP7JqDru
         TB9/M8ZIq8P8V0ShHkknV1lZAdsUqW1u18CrUend6YfToJ5g8Irn8doqeM6Ru7R9nI3k
         3RyuUhyCj8Ak+xE7uTLn44+Iy+tf6FtGZ9jsKrEDWl8uqWomvQ1cfPAvMdwsmQ4rSi2q
         6NeGcAeadhChSPTPh1KI2VucPfxv/e98rrBN4X+xq+7tPu1QjiJrEUp4jRetGH7m7Sog
         3u/QwyA4Uy/AbWddtsq7KMB8z5Gf5+2HKrLHrvm4H3QjI/yqwqVfrXg8dT5+cXQ6ZKV0
         zYkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xLE9IGDGdclf5seO4s6mk7AfmrPI38Ub2I2BNpgZVTo=;
        b=TM+L8Q2wUK/M7i4uejT1SrizswxZuLH66Zi2eDrFz+a0Ww1XX2jl+96bJ1w67XZ0gc
         OZIOAI7joDFAB1DRbE5RyWxTH2/tBWA7G1Gnj4yzMkKNMyaMRNYMQ4GYsO1x1SH+8D4s
         57RxUogduvjPSmicPGLdPBxo6iYjtIWpduNZ88aMoZ+Jd8WW5M+WAgA5kJsuOb1QheVV
         12ChAdyrTmGdhUUpnjZQSHsbymGZazgUqbMBXCx6dBsMXSU6n5rlft/0toX25I4hZ9sL
         sp+0y3VIQG5sG4CrCQTbDuHIvUkOnW145j1UUNOvYv66nonndTd1OlFUSj5aZjnR/f4C
         I7Bg==
X-Gm-Message-State: APjAAAXFOVP2sPrzzA3auKpIf7ZqxVPxPXcQUf8HVif/VlocDyRzoXxZ
        U1IOI7MA+CqjiVm3ZcjL1UbdLISX+PU=
X-Google-Smtp-Source: APXvYqyTrGc5VbAA6ehlwFcrbKwbbIShkAJlagVDXOlRG1GE7uZWgJAtgL+wq6SkgRxGuHw4kI2D5Q==
X-Received: by 2002:a62:e518:: with SMTP id n24mr17466524pff.102.1560160810189;
        Mon, 10 Jun 2019 03:00:10 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id m8sm18299091pff.137.2019.06.10.03.00.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 03:00:09 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Suzuki K Pouloze <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3] KVM: arm64: Implement vq_present() as a macro
Date:   Mon, 10 Jun 2019 15:30:03 +0530
Message-Id: <be823e68faffc82a6f621c16ce1bd45990d92791.1560160681.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This routine is a one-liner and doesn't really need to be function and
can be implemented as a macro.

Suggested-by: Dave Martin <Dave.Martin@arm.com>
Reviewed-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V2->V3:
- Pass "vqs" instead of "&vqs" to vq_present().
- Added Reviewed-by from Dave.

V1->V2:
- The previous implementation was fixing a compilation error that
  occurred only with old compilers (from 2015) due to a bug in the
  compiler itself.

- Dave suggested to rather implement this as a macro which made more
  sense.

 arch/arm64/kvm/guest.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 3ae2f82fca46..ae734fcfd4ea 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -207,13 +207,7 @@ static int set_core_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 
 #define vq_word(vq) (((vq) - SVE_VQ_MIN) / 64)
 #define vq_mask(vq) ((u64)1 << ((vq) - SVE_VQ_MIN) % 64)
-
-static bool vq_present(
-	const u64 (*const vqs)[KVM_ARM64_SVE_VLS_WORDS],
-	unsigned int vq)
-{
-	return (*vqs)[vq_word(vq)] & vq_mask(vq);
-}
+#define vq_present(vqs, vq) ((vqs)[vq_word(vq)] & vq_mask(vq))
 
 static int get_sve_vls(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 {
@@ -258,7 +252,7 @@ static int set_sve_vls(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 
 	max_vq = 0;
 	for (vq = SVE_VQ_MIN; vq <= SVE_VQ_MAX; ++vq)
-		if (vq_present(&vqs, vq))
+		if (vq_present(vqs, vq))
 			max_vq = vq;
 
 	if (max_vq > sve_vq_from_vl(kvm_sve_max_vl))
@@ -272,7 +266,7 @@ static int set_sve_vls(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	 * maximum:
 	 */
 	for (vq = SVE_VQ_MIN; vq <= max_vq; ++vq)
-		if (vq_present(&vqs, vq) != sve_vq_available(vq))
+		if (vq_present(vqs, vq) != sve_vq_available(vq))
 			return -EINVAL;
 
 	/* Can't run with no vector lengths at all: */
-- 
2.21.0.rc0.269.g1a574e7a288b

