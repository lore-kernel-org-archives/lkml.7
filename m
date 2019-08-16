Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56EA6C3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 19:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18C302077C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 19:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bF9+kFBu";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="gjQ/a2Q7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbfHPTV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 15:21:58 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:16227 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfHPTV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 15:21:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1565983316; x=1597519316;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZNDl+bii6Kn3re353eARcian2bRjMp890MTLEeU/mto=;
  b=bF9+kFBuw4Itjb1paImZmeABVlLsuSvXfVg0Ccqb9IXZvLMvLGTp/cqD
   ZrJ4xrb4Tqbari3KEnUwkmQ+v6riOwmDpRHCq6XV6MqDc0WaJ3E3L+36j
   fR8w/WADQHWeJsMCUzUEF9VpOvLHGQZDWrRKFZOjA87PoccMjlzij4GLk
   eTpDe9xRYobxATXfNPhsc894Ou2uRIe2qj6VEHcwOD0aGj3pXCoOUUAL1
   OPBKi7M6MqGZcvH663TI4toj9lJwaVXbA8YHTKjWaF/m20MjB7H39jDev
   dQk6ZQbXfJ8l0jgfsX1plepnBYLJkRMerZnROX+WZ9rM507GseYrHanfb
   w==;
IronPort-SDR: 6sl0qd4cRw2Ws0eKbKN0Juck8C3Wub18vyQ5OmihUoflzicBgNWfPQKmtdmzRZhJeIvWTvrfEf
 wFzoYRS5sFaS31B0g50upLUl7Q1pVMYdA+1X7EsBrKLhvzYa1TcqRQtY3bMEMWCIhpdhurDCm5
 KyiD9JZaY9R7nZOaGa+XSpCTLy4LxUHN24G+P20Zoz08N4PlsIrRPz426nlzqCR0UVD2pwZOeK
 WODuCfsY0+JhZbDEXwSkJuo0/DCZD1AzVMf0Vll9FrozR8lZM46do/+4Rqj/bqjt3hTYd/tTeX
 2d8=
X-IronPort-AV: E=Sophos;i="5.64,394,1559491200"; 
   d="scan'208";a="120614103"
Received: from mail-bl2nam02lp2058.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.58])
  by ob1.hgst.iphmx.com with ESMTP; 17 Aug 2019 03:21:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JeOEXv+Yj67xuO4pvcmqVNv2tPWzqFY7bSIdG0yJNO2dcLXTlRNH88Yq1bEHxgubVF9OvXwNEtKWrA6z4U0MKTWCs0jgyNJ/tjXNCHwCt2A9kwKVN3W7gkaF+O5hWOfLO9xvVO/CAQYmPh14kZLY1MM7+yCTGh8VXf4MzlVS2lhgVa+x6RTGrPKSWds/wnRSJaVMlYVokG9PmHttipvan4xHcgq2B3QLUkOzObLQ2uPlW9AMjzg6tCQU6YjjiZZiJ55Zyy+zV9WRw7WhSoDKDD2IKjOMa1XY76iIsSutZoGg6AF/vTMLH6CV2HL92Mi1m/AXYChNRBLqkr6RjhCJCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZNDl+bii6Kn3re353eARcian2bRjMp890MTLEeU/mto=;
 b=VkN4fUxEqYGxErl0nphmLobN3aRA97I/rQMP3ULPogJ1z55pqkcwbMRL/OnoEB2TDsqXKx50jPuRzj+RDUb5ZjainncgufnqVB2ysCwBRrNEWRkSXVQN233kPI2gdeMqnclrqRfLvyBFuffdPzm0lJcQXSKbZp4Jj1qO6C6+vDbUIn6f4KD15c+dqsX4frs6sV/DHoyBSEQCfysYS31SxWAhGXnKMltqb79vzxhYgApsmaRVEv3ABcqsIS0OBNw5ZvSCzSDIY3z2+9+Pl2UwA+NwZF/g1r9oGbAryJ/rGO42c3s2/mKkYrGiiJBx1WVzvEJUEj5ZLK/ya+7laIk3dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZNDl+bii6Kn3re353eARcian2bRjMp890MTLEeU/mto=;
 b=gjQ/a2Q7arhq4kvf16Yf96ow8rzvAkcNx1pzVtRYaDU5X5j/HXoblSupWjmODRwTNMTbxcZSsSVXknKZl4D6cqodMf3jA8gYmOyGOpHsYwWCpa+JiYshnb3G9x7tRP5kL5QDLdsFymH1ZTIuIDLyjwRSiRHSVa800nZymW984jo=
