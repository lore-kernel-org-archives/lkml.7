Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288DDCA9ED4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 23:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7453204EC
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 23:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ciGNdCr5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730082AbfKDXAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 18:00:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33854 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730009AbfKDXAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 18:00:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572908412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N9AzTCz7VYWqu+O1g8R1BaaHUGHR9Ucr0dBlgPM9xNc=;
        b=ciGNdCr5GTued1ftmHd5XPGuG2Mn9FNAEAMiulF+1+BoftrC8/9pcMSe5ZaQcq+3bmAUFD
        gzQeeP0ntZfADrrfbnBrCRBYcmdSFKlprLtjCYa9mwp9+K7aUyLGGO8tg/AD1qXojmJbhv
        vwmvRnwJw0ZvDNMKOmxtxTWe8XlMqKE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-eiOOitc7MEmU_eGNTeYP_g-1; Mon, 04 Nov 2019 18:00:10 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ADA66107ACC3;
        Mon,  4 Nov 2019 23:00:08 +0000 (UTC)
Received: from mail (ovpn-121-157.rdu2.redhat.com [10.10.121.157])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C9224600C6;
        Mon,  4 Nov 2019 23:00:02 +0000 (UTC)
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH 03/13] kvm: monolithic: fixup x86-32 build
Date:   Mon,  4 Nov 2019 17:59:51 -0500
Message-Id: <20191104230001.27774-4-aarcange@redhat.com>
In-Reply-To: <20191104230001.27774-1-aarcange@redhat.com>
References: <20191104230001.27774-1-aarcange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: eiOOitc7MEmU_eGNTeYP_g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kvm_x86_set_hv_timer and kvm_x86_cancel_hv_timer needs to be defined
to succeed the 32bit kernel build, but they can't be called.

Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
---
 arch/x86/kvm/vmx/vmx.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index bd17ad61f7e3..1a58ae38c8f2 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7195,6 +7195,17 @@ void kvm_x86_cancel_hv_timer(struct kvm_vcpu *vcpu)
 {
 =09to_vmx(vcpu)->hv_deadline_tsc =3D -1;
 }
+#else
+int kvm_x86_set_hv_timer(struct kvm_vcpu *vcpu, u64 guest_deadline_tsc,
+=09=09=09 bool *expired)
+{
+=09BUG();
+}
+
+void kvm_x86_cancel_hv_timer(struct kvm_vcpu *vcpu)
+{
+=09BUG();
+}
 #endif
=20
 void kvm_x86_sched_in(struct kvm_vcpu *vcpu, int cpu)

