Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B55C04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDC752085A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XMEhqD1P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbfEMJXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 05:23:30 -0400
Received: from mail-eopbgr50059.outbound.protection.outlook.com ([40.107.5.59]:45825
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727747AbfEMJX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 05:23:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XpMJPWruatyyW0pkRidGZnF2e/0tsEgf0w9OU3On0PA=;
 b=XMEhqD1PxVSyDOJ1f1AFqG4EPlAjaxd1oemF66z1ML6z8KOPLnm2htfwONO2qQ5ja6OhXYRW6Fdrq/Zw6cukK+YJjHy/8/fB1PnCfBxwKSPMZSXjZZP3cQQ5ShjMAvkVD1d3TMb6RaUKCAgF1iBFSRe8T/H+4O2O4PXyOTAd6mI=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.52.16) by
 VI1PR04MB3040.eurprd04.prod.outlook.com (10.170.228.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.24; Mon, 13 May 2019 09:23:24 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::4923:8ad8:62c1:3e61]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::4923:8ad8:62c1:3e61%5]) with mapi id 15.20.1878.024; Mon, 13 May 2019
 09:23:24 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        =?utf-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Markus Reichl <m.reichl@fivetechno.de>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: RE: [PATCH v3] usb: core: verify devicetree nodes for USB devices
Thread-Topic: [PATCH v3] usb: core: verify devicetree nodes for USB devices
Thread-Index: AQHVBkP6yfsjDnSxCk69+l82SkgDJqZjJOxsgACHhqCAAHC5gIAEqmrwgAAClwCAAANgMA==
Date:   Mon, 13 May 2019 09:23:24 +0000
Message-ID: <VI1PR04MB5327FAC12E4A3D403E8D92128B0F0@VI1PR04MB5327.eurprd04.prod.outlook.com>
References: <yw1xpnotufti.fsf@mansr.com>
        <CGME20190509084827eucas1p294962744fe70745c50b69a5349b5de68@eucas1p2.samsung.com>
        <20190509084726.5405-1-m.szyprowski@samsung.com>        <yw1xlfzfv4ol.fsf@mansr.com>
        <VI1PR04MB5327AD56CA772284DFE663D08B0C0@VI1PR04MB5327.eurprd04.prod.outlook.com>
        <7c5579d2-634a-d705-a451-563939957d57@samsung.com>
        <VI1PR04MB5327B425756FA394C51525208B0F0@VI1PR04MB5327.eurprd04.prod.outlook.com>
 <3544eb61-2bd8-338d-8d62-d95a775528ef@samsung.com>
