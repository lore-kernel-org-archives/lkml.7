Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51607C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 14:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AC1F2171F
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 14:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=SILICOMLTD.onmicrosoft.com header.i=@SILICOMLTD.onmicrosoft.com header.b="M/GbkeCD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406840AbfHIOOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 10:14:32 -0400
Received: from mail-eopbgr130113.outbound.protection.outlook.com ([40.107.13.113]:21390
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726140AbfHIOOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 10:14:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Memk4WOpMO0y7kkjfl6lPcS1+SJ2sY9ACE5nyD1ojs5WtT9RXeP4odlaEUDAEdsxF1el6sNjAl+I53GFZTdDvv+bFaoL1vMkF3y/6e6ES8YelFtqRguKVyndRI9ZlHon9MtwfHRRfIz9lJTf2GGSpq8uBpe2Ipua7OyIkS5thgxNAIxgoC7fwxiiQuZqUiJSRMRWl24adRmOt42rS/CF+qJxj4oLhYvk9kaDcP/aSLm/S+98PndyYA9loal43SMZLfPfQG7VVoBoGaiBXm4VfPvJxcT1xdvUD6XpvfHX8OBkAQU3FUn3KTGfl6dF/qNb6wNmNeiClewmUXC5zWDfug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3rr6x9WPezSBbYs6tDg4+QVie557lCQ/q2W5fjClsH0=;
 b=dUGabZ92ZZwqtjj1asFEznBfi0lujt8Qzx0irdgP65Z3UjqE88pFXdiPLNF6y34S1yUh565/CmzpeRUm+LEzO+k/mXoQgWBfX5ux6RrN3++9ieN056JiYVH5cyVrjbXqFdC0OqZ+Pve3DJHDtwGO7iQMDRUukU85JxRCbbSejO3NfBEIYmITvlC9D3xzauheDkegqY0RIJnDP0/JJ3ZszIPveqoplaMRzYek0MI5crYT0QiqoK2RzsTXMTtQVKI698gDHTLK+rTwqtZ+9dJeNsDxgQai/jWiyA86GoS9nezRH5lq5JdyJVFW3h8DBoKoXIX/IDyNnH9b8IFNh8Up9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silicom-usa.com; dmarc=pass action=none
 header.from=silicom-usa.com; dkim=pass header.d=silicom-usa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SILICOMLTD.onmicrosoft.com; s=selector2-SILICOMLTD-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3rr6x9WPezSBbYs6tDg4+QVie557lCQ/q2W5fjClsH0=;
 b=M/GbkeCD1axc+2GNrEXUs2yKdTeWqj9ekWoUle3AIc2yUAGdMKqfA3TWZchyJkRhOUJpw/+JecqOGTkGSqannMpLWNzy6DLWR32vbafj2CdByr6O4Vm8gWzIArBb7RVVeejq0cSv8HEHNk9jvCn7/B9bXtF/x2cNBOUprrbXCzg=
Received: from VI1PR0402MB2717.eurprd04.prod.outlook.com (10.175.22.139) by
 VI1PR0402MB3854.eurprd04.prod.outlook.com (52.134.16.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.13; Fri, 9 Aug 2019 14:13:46 +0000
Received: from VI1PR0402MB2717.eurprd04.prod.outlook.com
 ([fe80::eca9:e1f:eca7:8439]) by VI1PR0402MB2717.eurprd04.prod.outlook.com
 ([fe80::eca9:e1f:eca7:8439%9]) with mapi id 15.20.2157.020; Fri, 9 Aug 2019
 14:13:46 +0000
From:   Stephen Douthit <stephend@silicom-usa.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ata: ahci: Lookup PCS register offset based on PCI device
 ID
Thread-Topic: [PATCH] ata: ahci: Lookup PCS register offset based on PCI
 device ID
Thread-Index: AQHVTidIVfq9W1HbR0i2bNtry39JoabyLaKAgACvWYA=
Date:   Fri, 9 Aug 2019 14:13:46 +0000
Message-ID: <9f7821b3-5bc2-bda1-eae6-4d7213677c9b@silicom-usa.com>
References: <20190808202415.25166-1-stephend@silicom-usa.com>
 <20be9bbb-5f09-c048-d98d-7398657c0c8f@kernel.dk>
In-Reply-To: <20be9bbb-5f09-c048-d98d-7398657c0c8f@kernel.dk>
Reply-To: Stephen Douthit <stephend@silicom-usa.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN8PR07CA0034.namprd07.prod.outlook.com
 (2603:10b6:408:ac::47) To VI1PR0402MB2717.eurprd04.prod.outlook.com
 (2603:10a6:800:b4::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=stephend@silicom-usa.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [96.82.2.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1013ad46-43c6-4a65-5eeb-08d71cd3cabe
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0402MB3854;
x-ms-traffictypediagnostic: VI1PR0402MB3854:
x-microsoft-antispam-prvs: <VI1PR0402MB3854AE3DE073D86DC7B1C78C94D60@VI1PR0402MB3854.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 01244308DF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39840400004)(376002)(346002)(136003)(396003)(366004)(189003)(199004)(53936002)(71200400001)(71190400001)(3450700001)(66446008)(64756008)(66556008)(66476007)(66946007)(6486002)(2906002)(6916009)(31686004)(43066004)(6512007)(3846002)(6116002)(53546011)(6506007)(386003)(81166006)(478600001)(81156014)(4326008)(186003)(6436002)(7736002)(305945005)(6246003)(66066001)(5660300002)(8936002)(52116002)(36756003)(76176011)(99286004)(25786009)(102836004)(26005)(14454004)(8676002)(2616005)(446003)(11346002)(31696002)(476003)(86362001)(229853002)(256004)(486006)(14444005)(54906003)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0402MB3854;H:VI1PR0402MB2717.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: silicom-usa.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9FsDvVGPvylrw3l7PLuAzhAx8QJUxTxwWFEMT4axQ8w6JwZupyOYkjLYWLnNmZIYM+lqEPjmRWQdX//xivBn94FkqbfHo8gRW2F58EZNhezpU4fzFvlmMQJ6aa64KMIy2Z9StnbTcH2Z4rpq1Ud+MOF61GAiln3HrkXuhoG94DdnRy2t7Fxe8ILZ+joSxqnOW6//bbllthvGQSI13fGm45Oe5KV0v6dmTEeAVuvHtbiV12SBRfF38W9av3G7tVvz51jTiWLBlciLKV4Zn3/FKSKIWmoPJZM9gtoU3qpE07jjcjXlGEwbBdBwehjlEG1ntMsAWD6gZZJ71jINBIc7JflqmLmZefHR38tc1hk2sELVb8uTP+79/DDWbTIEfULDoMOaMCdMY+9eO7a1RmwLWTE8/6m17dpnOxbEQU7fwXo=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <72C75ED6BFA8F747AC0E1C7EF1DAD3C0@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: silicom-usa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1013ad46-43c6-4a65-5eeb-08d71cd3cabe
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2019 14:13:46.3844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c9e326d8-ce47-4930-8612-cc99d3c87ad1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7niXriMadjxFwYcDXLKQBju1WXruw+J8te3/cUPkJODhm+AQUxAk6gbxhQmyTyUbfVPoGxhG8V8zCjf/8lc5UyWd+U4TmI3d6745MLS8acA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3854
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC84LzE5IDExOjQ2IFBNLCBKZW5zIEF4Ym9lIHdyb3RlOg0KPiBPbiA4LzgvMTkgMToyNCBQ
TSwgU3RlcGhlbiBEb3V0aGl0IHdyb3RlOg0KPj4gSW50ZWwgbW92ZWQgdGhlIFBDUyByZWdpc3Rl
ciBmcm9tIDB4OTIgdG8gMHg5NCBvbiBEZW52ZXJ0b24gZm9yIHNvbWUNCj4+IHJlYXNvbiwgc28g
bm93IHdlIGdldCB0byBjaGVjayB0aGUgZGV2aWNlIElEIGJlZm9yZSBwb2tpbmcgaXQgb24gcmVz
ZXQuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogU3RlcGhlbiBEb3V0aGl0IDxzdGVwaGVuZEBzaWxp
Y29tLXVzYS5jb20+DQo+PiAtLS0NCj4+ICAgIGRyaXZlcnMvYXRhL2FoY2kuYyB8IDQyICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLQ0KPj4gICAgMSBmaWxlIGNoYW5n
ZWQsIDM5IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvYXRhL2FoY2kuYyBiL2RyaXZlcnMvYXRhL2FoY2kuYw0KPj4gaW5kZXggZjc2NTJi
YWE2MzM3Li43MDkwYzc3NTRmYzIgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2F0YS9haGNpLmMN
Cj4+ICsrKyBiL2RyaXZlcnMvYXRhL2FoY2kuYw0KPj4gQEAgLTYyMyw2ICs2MjMsNDEgQEAgc3Rh
dGljIHZvaWQgYWhjaV9wY2lfc2F2ZV9pbml0aWFsX2NvbmZpZyhzdHJ1Y3QgcGNpX2RldiAqcGRl
diwNCj4+ICAgIAlhaGNpX3NhdmVfaW5pdGlhbF9jb25maWcoJnBkZXYtPmRldiwgaHByaXYpOw0K
Pj4gICAgfQ0KPj4gICAgDQo+PiArLyoNCj4+ICsgKiBJbnRlbCBtb3ZlZCB0aGUgUENTIHJlZ2lz
dGVyIG9uIHRoZSBEZW52ZXJ0b24gQUhDSSBjb250cm9sbGVyLCBzZWUgd2hpY2gNCj4+ICsgKiBv
ZmZzZXQgdGhpcyBjb250cm9sbGVyIGlzIHVzaW5nDQo+PiArICovDQo+PiArc3RhdGljIGludCBh
aGNpX3Bjc19vZmZzZXQoc3RydWN0IGF0YV9ob3N0ICpob3N0KQ0KPj4gK3sNCj4+ICsJc3RydWN0
IHBjaV9kZXYgKnBkZXYgPSB0b19wY2lfZGV2KGhvc3QtPmRldik7DQo+PiArDQo+PiArCXN3aXRj
aCAocGRldi0+ZGV2aWNlKSB7DQo+PiArCWNhc2UgMHgxOWIwOg0KPj4gKwljYXNlIDB4MTliMToN
Cj4+ICsJY2FzZSAweDE5YjI6DQo+PiArCWNhc2UgMHgxOWIzOg0KPj4gKwljYXNlIDB4MTliNDoN
Cj4+ICsJY2FzZSAweDE5YjU6DQo+PiArCWNhc2UgMHgxOWI2Og0KPj4gKwljYXNlIDB4MTliNzoN
Cj4+ICsJY2FzZSAweDE5YkU6DQo+PiArCWNhc2UgMHgxOWJGOg0KPj4gKwljYXNlIDB4MTljMDoN
Cj4+ICsJY2FzZSAweDE5YzE6DQo+PiArCWNhc2UgMHgxOWMyOg0KPj4gKwljYXNlIDB4MTljMzoN
Cj4+ICsJY2FzZSAweDE5YzQ6DQo+PiArCWNhc2UgMHgxOWM1Og0KPj4gKwljYXNlIDB4MTljNjoN
Cj4+ICsJY2FzZSAweDE5Yzc6DQo+PiArCWNhc2UgMHgxOWNFOg0KPj4gKwljYXNlIDB4MTljRjoN
Cj4gDQo+IEFueSBwYXJ0aWN1bGFyIHJlYXNvbiB3aHkgeW91IG1hZGUgc29tZSBvZiBoZXggYWxw
aGFzIHVwcGVyIGNhc2U/DQoNCk5vIGdvb2QgcmVhc29uLiAgVGhlc2Ugd2VyZSBjb3BpZWQgZnJv
bSB0aGUgYWhjaV9wY2lfdGJsIGFib3ZlIGFuZCBJDQpkaWRuJ3Qgbm90aWNlIHRoZSBtaXhlZCBj
YXNlLg0KDQpJJ2xsIHJlc2VuZC4NCg0KV291bGQgeW91IGxpa2UgYSBzZXBhcmF0ZSBjbGVhbnVw
IHBhdGNoIGZvciBhaGNpX3BjaV90YmwgYXMgd2VsbD8NCg0K
