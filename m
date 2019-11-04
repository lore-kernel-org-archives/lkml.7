Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF869CA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 23:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4413204EC
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 23:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dO7gRYSy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730375AbfKDXAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 18:00:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29411 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730097AbfKDXAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 18:00:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572908414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XbUNPv4e7X64k+IbDW//r7wDmNNY6cewcDMc0XpI9XA=;
        b=dO7gRYSybAMFOVtzY+DwlOUrC0DCa3fiwUD67OC1GcRJ55poxNATcVaMw7mb1PeePrqRG+
        2Sl6JbPqef8b7OGJNXwIrqJ7EA8JOXFo1chWPmWXVkquuuN4d3tPc0yf7lUOYMtmd9T50o
        +qT2kHSs8zL0IpifDcrKUuvGMBn7ACQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-frA79sqPNlGS8-Tl3rHR6w-1; Mon, 04 Nov 2019 18:00:10 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5FC441800DFB;
        Mon,  4 Nov 2019 23:00:09 +0000 (UTC)
Received: from mail (ovpn-121-157.rdu2.redhat.com [10.10.121.157])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 37B3119C58;
        Mon,  4 Nov 2019 23:00:09 +0000 (UTC)
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH 10/13] KVM: x86: optimize more exit handlers in vmx.c
Date:   Mon,  4 Nov 2019 17:59:58 -0500
Message-Id: <20191104230001.27774-11-aarcange@redhat.com>
In-Reply-To: <20191104230001.27774-1-aarcange@redhat.com>
References: <20191104230001.27774-1-aarcange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: frA79sqPNlGS8-Tl3rHR6w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate wasteful call/ret non RETPOLINE case and unnecessary fentry
dynamic tracing hooking points.

Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
---
 arch/x86/kvm/vmx/vmx.c | 30 +++++-------------------------
 1 file changed, 5 insertions(+), 25 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 222467b2040e..a6afa5f4a01c 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4694,7 +4694,7 @@ static int handle_exception_nmi(struct kvm_vcpu *vcpu=
)
 =09return 0;
 }
=20
-static int handle_external_interrupt(struct kvm_vcpu *vcpu)
+static __always_inline int handle_external_interrupt(struct kvm_vcpu *vcpu=
)
 {
 =09++vcpu->stat.irq_exits;
 =09return 1;
@@ -4965,21 +4965,6 @@ void kvm_x86_set_dr7(struct kvm_vcpu *vcpu, unsigned=
 long val)
 =09vmcs_writel(GUEST_DR7, val);
 }
=20
-static int handle_cpuid(struct kvm_vcpu *vcpu)
-{
-=09return kvm_emulate_cpuid(vcpu);
-}
-
-static int handle_rdmsr(struct kvm_vcpu *vcpu)
-{
-=09return kvm_emulate_rdmsr(vcpu);
-}
-
-static int handle_wrmsr(struct kvm_vcpu *vcpu)
-{
-=09return kvm_emulate_wrmsr(vcpu);
-}
-
 static int handle_tpr_below_threshold(struct kvm_vcpu *vcpu)
 {
 =09kvm_apic_update_ppr(vcpu);
@@ -4996,11 +4981,6 @@ static int handle_interrupt_window(struct kvm_vcpu *=
vcpu)
 =09return 1;
 }
=20
-static int handle_halt(struct kvm_vcpu *vcpu)
-{
-=09return kvm_emulate_halt(vcpu);
-}
-
 static int handle_vmcall(struct kvm_vcpu *vcpu)
 {
 =09return kvm_emulate_hypercall(vcpu);
@@ -5548,11 +5528,11 @@ static int (*kvm_vmx_exit_handlers[])(struct kvm_vc=
pu *vcpu) =3D {
 =09[EXIT_REASON_IO_INSTRUCTION]          =3D handle_io,
 =09[EXIT_REASON_CR_ACCESS]               =3D handle_cr,
 =09[EXIT_REASON_DR_ACCESS]               =3D handle_dr,
-=09[EXIT_REASON_CPUID]                   =3D handle_cpuid,
-=09[EXIT_REASON_MSR_READ]                =3D handle_rdmsr,
-=09[EXIT_REASON_MSR_WRITE]               =3D handle_wrmsr,
+=09[EXIT_REASON_CPUID]                   =3D kvm_emulate_cpuid,
+=09[EXIT_REASON_MSR_READ]                =3D kvm_emulate_rdmsr,
+=09[EXIT_REASON_MSR_WRITE]               =3D kvm_emulate_wrmsr,
 =09[EXIT_REASON_PENDING_INTERRUPT]       =3D handle_interrupt_window,
-=09[EXIT_REASON_HLT]                     =3D handle_halt,
+=09[EXIT_REASON_HLT]                     =3D kvm_emulate_halt,
 =09[EXIT_REASON_INVD]=09=09      =3D handle_invd,
 =09[EXIT_REASON_INVLPG]=09=09      =3D handle_invlpg,
 =09[EXIT_REASON_RDPMC]                   =3D handle_rdpmc,