In-Reply-To: <3544eb61-2bd8-338d-8d62-d95a775528ef@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 64bf6d03-ba51-4abd-f51d-08d6d784a689
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB3040;
x-ms-traffictypediagnostic: VI1PR04MB3040:
x-microsoft-antispam-prvs: <VI1PR04MB304066BB1AC3D55480F4D66F8B0F0@VI1PR04MB3040.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-forefront-prvs: 0036736630
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(346002)(136003)(376002)(189003)(199004)(25786009)(66946007)(4326008)(73956011)(53936002)(66446008)(186003)(26005)(66556008)(52536014)(76116006)(64756008)(66476007)(55016002)(9686003)(102836004)(44832011)(14454004)(7696005)(11346002)(446003)(476003)(6436002)(74316002)(6246003)(76176011)(6506007)(53546011)(486006)(229853002)(68736007)(256004)(14444005)(5024004)(86362001)(54906003)(110136005)(66066001)(7736002)(99286004)(305945005)(478600001)(71190400001)(33656002)(71200400001)(3846002)(2906002)(81156014)(6116002)(81166006)(8936002)(5660300002)(316002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3040;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KweGsgwrwQYZrFpXusnabyFB8/6Jl95F1UvCluhVF5jJeEWsXNNjZfoLnJLlpJUpmMAB2wu7s/qH/6iScYx3G9bUaUWYzKiafF5eGL8LWPe2oqKwItcbnLCQJjF8MGyJmpTq0u65oEevUbBlRNhAMD8tM22Vh7ZLKUhwU48aocNrbGK+0GmUCHQk+aQ/fKUTHWhgye+Fvd8pAL0aba1yUqpNj7ISbCOmpv30fErx4he0ZGKOeoUSajT9Qhbzx3IRJwQ4kx/04H7bpYbXIImCI22E4JlOYBaIfhmIO0s6Q84eLGJAdFAKwygaTkX1WVdqwOzzPyCxrORD/u4/3lKkwa0wN4Fei3+UU3kzu8yNiihbQOL4CTaEnZT+JfxS3Tzg5XAHOBGNToIbEIbdRef1iNP6uxyIPZaqsg8Q8HLvkUE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64bf6d03-ba51-4abd-f51d-08d6d784a689
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2019 09:23:24.8617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3040
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IA0KPiBPbiAyMDE5LTA1LTEzIDExOjAwLCBQZXRlciBDaGVuIHdyb3RlOg0KPiA+PiBPbiAyMDE5
LTA1LTEwIDA1OjEwLCBQZXRlciBDaGVuIHdyb3RlOg0KPiA+Pj4+IE1hcmVrIFN6eXByb3dza2kg
PG0uc3p5cHJvd3NraUBzYW1zdW5nLmNvbT4gd3JpdGVzOg0KPiA+Pj4+PiBDb21taXQgNjliZWM3
MjU5ODUzICgiVVNCOiBjb3JlOiBsZXQgVVNCIGRldmljZSBrbm93IGRldmljZSBub2RlIikNCj4g
Pj4+Pj4gYWRkZWQgc3VwcG9ydCBmb3IgYXR0YWNoaW5nIGRldmljZXRyZWUgbm9kZSBmb3IgVVNC
IGRldmljZXMuIFRoZQ0KPiA+Pj4+PiBtZW50aW9uZWQgY29tbWl0IGhvd2V2ZXIgaWRlbnRpZmll
cyB0aGUgZ2l2ZW4gVVNCIGRldmljZSBub2RlIG9ubHkNCj4gPj4+Pj4gYnkgdGhlDQo+ID4+ICdy
ZWcnDQo+ID4+Pj4+IHByb3BlcnR5IGluIHRoZSBob3N0IGNvbnRyb2xsZXIgY2hpbGRyZW4gbm9k
ZXMuIFRoZSBVU0IgZGV2aWNlDQo+ID4+Pj4+IG5vZGUgaG93ZXZlciBhbHNvIGhhcyB0byBoYXZl
IGEgJ2NvbXBhdGlibGUnIHByb3BlcnR5IGFzIGRlc2NyaWJlZA0KPiA+Pj4+PiBpbiBEb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL3VzYi1kZXZpY2UudHh0LiBMYWNrIGZvcg0K
PiA+Pj4+PiB0aGUgJ2NvbXBhdGlibGUnIHByb3BlcnR5IGNoZWNrIG1pZ2h0IHJlc3VsdCBpbiBh
c3NpZ25pbmcgYQ0KPiA+Pj4+PiBkZXZpY2V0cmVlIG5vZGUsIHdoaWNoIGlzIG5vdCBpbnRlbmRl
ZCB0byBiZSB0aGUgcHJvcGVyIG5vZGUgZm9yIHRoZSBnaXZlbg0KPiBVU0IgZGV2aWNlLg0KPiA+
Pj4+Pg0KPiA+Pj4+PiBUaGlzIGlzIGltcG9ydGFudCBlc3BlY2lhbGx5IHdoZW4gVVNCIGhvc3Qg
Y29udHJvbGxlciBoYXMNCj4gPj4+Pj4gY2hpbGQtbm9kZXMgZm9yIG90aGVyIHB1cnBvc2VzLiBG
b3IgZXhhbXBsZSwgRXh5bm9zIEVIQ0kgYW5kIE9IQ0kNCj4gPj4+Pj4gZHJpdmVycyBhbHJlYWR5
IGRlZmluZSBjaGlsZC1ub2RlcyBmb3IgZWFjaCBwaHlzaWNhbCByb290IGh1YiBwb3J0DQo+ID4+
Pj4+IGFuZCBhc3NpZ25zIHJlc3BlY3RpdmUgUEhZIGNvbnRyb2xsZXIgYW5kIHBhcmFtZXRlcnMg
Zm9yIHRoZW0uDQo+ID4+Pj4+IFRob3NlIGJpbmRpbmcgcHJlZGF0ZXMgc3VwcG9ydCBmb3IgVVNC
IGRldmljZXRyZWUgbm9kZXMuDQo+ID4+Pj4+DQo+ID4+Pj4+IENoZWNraW5nIGZvciB0aGUgcHJv
cGVyIGNvbXBhdGliaWxpdHkgc3RyaW5nIGFsbG93cyB0byBtaXRpZ2F0ZQ0KPiA+Pj4+PiB0aGUg
Y29uZmxpY3QgYmV0d2VlbiBVU0IgZGV2aWNlIGRldmljZXRyZWUgbm9kZXMgYW5kIHRoZSBiaW5k
aW5ncw0KPiA+Pj4+PiBmb3IgVVNCIGNvbnRyb2xsZXJzIHdpdGggY2hpbGQgbm9kZXMuIEl0IGFs
c28gZml4ZXMgdGhlDQo+ID4+Pj4+IHNpZGUtZWZmZWN0IG9mIHRoZSBvdGhlciBjb21taXRzLCBs
aWtlIDAxZmRmMTc5ZjRiMCAoInVzYjogY29yZToNCj4gPj4+Pj4gc2tpcCBpbnRlcmZhY2VzIGRp
c2FibGVkIGluIGRldmljZXRyZWUiKSwgd2hpY2ggaW5jb3JyZWN0bHkNCj4gPj4+Pj4gZGlzYWJs
ZXMgc29tZSBkZXZpY2VzIG9uIEV4eW5vcyBiYXNlZCBib2FyZHMuDQo+ID4+PiBIaSBNYXJlaywN
Cj4gPj4+DQo+ID4+PiBUaGUgcHVycG9zZSBvZiB5b3VyIHBhdGNoIGlzIGRvIG5vdCBzZXQgb2Zf
bm9kZSBmb3IgZGV2aWNlIHVuZGVyIFVTQg0KPiA+Pj4gY29udHJvbGxlciwNCj4gPj4gcmlnaHQ/
DQo+ID4+DQo+ID4+IFJpZ2h0Lg0KPiA+Pg0KPiA+IERvIHlvdSBtaW5kIGRvaW5nIGl0IGF0IGZ1
bmN0aW9uIGV4eW5vc19laGNpX2dldF9waHkgb2YgZWhjaS1leHlub3MuYz8NCj4gDQo+IEkgZG9u
J3QgbWluZCBmaXhpbmcgaXQgaW4gZWhjaS1leHlub3MsIGJ1dCBmcmFua2x5IHNvIGZhciBJIGhh
dmUgbm8gaWRlYSBob3cgdG8gZG8gaXQuDQo+IFRoZSBwcm9ibGVtIGlzIHRoYXQgbmV3bHkgY3Jl
YXRlZCBVU0IgZGV2aWNlcyBnZXQgb2Ytbm9kZSBwb2ludGVyIHBvaW50aW5nIHRvIGENCj4gbm9k
ZSB3aGljaCBpZiBub3QgaW50ZW5kZWQgZm9yIHRoZW0uIEhvdyB0aGlzIGNhbiBiZSBmaXhlZCBp
biBlaGNpLWV4eW5vcz8NCj4gDQogDQpDYW4ndCBiZSB3b3JrYXJvdW5kIGJ5IHNldHRpbmcgb2Zf
bm9kZSBhcyBOVUxMIGZvciBFSENJIGNvbnRyb2xsZXIgb3IgZm9yIFBIWSBub2RlIGF0DQpleHlu
b3NfZWhjaV9nZXRfcGh5Pw0KDQpQZXRlcg0KDQo=
