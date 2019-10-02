Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46382C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 13:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0755B21A4A
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 13:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IXfx3BwD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfJBNLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 09:11:42 -0400
Received: from mail-eopbgr820075.outbound.protection.outlook.com ([40.107.82.75]:19407
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725860AbfJBNLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 09:11:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pyhxkm88diybtDHUOtCzuaK/37zfKSuDZeAEc6iaus37HxMuSSVy1jNpGalKwRKBiikTrL8AR+Pp0fipSKQl0mIDkHOKiqKb6tTpc0BA1WMh3i3k5YLGWTvV3ZdtGKM72CczrdJdbWKf6XcFTKXuUONjaqC6qRFKbn0vV1E7qnscvLkdtCc9ozTtsTd/cg2msfJM/yOR1S+XjkyI4sHs4hMdzPEabuIk2B6Hmrwaz1ZhhvjyGnzOmHSpT9k/P1nRFXfXot0zNFJCCwfcATRo4QAjar5qGcQ6Qjr4VK5aM1qMN6yPmKux09uWphsHk/m93KHNjEhJsO9ew9GgokbX3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PD07Va/9+y914VgEDJb2rG+ZgMoSIIweZWHEHvUJvUQ=;
 b=CYeZB6Wmtj2rFILxTKs/xRFpslQ5ny4mA9fFpbIo4hjgzDuRdAbq8F6IQg8QPmL3SV0mhx4LpVwxpkDbb37WBBlezkYLVrOvRkxcSz6imNSF9l2lk0S5isMqBhosbpyT2juw/FOH9OoIgSd6izET/awP5b/xwHocJOp/gl1Br+eDMKd2EybN9tNC+yDpLAuQMJPYqvBQ+XE9gKvAMcAhW9IIYLaHCpJsnWGdBU2ifa+1cPgmIaj6jVdO8fKrLR4rS8IEV7zMAORbQA83svSYjRchqRrAm2CUiU/PWIghiSWFp+q8NbI9ERdYebtRaQgHo/tMAvD44hF1WSsz9bff4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PD07Va/9+y914VgEDJb2rG+ZgMoSIIweZWHEHvUJvUQ=;
 b=IXfx3BwDYceBuUFXAfKFPPV/2H3tszv+KH5ZoXCtS8UUDq4oCXMNVd9Cib7/761IC27m/Q+5SPrQzf8iSziarviMCVQL6WuwjQJxPyBYJDbHkn/PYeOHWdvbnVug5injcSeaC72tyQaNsFET20nd4ghOBGuSh5tjuyA/nvJQy0g=
Received: from BN6PR12MB1809.namprd12.prod.outlook.com (10.175.101.17) by
 BN6PR12MB1268.namprd12.prod.outlook.com (10.168.226.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Wed, 2 Oct 2019 13:11:37 +0000
Received: from BN6PR12MB1809.namprd12.prod.outlook.com
 ([fe80::418d:e764:3c12:f961]) by BN6PR12MB1809.namprd12.prod.outlook.com
 ([fe80::418d:e764:3c12:f961%10]) with mapi id 15.20.2305.023; Wed, 2 Oct 2019
 13:11:37 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     "RAVULAPATI, VISHNU VARDHAN RAO" 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>,
        "Mehta, Sanju" <Sanju.Mehta@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/7] ASoC: amd: Registering device endpoints using MFD
 framework
Thread-Topic: [PATCH 2/7] ASoC: amd: Registering device endpoints using MFD
 framework
Thread-Index: AQHVd5gywJvnY+WwrkWUotR2w3skaqdFWHuAgAA2g4CAACFpAIAAct1AgAEp/YCAAAfXMA==
Date:   Wed, 2 Oct 2019 13:11:37 +0000
Message-ID: <BN6PR12MB1809451A3152488F3D8D1371F79C0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1569891524-18875-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <1569891524-18875-2-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <20191001064539.GB11769@dell> <2ff13a61-a346-4d49-ab3a-da5d2126727c@amd.com>
 <20191001120020.GC11769@dell>
 <BN6PR12MB180930BD7D03FD7DEB14D7C1F79D0@BN6PR12MB1809.namprd12.prod.outlook.com>
 <20191002123759.GD11769@dell>
In-Reply-To: <20191002123759.GD11769@dell>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [165.204.11.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8036b446-7897-4b19-cd92-08d7473a0e72
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: BN6PR12MB1268:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR12MB126868E3AD54F7721D79E040F79C0@BN6PR12MB1268.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0178184651
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(366004)(136003)(396003)(376002)(189003)(199004)(13464003)(14454004)(74316002)(305945005)(316002)(8676002)(52536014)(256004)(54906003)(5660300002)(99286004)(6916009)(33656002)(81156014)(81166006)(7736002)(2906002)(6506007)(6436002)(53546011)(8936002)(55016002)(64756008)(66476007)(66556008)(66446008)(486006)(66946007)(229853002)(26005)(102836004)(76116006)(6246003)(9686003)(86362001)(11346002)(6116002)(3846002)(186003)(66066001)(71190400001)(71200400001)(7696005)(25786009)(476003)(4326008)(478600001)(76176011)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1268;H:BN6PR12MB1809.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1EpR3h00UBdCYhSXbz8/n0wPEe1DDUwgLzRdkt72tOdtpD10cBzqaFClKUNTAJzIiCYaWeZtpt+dTjkGz/i6beSYiQoCrvAPepEJFcR4OwwuiXZ++by1tRrfWz8zJ6/YczaIcr+3/NIGoRkD3zMe37diXNp6V79y0L4vgOdJ+RWHx7YwcwqqsrQdiFEPmrfUqbygdk/focuctSs3/bjZp6D9yTL2f0E9Skwv8ZPV+5cFL5bp6psj1/z7HLOFP3C/B9qJufcHwXs+6Y5xLJLn4ztl7f1YALBhPp8CGDnjP/JGBx9ONDk9Poft34V6UTydg3LSufLkQd2QCG5g38ULB/EMnIr+1SauqTuCj2X0FzIgCdRCe4wN+w2jnbI65YYr2ouRwc0jSLdeYn7MEHmrvipme6GXILtxEIv+5VHGCNQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8036b446-7897-4b19-cd92-08d7473a0e72
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2019 13:11:37.1065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BDPKoc6mlmravNEul9yc3TYislK29Wo3atjJtfouGxVGY67k2LQQ1jGm1f5rkQ980s2Nw/KJI1wZ2YDFtNEMvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1268
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMZWUgSm9uZXMgPGxlZS5qb25l
c0BsaW5hcm8ub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIE9jdG9iZXIgMiwgMjAxOSA4OjM4IEFN
DQo+IFRvOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQo+
IENjOiBSQVZVTEFQQVRJLCBWSVNITlUgVkFSREhBTiBSQU8NCj4gPFZpc2hudXZhcmRoYW5yYW8u
UmF2dWxhcGF0aUBhbWQuY29tPjsgTGlhbSBHaXJkd29vZA0KPiA8bGdpcmR3b29kQGdtYWlsLmNv
bT47IE1hcmsgQnJvd24gPGJyb29uaWVAa2VybmVsLm9yZz47IEphcm9zbGF2DQo+IEt5c2VsYSA8
cGVyZXhAcGVyZXguY3o+OyBUYWthc2hpIEl3YWkgPHRpd2FpQHN1c2UuY29tPjsgTXVrdW5kYSwN
Cj4gVmlqZW5kYXIgPFZpamVuZGFyLk11a3VuZGFAYW1kLmNvbT47IE1hcnV0aGkgU3Jpbml2YXMg
QmF5eWF2YXJhcHUNCj4gPE1hcnV0aGkuQmF5eWF2YXJhcHVAYW1kLmNvbT47IE1laHRhLCBTYW5q
dQ0KPiA8U2FuanUuTWVodGFAYW1kLmNvbT47IENvbGluIElhbiBLaW5nIDxjb2xpbi5raW5nQGNh
bm9uaWNhbC5jb20+OyBEYW4NCj4gQ2FycGVudGVyIDxkYW4uY2FycGVudGVyQG9yYWNsZS5jb20+
OyBtb2RlcmF0ZWQgbGlzdDpTT1VORCAtIFNPQyBMQVlFUg0KPiAvIERZTkFNSUMgQVVESU8gUE9X
RVIgTUFOQUdFTS4uLiA8YWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnPjsNCj4gb3BlbiBsaXN0
IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDIv
N10gQVNvQzogYW1kOiBSZWdpc3RlcmluZyBkZXZpY2UgZW5kcG9pbnRzIHVzaW5nIE1GRA0KPiBm
cmFtZXdvcmsNCj4gDQo+IE9uIFR1ZSwgMDEgT2N0IDIwMTksIERldWNoZXIsIEFsZXhhbmRlciB3
cm90ZToNCj4gDQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTog
TGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4NCj4gPiA+IFNlbnQ6IFR1ZXNkYXksIE9j
dG9iZXIgMSwgMjAxOSA4OjAwIEFNDQo+ID4gPiBUbzogUkFWVUxBUEFUSSwgVklTSE5VIFZBUkRI
QU4gUkFPDQo+ID4gPiA8VmlzaG51dmFyZGhhbnJhby5SYXZ1bGFwYXRpQGFtZC5jb20+DQo+ID4g
PiBDYzogUkFWVUxBUEFUSSwgVklTSE5VIFZBUkRIQU4gUkFPDQo+ID4gPiA8VmlzaG51dmFyZGhh
bnJhby5SYXZ1bGFwYXRpQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPiA+IDxBbGV4
YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgTGlhbSBHaXJkd29vZA0KPiA8bGdpcmR3b29kQGdtYWls
LmNvbT47DQo+ID4gPiBNYXJrIEJyb3duIDxicm9vbmllQGtlcm5lbC5vcmc+OyBKYXJvc2xhdiBL
eXNlbGEgPHBlcmV4QHBlcmV4LmN6PjsNCj4gPiA+IFRha2FzaGkgSXdhaSA8dGl3YWlAc3VzZS5j
b20+OyBNdWt1bmRhLCBWaWplbmRhcg0KPiA+ID4gPFZpamVuZGFyLk11a3VuZGFAYW1kLmNvbT47
IE1hcnV0aGkgU3Jpbml2YXMgQmF5eWF2YXJhcHUNCj4gPiA+IDxNYXJ1dGhpLkJheXlhdmFyYXB1
QGFtZC5jb20+OyBNZWh0YSwgU2FuanUNCj4gPFNhbmp1Lk1laHRhQGFtZC5jb20+Ow0KPiA+ID4g
Q29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT47IERhbiBDYXJwZW50ZXIN
Cj4gPiA+IDxkYW4uY2FycGVudGVyQG9yYWNsZS5jb20+OyBtb2RlcmF0ZWQgbGlzdDpTT1VORCAt
IFNPQyBMQVlFUiAvDQo+ID4gPiBEWU5BTUlDIEFVRElPIFBPV0VSIE1BTkFHRU0uLi4gPGFsc2Et
ZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZz47DQo+IG9wZW4NCj4gPiA+IGxpc3QgPGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc+DQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIDIvN10gQVNvQzog
YW1kOiBSZWdpc3RlcmluZyBkZXZpY2UgZW5kcG9pbnRzDQo+ID4gPiB1c2luZyBNRkQgZnJhbWV3
b3JrDQo+ID4gPg0KPiA+ID4gT24gVHVlLCAwMSBPY3QgMjAxOSwgdmlzaG51IHdyb3RlOg0KPiA+
ID4NCj4gPiA+ID4gSGkgSm9uZXMsDQo+ID4gPiA+DQo+ID4gPiA+IEkgYW0gdmVyeSBUaGFua2Z1
bCB0byB5b3VyIHJldmlldyBjb21tZW50cy4NCj4gPiA+ID4NCj4gPiA+ID4gQWN0dWFsbHkgVGhl
IGRyaXZlciBpcyBub3QgdG90YWxseSBiYXNlZCBvbiBNRkQuIEl0IGp1c3QgdXNlcw0KPiA+ID4g
PiBtZmRfYWRkX2hvdHBsdWdfZGV2aWNlcygpIGFuZCBtZmRfcmVtb3ZlX2RldmljZXMoKSBmb3Ig
YWRkaW5nDQo+IHRoZQ0KPiA+ID4gPiBkZXZpY2VzIGF1dG9tYXRpY2FsbHkuDQo+ID4gPiA+DQo+
ID4gPiA+IFJlbWFpbmluZyBjb2RlIGhhcyBub3RoaW5nIHRvIGRvIHdpdGggTUZEIGZyYW1ld29y
ay4NCj4gPiA+ID4NCj4gPiA+ID4gU28gSSB0aG91Z2h0IEl0IHdvdWxkIG5vdCBicmVhayB0aGUg
Y29kaW5nIHN0eWxlIGFuZCBtb3ZlZCBhaGVhZA0KPiA+ID4gPiBieSB1c2luZyB0aGUgTUZEIEFQ
SSBieSBhZGRpbmcgaXRzIGhlYWRlciBmaWxlLg0KPiA+ID4gPg0KPiA+ID4gPiBJZiBpdCBpcyBh
bnkgdmlvbGF0aW9uIG9mIGNvZGluZyBzdGFuZGFyZCB0aGVuIEkgY2FuIG1vdmUgaXQgdG8NCj4g
PiA+ID4gZHJpdmVycy9tZmQuDQo+ID4gPiA+DQo+ID4gPiA+IFRoaXMgcGF0Y2ggY291bGQgYmUg
YSBzaG93IHN0b3BwZXIgZm9yIHVzLlBsZWFzZSBzdWdnZXN0IHVzIGhvdw0KPiA+ID4gPiBjYW4g
d2UgbW92ZSBhaGVhZCBBU0FQLg0KPiA+ID4NCj4gPiA+IEVpdGhlciBtb3ZlIHRoZSBNRkQgcGFy
dHMgdG8gZHJpdmVycy9tZmQsIG9yIHN0b3AgdXNpbmcgdGhlIE1GRCBBUEkuDQo+ID4NCj4gPiBU
aGVyZSBhcmUgbW9yZSBkcml2ZXJzIG91dHNpZGUgb2YgZHJpdmVycy9tZmQgdXNpbmcgdGhpcyBB
UEkgdGhhbg0KPiA+IGRyaXZlcnMgaW4gZHJpdmVycy9tZmQuDQo+IA0KPiBQZW9wbGUgZG8gd3Jv
bmcgdGhpbmdzIGFsbCB0aGUgdGltZS4gIEl0IGRvZXNuJ3QgbWFrZSB0aGVtIHJpZ2h0Lg0KPiAN
Cj4gPiBJbiBhIGxvdCBvZiBjYXNlcyBpdCBkb2Vzbid0IG1ha2Ugc2Vuc2UgdG8gbW92ZSB0aGUg
ZHJpdmVyIHRvIGRyaXZlcnMvbWZkLg0KPiANCj4gSW4gdGhvc2UgY2FzZXMsIHRoZSBwbGF0Zm9y
bV9kZXZpY2VfKigpIEFQSSBzaG91bGQgYmUgdXNlZC4NCg0KV2h5IGRvIHdlIGhhdmUgYm90aD8g
IEl0J3Mgbm90IGNsZWFyIHRvIG1lIG9uIHdoZW4gd2Ugc2hvdWxkIHVzZSBvbmUgdnMgdGhlIG90
aGVyLiAgVGhlc2UgYXJlIG5vdCBwbGF0Zm9ybXMgcGVyIHNlLCB0aGV5IGFyZSBQQ0kgZGV2aWNl
cyB0aGF0IGhhcHBlbiB0byBoYXZlIG90aGVyIGRldmljZXMgb24gdGhlbS4gIE9uIHByZXZpb3Vz
IHByb2plY3RzLCBJIHdhcyB0b2xkIHRvIHVzZSBtZmQgYW5kIG5vIG9iamVjdGlvbnMgd2VyZSBy
YWlzZWQgYXQgdGhhdCB0aW1lLg0KDQpBbGV4DQoNCg==
