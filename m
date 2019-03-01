Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543EAC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 10:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F37E82087E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 10:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.se header.i=@prevas.se header.b="FtSHq8Hr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbfCAKV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 05:21:26 -0500
Received: from mail-eopbgr40133.outbound.protection.outlook.com ([40.107.4.133]:64229
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727920AbfCAKV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 05:21:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SRKxnkA7Nin8Rzx+mHc/X7p9rcoJig7EpBJsPYgpiw=;
 b=FtSHq8HrHQe1RgDhVks6w/0qeLjVIfrNgfjMzO3fYKEHlKQxrFxtNdXxNT//8R87ZYyqySHpyChZ8x26xmiA3MU0iaVb++jmGCOCfSGs0gHH4hi3pM8MlSdz5/Ni9nEZQdHPNXZAxg/ywsPOaMygw0mfODChqfA7mwEgFuKLg7Q=
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM (20.178.126.212) by
 VI1PR10MB2606.EURPRD10.PROD.OUTLOOK.COM (20.178.125.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.16; Fri, 1 Mar 2019 10:21:09 +0000
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d49:d85b:58bf:cd5b]) by VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d49:d85b:58bf:cd5b%6]) with mapi id 15.20.1643.022; Fri, 1 Mar 2019
 10:21:09 +0000
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Leo Li <leoyang.li@nxp.com>
CC:     Scott Wood <oss@buserror.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Timur Tabi <timur@freescale.com>,
        Rasmus Villemoes <Rasmus.Villemoes@prevas.se>
Subject: Re: [PATCH 4/4] soc/fsl/qe: qe.c: support fsl,qe-snums property
Thread-Topic: [PATCH 4/4] soc/fsl/qe: qe.c: support fsl,qe-snums property
Thread-Index: AQHUz1Co/Wp6EPz520CpARAl4seE16X2IT0AgABG+4CAAB9/gIAACp0A
Date:   Fri, 1 Mar 2019 10:21:08 +0000
Message-ID: <de425a29-58c6-b173-8c13-0d30ecfa96c0@prevas.dk>
References: <338677b2-ef74-2afc-4542-c66f1acdb7e5@prevas.dk>
 <20190228103026.9566-1-rasmus.villemoes@prevas.dk>
 <20190228103026.9566-5-rasmus.villemoes@prevas.dk>
 <VI1PR04MB324774864C3B7B44C41C232191760@VI1PR04MB3247.eurprd04.prod.outlook.com>
 <5528c093-12d2-16d3-1afd-73393d8d3b2f@prevas.dk>
 <VI1PR04MB32478E394D4722F08586F97091760@VI1PR04MB3247.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB32478E394D4722F08586F97091760@VI1PR04MB3247.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR06CA0158.eurprd06.prod.outlook.com
 (2603:10a6:7:16::45) To VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:e3::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Rasmus.Villemoes@prevas.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [81.216.59.226]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d184b15d-a379-49a2-5c21-08d69e2f9ef2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:VI1PR10MB2606;
