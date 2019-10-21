Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C274DCA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94CC120684
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbfJUKIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 06:08:04 -0400
Received: from mail-oln040092068044.outbound.protection.outlook.com ([40.92.68.44]:61253
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727110AbfJUKIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 06:08:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZiXNEjf4Bxue9nT5mbUa8q0k9aI2rrhXQ7s5ZuBEVK/DsH6eKFBByoIe4C3L8EWFKQdEnjOjv/7wU0Yd30E6kz/Oa9zh5uynqJhfoLyX8G40le3B37SQz743/pEcDxikq6heqLSrhapNVoxozCLQLYNwtXKhML7h59z1epZHDvstd1pVHdx6PzCVRtKIU7/pJUU4KAqtpHhJJ+ZpGDDrpwLIRieGcgH/fYT6C+V9jYaUGMEYowaqG4xFedT/iWB4y5/pG+HRZJX6/omscD3rv4wahnoQAnFZfqkpflHECstL3RgTeeap/B9Xzd7ztAbArZlMtJS4KR9qjXsKNP4DDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/zpb5WesklVNArzRUxoeAWG9+gWsDzTmybcOEVhAuY=;
 b=BqIco2IYxC7hTI2v94Cec5RH2aTckk00AwjV+inYbflybKmW6fb1DuvACMeGCufMdfcPJO/Qt7pECJPe7FP7jV14ZrLIdSzCro54udYxqrAAQN2nsItR7XfE12WyxpatgvfwdM0FzihWko8jLLU+TRauM0Dw6DZQRHT2HXgAE+ZR2ZoywupQSstn8bQM6u2wczUMHdIjpP4Jr0y9rRoD0D1DlayowZjY39oRoIaBOVGLc7jqENj4VuWY+KCm7SLYLG7FpC2DKoiWdvypVC/C54WOYjNy/UvXatQjnM0c4dOD9FYDInvj4YpxMks8s1n1ajZ5fhhDct+ImQV6ZjdGkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from HE1EUR02FT038.eop-EUR02.prod.protection.outlook.com
 (10.152.10.58) by HE1EUR02HT122.eop-EUR02.prod.protection.outlook.com
 (10.152.10.252) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2367.14; Mon, 21 Oct
 2019 10:08:00 +0000
Received: from AM0PR0502MB3668.eurprd05.prod.outlook.com (10.152.10.54) by
 HE1EUR02FT038.mail.protection.outlook.com (10.152.11.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2367.14 via Frontend Transport; Mon, 21 Oct 2019 10:08:00 +0000
Received: from AM0PR0502MB3668.eurprd05.prod.outlook.com
 ([fe80::b1e4:568d:bbc:8247]) by AM0PR0502MB3668.eurprd05.prod.outlook.com
 ([fe80::b1e4:568d:bbc:8247%6]) with mapi id 15.20.2347.029; Mon, 21 Oct 2019
 10:08:00 +0000
From:   Anatol Belski <weltling@outlook.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Michael Jamet <michael.jamet@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        "trivial@kernel.org" <trivial@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2] include/linux/byteorder/generic.h: fix signed/unsigned
 warnings
Thread-Topic: [PATCH v2] include/linux/byteorder/generic.h: fix
 signed/unsigned warnings
Thread-Index: AQHVh/HGZiHBTV97akWCLD86HLHkVadk1r+AgAAIMQA=
Date:   Mon, 21 Oct 2019 10:08:00 +0000
Message-ID: <AM0PR0502MB3668F50248ACD5CFA9B74D96BA690@AM0PR0502MB3668.eurprd05.prod.outlook.com>
References: <AM0PR0502MB366860AC878296E4E76DD223BA690@AM0PR0502MB3668.eurprd05.prod.outlook.com>
         <20191021093839.GM32742@smile.fi.intel.com>
In-Reply-To: <20191021093839.GM32742@smile.fi.intel.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
x-clientproxiedby: AM3PR07CA0143.eurprd07.prod.outlook.com
 (2603:10a6:207:8::29) To AM0PR0502MB3668.eurprd05.prod.outlook.com
 (2603:10a6:208:19::11)
x-incomingtopheadermarker: OriginalChecksum:BB107EEB261F87BFD3A07B5976BF653D3F6B70CE2126C93BB88ECEE2811D5672;UpperCasedChecksum:60B5B2AE91D7EBC35951CB58EB5E1FBF4F32EBD7158E8D8D56BE97F1AB487CDD;SizeAsReceived:8109;Count:52
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [afDEJeBRzv8p8q4LzF9xp0cQ0JG9yKSULe+93z9U/t0CSm49E/pcHrpU0EvekqZM]
x-microsoft-original-message-id: <e398ba2c570f2f58888375fce93bbb78e609e649.camel@outlook.de>
x-ms-publictraffictype: Email
x-incomingheadercount: 52
x-eopattributedmessage: 0
x-ms-traffictypediagnostic: HE1EUR02HT122:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8IwdeViGpAE1tDraD8V8NieVI1zU+UeQGw2TY04KEwqxJdkSJ4LlB789aJ6ZC+ELLZ+blQwbp/PBFEkzxzalq1cWZYYJSTsOr2oVg4w4kwL51Qld4g+ONZAcH2n6UKLxCOdCj+1gTqXGztlfxHySdDNcw03ZggIIVKdd+yVti92s0ltwwKbzRFX2hgHlkvsC
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB483C52911C584C8A5C69BD99090423@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 392a1a34-121a-49e5-1cc8-08d7560e8d3e
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2019 10:08:00.5787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1EUR02HT122
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE5LTEwLTIxIGF0IDEyOjM4ICswMzAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
DQo+IFdlIGhhdmUgZXhwbGljaXRseSBkaXNhYmxlZCB0aGlzIHdhcm5pbmdzIGluIHRoZSBrZXJu
ZWwgTWFrZWZpbGUuDQo+IEhvdyBkaWQgeW91IGFjaGlldmUgdGhpcz8gKHllcywgSSBrbm93IHRo
ZSBwb3NzaWJsZSBhbnN3ZXIsIHBlcmhhcHMNCj4gdGhpcyBoYXMgdG8gYmUgbWVudGlvbmVkIGFz
IHdlbGwpDQpBZGRlZCBXPTEyIHRvIHRoZSBtYWtlIGNvbW1hbmQsIHVzZWQgR0NDIDkuMS4wLiBU
aGVyZSBhcmUgcXVpdGUgc29tZQ0Kd2FybmluZ3Mgb2YgdGhpcyBhcnQgeWV0LCBzbyB0aGlzIGlz
IGp1c3QgYSBmaXJzdCBzaG90Lg0KDQpBZGRpdGlvbmFsIGlzc3VlIGknZCBzZWUgaW4gdGhpcyBw
YXJ0aWN1bGFyIGNhc2UgYWxzbywgdGhhdCBpdGVyYXRpbmcNCnRocm91Z2ggYW4gYXJyYXkgc2hv
dWxkIHVzZSBzb21lIHVuc2lnbmVkIHRvIGVuc3VyZSB0aGVyZSdzIG5vIHNpZ25lZA0Kb3ZlcmZs
b3cuIEJ1dCBvdGhlcndpc2UsIGl0J3MgYmV0dGVyIHRvIGZpeCBzaW1pbGFyIGNhc2VzIHRvIHJl
ZHVjZSB0aGUNCm5vaXNlLg0KDQo+ID4gU2lnbmVkLW9mZi1ieTogQW5hdG9sIEJlbHNraSA8YW5i
ZWxza2lAbWljcm9zb2Z0LmNvbT4NCj4gPiAtLS0NCj4gDQo+IENoYW5nZWxvZyBpcyBtaXNzaW5n
Lg0KPiAoTm8gbmVlZCB0byByZXNlbmQganVzdCBmb3IgdGhpcywgaXQncyBmb3IgeW91ciBmdXR1
cmUgY29udHJpYnV0aW9ucykNCj4gDQpUaGFua3MgZm9yIHBvaW50aW5nIHRvIHRoaXMuIEkgYWxz
byBwcm9iYWJseSBzaG91bGQgaGF2ZSBhZGRlZCBhIENjOi4NCldpbGwgZ28gdGhyb3VnaCB0aGUg
c3VibWl0dGluZyBwYXRjaGVzIGRvY3VtZW50IG1vcmUgY2FyZWZ1bGx5Lg0KDQpUaGFua3MhDQoN
CmFuYXRvbA0KDQo=
