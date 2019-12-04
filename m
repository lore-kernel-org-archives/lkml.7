Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A52C2D0B1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 20:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6AD1218AC
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 20:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YVTQgY1y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbfLDUov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 15:44:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32885 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727911AbfLDUou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 15:44:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575492289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l2YEk5cwsZz1UE3QUcoyQVivBnXjlS4sWD+akWvYinI=;
        b=YVTQgY1yvIJfN38otZ5VPbNIqYjwCfWbMPQQQCo+MpsLEZs7mwMRzlS0rWGta48hTi1YQh
        M4UIgsHsJ3oqur7b+YH0yu/72hIOrgjdYXTqV+X8YGy9L1n65IhHgoTlrPtmGqQdP4nD7x
        Jll0Ss17WSaDsvaw/oifjIABXLGNlfo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-hOPwBX_pOLC879bhLu4dwQ-1; Wed, 04 Dec 2019 15:44:48 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26298DBE6;
        Wed,  4 Dec 2019 20:44:47 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-117.ams2.redhat.com [10.36.116.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4E8B9694A1;
        Wed,  4 Dec 2019 20:44:43 +0000 (UTC)
From:   Eric Auger <eric.auger@redhat.com>
To:     eric.auger.pro@gmail.com, eric.auger@redhat.com, maz@kernel.org,
        linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Cc:     james.morse@arm.com, andrew.murray@arm.com, suzuki.poulose@arm.com,
        drjones@redhat.com
Subject: [RFC 2/3] KVM: arm64: pmu: Fix chained SW_INCR counters
Date:   Wed,  4 Dec 2019 21:44:25 +0100
Message-Id: <20191204204426.9628-3-eric.auger@redhat.com>
In-Reply-To: <20191204204426.9628-1-eric.auger@redhat.com>
References: <20191204204426.9628-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: hOPwBX_pOLC879bhLu4dwQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment a SW_INCR counter always overflows on 32-bit
boundary, independently on whether the n+1th counter is
programmed as CHAIN.

Check whether the SW_INCR counter is a 64b counter and if so,
implement the 64b logic.

Fixes: 80f393a23be6 ("KVM: arm/arm64: Support chained PMU counters")
Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 virt/kvm/arm/pmu.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
index c3f8b059881e..7ab477db2f75 100644
--- a/virt/kvm/arm/pmu.c
+++ b/virt/kvm/arm/pmu.c
@@ -491,6 +491,8 @@ void kvm_pmu_software_increment(struct kvm_vcpu *vcpu, =
u64 val)
=20
 =09enable =3D __vcpu_sys_reg(vcpu, PMCNTENSET_EL0);
 =09for (i =3D 0; i < ARMV8_PMU_CYCLE_IDX; i++) {
+=09=09bool chained =3D test_bit(i >> 1, vcpu->arch.pmu.chained);
+
 =09=09if (!(val & BIT(i)))
 =09=09=09continue;
 =09=09type =3D __vcpu_sys_reg(vcpu, PMEVTYPER0_EL0 + i)
@@ -500,8 +502,20 @@ void kvm_pmu_software_increment(struct kvm_vcpu *vcpu,=
 u64 val)
 =09=09=09reg =3D __vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i) + 1;
 =09=09=09reg =3D lower_32_bits(reg);
 =09=09=09__vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i) =3D reg;
-=09=09=09if (!reg)
+=09=09=09if (reg) /* no overflow */
+=09=09=09=09continue;
+=09=09=09if (chained) {
+=09=09=09=09reg =3D __vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i + 1) + 1;
+=09=09=09=09reg =3D lower_32_bits(reg);
+=09=09=09=09__vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i + 1) =3D reg;
+=09=09=09=09if (reg)
+=09=09=09=09=09continue;
+=09=09=09=09/* mark an overflow on high counter */
+=09=09=09=09__vcpu_sys_reg(vcpu, PMOVSSET_EL0) |=3D BIT(i + 1);
+=09=09=09} else {
+=09=09=09=09/* mark an overflow */
 =09=09=09=09__vcpu_sys_reg(vcpu, PMOVSSET_EL0) |=3D BIT(i);
+=09=09=09}
 =09=09}
 =09}
 }
--=20
2.20.1

