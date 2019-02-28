Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1C3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7126B2171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.se header.i=@prevas.se header.b="fxnhMnO8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732007AbfB1ILf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 03:11:35 -0500
Received: from mail-eopbgr80113.outbound.protection.outlook.com ([40.107.8.113]:34944
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725949AbfB1ILf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 03:11:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7tq2Q53OfIoVRbfH1BWDj7K7A8l+/EJPHvne59hTvjo=;
 b=fxnhMnO8jsFglumH6tThkNvwgfavEB2hED/Ru99r7mlVjl4EgeLF1aeKKcFo1gfY90J1NdLtkj3pjYOGXykyJF0TfQxKlyK8yHj8za8XA3+jE91qk2KAJMMKyfA1WR2k0V1FuidG72vsj/nK2ivWhNdblgMu2IuV8OVxqYR6IQA=
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM (20.178.126.212) by
 VI1PR10MB0541.EURPRD10.PROD.OUTLOOK.COM (10.167.201.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.16; Thu, 28 Feb 2019 08:11:28 +0000
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d49:d85b:58bf:cd5b]) by VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d49:d85b:58bf:cd5b%6]) with mapi id 15.20.1643.022; Thu, 28 Feb 2019
 08:11:28 +0000
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Leo Li <leoyang.li@nxp.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Valentin Longchamp <valentin.longchamp@keymile.com>,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <Rasmus.Villemoes@prevas.se>
Subject: Re: [RFC PATCH] soc/fsl/qe: support MPC8309
Thread-Topic: [RFC PATCH] soc/fsl/qe: support MPC8309
Thread-Index: AQHUzbALXjDeDpgRFU++rfaOQW65LqX0y9nggAATLIA=
Date:   Thu, 28 Feb 2019 08:11:28 +0000
Message-ID: <338677b2-ef74-2afc-4542-c66f1acdb7e5@prevas.dk>
References: <20190226084816.20535-1-rasmus.villemoes@prevas.dk>
 <VI1PR04MB32475CFE4827D2141262D34E91750@VI1PR04MB3247.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB32475CFE4827D2141262D34E91750@VI1PR04MB3247.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0371.eurprd05.prod.outlook.com
 (2603:10a6:7:94::30) To VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:e3::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Rasmus.Villemoes@prevas.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [81.216.59.226]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b90d9035-f7bc-4aea-e6ba-08d69d5456fc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:VI1PR10MB0541;
