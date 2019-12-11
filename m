Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EADC2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 20:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3D4924656
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 20:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="acHQQrZr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfLKUtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 15:49:07 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:48039 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbfLKUtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 15:49:01 -0500
Received: by mail-pl1-f202.google.com with SMTP id d24so36713pll.14
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 12:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nhUvad64y2J5+k80ysZ9zgdkeo4zQNXWR3pwGYhF48c=;
        b=acHQQrZrnlr62CvNe5hxg9AohvcCZSjyCDFZ3Hf5zH8EGMQDG6TujUFqKegZobyqaJ
         7sI/4zwUeQFvB+2u50CjyMrj/ifLgYYvLIf99oOMmrewQwIkGelULqk7ofqEgb/3JkTo
         Az8Fm/HnT5CtdvcYvSQXcEQLAlpUY8cI/5x8Vgk3WBdNado0bfxlVBd2l9+5JhFCB0Dp
         TlC2DKTS+DnW0a3B1QDsKKGIEC9sGa6z8g/KKaY3L99Z4jKH3+pbSmWlYVSYD1ADltT+
         4IeQVJL031mY56W+XjhxwAsmN3ZSrFPcVmQi3F0vwX5oQZBsY2eHl9PM9RmLxQDKlzW/
         2mXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nhUvad64y2J5+k80ysZ9zgdkeo4zQNXWR3pwGYhF48c=;
        b=AdgGs9DHvQfCl8kmPY/0ZP6mjFzFhKsZUAtnlSSYF5FSztAy2OkKaksOxV6IXExgO7
         qoixYmozUnQrV7uU62wdtjB9oc5pEmsmOaTLYJ42kGrAcizrvcm4ZRyMkeoD4Ec0DKWs
         d6YoAorT/EU08y1hf6xONcT+RL6v2jXgs5YX0tybGWCm63OaqWdEC2sERy4iLaTjTsIm
         CVSHRptzUGvNzfGDElWfvJuk8u+E7s0YqFwsSlwI4+t7UqmDRET9Qa81EiDlMbYRtGAO
         0NdN0jZasKgOhX9eWID+Nbr7J5ulJjnHgtjNdp4OYUdLfyg4igBp0AAh7o0XGm/+/JD/
         AXEg==
X-Gm-Message-State: APjAAAWJCNvOp6MeDrwLHuCj/ls+DPd5x3FXpSW62qqAWyp9Mw6v76nx
        SuMjZokGTtgLPzsPUfr2EdJkPCiyYVdd
X-Google-Smtp-Source: APXvYqzMbqg2ZAo3mpcOI/CliiFPYJvF/vXz4zNY+Ru1eO8xRLB0Z0l/Wn9cCmNlY1KiEQ3HCVcbYKqOZLU6
X-Received: by 2002:a63:9d07:: with SMTP id i7mr6629501pgd.344.1576097340640;
 Wed, 11 Dec 2019 12:49:00 -0800 (PST)
Date:   Wed, 11 Dec 2019 12:47:49 -0800
In-Reply-To: <20191211204753.242298-1-pomonis@google.com>
Message-Id: <20191211204753.242298-10-pomonis@google.com>
Mime-Version: 1.0
References: <20191211204753.242298-1-pomonis@google.com>
X-Mailer: git-send-email 2.24.0.525.g8f36a354ae-goog
Subject: [PATCH v2 09/13] KVM: x86: Protect MSR-based index computations from
 Spectre-v1/L1TF attacks in x86.c
From:   Marios Pomonis <pomonis@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, rkrcmar@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Finco <nifi@google.com>, Andrew Honig <ahonig@google.com>,
        Marios Pomonis <pomonis@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a Spectre-v1/L1TF vulnerability in set_msr_mce() and
get_msr_mce().
Both functions contain index computations based on the
(attacker-controlled) MSR number.

Fixes: commit 890ca9aefa78 ("KVM: Add MCE support")

Signed-off-by: Nick Finco <nifi@google.com>
Signed-off-by: Marios Pomonis <pomonis@google.com>
Reviewed-by: Andrew Honig <ahonig@google.com>
Cc: stable@vger.kernel.org
---
 arch/x86/kvm/x86.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a256e09f321a..a9e66f09422e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2496,7 +2496,10 @@ static int set_msr_mce(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	default:
 		if (msr >= MSR_IA32_MC0_CTL &&
 		    msr < MSR_IA32_MCx_CTL(bank_num)) {
-			u32 offset = msr - MSR_IA32_MC0_CTL;
+			u32 offset = array_index_nospec(
+				msr - MSR_IA32_MC0_CTL,
+				MSR_IA32_MCx_CTL(bank_num) - MSR_IA32_MC0_CTL);
+
 			/* only 0 or all 1s can be written to IA32_MCi_CTL
 			 * some Linux kernels though clear bit 10 in bank 4 to
 			 * workaround a BIOS/GART TBL issue on AMD K8s, ignore
@@ -2937,7 +2940,10 @@ static int get_msr_mce(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata, bool host)
 	default:
 		if (msr >= MSR_IA32_MC0_CTL &&
 		    msr < MSR_IA32_MCx_CTL(bank_num)) {
-			u32 offset = msr - MSR_IA32_MC0_CTL;
+			u32 offset = array_index_nospec(
+				msr - MSR_IA32_MC0_CTL,
+				MSR_IA32_MCx_CTL(bank_num) - MSR_IA32_MC0_CTL);
+
 			data = vcpu->arch.mce_banks[offset];
 			break;
 		}
-- 
2.24.0.525.g8f36a354ae-goog

