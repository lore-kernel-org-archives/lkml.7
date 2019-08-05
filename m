Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00390C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 09:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B522C217D9
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 09:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="xyVjXtoW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbfHEJGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 05:06:52 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:40495 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfHEJGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 05:06:52 -0400
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: v7hr0Dt2vH4S4+DqcPHjcraJ98MxXVZKZ3ulbn7MazMCVV8fHj3NeOg5KWc1q7NIO22+WQe7uB
 ydY79WqCZnaY+UZChimLk1/oCCcqmOxLE7B/FDKNTIu5Bu3L8QGizb5IstzzMoehvEPBFSia4D
 m3SojuhAhwDZNw3FGC2z9s5D92vlQo+6FyFU1S5bLaVzzbUFhbPJEV5n7xd5TX7bEipZuoYhbW
 CCNMGtcX6tIGF6/Zf0DUbwnM4IxgxLRnmnnSHOEPXJfdYjynCQ8upOJmaNI7WjOj8HH5ipj9jZ
 ljo=
X-IronPort-AV: E=Sophos;i="5.64,349,1559545200"; 
   d="scan'208";a="43974237"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Aug 2019 02:06:50 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 5 Aug 2019 02:06:48 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Mon, 5 Aug 2019 02:06:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MqifNxVbGpaavMQ3ynSQvR7CxonTxfovkd/AA6RFDqJXEiTj3ru+KJp+ya3eROwqxaiXbDbdxfTm9CjMM6DV8BAhBXoO2py9dQJwwOvGkIQ48Vx0CNu8JPeicdYUofiax0Fwg5uWL1iN8LG844yevhGNcKk5D4T3P0YB6bbIOBVHN2KUmoLfuroWQn6Nc2v+EP+l1pFhTnsRlrK99OYeIyM20Ghgzi4pvJOQV/qkMhdmPSc211lqwvFqTUNf34xSUiAwkfvsSAHDgVrNuAcyj/vFaF92uAO4tguJQ3VIcJ/WGtput8/Pt4GywExjhHqR6tORErjME1DzZf0d26Y3FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hN4eUvA6Xgx/287dBQgzCkem0ePRA+Qshv09DAw1+I0=;
 b=hRhxCAPFP4V16sklCU/3PcNMfcX+gN0aV5BzEgXmGXMWgCl9x1RrH8N+kZEQ530OX8yR3QLu6CfOalrYwgh9UDyOZy84W9Xif/ZxsEWBnFDpxpP3Qsndjez4qESXXk5Z9EDtplWScfG9yYK7YH9bpuQscrvg2sdGLwAJLksd9AQgUXF02x6ZqhfUuS573vh1uAuHB8iapGswUF0NZCwaGD751bwX5Xk+dqy68phDoq57i9rY6raoVvmCaqewt+n4hpwZJZPVKE0lY+NIJvbHXWBYOAqvyhK93sgLG4QpW9om/RZuCj5EyPn98ggBfgPZ7kWkmB40QGE0El0mQ7tvzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hN4eUvA6Xgx/287dBQgzCkem0ePRA+Qshv09DAw1+I0=;
 b=xyVjXtoWlXhYR84YtMo2aJwPHlgKcqQFPHxYr2cmClhGbnfKAhd+YUpajHyYyZlwbmUzXiwB0wKSuSUD5JH1QepkHBJs1LcaQmd7Bm73cz5osutB8tV6a3Sw43OP0odB5A3W2yl+99ZUEMhH8104H/qIf/YOLy9XuIvkPsQN00c=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4333.namprd11.prod.outlook.com (10.255.90.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Mon, 5 Aug 2019 09:06:47 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 09:06:47 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>
CC:     <marek.vasut@gmail.com>, <bbrezillon@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <tmaimon77@gmail.com>
Subject: Re: [PATCH v4 1/3] mtd: spi-nor: always use bounce buffer for
 register read/writes
Thread-Topic: [PATCH v4 1/3] mtd: spi-nor: always use bounce buffer for
 register read/writes
Thread-Index: AQHVSIVVg9Qji1Cq1EmeYAs+Xr0s4KbsSSOA
Date:   Mon, 5 Aug 2019 09:06:47 +0000
Message-ID: <b125bf29-f1fd-6d33-4a7c-49cb94ef1488@microchip.com>
References: <20190801162229.28897-1-vigneshr@ti.com>
 <20190801162229.28897-2-vigneshr@ti.com>
In-Reply-To: <20190801162229.28897-2-vigneshr@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P18901CA0015.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:801::25) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 783263b4-c7e8-4408-275b-08d719843e51
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB4333;
x-ms-traffictypediagnostic: MN2PR11MB4333:
x-microsoft-antispam-prvs: <MN2PR11MB43332201DCD11E5E0BE65950F0DA0@MN2PR11MB4333.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(366004)(396003)(376002)(136003)(189003)(199004)(3846002)(6116002)(31696002)(14444005)(76176011)(31686004)(256004)(36756003)(26005)(81156014)(8936002)(305945005)(86362001)(81166006)(6486002)(478600001)(6512007)(25786009)(2906002)(54906003)(110136005)(71190400001)(71200400001)(316002)(6246003)(7736002)(52116002)(53936002)(486006)(14454004)(99286004)(476003)(66446008)(64756008)(66556008)(66476007)(102836004)(66946007)(8676002)(5660300002)(6436002)(229853002)(68736007)(53546011)(446003)(11346002)(6506007)(186003)(66066001)(4326008)(386003)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4333;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rTBqgC95nWQ2V3sun7lNR3vMCIQOkBMAGQ7nGDxWdx6nnjfTG/tuNE1eVknbxF1pbFQdTOEFxN28qWs8pZSmiYeAvodTBW5h3qEtgd/Mcb7YfICVIZuT4p7XEHFZWX05ff6K4prf+0op1rSqJtBllpaL1CWRLq+QjuN59L+XgI5bVslSO1tbx8KpHNupFkfuek6DrT0CVcppfB6F05gZs+1gl38Kw58KojtjLvT+Rol4iNQRpH79h4GL8kJmow2RE/HqJt3h+yoSJ4+er5XGMKH3y0vNqmIjtda9PBKKTOZV51UwTzlJ6KnLSsEPRtwCRBloo+cIPvRWfeHgQhwEq1GVpK9tsbRV8YM5f/zdTqgOEXg6G0KlHdNAuczFuj/01C9kPtTqnLxgr1ljTDCXbUJbisGWQmnzGWGTQ5WjlWA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C58F9801A8CDD1419774F4C13B3E1EDC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 783263b4-c7e8-4408-275b-08d719843e51
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 09:06:47.0896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tudor.ambarus@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4333
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA4LzAxLzIwMTkgMDc6MjIgUE0sIFZpZ25lc2ggUmFnaGF2ZW5kcmEgd3JvdGU6DQo+
IEV4dGVybmFsIEUtTWFpbA0KPiANCj4gDQo+IHNwaS1tZW0gbGF5ZXIgZXhwZWN0cyBhbGwgYnVm
ZmVycyBwYXNzZWQgdG8gaXQgdG8gYmUgRE1BJ2FibGUuIEJ1dA0KPiBzcGktbm9yIGxheWVyIG1v
c3RseSBhbGxvY2F0ZXMgYnVmZmVycyBvbiBzdGFjayBmb3IgcmVhZGluZy93cml0aW5nIHRvDQo+
IHJlZ2lzdGVycyBhbmQgdGhlcmVmb3JlIGFyZSBub3QgRE1BJ2FibGUuIEludHJvZHVjZSBib3Vu
Y2UgYnVmZmVyIHRvIGJlDQo+IHVzZWQgdG8gcmVhZC93cml0ZSB0byByZWdpc3RlcnMuIFRoaXMg
ZW5zdXJlcyB0aGF0IGJ1ZmZlciBwYXNzZWQgdG8NCj4gc3BpLW1lbSBsYXllciBkdXJpbmcgcmVn
aXN0ZXIgcmVhZC93cml0ZXMgaXMgRE1BJ2FibGUuIFdpdGggdGhpcyBjaGFuZ2UNCj4gbm9yLT5j
bWQtYnVmIGlzIG5vIGxvbmdlciB1c2VkLCBzbyBkcm9wIGl0Lg0KPiANCj4gUmV2aWV3ZWQtYnk6
IEJvcmlzIEJyZXppbGxvbiA8Ym9yaXMuYnJlemlsbG9uQGNvbGxhYm9yYS5jb20+DQo+IFNpZ25l
ZC1vZmYtYnk6IFZpZ25lc2ggUmFnaGF2ZW5kcmEgPHZpZ25lc2hyQHRpLmNvbT4NCj4gLS0tDQo+
IA0KPiB2NDoNCj4gQXZvaWQgbWVtY3B5IGR1cmluZyBSRUFESUQNCj4gDQo+IHYzOiBuZXcgcGF0
Y2gNCj4gDQo+ICBkcml2ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYyB8IDcwICsrKysrKysrKysr
KysrKysrKysrLS0tLS0tLS0tLS0tLS0tDQo+ICBpbmNsdWRlL2xpbnV4L210ZC9zcGktbm9yLmgg
ICB8ICA3ICsrKy0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgNDUgaW5zZXJ0aW9ucygrKSwgMzIgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9y
LmMgYi9kcml2ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYw0KPiBpbmRleCAwM2NjNzg4NTExZDUu
LmUwMjM3NmUxMTI3YiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9y
LmMNCj4gKysrIGIvZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9yLmMNCg0KY3V0DQoNCj4gIC8q
Kg0KPiBAQCAtMTQwNCw5ICsxNDAxLDExIEBAIHN0YXRpYyBpbnQgd3JpdGVfc3JfY3Ioc3RydWN0
IHNwaV9ub3IgKm5vciwgdTggKnNyX2NyKQ0KPiAgew0KPiAgCWludCByZXQ7DQo+ICANCj4gKwlt
ZW1jcHkobm9yLT5ib3VuY2VidWYsIHNyX2NyLCAyKTsNCg0KSSdtIHRoaW5raW5nIG91dCBsb3Vk
LiBUaGlzIGNhbiBiZSBhdm9pZGVkIGJ5IGZvcmNpbmcgYWxsIHRoZSBjYWxsZXJzIHRvIHVzZQ0K
bm9yLT5ib3VuY2VidWYuIFRoYXQgd291bGQgcmVzdWx0IGluIGE6DQoNCnN0YXRpYyBpbnQgd3Jp
dGVfc3Ioc3RydWN0IHNwaV9ub3IgKm5vciwgc2l6ZV90IGxlbikNCg0Kd3JpdGVfc3JfY3IoKSBj
YW4gYmUgcmVtb3ZlZC4gTWVtY29weWluZyAyIGJ5dGVzIGlzIGEgc21hbGwgcHJpY2UgdG8gcGF5
LCB3ZSBjYW4NCmtlZXAgdGhpbmdzIGFzIHRoZXkgYXJlLCB0byBub3QgYmUgdG9vIGludmFzaXZl
LiBCdXQgaWYgeW91IHRoaW5rIHRoYXQgdGhpcyBpZGVhDQppcyB3b3J0aCBpdCwgdGVsbC4NCg0K
PiArDQo+ICAJd3JpdGVfZW5hYmxlKG5vcik7DQo+ICANCj4gLQlyZXQgPSBub3ItPndyaXRlX3Jl
Zyhub3IsIFNQSU5PUl9PUF9XUlNSLCBzcl9jciwgMik7DQo+ICsJcmV0ID0gbm9yLT53cml0ZV9y
ZWcobm9yLCBTUElOT1JfT1BfV1JTUiwgbm9yLT5ib3VuY2VidWYsIDIpOw0KPiAgCWlmIChyZXQg
PCAwKSB7DQo+ICAJCWRldl9lcnIobm9yLT5kZXYsDQo+ICAJCQkiZXJyb3Igd2hpbGUgd3JpdGlu
ZyBjb25maWd1cmF0aW9uIHJlZ2lzdGVyXG4iKTsNCg0KY3V0DQoNCj4gQEAgLTIxNzcsOSArMjE3
NiwxMCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGZsYXNoX2luZm8gc3BpX25vcl9pZHNbXSA9IHsN
Cj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZmxhc2hfaW5mbyAqc3BpX25vcl9yZWFkX2lkKHN0cnVj
dCBzcGlfbm9yICpub3IpDQo+ICB7DQo+ICAJaW50CQkJdG1wOw0KPiAtCXU4CQkJaWRbU1BJX05P
Ul9NQVhfSURfTEVOXTsNCj4gKwl1OAkJCSppZDsNCj4gIAljb25zdCBzdHJ1Y3QgZmxhc2hfaW5m
bwkqaW5mbzsNCj4gIA0KPiArCWlkID0gbm9yLT5ib3VuY2VidWY7DQoNCm5pdDogZG8gaW5pdCBh
dCBkZWNsYXJhdGlvbi4NCg0KQWxzbywgeW91IG1pc3NlZCBhIHBsYWNlIGluIHdoaWNoIHlvdSBj
YW4gdXNlIHRoZSBib3VuY2VidWYsIHNlYXJjaCBieSAicmVhZF9yZWcoIjoNCnJldCA9IG5vci0+
cmVhZF9yZWcobm9yLCBTUElOT1JfT1BfWFJEU1IsICZ2YWwsIDEpOw0KDQpDaGVlcnMsDQp0YQ0K
