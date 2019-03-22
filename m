Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFAAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3401218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0r9f0r2h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387923AbfCVMsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:48:47 -0400
Received: from mail-eopbgr750088.outbound.protection.outlook.com ([40.107.75.88]:59370
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387636AbfCVL5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:57:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t72b6UEPGBijNFAaRMAvBGwMm5eNs5rKAOVkcv9NazU=;
 b=0r9f0r2hJQz4XDjXdEBBRaT5PUepk5V5A+Ls3l3s+G6LlAkPXaZUGE1mM1oFMFv2Q6SBtL8GObQ7/xn5r9Xq95+a952YK0HyOX3mMbBZHm5AGapD1bcb37LRggeorFRlZyIREeyf9NyCeSimrFfA2aR6FTmPshH+WM8x0BUT8i4=
Received: from DM6PR12MB2844.namprd12.prod.outlook.com (20.176.117.96) by
 DM6PR12MB2811.namprd12.prod.outlook.com (20.176.117.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.15; Fri, 22 Mar 2019 11:57:29 +0000
Received: from DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::3589:a066:e1d:b1f0]) by DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::3589:a066:e1d:b1f0%5]) with mapi id 15.20.1709.015; Fri, 22 Mar 2019
 11:57:29 +0000
From:   "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Subject: [PATCH 2/6] svm: Add AMD AVIC handlers for APIC ID, DFR and LDR
 update
Thread-Topic: [PATCH 2/6] svm: Add AMD AVIC handlers for APIC ID, DFR and LDR
 update
Thread-Index: AQHU4KZsJ2Y+NwV9OUGGiNrODx1Zeg==
Date:   Fri, 22 Mar 2019 11:57:28 +0000
Message-ID: <20190322115702.10166-3-suravee.suthikulpanit@amd.com>
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
x-ms-office365-filtering-correlation-id: 869cb777-aabf-432e-29dc-08d6aebd8e93
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB2811;
x-ms-traffictypediagnostic: DM6PR12MB2811:
x-microsoft-antispam-prvs: <DM6PR12MB281144A055AA20C3B7919719F3430@DM6PR12MB2811.namprd12.prod.outlook.com>
x-forefront-prvs: 09840A4839
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(346002)(396003)(376002)(199004)(189003)(52116002)(71190400001)(86362001)(105586002)(7736002)(5660300002)(186003)(106356001)(53936002)(25786009)(76176011)(316002)(4326008)(14454004)(71200400001)(99286004)(110136005)(97736004)(102836004)(26005)(54906003)(386003)(2906002)(11346002)(478600001)(2501003)(66066001)(6486002)(6512007)(6506007)(68736007)(14444005)(256004)(446003)(36756003)(476003)(72206003)(486006)(1076003)(6116002)(81156014)(3846002)(8936002)(2616005)(8676002)(81166006)(15650500001)(305945005)(50226002)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2811;H:DM6PR12MB2844.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: V0hXl/wSXNV5Rhgss/+uGESTyhLVpVurjtLGNCuy2OOYABAi5OorzdjElCO4M2qUDoTs+p2PUruffN4DQjZvT5ceIiH0dTeOiuuU1apZHg7SaWbC1vhYdGyXIMv8X2KZ7n+2g9r6+mSUbeTgm7ViBFRS444m4eJlhgReyupiPPHNwOSQdckcjSsTepM+xF8YAebXKw++cL3W9/gWkzgBv9YC3v5rlo7QyMPej40MUYgal9y0U7+He/TcVJIcnZkStakKW0cyO85bNuqEVQvouNYzuAaO2TUu+TcctrwdyGi99TUQBaCbxBcz1kHZfHwJ54bXCXrJYXvwcUzwy7ZlKNy1a0jU/VT6neFTuBApa1K8NFT8+E4SJRxkQjvavoSVxWQC1uBmVtLi895nuiXzIXTAohRfGc9nbI9zoTUcMgc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 869cb777-aabf-432e-29dc-08d6aebd8e93
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2019 11:57:28.7347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2811
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During AVIC temporary deactivation, guest could update APIC ID,
DFR and LDR registers, which would not be trapped by
avic_unaccelerated_ccess_interception(). In this case, we need
to update the AVIC logical APIC ID table accordingly.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 arch/x86/kvm/svm.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index f4fb766e474c..4cf93a729ad8 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -4705,6 +4705,24 @@ static void avic_handle_dfr_update(struct kvm_vcpu *=
vcpu)
 	svm->dfr_reg =3D dfr;
 }
=20
+static void svm_hwapic_ldr_update(struct kvm_vcpu *vcpu)
+{
+	if (svm_get_enable_apicv(vcpu) && !kvm_vcpu_apicv_active(vcpu))
+		avic_handle_ldr_update(vcpu);
+}
+
+static void svm_hwapic_apic_id_update(struct kvm_vcpu *vcpu)
+{
+	if (svm_get_enable_apicv(vcpu) && !kvm_vcpu_apicv_active(vcpu))
+		avic_handle_apic_id_update(vcpu);
+}
+
+static void svm_hwapic_dfr_update(struct kvm_vcpu *vcpu)
+{
+	if (svm_get_enable_apicv(vcpu) && !kvm_vcpu_apicv_active(vcpu))
+		avic_handle_dfr_update(vcpu);
+}
+
 static int avic_unaccel_trap_write(struct vcpu_svm *svm)
 {
 	struct kvm_lapic *apic =3D svm->vcpu.arch.apic;
@@ -7222,6 +7240,9 @@ static struct kvm_x86_ops svm_x86_ops __ro_after_init=
 =3D {
 	.load_eoi_exitmap =3D svm_load_eoi_exitmap,
 	.hwapic_irr_update =3D svm_hwapic_irr_update,
 	.hwapic_isr_update =3D svm_hwapic_isr_update,
+	.hwapic_apic_id_update =3D svm_hwapic_apic_id_update,
+	.hwapic_dfr_update =3D svm_hwapic_dfr_update,
+	.hwapic_ldr_update =3D svm_hwapic_ldr_update,
 	.sync_pir_to_irr =3D kvm_lapic_find_highest_irr,
 	.apicv_post_state_restore =3D avic_post_state_restore,
=20
--=20
2.17.1

