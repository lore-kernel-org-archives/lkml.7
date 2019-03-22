Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A312BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6847D218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JqudaXIJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733183AbfCVL5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:57:32 -0400
Received: from mail-eopbgr750054.outbound.protection.outlook.com ([40.107.75.54]:64814
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387644AbfCVL5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:57:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YtdWoiKovOdSiW9CVdGaRFi+7noydbM5hYGQ+3A/MCU=;
 b=JqudaXIJ0IeI22p/JtIFf2FLj0Yp3LVY4GEf33G1ikWWcK89BtVzSifbNQL16aZ9mEtMSd786z2VtIkQH0X17z5PNN03GCKf854x8b2VtcxbQ+11x99sJpuZz5wkKaB59Tnm6jTRNm4S8uGGa/5gCKNGXZH3h3cJIJOH+GzOqJM=
Received: from DM6PR12MB2844.namprd12.prod.outlook.com (20.176.117.96) by
 DM6PR12MB2811.namprd12.prod.outlook.com (20.176.117.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.15; Fri, 22 Mar 2019 11:57:23 +0000
Received: from DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::3589:a066:e1d:b1f0]) by DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::3589:a066:e1d:b1f0%5]) with mapi id 15.20.1709.015; Fri, 22 Mar 2019
 11:57:23 +0000
