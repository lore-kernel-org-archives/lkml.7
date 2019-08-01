Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E6CFC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FB7220679
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="KaScZw6s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388017AbfHATBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 15:01:19 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50547 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732059AbfHATBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 15:01:19 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x71J189S068781
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 1 Aug 2019 12:01:08 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x71J189S068781
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564686069;
        bh=cO0r5M1mvDDtn4tEAJduWlWL3tpO68c0rVFK8LWTyHA=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=KaScZw6s3wPRJCg0KMWXjkc+Hp6EZCBxCmVD8p13zNCh/lihZhmBTpESnS53AxUQa
         MQLUAXnIzrgo2V8jBf82IgS230AMm/TMTqsYOxdOsR5VfmLtBtkXCxEgT/2/sl178/
         C7W1hDGnMm11fYHMpsCfFDRxyPf0ydvW7UejopUpndfK46FiASN+Y0I9gwyEotR92Q
         AzOT/owxBfLigxVDJxZ7yeFLo/kYctbhayWSTEF5MeStkuUNXOmUu594WKFWihk6p3
         l+wsC890fYQtws7UHSMzIXu4pcMMAhfaE7iT3rXJxeqvsKaIpVzasv4S4zzxY1uDQM
         SbczuT6ouPWJg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x71J17Uk068777;
        Thu, 1 Aug 2019 12:01:07 -0700
Date:   Thu, 1 Aug 2019 12:01:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-2c0d278f3293fc59da0d183075415ca1e8c93b40@git.kernel.org>
Cc:     bigeasy@linutronix.de, hpa@zytor.com, pbonzini@redhat.com,
        mingo@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Reply-To: bigeasy@linutronix.de, hpa@zytor.com, pbonzini@redhat.com,
          mingo@kernel.org, tglx@linutronix.de, peterz@infradead.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190726185753.363363474@linutronix.de>
References: <20190726185753.363363474@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] KVM: LAPIC: Mark hrtimer to expire in hard
 interrupt context
Git-Commit-ID: 2c0d278f3293fc59da0d183075415ca1e8c93b40
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  2c0d278f3293fc59da0d183075415ca1e8c93b40
Gitweb:     https://git.kernel.org/tip/2c0d278f3293fc59da0d183075415ca1e8c93b40
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Fri, 26 Jul 2019 20:30:55 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 1 Aug 2019 20:51:20 +0200

KVM: LAPIC: Mark hrtimer to expire in hard interrupt context

On PREEMPT_RT enabled kernels unmarked hrtimers are moved into soft
interrupt expiry mode by default.

While that's not a functional requirement for the KVM local APIC timer
emulation, it's a latency issue which can be avoided by marking the timer
so hard interrupt context expiry is enforced.

No functional change.

[ tglx: Split out from larger combo patch. Add changelog. ]

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190726185753.363363474@linutronix.de



---
 arch/x86/kvm/lapic.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 0aa158657f20..b9e516099d07 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1601,7 +1601,7 @@ static void start_sw_tscdeadline(struct kvm_lapic *apic)
 	    likely(ns > apic->lapic_timer.timer_advance_ns)) {
 		expire = ktime_add_ns(now, ns);
 		expire = ktime_sub_ns(expire, ktimer->timer_advance_ns);
-		hrtimer_start(&ktimer->timer, expire, HRTIMER_MODE_ABS);
+		hrtimer_start(&ktimer->timer, expire, HRTIMER_MODE_ABS_HARD);
 	} else
 		apic_timer_expired(apic);
 
@@ -2302,7 +2302,7 @@ int kvm_create_lapic(struct kvm_vcpu *vcpu, int timer_advance_ns)
 	apic->vcpu = vcpu;
 
 	hrtimer_init(&apic->lapic_timer.timer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_ABS);
+		     HRTIMER_MODE_ABS_HARD);
 	apic->lapic_timer.timer.function = apic_timer_fn;
 	if (timer_advance_ns == -1) {
 		apic->lapic_timer.timer_advance_ns = LAPIC_TIMER_ADVANCE_ADJUST_INIT;
@@ -2487,7 +2487,7 @@ void __kvm_migrate_apic_timer(struct kvm_vcpu *vcpu)
 
 	timer = &vcpu->arch.apic->lapic_timer.timer;
 	if (hrtimer_cancel(timer))
-		hrtimer_start_expires(timer, HRTIMER_MODE_ABS);
+		hrtimer_start_expires(timer, HRTIMER_MODE_ABS_HARD);
 }
 
 /*
