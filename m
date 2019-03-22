Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E488C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34AF42070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fDaIt6BB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387707AbfCVL5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:57:40 -0400
Received: from mail-eopbgr750053.outbound.protection.outlook.com ([40.107.75.53]:65282
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387680AbfCVL5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:57:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmiWwO3BkUkIczul5UaDEtWkAK+bBCcf6R8AvNYn2dI=;
 b=fDaIt6BBvBmiiXaRLVcazLU6EIieM3urqZGXeFJt8pX1D/7a06ChRRuXXX32VyQQUSH+AGKYp3NHazYe/MDt6Dgl4kbSDiOEMoxo3cdkPxzS3iX/qTiyvtQIF6al+WeKdYFX7H0tPs/6HM0mx2GEjPsmMh1fwT5xCUj8wwl+YgU=
Received: from DM6PR12MB2844.namprd12.prod.outlook.com (20.176.117.96) by
 DM6PR12MB2811.namprd12.prod.outlook.com (20.176.117.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.15; Fri, 22 Mar 2019 11:57:34 +0000
Received: from DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::3589:a066:e1d:b1f0]) by DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::3589:a066:e1d:b1f0%5]) with mapi id 15.20.1709.015; Fri, 22 Mar 2019
 11:57:34 +0000
From:   "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Subject: [PATCH 4/6] kvm: lapic: Add apicv activate/deactivate helper function
Thread-Topic: [PATCH 4/6] kvm: lapic: Add apicv activate/deactivate helper
 function
Thread-Index: AQHU4KZvukQXllsT80ClQydRuIOOIg==
Date:   Fri, 22 Mar 2019 11:57:34 +0000
Message-ID: <20190322115702.10166-5-suravee.suthikulpanit@amd.com>
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
x-ms-office365-filtering-correlation-id: 10ea35b9-8e05-4bb0-4629-08d6aebd9210
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB2811;
x-ms-traffictypediagnostic: DM6PR12MB2811:
x-microsoft-antispam-prvs: <DM6PR12MB2811DD1366B3752EEC8AFB87F3430@DM6PR12MB2811.namprd12.prod.outlook.com>
x-forefront-prvs: 09840A4839
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(346002)(396003)(376002)(199004)(189003)(52116002)(71190400001)(86362001)(105586002)(7736002)(5660300002)(186003)(106356001)(53936002)(25786009)(76176011)(316002)(4326008)(14454004)(71200400001)(99286004)(110136005)(97736004)(102836004)(26005)(54906003)(386003)(2906002)(11346002)(478600001)(2501003)(66066001)(6486002)(6512007)(6506007)(68736007)(14444005)(256004)(446003)(36756003)(476003)(72206003)(486006)(1076003)(6116002)(81156014)(3846002)(8936002)(2616005)(8676002)(81166006)(305945005)(50226002)(6436002)(309714004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2811;H:DM6PR12MB2844.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pE/y4tl99dw1aAUwjTA6uVubSudFx/4f/UWHcew6lavoghmuw/zW5IRzkpDtlwBORmUBEoWRuzhC42YBmCR6Ot/vkEuADMkjcW+N90rewmSrVRpma9vAR7pnBLxrKXWwANfZnmqyjbEJcip1ZcqMR7UxC43iP9uijxlw3m92Tmo6ngD0VhzatCX5W4j/iPrAOuFyWieXOh22z1pLjtMwjj4xJp+4UhmfZrE3V/V8qLPJbBXe+VLnG2n2opMRR3Wiggg/qduOaqJdrQRcE9/O9eFY9CsknxaaWpW5La1G1oP/poHpuPe7vAPFGx+eCmekjMoWQ3HatL4Jk7sv37FGNiIXYxikiyeNyX4nvpS1iFP6RkNYRCUuA2AQgKHQLa1ztXpVSPahHITxDhUWMXbzDhSte+SnRBQDJ40hiJFybgw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ea35b9-8e05-4bb0-4629-08d6aebd9210
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2019 11:57:34.5958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2811
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a helper function for setting lapic parameters when
activate/deactivate apicv.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 arch/x86/kvm/lapic.c | 23 ++++++++++++++++++-----
 arch/x86/kvm/lapic.h |  1 +
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 95295cf81283..9c5cd1a98928 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2126,6 +2126,22 @@ void kvm_lapic_set_base(struct kvm_vcpu *vcpu, u64 v=
alue)
=20
 }
=20
+void kvm_apic_update_apicv(struct kvm_vcpu *vcpu)
+{
+	struct kvm_lapic *apic =3D vcpu->arch.apic;
+	bool active =3D vcpu->arch.apicv_active;
+
+	if (active) {
+		/* irr_pending is always true when apicv is activated. */
+		apic->irr_pending =3D true;
+		apic->isr_count =3D 1;
+	} else {
+		apic->irr_pending =3D !!count_vectors(apic->regs + APIC_IRR);
+		apic->isr_count =3D count_vectors(apic->regs + APIC_ISR);
+	}
+}
+EXPORT_SYMBOL(kvm_apic_update_apicv);
+
 void kvm_lapic_reset(struct kvm_vcpu *vcpu, bool init_event)
 {
 	struct kvm_lapic *apic =3D vcpu->arch.apic;
@@ -2170,8 +2186,7 @@ void kvm_lapic_reset(struct kvm_vcpu *vcpu, bool init=
_event)
 		kvm_lapic_set_reg(apic, APIC_ISR + 0x10 * i, 0);
 		kvm_lapic_set_reg(apic, APIC_TMR + 0x10 * i, 0);
 	}
-	apic->irr_pending =3D vcpu->arch.apicv_active;
-	apic->isr_count =3D vcpu->arch.apicv_active ? 1 : 0;
+	kvm_apic_update_apicv(vcpu);
 	apic->highest_isr_cache =3D -1;
 	update_divide_count(apic);
 	atomic_set(&apic->lapic_timer.pending, 0);
@@ -2433,9 +2448,7 @@ int kvm_apic_set_state(struct kvm_vcpu *vcpu, struct =
kvm_lapic_state *s)
 	apic_manage_nmi_watchdog(apic, kvm_lapic_get_reg(apic, APIC_LVT0));
 	update_divide_count(apic);
 	start_apic_timer(apic);
-	apic->irr_pending =3D true;
-	apic->isr_count =3D vcpu->arch.apicv_active ?
-				1 : count_vectors(apic->regs + APIC_ISR);
+	kvm_apic_update_apicv(vcpu);
 	apic->highest_isr_cache =3D -1;
 	if (vcpu->arch.apicv_active) {
 		kvm_x86_ops->apicv_post_state_restore(vcpu);
diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
index ff6ef9c3d760..b657605cfec0 100644
--- a/arch/x86/kvm/lapic.h
+++ b/arch/x86/kvm/lapic.h
@@ -88,6 +88,7 @@ void kvm_apic_update_ppr(struct kvm_vcpu *vcpu);
 int kvm_apic_set_irq(struct kvm_vcpu *vcpu, struct kvm_lapic_irq *irq,
 		     struct dest_map *dest_map);
 int kvm_apic_local_deliver(struct kvm_lapic *apic, int lvt_type);
+void kvm_apic_update_apicv(struct kvm_vcpu *vcpu);
=20
 bool kvm_irq_delivery_to_apic_fast(struct kvm *kvm, struct kvm_lapic *src,
 		struct kvm_lapic_irq *irq, int *r, struct dest_map *dest_map);
--=20
2.17.1