From:   "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Subject: [PATCH 0/6] KVM/x86: Add workaround to support ExtINT with AVIC
Thread-Topic: [PATCH 0/6] KVM/x86: Add workaround to support ExtINT with AVIC
Thread-Index: AQHU4KZosQ632xwMIUelDUbIBZTx9w==
Date:   Fri, 22 Mar 2019 11:57:22 +0000
Message-ID: <20190322115702.10166-1-suravee.suthikulpanit@amd.com>
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
x-ms-office365-filtering-correlation-id: fd4116b7-5636-43d0-fa56-08d6aebd8aec
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB2811;
x-ms-traffictypediagnostic: DM6PR12MB2811:
x-microsoft-antispam-prvs: <DM6PR12MB281165EF68518040C9ACFB2EF3430@DM6PR12MB2811.namprd12.prod.outlook.com>
x-forefront-prvs: 09840A4839
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(346002)(396003)(376002)(199004)(189003)(52116002)(71190400001)(86362001)(105586002)(7736002)(5660300002)(186003)(106356001)(53936002)(25786009)(316002)(4326008)(14454004)(71200400001)(99286004)(110136005)(97736004)(102836004)(26005)(54906003)(386003)(2906002)(478600001)(2501003)(66066001)(6486002)(6512007)(6506007)(68736007)(14444005)(256004)(36756003)(476003)(72206003)(486006)(1076003)(6116002)(81156014)(3846002)(8936002)(2616005)(8676002)(81166006)(305945005)(50226002)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2811;H:DM6PR12MB2844.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IeKpqlYVscYJZDvlzI2TVC1lk5ML6Iz9MDtD81XCMFkUsy92VHfl0GxzmordjN+PGXTWrFhiXBvSxLFr+0G3X9zz+7V+wvO0qsC/2izBmOvrjAZvEHAFrVRgyCIEkVO9C7GWFzVbGAMdlmrvqO1i7c4iTGUh5eU24GWFilqh7BUUyq/BrLktGFbzHDIed+joaBrpdYFKIVJnefrbjzENgV1ajx0T+IqDkL2rd14kk9/Fp6++s7Bhc1YGv3CLFoyVV8JOO+IBLEtFHrLKUSU8E6ziyOiKv0wUuyZh6td26Se6fg02ekbW0Hcdgz1301oeyrzpyjkUXFSmlUpc9O8oCS0fSndXvcrae+Uxop9td7uEGyJRnchwfDJxNC/vM7dZwB4OXeamuqArPTxRiFVH5Ic9wB4lSQiqkaKTdve3fjA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F7326018E9A87F4D8369C3AB32086C5B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd4116b7-5636-43d0-fa56-08d6aebd8aec
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2019 11:57:22.8776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2811
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBzZXJpZXMgaXMgb25lIG9mIHRoZSBwcmVyZXF1aXNpdGVzIGZvciBzdXBwb3J0aW5nIEFN
RCBBVklDIHdpdGgNCmluLWtlcm5lbCBpcnFjaGlwIChrZXJuZWxfaXJxY2hpcD1vbikuDQoNClNp
bmNlIEFWSUMgZG9lcyBub3Qgc3VwcG9ydCBFeHRJTlQgaW50ZXJydXB0LCB3aGljaCBpcyByZXF1
aXJlZCBkdXJpbmcNCnRoZSBib290aW5nIHBoYXNlIG9mIFdpbmRvd3MgYW5kIEZyZWVCU0QgVk1z
IChlLmcuIFBJVCAtPiBQSUMgLT4gRXh0SW50KS4NClRoaXMgcmVzdWx0cyBpbiBWTSBoYW5nIGlu
IHRoZSBib290IGxvYWRlciB3aXRoIGtlcm5lbF9pcnFjaGlwPW9uIG1vZGUuDQoNClRoaXMgc2Vy
aWVzIHByb3ZpZGVzIHdvcmthcm91bmQgYnkgdGVtcG9yYXJ5IGRlYWN0aXZhdGUgQVZJQyBhbmQg
ZmFsbGJhY2sNCnRvIHVzZSBsZWdhY3kgaW50ZXJydXB0IGluamVjdGlvbiAody8gdklOVFIgYW5k
IGludGVycnVwdCB3aW5kb3cpLg0KVGhlbiByZS1hY3RpdmF0ZSBBVklDIG9uY2UgdGhlIGludHJy
dXB0cyBhcmUgaGFuZGxlZC4NCg0KVGhhbmtzLA0KU3VyYXZlZQ0KDQpTdXJhdmVlIFN1dGhpa3Vs
cGFuaXQgKDYpOg0KICBLVk06IHg4NjogQWRkIGNhbGxiYWNrIGZ1bmN0aW9ucyBmb3IgaGFuZGxp
bmcgQVBJQyBJRCwgREZSIGFuZCBMRFINCiAgICB1cGRhdGUNCiAgc3ZtOiBBZGQgQU1EIEFWSUMg
aGFuZGxlcnMgZm9yIEFQSUMgSUQsIERGUiBhbmQgTERSIHVwZGF0ZQ0KICBzdm06IEFkZCBzdXBw
b3J0IGZvciBBUElDX0FDQ0VTU19QQUdFX1BSSVZBVEVfTUVNU0xPVCBzZXR1cC9kZXN0cm95DQog
IGt2bTogbGFwaWM6IEFkZCBhcGljdiBhY3RpdmF0ZS9kZWFjdGl2YXRlIGhlbHBlciBmdW5jdGlv
bg0KICBLVk06IHg4NjogQWRkIGludGVyZmFjZSBmb3IgcnVuLXRpbWUgYWN0aXZhdGUvZGUtYWN0
aXZhdGUgQVBJQw0KICAgIHZpcnR1YWxpemF0aW9uDQogIHN2bTogVGVtcG9yYXJ5IGRlYWN0aXZh
dGUgQVZJQyBkdXJpbmcgRXh0SU5UIGhhbmRsaW5nDQoNCiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9r
dm1faG9zdC5oIHwgIDExICsrKysNCiBhcmNoL3g4Ni9rdm0vbGFwaWMuYyAgICAgICAgICAgIHwg
IDI5ICsrKysrKystLQ0KIGFyY2gveDg2L2t2bS9sYXBpYy5oICAgICAgICAgICAgfCAgIDEgKw0K
IGFyY2gveDg2L2t2bS9zdm0uYyAgICAgICAgICAgICAgfCAxMDYgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrLS0NCiBhcmNoL3g4Ni9rdm0veDg2LmMgICAgICAgICAgICAgIHwgIDQ4ICsr
KysrKysrKysrKysrKw0KIDUgZmlsZXMgY2hhbmdlZCwgMTg1IGluc2VydGlvbnMoKyksIDEwIGRl
bGV0aW9ucygtKQ0KDQotLSANCjIuMTcuMQ0KDQo=
