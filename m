Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D594FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF3A42082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729844AbfC0OMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 10:12:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52908 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbfC0OMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 10:12:24 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 01EAA59443;
        Wed, 27 Mar 2019 14:12:24 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A51A85D9C4;
        Wed, 27 Mar 2019 14:12:22 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Liran Alon <liran.alon@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: x86: avoid misreporting level-triggered irqs as edge-triggered in tracing
Date:   Wed, 27 Mar 2019 15:12:20 +0100
Message-Id: <20190327141220.13940-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 27 Mar 2019 14:12:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 arch/x86/kvm/trace.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/trace.h b/arch/x86/kvm/trace.h
index 6432d08c7de7..4d47a2631d1f 100644
--- a/arch/x86/kvm/trace.h
+++ b/arch/x86/kvm/trace.h
@@ -438,13 +438,13 @@ TRACE_EVENT(kvm_apic_ipi,
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

