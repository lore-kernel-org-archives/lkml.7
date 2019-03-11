Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30C4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 07:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7690E20643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 07:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZDKeqpqZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfCKHnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 03:43:35 -0400
Received: from mail-eopbgr150071.outbound.protection.outlook.com ([40.107.15.71]:55203
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725831AbfCKHne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 03:43:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3vzN5oocRwCZohafDmzxFThEIiV370VqRpU9pw8HDY=;
 b=ZDKeqpqZ7o2bhnuasteA2odPoT5oSFNFdnqzcHnAkkIyOK9sJ/BfvWC3pyTobkPd2YjdcehL4gA2C8d+TCoHLW8AZ4Z0yNcc2nIDB9HV129SmcFvIXFoff+wtW9HBvoCNFuAGVlB9J2h4XlVEhQGfcstq7S7h7pdWALUmY+CX+s=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3676.eurprd04.prod.outlook.com (52.134.70.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Mon, 11 Mar 2019 07:42:51 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 07:42:51 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] mailbox: imx: keep MU irq working during suspend/resume
Thread-Topic: [PATCH] mailbox: imx: keep MU irq working during suspend/resume
Thread-Index: AQHUwtAg/pNADKFPLk+9n0uazrY7lKYGNl6Q
Date:   Mon, 11 Mar 2019 07:42:50 +0000
Message-ID: <DB3PR0402MB3916CF122AB4C49EB6159144F5480@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1549974905-12116-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1549974905-12116-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8413215c-d0b4-41af-8f90-08d6a5f52a11
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3676;
x-ms-traffictypediagnostic: DB3PR0402MB3676:
x-microsoft-exchange-diagnostics: =?gb2312?B?MTtEQjNQUjA0MDJNQjM2NzY7MjM6WmdJd1g4WEowbCtPRnlQWDVEcmFYUHpY?=
 =?gb2312?B?TXFJZ1VoWWlhVXpFWHA0eFNaMUppYzl6RDF1MVpmOW5OMDNaUnVVK2hRRFYr?=
 =?gb2312?B?b1VQSmhKY0xieFNScHl3bUtsVjdoWlYvL0tsaDNMZ3hXOSthb3I2bjFuZGY0?=
 =?gb2312?B?TkFWTjVQQ3I4aWdFR3B6ZEFWdlZoNmUzV0U3MmtVSklWWXhxdkpHbk9IYkpM?=
 =?gb2312?B?QlpRVVhxZFA2QmUrVFVBc1ZQelhaeFBuRk42eXNkWFBBN0FTOS84eEs2Z1BF?=
 =?gb2312?B?a3p4QWJVcFp1NHVPZk5vTzRkMTN5eGpadHZtSzZNZFVIQTV0WDVNdHEwZ01X?=
 =?gb2312?B?R0JHbnViVXBMVEhrYlhkYm5zVDhkbHZaQTYvdUNVYmdDaEhmWjJMUHVRdUkw?=
 =?gb2312?B?d0EyYXJwNEhtOTZ6TDg4ZTRlLzgwak51SzNNZjYvLzZXcVcva1Nlc0hEWFV6?=
 =?gb2312?B?MFZVQnpsd1BmS3RwN1NIdDRwbmJRVnhyU1d4Sm5XV2M1UEVjS0d1UVZTK1hZ?=
 =?gb2312?B?SHVFWDB4anUzRllhczJIQlNLTGhkQXBsdHBQWEIyTmNMb3UwMmFCaThPRHZV?=
 =?gb2312?B?dUt4V2hNcENqMUttRHVLWFg1YmFFNkNxSFgvTFhYcVBRTDZ1aWs0dWJzMnNB?=
 =?gb2312?B?Sm9VbXFVMUJqaHpsOFRVcXpjVUNXV3dYTXAvcE1jUzgweVlLSmRiMlJDMUFK?=
 =?gb2312?B?dkU1MmxhL1JNVGFjektqOXlERytOR3I4WUdkYnVYWUxnTHpES0Q1TFc2b3Bl?=
 =?gb2312?B?b1haL2F5U0tTd0VVUEh6MGZta3JQeDFaOCtMTVRDREtuc3RFNjZabzlyU1pt?=
 =?gb2312?B?WUtGRzNvaFFtUDBSYjBPMUlWNk1mNVo5TFJVWVVrNHVENWdtbmZQdW5BMW5F?=
 =?gb2312?B?MmFrL2g1RGxtbk56WFpxeUNRM1dLTml2MzJXYms5bkFUdm1rZ2IvYW9KSTYx?=
 =?gb2312?B?OTErMjBGWm1MNnFscjJoR2pycit3NndkVTVESDR2QkYzaDhwbDhxd2tCNWFs?=
 =?gb2312?B?QTYvenlZVExPNE1hUVJjclNqVlJhekIwb29RKzVod21SOGVNZjVOYmdJT1Ur?=
 =?gb2312?B?b1pIRGJZclY0UVE3MDVWaDdSM05OWFBiSHRQWUk3d3VUVjVVVlVKNFBTdis3?=
 =?gb2312?B?Y1RJSkUvd3FQMi9aU2tKSTZ6M2tqVTV1Y3pKZGsvMVBkMUovK1JMVkh3KzBy?=
 =?gb2312?B?emVrb3hBekkzUVhsVGVHSHNJUTJrOTNWWjgrU2VXM0ozV1hpRUF3Ym5PZVdi?=
 =?gb2312?B?S3o0ZzlVYmo1bmJacm1aMTY3OHl3OHI4UE9NdThiL20ybXUvZGhoUmlMcTJS?=
 =?gb2312?B?M0IwcVVTdktuMStYL3VjYmsyRlFIeWpucTgvdi9MZmJVeWU1aW43SU5JQUho?=
 =?gb2312?B?eG5va1JmcVlRcWVFdk1RSmFBNlBacGh4MHN0aWhMZ3k2M1JOZFpUcGZENE9Q?=
 =?gb2312?B?TDBGZ01DNEs0cTlZNGRrRWt4dEJqLzgwdkhSckZEc2NhM2hkMWRKM0s4OWFn?=
 =?gb2312?B?WmRBQVBHaHNqcTgyQkxEemFXTFpQVGE4bFpZT3ZvWkh4SzloVkwreUdEYW1T?=
 =?gb2312?B?dlFxbjlrWG1BMnY0K0x4QzFnSFpvTExTRnFkajJ1c2ZUWUhpVGNZaHl3UmYr?=
 =?gb2312?B?MGgydFMzRGR3R0o0azg1Q29ZenorbU5pUzhjN2FJYVo2MXpDbi85OEo4UmxV?=
 =?gb2312?B?Wk1mWHR6U2hKck1GeFNSaXRvK0xMUXhjWEgxYm1EanBZNXFxMmRRM01MQmpo?=
 =?gb2312?B?Lzd6ZUdWNVFLREZjV1hac0g0U0gxZUxGUjFuNWZuTTdyRzBIZ2FETjVHeGd0?=
 =?gb2312?Q?P40WZks8NjkSPN4?=
x-microsoft-antispam-prvs: <DB3PR0402MB3676576B61159D39E41FBEE9F5480@DB3PR0402MB3676.eurprd04.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(136003)(39860400002)(376002)(13464003)(189003)(199004)(74316002)(2501003)(15650500001)(110136005)(2906002)(33656002)(106356001)(105586002)(68736007)(316002)(97736004)(81156014)(81166006)(8676002)(478600001)(14454004)(305945005)(7736002)(7696005)(99286004)(6506007)(53546011)(102836004)(76176011)(6116002)(6436002)(3846002)(4326008)(44832011)(229853002)(9686003)(476003)(71190400001)(71200400001)(52536013)(5660300002)(25786009)(26005)(446003)(256004)(66066001)(2201001)(14444005)(53936002)(11346002)(8936002)(86362001)(186003)(486006)(55016002)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3676;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Y5eix855wLGLD9lmQ2rTihmIMNLftJPP2NMGv0Sj2Iy1wqikT0ohocEnjG3vv95AfqRzUDAyaEMkwUxDGdYU93otzP4+QYRd4+8VFy1sDmAUciSYeQMPqwtTlgQ8aVeNFVAqAk0MmCyF2lSAg0s6Kp6xScZfwYqrwxnV7hmPi0rskPH73CK2X+tFQ1lB5jgKKipIIaNeseqg5Rmmp70rGK9/OMqGPnqKDb4OntDskil2xRNxxGhwQCqdNfa9WZCLGE98hySIaG4K68p2WAiX5HJLPg0Vh//4Y/9Ba1CcIcKYbcu2/6ZOfTRYd5itASX1zLpHrB+eKNrXrb0lLQXr+4oKiRxHZH51JPYXzkEgFVHFk+NRRamT0GIGrpki/xiHXfoCKpG0fSA/qwAww59R7zqXJNbuMaz710XBQbjomSU=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8413215c-d0b4-41af-8f90-08d6a5f52a11
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 07:42:51.0187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3676
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UGluZy4uLg0KDQpCZXN0IFJlZ2FyZHMhDQpBbnNvbiBIdWFuZw0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEFuc29uIEh1YW5nIFttYWlsdG86QW5zb24uSHVhbmdAbnhw
LmNvbV0NCj4gU2VudDogMjAxOcTqMtTCMTLI1SAyMDo0MA0KPiBUbzogamFzc2lzaW5naGJyYXJA
Z21haWwuY29tOyBzaGF3bmd1b0BrZXJuZWwub3JnOw0KPiBzLmhhdWVyQHBlbmd1dHJvbml4LmRl
OyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsNCj4gbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
DQo+IENjOiBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBbUEFU
Q0hdIG1haWxib3g6IGlteDoga2VlcCBNVSBpcnEgd29ya2luZyBkdXJpbmcgc3VzcGVuZC9yZXN1
bWUNCj4gDQo+IER1cmluZyBub2lycSBzdXNwZW5kIHBoYXNlLCBtYWlsYm94IE1VIGlycSB3aWxs
IGJlIG1hc2tlZCBidXQgbWFueQ0KPiBkcml2ZXJzIHN0aWxsIG5lZWQgdG8gY29tbXVuaWNhdGUg
d2l0aCBzeXN0ZW0gY29udHJvbGxlciBmaXJtd2FyZSB2aWENCj4gbWFpbGJveCwgaWYgTVUgaXJx
IGlzIG1hc2tlZCwgaXQgd2lsbCBjYXVzZSBSUEMgdGltZW91dCBhcyBiZWxvdzoNCj4gDQo+IFsg
ICAyMy4zNzIxMDNdIGlteC1zY3Ugc2N1OiBSUEMgc2VuZCBtc2cgdGltZW91dA0KPiANCj4gU2V0
dGluZyBNVSBpcnEgdG8gYmUgd2FrZXVwIHNvdXJjZSBpcyBOT1Qgd29ya2luZyBhcyBHSUMgZHJp
dmVyIGRvZXMgTk9UDQo+IGhhdmUgLmlycV9zZXRfd2FrZSBpbXBsZW1lbnRlZCwgc28gdG8gc3Vw
cG9ydCBzdXNwZW5kL3Jlc3VtZSwganVzdCBtYWtlDQo+IGlteCBtYWlsYm94IGRyaXZlciBOT1Qg
c3VzcGVuZCwgc2luY2UgTVUgaXMgYWx3YXlzIGEgd2FrZXVwIHNvdXJjZSBvbg0KPiBpLk1YIHBs
YXRmb3JtcyB3aXRoIHN5c3RlbSBjb250cm9sbGVyIGluc2lkZSwgYW5kIGl0cyBwb3dlci9jbG9j
ayBpcw0KPiBtYWludGFpbmVkIGJ5IHN5c3RlbSBjb250cm9sbGVyLCBtYWlsYm94IGRyaXZlciBu
byBuZWVkIHRvIG1hbmFnZSB0aGVtLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcg
PEFuc29uLkh1YW5nQG54cC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9tYWlsYm94L2lteC1tYWls
Ym94LmMgfCA0ICsrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tYWlsYm94L2lteC1tYWlsYm94
LmMgYi9kcml2ZXJzL21haWxib3gvaW14LW1haWxib3guYw0KPiBpbmRleCA3NzQzNjJhLi44NWZj
NWI1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL21haWxib3gvaW14LW1haWxib3guYw0KPiArKysg
Yi9kcml2ZXJzL21haWxib3gvaW14LW1haWxib3guYw0KPiBAQCAtMTg3LDggKzE4Nyw4IEBAIHN0
YXRpYyBpbnQgaW14X211X3N0YXJ0dXAoc3RydWN0IG1ib3hfY2hhbiAqY2hhbikNCj4gIAkJcmV0
dXJuIDA7DQo+ICAJfQ0KPiANCj4gLQlyZXQgPSByZXF1ZXN0X2lycShwcml2LT5pcnEsIGlteF9t
dV9pc3IsIElSUUZfU0hBUkVELCBjcC0+aXJxX2Rlc2MsDQo+IC0JCQkgIGNoYW4pOw0KPiArCXJl
dCA9IHJlcXVlc3RfaXJxKHByaXYtPmlycSwgaW14X211X2lzciwgSVJRRl9TSEFSRUQgfA0KPiAr
CQkJICBJUlFGX05PX1NVU1BFTkQsIGNwLT5pcnFfZGVzYywgY2hhbik7DQo+ICAJaWYgKHJldCkg
ew0KPiAgCQlkZXZfZXJyKHByaXYtPmRldiwNCj4gIAkJCSJVbmFibGUgdG8gYWNxdWlyZSBJUlEg
JWRcbiIsIHByaXYtPmlycSk7DQo+IC0tDQo+IDIuNy40DQoNCg==
