Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7BFC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 04:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB3024673
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 04:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J8sz4rTe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfFDEns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 00:43:48 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36595 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbfFDEns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 00:43:48 -0400
Received: by mail-pg1-f194.google.com with SMTP id a3so2178858pgb.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 21:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zkepnFRWjo+2i9EzIxBtZYocaRmAxYlop81Nj4rH8DI=;
        b=J8sz4rTevobviVKwm+dLsHY0zZAT9dT0y9oQKyafTlFYIXFXc0sZ/DS6ZSOiJpH4ci
         KWIWCxBwVCaPaC6geJvwYMf++4HvY7OTCHRLscuRijfmR+cSNydwyg5D7V0LxdI+LGJj
         VoIsuIUSlisSzGAnZPF1DUqV6SKLx89VTa4WQfp3wugLav54sY7mHjBqxF+0JGokf+x5
         vAXrGc2v1k5D8fJriujqAgW3MBU+vh7xu/kdqnI+obXgP0yWUAbhuhkTIFIKQ3sLgrpa
         LHfdBBRDqAXOzJ4d5JHexjtnNKCmImiX9N+T5AaQoeIXuM7pSq+BGNA0pB/V9nTjcFod
         Ax6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zkepnFRWjo+2i9EzIxBtZYocaRmAxYlop81Nj4rH8DI=;
        b=N044i4gf734Y9q5wqLRmKz8T5ek4WOibCn80gZlG8snLGLDvvbBeuyoVCRSBhLBEq0
         JOmXTABP8NuQHWNurn/6JUPImNONNW0prw8u7RdOFdkQv68nHze2ZJm2kRvCSPUGiPtC
         NhNGm7GFAEkjHOPdfS1pb2ygojyO8qACgsoiXYvrk+cVqOIw8n4SFclP7PA/BjnNY89O
         FvvCLvcsUd/xDp61h8po8Nfws+xBK2AgVBuvp6I77hrb+tC9RH5IZC07XYadpkMlfpvj
         v2btmIAPJYQKIb7FS6Nms2y54MVe8BgF9bVSNS25VwNyvGMFBQ5sXwS81PUND3QBW0fd
         OpHQ==
X-Gm-Message-State: APjAAAXqYM9V0Av4TAuJ1NJAEQQ+4V8+xg/bW8FJ231VlB7Euocdu9Ez
        CFhMziD52Al++juxcKe2c4i1OA==
X-Google-Smtp-Source: APXvYqyrbfVVhnHOSNRF/Ni0Um7ccZKTk5f7Qfxx4j3T7CrtwO7Q4cK+39lbl+3EGYtoAYqA4PM09w==
X-Received: by 2002:a17:90a:ff03:: with SMTP id ce3mr34487977pjb.81.1559623427427;
        Mon, 03 Jun 2019 21:43:47 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id q17sm24195389pfq.74.2019.06.03.21.43.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 21:43:46 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dave Martin <Dave.Martin@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Suzuki K Pouloze <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: arm64: Drop 'const' from argument of vq_present()
Date:   Tue,  4 Jun 2019 10:13:19 +0530
Message-Id: <699121e5c938c6f4b7b14a7e2648fa15af590a4a.1559623368.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We currently get following compilation warning:

arch/arm64/kvm/guest.c: In function 'set_sve_vls':
arch/arm64/kvm/guest.c:262:18: warning: passing argument 1 of 'vq_present' from incompatible pointer type
arch/arm64/kvm/guest.c:212:13: note: expected 'const u64 (* const)[8]' but argument is of type 'u64 (*)[8]'

The argument can't be const, as it is copied at runtime using
copy_from_user(). Drop const from the prototype of vq_present().

Fixes: 9033bba4b535 ("KVM: arm64/sve: Add pseudo-register for the guest's vector lengths")
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm64/kvm/guest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 3ae2f82fca46..78f5a4f45e0a 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -209,7 +209,7 @@ static int set_core_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 #define vq_mask(vq) ((u64)1 << ((vq) - SVE_VQ_MIN) % 64)
 
 static bool vq_present(
-	const u64 (*const vqs)[KVM_ARM64_SVE_VLS_WORDS],
+	u64 (*const vqs)[KVM_ARM64_SVE_VLS_WORDS],
 	unsigned int vq)
 {
 	return (*vqs)[vq_word(vq)] & vq_mask(vq);
-- 
2.21.0.rc0.269.g1a574e7a288b

