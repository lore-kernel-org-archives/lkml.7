Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF07ECE597
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 07:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36DAF21920
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 07:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C/ywy926"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733256AbfJJHiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 03:38:18 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:51381 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733063AbfJJHbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 03:31:10 -0400
Received: by mail-qk1-f202.google.com with SMTP id h4so4579331qkd.18
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 00:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cqfOgbBFq1cuCJ9mBVUN432MN6WUG2Cztrp58NLs2Vw=;
        b=C/ywy926tafCeZE7HfHuO7rwVEIl1bPrxo0phIi3BlyVKKzbYBsdlulXvZwVmVv152
         pSDnC5TXL5u/rIOqk5sCwwe9zTponYR5613RtFPYKxAnp1P2hQy46QRdfWSTvAyKgHxT
         +s8OWL8JsfxGoGswhx87REvg1bxy6UD5+Z5N5/cwKMK++NsW9zmTgwvwrmXvdsO+RD46
         /CW3FiWNnaeM+/a58dWILDDj6hT3tHScRgNcUFz14HaFjyNfynJpHIgxuskOLZUyUB3u
         A58hwqSvLbz9Bz6p6Nydy/epNL3Cu9kha1GvBWk/w8LyVjBW7G6GiF68ffWwZtt7wfWn
         Xjlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cqfOgbBFq1cuCJ9mBVUN432MN6WUG2Cztrp58NLs2Vw=;
        b=mzIQ3zzbQc6UTi+H5OXrp6a2qMeewhAUviaahAPgDfBZUKYeP924TotDkhdlI0ZyHh
         8j/XQMjIFUvsMHlSKYlDcsBiRhcSYjat1ZUrD4gG6X/b2YsZFql/1ar+UOqAGd8wd8DN
         O6liEXhUnTEEsumRTatg+MW+uJ+yJiBI2TDffia7a9BTUZwlqE66a4BJGeJZ8X+2nHx4
         IB1ZXSr92SCAFpvKI0XDB6g9sppHbWG+0QjarYgB5hltsLPjfIkjG8FzJZzv2ZiNSNSM
         nGz5qS58rv0GZf9pD8R7i0xWYon915b/aaoTffExDfkVka2HMN9whC+rxSWJc9OIejCX
         bu5A==
X-Gm-Message-State: APjAAAUIKtrsxA8bjKZwRs8UJKfTAtRSOfx/EhTCd7SeDQsxGXWRSEnY
        TxJG8XkgBOD6lbugJA09bO6GuXKhH31Czw==
X-Google-Smtp-Source: APXvYqwCqV1V0a/8Ms8j/bNzW6sJqTHXo4TnK3h/ScttMp4kqMIWGm+wYIgZKsfhzUHRlf4rOEsV57bcyS0uBw==
X-Received: by 2002:a05:620a:136e:: with SMTP id d14mr8147013qkl.393.1570692668234;
 Thu, 10 Oct 2019 00:31:08 -0700 (PDT)
Date:   Thu, 10 Oct 2019 16:30:54 +0900
In-Reply-To: <20191010073055.183635-1-suleiman@google.com>
Message-Id: <20191010073055.183635-2-suleiman@google.com>
Mime-Version: 1.0
References: <20191010073055.183635-1-suleiman@google.com>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: [RFC v2 1/2] kvm: Mechanism to copy host timekeeping parameters into guest.
From:   Suleiman Souhlal <suleiman@google.com>
To:     pbonzini@redhat.com, rkrcmar@redhat.com, tglx@linutronix.de
Cc:     john.stultz@linaro.org, sboyd@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        ssouhlal@freebsd.org, tfiga@chromium.org, vkuznets@redhat.com,
        Suleiman Souhlal <suleiman@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is used to synchronize time between host and guest.
The guest can request the (guest) physical address it wants the
data in through the MSR_KVM_TIMEKEEPER_EN MSR.

It currently assumes the host timekeeper is "tsc".

