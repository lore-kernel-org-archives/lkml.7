Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933CCC04E87
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 09:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C5DD20881
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 09:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kVWsmQN8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbfEOJ5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 05:57:17 -0400
Received: from mail-eopbgr130045.outbound.protection.outlook.com ([40.107.13.45]:16610
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725977AbfEOJ5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 05:57:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dppGzgebjPo1AJQyzMCQOUh3IaiJM6Z+MV7oriSNvSg=;
 b=kVWsmQN8ixeLh67ux0jKYP2oDruZQBMOlZfELJo4eJl2j5to3h8C40DZHZrWzhm2sErF1ZoasNsWEt3ATZhf4Q0xf43th2Inxj68Av6m95sJrDsYesEY5vOezkBHvnxf0JPL+yCWrSEMMwzOeqBzYkMSrqJmZs0jXFS3abhyDkk=
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com (20.177.50.159) by
 VI1PR04MB5391.eurprd04.prod.outlook.com (20.178.120.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Wed, 15 May 2019 09:57:12 +0000
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com
 ([fe80::8942:6d16:631:413]) by VI1PR04MB5134.eurprd04.prod.outlook.com
 ([fe80::8942:6d16:631:413%4]) with mapi id 15.20.1878.024; Wed, 15 May 2019
 09:57:12 +0000
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "marex@denx.de" <marex@denx.de>, Leo Li <leoyang.li@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
Subject: Re: [RFC PATCH v2 1/3] USB: use genalloc for USB HCs with local
 memory
Thread-Topic: [RFC PATCH v2 1/3] USB: use genalloc for USB HCs with local
 memory
Thread-Index: AQHVCmKqi2RLbkcB50+PlEfeksPwEqZqsaYAgAFCsgA=
Date:   Wed, 15 May 2019 09:57:12 +0000
Message-ID: <f4fc0151-5e49-77fd-7736-37cdfe57c268@nxp.com>
References: <20190514143807.7745-1-laurentiu.tudor@nxp.com>
 <20190514143807.7745-2-laurentiu.tudor@nxp.com>
 <20190514144210.GA14625@lst.de>
In-Reply-To: <20190514144210.GA14625@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 859a986c-3961-4da0-91e6-08d6d91bb3ed
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5391;
x-ms-traffictypediagnostic: VI1PR04MB5391:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR04MB5391B5C45057BEA12A932AF8EC090@VI1PR04MB5391.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0038DE95A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(136003)(376002)(396003)(39860400002)(189003)(199004)(54094003)(81166006)(53546011)(81156014)(8936002)(8676002)(6506007)(31686004)(54906003)(316002)(76176011)(305945005)(7736002)(3846002)(6916009)(102836004)(2906002)(99286004)(6116002)(229853002)(256004)(6436002)(6486002)(6512007)(66476007)(64756008)(66556008)(5660300002)(44832011)(71190400001)(66066001)(68736007)(71200400001)(26005)(36756003)(66446008)(186003)(4326008)(53936002)(86362001)(6246003)(31696002)(476003)(2616005)(478600001)(14454004)(25786009)(966005)(11346002)(486006)(66946007)(446003)(91956017)(76116006)(73956011)(6306002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5391;H:VI1PR04MB5134.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yW0dQZRgz7ZYJQNMRpu6QWAVfaNPn96jxaeYrgkPKE5XLCY1LVm5SCajuAHBEKq8Yf4iT6SoRmQOuA0aW/i40uA2b0fLLd7WYWloTwmOTUQRMALOSFIzyQqjnvI4WjCfPz1RtA+GEFUxqI4VtFiKUPB8P1QOxC5z+OSDuhYdcjYaD+YXKcsdzUfBtIxvS1oZogpfOE6P7AYWgT5J4LoD8xnT8EeX+KXqPgllogNxcpGj8LyFKZi5kNtJSh1OwMQ5EIFIXUFKRw5H42w+vBcpNYEb4W22KJ1Lu28P+AAlqtq97jsyyZ5BDAnG0RDNQhzLsGwkU2NgyNOLCOwHAM498bap0xk1HHKYcmUSlJ3ptocVtu4FkZ87T98KFlbxijT+TsRKtNt0OTx7FjOOlmfnoRU/1g6cI+SSil/KrlureNY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2C2AEA4CE488064C8DE45118DD24BB87@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 859a986c-3961-4da0-91e6-08d6d91bb3ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2019 09:57:12.3988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5391
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTQuMDUuMjAxOSAxNzo0MiwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+PiBAQCAtMTM2
LDYgKzEzNywxMCBAQCB2b2lkICpoY2RfYnVmZmVyX2FsbG9jKA0KPj4gICAJCWlmIChzaXplIDw9
IHBvb2xfbWF4W2ldKQ0KPj4gICAJCQlyZXR1cm4gZG1hX3Bvb2xfYWxsb2MoaGNkLT5wb29sW2ld
LCBtZW1fZmxhZ3MsIGRtYSk7DQo+PiAgIAl9DQo+PiArDQo+PiArCWlmIChoY2QtPmRyaXZlci0+
ZmxhZ3MgJiBIQ0RfTE9DQUxfTUVNKQ0KPj4gKwkJcmV0dXJuIGdlbl9wb29sX2RtYV9hbGxvYyho
Y2QtPmxvY2FsbWVtX3Bvb2wsIHNpemUsIGRtYSk7DQo+IA0KPiBJIHRoaW5rIHRoaXMgY2hlY2sg
bmVlZHMgdG8gYmUgYmVmb3JlIHRoZSBhYm92ZSBjb2RlIHRvIHVzZSB0aGUgZG1hDQo+IHBvb2xz
LCBhcyB3ZSBzaG91bGQgYWx3YXlzIHVzZSB0aGUgSENEIGxvY2FsIG1lbW9yeS4gIFByb2JhYmx5
IGFsbCB0aGUNCj4gd2F5IHVwIGp1c3QgYmVsb3cgdGhlIHNpemUgPT0gMCBjaGVjaywgdGhhdCB3
YXkgd2UgY2FuIGFsc28gcmVtb3ZlIHRoZQ0KPiBvdGhlciBIQ0RfTE9DQUxfTUVNIGNoZWNrLg0K
DQpBbHJpZ2h0Lg0KDQo+PiBAQCAtMTY1LDUgKzE3MCwxMCBAQCB2b2lkIGhjZF9idWZmZXJfZnJl
ZSgNCj4+ICAgCQkJcmV0dXJuOw0KPj4gICAJCX0NCj4+ICAgCX0NCj4+IC0JZG1hX2ZyZWVfY29o
ZXJlbnQoaGNkLT5zZWxmLnN5c2Rldiwgc2l6ZSwgYWRkciwgZG1hKTsNCj4+ICsNCj4+ICsJaWYg
KGhjZC0+ZHJpdmVyLT5mbGFncyAmIEhDRF9MT0NBTF9NRU0pDQo+PiArCQlnZW5fcG9vbF9mcmVl
KGhjZC0+bG9jYWxtZW1fcG9vbCwgKHVuc2lnbmVkIGxvbmcpYWRkciwNCj4+ICsJCQkgICAgICBz
aXplKTsNCj4+ICsJZWxzZQ0KPj4gKwkJZG1hX2ZyZWVfY29oZXJlbnQoaGNkLT5zZWxmLnN5c2Rl
diwgc2l6ZSwgYWRkciwgZG1hKTsNCj4gDQo+IFNhbWUgaGVyZS4NCg0KT2suDQoNCj4+IEBAIC01
MDUsOCArNTA2LDE1IEBAIHN0YXRpYyBpbnQgb2hjaV9pbml0IChzdHJ1Y3Qgb2hjaV9oY2QgKm9o
Y2kpDQo+PiAgIAl0aW1lcl9zZXR1cCgmb2hjaS0+aW9fd2F0Y2hkb2csIGlvX3dhdGNoZG9nX2Z1
bmMsIDApOw0KPj4gICAJb2hjaS0+cHJldl9mcmFtZV9ubyA9IElPX1dBVENIRE9HX09GRjsNCj4+
ICAgDQo+PiAtCW9oY2ktPmhjY2EgPSBkbWFfYWxsb2NfY29oZXJlbnQgKGhjZC0+c2VsZi5jb250
cm9sbGVyLA0KPj4gLQkJCXNpemVvZigqb2hjaS0+aGNjYSksICZvaGNpLT5oY2NhX2RtYSwgR0ZQ
X0tFUk5FTCk7DQo+PiArCWlmIChoY2QtPmRyaXZlci0+ZmxhZ3MgJiBIQ0RfTE9DQUxfTUVNKQ0K
Pj4gKwkJb2hjaS0+aGNjYSA9IGdlbl9wb29sX2RtYV9hbGxvYyhoY2QtPmxvY2FsbWVtX3Bvb2ws
DQo+PiArCQkJCQkJc2l6ZW9mKCpvaGNpLT5oY2NhKSwNCj4+ICsJCQkJCQkmb2hjaS0+aGNjYV9k
bWEpOw0KPj4gKwllbHNlDQo+PiArCQlvaGNpLT5oY2NhID0gZG1hX2FsbG9jX2NvaGVyZW50KGhj
ZC0+c2VsZi5jb250cm9sbGVyLA0KPj4gKwkJCQkJCXNpemVvZigqb2hjaS0+aGNjYSksDQo+PiAr
CQkJCQkJJm9oY2ktPmhjY2FfZG1hLA0KPj4gKwkJCQkJCUdGUF9LRVJORUwpOw0KPiANCj4gSSB3
b25kZXIgaWYgd2UgY291bGQganVzdCB1c2UgaGNkX2J1ZmZlcl9hbGxvYy9mcmVlIGhlcmUsIGFs
dGhvdWdodA0KPiB0aGF0IHdvdWxkIHJlcXVpcmUgdGhlbSB0byBiZSBleHBvcnRlZC4gIEknbGwg
bGVhdmUgdGhhdCBkZWNpc2lvbiB0bw0KPiB0aGUgcmVsZXZhbnQgbWFpbnRhaW5lcnMsIHRob3Vn
aC4NCj4gDQo+IEV4Y2VwdCBmb3IgdGhpcyB0aGUgc2VyaWVzIGxvb2tzIGV4YWN0bHkgd2hhdCBJ
IGhhZCBlbnZpc2lvbmVkIHRvDQo+IGdldCByaWQgb2YgdGhlIGRldmljZSBsb2NhbCBkbWFfZGVj
bGFyZV9jb2hlcmVudCB1c2UgY2FzZSwgdGhhbmtzIQ0KDQpHbGFkIEkgY291bGQgaGVscC4gT24g
dGhlIHJlbW90ZXByb2NfdmlydGlvLmMgY2FzZSwgSSBoYWQgYSBjdXJzb3J5IGxvb2sgDQphbmQg
Zm91bmQgb3V0IHRoYXQgdGhlIGRtYV9kZWNsYXJlX2NvaGVyZW50X21lbW9yeSgpIHVzYWdlIHdh
cyANCmludHJvZHVjZWQgcXVpdGUgcmVjZW50bHksIGJ5IHRoaXMgcGF0Y2g6DQpodHRwczovL2dp
dC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQv
Y29tbWl0Lz9pZD0wODZkMDg3MjVkMzRjNmIzMzMzZGI3MTAzNDRhZTljNGZkYWZiMmQ1DQoNCi0t
LQ0KQmVzdCBSZWdhcmRzLCBMYXVyZW50aXU=
