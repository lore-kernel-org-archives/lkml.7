Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C92CC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 21:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12A1B2183F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 21:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="w9Tzjinx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfFNVPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 17:15:21 -0400
Received: from mail-eopbgr720043.outbound.protection.outlook.com ([40.107.72.43]:64064
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726627AbfFNVPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 17:15:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dUSMN5REm5cdXoV/87i1p2hTXgUcNNt43VWQb6Pnza8=;
 b=w9Tzjinxncg+4mAGPwn2/bzesPLWYV1Hgd8Gc0JPxnvnMRi/uhcG3k0/gWUxtuE2PR9QClBiXXJNfgYMmspCY//4uAUJ/CW8UnLKugazUqnenUW57zqFz742lSRygYzDeS7985oyjGUwn0m6JXVzSCj3TbEOt/snOhxwfewf4zA=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB3724.namprd12.prod.outlook.com (10.255.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Fri, 14 Jun 2019 21:15:17 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::bcaf:86d4:677f:9555]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::bcaf:86d4:677f:9555%6]) with mapi id 15.20.1987.012; Fri, 14 Jun 2019
 21:15:17 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 0/2] x86: SME: Kexec/kdump memory loading fix
Thread-Topic: [PATCH 0/2] x86: SME: Kexec/kdump memory loading fix
Thread-Index: AQHVIvZDp4CKCmVgw0++Tqos9ljYSg==
Date:   Fri, 14 Jun 2019 21:15:17 +0000
Message-ID: <cover.1560546537.git.thomas.lendacky@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SN6PR16CA0054.namprd16.prod.outlook.com
 (2603:10b6:805:ca::31) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c6708f20-c473-4a30-0dfd-08d6f10d663e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR12MB3724;
