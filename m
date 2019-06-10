Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE648C282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 09:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A018B206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 09:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yT6RPU0C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389098AbfFJJue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 05:50:34 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40383 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388033AbfFJJue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 05:50:34 -0400
Received: by mail-pf1-f194.google.com with SMTP id p184so1697447pfp.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 02:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kcMkiDLN7tiwiQsNRFSRAPQinigwUeaLd/2nza4IvSU=;
        b=yT6RPU0CmwKG/FXMD1Wgkm2QRYHkYuYg+/raqwOkmXEjq3RAv2+lfhy9R5IOAS93RG
         i7tOc5zL3+RoZHOkwakdN/UbrwF7aF/rJw83u+svd+cmYj5VPG1O9R1FLsptHLQqB3Mc
         84Ntiy5ndSJrLIuA3KCS/hZIgDPK0UYohsaTdKTUOa0qHER7c7tlLOE0zdMhqCws3Bif
         g8+YdSagQ2c1Pt5DrPXrUAYDi5IxMc/xUSO9WUV6vwblZGT8pgtT4nzXBtqJ/0zJ4d2a
         ZdhsBkksjFQeFfD4gqnEB3Bzht6ugBXErf1g3PTvTVNBe1PmJl24fo3A584MOXTSzRtx
         W4lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kcMkiDLN7tiwiQsNRFSRAPQinigwUeaLd/2nza4IvSU=;
        b=RkyZLUO+hdxz7vJkdZfImb0RUip3SB6X3udkr9g4tGiOCEdCUcu6p1/Jcs7JHtAMZu
         o1BdeckLBGmDpSZsTPzzc4WmzJQLFRoLk50mIvdpHvOp1yjR0UHUqD+8HOvzW1AHUxDD
         gKY7gL8RL6UwKQAy3ZQkDSSjJTtnMYVtCjDE8SnBJsj8V8Jj5Gfi8gFL1qcZS1NTM2ee
         Q3gRdT/cKyy4Z9MMZFyw7R5xtLCrEUhapCqmi3g0LMVG2r6YZW60iGIR3ennzR/2CNkr
         QToelPfvOmCU9OHXQb2i0nIFmHIbBDxVSpmVnMkeHsAXKGZiuA9jDfWDl+28zunXl5NN
         T3RA==
X-Gm-Message-State: APjAAAU5NIxUMqjduJjBnhqmER5mXp5nwkUTtfd+E4BeRgmk0CzOEoQT
        AqN+Q9aliux/JT0jBkD7ehTe2Q==
X-Google-Smtp-Source: APXvYqxpR4cUB4btPVzc36PN9bN2L8r8IX/mf5wWOjnnmy45D/evuMovHEqSoavCWjijvi5HdwPJTA==
X-Received: by 2002:a62:d11d:: with SMTP id z29mr20325246pfg.21.1560160233436;
        Mon, 10 Jun 2019 02:50:33 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id o6sm10260545pfo.164.2019.06.10.02.50.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 02:50:32 -0700 (PDT)
Date:   Mon, 10 Jun 2019 15:20:30 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Suzuki K Pouloze <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] KVM: arm64: Implement vq_present() as a macro
Message-ID: <20190610095030.yurzajuyylyo57h2@vireshk-i7>
References: <7c2590c4d8cc95cd40bbb05c0d0c5e2b0735a16b.1560145715.git.viresh.kumar@linaro.org>
 <20190610090917.GK28398@e103592.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610090917.GK28398@e103592.cambridge.arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-06-19, 10:09, Dave Martin wrote:
> You could drop the extra level of indirection on vqs now.  The only
> thing it achieves is to enforce the size of the array via type-
> checkout, but the macro can't easily do that (unless you can think
> of another way to do it).
> 
> Otherwise, looks good.

Below is what I wrote initially this morning and then moved to the
current version as I wasn't sure if you would want that :)

-- 
viresh

-------------------------8<-------------------------

From be823e68faffc82a6f621c16ce1bd45990d92791 Mon Sep 17 00:00:00 2001
Message-Id: <be823e68faffc82a6f621c16ce1bd45990d92791.1560160165.git.viresh.kumar@linaro.org>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon, 10 Jun 2019 11:15:17 +0530
Subject: [PATCH] KVM: arm64: Implement vq_present() as a macro

This routine is a one-liner and doesn't really need to be function and
can be implemented as a macro.

Suggested-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
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