Received: from BYAPR04MB3990.namprd04.prod.outlook.com (52.135.215.29) by
 BYAPR04MB5845.namprd04.prod.outlook.com (20.179.59.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.20; Fri, 16 Aug 2019 19:21:53 +0000
Received: from BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::d89b:cb55:d563:79e9]) by BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::d89b:cb55:d563:79e9%6]) with mapi id 15.20.2157.022; Fri, 16 Aug 2019
 19:21:53 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     "anup@brainfault.org" <anup@brainfault.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "johan@kernel.org" <johan@kernel.org>
Subject: Re: [v5 PATCH] RISC-V: Fix unsupported isa string info.
Thread-Topic: [v5 PATCH] RISC-V: Fix unsupported isa string info.
Thread-Index: AQHVTU090lWiUiEQM02Uoz9V3NTipqb3o0CAgAaR3AA=
Date:   Fri, 16 Aug 2019 19:21:52 +0000
Message-ID: <3fb8d4f0383b005ecd932a69c4dd295a79b6fb1a.camel@wdc.com>
References: <20190807182316.28013-1-atish.patra@wdc.com>
         <20190812150215.GF26897@infradead.org>
In-Reply-To: <20190812150215.GF26897@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [199.255.44.175]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f4e447b-ebf0-4905-ffaf-08d7227efebe
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5845;
x-ms-traffictypediagnostic: BYAPR04MB5845:
x-microsoft-antispam-prvs: <BYAPR04MB5845D238E3A0F20487A85358FAAF0@BYAPR04MB5845.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 0131D22242
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(366004)(136003)(396003)(39860400002)(376002)(189003)(199004)(6116002)(81166006)(36756003)(5660300002)(3846002)(1730700003)(446003)(478600001)(256004)(54906003)(6246003)(25786009)(81156014)(8676002)(305945005)(71200400001)(71190400001)(99286004)(14454004)(7736002)(53936002)(316002)(6512007)(66446008)(66556008)(64756008)(76176011)(66476007)(6506007)(2501003)(86362001)(118296001)(66946007)(76116006)(476003)(4326008)(8936002)(102836004)(26005)(186003)(6916009)(6436002)(6486002)(229853002)(5640700003)(2906002)(2351001)(66066001)(486006)(11346002)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5845;H:BYAPR04MB3990.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vmdvgaEmU/EnPLf9DH+NxedgHk1PxS/K/CNCREo1pck+cVAElfpHJRBlUAEQYW9IARMKLSIlBhrH/Y4+fbmfbaayDJ35dE/zjjS28OB4aAzY1+etlWNp2tIseOwt6V+1QkZBUqOci+f/5C6o+lODXGrkfabZ7f4MuEuUYL6C9Wm9Oc8+dllGMAd4Rmc91pSIzkwvh5f7vBIfszXEue8ekQAPoLflc8MPlNpk0pVgGk/TRLo2g3FEqEbCB+SyA0I17kFOxHFHHlm7AGJYE/gF+03UMZUW2VA58ht43BzXCM+bA0zXqgt8tDCplqGP90GAQOxA+QwxAH/PwKaopl1IcVpKgnyCIQKxcMuhrmgmhqzG3KN8rTwuDAhFR+Xc78M+T3tlJleXWgG6/gU6My947BwYpFB/TGcvHRx8mAmAH/w=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C1958C8B74608D4698922317252C5ED2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f4e447b-ebf0-4905-ffaf-08d7227efebe
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2019 19:21:52.9989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J3+uy0fnnvUehxT0mwnBbGg3K6xzcDxzjwkyjoj9QEpttRSsoZjVVRzWbl3ndZqFBELmDzereRy3uX1yDUiEDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5845
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE5LTA4LTEyIGF0IDA4OjAyIC0wNzAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gPiArCWZvciAoZSA9IG1hbmRhdG9yeV9leHQ7ICplICE9ICdcMCc7ICsrZSkgew0KPiA+
ICsJCWlmIChpc2FbMF0gIT0gZVswXSkgew0KPiA+ICsjaWYgZGVmaW5lZChDT05GSUdfRlApDQo+
ID4gKwkJCWlmICgoaXNhWzBdID09ICdmJykgfHwgKGlzYVswXSA9PSAnZCcpKQ0KPiA+ICsJCQkJ
Y29udGludWU7DQo+ID4gKyNlbmRpZg0KPiA+ICsJCQl1bnN1cHBvcnRlZF9pc2FbaW5kZXhdID0g
ZVswXTsNCj4gPiArCQkJaW5kZXgrKzsNCj4gPiArCQl9DQo+IA0KPiBJJ2QganVzdCB1c2UgaWYg
KElTX0VOQUJMRUQoKSkgaGVyZSB0byBnZXQgZnVsbCBjb21waWxlciBjb3ZlcmFnZS4NCj4gQWxz
byBubyBuZWVkIGZvciB0aGUgaW5uZXIgYnJhY2VzLg0KPiANCg0KU3VyZS4gSSB3aWxsIGRvIHRo
YXQuDQoNCj4gPiArCWlmIChpc2FbMF0gIT0gJ1wwJykgew0KPiA+ICsJCS8qIEFkZCByZW1haW5n
aW5nIGlzYSBzdHJpbmdzICovDQo+ID4gKwkJZm9yIChlID0gaXNhOyAqZSAhPSAnXDAnOyArK2Up
IHsNCj4gPiArI2lmICFkZWZpbmVkKENPTkZJR19WSVJUVUFMSVpBVElPTikNCj4gPiArCQkJaWYg
KGVbMF0gIT0gJ2gnKQ0KPiA+ICsjZW5kaWYNCj4gPiArCQkJCXNlcV93cml0ZShmLCBlLCAxKTsN
Cj4gPiArCQl9DQo+ID4gKwl9DQo+IA0KPiBUaGlzIG9uZSBJIGRvbid0IGdldC4gIFdoeSBkbyB3
ZSB3YW50IHRvIGNoZWNrIENPTkZJR19WSVJUVUFMSVpBVElPTj8NCj4gDQoNCklmIENPTkZJR19W
SVJUVUFMSVpBVElPTiBpcyBub3QgZW5hYmxlZCwgaXQgc2hvdWxkbid0IHByaW50IHRoYXQNCmh5
cGVydmlzb3IgZXh0ZW5zaW9uICJoIiBpbiBpc2EgZXh0ZW5zaW9ucy4NCg0KVGhpcyBjYW4gYmUg
ZXh0ZW5kZWQgdG8gYW55IG90aGVyIGZ1dHVyZSBleHRlbnNpb25zIGFuZCByZWxhdGVkIGNvbmZp
Zy4NCg0KPiA+ICAJc2VxX3B1dHMoZiwgIlxuIik7dGhlciB5b3Ugd2FudCB0byBrbm93IGlmIGEg
c3BlY2lmaWMgZXh0ZW5zaW9uDQo+ID4gaXMgZW5hYmxlZA0KPiA+ICANCj4gPiAgCS8qDQo+ID4g
IAkgKiBJZiB3ZSB3ZXJlIGdpdmVuIGFuIHVuc3VwcG9ydGVkIElTQSBpbiB0aGUgZGV2aWNlIHRy
ZWUgdGhlbg0KPiA+IHByaW50DQo+ID4gIAkgKiBhIGJpdCBvZiBpbmZvIGRlc2NyaWJpbmcgd2hh
dCB3ZW50IHdyb25nLg0KPiA+ICAJICovDQo+ID4gLQlpZiAoaXNhWzBdICE9ICdcMCcpDQo+ID4g
LQkJcHJfaW5mbygidW5zdXBwb3J0ZWQgSVNBIFwiJXNcIiBpbiBkZXZpY2UgdHJlZVxuIiwNCj4g
PiBvcmlnX2lzYSk7DQo+ID4gKwlpZiAodW5zdXBwb3J0ZWRfaXNhWzBdKQ0KPiA+ICsJCXByX2lu
Zm8oInVuc3VwcG9ydGVkIElTQSBleHRlbnNpb25zIFwiJXNcIiBpbiBkZXZpY2UNCj4gPiB0cmVl
IGZvciBjcHUgWyVsZF1cbiIsDQo+ID4gKwkJCXVuc3VwcG9ydGVkX2lzYSwgY3B1aWQpOw0KPiAN
Cj4gQW5kIEknbSBub3QgZXZlbiBzdXJlIHdoeSB3ZSBjYXJlIGFib3V0IHVuc3VwcG9ydGVkDQo+
IGV4dGVuc2lvbnMuICBTb29uZXINCj4gb3IgbGF0ZSBhIGZldyB3aWxsIG9wIHVwIGFuZCB0aGV5
IHNob3VsZCBiZSBoYXJtbGVzcy4NCg0KVGhpcyBpcyBqdXN0IGFuIGluZm9ybWF0aW9uIHRvIHRo
ZSB1c2Vyc3BhY2UgdGhhdCBzb21lIG9mIHRoZSBtYW5kYXRvcnkNCklTQSBleHRlbnNpb25zICgi
bWFmZGNzdSIpIGFyZSBub3Qgc3VwcG9ydGVkIGluIGtlcm5lbCB3aGljaCBtYXkgbGVhZA0KdG8g
dW5kZXNpcmFibGUgcmVzdWx0cy4NCg0KDQpSZWdhcmRzLA0KQXRpc2gNCg0K