x-ms-traffictypediagnostic: VI1PR10MB2606:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR10MB2606492F372D7E93ADE5BDFB8A760@VI1PR10MB2606.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 09634B1196
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(39850400004)(376002)(366004)(396003)(52314003)(199004)(189003)(13464003)(42882007)(44832011)(476003)(2616005)(15974865002)(186003)(446003)(11346002)(486006)(31686004)(68736007)(5660300002)(6116002)(3846002)(2906002)(99286004)(229853002)(8936002)(8976002)(53936002)(6512007)(6486002)(256004)(93886005)(6436002)(71190400001)(71200400001)(26005)(66066001)(305945005)(478600001)(8676002)(74482002)(105586002)(81166006)(31696002)(81156014)(72206003)(36756003)(110136005)(54906003)(97736004)(316002)(76176011)(52116002)(6506007)(53546011)(386003)(4326008)(106356001)(14454004)(107886003)(102836004)(7736002)(6246003)(25786009)(142933001)(18886075002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR10MB2606;H:VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: prevas.se does not designate
 permitted sender hosts)
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtWSTFQUjEwTUIyNjA2OzIzOnJCTkR1cnZMalpBZmVnMVpqNW9KYmxZdnpH?=
 =?utf-8?B?Wjg2b0ppWkRXVVJ1UHBwUWFnb1FiTWVQWk1HZ3QyY0tQblFEYXUxcDhCaElG?=
 =?utf-8?B?QWZKbVRjR0RGUlY5TmN1MTNGT1A0WDRiSTdPUU9jN3V2N0NBT3NiSE00WlRK?=
 =?utf-8?B?VVMzTEFSSkluYk1qajZWT0o0ZjhNUE5WRFoxVkw1SHo5dDdQZDdQbDNtUktm?=
 =?utf-8?B?bWVvUFAvMzNYREhwa0tmR0NCOG5JamZWRHNoeVZyM3RYMEtySEQrZWt2ZzJN?=
 =?utf-8?B?ZGZTSkJoQkN0ZUt5Zmk3M05IUU9wM2ZjcWRVSXE5Qk4wYXlxTmJvUHhvdTJw?=
 =?utf-8?B?eVVMeE1kT3dGU0tQeUZFQ1lob2RhQXpJOWV4ZDdzc1h1ZTgrdGtyc3IwNUFo?=
 =?utf-8?B?WGw4RnB6ckcrT0tnbUNsczUweWZxTXVZQXB3ZHBpWHRLTk8vM0RwTS8zQU13?=
 =?utf-8?B?S0FsR3FkQmVTc0VGVkFHcXFGQ2t6V2VkUjBNc3BDMzFyV2hQc1loaEZJQk1u?=
 =?utf-8?B?aytHK0dtU2VCblk0aEZhN3c2SUhBZGl6eDdvVldCWFA2U0pZMTRnanVHM2dZ?=
 =?utf-8?B?RllMSmI4L09jUGw4UWpncWxqMENkOGp6QTNIM29SUTZtYytkdE5CeEFMOEJq?=
 =?utf-8?B?MzNlQS8xUitoeWc5L1J3R3JqSzBIWld4N1VBSGVKbnJ2YWZuVW1pM3laYUFo?=
 =?utf-8?B?My9IUXFkaGo5SFpqbnVZNzNLRkdwMVRrZmM3Q0dLcjNFYVdxNXkwcGtNdUUx?=
 =?utf-8?B?NjZlSElDSlhxMWhlS3o3RUVuMGIwb3hUTHZmTkRpUDJiZldBcTFMTmkzQ3Vu?=
 =?utf-8?B?OEJnUmhqOW80OWtlWHVrRlNmSkUvUk9WUkxCbjdtU2hpOTlsSEdoaUVUTHZu?=
 =?utf-8?B?cnZlbjNCRVBrdHNsZ3JNaDU4SitLNFdOWlptZkN3VDVHWmRnWmllOW5UbVhV?=
 =?utf-8?B?SmxYMXlUUWpuS0lqOEZya3IxemNadkdoTitvR2dReDE1U1BIeFZyS05aNEtW?=
 =?utf-8?B?NXVWNlYyWktTQVV1eCt3L1BXazZvb0tmMUlyaktCejkwbDhGL0o3enlaSFdW?=
 =?utf-8?B?OHZQczF1MTVhbC9acVJESzJBVG90aTZ4RDJ1L0V1dGhQaFQvNXZmOFB4RXRk?=
 =?utf-8?B?YytFTEtNYUNncC9kUVkvbVF6RzJVSzl0T01sUDkvUHp6M1paVEZzWkpLM0RM?=
 =?utf-8?B?K2FHMTBIOXdkQ25tTnVlMTVNN1BQQ2NqcU00d1hyWGFnOFJBUmQ2NEFUdkpS?=
 =?utf-8?B?aEVDQ1JWdjcyeklxWHdXS1M0czJha04rRHhaMzZuNUFoRmdDSXVlaFh4bmVp?=
 =?utf-8?B?b0xyNi9URithbFg0U2lNUmozL1lmTnR5L3Fldm9NZkk5WUhUVmplSXo3b2xl?=
 =?utf-8?B?Y2hWNndmSnFTK3MvNHhMeXN1NG0yT2RnRFN4d2tUdWhYOWMzM0RPaEFIbmIz?=
 =?utf-8?B?Z2tKZTFEZWl4NHNwd3hOSGxWTkRQVFhTd3lZWElWMkhDRk1mL3dZbCswZXE4?=
 =?utf-8?B?ZCtHdktENDdWcWVQSGM1U2xRTnBPWGZDOXkrTUVXc0ZITDBFRXE4UHVTOWdL?=
 =?utf-8?B?Vnl6NkJQSllIRWg2UXdXY01IUW9Fa3d6blF1RURmV2U0VU11M2xEcG5CMlU0?=
 =?utf-8?B?YzVZQ2g4V240OTV5UnZ2V0hjTjUzbWRva1hkN1J4aHBCeXAweVNDZ2pRNGV2?=
 =?utf-8?B?N1ZZY05mZmpYSHJWM0tUSThXVmF6TDE4YWFEZTJNUGtxNFB0Z084cXhUWXp2?=
 =?utf-8?B?M0J4K2RYU2ZmU2hlUktZcFRSVGdRL2xsWVJUUEVFbjFaaHFxdVAxWkRzWEZJ?=
 =?utf-8?B?ZWI4U2kxVjhnUUlFZko1ZjdFQlZQWmhxbnNIWS9jR2VJcHNEdDA4Z1hRT2ov?=
 =?utf-8?B?U2VpTklqcEFjQUx6OWVrRVErNnlUQ1dNNFErSk9hWFgvajY3czZmK1JGd0Ru?=
 =?utf-8?B?Z3lnZERoR09TSUNsSXdZamF6VkFVRGI1bWpNT0xUR3M5V3Bvc0FPUGptRFNn?=
 =?utf-8?B?NXhWOWpUdmF0Yzg4b1A3UmVFa2hDTFYvVE5CSHorSWwvNkhrMVQ2SW1Jc2lu?=
 =?utf-8?Q?OMPY=3D?=
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FE6Csjo3FvYU+lwYwES0Rn5r4yNYdm4NvnSaQ6bi3SnT1U5PvRt8t3R9cp3dS8XYsxb7xqAjZrg++68Mo+3kqXAdoy2H6g72bGtHVswGBcQjnKQcpGrTFpfHvZeQUFT6308qvZEG3RV02xUoNkGRUi1rxH/gxQL6Dlkjsk9RDRop41q/pLae2EzgV/i4ZkDWmnfklvLpPlWqLWBTf3jdCk/PkI6NnlBUmRAm0WZFJVpyIwsQDPAMPctqK4Eufw9xQq/srB65uX4v9JWMXIvgMBnXS0N6u1uYgxnbzA1SVIVG4ysjiMV0ah9WUTcUTZEbepIRS+p2/YarYQpNUnSCaQ283xCfZzBmVc4EwDhXSOGnIxUEm+q84wQ0vkxG5ZL2eQMo2YQfBwMmSIDtLy7o47Kfy6QGpOMbgJe1XhTM2Qo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <063AB29CA18A264E95E987CED55CBDF4@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: d184b15d-a379-49a2-5c21-08d69e2f9ef2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2019 10:21:08.1194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2606
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDEvMDMvMjAxOSAxMC40MywgUWlhbmcgWmhhbyB3cm90ZToNCj4gT24gMDEvMDMvMjAxOSAx
NS41MO+8jFJhc211cyBWaWxsZW1vZXMgd3JvdGU6DQo+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPj4gRnJvbTogUmFzbXVzIFZpbGxlbW9lcyA8cmFzbXVzLnZpbGxlbW9lc0BwcmV2YXMu
ZGs+DQo+PiBTZW50OiAyMDE55bm0M+aciDHml6UgMTU6NTANCj4+IFRvOiBRaWFuZyBaaGFvIDxx
aWFuZy56aGFvQG54cC5jb20+OyBMZW8gTGkgPGxlb3lhbmcubGlAbnhwLmNvbT4NCj4+IENjOiBT
Y290dCBXb29kIDxvc3NAYnVzZXJyb3IubmV0PjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZzsgVGltdXIgVGFiaQ0KPj4gPHRpbXVyQGZyZWVzY2FsZS5jb20+OyBSYXNtdXMgVmlsbGVtb2Vz
IDxSYXNtdXMuVmlsbGVtb2VzQHByZXZhcy5zZT4NCj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggNC80
XSBzb2MvZnNsL3FlOiBxZS5jOiBzdXBwb3J0IGZzbCxxZS1zbnVtcyBwcm9wZXJ0eQ0KPj4NCj4+
IE9uIDAxLzAzLzIwMTkgMDQuMzYsIFFpYW5nIFpoYW8gd3JvdGU6DQo+Pj4gT24gMjAxOeW5tDLm
nIgyOOaXpSAxODozMe+8jFJhc211cyBWaWxsZW1vZXMgd3JvdGU6DQo+Pj4NCj4+Pj4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+Pj4gRnJvbTogUmFzbXVzIFZpbGxlbW9lcyA8cmFzbXVz
LnZpbGxlbW9lc0BwcmV2YXMuZGs+DQo+Pj4+IFNlbnQ6IDIwMTnlubQy5pyIMjjml6UgMTg6MzEN
Cj4+Pj4gVG86IFFpYW5nIFpoYW8gPHFpYW5nLnpoYW9AbnhwLmNvbT47IExlbyBMaSA8bGVveWFu
Zy5saUBueHAuY29tPg0KPj4+PiBDYzogU2NvdHQgV29vZCA8b3NzQGJ1c2Vycm9yLm5ldD47IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+Pj4+IFRpbXVyIFRhYmkgPHRpbXVyQGZyZWVz
Y2FsZS5jb20+OyBSYXNtdXMgVmlsbGVtb2VzDQo+Pj4+IDxSYXNtdXMuVmlsbGVtb2VzQHByZXZh
cy5zZT4NCj4+Pj4gU3ViamVjdDogW1BBVENIIDQvNF0gc29jL2ZzbC9xZTogcWUuYzogc3VwcG9y
dCBmc2wscWUtc251bXMgcHJvcGVydHkNCj4+Pj4NCj4+Pg0KPj4+IFNvIHlvdSBkZWZpbmUgMTQg
c251bXMgZm9yIE1QQzgzMDksIGJ1dCB0aGVyZSBzdGlsbCBiZSB0aGUgY29tbWVudCAiLyoNCj4+
PiBObyBRRSBldmVyIGhhcyBmZXdlciB0aGFuIDI4IFNOVU1zICovIiBhbmQgaXQgd2lsbCBjaGVj
ayBpZiBUaGUNCj4+IG51bV9vZl9zbnVtcyAiaXMgPjI4IiwgaXQgd2lsbCBjYXVzZSBjb25mdXNp
b24sIHNvIEkgc3VnZ2VzdCB0byBtb2RpZnkgMjggdG8NCj4+IDE0Lg0KPj4NCj4+IFN1cmUsIHRo
YXQgbmVlZHMgdXBkYXRpbmcuIE15IHRoaW5raW5nIHdhcyB0aGF0IG9ubHkgbGVnYWN5IERUcyB3
b3VsZCB1c2UgdGhlDQo+PiBmc2wscWUtbnVtLXNudW1zLCBhbmQgdGhlcmUgd291bGQgYmUgbm8g
bmVlZCB0byBzdXBwb3J0IGxvd2VyIHZhbHVlcyB0aGFuDQo+PiB3ZSB1c2VkIHRvLCBzaW5jZSB0
aGUgbG9naWMgYmFjayBpbiBxZV9zbnVtc19pbml0IHdvdWxkbid0IGhhbmRsZSBzdWNoIHZhbHVl
cw0KPj4gYXBwcm9wcmlhdGVseSBhbnl3YXkuDQo+Pg0KPj4+IEkgcmVhZCB0aGUgb2xkIHZlcnNp
b24gUVVJQ0MgRW5naW5lIEJsb2NrIFJlZmVyZW5jZSBNYW51YWwsIGl0IHNhaWQNCj4+PiBzbnVt
cyB0YWJsZSBpcyBub3QgYXZhaWxhYmxlIG9uIE1QQzgzMDYvTVBDODMwNlMvTVBDODMwOSwgU28g
SSB0aGluaw0KPj4gdGhlIGNvZGUgaXQgd3JpdHRlbiBsb25nIGJlZm9yZSB3aXRoIHRoaXMgdmVy
c2lvbiBSTSwgYW5kIGF0IHRoYXQgdGltZSwgdGhlDQo+PiBzbnVtcyBpcyBhdCBsZWFzdCAyOCwg
YW5kIG5vYm9keSBtb2RpZnkgdGhlIGNvZGUgbGF0ZXIuDQo+Pj4gQW5kIG5vdyB3aXRoIHRoZSBu
ZXcgdmVyc2lvbiBSTSwgaXQgc3VwcG9ydA0KPj4gTVBDODMwNi9NUEM4MzA2Uy9NUEM4MzA5DQo+
Pj4gd2l0aCBzbnVtcyBhbmQgaGF2ZSBzbnVtcyBmZXdlciB0aGVuIDI4LCBzbyBJIHRoaW5rIHRo
ZSBtaW5pbXVtIHZhbHVlDQo+PiBzaG91bGQgQmUgbW9kaWZpZWQgdG8gMTQuDQo+Pg0KPj4gWWVz
LiBJJ2xsIGRvIGFuIGV4dHJhIGNsZWFudXAgcGF0Y2ggbW9kaWZ5aW5nIHRoZSBjb2RlIGNvbW1l
bnRzIGFwcHJvcHJpYXRlbHkuDQo+PiBCdXQgd2hhdCBkbyB5b3UgdGhpbmsgYWJvdXQgdGhlIGNv
cmUgaWRlYSBiZWhpbmQgdGhpcyBjaGFuZ2UgKGFuZCB0aGUNCj4+IHByZWNlZGluZyBjbGVhbnVw
IHBhdGNoZXMpPw0KPiANCj4gTWF5YmUgd2UgY291bGQgbW9kaWZ5IHRoZSBjb21tZW50cyBpbiB0
aGlzIHBhdGNoLCBBbnl3YXksIHRoZSBNUEM4MzA2L01QQzgzMDZTL01QQzgzMDkNCj4gSXMgc3Vw
cG9ydGVkIHdpdGggc251bXMgYW5kIHRoZSBudW1iZXIgaXMgMTQsIEluIGFkZGl0aW9uLCB5b3Ug
YXNzaWduIHFlX251bV9vZl9zbnVtIHRvIGkgYXMgYmVsb3cuDQo+IFRoZSB2YXJpYWJsZSBzdGFu
ZHMgZm9yIG51bSBvZiBzbnVtcy4NCg0KWWVzLCBidXQgSSBjYW4ndCBhc3NpZ24gaXQgZGlyZWN0
bHksIGJlY2F1c2UgcWVfbnVtX29mX3NudW0gaXMgdW5zaWduZWQsDQphbmQgSSBuZWVkIHRvIHRl
c3Qgd2hldGhlciB0aGUgcmV0dXJuIHZhbHVlIGlzIG5lZ2F0aXZlLg0KDQo+IE9yIHdlIGNvdWxk
IGFkZCBjb21tZW50cyB0byBleHBsYWluIGl0IGNsZWFybHkgd2h5IHFlX251bV9vZl9zbnVtIGlz
IGFzc2lnbiB0byBhIHZhbHVlIGZld2VyIHRoYW4gMjgNCj4gV2hpbGUgaXQgc2F5cyAiIE5vIFFF
IGV2ZXIgaGFzIGZld2VyIHRoYW4gMjggU05VTXMgIi4NCg0KT0ssIEknbGwgZm9sZCBpbiBzb21l
IGNvbW1lbnQgdXBkYXRpbmcgaW4gYSB2MiBwYXRjaC4NCg0KPiANCj4gKwlxZSA9IHFlX2dldF9k
ZXZpY2Vfbm9kZSgpOw0KPiArCWlmIChxZSkgew0KPiArCQlpID0gb2ZfcHJvcGVydHlfcmVhZF92
YXJpYWJsZV91OF9hcnJheShxZSwgImZzbCxxZS1zbnVtcyIsDQo+ICsJCQkJCQkgICAgICAgc251
bXMsIDE0LCBRRV9OVU1fT0ZfU05VTSk7DQo+ICsJCW9mX25vZGVfcHV0KHFlKTsNCj4gKwkJaWYg
KGkgPiAwKSB7DQo+ICsJCQlxZV9udW1fb2Zfc251bSA9IGk7DQo+ICsJCQlyZXR1cm47DQo+ICsJ
CX0NCj4gKwl9IA0KDQpBY3R1YWxseSwgcHV0dGluZyBpbiBhIGxvd2VyIGJvdW5kIG9mIDE0IGhl
cmUgaXMgYSBtaXN0YWtlIC0gaXQgc2hvdWxkDQpqdXN0IGJlIDEsIGFuZCB0aGVuIHRoZSBjb2Rl
IHdvdWxkIGFsc28gd29yayBmb3IgYW55IFFFIHZhcmlhbnQgdGhhdA0KbWlnaHQgYmUgc2hpcHBl
ZCBpbiB0aGUgZnV0dXJlLiBJdCdzIHVwIHRvIHRoZSBEVCBhdXRob3IgdG8gbWFrZSBzdXJlDQp0
aGUgZGF0YSBpcyBjb3JyZWN0Lg0KDQpDYW4geW91IGZpZ3VyZSBvdXQgd2h5IHRoZSBvbGQgY29k
ZSBkZWZhdWx0cyB0byAyOCwgYW5kIHdoeSBpdHMgb2sgZm9yDQphbGwgdGhvc2UgdmFyaWFudHMg
dG8ganVzdCBlbmQgdXAgdXNpbmcgdGhlIGZpcnN0IDI4IGVsZW1lbnRzIG9mIHRoZSBfNDYNCmFy
cmF5PyBXaGF0J3MgdGhlIHB1cnBvc2Ugb2YgdGhvc2Ugc3VycGx1cyAxOCBlbGVtZW50cz8NCg0K
UmFzbXVzDQoNCg0KDQo+IEJlc3QgUmVnYXJkcw0KPiBRaWFuZyBaaGFvDQo+IA0KDQoNCi0tIA0K
UmFzbXVzIFZpbGxlbW9lcw0KU29mdHdhcmUgRGV2ZWxvcGVyDQpQcmV2YXMgQS9TDQpIZWRlYWdl
ciAzDQpESy04MjAwIEFhcmh1cyBODQorNDUgNTEyMTAyNzQNCnJhc211cy52aWxsZW1vZXNAcHJl
dmFzLmRrDQp3d3cucHJldmFzLmRrDQo=
