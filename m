Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2DDC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D681121939
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Aie1OQsz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387686AbfCVL5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:57:33 -0400
Received: from mail-eopbgr750052.outbound.protection.outlook.com ([40.107.75.52]:13379
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387651AbfCVL52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:57:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FoqCZhuokJ8fYQR9yV5vmEbiwjZrA225WeWXLHiPou8=;
 b=Aie1OQsz6VFzIZucUNs1/0tnjZysVfZTz3FFEqLdEOESZun4MmQCYyX4ntwCR4lehPOuluQsDwpdQlbWsDjPQQ76Qam1rIH/yrzaxVAm0flXWfO1FcJtYMJvo8Wu6hMoOPZSyqwfzagrzcst79eDhIkTKzFevXMEAikWzWlejt4=
Received: from DM6PR12MB2844.namprd12.prod.outlook.com (20.176.117.96) by
 DM6PR12MB2811.namprd12.prod.outlook.com (20.176.117.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.15; Fri, 22 Mar 2019 11:57:25 +0000
Received: from DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::3589:a066:e1d:b1f0]) by DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::3589:a066:e1d:b1f0%5]) with mapi id 15.20.1709.015; Fri, 22 Mar 2019
 11:57:25 +0000
From:   "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Subject: [PATCH 1/6] KVM: x86: Add callback functions for handling APIC ID,
 DFR and LDR update
Thread-Topic: [PATCH 1/6] KVM: x86: Add callback functions for handling APIC
 ID, DFR and LDR update
Thread-Index: AQHU4KZqWIh7CkaDPUGAVOVmco9DYg==
Date:   Fri, 22 Mar 2019 11:57:25 +0000
Message-ID: <20190322115702.10166-2-suravee.suthikulpanit@amd.com>
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
x-ms-office365-filtering-correlation-id: 3e280b44-3a9a-4daa-1a87-08d6aebd8cd0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB2811;
x-ms-traffictypediagnostic: DM6PR12MB2811:
x-microsoft-antispam-prvs: <DM6PR12MB28110228434A730D3E6C596CF3430@DM6PR12MB2811.namprd12.prod.outlook.com>
x-forefront-prvs: 09840A4839
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(346002)(396003)(376002)(199004)(189003)(52116002)(71190400001)(86362001)(105586002)(7736002)(5660300002)(186003)(106356001)(53936002)(25786009)(76176011)(316002)(4326008)(14454004)(71200400001)(99286004)(110136005)(97736004)(102836004)(26005)(54906003)(386003)(2906002)(11346002)(478600001)(2501003)(66066001)(6486002)(6512007)(6506007)(68736007)(14444005)(256004)(446003)(36756003)(476003)(72206003)(486006)(1076003)(6116002)(81156014)(3846002)(8936002)(2616005)(8676002)(81166006)(15650500001)(305945005)(50226002)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2811;H:DM6PR12MB2844.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: g4mQGaiAC3Wca0ATnMoeCN9UCYnhLiiyZBL7iJ3RTZKSj1Iir05YXgs0nMSFfWM4hDh8VrmjU9EBIT7JyKck6nRHDk9cPs9CzHVdWfIPJDcenIYeYtO6bAx/2vArKprTgq+RGhyPkFONZP5EfuBkcpYjzFTXC9jf72DnMVU/L9y/AxlHKmfOjpqb+2TmdlUNTXgWZCeDO7J+WO2fz2W/d4MwxT7cN1eTKQYnrCqt3zdwotcT1OePF6TolI2Bc2FdfWQl4oJb8Y4GjrZocIAMDgzV7PrC7iNCnKa5TmzeoNPl2e6Ju20FshV2r8FVZzJAYTv5ZFYTb3x0eEdpiUMBxDlI1OqbwKHdGRf6ahVcjrpBhsKgswCCNIdJsyaf/yAUIsm3ARGpGhuewzABN+ceXqN2pfiVely4W8NM4CgMyig=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e280b44-3a9a-4daa-1a87-08d6aebd8cd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2019 11:57:25.8297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2811
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add hooks for handling the case when guest VM update APIC ID, DFR and LDR.
This is needed during AMD AVIC is temporary deactivated.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 arch/x86/include/asm/kvm_host.h | 3 +++
 arch/x86/kvm/lapic.c            | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_hos=
t.h
index a5db4475e72d..1906e205e6a3 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1077,6 +1077,9 @@ struct kvm_x86_ops {
 	void (*refresh_apicv_exec_ctrl)(struct kvm_vcpu *vcpu);
 	void (*hwapic_irr_update)(struct kvm_vcpu *vcpu, int max_irr);
 	void (*hwapic_isr_update)(struct kvm_vcpu *vcpu, int isr);
+	void (*hwapic_apic_id_update)(struct kvm_vcpu *vcpu);
+	void (*hwapic_dfr_update)(struct kvm_vcpu *vcpu);
+	void (*hwapic_ldr_update)(struct kvm_vcpu *vcpu);
 	bool (*guest_apic_has_interrupt)(struct kvm_vcpu *vcpu);
 	void (*load_eoi_exitmap)(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitmap);
 	void (*set_virtual_apic_mode)(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 991fdf7fc17f..95295cf81283 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -262,12 +262,16 @@ static inline void apic_set_spiv(struct kvm_lapic *ap=
ic, u32 val)
 static inline void kvm_apic_set_xapic_id(struct kvm_lapic *apic, u8 id)
 {
 	kvm_lapic_set_reg(apic, APIC_ID, id << 24);
+	if (kvm_x86_ops->hwapic_apic_id_update)
+		kvm_x86_ops->hwapic_apic_id_update(apic->vcpu);
 	recalculate_apic_map(apic->vcpu->kvm);
 }
=20
 static inline void kvm_apic_set_ldr(struct kvm_lapic *apic, u32 id)
 {
 	kvm_lapic_set_reg(apic, APIC_LDR, id);
+	if (kvm_x86_ops->hwapic_ldr_update)
+		kvm_x86_ops->hwapic_ldr_update(apic->vcpu);
 	recalculate_apic_map(apic->vcpu->kvm);
 }
=20
@@ -1836,6 +1840,8 @@ int kvm_lapic_reg_write(struct kvm_lapic *apic, u32 r=
eg, u32 val)
 	case APIC_DFR:
 		if (!apic_x2apic_mode(apic)) {
 			kvm_lapic_set_reg(apic, APIC_DFR, val | 0x0FFFFFFF);
+			if (kvm_x86_ops->hwapic_dfr_update)
+				kvm_x86_ops->hwapic_dfr_update(apic->vcpu);
 			recalculate_apic_map(apic->vcpu->kvm);
 		} else
 			ret =3D 1;
--=20
2.17.1

