Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBA1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 06:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00595218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 06:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="N/0zmYoo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbfCUGgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 02:36:14 -0400
Received: from mail-eopbgr770079.outbound.protection.outlook.com ([40.107.77.79]:33908
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726447AbfCUGgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 02:36:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oo97nJOoBjRqBSPJV0jK1LW18lGvqndHFEmoa06PVf8=;
 b=N/0zmYooirfSSYYGiEBQ3fFsNsOoAR8lIfPM8aIeXzVj87IUFay4m8Bty3UwnqWzPqJINhkiEOM1AX+vS7kzAr5pPv+2MMxjHrzsdOFA7eGEy0oL7dKdPXTC2+7O3Mg9PfzcqmQJiX29z2KIBNFM2v4Yi+THFnLswIj4Wdar+Sw=
Received: from DM5PR02MB2187.namprd02.prod.outlook.com (10.168.173.137) by
 DM5PR02MB3292.namprd02.prod.outlook.com (10.164.152.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Thu, 21 Mar 2019 06:36:09 +0000
Received: from DM5PR02MB2187.namprd02.prod.outlook.com
 ([fe80::2d7f:9bf0:24c2:5c57]) by DM5PR02MB2187.namprd02.prod.outlook.com
 ([fe80::2d7f:9bf0:24c2:5c57%6]) with mapi id 15.20.1709.015; Thu, 21 Mar 2019
 06:36:09 +0000
From:   Appana Durga Kedareswara Rao <appanad@xilinx.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "wg@grandegger.com" <wg@grandegger.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Michal Simek <michals@xilinx.com>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/6] net: can: xilinx_can: Bug fixes and Enhancements
Thread-Topic: [PATCH 0/6] net: can: xilinx_can: Bug fixes and Enhancements
Thread-Index: AQHU3X5pxtrhGyT8f0y/0R8BjEz816YUgSyAgAEkNOA=
Date:   Thu, 21 Mar 2019 06:36:09 +0000
Message-ID: <DM5PR02MB21875918C65EF8757E34C574DC420@DM5PR02MB2187.namprd02.prod.outlook.com>
References: <1552908766-26753-1-git-send-email-appana.durga.rao@xilinx.com>
 <d1cd73cc-e200-7c06-dd6e-3c5e2e35709c@pengutronix.de>
In-Reply-To: <d1cd73cc-e200-7c06-dd6e-3c5e2e35709c@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=appanad@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 75ec2b86-4de4-47d2-c635-08d6adc780f6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR02MB3292;
x-ms-traffictypediagnostic: DM5PR02MB3292:
x-ms-exchange-purlcount: 2
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <DM5PR02MB3292DCDB2D291F0F7F83613ADC420@DM5PR02MB3292.namprd02.prod.outlook.com>
x-forefront-prvs: 0983EAD6B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(136003)(366004)(39860400002)(376002)(199004)(189003)(13464003)(6506007)(6246003)(53386004)(478600001)(256004)(8676002)(446003)(6636002)(99286004)(74316002)(7696005)(229853002)(305945005)(25786009)(66066001)(53546011)(2501003)(110136005)(106356001)(7736002)(76176011)(81166006)(14444005)(4326008)(102836004)(68736007)(53936002)(97736004)(105586002)(11346002)(14454004)(52536014)(6436002)(55016002)(33656002)(476003)(6116002)(81156014)(3846002)(71200400001)(86362001)(6306002)(5660300002)(486006)(8936002)(966005)(2906002)(26005)(2201001)(54906003)(71190400001)(9686003)(186003)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR02MB3292;H:DM5PR02MB2187.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uguJTvmd6kSjPsg1F31LHQPtO9idykfQXU3tr1YzYpR+kEw8wBzdMDIelx4AA/d6MkoDhe0XfymB0G49qwnb9W7lsOctdZDDkBGa+3OUKQfeg9rDywLlLL1JKCuJz1J+fXBXa0zVxEA+PUDE9Ogs1B3y8OIazoH0uKDeqb+jx/CBcShld1rPoi3DifTmwuqxAsw1C+P6AjHtnhBjbjjAacdDzfp3v5TzHXNjQJ6ZolnGEh8pljTGnm1k0l2/qSK0Bta2LBpUY8J27io4D+nZJ2ZX0o5GGXvkKw+OGVFFc8t6zWsdsiZH4YL1HBUqcQLnwbxwADL73EwxJHCHYGQAiCWTGWksBWZm+si4NUzDDnIjJafeOVJvxxrsIfoCorXE5M5xNlYerJwVhs3IoGTsv2VuqKnsK9AiZSrG8BtJaQc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75ec2b86-4de4-47d2-c635-08d6adc780f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2019 06:36:09.2636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3292
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFyYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJjIEts
ZWluZS1CdWRkZSA8bWtsQHBlbmd1dHJvbml4LmRlPg0KPiBTZW50OiBXZWRuZXNkYXksIE1hcmNo
IDIwLCAyMDE5IDY6MzkgUE0NCj4gVG86IEFwcGFuYSBEdXJnYSBLZWRhcmVzd2FyYSBSYW8gPGFw
cGFuYWRAeGlsaW54LmNvbT47DQo+IHdnQGdyYW5kZWdnZXIuY29tOyBkYXZlbUBkYXZlbWxvZnQu
bmV0OyBNaWNoYWwgU2ltZWsNCj4gPG1pY2hhbHNAeGlsaW54LmNvbT4NCj4gQ2M6IGxpbnV4LWNh
bkB2Z2VyLmtlcm5lbC5vcmc7IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS0NCj4g
a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcN
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCAwLzZdIG5ldDogY2FuOiB4aWxpbnhfY2FuOiBCdWcgZml4
ZXMgYW5kIEVuaGFuY2VtZW50cw0KPiANCj4gT24gMy8xOC8xOSAxMjozMiBQTSwgQXBwYW5hIER1
cmdhIEtlZGFyZXN3YXJhIHJhbyB3cm90ZToNCj4gPiBUaGlzIHBhdGNoIHNlcmllcyBkb2VzIHRo
ZSBiZWxvdw0KPiA+IC0tPiBBZGRlZCBzdXBwb3J0IGZvciBDQU5GRCBGRCBmcmFtZXMNCj4gPiAt
LT4gRml4IENoZWNrcGF0Y2ggcmVwb3J0ZWQgd2FybmluZ3MgYW5kIGNoZWNrcw0KPiA+DQo+ID4g
QXBwYW5hIER1cmdhIEtlZGFyZXN3YXJhIHJhbyAoNik6DQo+ID4gICBuZXQ6IGNhbjogeGlsaW54
X2NhbjogRml4IHN0eWxlIGlzc3Vlcw0KPiA+ICAgbmV0OiBjYW46IHhpbGlueF9jYW46IEZpeCBm
bGFncyBmaWVsZCBpbml0aWFsaXphdGlvbiBmb3IgYXhpIGNhbiBhbmQNCj4gPiAgICAgY2FucHMN
Cj4gPiAgIG5ldDogY2FuOiB4aWxpbnhfY2FuOiBBZGQgY2FudHlwZSBwYXJhbWV0ZXIgaW4geGNh
bl9kZXZ0eXBlX2RhdGENCj4gPiAgICAgc3RydWN0DQo+ID4gICBuZXQ6IGNhbjogeGlsaW54X2Nh
bjogQWRkIHN1cHBvcnQgZm9yIENBTkZEIEZEIGZyYW1lcw0KPiA+ICAgbmV0OiBjYW46IHhpbGlu
eF9jYW46IEFkZCBTUERYIGxpY2Vuc2UNCj4gPiAgIG5ldDogY2FuOiB4aWxpbnhfY2FuOiBGaXgg
a2VybmVsIGRvYyB3YXJuaW5ncw0KPiA+DQo+ID4gIGRyaXZlcnMvbmV0L2Nhbi94aWxpbnhfY2Fu
LmMgfCAzMDMNCj4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0t
DQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyNTcgaW5zZXJ0aW9ucygrKSwgNDYgZGVsZXRpb25zKC0p
DQo+IA0KPiBBcHBsaWVkIHRvIGxpbnV4LWNhbi1uZXh0L3Rlc3RpbmcsIGJ1dCBpbiBvcmRlci4g
Rmlyc3QgZml4ZXMgdGhhbg0KPiBlbmhhbmNlbWVudHM6DQoNClRoYW5rcy4uLg0KSSBjb3VsZG4n
dCBmaW5kIHRoZSBwYXRjaGVzIGhlcmUgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xp
bnV4L2tlcm5lbC9naXQvbWtsL2xpbnV4LWNhbi1uZXh0LmdpdC9sb2cvZHJpdmVycy9uZXQvY2Fu
L3hpbGlueF9jYW4uYz9oPXRlc3RpbmcgDQpBbSBJIHJlZmVycmluZyB3cm9uZyByZXBvL2JyYW5j
aD8/IA0KDQpSZWdhcmRzLA0KS2VkYXIuDQo+IA0KPiA+IDI0MTgyNjMwMjg1NCBuZXQ6IGNhbjog
eGlsaW54X2NhbjogRml4IHN0eWxlIGlzc3Vlcw0KPiA+IDcwZmIyNmZhZGMyNyBuZXQ6IGNhbjog
eGlsaW54X2NhbjogRml4IGtlcm5lbCBkb2Mgd2FybmluZ3MNCj4gPiA3YmViNjQzNTFmZjEgbmV0
OiBjYW46IHhpbGlueF9jYW46IEFkZCBTUERYIGxpY2Vuc2UgZGQ5NDkxMGJjZWFlIG5ldDoNCj4g
PiBjYW46IHhpbGlueF9jYW46IEZpeCBmbGFncyBmaWVsZCBpbml0aWFsaXphdGlvbiBmb3IgYXhp
IGNhbiBhbmQgY2FucHMNCj4gPiA2YmQwNWNlY2U1NjcgbmV0OiBjYW46IHhpbGlueF9jYW46IEFk
ZCBjYW50eXBlIHBhcmFtZXRlciBpbg0KPiA+IHhjYW5fZGV2dHlwZV9kYXRhIHN0cnVjdA0KPiA+
IDM0ZTI4MDE3MDczNiBuZXQ6IGNhbjogeGlsaW54X2NhbjogQWRkIHN1cHBvcnQgZm9yIENBTkZE
IEZEIGZyYW1lcw0KPiANCj4gTWFyYw0KPiANCj4gLS0NCj4gUGVuZ3V0cm9uaXggZS5LLiAgICAg
ICAgICAgICAgICAgIHwgTWFyYyBLbGVpbmUtQnVkZGUgICAgICAgICAgIHwNCj4gSW5kdXN0cmlh
bCBMaW51eCBTb2x1dGlvbnMgICAgICAgIHwgUGhvbmU6ICs0OS0yMzEtMjgyNi05MjQgICAgIHwN
Cj4gVmVydHJldHVuZyBXZXN0L0RvcnRtdW5kICAgICAgICAgIHwgRmF4OiAgICs0OS01MTIxLTIw
NjkxNy01NTU1IHwNCj4gQW10c2dlcmljaHQgSGlsZGVzaGVpbSwgSFJBIDI2ODYgIHwgaHR0cDov
L3d3dy5wZW5ndXRyb25peC5kZSAgIHwNCg0K
