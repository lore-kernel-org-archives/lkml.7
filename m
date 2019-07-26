Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205C3C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFA4A218B8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388734AbfGZTTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 15:19:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50197 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388562AbfGZTS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 15:18:59 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hr5k1-0001Ay-HV; Fri, 26 Jul 2019 21:18:57 +0200
Message-Id: <20190726185753.363363474@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 26 Jul 2019 20:30:55 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Juergen Gross <jgross@suse.com>
Subject: [patch 07/12] KVM: LAPIC: Mark hrtimer to expire in hard interrupt
 context
References: <20190726183048.982726647@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

On PREEMPT_RT enabled kernels unmarked hrtimers are moved into soft
interrupt expiry mode by default.

While that's not a functional requirement for the KVM local APIC timer
emulation, it's a latency issue which can be avoided by marking the timer
so hard interrupt context expiry is enforced.

No functional change.

[ tglx: Split out from larger combo patch. Add changelog. ]

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/lapic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2302,7 +2302,7 @@ int kvm_create_lapic(struct kvm_vcpu *vc
 	apic->vcpu = vcpu;
 
 	hrtimer_init(&apic->lapic_timer.timer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_ABS);
+		     HRTIMER_MODE_ABS_HARD);
 	apic->lapic_timer.timer.function = apic_timer_fn;
 	if (timer_advance_ns == -1) {
 		apic->lapic_timer.timer_advance_ns = LAPIC_TIMER_ADVANCE_ADJUST_INIT;


