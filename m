Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD8FC04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5002214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lwqAiIhh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbfEMJAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 05:00:46 -0400
Received: from mail-eopbgr50040.outbound.protection.outlook.com ([40.107.5.40]:16838
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727401AbfEMJAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 05:00:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTAn3h14jAxrKV99xndIN2xmKqLBxc8x6Qckk787510=;
 b=lwqAiIhh61MbAED9YZkaJfOw5DXw4zkW22a/RQ9zUjoUtpVdH3Xuwl9T/M0iSEoAjqXJpvahHUoI7N9B24ys9VdreKsG/wmHFXzNtu7IxHqfUL8UVfkzbLpViHUgLyrw39yaVds7hyq4rqb+NqG/vEBD/mLcdxMqwPU2xtQbOjg=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.52.16) by
 VI1PR04MB6238.eurprd04.prod.outlook.com (20.179.24.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.22; Mon, 13 May 2019 09:00:42 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::4923:8ad8:62c1:3e61]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::4923:8ad8:62c1:3e61%5]) with mapi id 15.20.1878.024; Mon, 13 May 2019
 09:00:42 +0000
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
Thread-Index: AQHVBkP6yfsjDnSxCk69+l82SkgDJqZjJOxsgACHhqCAAHC5gIAEqmrw
Date:   Mon, 13 May 2019 09:00:41 +0000
Message-ID: <VI1PR04MB5327B425756FA394C51525208B0F0@VI1PR04MB5327.eurprd04.prod.outlook.com>
References: <yw1xpnotufti.fsf@mansr.com>
        <CGME20190509084827eucas1p294962744fe70745c50b69a5349b5de68@eucas1p2.samsung.com>
        <20190509084726.5405-1-m.szyprowski@samsung.com>        <yw1xlfzfv4ol.fsf@mansr.com>
        <VI1PR04MB5327AD56CA772284DFE663D08B0C0@VI1PR04MB5327.eurprd04.prod.outlook.com>
 <7c5579d2-634a-d705-a451-563939957d57@samsung.com>
