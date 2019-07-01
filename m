Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9162C06510
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 21:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A57482173E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 21:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NpKXSR5u";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ghtlyfY3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfGAV0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 17:26:21 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:44854 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbfGAV0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 17:26:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562016380; x=1593552380;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3V/LpFRVnfBTIRTA/E6S6Opbxs7T1rbBrBsb20bpQxg=;
  b=NpKXSR5usc6C/8E2IQwPBJDI7GTZFo73FUhifitqbNfDMFVVC8OS7jcx
   L3c+UWdKdLKkzT31gKEQ0V3mDWyx3cE2TOC2nuvWXeTRsDr8GUit7YiA9
   3RfIPN/tjIDby+f7lMbbrab6lXtBGOTxv8JOWM2bfhYrIKlAf6fO4IUg7
   9nEutAGQqB19mSEG9RQwodWntuuZACdxlPiUy9fPvIEFtfQwqUkZwJZly
   2ADqYFSAC1a7RqspguvHn+oB0a86Kk78C0NcNNaZDDhBE6kSgOuCzBYQH
   7Bz+Lt4U79gH+NGghDBAESTyzmIHK6aXSiJCxy3V88O/dwEgo0TxIRJZ6
   g==;
X-IronPort-AV: E=Sophos;i="5.63,440,1557158400"; 
   d="scan'208";a="113613833"
Received: from mail-by2nam03lp2055.outbound.protection.outlook.com (HELO NAM03-BY2-obe.outbound.protection.outlook.com) ([104.47.42.55])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2019 05:26:19 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3V/LpFRVnfBTIRTA/E6S6Opbxs7T1rbBrBsb20bpQxg=;
 b=ghtlyfY3MWv6VUkokwb/p/GbYrO9IVX+/jweAoRAjxboEDG2ln0PXrCPomrE3K3KkzudoSs/6AuTQIHXFSswdtvE1+FsdhxspDHn1vg1tkzO+Xy5HOsdBxMiQdGijZBt95vU68tF2und04RP+B2airn66rxDOaUcolsOqf23HJw=
