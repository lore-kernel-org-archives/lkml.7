Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A376C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D240020578
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557207949;
	bh=Rh191pEYYJDCVY4BQyz41VTbFjG7qXDROii6NgjuXsI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TDq5nW7HpXXTup0BR+D+8nSeCoWsbuKCSrG+dG+aKLy9Awut0/SbL68sW5w8TZWDM
	 7FMhnmiC7ZWiuB4BKs6KS0glmvA1kzq520MXKUiOb1g4NyBXuxcJ7uZGgf694vyNYg
	 xE9on4TjxGrBeCxSr/cSnANk2xPOWJLaXzjrW964=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbfEGFlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 01:41:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:32956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728239AbfEGFlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 01:41:50 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E89020B7C;
        Tue,  7 May 2019 05:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557207710;
        bh=Rh191pEYYJDCVY4BQyz41VTbFjG7qXDROii6NgjuXsI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ev3EZk99lWU1cylE6oYNGYsm68odIcCSe4NNR71f5xAcIt3KkllmAdGQfQReg3tqn
         xvczptEP+OSiwln+N+6pE/MtjoJOSnw8HifFp1KmG36WyVxa6CEEqOPHG8eYkZhcga
         z6VSA1m5XKp8JXvbS/2OHPeWAyzrkj84RRZWuZ2M=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 13/25] KVM: x86: avoid misreporting level-triggered irqs as edge-triggered in tracing
Date:   Tue,  7 May 2019 01:41:10 -0400
Message-Id: <20190507054123.32514-13-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507054123.32514-1-sashal@kernel.org>
References: <20190507054123.32514-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com>

[ Upstream commit 7a223e06b1a411cef6c4cd7a9b9a33c8d225b10e ]

In __apic_accept_irq() interface trig_mode is int and actually on some code
paths it is set above u8:

kvm_apic_set_irq() extracts it from 'struct kvm_lapic_irq' where trig_mode
is u16. This is done on purpose as e.g. kvm_set_msi_irq() sets it to
(1 << 15) & e->msi.data

kvm_apic_local_deliver sets it to reg & (1 << 15).

Fix the immediate issue by making 'tm' into u16. We may also want to adjust
__apic_accept_irq() interface and use proper sizes for vector, level,
trig_mode but this is not urgent.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/trace.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/trace.h b/arch/x86/kvm/trace.h
index 0a6cc6754ec5..ea618b713b6f 100644
--- a/arch/x86/kvm/trace.h
+++ b/arch/x86/kvm/trace.h
@@ -434,13 +434,13 @@ TRACE_EVENT(kvm_apic_ipi,
 );
 
 TRACE_EVENT(kvm_apic_accept_irq,
-	    TP_PROTO(__u32 apicid, __u16 dm, __u8 tm, __u8 vec),
+	    TP_PROTO(__u32 apicid, __u16 dm, __u16 tm, __u8 vec),
 	    TP_ARGS(apicid, dm, tm, vec),
 
 	TP_STRUCT__entry(
 		__field(	__u32,		apicid		)
 		__field(	__u16,		dm		)
-		__field(	__u8,		tm		)
+		__field(	__u16,		tm		)
 		__field(	__u8,		vec		)
 	),
 
-- 
2.20.1

