Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263E6CA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 23:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E630B204EC
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 23:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CtPfjDXn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730027AbfKDXAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 18:00:12 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30185 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729877AbfKDXAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 18:00:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572908410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=klZ1JFI1Q4aKLy/d85vcSQeQR1jyESDD5tgAOAEg+nk=;
        b=CtPfjDXnMstSbUPn260N1AEwt48UcWU0+IBlUVVeQK2Wg6R+MnjSkn4q7AV+sAEt12nM4T
        FJI1FMslRzNHQg8qED3lL57Adz96h+EQx+glyyk1gjFGTNJ9RzgjI+n4An/USQ2WLEplRv
        q9uAJZozzGYqWUjuHS4rsKYzln6qppQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-I1We5Z-7MSO-xcxC5jZicg-1; Mon, 04 Nov 2019 18:00:06 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 41F7D8017DD;
        Mon,  4 Nov 2019 23:00:05 +0000 (UTC)
Received: from mail (ovpn-121-157.rdu2.redhat.com [10.10.121.157])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CED3760BF3;
        Mon,  4 Nov 2019 23:00:02 +0000 (UTC)
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH 04/13] KVM: monolithic: x86: handle the request_immediate_exit variation
Date:   Mon,  4 Nov 2019 17:59:52 -0500
Message-Id: <20191104230001.27774-5-aarcange@redhat.com>
In-Reply-To: <20191104230001.27774-1-aarcange@redhat.com>
References: <20191104230001.27774-1-aarcange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: I1We5Z-7MSO-xcxC5jZicg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

request_immediate_exit is one of those few cases where the pointer to
function of the method isn't fixed at build time and it requires
special handling because hardware_setup() may override it at runtime.

Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
---
 arch/x86/kvm/vmx/vmx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 1a58ae38c8f2..9c5f0c67b899 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7103,7 +7103,10 @@ void kvm_x86_set_supported_cpuid(u32 func, struct kv=
m_cpuid_entry2 *entry)
=20
 void kvm_x86_request_immediate_exit(struct kvm_vcpu *vcpu)
 {
-=09to_vmx(vcpu)->req_immediate_exit =3D true;
+=09if (likely(enable_preemption_timer))
+=09=09to_vmx(vcpu)->req_immediate_exit =3D true;
+=09else
+=09=09__kvm_request_immediate_exit(vcpu);
 }
=20
 int kvm_x86_check_intercept(struct kvm_vcpu *vcpu,

