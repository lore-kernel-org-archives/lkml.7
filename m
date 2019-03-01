Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36CBC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 09:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7033E218AE
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 09:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="c462eD8Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387706AbfCAJnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 04:43:12 -0500
Received: from mail-eopbgr140078.outbound.protection.outlook.com ([40.107.14.78]:3843
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727915AbfCAJnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 04:43:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUx3bYIVB/lZYdGcXgoDRENplSUpbNRWo/+tmmnv9mM=;
 b=c462eD8QVeK/DBcVMMo0hTcsLf6DFxKPI8DGhzcHJv22QWaGwCcr7fxRcSwJFfaB6tnvuL/B9a0B/ZKTX5zGQASoc0b66LQjrzf1E/VMvuTF6AP08IwMm4CS7WLtP6U1DCxXJYnfWAkLdujL/0Y/KoxmJTjqlRS2AGZZRDrdAeQ=
Received: from VI1PR04MB3247.eurprd04.prod.outlook.com (10.170.232.160) by
 VI1PR04MB5680.eurprd04.prod.outlook.com (20.178.126.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.15; Fri, 1 Mar 2019 09:43:07 +0000
Received: from VI1PR04MB3247.eurprd04.prod.outlook.com
 ([fe80::8d98:21a4:2a84:3c1d]) by VI1PR04MB3247.eurprd04.prod.outlook.com
 ([fe80::8d98:21a4:2a84:3c1d%4]) with mapi id 15.20.1643.022; Fri, 1 Mar 2019
 09:43:07 +0000
From:   Qiang Zhao <qiang.zhao@nxp.com>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Leo Li <leoyang.li@nxp.com>
CC:     Scott Wood <oss@buserror.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Timur Tabi <timur@freescale.com>,
        Rasmus Villemoes <Rasmus.Villemoes@prevas.se>
Subject: RE: [PATCH 4/4] soc/fsl/qe: qe.c: support fsl,qe-snums property
Thread-Topic: [PATCH 4/4] soc/fsl/qe: qe.c: support fsl,qe-snums property
Thread-Index: AQHUz1CqoXHo27iDIUewTpjp4VynIqX2G6jwgABMkoCAABS3cA==
Date:   Fri, 1 Mar 2019 09:43:07 +0000
Message-ID: <VI1PR04MB32478E394D4722F08586F97091760@VI1PR04MB3247.eurprd04.prod.outlook.com>
References: <338677b2-ef74-2afc-4542-c66f1acdb7e5@prevas.dk>
 <20190228103026.9566-1-rasmus.villemoes@prevas.dk>
 <20190228103026.9566-5-rasmus.villemoes@prevas.dk>
 <VI1PR04MB324774864C3B7B44C41C232191760@VI1PR04MB3247.eurprd04.prod.outlook.com>
 <5528c093-12d2-16d3-1afd-73393d8d3b2f@prevas.dk>
In-Reply-To: <5528c093-12d2-16d3-1afd-73393d8d3b2f@prevas.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiang.zhao@nxp.com; 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 833b0ed5-aadb-42f9-8499-08d69e2a4f4c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5680;
x-ms-traffictypediagnostic: VI1PR04MB5680:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtWSTFQUjA0TUI1NjgwOzIzOi9xR3lhVnYyQzRGNTdYVnhNMWNCWFBlRWNw?=
 =?utf-8?B?Q09wRWhZTFZrc1dRTWVqVGt5SGUzblFNTm14cXUrWWNzaGhRZUJ6RW0vWnZ1?=
 =?utf-8?B?L2JtUU5YR2IrZ3Rxa1k0Z1UycVFUaVZncTRvQThRVEhBTmxjb2p1TEFMN2RN?=
 =?utf-8?B?NGpaMS9mSFhVbW01SWdNTmVYblM2NTlCcElhQ0djd2xpd0w4c3RYSWpPaEFx?=
 =?utf-8?B?MXpKTFZpaFg0aTN5aWIzT0UwZ20wZFV2NkVLSDJ0ZTF3YWg3YmU4SHhlRkNx?=
 =?utf-8?B?ME5MMXUwa3RERlp6OU11QmMvWGQ1eDd3dGVwQ25Jdks2QUNLaFkxNVRTVStD?=
 =?utf-8?B?VWFFWTRVcEZLczVGNDN2emlrZnpKdkE0Snh2czlvWms4bFN3aFpUbWw2dmFw?=
 =?utf-8?B?V3hmV0h1UFN6czQwTkJ3TVJLM2Fmc3E4U1F1NURzSkZZZm0zNHRIaktPNTBa?=
 =?utf-8?B?Y0I5VUlpSE14RkFFVzRGczd4eWh2VVR4RjV0YTFwalV0ZGxUVmhpc2M5eFZG?=
 =?utf-8?B?TTA0Zmg3U1d2N0hqWTJENjN0Y0UrMktNQ3NqVGdUdytGRldhbjc0eGtBSFlF?=
 =?utf-8?B?eVVDS0x5dmVIeEh6a0ovNlhGTUF1WXFuVFJSMTloc3k4ZktFbmVSL21SNUFh?=
 =?utf-8?B?YXpsSnZpNTc2aVQwa0dsTGNLT3pRMjcvWFNaZTFPNGJDQWM0UlUvcExCc3I3?=
 =?utf-8?B?a3Q5SkNyWk9HdFpEOXNFQkFGUUxpek80c0F5U3lsVzR4ZlQvNncvMU5abG5i?=
 =?utf-8?B?SWZlTGdJTUtHOVA5Y1hjQUk1SytmSnlsazcvcTEwbjFxQ1Rzdmk4S3l5Z1ZJ?=
 =?utf-8?B?SHErS0FuYWw5d2Y0cnZlMUQ3RS9zSjFSQlc2WGJ0eWhnTVMyVjU1UzBSSEEr?=
 =?utf-8?B?VUQzUlpvb09YMm5XV1VGVVllQTROdFlheWFLV3o5UG4rS2lqZml1b2owUFdS?=
 =?utf-8?B?TDJVajdxNzZaWFh6djQ5aTZaMVNiM1lwVXh1OUNoWGR0VjcrbVNsbk1jTnpk?=
 =?utf-8?B?RzQ3S21HZWJDWGVNTFVxQzJSd0lrcmliLytBSlhBRE1iZWk0SXladHoyUmQr?=
 =?utf-8?B?ZkJuNEZpYkR2a2hzQ3Y4TzZtV2NvL0xTbHNYK3dUVVNyUm90c1AvTmhjc1FR?=
 =?utf-8?B?TEwxaTIwQXNyam5aQi9XQ2l3Q1J4U0dKMVAvUThsRDNjaWdJN2tMYVJ0b2Jr?=
 =?utf-8?B?REIzZHlkTUZpaVZVS1R6V0NkMFBYaHYxQnpyMmJyL0l0aHRDamhzY1l3aUI1?=
 =?utf-8?B?VC9ieHVqa05KUjJ3clA2N3hWcTM1L2lZUEJqNTdXbCs1Q2N1RFg5b2xDTFlW?=
 =?utf-8?B?RmZrMGlnSkVkZGU0SUlENVVRSjdsUmR2WUlzY2I3a3RtejVqdkJqZGx4cjBr?=
 =?utf-8?B?VDQ0YVNxZ2xhOVRSV0xXbWd1dmhrQi8rRkZSSitYSndUTlZPcGYwL2llUlNB?=
 =?utf-8?B?WGtEWXovR21aSDRqbEQ4aDNvNTUvbWVzbjd6ZWtUbnFTSWxHUy9ZSVVtR3Nz?=
 =?utf-8?B?TTZuNURHYkRxbmM2MzFqNUR5dCs3SURRNkxNZ2lXdDRyK0lKeHBIbzlRK2hj?=
 =?utf-8?B?NzkzeVRDVGFEYzZ6SEtsZldHcXY1WGtSUXhHSk1YUndXUW9zWi8rTWRCRlM3?=
 =?utf-8?B?OFNXOU9ZYW81c21QaWpodGVadHlLUlhlRVJXWFRzTE1iOW5Ubm9NbWt3RGhV?=
 =?utf-8?B?R3I3dExWcXhDb1hha3lseHo2YktnZkxDcGhjQ1JXSXM2OVhlcFhROTExbHc4?=
 =?utf-8?B?MVFQaDJnWWRPT3A2MXZrOUpTMjBnWnBRMWdzbmNrZWtVeFVBZ2NyWTgwdkxZ?=
 =?utf-8?B?K2NEcCtEZVEyaVRyekhIdXBVT01IbS9BMFpwb1EyM1ZrUFE9PQ==?=
x-microsoft-antispam-prvs: <VI1PR04MB5680A6B16BA7510669BD29C491760@VI1PR04MB5680.eurprd04.prod.outlook.com>
x-forefront-prvs: 09634B1196
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(346002)(136003)(366004)(52314003)(189003)(199004)(13464003)(8676002)(8936002)(66066001)(316002)(9686003)(6506007)(305945005)(44832011)(6436002)(6636002)(446003)(105586002)(11346002)(256004)(53546011)(55016002)(486006)(5660300002)(81166006)(74316002)(81156014)(476003)(110136005)(229853002)(7736002)(71190400001)(71200400001)(86362001)(3846002)(6116002)(54906003)(97736004)(186003)(53936002)(99286004)(102836004)(68736007)(52536013)(2906002)(6246003)(26005)(76176011)(7696005)(478600001)(106356001)(93886005)(4326008)(14454004)(25786009)(33656002)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5680;H:VI1PR04MB3247.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HUS76+kOQz3sHsAFHr+oCHcLCgg7mtG6cq25AXYWkTjwiDvLXH0HVjpQ/woKGGGxwydv/NbAjFo3bvA4uQ7eulzv+g17YPiPCAmpI8/vIbOxCp991Lg0o3ZPC+ZQla96HVjT9VmMZoeSM2CYZirJxOpCI2r7ZTlf/urnspqDMOdyeuH8SNSZ/flCP/YELPyFe/axSuagDMwbqphyyxgRxEhaI/IyrPdfdi8yTXERdsfA8OJtukumPdZnmE5C0w3hKUo92iq8DBe/8AgP1qDNaKTGitrBzUxJJ8NMxV47xNJ4yvDe2sBhNSJRBqsaSBJm6mtkBbJeDpNRiVVGiY9ym9bcwnpDbr07+VPjB4/pvpAYKP7Mo5dkfrMQ70fRXrlmT3trJWpXUb0rWHomuEL6/jbOVkYer8EoQFLP2kPEOqY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 833b0ed5-aadb-42f9-8499-08d69e2a4f4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2019 09:43:07.4202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5680
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDEvMDMvMjAxOSAxNS41MO+8jFJhc211cyBWaWxsZW1vZXMgd3JvdGU6DQo+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJhc211cyBWaWxsZW1vZXMgPHJhc211cy52aWxs
ZW1vZXNAcHJldmFzLmRrPg0KPiBTZW50OiAyMDE55bm0M+aciDHml6UgMTU6NTANCj4gVG86IFFp
YW5nIFpoYW8gPHFpYW5nLnpoYW9AbnhwLmNvbT47IExlbyBMaSA8bGVveWFuZy5saUBueHAuY29t
Pg0KPiBDYzogU2NvdHQgV29vZCA8b3NzQGJ1c2Vycm9yLm5ldD47IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc7IFRpbXVyIFRhYmkNCj4gPHRpbXVyQGZyZWVzY2FsZS5jb20+OyBSYXNtdXMg
VmlsbGVtb2VzIDxSYXNtdXMuVmlsbGVtb2VzQHByZXZhcy5zZT4NCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCA0LzRdIHNvYy9mc2wvcWU6IHFlLmM6IHN1cHBvcnQgZnNsLHFlLXNudW1zIHByb3BlcnR5
DQo+IA0KPiBPbiAwMS8wMy8yMDE5IDA0LjM2LCBRaWFuZyBaaGFvIHdyb3RlOg0KPiA+IE9uIDIw
MTnlubQy5pyIMjjml6UgMTg6MzHvvIxSYXNtdXMgVmlsbGVtb2VzIHdyb3RlOg0KPiA+DQo+ID4+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IFJhc211cyBWaWxsZW1vZXMg
PHJhc211cy52aWxsZW1vZXNAcHJldmFzLmRrPg0KPiA+PiBTZW50OiAyMDE55bm0MuaciDI45pel
IDE4OjMxDQo+ID4+IFRvOiBRaWFuZyBaaGFvIDxxaWFuZy56aGFvQG54cC5jb20+OyBMZW8gTGkg
PGxlb3lhbmcubGlAbnhwLmNvbT4NCj4gPj4gQ2M6IFNjb3R0IFdvb2QgPG9zc0BidXNlcnJvci5u
ZXQ+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiA+PiBUaW11ciBUYWJpIDx0aW11
ckBmcmVlc2NhbGUuY29tPjsgUmFzbXVzIFZpbGxlbW9lcw0KPiA+PiA8UmFzbXVzLlZpbGxlbW9l
c0BwcmV2YXMuc2U+DQo+ID4+IFN1YmplY3Q6IFtQQVRDSCA0LzRdIHNvYy9mc2wvcWU6IHFlLmM6
IHN1cHBvcnQgZnNsLHFlLXNudW1zIHByb3BlcnR5DQo+ID4+DQo+ID4NCj4gPiBTbyB5b3UgZGVm
aW5lIDE0IHNudW1zIGZvciBNUEM4MzA5LCBidXQgdGhlcmUgc3RpbGwgYmUgdGhlIGNvbW1lbnQg
Ii8qDQo+ID4gTm8gUUUgZXZlciBoYXMgZmV3ZXIgdGhhbiAyOCBTTlVNcyAqLyIgYW5kIGl0IHdp
bGwgY2hlY2sgaWYgVGhlDQo+IG51bV9vZl9zbnVtcyAiaXMgPjI4IiwgaXQgd2lsbCBjYXVzZSBj
b25mdXNpb24sIHNvIEkgc3VnZ2VzdCB0byBtb2RpZnkgMjggdG8NCj4gMTQuDQo+IA0KPiBTdXJl
LCB0aGF0IG5lZWRzIHVwZGF0aW5nLiBNeSB0aGlua2luZyB3YXMgdGhhdCBvbmx5IGxlZ2FjeSBE
VHMgd291bGQgdXNlIHRoZQ0KPiBmc2wscWUtbnVtLXNudW1zLCBhbmQgdGhlcmUgd291bGQgYmUg
bm8gbmVlZCB0byBzdXBwb3J0IGxvd2VyIHZhbHVlcyB0aGFuDQo+IHdlIHVzZWQgdG8sIHNpbmNl
IHRoZSBsb2dpYyBiYWNrIGluIHFlX3NudW1zX2luaXQgd291bGRuJ3QgaGFuZGxlIHN1Y2ggdmFs
dWVzDQo+IGFwcHJvcHJpYXRlbHkgYW55d2F5Lg0KPiANCj4gPiBJIHJlYWQgdGhlIG9sZCB2ZXJz
aW9uIFFVSUNDIEVuZ2luZSBCbG9jayBSZWZlcmVuY2UgTWFudWFsLCBpdCBzYWlkDQo+ID4gc251
bXMgdGFibGUgaXMgbm90IGF2YWlsYWJsZSBvbiBNUEM4MzA2L01QQzgzMDZTL01QQzgzMDksIFNv
IEkgdGhpbmsNCj4gdGhlIGNvZGUgaXQgd3JpdHRlbiBsb25nIGJlZm9yZSB3aXRoIHRoaXMgdmVy
c2lvbiBSTSwgYW5kIGF0IHRoYXQgdGltZSwgdGhlDQo+IHNudW1zIGlzIGF0IGxlYXN0IDI4LCBh
bmQgbm9ib2R5IG1vZGlmeSB0aGUgY29kZSBsYXRlci4NCj4gPiBBbmQgbm93IHdpdGggdGhlIG5l
dyB2ZXJzaW9uIFJNLCBpdCBzdXBwb3J0DQo+IE1QQzgzMDYvTVBDODMwNlMvTVBDODMwOQ0KPiA+
IHdpdGggc251bXMgYW5kIGhhdmUgc251bXMgZmV3ZXIgdGhlbiAyOCwgc28gSSB0aGluayB0aGUg
bWluaW11bSB2YWx1ZQ0KPiBzaG91bGQgQmUgbW9kaWZpZWQgdG8gMTQuDQo+IA0KPiBZZXMuIEkn
bGwgZG8gYW4gZXh0cmEgY2xlYW51cCBwYXRjaCBtb2RpZnlpbmcgdGhlIGNvZGUgY29tbWVudHMg
YXBwcm9wcmlhdGVseS4NCj4gQnV0IHdoYXQgZG8geW91IHRoaW5rIGFib3V0IHRoZSBjb3JlIGlk
ZWEgYmVoaW5kIHRoaXMgY2hhbmdlIChhbmQgdGhlDQo+IHByZWNlZGluZyBjbGVhbnVwIHBhdGNo
ZXMpPw0KDQpNYXliZSB3ZSBjb3VsZCBtb2RpZnkgdGhlIGNvbW1lbnRzIGluIHRoaXMgcGF0Y2gs
IEFueXdheSwgdGhlIE1QQzgzMDYvTVBDODMwNlMvTVBDODMwOQ0KSXMgc3VwcG9ydGVkIHdpdGgg
c251bXMgYW5kIHRoZSBudW1iZXIgaXMgMTQsIEluIGFkZGl0aW9uLCB5b3UgYXNzaWduIHFlX251
bV9vZl9zbnVtIHRvIGkgYXMgYmVsb3cuDQpUaGUgdmFyaWFibGUgc3RhbmRzIGZvciBudW0gb2Yg
c251bXMuDQpPciB3ZSBjb3VsZCBhZGQgY29tbWVudHMgdG8gZXhwbGFpbiBpdCBjbGVhcmx5IHdo
eSBxZV9udW1fb2Zfc251bSBpcyBhc3NpZ24gdG8gYSB2YWx1ZSBmZXdlciB0aGFuIDI4DQpXaGls
ZSBpdCBzYXlzICIgTm8gUUUgZXZlciBoYXMgZmV3ZXIgdGhhbiAyOCBTTlVNcyAiLg0KDQorCXFl
ID0gcWVfZ2V0X2RldmljZV9ub2RlKCk7DQorCWlmIChxZSkgew0KKwkJaSA9IG9mX3Byb3BlcnR5
X3JlYWRfdmFyaWFibGVfdThfYXJyYXkocWUsICJmc2wscWUtc251bXMiLA0KKwkJCQkJCSAgICAg
ICBzbnVtcywgMTQsIFFFX05VTV9PRl9TTlVNKTsNCisJCW9mX25vZGVfcHV0KHFlKTsNCisJCWlm
IChpID4gMCkgew0KKwkJCXFlX251bV9vZl9zbnVtID0gaTsNCisJCQlyZXR1cm47DQorCQl9DQor
CX0gDQoNCkJlc3QgUmVnYXJkcw0KUWlhbmcgWmhhbw0K
