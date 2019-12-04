Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA87C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 20:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21F102231B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 20:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HzLtdA3k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbfLDUoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 15:44:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34183 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727911AbfLDUoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 15:44:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575492292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1HSSxylw+ml72S+tggNSNZjvCbGfb9EILB6DT2G4aGg=;
        b=HzLtdA3kQ49KuyG1St4386WLneAJXgpVdPDiBdlBJLTik8qk+nwlppIUXcDOynSgCkDy8m
        yj+RcsyZG/mWJsVnIio4orveN5m8KGFyGpxjny8HDOSeo546ew0dHL9YNHASZ7SzsvX/uG
        PnNXyjE+5rgQJGzkZhlYEYPaGUWpWVU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-mZ8JF3-HOMaWnAVM9fm54Q-1; Wed, 04 Dec 2019 15:44:51 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 54E4D1005502;
        Wed,  4 Dec 2019 20:44:50 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-117.ams2.redhat.com [10.36.116.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9C9C869192;
        Wed,  4 Dec 2019 20:44:47 +0000 (UTC)
From:   Eric Auger <eric.auger@redhat.com>
To:     eric.auger.pro@gmail.com, eric.auger@redhat.com, maz@kernel.org,
        linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Cc:     james.morse@arm.com, andrew.murray@arm.com, suzuki.poulose@arm.com,
        drjones@redhat.com
Subject: [RFC 3/3] KVM: arm64: pmu: Enforce PMEVTYPER evtCount size
Date:   Wed,  4 Dec 2019 21:44:26 +0100
Message-Id: <20191204204426.9628-4-eric.auger@redhat.com>
In-Reply-To: <20191204204426.9628-1-eric.auger@redhat.com>
References: <20191204204426.9628-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: mZ8JF3-HOMaWnAVM9fm54Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARMv8.1-PMU supports 16-bit evtCount whereas 8.0 only supports
10 bits.

On Seatlle which has an 8.0 PMU implementation, evtCount[15:10]
are not read as 0, as expected. Fix that by applying a mask on
the selected event that depends on the PMU version.

Also remove a redundant __vcpu_sys_reg() assignment (already
done in kvm_pmu_set_counter_even_type()).

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 arch/arm64/include/asm/perf_event.h |  5 ++++-
 arch/arm64/include/asm/sysreg.h     |  5 +++++
 arch/arm64/kernel/perf_event.c      |  2 +-
 arch/arm64/kvm/sys_regs.c           | 14 ++++++++++----
 4 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/perf_event.h b/arch/arm64/include/asm/p=
erf_event.h
index 2bdbc79bbd01..37ad1d654d2a 100644
--- a/arch/arm64/include/asm/perf_event.h
+++ b/arch/arm64/include/asm/perf_event.h
@@ -189,7 +189,10 @@
 /*
  * PMXEVTYPER: Event selection reg
  */
-#define=09ARMV8_PMU_EVTYPE_MASK=090xc800ffff=09/* Mask for writable bits *=
/
+/* Mask for writable bits featuring 10b evtCount (ARMv8.0-PMU)*/
+#define=09ARMV8_PMU_EVTYPE_MASK=090xc80003ff
+/* Mask for writable bits featuring 16b evtCount (ARMv8.1-PMU)*/
+#define ARMV8_1_PMU_EVTYPE_MASK=090xc800ffff
 #define=09ARMV8_PMU_EVTYPE_EVENT=090xffff=09=09/* Mask for EVENT bits */
=20
 /*
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysre=
g.h
index 6e919fafb43d..e01b3e3acdf6 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -672,6 +672,11 @@
 #define ID_AA64DFR0_TRACEVER_SHIFT=094
 #define ID_AA64DFR0_DEBUGVER_SHIFT=090
=20
+#define ID_AA64DFR0_PMUVER_NOT_IMPL=090x0
+#define ID_AA64DFR0_PMUVER_8_0=09=090x1
+#define ID_AA64DFR0_PMUVER_8_1=09=090x4
+#define ID_AA64DFR0_PMUVER_IMPL_DEF=090xF
+
 #define ID_ISAR5_RDM_SHIFT=09=0924
 #define ID_ISAR5_CRC32_SHIFT=09=0916
 #define ID_ISAR5_SHA2_SHIFT=09=0912
diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.=
c
index e40b65645c86..d5fe56190ad3 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -425,7 +425,7 @@ static void armv8pmu_write_counter(struct perf_event *e=
vent, u64 value)
 static inline void armv8pmu_write_evtype(int idx, u32 val)
 {
 =09armv8pmu_select_counter(idx);
-=09val &=3D ARMV8_PMU_EVTYPE_MASK;
+=09val &=3D ARMV8_1_PMU_EVTYPE_MASK;
 =09write_sysreg(val, pmxevtyper_el0);
 }
=20
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 46822afc57e0..8deb6485d605 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -815,11 +815,17 @@ static bool access_pmu_evcntr(struct kvm_vcpu *vcpu,
 static bool access_pmu_evtyper(struct kvm_vcpu *vcpu, struct sys_reg_param=
s *p,
 =09=09=09       const struct sys_reg_desc *r)
 {
-=09u64 idx, reg;
+=09unsigned int pmuver;
+=09u64 idx, reg, dfr0, evtype_mask;
=20
 =09if (!kvm_arm_pmu_v3_ready(vcpu))
 =09=09return trap_raz_wi(vcpu, p, r);
=20
+=09dfr0 =3D read_sanitised_ftr_reg(SYS_ID_AA64DFR0_EL1);
+=09pmuver =3D cpuid_feature_extract_unsigned_field(dfr0,
+=09=09=09=09=09=09      ID_AA64DFR0_PMUVER_SHIFT);
+=09evtype_mask =3D (pmuver =3D=3D ID_AA64DFR0_PMUVER_8_0) ?
+=09=09=09ARMV8_PMU_EVTYPE_MASK : ARMV8_1_PMU_EVTYPE_MASK;
 =09if (pmu_access_el0_disabled(vcpu))
 =09=09return false;
=20
@@ -842,11 +848,11 @@ static bool access_pmu_evtyper(struct kvm_vcpu *vcpu,=
 struct sys_reg_params *p,
 =09=09return false;
=20
 =09if (p->is_write) {
-=09=09kvm_pmu_set_counter_event_type(vcpu, p->regval, idx);
-=09=09__vcpu_sys_reg(vcpu, reg) =3D p->regval & ARMV8_PMU_EVTYPE_MASK;
+=09=09kvm_pmu_set_counter_event_type(vcpu,
+=09=09=09=09=09       p->regval & evtype_mask, idx);
 =09=09kvm_vcpu_pmu_restore_guest(vcpu);
 =09} else {
-=09=09p->regval =3D __vcpu_sys_reg(vcpu, reg) & ARMV8_PMU_EVTYPE_MASK;
+=09=09p->regval =3D __vcpu_sys_reg(vcpu, reg) & evtype_mask;
 =09}
=20
 =09return true;
--=20
2.20.1

