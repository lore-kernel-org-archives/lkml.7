Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F42CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C729620850
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GQjoZWmb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387741AbfCVL5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:57:50 -0400
Received: from mail-eopbgr750053.outbound.protection.outlook.com ([40.107.75.53]:65282
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387727AbfCVL5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:57:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9MBg3vhCyXP9E/XJjaY2aKe7h0y50vZnSbqBnb3q/c=;
 b=GQjoZWmbjQV0MdxqUY5yw2hO/cSdwHJso/FLlJfSUzCp86O3GYNfyCB8ekkNzudHoIUVsuBRxvfgeJ0+Q4mmm0TAvRxauQhiU1r1nkRtO/7TP0vqULaT3qRxKJnP+4etMmb4uuEJp2iR2+S3xSrKkgtH1qW+oKskqTL51scstHA=
Received: from DM6PR12MB2844.namprd12.prod.outlook.com (20.176.117.96) by
 DM6PR12MB2811.namprd12.prod.outlook.com (20.176.117.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.15; Fri, 22 Mar 2019 11:57:40 +0000
Received: from DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::3589:a066:e1d:b1f0]) by DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::3589:a066:e1d:b1f0%5]) with mapi id 15.20.1709.015; Fri, 22 Mar 2019
 11:57:40 +0000
From:   "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Subject: [PATCH 6/6] svm: Temporary deactivate AVIC during ExtINT handling
Thread-Topic: [PATCH 6/6] svm: Temporary deactivate AVIC during ExtINT
 handling
Thread-Index: AQHU4KZzfF+I1STPkEG8oeMRWodS5g==
Date:   Fri, 22 Mar 2019 11:57:40 +0000
Message-ID: <20190322115702.10166-7-suravee.suthikulpanit@amd.com>
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
x-ms-office365-filtering-correlation-id: ecf4cd2d-8ed1-4e90-e2c0-08d6aebd9592
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB2811;
x-ms-traffictypediagnostic: DM6PR12MB2811:
x-microsoft-antispam-prvs: <DM6PR12MB2811D7D8222B85CA47DDC58CF3430@DM6PR12MB2811.namprd12.prod.outlook.com>
x-forefront-prvs: 09840A4839
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(346002)(396003)(376002)(199004)(189003)(52116002)(71190400001)(86362001)(105586002)(7736002)(5660300002)(186003)(106356001)(53936002)(25786009)(76176011)(316002)(4326008)(14454004)(71200400001)(99286004)(110136005)(97736004)(102836004)(26005)(54906003)(386003)(2906002)(11346002)(478600001)(2501003)(66066001)(6486002)(6512007)(6506007)(68736007)(14444005)(256004)(446003)(36756003)(476003)(72206003)(486006)(1076003)(6116002)(81156014)(3846002)(8936002)(2616005)(8676002)(81166006)(305945005)(50226002)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2811;H:DM6PR12MB2844.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ieQo4dURgEPQGk5uHMsJ0xtr8kreQzlErpX0BPMFCBKqflZ7yOa8WvjrLa9hN+BiSXhlF8shnFxE3QJnMOWWvWmGBD5fhM0h437cxW9GmBSnQESriTC3worjWGNGaIPasA0VfynYKUSCQVNzGSbMHA+8CC59DBGZQhzGeBIvpFb6jjkD0ynXqRMPkeH0dHflJbfSHtbCEG7S+hxxytyr+8VFbXSw0TfF1UKVsrB4vjJXgakZd9cmgSPhVXmbRhW4RmWnD/cyerXBryjCWJGg91THjeCcmfAa4gm7i8Lz3qxiMaYsVwcQw+vW6virVTH9pGkB+AAoSa8LjOfdifHy3R9Bghi37zBf6Uzn53gzoleNlVUbwuCOi1MmG8FHviXeIxUZehDykPIODD36AOfbPyvpSPRacv1Zi3NR+Tj3+DA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecf4cd2d-8ed1-4e90-e2c0-08d6aebd9592
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2019 11:57:40.5340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2811
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD AVIC does not support ExtINT. Therefore, AVIC must be temporary
deactivated and fall back to using legacy interrupt injection via
vINTR and interrupt window.

Introduce svm_request_activate/deactivate_avic() helper functions,
which handle steps required to activate/deactivate AVIC.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 arch/x86/kvm/svm.c | 57 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 54 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index f41f34f70dde..84116e689d5f 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -391,6 +391,8 @@ static u8 rsm_ins_bytes[] =3D "\x0f\xaa";
 static void svm_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0);
 static void svm_flush_tlb(struct kvm_vcpu *vcpu, bool invalidate_gpa);
 static void svm_complete_interrupts(struct vcpu_svm *svm);