Received: from BYAPR04MB3782.namprd04.prod.outlook.com (52.135.214.142) by
 BYAPR04MB4664.namprd04.prod.outlook.com (52.135.240.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Mon, 1 Jul 2019 21:26:18 +0000
Received: from BYAPR04MB3782.namprd04.prod.outlook.com
 ([fe80::65e3:6069:d7d5:90a2]) by BYAPR04MB3782.namprd04.prod.outlook.com
 ([fe80::65e3:6069:d7d5:90a2%5]) with mapi id 15.20.2032.019; Mon, 1 Jul 2019
 21:26:18 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "hch@lst.de" <hch@lst.de>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@sifive.com" <palmer@sifive.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 16/17] riscv: clear the instruction cache and all
 registers when booting
Thread-Topic: [PATCH 16/17] riscv: clear the instruction cache and all
 registers when booting
Thread-Index: AQHVKk/eafb73EoeVUKcVAZHOtIduKa2UpyA
Date:   Mon, 1 Jul 2019 21:26:18 +0000
Message-ID: <78919862d11f6d56446f8fffd8a1a8c601ea5c32.camel@wdc.com>
References: <20190624054311.30256-1-hch@lst.de>
         <20190624054311.30256-17-hch@lst.de>
In-Reply-To: <20190624054311.30256-17-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [199.255.45.61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 52bd3de9-56d7-489f-bfcc-08d6fe6ac148
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4664;
x-ms-traffictypediagnostic: BYAPR04MB4664:
x-microsoft-antispam-prvs: <BYAPR04MB46647A09F1EECF00129DC8C9FAF90@BYAPR04MB4664.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1265;
x-forefront-prvs: 00851CA28B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(189003)(199004)(118296001)(25786009)(71190400001)(71200400001)(476003)(486006)(2501003)(99286004)(2616005)(6506007)(76176011)(26005)(256004)(14444005)(6116002)(3846002)(478600001)(446003)(186003)(102836004)(72206003)(36756003)(11346002)(6436002)(76116006)(6486002)(2201001)(2906002)(53936002)(14454004)(229853002)(6512007)(5660300002)(316002)(66066001)(66946007)(54906003)(66476007)(66446008)(66556008)(64756008)(73956011)(68736007)(110136005)(6246003)(8676002)(81166006)(81156014)(86362001)(8936002)(305945005)(7736002)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4664;H:BYAPR04MB3782.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KslD34yP5hwFESqyOJ0iBtBjfXD0dQncTKQ4fD9kcR4kfgsHcs0HH/ZJMUc/DBZMrb/qUSDtBXj5YhB+HF00PBwPCn3v1rrcIRCUnozxVzKzyUDEGm5Y4pIXzQrpw2fN1+90KJvWVbxJIZfV1eLGItrC4CTC5F97GoQFQjYVMBIxiLQvrBECE3RrbPbTcxQ57KUz0sOoXQwjnB8ZthVQgUl+CqN6I5YyJKZYDgGbibnWPBGlgW0UkybCx+7D5HN7xfl02U7jE30IonlZYGqctOX/2d3CW/My4cVSpsBlxGNnSD7Yu3O+dqiXvxG2XNIg9KE5K0vqsYqvoOGqr533dwVox15t2qLKhk7nnlOztphOJxv8mR+cbuoDY+ky10eT39evfR5j4Yv1+kdmezF7MDIO8yuMeW2Qz9lT0moh8O4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F95E20170DB634F896CA2BAF2589A70@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52bd3de9-56d7-489f-bfcc-08d6fe6ac148
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2019 21:26:18.0563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Atish.Patra@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4664
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE5LTA2LTI0IGF0IDA3OjQzICswMjAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gV2hlbiB3ZSBnZXQgYm9vdGVkIHdlIHdhbnQgYSBjbGVhciBzbGF0ZSB3aXRob3V0IGFu
eSBsZWFrcyBmcm9tDQo+IHByZXZpb3VzDQo+IHN1cGVydmlzb3JzIG9yIHRoZSBmaXJtd2FyZS4g
IEZsdXNoIHRoZSBpbnN0cnVjdGlvbiBjYWNoZSBhbmQgdGhlbg0KPiBjbGVhcg0KPiBhbGwgcmVn
aXN0ZXJzIHRvIGtub3duIGdvb2QgdmFsdWVzLiAgVGhpcyBpcyByZWFsbHkgaW1wb3J0YW50IGZv
ciB0aGUNCj4gdXBjb21pbmcgbm9tbXUgc3VwcG9ydCB0aGF0IHJ1bnMgb24gTS1tb2RlLCBidXQg
Y2FuJ3QgcmVhbGx5IGhhcm0NCj4gd2hlbg0KPiBydW5uaW5nIGluIFMtbW9kZSBlaXRoZXIuDQoN
ClRoYXQgbWVhbnMgaXQgc2hvdWxkIGJlIGRvbmUgZm9yIFMtbW9kZSBhcyB3ZWxsLiBSaWdodCA/
DQpJIHNlZSB0aGUgcmVzZXQgY29kZSBpcyBlbmFibGVkIG9ubHkgZm9yIE0tbW9kZSBvbmx5Lg0K
DQo+ICAgVmFndWVseSBiYXNlZCBvbiB0aGUgY29uY2VwdHMgZnJvbSBvcGVuc2JpLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+IC0tLQ0KPiAg
YXJjaC9yaXNjdi9rZXJuZWwvaGVhZC5TIHwgODUNCj4gKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDg1IGluc2VydGlvbnMoKykNCj4g
DQo+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L2tlcm5lbC9oZWFkLlMgYi9hcmNoL3Jpc2N2L2tl
cm5lbC9oZWFkLlMNCj4gaW5kZXggYTRjMTcwZTQxYTM0Li43NGZlYjE3NzM3YjQgMTAwNjQ0DQo+
IC0tLSBhL2FyY2gvcmlzY3Yva2VybmVsL2hlYWQuUw0KPiArKysgYi9hcmNoL3Jpc2N2L2tlcm5l
bC9oZWFkLlMNCj4gQEAgLTExLDYgKzExLDcgQEANCj4gICNpbmNsdWRlIDxhc20vdGhyZWFkX2lu
Zm8uaD4NCj4gICNpbmNsdWRlIDxhc20vcGFnZS5oPg0KPiAgI2luY2x1ZGUgPGFzbS9jc3IuaD4N
Cj4gKyNpbmNsdWRlIDxhc20vaHdjYXAuaD4NCj4gIA0KPiAgX19JTklUDQo+ICBFTlRSWShfc3Rh
cnQpDQo+IEBAIC0xOSw2ICsyMCwxMiBAQCBFTlRSWShfc3RhcnQpDQo+ICAJY3NydyBDU1JfWElQ
LCB6ZXJvDQo+ICANCj4gICNpZmRlZiBDT05GSUdfTV9NT0RFDQo+ICsJLyogZmx1c2ggdGhlIGlu
c3RydWN0aW9uIGNhY2hlICovDQo+ICsJZmVuY2UuaQ0KPiArDQo+ICsJLyogUmVzZXQgYWxsIHJl
Z2lzdGVycyBleGNlcHQgcmEsIGEwLCBhMSAqLw0KPiArCWNhbGwgcmVzZXRfcmVncw0KPiArDQo+
ICAJLyoNCj4gIAkgKiBUaGUgaGFydGlkIGluIGEwIGlzIGV4cGVjdGVkIGxhdGVyIG9uLCBhbmQg
d2UgaGF2ZSBubw0KPiBmaXJtd2FyZQ0KPiAgCSAqIHRvIGhhbmQgaXQgdG8gdXMuDQo+IEBAIC0x
NjgsNiArMTc1LDg0IEBAIHJlbG9jYXRlOg0KPiAgCWogLkxzZWNvbmRhcnlfcGFyaw0KPiAgRU5E
KF9zdGFydCkNCj4gIA0KPiArI2lmZGVmIENPTkZJR19NX01PREUNCj4gK0VOVFJZKHJlc2V0X3Jl
Z3MpDQo+ICsJbGkJc3AsIDANCj4gKwlsaQlncCwgMA0KPiArCWxpCXRwLCAwDQo+ICsJbGkJdDAs
IDANCj4gKwlsaQl0MSwgMA0KPiArCWxpCXQyLCAwDQo+ICsJbGkJczAsIDANCj4gKwlsaQlzMSwg
MA0KPiArCWxpCWEyLCAwDQo+ICsJbGkJYTMsIDANCj4gKwlsaQlhNCwgMA0KPiArCWxpCWE1LCAw
DQo+ICsJbGkJYTYsIDANCj4gKwlsaQlhNywgMA0KPiArCWxpCXMyLCAwDQo+ICsJbGkJczMsIDAN
Cj4gKwlsaQlzNCwgMA0KPiArCWxpCXM1LCAwDQo+ICsJbGkJczYsIDANCj4gKwlsaQlzNywgMA0K
PiArCWxpCXM4LCAwDQo+ICsJbGkJczksIDANCj4gKwlsaQlzMTAsIDANCj4gKwlsaQlzMTEsIDAN
Cj4gKwlsaQl0MywgMA0KPiArCWxpCXQ0LCAwDQo+ICsJbGkJdDUsIDANCj4gKwlsaQl0NiwgMA0K
PiArCWNzcncJc3NjcmF0Y2gsIDANCj4gKw0KPiArI2lmZGVmIENPTkZJR19GUFUNCj4gKwljc3Jy
CXQwLCBtaXNhDQo+ICsJYW5kaQl0MCwgdDAsIChDT01QQVRfSFdDQVBfSVNBX0YgfCBDT01QQVRf
SFdDQVBfSVNBX0QpDQo+ICsJYm5legl0MCwgLkxyZXNldF9yZWdzX2RvbmUNCj4gKw0KPiArCWxp
CXQxLCBTUl9GUw0KPiArCWNzcnMJc3N0YXR1cywgdDENCj4gKwlmbXYucy54CWYwLCB6ZXJvDQo+
ICsJZm12LnMueAlmMSwgemVybw0KPiArCWZtdi5zLngJZjIsIHplcm8NCj4gKwlmbXYucy54CWYz
LCB6ZXJvDQo+ICsJZm12LnMueAlmNCwgemVybw0KPiArCWZtdi5zLngJZjUsIHplcm8NCj4gKwlm
bXYucy54CWY2LCB6ZXJvDQo+ICsJZm12LnMueAlmNywgemVybw0KPiArCWZtdi5zLngJZjgsIHpl
cm8NCj4gKwlmbXYucy54CWY5LCB6ZXJvDQo+ICsJZm12LnMueAlmMTAsIHplcm8NCj4gKwlmbXYu
cy54CWYxMSwgemVybw0KPiArCWZtdi5zLngJZjEyLCB6ZXJvDQo+ICsJZm12LnMueAlmMTMsIHpl
cm8NCj4gKwlmbXYucy54CWYxNCwgemVybw0KPiArCWZtdi5zLngJZjE1LCB6ZXJvDQo+ICsJZm12
LnMueAlmMTYsIHplcm8NCj4gKwlmbXYucy54CWYxNywgemVybw0KPiArCWZtdi5zLngJZjE4LCB6
ZXJvDQo+ICsJZm12LnMueAlmMTksIHplcm8NCj4gKwlmbXYucy54CWYyMCwgemVybw0KPiArCWZt
di5zLngJZjIxLCB6ZXJvDQo+ICsJZm12LnMueAlmMjIsIHplcm8NCj4gKwlmbXYucy54CWYyMywg
emVybw0KPiArCWZtdi5zLngJZjI0LCB6ZXJvDQo+ICsJZm12LnMueAlmMjUsIHplcm8NCj4gKwlm
bXYucy54CWYyNiwgemVybw0KPiArCWZtdi5zLngJZjI3LCB6ZXJvDQo+ICsJZm12LnMueAlmMjgs
IHplcm8NCj4gKwlmbXYucy54CWYyOSwgemVybw0KPiArCWZtdi5zLngJZjMwLCB6ZXJvDQo+ICsJ
Zm12LnMueAlmMzEsIHplcm8NCj4gKwljc3J3CWZjc3IsIDANCj4gKyNlbmRpZiAvKiBDT05GSUdf
RlBVICovDQo+ICsuTHJlc2V0X3JlZ3NfZG9uZToNCj4gKwlyZXQNCj4gK0VORChyZXNldF9yZWdz
KQ0KPiArI2VuZGlmIC8qIENPTkZJR19NX01PREUgKi8NCj4gKw0KPiAgX19QQUdFX0FMSUdORURf
QlNTDQo+ICAJLyogRW1wdHkgemVybyBwYWdlICovDQo+ICAJLmJhbGlnbiBQQUdFX1NJWkUNCg0K
LS0gDQpSZWdhcmRzLA0KQXRpc2gNCg==
