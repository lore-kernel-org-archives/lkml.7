Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1792BECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 07:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC99A2133F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 07:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AEIA7XYO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbfJIHn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 03:43:28 -0400
Received: from mail-eopbgr150050.outbound.protection.outlook.com ([40.107.15.50]:49991
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725879AbfJIHn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 03:43:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBITk9laVtxC1yKnZGd7p9nJCBFWX8i2CARu4Cj03s/MPrGzJyccMpr59XmP8B9fj7b4gVWLDjYvRSVBG8EaIKxSyt6bVxtPE03PmmtIVpyodOu1PeTGPe972YADfkns1qMMN14LTik+uWWWFIMrMX42U84MmV8vfJ+mYIzsSU7gyKW1Xerzd4oQQFvcrZppxfrLZ3gE/pgYAXXyhPaENS+21vd1xwmEI0GImf8l2Lzu5kDvtgn2+TIZbe5xKT0xQ5k+OTMUvrGA9ia7e+RV4MxDkizdbseyvlLDGnVcl7dXW90OMDdJZXgtp2YMjGKyEQd2eiWtZ7jCJHFJg+Qfeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JezFGT7SYnw9AouOO/SQOroJZ5TZ0/9VIIVeY8a11O0=;
 b=gKsIk9vxxftpOTZVSRe84sOxEOR9qjBEyRphciq4h9DnrqHiDM/Nsuz+udWHS7b1uTmTap0FoqtSI+BhduPv9vxdPHm8z/JQhYKwJAOOgIa+OEnnRQW59iPxO11QO8oFhTGM1PbnOKmfkP5dRWFCCyY+HDcTcSxQU69nTx6sBeSqxnx+6l5zNRM0jBoKRXf76pU2hEYJ+RviePQ3mpfVfkOr3HtChGLNvBjMxA9iM9yjG1T8q3oN7JS353Pjc2uz9Pt9xxPYbOx68mZw6Zx/DGLa9ZvAZlOSiC8N2Gpq9Yvj/dAuyvhCDbI10FQBrNo6mzhVRwGi5UAZ8fKrTCbBMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JezFGT7SYnw9AouOO/SQOroJZ5TZ0/9VIIVeY8a11O0=;
 b=AEIA7XYOLT/hKBKBd39zumDhdZEIXVDgIJ+ZjChYAgqgPwj3nzPKzi+yL+2g4CW8MPdvE26FgOi9i8KkN5ON/9KxmR7QRI9AD3g/cLBl1UGclFUFejTL6sIGDBtepMhQ0xmOnTEW5nw2NYnnmE6s5hpSmiz5Hm3IOX6aDoybBy8=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3836.eurprd04.prod.outlook.com (52.134.71.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Wed, 9 Oct 2019 07:43:24 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d469:ad51:2bec:19f0]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d469:ad51:2bec:19f0%6]) with mapi id 15.20.2347.016; Wed, 9 Oct 2019
 07:43:24 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Stephen Boyd <swboyd@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: RE: [PATCH] tty: serial: imx: Only get second/third IRQ when there is
 more than one IRQ
Thread-Topic: [PATCH] tty: serial: imx: Only get second/third IRQ when there
 is more than one IRQ
Thread-Index: AQHVfmm1cibywjMA5UifVvn4HL9DWadR35+AgAAA6hCAAATlgIAAAf4ggAAEgICAAADzQA==
Date:   Wed, 9 Oct 2019 07:43:24 +0000
Message-ID: <DB3PR0402MB391677227A688D5DD56A8417F5950@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1570601911-9162-1-git-send-email-Anson.Huang@nxp.com>
 <20191009065315.wgdvmkv6skteyul4@pengutronix.de>
 <DB3PR0402MB39165F9CE876772F8F94F187F5950@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20191009071403.ugd2wuac6ue5zsd6@pengutronix.de>
 <DB3PR0402MB39161E02A9D042948B71FDCDF5950@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20191009073717.qlr2svma5fiaf4ad@pengutronix.de>