+static void svm_request_activate_avic(struct kvm_vcpu *vcpu);
+static bool svm_get_enable_apicv(struct kvm_vcpu *vcpu);
=20
 static int nested_svm_exit_handled(struct vcpu_svm *svm);
 static int nested_svm_intercept(struct vcpu_svm *svm);
@@ -2109,6 +2111,9 @@ static void avic_set_running(struct kvm_vcpu *vcpu, b=
ool is_run)
 {
 	struct vcpu_svm *svm =3D to_svm(vcpu);
=20
+	if (!kvm_vcpu_apicv_active(vcpu))
+		return;
+
 	svm->avic_is_running =3D is_run;
 	if (is_run)
 		avic_vcpu_load(vcpu, vcpu->cpu);
@@ -2356,6 +2361,10 @@ static void svm_vcpu_blocking(struct kvm_vcpu *vcpu)
=20
 static void svm_vcpu_unblocking(struct kvm_vcpu *vcpu)
 {
+	if (kvm_check_request(KVM_REQ_APICV_ACTIVATE, vcpu))
+		kvm_vcpu_activate_apicv(vcpu);
+	if (kvm_check_request(KVM_REQ_APICV_DEACTIVATE, vcpu))
+		kvm_vcpu_deactivate_apicv(vcpu);
 	avic_set_running(vcpu, true);
 }
=20
@@ -4505,6 +4514,15 @@ static int interrupt_window_interception(struct vcpu=
_svm *svm)
 {
 	kvm_make_request(KVM_REQ_EVENT, &svm->vcpu);
 	svm_clear_vintr(svm);
+
+	/*
+	 * For AVIC, the only reason to end up here is ExtINTs.
+	 * In this case AVIC was temporarily disabled for
+	 * requesting the IRQ window and we have to re-enable it.
+	 */
+	if (svm_get_enable_apicv(&svm->vcpu))
+		svm_request_activate_avic(&svm->vcpu);
+
 	svm->vmcb->control.int_ctl &=3D ~V_IRQ_MASK;
 	mark_dirty(svm->vmcb, VMCB_INTR);
 	++svm->vcpu.stat.irq_window_exits;
@@ -5206,6 +5224,34 @@ static void svm_hwapic_isr_update(struct kvm_vcpu *v=
cpu, int max_isr)
 {
 }
=20
+static bool is_avic_active(struct vcpu_svm *svm)
+{
+	return (svm_get_enable_apicv(&svm->vcpu) &&
+		svm->vmcb->control.int_ctl & AVIC_ENABLE_MASK);
+}
+
+static void svm_request_activate_avic(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm =3D to_svm(vcpu);
+
+	if (!lapic_in_kernel(vcpu) || is_avic_active(svm))
+		return;
+
+	avic_setup_access_page(vcpu, false);
+	kvm_make_apicv_activate_request(vcpu->kvm);
+}
+
+static void svm_request_deactivate_avic(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm =3D to_svm(vcpu);
+
+	if (!lapic_in_kernel(vcpu) || !is_avic_active(svm))
+		return;
+
+	avic_destroy_access_page(vcpu);
+	kvm_make_apicv_deactivate_request(vcpu->kvm);
+}
+
 /* Note: Currently only used by Hyper-V. */
 static void svm_refresh_apicv_exec_ctrl(struct kvm_vcpu *vcpu)
 {
@@ -5493,9 +5539,6 @@ static void enable_irq_window(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm =3D to_svm(vcpu);
=20
-	if (kvm_vcpu_apicv_active(vcpu))
-		return;
-
 	/*
 	 * In case GIF=3D0 we can't rely on the CPU to tell us when GIF becomes
 	 * 1, because that's a separate STGI/VMRUN intercept.  The next time we
@@ -5505,6 +5548,14 @@ static void enable_irq_window(struct kvm_vcpu *vcpu)
 	 * window under the assumption that the hardware will set the GIF.
 	 */
 	if ((vgif_enabled(svm) || gif_set(svm)) && nested_svm_intr(svm)) {
+		/*
+		 * IRQ window is not needed when AVIC is enabled,
+		 * unless we have pending ExtINT since it cannot be injected
+		 * via AVIC. In such case, we need to temporarily disable AVIC,
+		 * and fallback to injecting IRQ via V_IRQ.
+		 */
+		if (kvm_vcpu_apicv_active(vcpu))
+			svm_request_deactivate_avic(&svm->vcpu);
 		svm_set_vintr(svm);
 		svm_inject_irq(svm, 0x0);
 	}
--=20
2.17.1