x-ms-traffictypediagnostic: VI1PR10MB0541:
x-microsoft-antispam-prvs: <VI1PR10MB0541D4FFA44A3E2CC37E48298A750@VI1PR10MB0541.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(346002)(39850400004)(366004)(396003)(199004)(189003)(13464003)(6246003)(110136005)(2906002)(316002)(4326008)(74482002)(81156014)(81166006)(8676002)(102836004)(6116002)(3846002)(107886003)(54906003)(99286004)(53546011)(52116002)(25786009)(76176011)(5660300002)(6506007)(386003)(36756003)(256004)(68736007)(6486002)(97736004)(476003)(486006)(44832011)(105586002)(229853002)(6512007)(66066001)(31686004)(6436002)(71190400001)(71200400001)(305945005)(14454004)(186003)(7736002)(106356001)(42882007)(8976002)(26005)(446003)(2616005)(53936002)(31696002)(8936002)(11346002)(478600001)(72206003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR10MB0541;H:VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: prevas.se does not designate
 permitted sender hosts)
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtWSTFQUjEwTUIwNTQxOzIzOkk1Z2NyVGM2bCtWNDI5Y1IzSmVxVU5BdGJ6?=
 =?utf-8?B?aEhWdXdrNGI4QVk4cVpQNk9pOVJheGliZ2lodEg0OTJnMmlPeWpJYmpUblVn?=
 =?utf-8?B?emY5bjFIWUM3YjVDb1dSS0V5Y0w5Q2d1dTRYUStXaUFWY1BjM1E4NlRnZWl0?=
 =?utf-8?B?SGZVMWp2d1hhSTk3aVZ1VURvNW9Rb1JhWDRENVlhQk42anA2ZW9oelYxVG5T?=
 =?utf-8?B?bDh4NzdQVkt3YlhUcVJ5NHE0NWVkVEQ3TVNidC9GTy8wZUVTV3g4Z3lYYUlC?=
 =?utf-8?B?ajJBZE0xaS8xcmx2TWlSaGtVdlUzT1JQRGhpd2t6SEZLSG5oYVNnR29MTlVl?=
 =?utf-8?B?OWs5eEZJM0svbnltaThMQnJ3U3FUZlBIK2NUWjl5dTN3M2N3VFhnSjk3OUtY?=
 =?utf-8?B?K2t3Vm9RMHpjMDBVNFVhZmlnQzV6RlQyc2hsREdSZ2x1T3hrZVFpY0tNT2RO?=
 =?utf-8?B?eFY5NHBPRWF4MGl4bWV5Vkp6WTVMNDNxODhvRkRwS3JYWWdFdUZ2UnkwU0JG?=
 =?utf-8?B?bncrRThsc3JsMDBmajBTci9tbnB0TW1GS3FrS1dJRngxS2xZdEdXMWwvNmFQ?=
 =?utf-8?B?NTRxMzNrSVhydlZXc0RyTkVBL0lRejJyZ0piZGo4T01qNldUNTlYQTgxaEFk?=
 =?utf-8?B?bkhyUUZKTWlNNnhtZFc4Z1pvWUt2MGFPRm9acHRRRHVMVm5ZaFlTSXdXTzFW?=
 =?utf-8?B?d1FVaENTTm1CdW0xcDJOL25SNC9SbjRyTEtCMUhwM2ZqSk5jYXpwczVFSjEw?=
 =?utf-8?B?WjMrUnFSVnc4QlJrZnZyTUVKLzJJMklod1VkaWFiRVdROWJoRmpzZ3dNOVMx?=
 =?utf-8?B?bjUvK1JqRENhSkNvZjYyOGRGdHNrTjJ1RmtvV2FYMkhBcHpJZW5OdTA0U0w3?=
 =?utf-8?B?Q2g4Z2FvZ2hWS3JPOS9IcDNCS1pGRVluUTY3VVVPMFJPTmVjMlV0Q3d2SEtK?=
 =?utf-8?B?L0V5VW5vV2k0VExPQ3FnZFdQK2VpTTh1eVJtUnRpOVlVeHg1cTZJVFNoWGx5?=
 =?utf-8?B?NmR3VVk5cmpiNkJwWEJKRklDVG9BTlYzYUlnNmFOcnAxS2xtQXltUVpPZ25h?=
 =?utf-8?B?L3oza3pZN3NHZmkrRm4wM1ZacGZaQ055UXlLVHg2TWRBWEdqWnRIVWd2akMw?=
 =?utf-8?B?dWxNU1VpOVU4YU5TRXl6dzNpckJvR2RHcFdpSWRqVEZZU3BWWEVhNFVOL2wz?=
 =?utf-8?B?TG5YRm1yS0k5VUVYTHZVT01oZ1VMTVlYMWhGb3pUMS9nWGZpSEhua1B2Y1dC?=
 =?utf-8?B?d1NMblliQ1NPSUJzUmMvMGUxVTdvTmtCUytPRExDdUduYmh2Vm82aEY5Y0dF?=
 =?utf-8?B?STdyeXFRWFZyMFoxZHJwQmlhczdmdnBncFIyNEI3ZDByclY2NzlRY3hxU3dX?=
 =?utf-8?B?c2h6RWxRZzh5ZCs5bWVSeXY4b3dSMUNkTjBMTjJpNzdDT1RyYU56Skd3dXRL?=
 =?utf-8?B?NFNRWUplRmFJMzNhTk5qK2JLZnVwUXAzZGRNdUxtd2NRcXJIbmRyNEhtU2Vk?=
 =?utf-8?B?TGdla0pTNzN2RHN5ekxNeW1JR3Nudk5FMHRyK1k2YlRDZ0dCYVdVTGFJMVRs?=
 =?utf-8?B?WTVjYWl6SlNTRVFJbUZvbnZGM0V1a0o0L3lldHRSbmZhUzRVaUkwcU10Z3dC?=
 =?utf-8?B?Sll4U2V5Zi9Ycm5CSVlHZUxuNmd2ZHhuTGJDemdnTlRBU21kOW1kZjhickZo?=
 =?utf-8?B?RWdFd1c1S05FOCszZXpJSE9pNjN3UXNQRzJlRURGSnhWL0NLa2xIdko4NmYz?=
 =?utf-8?B?Q1RNWWNmQVhIWkx0Yys2Tis1THYvYzNRZnZla1ZSRk45OHhURmdCcVEvNWFB?=
 =?utf-8?B?TjZOdkFiQjlUTlhPMGFEUXhKcm5ybUlBV2d1RW5qbWZIOEdoM2tCTCsyR3N6?=
 =?utf-8?Q?vjsrSnWWEDBtWud5U23DY6q2txnGK4x/?=
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: z4ZKauQ4e6JLNta11YpsEuXMcVbN32Rr/o4BTUotFN95+awjbqVrBIM+24LVud7nGYSBni7Ur3b8SCqr6wTdU6kguxv1Y6YwG+2vbhta4EdS+AJb3/3e6wewh2VuBbIcp+Lf6zlaxsZXidoAMAc/kNvPa96mG/21FYMaiVWDXVk7KMUghmVXDWf5r7l0v7GgJD5ULkKNqC3brdKMiT7aC57TmSrYyLHY5CziH0hcAyMZmYGBFxUQ7E1IxA1N6Sr/5537P5vspKcGz9t0H0rpffg7Ktt1C7v3BXNxlPhQ19nV0PfrDofX1d4m47c0qkoB0inVa3J6SpZ8NfOqLe6PbbUVUQ58zkU25okAR3jhs9udWjiFohF7y5zCqjaJfHLZwtIdVmpyYkZd/70r6qLApin+1JOSMrQcDNvTUC9xa7c=
Content-Type: text/plain; charset="utf-8"
Content-ID: <27A7684918F9614F82E4904FAB966524@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: b90d9035-f7bc-4aea-e6ba-08d69d5456fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 08:11:27.6258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB0541
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjgvMDIvMjAxOSAwOC4xNCwgUWlhbmcgWmhhbyB3cm90ZToNCj4gT24gVHVlLCBGZWIgMjYs
IDIwMTkgYXQgMjo0OSBBTSBSYXNtdXMgVmlsbGVtb2VzIDxyYXNtdXMudmlsbGVtb2VzQHByZXZh
cy5kaz4gd3JvdGU6DQo+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4gRnJvbTogUmFz
bXVzIFZpbGxlbW9lcyA8cmFzbXVzLnZpbGxlbW9lc0BwcmV2YXMuZGs+DQo+PiBTZW50OiAyMDE5
5bm0MuaciDI25pelIDE2OjQ4DQo+PiBUbzogUWlhbmcgWmhhbyA8cWlhbmcuemhhb0BueHAuY29t
PjsgTGVvIExpIDxsZW95YW5nLmxpQG54cC5jb20+DQo+PiBDYzogbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgVmFsZW50aW4gTG9uZ2NoYW1wDQo+PiA8dmFsZW50aW4ubG9uZ2NoYW1wQGtl
eW1pbGUuY29tPjsgU2NvdHQgV29vZCA8b3NzQGJ1c2Vycm9yLm5ldD47DQo+PiBSYXNtdXMgVmls
bGVtb2VzIDxSYXNtdXMuVmlsbGVtb2VzQHByZXZhcy5zZT4NCj4+IFN1YmplY3Q6IFtSRkMgUEFU
Q0hdIHNvYy9mc2wvcWU6IHN1cHBvcnQgTVBDODMwOQ0KPj4NCj4+IEN1cnJlbnRseSwgd2hlbiBk
ZXZpY2UgdHJlZSBzcGVjaWZpZXMgZnNsLHFlLW51bS1zbnVtcyA9IDI4ICh3aGljaCBhIG51bWJl
cg0KPj4gb2YgaW4tdHJlZSAuZHRzIGZpbGVzIGRvLCBhbmQgd2hpY2ggaXMgdGhlIGRlZmF1bHQg
d2hlbiB0aGF0IHByb3BlcnR5IGlzIG1pc3NpbmcpLA0KPj4gcWVfc251bXNfaW5pdCgpIGVuZHMg
dXAgdXNpbmcgdGhlIGZpcnN0IDI4IGVsZW1lbnRzIG9mIHRoZSBzbnVtX2luaXRfNDZbXQ0KPj4g
YXJyYXkuDQo+Pg0KPj4gVGhlIHNpdHVhdGlvbiBpcyBxdWl0ZSBtZXNzeS4gVGhpcyBwYXRjaCBt
YXkgYnJlYWsgZXhpc3Rpbmcgc2V0dXBzIHRoYXQgZm9yDQo+PiBzb21lIHJlYXNvbiB3b3JrIHdp
dGggc3BlY2lmeWluZyBmc2wscWUtbnVtLXNudW1zID0gMjggYW5kIHVzaW5nIHRoZQ0KPj4gZXhp
c3Rpbmcgc251bV9pbml0XzQ2IGFycmF5LiBPVE9ILCB0aGUgY3VycmVudCBjb2RlIGNlcnRhaW5s
eSBkb2VzIG5vdCB3b3JrDQo+PiBmb3IgdGhlIE1QQzgzMDktYmFzZWQgYm9hcmQgd2UncmUgd29y
a2luZyBvbiwgc2luY2UgdGhlIGZpcnN0IDE0IG9mIHRoZQ0KPj4gZWxlbWVudHMgaW4gc251bV9p
bml0XzQ2IGFyZSAiTm90IGF2YWlsYWJsZSBvbg0KPj4gTVBDODMwNi9NUEM4MzA2Uy9NUEM4MzA5
IiBhY2NvcmRpbmcgdG8gdGhlIFFVSUNDIEVuZ2luZSBSZWZlcmVuY2UNCj4+IE1hbnVhbCAoVGFi
bGUgNC0zMCkgLSBhbmQgaW5kZWVkLCB3aXRob3V0IHRoaXMgcGF0Y2ggKG9yIHNvbWV0aGluZyB0
byB0aGUNCj4+IHNhbWUgZWZmZWN0KSwgd2UgZ2V0DQo+IA0KPiBBY2NvcmRpbmcgdG8gdGhlIFFV
SUNDIEVuZ2luZSBSZWZlcmVuY2UgTWFudWFsIChUYWJsZSA0LTMwKSwgdGhlIG51bWJlciBvZiBz
bnVtcyB1c2VkIGZvciANCj4gIiBNUEM4MzA2L01QQzgzMDZTL01QQzgzMDkiIHNob3VsZCBiZSAx
NCBpbnN0ZWFkIG9mIDI4LCBzbyBtYXliZSB3ZSBzaG91bGQgYXNzaWduICJmc2wscWUtbnVtLXNu
dW1zID0gMTQiDQo+IEFuZCBkZWZpbmUgYSBuZXcgc251bV9pbml0XzE0IGFycmF5LCBtZWFud2hp
bGUsIG1vZGlmeSB0aGUgbWluaW11bSB2YWx1ZSBvZiAibnVtX29mX3NudW1zIiB0byAxNCBpbiBm
dW5jdGlvbiAicWVfZ2V0X251bV9vZl9zbnVtcyINCj4gKEkgbWVhbjogIiBpZiAoKG51bV9vZl9z
bnVtcyA8IDE0KSB8fCAobnVtX29mX3NudW1zID4gUUVfTlVNX09GX1NOVU0pKSB7IikNCg0KUGVy
aGFwcywgYnV0IGl0J3MgY29tcGxldGVseSB1bmNsZWFyIHRvIG1lIHdoeSB0aGUgY29kZSB3b3Vs
ZCBjb250YWluIGENCmNvbW1lbnQgLyogTm8gUUUgZXZlciBoYXMgZmV3ZXIgdGhhbiAyOCBTTlVN
cyAqLyB3aGVuIHRoYXQgdGhlbiBhcHBlYXJzDQp0byBiZSB3cm9uZy4gSXQgaXMgYWxzbyBmYXIg
ZnJvbSBjbGVhciB3aHkgdGhlIHNudW1zIHN1Y2ggYXMgMHgwOCwgMHgwOQ0KZXRjLiB0aGF0IGFw
cGVhciBpbiB0YWJsZSA0LTMwIHdpdGhvdXQgYW55IGFzc2lnbmVkIG1lYW5pbmcgZG8gYXBwZWFy
IGluDQp0aGUgZXhpc3Rpbmcgc251bV9pbml0XzQ2IHRhYmxlIC0gYnV0IG9mIGNvdXJzZSwgdGhv
c2UgZWxlbWVudHMgb2YgdGhhdA0KYXJyYXkgZG9uJ3QgY3VycmVudGx5IGhhcHBlbiB0byBiZSB1
c2VkIHdoZW4gcWVfZ2V0X251bV9vZl9zbnVtcz09MjgNCihidXQgdGhleSBkbyBnZXQgdXNlZCBm
b3IgZS5nLiBtcGM4NTY5IHdoaWNoIHNwZWNpZmllcyBmc2wscWUtbnVtLXNudW1zPTQ2KS4NCg0K
QWx0b2dldGhlciwgSSB0aGluayBpdCdzIGEgY29tcGxldGVseSB3cm9uZyBhcHByb2FjaCB0byBw
cmV0ZW5kIHRoYXQgdGhlDQpfc2V0IG9mIHZhbGlkIHNudW1zXyBpcyBhIGZ1bmN0aW9uIG9mIHRo
ZSBfbnVtYmVyIG9mIHNudW1zXyBhbG9uZSAtIHRoZQ0KZm9vdG5vdGVzIHRvIHRhYmxlIDQtMzAg
bWFrZSBpdCBhYnVuZGFudGx5IGNsZWFyIHRoYXQgb25lIHJlYWxseSBjYW5ub3QNCmV4cGVjdCBz
dWNoIGEgc2ltcGxlIHJlbGF0aW9uc2hpcC4NCg0KU28sIEkgc3VnZ2VzdCBkZXByZWNhdGluZyB0
aGUgZnNsLHFlLW51bS1zbnVtcyBiaW5kaW5nLCBpbiBmYXZvciBvZiBhDQptb3JlIHNlbnNpYmxl
DQoNCmZzbCxxZS1zbnVtcyA9IC9iaXRzLyA4IDwweDg4IDB4ODkgMHg5OCAweDk5IC4uLj4NCg0K
d2hpY2ggd2lsbCBhdXRvbWF0aWNhbGx5IGVuY29kZSBib3RoIHRoZSBudW1iZXIgb2Ygc251bXMg
YXMgd2VsbCBhcyB0aGUNCmNvbmNyZXRlIHZhbHVlcyB0byBiZSB1c2VkLg0KDQpSYXNtdXMNCg==
