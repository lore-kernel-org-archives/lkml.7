Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CB3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B834A2070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Vizm6Ueo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733213AbfCVMsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:48:14 -0400
Received: from mail-eopbgr750053.outbound.protection.outlook.com ([40.107.75.53]:65282
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732855AbfCVL5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:57:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jg+5LF+hGiRJgBVGwIy+/QdCK9IT8A1B38ggtPjuyyU=;
 b=Vizm6Ueo3vGSW8gVO6MpUx4UPe+XH6s9JsYQk03b1FCFDpL7fXGv+KsRJBfzzS0I15P4kG7n0TIic3XkuXxzOciqNb31Z5id/Ixx8Wqq97r8vruNANXJSI7Wtx/xeL/l9QcL//QPkku5U2FEJAoWVRPvSglGP1mXWd+KtpcbrRc=
Received: from DM6PR12MB2844.namprd12.prod.outlook.com (20.176.117.96) by
 DM6PR12MB2811.namprd12.prod.outlook.com (20.176.117.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.15; Fri, 22 Mar 2019 11:57:37 +0000
Received: from DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::3589:a066:e1d:b1f0]) by DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::3589:a066:e1d:b1f0%5]) with mapi id 15.20.1709.015; Fri, 22 Mar 2019
 11:57:37 +0000
From:   "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Subject: [PATCH 5/6] KVM: x86: Add interface for run-time activate/de-activate
 APIC virtualization
Thread-Topic: [PATCH 5/6] KVM: x86: Add interface for run-time
 activate/de-activate APIC virtualization
