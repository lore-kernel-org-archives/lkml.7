Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD77EC31E4E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 18:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84A5020644
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 18:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="gYkilA5F";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="oaOJffTj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbfFNSFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 14:05:09 -0400
Received: from dc2-smtprelay2.synopsys.com ([198.182.61.142]:33072 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726305AbfFNSFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 14:05:08 -0400
Received: from mailhost.synopsys.com (dc2-mailhost1.synopsys.com [10.12.135.161])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 034BBC2289;
        Fri, 14 Jun 2019 18:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1560535508; bh=8l8rPS/BySgxKl7CjMynmtU9SAyJOl5r8Xw0NG8wAC0=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=gYkilA5FB8HiSeRy3vKPpk5f4eCqFid+8N3qGOQkb+u9MEkuKLQtD60WF6LncCyVo
         QeoSjg/yuJsnQJNlqTgMX8qfrXg4rtoYa0SmFgUIuLZy28heStZIY24ATvCE0v5XST
         o35bQF3DWPTSqqMIg0nsbKSWi+1UEjWOtQHyf34TvDAs89UBINSd9Xttn8tVPVUojs
         8pKMnAwGkJnB/nf5HQMrhH4bbWfHoPncCwTd7GQ7gd03p28GmOUZhOvQqNdozrervd
         m6CdlpOb3owxqS340+5uaCiZ6i4T5ZfD2dA2DJ/lKZ977u9gXauvIVapnAnPrAZjyp
         6doF38xDoZ4Mw==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id D4B33A009B;
        Fri, 14 Jun 2019 18:05:03 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 14 Jun 2019 11:05:03 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 14 Jun 2019 11:05:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector1-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8l8rPS/BySgxKl7CjMynmtU9SAyJOl5r8Xw0NG8wAC0=;
 b=oaOJffTjW0uTpKf34k7hA4ANFNsEMxaGhtz6N1kUgHH+s238w8ljAedjDNr8knG8MLj2PddmLsOGZXyqmdHBxD0xg28TxIF2IdAYdAMEYFE8Jljiiy/0hfPsaFrTUY6t7svusvAd9f8KO9dTFX9WiuJpZCZk5Gx/rdC0mQMAq8g=
Received: from SN6PR12MB2670.namprd12.prod.outlook.com (52.135.103.23) by
 SN6PR12MB2670.namprd12.prod.outlook.com (52.135.103.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.17; Fri, 14 Jun 2019 18:05:01 +0000
Received: from SN6PR12MB2670.namprd12.prod.outlook.com
 ([fe80::cd10:94a4:d1b1:c3b2]) by SN6PR12MB2670.namprd12.prod.outlook.com
 ([fe80::cd10:94a4:d1b1:c3b2%5]) with mapi id 15.20.1965.019; Fri, 14 Jun 2019
 18:05:01 +0000
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     "hch@lst.de" <hch@lst.de>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
CC:     "shorne@gmail.com" <shorne@gmail.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "vladimir.murzin@arm.com" <vladimir.murzin@arm.com>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "stefan.kristiansson@saunalahti.fi" 
        <stefan.kristiansson@saunalahti.fi>,
        "jonas@southpole.se" <jonas@southpole.se>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        "deller@gmx.de" <deller@gmx.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>
Subject: Re: [PATCH 7/7] arc: use the generic remapping allocator for coherent
 DMA allocations
Thread-Topic: [PATCH 7/7] arc: use the generic remapping allocator for
 coherent DMA allocations
Thread-Index: AQHVIsAMmlRh09Vs6Ea+qlthrKcWyaabcdSA
Date:   Fri, 14 Jun 2019 18:05:01 +0000
Message-ID: <78ac563f2815a9a14bfab6076d0ef948497f5b9f.camel@synopsys.com>
References: <20190614144431.21760-1-hch@lst.de>
         <20190614144431.21760-8-hch@lst.de>
In-Reply-To: <20190614144431.21760-8-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=paltsev@synopsys.com; 
x-originating-ip: [84.204.78.101]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe65ae5e-8ab4-4807-cac3-08d6f0f2d1c4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:SN6PR12MB2670;
x-ms-traffictypediagnostic: SN6PR12MB2670:
x-microsoft-antispam-prvs: <SN6PR12MB2670A4F2AE9D22869844289FDEEE0@SN6PR12MB2670.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 0068C7E410
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(346002)(366004)(39860400002)(376002)(396003)(136003)(189003)(199004)(66476007)(99286004)(66946007)(91956017)(73956011)(118296001)(102836004)(76176011)(478600001)(76116006)(6506007)(305945005)(7736002)(2501003)(66446008)(64756008)(66556008)(8676002)(8936002)(81166006)(81156014)(316002)(53936002)(6436002)(86362001)(6512007)(229853002)(6486002)(4326008)(6246003)(68736007)(25786009)(54906003)(110136005)(14454004)(2906002)(66066001)(7416002)(5660300002)(3846002)(6116002)(6636002)(486006)(476003)(26005)(256004)(14444005)(71190400001)(71200400001)(186003)(36756003)(2616005)(11346002)(446003)(41533002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR12MB2670;H:SN6PR12MB2670.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YBo9AYdmhEZbwv5F7ged9mWrC7tql7NT/82/lk4XBk4yxnVTMeXKJkmO/NjR85T44P5fCtj9xLXlJq9Ucph+GJH4m3+N//zN8tQtYI06Dq4BBxo7v6XIpR22HYlb/2KyiFzVWZ+2nKz84PkZWPkOlIqHHuRcNZ0zWSY16jw5gdyNkT4h/gn7M3mtCfptPWK9h/g0BXFbxbkqC6xgvi/jttuP7GI6eHhrGNHGiGQIfpMalogyDPNVq8zTgVertmYirFJda3stU1kZIIRNzG6smhyRLoZfRYFcnaSs8tqepqOsbsk8RNRuzdww5tXASliJmsM2Hs3JpzT5a9idHU3GyP2F5IGaF4QyjSsW54WTao4IWUGOvUolro4T4ZUaXgvsiQCZDW8IhXZ8DvCk2pH1fNVZx0/w7eUJjwi/d8tuhX4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FCDD90A34BC48347BC639126DA077974@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fe65ae5e-8ab4-4807-cac3-08d6f0f2d1c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2019 18:05:01.0717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: paltsev@synopsys.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2670
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ2hyaXN0b3BoLA0KDQpSZWd1bGFyIHF1ZXN0aW9uIC0gZG8geW91IGhhdmUgYW55IHB1Ymxp
YyBnaXQgcmVwb3NpdG9yeSB3aXRoIGFsbCB0aGlzIGRtYSBjaGFuZ2VzPw0KSSB3YW50IHRvIHRl
c3QgaXQgZm9yIEFSQy4NCg0KUHJldHR5IHN1cmUgdGhlDQogW1BBVENIIDIvN10gYXJjOiByZW1v
dmUgdGhlIHBhcnRpYWwgRE1BX0FUVFJfTk9OX0NPTlNJU1RFTlQgc3VwcG9ydA0KaXMgZmluZS4N
Cg0KTm90IHNvIHN1cmUgYWJvdXQNCiBbUEFUQ0ggNy83XSBhcmM6IHVzZSB0aGUgZ2VuZXJpYyBy
ZW1hcHBpbmcgYWxsb2NhdG9yIGZvciBjb2hlcmVudCBETUEgYWxsb2NhdGlvbnMNCjopDQoNCk9u
IEZyaSwgMjAxOS0wNi0xNCBhdCAxNjo0NCArMDIwMCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6
DQo+IFJlcGxhY2UgdGhlIGNvZGUgdGhhdCBzZXRzIHVwIHVuY2FjaGVkIFBURXMgd2l0aCB0aGUg
Z2VuZXJpYyB2bWFwIGJhc2VkDQo+IHJlbWFwcGluZyBjb2RlLiAgSXQgYWxzbyBwcm92aWRlcyBh
biBhdG9taWMgcG9vbCBmb3IgYWxsb2NhdGlvbnMgZnJvbQ0KPiBub24tYmxvY2tpbmcgY29udGV4
dCwgd2hpY2ggd2Ugbm90IHByb3Blcmx5IHN1cHBvcnRlZCBieSB0aGUgZXhpc3RpbmcNCj4gYXJj
IGNvZGUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5k
ZT4NCj4gLS0tDQo+ICBhcmNoL2FyYy9LY29uZmlnICB8ICAyICsrDQo+ICBhcmNoL2FyYy9tbS9k
bWEuYyB8IDYyICsrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
DQo+ICAyIGZpbGVzIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDUyIGRlbGV0aW9ucygtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJjL0tjb25maWcgYi9hcmNoL2FyYy9LY29uZmlnDQo+
IGluZGV4IDIzZTA2M2RmNWQyYy4uY2RhZDdkMzBmZjFkIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2Fy
Yy9LY29uZmlnDQo+ICsrKyBiL2FyY2gvYXJjL0tjb25maWcNCj4gQEAgLTEwLDYgKzEwLDcgQEAg
Y29uZmlnIEFSQw0KPiAgCWRlZl9ib29sIHkNCj4gIAlzZWxlY3QgQVJDX1RJTUVSUw0KPiAgCXNl
bGVjdCBBUkNIX0hBU19ETUFfQ09IRVJFTlRfVE9fUEZODQo+ICsJc2VsZWN0IEFSQ0hfSEFTX0RN
QV9QUkVQX0NPSEVSRU5UDQo+ICAJc2VsZWN0IEFSQ0hfSEFTX1BURV9TUEVDSUFMDQo+ICAJc2Vs
ZWN0IEFSQ0hfSEFTX1NFVFVQX0RNQV9PUFMNCj4gIAlzZWxlY3QgQVJDSF9IQVNfU1lOQ19ETUFf
Rk9SX0NQVQ0KPiBAQCAtMTksNiArMjAsNyBAQCBjb25maWcgQVJDDQo+ICAJc2VsZWN0IEJVSUxE
VElNRV9FWFRBQkxFX1NPUlQNCj4gIAlzZWxlY3QgQ0xPTkVfQkFDS1dBUkRTDQo+ICAJc2VsZWN0
IENPTU1PTl9DTEsNCj4gKwlzZWxlY3QgRE1BX0RJUkVDVF9SRU1BUA0KPiAgCXNlbGVjdCBHRU5F
UklDX0FUT01JQzY0IGlmICFJU0FfQVJDVjIgfHwgIShBUkNfSEFTX0xMNjQgJiYgQVJDX0hBU19M
TFNDKQ0KPiAgCXNlbGVjdCBHRU5FUklDX0NMT0NLRVZFTlRTDQo+ICAJc2VsZWN0IEdFTkVSSUNf
RklORF9GSVJTVF9CSVQNCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJjL21tL2RtYS5jIGIvYXJjaC9h
cmMvbW0vZG1hLmMNCj4gaW5kZXggOTgzMjkyOGY4OTZkLi4wZmE4NTA3MDlmYWMgMTAwNjQ0DQo+
IC0tLSBhL2FyY2gvYXJjL21tL2RtYS5jDQo+ICsrKyBiL2FyY2gvYXJjL21tL2RtYS5jDQo+IEBA
IC0xMSw0NiArMTEsMTUgQEANCj4gICNpbmNsdWRlIDxhc20vY2FjaGVmbHVzaC5oPg0KPiAgDQo+
ICAvKg0KPiAtICogQVJDSCBzcGVjaWZpYyBjYWxsYmFja3MgZm9yIGdlbmVyaWMgbm9uY29oZXJl
bnQgRE1BIG9wcyAoZG1hL25vbmNvaGVyZW50LmMpDQo+ICsgKiBBUkNIIHNwZWNpZmljIGNhbGxi
YWNrcyBmb3IgZ2VuZXJpYyBub25jb2hlcmVudCBETUEgb3BzDQo+ICAgKiAgLSBoYXJkd2FyZSBJ
T0Mgbm90IGF2YWlsYWJsZSAob3IgImRtYS1jb2hlcmVudCIgbm90IHNldCBmb3IgZGV2aWNlIGlu
IERUKQ0KPiAgICogIC0gQnV0IHN0aWxsIGhhbmRsZSBib3RoIGNvaGVyZW50IGFuZCBub24tY29o
ZXJlbnQgcmVxdWVzdHMgZnJvbSBjYWxsZXINCj4gICAqDQo+ICAgKiBGb3IgRE1BIGNvaGVyZW50
IGhhcmR3YXJlIChJT0MpIGdlbmVyaWMgY29kZSBzdWZmaWNlcw0KPiAgICovDQo+IC12b2lkICph
cmNoX2RtYV9hbGxvYyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHNpemVfdCBzaXplLCBkbWFfYWRkcl90
ICpkbWFfaGFuZGxlLA0KPiAtCQlnZnBfdCBnZnAsIHVuc2lnbmVkIGxvbmcgYXR0cnMpDQo+IC17
DQo+IC0JdW5zaWduZWQgbG9uZyBvcmRlciA9IGdldF9vcmRlcihzaXplKTsNCj4gLQlzdHJ1Y3Qg
cGFnZSAqcGFnZTsNCj4gLQlwaHlzX2FkZHJfdCBwYWRkcjsNCj4gLQl2b2lkICprdmFkZHI7DQo+
IC0NCj4gLQkvKg0KPiAtCSAqIF9fR0ZQX0hJR0hNRU0gZmxhZyBpcyBjbGVhcmVkIGJ5IHVwcGVy
IGxheWVyIGZ1bmN0aW9ucw0KPiAtCSAqIChpbiBpbmNsdWRlL2xpbnV4L2RtYS1tYXBwaW5nLmgp
IHNvIHdlIHNob3VsZCBuZXZlciBnZXQgYQ0KPiAtCSAqIF9fR0ZQX0hJR0hNRU0gaGVyZS4NCj4g
LQkgKi8NCj4gLQlCVUdfT04oZ2ZwICYgX19HRlBfSElHSE1FTSk7DQo+IC0NCj4gLQlwYWdlID0g
YWxsb2NfcGFnZXMoZ2ZwIHwgX19HRlBfWkVSTywgb3JkZXIpOw0KPiAtCWlmICghcGFnZSkNCj4g
LQkJcmV0dXJuIE5VTEw7DQo+IC0NCj4gLQkvKiBUaGlzIGlzIGxpbmVhciBhZGRyICgweDgwMDBf
MDAwMCBiYXNlZCkgKi8NCj4gLQlwYWRkciA9IHBhZ2VfdG9fcGh5cyhwYWdlKTsNCj4gLQ0KPiAt
CSpkbWFfaGFuZGxlID0gcGFkZHI7DQo+IC0NCj4gLQkvKg0KPiAtCSAqIEEgY29oZXJlbnQgYnVm
ZmVyIG5lZWRzIE1NVSBtYXBwaW5nIHRvIGVuZm9yY2Ugbm9uLWNhY2hhYmlsaXR5Lg0KPiAtCSAq
IGt2YWRkciBpcyBrZXJuZWwgVmlydHVhbCBhZGRyZXNzICgweDcwMDBfMDAwMCBiYXNlZCkuDQo+
IC0JICovDQo+IC0Ja3ZhZGRyID0gaW9yZW1hcF9ub2NhY2hlKHBhZGRyLCBzaXplKTsNCj4gLQlp
ZiAoa3ZhZGRyID09IE5VTEwpIHsNCj4gLQkJX19mcmVlX3BhZ2VzKHBhZ2UsIG9yZGVyKTsNCj4g
LQkJcmV0dXJuIE5VTEw7DQo+IC0JfQ0KPiAgDQo+ICt2b2lkIGFyY2hfZG1hX3ByZXBfY29oZXJl
bnQoc3RydWN0IHBhZ2UgKnBhZ2UsIHNpemVfdCBzaXplKQ0KPiArew0KPiAgCS8qDQo+ICAJICog
RXZpY3QgYW55IGV4aXN0aW5nIEwxIGFuZC9vciBMMiBsaW5lcyBmb3IgdGhlIGJhY2tpbmcgcGFn
ZQ0KPiAgCSAqIGluIGNhc2UgaXQgd2FzIHVzZWQgZWFybGllciBhcyBhIG5vcm1hbCAiY2FjaGVk
IiBwYWdlLg0KPiBAQCAtNjEsMjQgKzMwLDcgQEAgdm9pZCAqYXJjaF9kbWFfYWxsb2Moc3RydWN0
IGRldmljZSAqZGV2LCBzaXplX3Qgc2l6ZSwgZG1hX2FkZHJfdCAqZG1hX2hhbmRsZSwNCj4gIAkg
KiBDdXJyZW50bHkgZmx1c2hfY2FjaGVfdm1hcCBudWtlcyB0aGUgTDEgY2FjaGUgY29tcGxldGVs
eSB3aGljaA0KPiAgCSAqIHdpbGwgYmUgb3B0aW1pemVkIGFzIGEgc2VwYXJhdGUgY29tbWl0DQo+
ICAJICovDQo+IC0JZG1hX2NhY2hlX3diYWNrX2ludihwYWRkciwgc2l6ZSk7DQo+IC0JcmV0dXJu
IGt2YWRkcjsNCj4gLX0NCj4gLQ0KPiAtdm9pZCBhcmNoX2RtYV9mcmVlKHN0cnVjdCBkZXZpY2Ug
KmRldiwgc2l6ZV90IHNpemUsIHZvaWQgKnZhZGRyLA0KPiAtCQlkbWFfYWRkcl90IGRtYV9oYW5k
bGUsIHVuc2lnbmVkIGxvbmcgYXR0cnMpDQo+IC17DQo+IC0JcGh5c19hZGRyX3QgcGFkZHIgPSBk
bWFfaGFuZGxlOw0KPiAtCXN0cnVjdCBwYWdlICpwYWdlID0gdmlydF90b19wYWdlKHBhZGRyKTsN
Cj4gLQ0KPiAtCWlvdW5tYXAoKHZvaWQgX19mb3JjZSBfX2lvbWVtICopdmFkZHIpOw0KPiAtCV9f
ZnJlZV9wYWdlcyhwYWdlLCBnZXRfb3JkZXIoc2l6ZSkpOw0KPiAtfQ0KPiAtDQo+IC1sb25nIGFy
Y2hfZG1hX2NvaGVyZW50X3RvX3BmbihzdHJ1Y3QgZGV2aWNlICpkZXYsIHZvaWQgKmNwdV9hZGRy
LA0KPiAtCQlkbWFfYWRkcl90IGRtYV9hZGRyKQ0KPiAtew0KPiAtCXJldHVybiBfX3BoeXNfdG9f
cGZuKGRtYV9hZGRyKTsNCj4gKwlkbWFfY2FjaGVfd2JhY2tfaW52KHBhZ2VfdG9fcGh5cyhwYWdl
KSwgc2l6ZSk7DQo+ICB9DQo+ICANCj4gIC8qDQo+IEBAIC0xNTUsMyArMTA3LDkgQEAgdm9pZCBh
cmNoX3NldHVwX2RtYV9vcHMoc3RydWN0IGRldmljZSAqZGV2LCB1NjQgZG1hX2Jhc2UsIHU2NCBz
aXplLA0KPiAgCWRldl9pbmZvKGRldiwgInVzZSAlc25jb2hlcmVudCBETUEgb3BzXG4iLA0KPiAg
CQkgZGV2LT5kbWFfY29oZXJlbnQgPyAiIiA6ICJub24iKTsNCj4gIH0NCj4gKw0KPiArc3RhdGlj
IGludCBfX2luaXQgYXRvbWljX3Bvb2xfaW5pdCh2b2lkKQ0KPiArew0KPiArCXJldHVybiBkbWFf
YXRvbWljX3Bvb2xfaW5pdChHRlBfS0VSTkVMLCBwZ3Byb3Rfbm9uY2FjaGVkKFBBR0VfS0VSTkVM
KSk7DQo+ICt9DQo+ICtwb3N0Y29yZV9pbml0Y2FsbChhdG9taWNfcG9vbF9pbml0KTsNCi0tIA0K
IEV1Z2VuaXkgUGFsdHNldg0K
