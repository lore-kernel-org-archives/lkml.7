Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBE8C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2C3621773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="fJTskITL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733118AbfDXVZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 17:25:56 -0400
Received: from mail-eopbgr130101.outbound.protection.outlook.com ([40.107.13.101]:2977
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731185AbfDXVZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 17:25:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kg96cHC8w/9jRHhWfxD1fdBiJk/KqI4BtC5ZzD62cuU=;
 b=fJTskITLwP/4XB561gp8/ZGMwDr8bW/FNDUV/reGe3oIeQalim+NMQqCXzWJqBxttd5xT9sZTtTCKv/JoMXlAFyM9gg9UaS1grMFYYj0UIop4aziX0oLA3MQ8sYSOF9MSDm9O+ktVYbVc4r6u+sZJz42eFjf5l6UB4cDKhPNU/g=
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com (20.178.12.74) by
 VI1PR02MB3901.eurprd02.prod.outlook.com (20.177.58.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Wed, 24 Apr 2019 21:25:50 +0000
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::2891:d814:7bff:fbc7]) by VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::2891:d814:7bff:fbc7%4]) with mapi id 15.20.1813.017; Wed, 24 Apr 2019
 21:25:50 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Peter Korsgaard <peter.korsgaard@barco.com>
CC:     Serge Semin <Sergey.Semin@t-platforms.ru>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] i2c-mux-gpio: Return an error if no config data found
Thread-Topic: [PATCH 2/5] i2c-mux-gpio: Return an error if no config data
 found
Thread-Index: AQHU+poQ7vY8I41EDUarM1AN7cQUWqZL01oA
Date:   Wed, 24 Apr 2019 21:25:50 +0000
Message-ID: <4e7c9184-03a2-f1d3-2ed0-a761d76b9654@axentia.se>
References: <20190424123414.25311-1-fancer.lancer@gmail.com>
 <20190424123414.25311-3-fancer.lancer@gmail.com>
