Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC634C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 19:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 861E82083B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 19:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MgVOVsvr";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="I93raC/J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfFUTOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 15:14:31 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:21042 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfFUTOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 15:14:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561144470; x=1592680470;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+AJQW0kNNpk4BWguDTeJsA9QlCDT0tD7bbEXMXP+RgQ=;
  b=MgVOVsvrbadVk0TTHe7RJgvuJWrQVDV+JliekcSW4+cTK+y1YPO4g3Sp
   ZGFNZ1N65QNdhpJO1jgRRJQdaJMwO/ztE1Jn/XzjixEiWFtz41Pj0H0kk
   Mq5EOZ9hezU4z3Gz5L1tE+9TqdtOXs3t1eYi688BEpGR+VZP6da0+o4er
   JCE7Q8lVLUJEC9/B7GBU41V2TDZ3Uyn8/tTzcEvwpoDSxLzIj4SHrvRTj
   pKCh/hAjYhrtb6JcfTDXTtAD5UgBBj1OcZXh+M86xP2n+ntVh/ysPjWwg
   1qwEbYP0O0wsN1D0PjeF+R9TnFu7/dIVph4UCRGMOUjfI3FgX1/GK2ijy
   Q==;
X-IronPort-AV: E=Sophos;i="5.63,401,1557158400"; 
   d="scan'208";a="112410683"
Received: from mail-sn1nam04lp2052.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.52])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jun 2019 03:14:29 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+AJQW0kNNpk4BWguDTeJsA9QlCDT0tD7bbEXMXP+RgQ=;
 b=I93raC/JVgBtohLBZoTsijI2+grtVr6lz9j93438ogMYLSxrUFE0TKcj73eeqWeZERNYl+7YUeUBLad7EdiThktf4D7dKSD8WTGWp3RBs9sIF7q47kCqRMdA2quru56IhT5KM55iMQhw+wjeBpVtvPYt2jAVWy3otkNumR2RlJI=