Thread-Index: AQHU4KZxvEXsSaT7I0eWBkO/ZFGgyw==
Date:   Fri, 22 Mar 2019 11:57:37 +0000
Message-ID: <20190322115702.10166-6-suravee.suthikulpanit@amd.com>
References: <20190322115702.10166-1-suravee.suthikulpanit@amd.com>
In-Reply-To: <20190322115702.10166-1-suravee.suthikulpanit@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.121.138.205]
x-clientproxiedby: SG2P274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::34)
 To DM6PR12MB2844.namprd12.prod.outlook.com (2603:10b6:5:45::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 11fa066c-3131-4765-76b3-08d6aebd93cc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB2811;
x-ms-traffictypediagnostic: DM6PR12MB2811:
x-microsoft-antispam-prvs: <DM6PR12MB2811A15A9EB85DAFC228868AF3430@DM6PR12MB2811.namprd12.prod.outlook.com>
x-forefront-prvs: 09840A4839
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(346002)(396003)(376002)(199004)(189003)(52116002)(71190400001)(86362001)(105586002)(7736002)(5660300002)(186003)(106356001)(53936002)(25786009)(76176011)(316002)(4326008)(14454004)(71200400001)(99286004)(110136005)(97736004)(102836004)(26005)(54906003)(386003)(2906002)(11346002)(478600001)(2501003)(66066001)(6486002)(6512007)(6506007)(68736007)(14444005)(256004)(446003)(36756003)(476003)(72206003)(486006)(1076003)(6116002)(81156014)(3846002)(8936002)(2616005)(8676002)(81166006)(305945005)(50226002)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2811;H:DM6PR12MB2844.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xwGiBL4vSLELwvekGqf7IBlXLzICY/ylXjW8iz4BurAE6rimi8hQQ+plFvnSTCnJ91mOLYk9WJmJAlVLy2Ris0aNTPPkxvDRPT3ho8wZiIaaWNd4movk+gdqLYXe8HBGUUWCto2S9iS8nRgaPCOemoWqBfjD0nlzS/sWxVE/x4WtGmLTwHHpkQK1KfixZ/1Kneal5tG/be9lgBOLInCEcKIdLaPmycA7xi0V+MQp4hD507rOOdYAf/uQAcrfw134jxkoMxqMZz/31S4vIgdlpS2LPqLWX6w4iCUryw7ejb772hXmV/ReTTh15ByXsKUNmaeg/2Ew7gyJqcdfLYoG5YFMNQY4TC3hxyMn7+bh4sysOdEqMUnadb9dmmtOp9iZ3GFIsZLBovCd4erTw8y2Cq7KAGEiuNF1spqW6hf8xvg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11fa066c-3131-4765-76b3-08d6aebd93cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2019 11:57:37.5699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2811
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When activate / deactivate AVIC during runtime, all vcpus has to be
operating in the same mode. So, introduce new interface to request
all vCPUs to activate/deactivate APICV.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 arch/x86/include/asm/kvm_host.h |  8 ++++++
 arch/x86/kvm/x86.c              | 48 +++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_hos=
t.h
index 1906e205e6a3..31dee26a37f2 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -79,6 +79,10 @@
 #define KVM_REQ_HV_STIMER		KVM_ARCH_REQ(22)
 #define KVM_REQ_LOAD_EOI_EXITMAP	KVM_ARCH_REQ(23)
 #define KVM_REQ_GET_VMCS12_PAGES	KVM_ARCH_REQ(24)
+#define KVM_REQ_APICV_ACTIVATE		\
+	KVM_ARCH_REQ_FLAGS(25, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
+#define KVM_REQ_APICV_DEACTIVATE	\
+	KVM_ARCH_REQ_FLAGS(26, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
=20
 #define CR0_RESERVED_BITS                                               \
 	(~(unsigned long)(X86_CR0_PE | X86_CR0_MP | X86_CR0_EM | X86_CR0_TS \
@@ -1537,6 +1541,10 @@ bool kvm_is_linear_rip(struct kvm_vcpu *vcpu, unsign=
ed long linear_rip);
=20
 void kvm_make_mclock_inprogress_request(struct kvm *kvm);
 void kvm_make_scan_ioapic_request(struct kvm *kvm);
+void kvm_vcpu_deactivate_apicv(struct kvm_vcpu *vcpu);
+void kvm_vcpu_activate_apicv(struct kvm_vcpu *vcpu);
+void kvm_make_apicv_activate_request(struct kvm *kvm);
+void kvm_make_apicv_deactivate_request(struct kvm *kvm);
=20
 void kvm_arch_async_page_not_present(struct kvm_vcpu *vcpu,
 				     struct kvm_async_pf *work);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 65e4559eef2f..1cd49c394680 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -29,6 +29,7 @@
 #include "cpuid.h"
 #include "pmu.h"
 #include "hyperv.h"
+#include "lapic.h"
=20
 #include <linux/clocksource.h>
 #include <linux/interrupt.h>
@@ -7054,6 +7055,22 @@ static void kvm_pv_kick_cpu_op(struct kvm *kvm, unsi=
gned long flags, int apicid)
 	kvm_irq_delivery_to_apic(kvm, NULL, &lapic_irq, NULL);
 }
=20
+void kvm_vcpu_activate_apicv(struct kvm_vcpu *vcpu)
+{
+	if (!lapic_in_kernel(vcpu)) {
+		WARN_ON_ONCE(!vcpu->arch.apicv_active);
+		return;
+	}
+	if (vcpu->arch.apicv_active)
+		return;
+
+	vcpu->arch.apicv_active =3D true;
+	kvm_apic_update_apicv(vcpu);
+
+	kvm_x86_ops->refresh_apicv_exec_ctrl(vcpu);
+}
+EXPORT_SYMBOL_GPL(kvm_vcpu_activate_apicv);
+
 void kvm_vcpu_deactivate_apicv(struct kvm_vcpu *vcpu)
 {
 	if (!lapic_in_kernel(vcpu)) {
@@ -7064,8 +7081,11 @@ void kvm_vcpu_deactivate_apicv(struct kvm_vcpu *vcpu=
)
 		return;
=20
 	vcpu->arch.apicv_active =3D false;
+	kvm_apic_update_apicv(vcpu);
+
 	kvm_x86_ops->refresh_apicv_exec_ctrl(vcpu);
 }
+EXPORT_SYMBOL_GPL(kvm_vcpu_deactivate_apicv);
=20
 int kvm_emulate_hypercall(struct kvm_vcpu *vcpu)
 {
@@ -7557,6 +7577,30 @@ void kvm_make_scan_ioapic_request(struct kvm *kvm)
 	kvm_make_all_cpus_request(kvm, KVM_REQ_SCAN_IOAPIC);
 }
=20
+void kvm_make_apicv_activate_request(struct kvm *kvm)
+{
+	int i;
+	struct kvm_vcpu *v;
+
+	kvm_for_each_vcpu(i, v, kvm)
+		kvm_clear_request(KVM_REQ_APICV_DEACTIVATE, v);
+
+	kvm_make_all_cpus_request(kvm, KVM_REQ_APICV_ACTIVATE);
+}
+EXPORT_SYMBOL_GPL(kvm_make_apicv_activate_request);
+
+void kvm_make_apicv_deactivate_request(struct kvm *kvm)
+{
+	int i;
+	struct kvm_vcpu *v;
+
+	kvm_for_each_vcpu(i, v, kvm)
+		kvm_clear_request(KVM_REQ_APICV_ACTIVATE, v);
+
+	kvm_make_all_cpus_request(kvm, KVM_REQ_APICV_DEACTIVATE);
+}
+EXPORT_SYMBOL_GPL(kvm_make_apicv_deactivate_request);
+
 static void vcpu_scan_ioapic(struct kvm_vcpu *vcpu)
 {
 	if (!kvm_apic_present(vcpu))
@@ -7743,6 +7787,10 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		 */
 		if (kvm_check_request(KVM_REQ_HV_STIMER, vcpu))
 			kvm_hv_process_stimers(vcpu);
+		if (kvm_check_request(KVM_REQ_APICV_ACTIVATE, vcpu))
+			kvm_vcpu_activate_apicv(vcpu);
+		if (kvm_check_request(KVM_REQ_APICV_DEACTIVATE, vcpu))
+			kvm_vcpu_deactivate_apicv(vcpu);
 	}
=20
 	if (kvm_check_request(KVM_REQ_EVENT, vcpu) || req_int_win) {
--=20
2.17.1

