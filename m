Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F9AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DC35218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730069AbfC2UNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 16:13:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43588 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729380AbfC2UNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 16:13:02 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F294660A91;
        Fri, 29 Mar 2019 20:13:01 +0000 (UTC)
Received: from weilaptop.redhat.com (ovpn-125-164.rdu2.redhat.com [10.10.125.164])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1045D5C226;
        Fri, 29 Mar 2019 20:12:53 +0000 (UTC)
From:   Wei Huang <wei@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        andre.przywara@arm.com, christoffer.dall@arm.com,
        marc.zyngier@arm.com, james.morse@arm.com, julien.thierry@arm.com,
        suzuki.poulose@arm.com, wei@redhat.com
Subject: [PATCH 1/1] KVM: arm/arm64: arch_timer: Fix TimerValue TVAL calculation in KVM
Date:   Fri, 29 Mar 2019 15:12:53 -0500
Message-Id: <20190329201253.29164-1-wei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 29 Mar 2019 20:13:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently the generic timer test of kvm-unit-tests failed to complete
(stalled) when a physical timer is being used. This issue is caused
by incorrect update of CNT_CVAL when TimerValue is being accessed,
introduced by 'Commit 84135d3d18da ("KVM: arm/arm64: consolidate arch
timer trap handlers")'. According to Arm ARM, the read/write behavior
of accesses to TimeValue registers is expected to be:

  * READ: TimerValue = (CompareValue – (Counter - Offset)
  * WRITE: CompareValue = ((Counter - Offset) + Sign(TimerValue)

This patch fixes the TVAL read/write code path according to the
specification.

Signed-off-by: Wei Huang <wei@redhat.com>
---
 virt/kvm/arm/arch_timer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
index 3417f2dbc366..d43308dc3617 100644
--- a/virt/kvm/arm/arch_timer.c
+++ b/virt/kvm/arm/arch_timer.c
@@ -812,7 +812,7 @@ static u64 kvm_arm_timer_read(struct kvm_vcpu *vcpu,
 
 	switch (treg) {
 	case TIMER_REG_TVAL:
-		val = kvm_phys_timer_read() - timer->cntvoff - timer->cnt_cval;
+		val = timer->cnt_cval - kvm_phys_timer_read() + timer->cntvoff;
 		break;
 
 	case TIMER_REG_CTL:
@@ -858,7 +858,7 @@ static void kvm_arm_timer_write(struct kvm_vcpu *vcpu,
 {
 	switch (treg) {
 	case TIMER_REG_TVAL:
-		timer->cnt_cval = val - kvm_phys_timer_read() - timer->cntvoff;
+		timer->cnt_cval = kvm_phys_timer_read() - timer->cntvoff + val;
 		break;
 
 	case TIMER_REG_CTL:
-- 
2.14.5