Received: from BYAPR04MB3782.namprd04.prod.outlook.com (52.135.214.142) by
 BYAPR04MB5045.namprd04.prod.outlook.com (52.135.235.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.15; Fri, 21 Jun 2019 19:14:27 +0000
Received: from BYAPR04MB3782.namprd04.prod.outlook.com
 ([fe80::65e3:6069:d7d5:90a2]) by BYAPR04MB3782.namprd04.prod.outlook.com
 ([fe80::65e3:6069:d7d5:90a2%5]) with mapi id 15.20.1987.014; Fri, 21 Jun 2019
 19:14:27 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yash.shah@sifive.com" <yash.shah@sifive.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "sachin.ghadi@sifive.com" <sachin.ghadi@sifive.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v2] riscv: dts: Add DT node for SiFive FU540 Ethernet
 controller driver
Thread-Topic: [PATCH v2] riscv: dts: Add DT node for SiFive FU540 Ethernet
 controller driver
Thread-Index: AQHVKCA1s3Kn2VpoYUKwjMwaF74JUaametQA
Date:   Fri, 21 Jun 2019 19:14:27 +0000
Message-ID: <18c7992607dd1fed062bd295ac0738a759eff078.camel@wdc.com>
References: <1561114429-29612-1-git-send-email-yash.shah@sifive.com>
         <1561114429-29612-2-git-send-email-yash.shah@sifive.com>
In-Reply-To: <1561114429-29612-2-git-send-email-yash.shah@sifive.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 75bd2c75-aeef-40f3-473e-08d6f67cae1d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5045;
x-ms-traffictypediagnostic: BYAPR04MB5045:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB5045CAA56321F757D4B58C15FAE70@BYAPR04MB5045.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 0075CB064E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6029001)(136003)(39860400002)(376002)(396003)(346002)(366004)(199004)(189003)(72206003)(66476007)(476003)(186003)(81156014)(2906002)(2201001)(3846002)(14454004)(76116006)(102836004)(7416002)(53936002)(110136005)(81166006)(6512007)(486006)(26005)(54906003)(6436002)(71200400001)(66946007)(118296001)(4326008)(316002)(6486002)(68736007)(6116002)(66066001)(8676002)(36756003)(6246003)(25786009)(229853002)(256004)(2501003)(6506007)(64756008)(14444005)(446003)(8936002)(5660300002)(478600001)(305945005)(2616005)(7736002)(76176011)(99286004)(86362001)(71190400001)(73956011)(11346002)(66556008)(66446008);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5045;H:BYAPR04MB3782.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XfTAuXQ8PpV80uoBukLPgKSIruDsacpPQqWmc+iVP563000HlHXcow/J8UkxzyOwQTOnvJALIzzhxdnFqRouBRF4cB2gzGjmm/oacl/2XbFvQeVJ9soZC0qWxzvgnJCjjp1Dj0w9RkevwRcaij7Ma4K2LSpjQh810JhFIUqRR3SGBZUBYC7fFW5Q2s0Dn/9qP80Zhvb1Qd0oZ2vvBXoVmGJT8+00NcwyPbKhnUOCylQpJmlQ9JAgiVqYm0y2KF8lVh5ube8pU615pkNeGS4LgkSc8H7fcjG3/3y+xGq1OmG9rtkKVbG+ydYwPEL01Ts7ByApt7FBV1q8zXHXmbz9hNo7KYvj0A7wJcUZIT3JQqlWGmNsKAutH0oOoxfBee2XprvWED7C2Z+kpm0NoeSQTe5OwBkzN/ofw6CBD86u9dU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0C3E41F463150B45B327C91AE3200B30@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75bd2c75-aeef-40f3-473e-08d6f67cae1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2019 19:14:27.6546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Atish.Patra@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5045
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE5LTA2LTIxIGF0IDE2OjIzICswNTMwLCBZYXNoIFNoYWggd3JvdGU6DQo+IERU
IG5vZGUgZm9yIFNpRml2ZSBGVTU0MC1DMDAwIEdFTUdYTCBFdGhlcm5ldCBjb250cm9sbGVyIGRy
aXZlciBhZGRlZA0KPiANCj4gU2lnbmVkLW9mZi1ieTogWWFzaCBTaGFoIDx5YXNoLnNoYWhAc2lm
aXZlLmNvbT4NCj4gLS0tDQo+ICBhcmNoL3Jpc2N2L2Jvb3QvZHRzL3NpZml2ZS9mdTU0MC1jMDAw
LmR0c2kgICAgICAgICAgfCAxNg0KPiArKysrKysrKysrKysrKysrDQo+ICBhcmNoL3Jpc2N2L2Jv
b3QvZHRzL3NpZml2ZS9oaWZpdmUtdW5sZWFzaGVkLWEwMC5kdHMgfCAgOSArKysrKysrKysNCj4g
IDIgZmlsZXMgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Fy
Y2gvcmlzY3YvYm9vdC9kdHMvc2lmaXZlL2Z1NTQwLWMwMDAuZHRzaQ0KPiBiL2FyY2gvcmlzY3Yv
Ym9vdC9kdHMvc2lmaXZlL2Z1NTQwLWMwMDAuZHRzaQ0KPiBpbmRleCA0ZThmYmRlLi5jNTNiNGVh
IDEwMDY0NA0KPiAtLS0gYS9hcmNoL3Jpc2N2L2Jvb3QvZHRzL3NpZml2ZS9mdTU0MC1jMDAwLmR0
c2kNCj4gKysrIGIvYXJjaC9yaXNjdi9ib290L2R0cy9zaWZpdmUvZnU1NDAtYzAwMC5kdHNpDQo+
IEBAIC0yMjUsNSArMjI1LDIxIEBADQo+ICAJCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gIAkJ
CSNzaXplLWNlbGxzID0gPDA+Ow0KPiAgCQl9Ow0KPiArCQlldGgwOiBldGhlcm5ldEAxMDA5MDAw
MCB7DQo+ICsJCQljb21wYXRpYmxlID0gInNpZml2ZSxmdTU0MC1tYWNiIjsNCj4gKwkJCWludGVy
cnVwdC1wYXJlbnQgPSA8JnBsaWMwPjsNCj4gKwkJCWludGVycnVwdHMgPSA8NTM+Ow0KPiArCQkJ
cmVnID0gPDB4MCAweDEwMDkwMDAwIDB4MCAweDIwMDANCj4gKwkJCSAgICAgICAweDAgMHgxMDBh
MDAwMCAweDAgMHgxMDAwPjsNCj4gKwkJCXJlZy1uYW1lcyA9ICJjb250cm9sIjsNCj4gKwkJCXN0
YXR1cyA9ICJkaXNhYmxlZCI7DQo+ICsJCQlsb2NhbC1tYWMtYWRkcmVzcyA9IFswMCAwMCAwMCAw
MCAwMCAwMF07DQo+ICsJCQljbG9jay1uYW1lcyA9ICJwY2xrIiwgImhjbGsiOw0KPiArCQkJY2xv
Y2tzID0gPCZwcmNpIFBSQ0lfQ0xLX0dFTUdYTFBMTD4sDQo+ICsJCQkJIDwmcHJjaSBQUkNJX0NM
S19HRU1HWExQTEw+Ow0KPiArCQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ICsJCQkjc2l6ZS1j
ZWxscyA9IDwwPjsNCj4gKwkJfTsNCj4gKw0KPiAgCX07DQo+ICB9Ow0KPiBkaWZmIC0tZ2l0IGEv
YXJjaC9yaXNjdi9ib290L2R0cy9zaWZpdmUvaGlmaXZlLXVubGVhc2hlZC1hMDAuZHRzDQo+IGIv
YXJjaC9yaXNjdi9ib290L2R0cy9zaWZpdmUvaGlmaXZlLXVubGVhc2hlZC1hMDAuZHRzDQo+IGlu
ZGV4IDRkYTg4NzAuLmQ3ODNiZjIgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvcmlzY3YvYm9vdC9kdHMv
c2lmaXZlL2hpZml2ZS11bmxlYXNoZWQtYTAwLmR0cw0KPiArKysgYi9hcmNoL3Jpc2N2L2Jvb3Qv
ZHRzL3NpZml2ZS9oaWZpdmUtdW5sZWFzaGVkLWEwMC5kdHMNCj4gQEAgLTYzLDMgKzYzLDEyIEBA
DQo+ICAJCWRpc2FibGUtd3A7DQo+ICAJfTsNCj4gIH07DQo+ICsNCj4gKyZldGgwIHsNCj4gKwlz
dGF0dXMgPSAib2theSI7DQo+ICsJcGh5LW1vZGUgPSAiZ21paSI7DQo+ICsJcGh5LWhhbmRsZSA9
IDwmcGh5MT47DQo+ICsJcGh5MTogZXRoZXJuZXQtcGh5QDAgew0KPiArCQlyZWcgPSA8MD47DQo+
ICsJfTsNCj4gK307DQoNClRoYW5rcy4gSSBhbSBhYmxlIHRvIGJvb3QgVW5sZWFzaGVkIHdpdGgg
bmV0d29ya2luZyBlbmFibGVkIHdpdGggdGhpcw0KcGF0Y2guDQoNCkZXSVcsIA0KVGVzdGVkLWJ5
OiBBdGlzaCBQYXRyYSA8YXRpc2gucGF0cmFAd2RjLmNvbT4NCg0KUmVnYXJkcywNCkF0aXNoDQo=