x-ms-traffictypediagnostic: DM6PR12MB3724:
x-microsoft-antispam-prvs: <DM6PR12MB37242B22287C48505F320B10ECEE0@DM6PR12MB3724.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0068C7E410
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(39860400002)(136003)(396003)(189003)(199004)(66446008)(54906003)(71190400001)(71200400001)(110136005)(3846002)(2906002)(7736002)(66946007)(53936002)(305945005)(52116002)(6116002)(66556008)(66476007)(73956011)(25786009)(256004)(36756003)(64756008)(102836004)(8676002)(81156014)(316002)(66066001)(6506007)(386003)(2616005)(186003)(6512007)(26005)(2501003)(81166006)(99286004)(6486002)(8936002)(486006)(476003)(68736007)(14454004)(86362001)(72206003)(478600001)(5660300002)(50226002)(4326008)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3724;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0Fn+3ZmqOR0QJXAbxj2Fj6Vdp8xUVeHIKC9O2PNa2d7LSoNZNoCG920PJykh6FHqdKsKXjMa5FCGT327Fm4JBDaRBap/SYBs30OZHKyRkmfEjXoA9zncTMR6NWTX44xnBjkoDdDmauy820VGCJPE7YG0y3H7XFJoEHKXDYI8kWk+hWZVy//oSSnykbpw8o+v2YlihN/7/BWS2sbraRA6U3Y0Td/d3sD+GaQGWb2c03nYZTlLiB/pN3tHJjD9+ujVzuMOlok1wKOjNtMm1mbtUdWKk4TiTsUz2r2VrUDXB6UQCbAwlX+ULXSOWuhyDMCpdoOkJA3pipOqiT9AIXEczLniDsCASFVisahPrgSQiLq9QkpRmL5Nf437VH9LPcp54eGumNJflciJ57y+Uw5WqG6VwxwHAoOQM8hm93lGmaM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6708f20-c473-4a30-0dfd-08d6f10d663e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2019 21:15:17.5013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tlendack@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3724
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBzZXJpZXMgYWRkcmVzc2VzIGFuIGlzc3VlIHJlbGF0ZWQgdG8ga2V4ZWMva2R1bXAgd2hl
biBTTUUgaXMgYWN0aXZlLg0KVGhlIFNNRSBzdXBwb3J0IHVzZXMgYSB3b3JrYXJlYSBsb2NhdGVk
IGFmdGVyIHRoZSBlbmQgb2YgdGhlIGtlcm5lbCB0bw0KcGVyZm9ybSAiaW4tcGxhY2UiIGVuY3J5
cHRpb24gb2YgdGhlIGtlcm5lbC4gV2hlbiBrZXhlYy9rZHVtcCBpcyB1c2VkLCBpdA0KaXMgcG9z
c2libGUgdGhhdCBzb21lIG90aGVyIGRhdGEgdXNlZCBieSBrZXhlYy9rZHVtcCBjb3VsZCBiZSBp
biB0aGlzIGFyZWENCm9mIG1lbW9yeSB3aGljaCB3b3VsZCBjYXVzZSB0aGUga2V4ZWMva2R1bXAg
b2YgdGhlIGtlcm5lbCB0byBmYWlsLg0KDQpDcmVhdGUgYSBzZWN0aW9uIGZvciBTTUUgaW4gdm1s
aW51eC5sZHMuUyB0aGF0IGlzIHBvc2l0aW9uZWQgYWZ0ZXIgIl9lbmQiLA0Kc28gdGhhdCB0aGUg
bWVtb3J5IGl0IG9jY3VwaWVzIHdpbGwgYmUgcmVjbGFpbWVkIGFmdGVyIGl0cyB1c2UgZHVyaW5n
DQpib290LiBTaW5jZSBpdCBpcyBwYXJ0IG9mIHRoZSBrZXJuZWwgaW1hZ2UsIHRoZXJlIGlzIG5v
IHdvcnJ5IG5vdyB0aGF0DQprZXhlYy9rZHVtcCB3aWxsIHBsYWNlIGRhdGEgaW4gdGhlIFNNRSB3
b3JrYXJlYSB3aGVuIGluc3RhbGxpbmcgdGhlIGtleGVjLw0Ka2R1bXAga2VybmVsLiBBcyBwYXJ0
IG9mIHRoaXMgZml4LCBjbGFyaWZ5IHdoYXQgb2NjdXBpZWQga2VybmVsIG1lbW9yeSBpcw0KcmVz
ZXJ2ZWQgYW5kIHdoYXQgcGFydHMgb2YgdGhlIGtlcm5lbCBtZW1vcnkgYXJlIGRpc2NhcmRlZC4N
Cg0KVGhlIGZvbGxvd2luZyBwYXRjaGVzIGFyZSBpbmNsdWRlZDoNCi0gSWRlbnRpZnkgYW5kIGRv
Y3VtZW50IHdoYXQgcGFydHMgb2YgdGhlIGtlcm5lbCBpbWFnZSBhcmUgcmVzZXJ2ZWQgKHNhdmVk
KQ0KICBhbmQgd2hhdCBpcyBkaXNjYXJkZWQuDQotIENyZWF0ZSBhIG5ldyBTTUUgd29ya2FyZWEg
c2VjdGlvbiB0aGF0IHdpbGwgYmUgcmVjbGFpbWVkIGFmdGVyIGl0cyB1c2UNCiAgZHVyaW5nIGJv
b3QsIHRodXMgYWxsb3cNCg0KVGhpcyBwYXRjaCBzZXJpZXMgaXMgYmFzZWQgb24gdGlwL21hc3Rl
ci4NCg0KLS0tDQoNClRvbSBMZW5kYWNreSAoMik6DQogIHg4Ni9tbTogSWRlbnRpZnkgdGhlIGVu
ZCBvZiB0aGUga2VybmVsIGFyZWEgdG8gYmUgcmVzZXJ2ZWQNCiAgeDg2L21tOiBDcmVhdGUgYW4g
U01FIHdvcmthcmVhIGluIHRoZSBrZXJuZWwgZm9yIGVhcmx5IGVuY3J5cHRpb24NCg0KIGFyY2gv
eDg2L2luY2x1ZGUvYXNtL3NlY3Rpb25zLmggICAgfCAgMiArKw0KIGFyY2gveDg2L2tlcm5lbC9z
ZXR1cC5jICAgICAgICAgICAgfCAgOCArKysrKysrLQ0KIGFyY2gveDg2L2tlcm5lbC92bWxpbnV4
Lmxkcy5TICAgICAgfCAzMyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0NCiBhcmNoL3g4
Ni9tbS9tZW1fZW5jcnlwdF9pZGVudGl0eS5jIHwgMjIgKysrKysrKysrKysrKysrKysrLS0NCiA0
IGZpbGVzIGNoYW5nZWQsIDYxIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQoNCi0tIA0K
Mi4xNy4xDQoNCg==
