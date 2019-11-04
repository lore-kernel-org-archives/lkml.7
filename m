Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C25CA9ED3
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 23:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFE7420663
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 23:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="auJTpblf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387411AbfKDXAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 18:00:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52154 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730094AbfKDXAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 18:00:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572908414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iTr27IQdavuGNLXbOWTD/Ig9akRCUdhnHXeA7w4Wy5w=;
        b=auJTpblfzx/tucZ1iNPsoW26ryeUoMqqKetNAy1aQgF4NzDcLH4DhFfy/pDQpAA5i2bIFF
        TrWoMyFqmQ0vB9HMlcO4poEVM3ZPcSFxKwdOnFY1sVYinSEVV8knEkYJpd9C9ZBT7X1tAd
        Q/unPGLvSUK0HcEsCIfTXb+qdPnVqkw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-0FcWTpJVP6qsaDpEdFTbnA-1; Mon, 04 Nov 2019 18:00:11 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2BB65EA;
        Mon,  4 Nov 2019 23:00:09 +0000 (UTC)
Received: from mail (ovpn-121-157.rdu2.redhat.com [10.10.121.157])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 49C6060BF3;
        Mon,  4 Nov 2019 23:00:09 +0000 (UTC)
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH 11/13] KVM: retpolines: x86: eliminate retpoline from vmx.c exit handlers
Date:   Mon,  4 Nov 2019 17:59:59 -0500
Message-Id: <20191104230001.27774-12-aarcange@redhat.com>
In-Reply-To: <20191104230001.27774-1-aarcange@redhat.com>
References: <20191104230001.27774-1-aarcange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 0FcWTpJVP6qsaDpEdFTbnA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's enough to check the exit value and issue a direct call to avoid
the retpoline for all the common vmexit reasons.

Of course CONFIG_RETPOLINE already forbids gcc to use indirect jumps
while compiling all switch() statements, however switch() would still
allow the compiler to bisect the case value. It's more efficient to
prioritize the most frequent vmexits instead.

The halt may be slow paths from the point of the guest, but not
necessarily so from the point of the host if the host runs at full CPU
capacity and no host CPU is ever left idle.

Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
---
 arch/x86/kvm/vmx/vmx.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index a6afa5f4a01c..582f837dc8c2 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5905,9 +5905,23 @@ int kvm_x86_handle_exit(struct kvm_vcpu *vcpu)
 =09}
=20
 =09if (exit_reason < kvm_vmx_max_exit_handlers
-=09    && kvm_vmx_exit_handlers[exit_reason])
+=09    && kvm_vmx_exit_handlers[exit_reason]) {
+#ifdef CONFIG_RETPOLINE
+=09=09if (exit_reason =3D=3D EXIT_REASON_MSR_WRITE)
+=09=09=09return kvm_emulate_wrmsr(vcpu);
+=09=09else if (exit_reason =3D=3D EXIT_REASON_PREEMPTION_TIMER)
+=09=09=09return handle_preemption_timer(vcpu);
+=09=09else if (exit_reason =3D=3D EXIT_REASON_PENDING_INTERRUPT)
+=09=09=09return handle_interrupt_window(vcpu);
+=09=09else if (exit_reason =3D=3D EXIT_REASON_EXTERNAL_INTERRUPT)
+=09=09=09return handle_external_interrupt(vcpu);
+=09=09else if (exit_reason =3D=3D EXIT_REASON_HLT)
+=09=09=09return kvm_emulate_halt(vcpu);
+=09=09else if (exit_reason =3D=3D EXIT_REASON_EPT_MISCONFIG)
+=09=09=09return handle_ept_misconfig(vcpu);
+#endif
 =09=09return kvm_vmx_exit_handlers[exit_reason](vcpu);
-=09else {
+=09} else {
 =09=09vcpu_unimpl(vcpu, "vmx: unexpected exit reason 0x%x\n",
 =09=09=09=09exit_reason);
 =09=09dump_vmcs();