In-Reply-To: <7c5579d2-634a-d705-a451-563939957d57@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a816662-2e8b-4bb2-e2fb-08d6d7817a2c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB6238;
x-ms-traffictypediagnostic: VI1PR04MB6238:
x-microsoft-antispam-prvs: <VI1PR04MB623862B23000A22DFA2FD83A8B0F0@VI1PR04MB6238.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-forefront-prvs: 0036736630
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(396003)(346002)(366004)(199004)(189003)(256004)(110136005)(14444005)(54906003)(76176011)(52536014)(5024004)(5660300002)(7696005)(81166006)(81156014)(99286004)(86362001)(8676002)(71200400001)(71190400001)(102836004)(53546011)(6506007)(26005)(11346002)(446003)(486006)(44832011)(476003)(14454004)(186003)(8936002)(9686003)(305945005)(66066001)(74316002)(68736007)(316002)(7736002)(3846002)(2906002)(53936002)(6246003)(55016002)(6116002)(33656002)(229853002)(66946007)(76116006)(4326008)(73956011)(6436002)(478600001)(64756008)(25786009)(66446008)(66556008)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6238;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Rm3NpDO1oNCiWMbLAJ8Yf7EYiIpP6Oq/yJ/2OTA99NzwNvqGAVBPUg+iY9lGwR56Lu9+3q60XWV9OGcuxu6UXVPM06+Fvx719pFpV9WDCxrmwfSvlokQoR29DvouhJWuMY8VNJCDLmIHHY2VA9YEj7EW5z7Ztu4DNiTe2dDbFTgIF+ZtPdLjgjLHMjUcSVtSmXL0wYbHxGOXKq+0suajfCtqe/hd3AV+/9Botxv6Vi0JkmSVFYm15aC4teHET/0zqXm+aK9mraWCQYMqcyQUEUAWlF/Xf5eXFd2sjjtCqrMrfy1wQSvJFTPL2WlwEnQMPkkNr8asIl8a1c1pBN+1y0yNyoBkHKMxqwb2cpHNV3W4W3LkpXHnaXck01JO+mZTkRREYT1WBpFKat/t5IJwvGNeYRCiQNKTfsUJAucVRVk=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a816662-2e8b-4bb2-e2fb-08d6d7817a2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2019 09:00:41.8667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6238
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IA0KPiANCj4gT24gMjAxOS0wNS0xMCAwNToxMCwgUGV0ZXIgQ2hlbiB3cm90ZToNCj4gPg0KPiA+
PiBNYXJlayBTenlwcm93c2tpIDxtLnN6eXByb3dza2lAc2Ftc3VuZy5jb20+IHdyaXRlczoNCj4g
Pj4+IENvbW1pdCA2OWJlYzcyNTk4NTMgKCJVU0I6IGNvcmU6IGxldCBVU0IgZGV2aWNlIGtub3cg
ZGV2aWNlIG5vZGUiKQ0KPiA+Pj4gYWRkZWQgc3VwcG9ydCBmb3IgYXR0YWNoaW5nIGRldmljZXRy
ZWUgbm9kZSBmb3IgVVNCIGRldmljZXMuIFRoZQ0KPiA+Pj4gbWVudGlvbmVkIGNvbW1pdCBob3dl
dmVyIGlkZW50aWZpZXMgdGhlIGdpdmVuIFVTQiBkZXZpY2Ugbm9kZSBvbmx5IGJ5IHRoZQ0KPiAn
cmVnJw0KPiA+Pj4gcHJvcGVydHkgaW4gdGhlIGhvc3QgY29udHJvbGxlciBjaGlsZHJlbiBub2Rl
cy4gVGhlIFVTQiBkZXZpY2Ugbm9kZQ0KPiA+Pj4gaG93ZXZlciBhbHNvIGhhcyB0byBoYXZlIGEg
J2NvbXBhdGlibGUnIHByb3BlcnR5IGFzIGRlc2NyaWJlZCBpbg0KPiA+Pj4gRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi91c2ItZGV2aWNlLnR4dC4gTGFjayBmb3IgdGhlDQo+
ID4+PiAnY29tcGF0aWJsZScgcHJvcGVydHkgY2hlY2sgbWlnaHQgcmVzdWx0IGluIGFzc2lnbmlu
ZyBhIGRldmljZXRyZWUNCj4gPj4+IG5vZGUsIHdoaWNoIGlzIG5vdCBpbnRlbmRlZCB0byBiZSB0
aGUgcHJvcGVyIG5vZGUgZm9yIHRoZSBnaXZlbiBVU0IgZGV2aWNlLg0KPiA+Pj4NCj4gPj4+IFRo
aXMgaXMgaW1wb3J0YW50IGVzcGVjaWFsbHkgd2hlbiBVU0IgaG9zdCBjb250cm9sbGVyIGhhcw0K
PiA+Pj4gY2hpbGQtbm9kZXMgZm9yIG90aGVyIHB1cnBvc2VzLiBGb3IgZXhhbXBsZSwgRXh5bm9z
IEVIQ0kgYW5kIE9IQ0kNCj4gPj4+IGRyaXZlcnMgYWxyZWFkeSBkZWZpbmUgY2hpbGQtbm9kZXMg
Zm9yIGVhY2ggcGh5c2ljYWwgcm9vdCBodWIgcG9ydA0KPiA+Pj4gYW5kIGFzc2lnbnMgcmVzcGVj
dGl2ZSBQSFkgY29udHJvbGxlciBhbmQgcGFyYW1ldGVycyBmb3IgdGhlbS4gVGhvc2UNCj4gPj4+
IGJpbmRpbmcgcHJlZGF0ZXMgc3VwcG9ydCBmb3IgVVNCIGRldmljZXRyZWUgbm9kZXMuDQo+ID4+
Pg0KPiA+Pj4gQ2hlY2tpbmcgZm9yIHRoZSBwcm9wZXIgY29tcGF0aWJpbGl0eSBzdHJpbmcgYWxs
b3dzIHRvIG1pdGlnYXRlIHRoZQ0KPiA+Pj4gY29uZmxpY3QgYmV0d2VlbiBVU0IgZGV2aWNlIGRl
dmljZXRyZWUgbm9kZXMgYW5kIHRoZSBiaW5kaW5ncyBmb3INCj4gPj4+IFVTQiBjb250cm9sbGVy
cyB3aXRoIGNoaWxkIG5vZGVzLiBJdCBhbHNvIGZpeGVzIHRoZSBzaWRlLWVmZmVjdCBvZg0KPiA+
Pj4gdGhlIG90aGVyIGNvbW1pdHMsIGxpa2UgMDFmZGYxNzlmNGIwICgidXNiOiBjb3JlOiBza2lw
IGludGVyZmFjZXMNCj4gPj4+IGRpc2FibGVkIGluIGRldmljZXRyZWUiKSwgd2hpY2ggaW5jb3Jy
ZWN0bHkgZGlzYWJsZXMgc29tZSBkZXZpY2VzIG9uDQo+ID4+PiBFeHlub3MgYmFzZWQgYm9hcmRz
Lg0KPiA+IEhpIE1hcmVrLA0KPiA+DQo+ID4gVGhlIHB1cnBvc2Ugb2YgeW91ciBwYXRjaCBpcyBk
byBub3Qgc2V0IG9mX25vZGUgZm9yIGRldmljZSB1bmRlciBVU0IgY29udHJvbGxlciwNCj4gcmln
aHQ/DQo+IA0KPiBSaWdodC4NCj4gDQoNCkRvIHlvdSBtaW5kIGRvaW5nIGl0IGF0IGZ1bmN0aW9u
IGV4eW5vc19laGNpX2dldF9waHkgb2YgZWhjaS1leHlub3MuYz8NCg0KUGV0ZXINCg==
