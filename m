Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBD6C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 22:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EA3D2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 22:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="yf5Rte+F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfCAWMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 17:12:10 -0500
Received: from mail-eopbgr130075.outbound.protection.outlook.com ([40.107.13.75]:52893
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726311AbfCAWMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 17:12:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPmXDiw/nCmfExp3KxC108R+kjO4d9OWFCruoK6g/Jg=;
 b=yf5Rte+FBVUMAbuVpbC08l0bgoXYVSlBUChGbLXhrM0Retnyxk1uJWWUFkChE19ig1IOdhshvKuWVpncj2Z1f6bKr8Oz3o4RFJQ4x/LhxSGpYjAzWo7q74y25bJ+fR7Qwa0RvEDv4aycAvYSf+dlQz6UYqE425aPd9gcy6hSJy8=
Received: from DB8PR05MB5898.eurprd05.prod.outlook.com (20.179.9.32) by
 DB8PR05MB6602.eurprd05.prod.outlook.com (20.179.12.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.18; Fri, 1 Mar 2019 22:12:04 +0000
Received: from DB8PR05MB5898.eurprd05.prod.outlook.com
 ([fe80::28ed:92cd:4075:b660]) by DB8PR05MB5898.eurprd05.prod.outlook.com
 ([fe80::28ed:92cd:4075:b660%2]) with mapi id 15.20.1665.015; Fri, 1 Mar 2019
 22:12:04 +0000
From:   Saeed Mahameed <saeedm@mellanox.com>
To:     Jiri Pirko <jiri@mellanox.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Parav Pandit <parav@mellanox.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "michal.lkml@markovi.net" <michal.lkml@markovi.net>
Subject: Re: [RFC net-next 8/8] net/mlx5: Add subdev driver to bind to subdev
 devices
Thread-Topic: [RFC net-next 8/8] net/mlx5: Add subdev driver to bind to subdev
 devices
Thread-Index: AQHUz/EI0g2MiyRYo0CIhMfO638PrqX3V7UA
Date:   Fri, 1 Mar 2019 22:12:04 +0000
Message-ID: <b4d8f1f9b53f589e2e60c9aa8bc677ac38144987.camel@mellanox.com>
References: <1551418672-12822-1-git-send-email-parav@mellanox.com>
         <1551418672-12822-9-git-send-email-parav@mellanox.com>
In-Reply-To: <1551418672-12822-9-git-send-email-parav@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=saeedm@mellanox.com; 
x-originating-ip: [209.116.155.178]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 82a67fde-113e-482a-3f73-08d69e92efaa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB8PR05MB6602;
x-ms-traffictypediagnostic: DB8PR05MB6602:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtEQjhQUjA1TUI2NjAyOzIzOitBS3VlQXdOUTgwV3Q4MU1mRjBCMHlIUXQ3?=
 =?utf-8?B?VHJuQ3MyWnVRdE1ZZ3FXTzZYZ2ZDKytyYmZzYXgzbVpZdFcwaGxaYzl2aktF?=
 =?utf-8?B?ckdHY0l5Ti9zYnB0RU9EVVVhK243bmNPVXJ0NmdpL1NiSEZrVjV4Z2ErYWV5?=
 =?utf-8?B?QnlOVkIwbC95cGxmVGtCUUFzUTJUTkV0VUwxM1M3MzJYemlPcjR1RnZ1VHZz?=
 =?utf-8?B?SVl1VDJPR1hYejA0dDlMdmJVR3Y5M01YbDM2TEhmaDdNcTRnTlFIYzJrM3JN?=
 =?utf-8?B?aGFRT2grZFlQcitCV3JZaUpTamM5dE43eHArMXVZYkdERTB0a1R4ejIwa0Zn?=
 =?utf-8?B?OW85bTJFbTNCUHhjZXQ3WVZ3WG1OR1dsakdiRzFEMmJZS2RUMFV4MW1kNEh5?=
 =?utf-8?B?K0VsNnM4N3RZaUQwVGZEOW5wMWNDY1ZDdTFKR2VBbkdsblFmNGV3L3dhUzhq?=
 =?utf-8?B?SGRtR2F1T2lBbStNdEw2TTNYbUw5RHIrTUNVZU9mUWd3ckN0enpyNTBOcGVJ?=
 =?utf-8?B?bnBtMG10VGRtMHZMT003czVNK1dtU05BV0QyR0MyWW5DUjdCZTRVa0U4THFF?=
 =?utf-8?B?V2JHYmJzMXR3YWVKdXZyZkhRNWxBNVlVNkpUWWJaTHEzU1NsZ0lGMzFibkhU?=
 =?utf-8?B?d1Fzb1N5Tlp5RFBORDkrNE5ESU9aeWp0Q2JXeDBnWkpsOUhnSUZSQ3BRM1ha?=
 =?utf-8?B?dTBnQ3lHRi9sdWNCUnlKZ1hoMDdnQ2M4K2VGVU91TEE0ZUt5NW9GR3JlM3Er?=
 =?utf-8?B?VFhsSTJCQjVwSUtsVnlmV2dWT0dxT3lvK1ZQY0JtdElqeGdjRjFObUhrdmxO?=
 =?utf-8?B?SFVmZStjcHRYRWhGTjFBNjU3OXBuNzZIYmNlVERKaUJGWStYUURVMW01cFZs?=
 =?utf-8?B?WFRYTW1nMkNFeDgvZ1FGb3BjQmFacUVNNDByQnFTV3NvMmJuMW54eSs3cDBV?=
 =?utf-8?B?NW8reHZ0R2VLcGtFN2xjeGx1Sk9saEdndzBMUG4yaHQ5UDdKK3l1TUpGVGsx?=
 =?utf-8?B?eWRjUHhMU0NZMEVISlJtMVNMYTZhSkVhMGJIY1l3S3JpcUpNSWROemNHZTBV?=
 =?utf-8?B?N01FOE1iRDVQaE44bFBmV25mUnBCdVJkb1lNWWF4dW9TS2RoRmZLbnNlcEpx?=
 =?utf-8?B?M2NUdG1lSjdLVHEyUjduSFpSVzN3MTJkekV1aGhwSzVlV1pFbEhha3JqalNJ?=
 =?utf-8?B?K0dXKytSUFI4dDlWRHVzWTNiRnR2c2V6T0d2VjU0VGFpYUpqeWt0OEJTdStP?=
 =?utf-8?B?cVN3UUpYZjNleTE3T3hBclNKT2JjS0xuODlQNDRWZmRuaEJCNVM3Qi9IM01x?=
 =?utf-8?B?ejVJQTBKbWpDRmZnVmx6K0J2VGR3MXBwMk05Zmt5VTJQM1RRUjNZR25VRkY5?=
 =?utf-8?B?bEdGM2xodDYxbjN6Q0pWSURDdmlOb3gwWjNXR1gvVWk2YStMSGRtVlh5M1BY?=
 =?utf-8?B?blVtbDJab2NCZ2xvVjlXOXVKbUFibUtSQjcreHFQVFc0QXJteU9NRDR6NlhB?=
 =?utf-8?B?QTVOQ21EbFNhcmF5UWxoaGdyQnR3b1Q2a042QVBFMzJaS0RBUjRvZkNkRE1B?=
 =?utf-8?B?YXVNY3RLTUFxMnA3WnB2b0wzRjhWbVFvTlQ1ckE2T1VvVFNRZDdBRWNrNkI5?=
 =?utf-8?B?L3JRa2VIdDBHUFlMcGpqcXRoV1hHSi8zdFlWeHd0eHlXMkp3aFprRThBPT0=?=
x-microsoft-antispam-prvs: <DB8PR05MB6602509CA351F21083569A4BBE760@DB8PR05MB6602.eurprd05.prod.outlook.com>
x-forefront-prvs: 09634B1196
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(346002)(376002)(396003)(199004)(189003)(118296001)(76176011)(256004)(14444005)(6506007)(26005)(478600001)(25786009)(105586002)(66066001)(53936002)(5660300002)(8936002)(68736007)(81166006)(81156014)(8676002)(71190400001)(71200400001)(106356001)(2501003)(186003)(6246003)(7736002)(486006)(102836004)(2906002)(2616005)(316002)(6486002)(446003)(14454004)(476003)(229853002)(6512007)(86362001)(110136005)(6436002)(99286004)(97736004)(36756003)(6116002)(3846002)(58126008)(11346002)(2201001)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR05MB6602;H:DB8PR05MB5898.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PLBneSVs70ndbznnQdYkL8980wT9c89WoUb9UqR7NyqOgd3t6/I8hQWH+nreT0byvFo932xRcd1Dau287VkdX7o3+4aWMeCr8Rd6ukkTpRUoWYPrWQ1zqKWaV0wRbRonVInTZjaupFE688ktpW1nENZmPG/4ve9XrbdMWUsaJbP8Kl+ZUwGJAddcdb6YBd57uXVOsDlEyGmIKT5NXAcPhB9EwrLpQsuPDD0T4+IT1nhEyw82PoaYTo7PJ6Hv5D8a0AX0+RyoeIPfUoFohuKFACmbAqcyWJ4rJKKuFRI3lBWCx3lTau8lNnEWHGxFNZZQomizN2rFdgR9MAXiaGl0RfyD60i3uRrg8XJwa35vmhMzzWqWS/dcopxBVcWTx6y0j4dUOWVrfQbfdNC2thlg88tCI3bnlg4PPA79L5re6wM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <87CC2933A7A94A4787AC28786434D5B9@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82a67fde-113e-482a-3f73-08d69e92efaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2019 22:12:04.1428
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR05MB6602
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE5LTAyLTI4IGF0IDIzOjM3IC0wNjAwLCBQYXJhdiBQYW5kaXQgd3JvdGU6DQo+
IEFkZCBhIHN1YmRldiBkcml2ZXIgdG8gcHJvYmUgdGhlIHN1YmRldiBkZXZpY2VzIGFuZCBjcmVh
dGUgZmFrZQ0KPiBuZXRkZXZpY2UgZm9yIGl0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUGFyYXYg
UGFuZGl0IDxwYXJhdkBtZWxsYW5veC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJu
ZXQvbWVsbGFub3gvbWx4NS9jb3JlL01ha2VmaWxlICAgfCAgMiArLQ0KPiAgZHJpdmVycy9uZXQv
ZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL21haW4uYyAgICAgfCAgOCArLQ0KPiAgLi4uL25l
dC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvbWx4NV9jb3JlLmggICAgfCAgMyArDQo+ICAu
Li4vZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL3N1YmRldl9kcml2ZXIuYyAgICB8IDkzDQo+
ICsrKysrKysrKysrKysrKysrKysrKysNCj4gIDQgZmlsZXMgY2hhbmdlZCwgMTA0IGluc2VydGlv
bnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gZHJpdmVycy9u
ZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL3N1YmRldl9kcml2ZXIuYw0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21seDUvY29yZS9NYWtlZmls
ZQ0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21seDUvY29yZS9NYWtlZmlsZQ0K
PiBpbmRleCBmMjE4Nzg5Li5jOGFlYWYxIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhl
cm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvTWFrZWZpbGUNCj4gKysrIGIvZHJpdmVycy9uZXQvZXRo
ZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL01ha2VmaWxlDQo+IEBAIC0xNiw3ICsxNiw3IEBAIG1s
eDVfY29yZS15IDo9CW1haW4ubyBjbWQubyBkZWJ1Z2ZzLm8gZncubw0KPiBlcS5vIHVhci5vIHBh
Z2VhbGxvYy5vIFwNCj4gIAkJdHJhbnNvYmoubyB2cG9ydC5vIHNyaW92Lm8gZnNfY21kLm8gZnNf
Y29yZS5vIFwNCj4gIAkJZnNfY291bnRlcnMubyBybC5vIGxhZy5vIGRldi5vIGV2ZW50cy5vIHdx
Lm8gbGliL2dpZC5vDQo+IFwNCj4gIAkJbGliL2RldmNvbS5vIGRpYWcvZnNfdHJhY2Vwb2ludC5v
IGRpYWcvZndfdHJhY2VyLm8NCj4gLW1seDVfY29yZS0kKENPTkZJR19TVUJERVYpICs9IHN1YmRl
di5vDQo+ICttbHg1X2NvcmUtJChDT05GSUdfU1VCREVWKSArPSBzdWJkZXYubyBzdWJkZXZfZHJp
dmVyLm8NCj4gIA0KPiAgIw0KPiAgIyBOZXRkZXYgYmFzaWMNCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21seDUvY29yZS9tYWluLmMNCj4gYi9kcml2ZXJzL25l
dC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvbWFpbi5jDQo+IGluZGV4IDVmOGNmMGQuLjdk
ZmE4YzQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21seDUv
Y29yZS9tYWluLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9j
b3JlL21haW4uYw0KPiBAQCAtMTU0OCw3ICsxNTQ4LDExIEBAIHN0YXRpYyBpbnQgX19pbml0IGlu
aXQodm9pZCkNCj4gIAltbHg1ZV9pbml0KCk7DQo+ICAjZW5kaWYNCj4gIA0KPiAtCXJldHVybiAw
Ow0KPiArCWVyciA9IHN1YmRldl9yZWdpc3Rlcl9kcml2ZXIoJm1seDVfc3ViZGV2X2RyaXZlcik7
DQo+ICsJaWYgKGVycikNCj4gKwkJcGNpX3VucmVnaXN0ZXJfZHJpdmVyKCZtbHg1X2NvcmVfZHJp
dmVyKTsNCj4gKw0KPiArCXJldHVybiBlcnI7DQo+ICANCj4gIGVycl9kZWJ1ZzoNCj4gIAltbHg1
X3VucmVnaXN0ZXJfZGVidWdmcygpOw0KPiBAQCAtMTU1Nyw2ICsxNTYxLDggQEAgc3RhdGljIGlu
dCBfX2luaXQgaW5pdCh2b2lkKQ0KPiAgDQo+ICBzdGF0aWMgdm9pZCBfX2V4aXQgY2xlYW51cCh2
b2lkKQ0KPiAgew0KPiArCXN1YmRldl91bnJlZ2lzdGVyX2RyaXZlcigmbWx4NV9zdWJkZXZfZHJp
dmVyKTsNCj4gKw0KPiAgI2lmZGVmIENPTkZJR19NTFg1X0NPUkVfRU4NCj4gIAltbHg1ZV9jbGVh
bnVwKCk7DQo+ICAjZW5kaWYNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21l
bGxhbm94L21seDUvY29yZS9tbHg1X2NvcmUuaA0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21l
bGxhbm94L21seDUvY29yZS9tbHg1X2NvcmUuaA0KPiBpbmRleCAyYTU0MTQ4Li4xYjczM2M3IDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvbWx4
NV9jb3JlLmgNCj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3Jl
L21seDVfY29yZS5oDQo+IEBAIC00MSwxMiArNDEsMTUgQEANCj4gICNpbmNsdWRlIDxsaW51eC9w
dHBfY2xvY2tfa2VybmVsLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvbWx4NS9jcS5oPg0KPiAgI2lu
Y2x1ZGUgPGxpbnV4L21seDUvZnMuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9zdWJkZXZfYnVzLmg+
DQo+ICANCj4gICNkZWZpbmUgRFJJVkVSX05BTUUgIm1seDVfY29yZSINCj4gICNkZWZpbmUgRFJJ
VkVSX1ZFUlNJT04gIjUuMC0wIg0KPiAgDQo+ICBleHRlcm4gdWludCBtbHg1X2NvcmVfZGVidWdf
bWFzazsNCj4gIA0KPiArZXh0ZXJuIHN0cnVjdCBzdWJkZXZfZHJpdmVyIG1seDVfc3ViZGV2X2Ry
aXZlcjsNCj4gKw0KPiAgI2RlZmluZSBtbHg1X2NvcmVfZGJnKF9fZGV2LCBmb3JtYXQsIC4uLikJ
CQkJDQo+IFwNCj4gIAlkZXZfZGJnKCYoX19kZXYpLT5wZGV2LT5kZXYsICIlczolZDoocGlkICVk
KTogIiBmb3JtYXQsCQkNCj4gXA0KPiAgCQkgX19mdW5jX18sIF9fTElORV9fLCBjdXJyZW50LT5w
aWQsCQkJDQo+IFwNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94
L21seDUvY29yZS9zdWJkZXZfZHJpdmVyLmMNCj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxs
YW5veC9tbHg1L2NvcmUvc3ViZGV2X2RyaXZlci5jDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+
IGluZGV4IDAwMDAwMDAuLjg4MGFhNGYNCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9kcml2ZXJz
L25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvc3ViZGV2X2RyaXZlci5jDQo+IEBAIC0w
LDAgKzEsOTMgQEANCj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+ICsv
LyBDb3B5cmlnaHQgKGMpIDIwMTgtMTkgTWVsbGFub3ggVGVjaG5vbG9naWVzDQo+ICsNCj4gKyNp
bmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9kbWEtbWFwcGluZy5o
Pg0KPiArI2luY2x1ZGUgPGxpbnV4L3N1YmRldl9idXMuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9z
dWJkZXZfaWRzLmg+DQo+ICsjaW5jbHVkZSA8bGludXgvZXRoZXJkZXZpY2UuaD4NCj4gKw0KPiAr
c3RydWN0IG1seDVfc3ViZGV2X25kZXYgew0KPiArCXN0cnVjdCBuZXRfZGV2aWNlIG5kZXY7DQo+
ICt9Ow0KPiArDQo+ICtzdGF0aWMgdm9pZCBtbHg1X2RtYV90ZXN0KHN0cnVjdCBkZXZpY2UgKmRl
dikNCj4gK3sNCj4gKwlkbWFfYWRkcl90IHBhOw0KPiArCXZvaWQgKnZhOw0KPiArDQo+ICsJdmEg
PSBkbWFfYWxsb2NfY29oZXJlbnQoZGV2LCA0MDk2LCAmcGEsIEdGUF9LRVJORUwpOw0KPiArCWlm
ICh2YSkNCj4gKwkJZG1hX2ZyZWVfY29oZXJlbnQoZGV2LCA0MDk2LCB2YSwgcGEpOw0KPiArfQ0K
PiArDQo+ICtzdGF0aWMgc3RydWN0IG5ldF9kZXZpY2UgKm5kZXY7DQo+ICsNCj4gK3N0YXRpYyBp
bnQgbWx4NWVfc3ViZGV2X29wZW4oc3RydWN0IG5ldF9kZXZpY2UgKm5ldGRldikNCj4gK3sNCj4g
KwlyZXR1cm4gMDsNCj4gK30NCj4gKw0KPiArc3RhdGljIGludCBtbHg1ZV9zdWJkZXZfY2xvc2Uo
c3RydWN0IG5ldF9kZXZpY2UgKm5ldGRldikNCj4gK3sNCj4gKwlyZXR1cm4gMDsNCj4gK30NCj4g
Kw0KPiArc3RhdGljIG5ldGRldl90eF90DQo+ICttbHg1ZV9zdWJkZXZfeG1pdChzdHJ1Y3Qgc2tf
YnVmZiAqc2tiLCBzdHJ1Y3QgbmV0X2RldmljZSAqbmV0ZGV2KQ0KPiArew0KPiArCXJldHVybiBO
RVRERVZfVFhfQlVTWTsNCj4gK30NCj4gKw0KPiArY29uc3Qgc3RydWN0IG5ldF9kZXZpY2Vfb3Bz
IG1seDVlX3N1YmRldl9uZXRkZXZfb3BzID0gew0KPiArCS5uZG9fb3BlbiAgICAgICAgICAgICAg
ICA9IG1seDVlX3N1YmRldl9vcGVuLA0KPiArCS5uZG9fc3RvcCAgICAgICAgICAgICAgICA9IG1s
eDVlX3N1YmRldl9jbG9zZSwNCj4gKwkubmRvX3N0YXJ0X3htaXQgICAgICAgICAgPSBtbHg1ZV9z
dWJkZXZfeG1pdCwNCj4gK307DQo+ICsNCj4gK3N0YXRpYyBpbnQgbWx4NV9zdWJkZXZfcHJvYmUo
c3RydWN0IGRldmljZSAqZGV2KQ0KPiArew0KPiArCWludCBlcnI7DQo+ICsNCj4gKwltbHg1X2Rt
YV90ZXN0KGRldik7DQoNCkhpIFBhcmF2LCBjYW4geW91IHBsZWFzZSBzaGVkIHNvbWUgbGlnaHQg
b24gaG93IGRvIHlvdSBwbGFuIHRvDQpjb21tdW5pY2F0ZSB3aXRoIHRoZSBwYXJlbnQgZGV2aWNl
ID8gKHBjaV9kZXYgYW5kIGl0J3MgcnVubmluZyBkcml2ZXINCmluc3RhbmNlKSwgV2Ugd2lsbCBu
ZWVkIHRvIHNoYXJlIHNvbWUgcmVzb3VyY2VzLCBzdWNoIGFzIElSUXMvQkFScy9ldGMNCi4uLCBh
bmQgbWF5YmUgc29tZSBIVyBvYmplY3RzIHdoaWNoIGFyZSBnb2luZyB0byBiZSBtYW5hZ2VkIGJ5
IHRoZQ0KcGFyZW50IHBjaSBkZXZpY2UgZHJpdmVyLg0KDQpKdXN0IGFsbG9jYXRpbmcgYSBkbWEg
YnVmZmVyIGRvZXNuJ3QgbWVhbiBhbnl0aGluZywgdGhlIGRtYSBidWZmZXIgaXMNCmp1c3QgYm91
bmQgdG8gdGhlIGdlbmVyaWMgZGV2aWNlLg0KDQo+ICsJLyogT25seSBvbmUgZGV2aWNlIHN1cHBv
cnRlZCBpbiByZmMgKi8NCj4gKwlpZiAobmRldikNCj4gKwkJcmV0dXJuIDA7DQo+ICsNCj4gKwlu
ZGV2ID0gYWxsb2NfZXRoZXJkZXZfbXFzKHNpemVvZihzdHJ1Y3QgbWx4NV9zdWJkZXZfbmRldiks
IDEsDQo+IDEpOw0KPiArCWlmICghbmRldikNCj4gKwkJcmV0dXJuIC1FTk9NRU07DQo+ICsNCj4g
KwlTRVRfTkVUREVWX0RFVihuZGV2LCBkZXYpOw0KPiArCW5kZXYtPm5ldGRldl9vcHMgPSAmbWx4
NWVfc3ViZGV2X25ldGRldl9vcHM7DQo+ICsJZXJyID0gcmVnaXN0ZXJfbmV0ZGV2KG5kZXYpOw0K
PiArCWlmIChlcnIpIHsNCj4gKwkJZnJlZV9uZXRkZXYobmRldik7DQo+ICsJCW5kZXYgPSBOVUxM
Ow0KPiArCX0NCj4gKwlyZXR1cm4gZXJyOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgaW50IG1seDVf
c3ViZGV2X3JlbW92ZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICt7DQo+ICsJaWYgKG5kZXYpIHsN
Cj4gKwkJdW5yZWdpc3Rlcl9uZXRkZXYobmRldik7DQo+ICsJCWZyZWVfbmV0ZGV2KG5kZXYpOw0K
PiArCQluZGV2ID0gTlVMTDsNCj4gKwl9DQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gK3N0
YXRpYyBjb25zdCBzdHJ1Y3Qgc3ViZGV2X2lkIG1seDVfc3ViZGV2X2lkX3RhYmxlW10gPSB7DQo+
ICsJeyAudmVuZG9yX2lkID0gU1VCREVWX1ZFTkRPUl9JRF9NRUxMQU5PWCwNCj4gKwkgIC5kZXZp
Y2VfaWQgPSBTVUJERVZfREVWSUNFX0lEX01FTExBTk9YX1NGIH0sDQo+ICsJeyAwLCB9DQo+ICt9
Ow0KPiArTU9EVUxFX0RFVklDRV9UQUJMRShzdWJkZXYsIG1seDVfc3ViZGV2X2lkX3RhYmxlKTsN
Cj4gKw0KPiArc3RydWN0IHN1YmRldl9kcml2ZXIgbWx4NV9zdWJkZXZfZHJpdmVyID0gew0KPiAr
CS5pZF90YWJsZSA9IG1seDVfc3ViZGV2X2lkX3RhYmxlLA0KPiArCS5kcml2ZXIubmFtZSA9ICJt
bHg1X3N1YmRldl9kcml2ZXIiLA0KPiArCS5kcml2ZXIucHJvYmUgPSBtbHg1X3N1YmRldl9wcm9i
ZSwNCj4gKwkuZHJpdmVyLnJlbW92ZSA9IG1seDVfc3ViZGV2X3JlbW92ZSwNCj4gK307DQo=