Signed-off-by: Suleiman Souhlal <suleiman@google.com>
---
 arch/x86/include/asm/kvm_host.h      |   3 +
 arch/x86/include/asm/pvclock-abi.h   |  27 ++++++
 arch/x86/include/uapi/asm/kvm_para.h |   1 +
 arch/x86/kvm/x86.c                   | 121 +++++++++++++++++++++++++++
 4 files changed, 152 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 50eb430b0ad8..4d622450cb4a 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -659,7 +659,10 @@ struct kvm_vcpu_arch {
 	struct pvclock_vcpu_time_info hv_clock;
 	unsigned int hw_tsc_khz;
 	struct gfn_to_hva_cache pv_time;
+	struct gfn_to_hva_cache pv_timekeeper_g2h;
+	struct pvclock_timekeeper pv_timekeeper;
 	bool pv_time_enabled;
+	bool pv_timekeeper_enabled;
 	/* set guest stopped flag in pvclock flags field */
 	bool pvclock_set_guest_stopped_request;
 
diff --git a/arch/x86/include/asm/pvclock-abi.h b/arch/x86/include/asm/pvclock-abi.h
index 1436226efe3e..2809008b9b26 100644
--- a/arch/x86/include/asm/pvclock-abi.h
+++ b/arch/x86/include/asm/pvclock-abi.h
@@ -40,6 +40,33 @@ struct pvclock_wall_clock {
 	u32   nsec;
 } __attribute__((__packed__));
 
+struct pvclock_read_base {
+	u64 mask;
+	u64 cycle_last;
+	u32 mult;
+	u32 shift;
+	u64 xtime_nsec;
+	u64 base;
+} __attribute__((__packed__));
+
+struct pvclock_timekeeper {
+	u64 gen;
+	u64 flags;
+	struct pvclock_read_base tkr_mono;
+	struct pvclock_read_base tkr_raw;
+	u64 xtime_sec;
+	u64 ktime_sec;
+	u64 wall_to_monotonic_sec;
+	u64 wall_to_monotonic_nsec;
+	u64 offs_real;
+	u64 offs_boot;
+	u64 offs_tai;
+	u64 raw_sec;
+	u64 tsc_offset;
+} __attribute__((__packed__));
+
+#define	PVCLOCK_TIMEKEEPER_ENABLED (1 << 0)
+
 #define PVCLOCK_TSC_STABLE_BIT	(1 << 0)
 #define PVCLOCK_GUEST_STOPPED	(1 << 1)
 /* PVCLOCK_COUNTS_FROM_ZERO broke ABI and can't be used anymore. */
diff --git a/arch/x86/include/uapi/asm/kvm_para.h b/arch/x86/include/uapi/asm/kvm_para.h
index 2a8e0b6b9805..3ebb1d87db3a 100644
--- a/arch/x86/include/uapi/asm/kvm_para.h
+++ b/arch/x86/include/uapi/asm/kvm_para.h
@@ -50,6 +50,7 @@
 #define MSR_KVM_STEAL_TIME  0x4b564d03
 #define MSR_KVM_PV_EOI_EN      0x4b564d04
 #define MSR_KVM_POLL_CONTROL	0x4b564d05
+#define MSR_KVM_TIMEKEEPER_EN	0x4b564d06
 
 struct kvm_steal_time {
 	__u64 steal;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 661e2bf38526..937f83cdda4b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -157,6 +157,8 @@ module_param(force_emulation_prefix, bool, S_IRUGO);
 int __read_mostly pi_inject_timer = -1;
 module_param(pi_inject_timer, bint, S_IRUGO | S_IWUSR);
 
+static atomic_t pv_timekeepers_nr;
+
 #define KVM_NR_SHARED_MSRS 16
 
 struct kvm_shared_msrs_global {
@@ -2729,6 +2731,16 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 
 		break;
 	}
+	case MSR_KVM_TIMEKEEPER_EN:
+		if (kvm_gfn_to_hva_cache_init(vcpu->kvm,
+		    &vcpu->arch.pv_timekeeper_g2h, data,
+		    sizeof(struct pvclock_timekeeper)))
+			vcpu->arch.pv_timekeeper_enabled = false;
+		else {
+			vcpu->arch.pv_timekeeper_enabled = true;
+			atomic_inc(&pv_timekeepers_nr);
+		}
+		break;
 	case MSR_KVM_ASYNC_PF_EN:
 		if (kvm_pv_enable_async_pf(vcpu, data))
 			return 1;
@@ -7097,6 +7109,109 @@ static struct perf_guest_info_callbacks kvm_guest_cbs = {
 };
 
 #ifdef CONFIG_X86_64
+static DEFINE_SPINLOCK(shadow_pvtk_lock);
+static struct pvclock_timekeeper shadow_pvtk;
+
+static void
+pvclock_copy_read_base(struct pvclock_read_base *pvtkr,
+    struct tk_read_base *tkr)
+{
+	pvtkr->cycle_last = tkr->cycle_last;
+	pvtkr->mult = tkr->mult;
+	pvtkr->shift = tkr->shift;
+	pvtkr->mask = tkr->mask;
+	pvtkr->xtime_nsec = tkr->xtime_nsec;
+	pvtkr->base = tkr->base;
+}
+
+static void
+kvm_copy_into_pvtk(struct kvm_vcpu *vcpu)
+{
+	struct pvclock_timekeeper *pvtk;
+	unsigned long flags;
+
+	if (!vcpu->arch.pv_timekeeper_enabled)
+		return;
+
+	pvtk = &vcpu->arch.pv_timekeeper;
+	if (pvclock_gtod_data.clock.vclock_mode == VCLOCK_TSC) {
+		pvtk->flags |= PVCLOCK_TIMEKEEPER_ENABLED;
+		spin_lock_irqsave(&shadow_pvtk_lock, flags);
+		pvtk->tkr_mono = shadow_pvtk.tkr_mono;
+		pvtk->tkr_raw = shadow_pvtk.tkr_raw;
+
+		pvtk->xtime_sec = shadow_pvtk.xtime_sec;
+		pvtk->ktime_sec = shadow_pvtk.ktime_sec;
+		pvtk->wall_to_monotonic_sec =
+		    shadow_pvtk.wall_to_monotonic_sec;
+		pvtk->wall_to_monotonic_nsec =
+		    shadow_pvtk.wall_to_monotonic_nsec;
+		pvtk->offs_real = shadow_pvtk.offs_real;
+		pvtk->offs_boot = shadow_pvtk.offs_boot;
+		pvtk->offs_tai = shadow_pvtk.offs_tai;
+		pvtk->raw_sec = shadow_pvtk.raw_sec;
+		spin_unlock_irqrestore(&shadow_pvtk_lock, flags);
+
+		pvtk->tsc_offset = kvm_x86_ops->read_l1_tsc_offset(vcpu);
+	} else
+		pvtk->flags &= ~PVCLOCK_TIMEKEEPER_ENABLED;
+
+	BUILD_BUG_ON(offsetof(struct pvclock_timekeeper, gen) != 0);
+
+	/*
+	 * Make the gen count odd to indicate we are in the process of
+	 * updating.
+	 */
+	vcpu->arch.pv_timekeeper.gen++;
+	vcpu->arch.pv_timekeeper.gen |= 1;
+
+	/*
+	 * See comment in kvm_guest_time_update() for why we have to do
+	 * multiple writes.
+	 */
+	kvm_write_guest_cached(vcpu->kvm, &vcpu->arch.pv_timekeeper_g2h,
+	    &vcpu->arch.pv_timekeeper, sizeof(vcpu->arch.pv_timekeeper.gen));
+
+	smp_wmb();
+
+	kvm_write_guest_cached(vcpu->kvm, &vcpu->arch.pv_timekeeper_g2h,
+	    &vcpu->arch.pv_timekeeper, sizeof(vcpu->arch.pv_timekeeper));
+
+	smp_wmb();
+
+	vcpu->arch.pv_timekeeper.gen++;
+
+	kvm_write_guest_cached(vcpu->kvm, &vcpu->arch.pv_timekeeper_g2h,
+	    &vcpu->arch.pv_timekeeper, sizeof(vcpu->arch.pv_timekeeper.gen));
+}
+
+static void
+update_shadow_pvtk(struct timekeeper *tk)
+{
+	struct pvclock_timekeeper *pvtk;
+	unsigned long flags;
+
+	pvtk = &shadow_pvtk;
+
+	if (atomic_read(&pv_timekeepers_nr) == 0 ||
+	    pvclock_gtod_data.clock.vclock_mode != VCLOCK_TSC)
+		return;
+
+	spin_lock_irqsave(&shadow_pvtk_lock, flags);
+	pvclock_copy_read_base(&pvtk->tkr_mono, &tk->tkr_mono);
+	pvclock_copy_read_base(&pvtk->tkr_raw, &tk->tkr_raw);
+
+	pvtk->xtime_sec = tk->xtime_sec;
+	pvtk->ktime_sec = tk->ktime_sec;
+	pvtk->wall_to_monotonic_sec = tk->wall_to_monotonic.tv_sec;
+	pvtk->wall_to_monotonic_nsec = tk->wall_to_monotonic.tv_nsec;
+	pvtk->offs_real = tk->offs_real;
+	pvtk->offs_boot = tk->offs_boot;
+	pvtk->offs_tai = tk->offs_tai;
+	pvtk->raw_sec = tk->raw_sec;
+	spin_unlock_irqrestore(&shadow_pvtk_lock, flags);
+}
+
 static void pvclock_gtod_update_fn(struct work_struct *work)
 {
 	struct kvm *kvm;
@@ -7124,6 +7239,7 @@ static int pvclock_gtod_notify(struct notifier_block *nb, unsigned long unused,
 	struct timekeeper *tk = priv;
 
 	update_pvclock_gtod(tk);
+	update_shadow_pvtk(tk);
 
 	/* disable master clock if host does not trust, or does not
 	 * use, TSC based clocksource.
@@ -7940,6 +8056,8 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 
 	bool req_immediate_exit = false;
 
+	kvm_copy_into_pvtk(vcpu);
+
 	if (kvm_request_pending(vcpu)) {
 		if (kvm_check_request(KVM_REQ_GET_VMCS12_PAGES, vcpu))
 			kvm_x86_ops->get_vmcs12_pages(vcpu);
@@ -9020,6 +9138,9 @@ void kvm_arch_vcpu_free(struct kvm_vcpu *vcpu)
 
 	kvmclock_reset(vcpu);
 
+	if (vcpu->arch.pv_timekeeper_enabled)
+		atomic_dec(&pv_timekeepers_nr);
+
 	kvm_x86_ops->vcpu_free(vcpu);
 	free_cpumask_var(wbinvd_dirty_mask);
 }
-- 
2.23.0.581.g78d2f28ef7-goog

