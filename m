Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54E4C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 13:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2AB320684
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 13:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbfFENEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 09:04:08 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42460 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727744AbfFENEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 09:04:08 -0400
Received: by mail-wr1-f67.google.com with SMTP id x17so1335299wrl.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 06:04:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E10Uq/CKstRqDPNkNzGX3FpBcikgtSLsGRUBR28/US4=;
        b=EqVLve8XhQbtB4zYS4QrGtem6w4tlk7U1e8plkiMVRTiSXknVP2b2aaSfqw1tN3yrV
         /qU2WOD6m2jBf5LZR8GcNidS71yHpdzFTuzdlVH8i9z6ATgejR50qmUqP9vBPbjiAwF4
         ag8mk3uzf2suDQvV1fH72oJ5YO8mjlN9KegckwBOclX00zl+/BADPSZLjO1b7AU8bneK
         g2B5mvk6xf/K3lg8B58UiWo1mNWdKAi+O3IlVpLk2KVaFeU0Xfswfz5yjES0eiT/Gv2z
         RmnHhmqgqASXIsLpaBJsq6zr1ZEGWgMwmpvUPhuWom0Ur+vRShza4xAxs1HKzHu9Q3zz
         gBWA==
X-Gm-Message-State: APjAAAWqpz3lpAEJbEY6UmkrWjy4KImzdhc3RBOR9ZNRM6y9kq3vA4sy
        8qllfBqBv0lAqVObaubSRg6NXA==
X-Google-Smtp-Source: APXvYqyTyzOOwhPEgHbXp4Rgoj+1MrN0NFP0TnUwo4C8ked0YmhErXRIquO15dMk8YjMci+9zcI6Ig==
X-Received: by 2002:adf:cd8c:: with SMTP id q12mr9193934wrj.103.1559739846327;
        Wed, 05 Jun 2019 06:04:06 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:657f:501:149f:5617? ([2001:b07:6468:f312:657f:501:149f:5617])
        by smtp.gmail.com with ESMTPSA id d10sm24821024wrh.91.2019.06.05.06.04.05
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 06:04:05 -0700 (PDT)
Subject: Re: [PATCH 1/3] KVM: LAPIC: Make lapic timer unpinned when timer is
 injected by posted-interrupt
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <1559729351-20244-1-git-send-email-wanpengli@tencent.com>
 <1559729351-20244-2-git-send-email-wanpengli@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <505fc388-2223-146f-ae8a-824169078a17@redhat.com>
Date:   Wed, 5 Jun 2019 15:04:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1559729351-20244-2-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/06/19 12:09, Wanpeng Li wrote:
> +static inline bool posted_interrupt_inject_timer(struct kvm_vcpu *vcpu)
> +{
> +	return (kvm_x86_ops->pi_inject_timer_enabled(vcpu) &&
> +		kvm_mwait_in_guest(vcpu->kvm));
> +}
> +

Here you need to check kvm_halt_in_guest, not kvm_mwait_in_guest,
because you need to go through kvm_apic_expired if the guest needs to be
woken up from kvm_vcpu_block.

There is a case when you get to kvm_vcpu_block with kvm_halt_in_guest,
which is when the guest disables asynchronous page faults.  Currently,
timer interrupts are delivered while apf.halted = true, with this change
they wouldn't.  I would just disable KVM_REQ_APF_HALT in
kvm_can_do_async_pf if kvm_halt_in_guest is true, let me send a patch
for that later.

When you do this, I think you don't need the
kvm_x86_ops->pi_inject_timer_enabled check at all, because if we know
that the vCPU cannot be asleep in kvm_vcpu_block, then we can inject the
timer interrupt immediately with __apic_accept_irq (if APICv is
disabled, it will set IRR and do kvm_make_request + kvm_vcpu_kick).

You can keep the module parameter, mostly for debugging reasons, but
please move it from kvm-intel to kvm, and add something like

diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 123ea07a3f3b..1cc7973c382e 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -14,6 +14,11 @@
 static cpumask_var_t housekeeping_mask;
 static unsigned int housekeeping_flags;

+bool housekeeping_enabled(enum hk_flags flags)
+{
+	return !!(housekeeping_flags & flags);
+}
+
 int housekeeping_any_cpu(enum hk_flags flags)
 {
 	if (static_branch_unlikely(&housekeeping_overridden))

so that the default for the module parameter can be
housekeeping_enabled(HK_FLAG_TIMER).

Thanks,

Paolo