In-Reply-To: <20190424123414.25311-3-fancer.lancer@gmail.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-originating-ip: [213.112.138.100]
x-clientproxiedby: HE1PR0701CA0066.eurprd07.prod.outlook.com
 (2603:10a6:3:9e::34) To VI1PR02MB4542.eurprd02.prod.outlook.com
 (2603:10a6:803:b1::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8298e85c-80ca-4f37-d314-08d6c8fb6c75
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:VI1PR02MB3901;
x-ms-traffictypediagnostic: VI1PR02MB3901:
x-microsoft-antispam-prvs: <VI1PR02MB390107D3AD0DA82B266C2AB1BC3C0@VI1PR02MB3901.eurprd02.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(39830400003)(366004)(376002)(199004)(189003)(37524003)(25786009)(68736007)(52116002)(256004)(14444005)(486006)(76176011)(8936002)(110136005)(81156014)(6246003)(81166006)(54906003)(74482002)(64126003)(14454004)(4326008)(8676002)(316002)(6512007)(99286004)(508600001)(5660300002)(66556008)(66446008)(26005)(64756008)(86362001)(6486002)(3846002)(102836004)(2906002)(6116002)(58126008)(66946007)(66476007)(65826007)(36756003)(6436002)(305945005)(31696002)(186003)(73956011)(31686004)(11346002)(476003)(97736004)(2616005)(65956001)(71190400001)(6506007)(65806001)(71200400001)(446003)(53546011)(7736002)(386003)(66066001)(229853002)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB3901;H:VI1PR02MB4542.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DpIWclPdPFmI2tWZAMnC4n9w68wE19iTPiVmewbEbJg4T0+/qBmXDR78klC05DFPyHte4RCJXG8MrCGBOWrC/zXv0GgfUT33kQMRza1XjPJT2VizNOUnaioxfdk7mTTj9vi2TavTQlRCiJJdJkVaRmAjTFe1IBp4Jl91W8UyD5xh7Y9jEb2hKwP1dAMGRUh1p07P0mrl6CCO/HZUeN/qZMcM/m+S3Q4qdzI/Q6EJhF1ST8OW3s+Mz+GxLwjiu+G00xj9AY3xTIeE7qP+dkrZPSpS2XJSOPkrrfQ0QO54ucp4o77r43ZaQqLjRDRRpvixNX7+n0smRQDxh8CQfR9vC72iCh3kz/o/RiEKl2izydPIDIKN4rgfCsV75AhGN67nGyJSsbDYcRX3p7jC4XZkWMG46niSGjra6VBYJm2ihRQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC598F75ABF4E246B70E14801BDFB8F6@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 8298e85c-80ca-4f37-d314-08d6c8fb6c75
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 21:25:50.4493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB3901
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0wNC0yNCAxNDozNCwgU2VyZ2UgU2VtaW4gd3JvdGU6DQo+IEl0J3MgcG9pbnRsZXNz
IGFuZCBtaWdodCBiZSBldmVuIGVycm9ycyBwcm9uZSB0byBwcm9jZWVkIHdpdGggZnVydGhlcg0K
PiBpbml0aWFsaXphdGlvbiBpZiBuZWl0aGVyIG9mLSBubyBwbGF0Zm9ybS1iYXNlZCBzZXR0aW5n
cyB3ZXJlIGRpc2NvdmVyZWQuDQo+IEp1c3QgcmV0dXJuIGFuIGVycm9yIGluIHRoaXMgY2FzZS4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNlcmdlIFNlbWluIDxmYW5jZXIubGFuY2VyQGdtYWlsLmNv
bT4NCj4gLS0tDQo+ICBkcml2ZXJzL2kyYy9tdXhlcy9pMmMtbXV4LWdwaW8uYyB8IDEyICsrKysr
KystLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMo
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2kyYy9tdXhlcy9pMmMtbXV4LWdwaW8uYyBi
L2RyaXZlcnMvaTJjL211eGVzL2kyYy1tdXgtZ3Bpby5jDQo+IGluZGV4IDI0Y2Y2ZWMwMmU3NS4u
YTE0ZmUxMzJiMGMzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2kyYy9tdXhlcy9pMmMtbXV4LWdw
aW8uYw0KPiArKysgYi9kcml2ZXJzL2kyYy9tdXhlcy9pMmMtbXV4LWdwaW8uYw0KPiBAQCAtMTMy
LDcgKzEzMiw3IEBAIHN0YXRpYyBpbnQgaTJjX211eF9ncGlvX3Byb2JlX2R0KHN0cnVjdCBncGlv
bXV4ICptdXgsDQo+ICBzdGF0aWMgaW50IGkyY19tdXhfZ3Bpb19wcm9iZV9kdChzdHJ1Y3QgZ3Bp
b211eCAqbXV4LA0KPiAgCQkJCQlzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgew0K
PiAtCXJldHVybiAwOw0KPiArCXJldHVybiAtRUlOVkFMOw0KPiAgfQ0KPiAgI2VuZGlmDQo+ICAN
Cj4gQEAgLTE0Miw2ICsxNDIsOSBAQCBzdGF0aWMgaW50IGkyY19tdXhfZ3Bpb19wcm9iZV9wbGF0
KHN0cnVjdCBncGlvbXV4ICptdXgsDQo+ICAJc3RydWN0IGkyY19tdXhfZ3Bpb19wbGF0Zm9ybV9k
YXRhICpkYXRhID0gZGV2X2dldF9wbGF0ZGF0YSgmcGRldi0+ZGV2KTsNCj4gIAlzdHJ1Y3QgZ3Bp
b19jaGlwICpncGlvOw0KPiAgDQo+ICsJaWYgKCFkYXRhKQ0KPiArCQlyZXR1cm4gLUVJTlZBTDsN
Cj4gKw0KPiAgCS8qDQo+ICAJICogSWYgYSBHUElPIGNoaXAgbmFtZSBpcyBwcm92aWRlZCwgdGhl
IEdQSU8gcGluIG51bWJlcnMgcHJvdmlkZWQgYXJlDQo+ICAJICogcmVsYXRpdmUgdG8gaXRzIGJh
c2UgR1BJTyBudW1iZXIuIE90aGVyd2lzZSB0aGV5IGFyZSBhYnNvbHV0ZS4NCj4gQEAgLTE3NSwx
MSArMTc4LDEwIEBAIHN0YXRpYyBpbnQgaTJjX211eF9ncGlvX3Byb2JlKHN0cnVjdCBwbGF0Zm9y
bV9kZXZpY2UgKnBkZXYpDQo+ICAJaWYgKCFtdXgpDQo+ICAJCXJldHVybiAtRU5PTUVNOw0KPiAg
DQo+IC0JaWYgKCFkZXZfZ2V0X3BsYXRkYXRhKCZwZGV2LT5kZXYpKQ0KPiArCXJldCA9IGkyY19t
dXhfZ3Bpb19wcm9iZV9wbGF0KG11eCwgcGRldik7DQo+ICsJaWYgKHJldCkNCj4gIAkJcmV0ID0g
aTJjX211eF9ncGlvX3Byb2JlX2R0KG11eCwgcGRldik7DQo+IC0JZWxzZQ0KPiAtCQlyZXQgPSBp
MmNfbXV4X2dwaW9fcHJvYmVfcGxhdChtdXgsIHBkZXYpOw0KPiAtCWlmIChyZXQgPCAwKQ0KPiAr
CWlmIChyZXQpDQo+ICAJCXJldHVybiByZXQ7DQoNCkkgbm90aWNlIHRoYXQgYWZ0ZXIgdGhpcyBw
YXRjaCwgYWxsIHByb2JlIGZhaWx1cmVzIGZyb20gbm9uLWR0IGNvbmZpZ3MNCndpbGwgcmV0dXJu
IC1FSU5WQUwgZnJvbSB0aGUgZHVtbXkgaTJjX211eF9ncGlvX3Byb2JlX2R0IHRoYXQgZ2V0cw0K
Y2FsbGVkIG9uIGkyY19tdXhfZ3Bpb19wcm9iZV9wbGF0IGZhaWx1cmUuDQoNClNvLCBhbnkgLUVQ
Uk9CRV9ERUZFUiBpcyBub3cgbG9zdC4gVGhhdCBwcm9iYWJseSBkb2Vzbid0IGZseS4NCg0KQ2hl
ZXJzLA0KUGV0ZXINCg0KPiAgDQo+ICAJcGFyZW50ID0gaTJjX2dldF9hZGFwdGVyKG11eC0+ZGF0
YS5wYXJlbnQpOw0KPiANCg0K