In-Reply-To: <20191009073717.qlr2svma5fiaf4ad@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a99a174-9d4f-43f3-5116-08d74c8c5d6a
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: DB3PR0402MB3836:|DB3PR0402MB3836:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3836CE4599F507FE3DECBE8BF5950@DB3PR0402MB3836.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 018577E36E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(136003)(366004)(39860400002)(376002)(189003)(54094003)(199004)(55016002)(6246003)(305945005)(52536014)(6436002)(66066001)(7736002)(8936002)(74316002)(25786009)(8676002)(76116006)(66946007)(81156014)(4326008)(66446008)(64756008)(81166006)(66556008)(66476007)(6916009)(229853002)(86362001)(14454004)(3846002)(6116002)(256004)(7696005)(76176011)(26005)(2906002)(6506007)(102836004)(7416002)(11346002)(99286004)(446003)(9686003)(478600001)(33656002)(54906003)(486006)(44832011)(316002)(476003)(186003)(71190400001)(71200400001)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3836;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: akzimXs4Lk2OKyGVcCP4Yssd4yMA6Iv5ZYqWAT5aghZI7pEqpx9tJskPEWgQTeRXjWtp5eP4ZlYIxwJLqYJ9Jy1zNjFufIA6YTD9PHjYTJP3x0UokF2RajqwEPcaQfPWs2yAi3tbP7golf1VROstTqSFl0wwKqyFSdJfzRZHN4SCxnugHU3Ce3ZzrWH3srlQ5Q12eehwIBNVbZHCP8hCeDm6vv94V5c7zsjDkRuiyggvvMVeaLz/p74INcAtDmpq1DauE40auwNSme2llpWpMl9tfV6WMaPpZsyRRwJaGZbMGkWYRYlsjiczGG9UuU78ZMpnWplSsN8A0BROV01wBeYL2IM1ypi2Ess5HgIFaZBdFmzINJubFY98MzPQvaqwJ4mV9ZOZn58sOox+E9LOzJlOonSst4JusxhBy+raiFo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a99a174-9d4f-43f3-5116-08d74c8c5d6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2019 07:43:24.1826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HnHE5edpr8D21Ycgeqh0eCPcrqjV58CtaGDS+lC/zsN/Bcm2oruKeU6vvHEhVAdMr2A4rlTJn7VcfZSlxdfwRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3836
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFV3ZQ0KDQo+IE9uIFdlZCwgT2N0IDA5LCAyMDE5IGF0IDA3OjI0OjU3QU0gKzAwMDAsIEFu
c29uIEh1YW5nIHdyb3RlOg0KPiA+ID4gT24gV2VkLCBPY3QgMDksIDIwMTkgYXQgMDY6NTg6MjRB
TSArMDAwMCwgQW5zb24gSHVhbmcgd3JvdGU6DQo+ID4gPiA+ID4gVGhlIHBhdGNoIGlzIGZpbmUg
Z2l2ZW4gdGhlIGNoYW5nZWQgYmVoYXZpb3VyIG9mDQo+ID4gPiA+ID4gcGxhdGZvcm1fZ2V0X2ly
cS4gSSB3b25kZXIgaWYgaXQgaXMgc2Vuc2libGUgdG8gaW50cm9kdWNlIGENCj4gPiA+ID4gPiB2
YXJpYW50IG9mIHBsYXRmb3JtX2dldF9pcnEgKHNheQ0KPiA+ID4gPiA+IHBsYXRmb3JtX2dldF9p
cnFfbm93YXJuKSB0aGF0IGJlaGF2ZXMgbGlrZSBfX3BsYXRmb3JtX2dldF9pcnENCj4gPiA+ID4g
PiBkb2VzIHQgVGhlbiB0aGUgaW14IGRyaXZlciB3b3VsZCBqdXN0IGNhbGwNCj4gPiA+ID4gPiBw
bGF0Zm9ybV9nZXRfaXJxX25vd2FybiB3aXRob3V0IGhhdmluZyB0byBjaGVjayB0aGUgbnVtYmVy
IG9mDQo+IGF2YWlsYWJsZSBpcnFzIGZpcnN0Lg0KPiA+ID4gPg0KPiA+ID4gPiBBZ3JlZWQsIGl0
IHdvdWxkIGJlIG5pY2UgaWYgd2UgY2FuIGZpeCB0aGlzIGZyb20gdGhlIEFQSSBsZXZlbCwNCj4g
PiA+ID4gdGhpcyBpcyB0byBzYXZlIG1hbnkgcGF0Y2hlcyBmcm9tIHZhcmlvdXMgZHJpdmVycyBz
aWRlLCBsZXQgbWUNCj4gPiA+ID4ga25vdyBpZiBhZ3JlZW1lbnQgaXMgcmVhY2hlZCBhbmQgSSB3
aWxsIGRvIHRoZSBwYXRjaC4NCj4gPiA+DQo+ID4gPiBJIHdvdWxkbid0IGV4cGVjdCB0aGF0IG1v
c3QgY2FsbGVycyBhY3R1YWxseSB3YW50IGFuIGVycm9yIG1lc3NhZ2UNCj4gPiA+IGFuZCBzbyB0
aGVzZSBuZWVkIGEgZGlmZmVyZW50IHBhdGNoIChpLmUuIGRyb3BwaW5nIHRoZSBlcnJvciBtZXNz
YWdlIGJ5DQo+IHRoZSBjYWxsZXIpLg0KPiA+ID4gVGhpcyB0eXBlIG9mIHBhdGNoIGlzIGZpbmUg
YW5kIHRoZSBub3JtYWwgbG9hZCB3aGVuIHNvbWV0aGluZyBpcw0KPiA+ID4gY29uc29saWRhdGVk
Lg0KPiA+ID4NCj4gPiA+IFdoaWNoIG90aGVyIGRyaXZlcnMgZG8geW91IGhhdmUgb24geW91ciBy
YWRhciB0aGF0IGRvbid0IHdhbnQgYW4NCj4gPiA+IGVycm9yIG1lc3NhZ2UgaWYgcGxhdGZvcm1f
Z2V0X2lycSgpIGZhaWxzPw0KPiA+DQo+ID4gSSBkaWQgTk9UIG1lYW4gZHJpdmVycyBkb24ndCB3
YW50IGFuIGVycm9yIHdoZW4gZ2V0dGluZyBpcnEgZmFpbGVkLA0KPiA+IGJ1dCBJIGp1c3QgYWdy
ZWUgdGhhdCBpbnRyb2R1Y2luZyBhbm90aGVyIEFQSSB3aXRoIG5vd2FybiBhcyB5b3UNCj4gPiBt
ZW50aW9uZWQgdXBwZXIsIHRoZW4gaS5NWCBkcml2ZXIgY2FuIGNhbGwgaXQuIEZvciBub3csIHRo
ZSBGRUMgZHJpdmVyDQo+ID4gYWxzbyBoYXZlIG1hbnkgc3VjaCBlcnJvciBtZXNzYWdlLCB3ZSB3
aWxsIGZpeCBsYXRlci4NCj4gPg0KPiA+IFNvIGlmIHRoZSBBUEkgd2l0aCBub3dhcm4gaXMgYWRk
ZWQsIHRoZW4gSSBjYW4gY2hhbmdlIHRoZSBBUEkgY2FsbCBpbg0KPiA+IHNvbWUgaS5NWCBkcml2
ZXIgaW5zdGVhZCBvZiBnZXR0aW5nIGlycV9jb3VudCBmaXJzdC4gRG8geW91IHRoaW5rIEkNCj4g
PiBzaG91bGQgYWRkIHRoZSBub3dhcm4gQVBJIGFuZCByZWRvIHRoaXMgcGF0Y2ggdG8gY2FsbCBp
dD8NCj4gDQo+IEhhdmluZyBhIHBhdGNoIChvciBhIHNldCBvZiBwYXRjaGVzKSBpcyBwcm9iYWJs
eSBoZWxwZnVsIHRvIGdldCBmb3J3YXJkIGhlcmUsDQo+IHllcy4gWW91IGhhdmUgbXkgYmxlc3Np
bmcgdG8gY3JlYXRlIGEgc3VnZ2VzdGlvbi4gKE5vdCB0aGF0IHlvdSBhY3R1YWxseSBuZWVkDQo+
IHRoYXQgOi0pDQoNClRoYW5rcywgT0ssIHRoZW4gSSB3aWxsIGxlYXZlIHRoaXMgcGF0Y2ggYXMg
aXQgaXMgZm9yIG5vdywgYW5kIGxlYXZlIG90aGVycyB0byBkZWNpZGUgd2hldGhlcg0KdG8gYWRk
IGEgcGF0Y2ggb2YgYWRkaW5nIG5ldyBBUEkgb2Ygbm93YXJuLiBTb21lIGRyaXZlcnMgbmVlZCB0
byBiZSBjaGFuZ2VkIGFueXdheSB0byBhdm9pZA0KdGhpcyBlcnJvciBtZXNzYWdlLCBlaXRoZXIg
Z2V0dGluZyBpcnEgY291bnQgZmlyc3Qgb3IgY2FsbGluZyBuZXcgQVBJIG9uY2UgaXQgaXMgYWRk
ZWQuDQoNClRoYW5rcywNCkFuc29uDQo=
