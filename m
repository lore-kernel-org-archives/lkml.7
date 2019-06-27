Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329A8C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 10:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01FA420828
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 10:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="HWjU5uE4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfF0KXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 06:23:24 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:38152 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbfF0KXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 06:23:23 -0400
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
X-IronPort-AV: E=Sophos;i="5.63,423,1557212400"; 
   d="scan'208";a="40635198"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Jun 2019 03:23:11 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex04.mchp-main.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 27 Jun 2019 03:23:11 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 27 Jun 2019 03:23:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=UoXvXCGdWPxZM8QyCQ3dHvBRethP37s6BSlXWZHt1Esf3yYmKA9uGMJQYEbo0T8cSeXhKABeKAI0F8Ky1J0JaywOT6HbDrma0G98a8/ebgSyHVsD7hMnW1xoAeCeSP8kOi0uUbNg2yi8I27fZ9MEPQhRLZU/uKTHXdycOZ117d4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xk7Q7cPpHrDcx5gv6G4AsNOONZ3amReZ9FSlg4N6AcA=;
 b=ORhM3vr+Qfn9oTJF3MlhqMb4VqpYBZ8rklZ87U8nXexRJPmJKEp0sAOXg6HBt87Xovq3hIRoh78w0+XsR45/ldfVVEfrqFnSYyYbC3vvwN62X6bImhM2Xg/nsYj6fjhDydNSXWo2py+Gat5s+2hsTNjNkNUAF2byDVuh3WsMoN0=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xk7Q7cPpHrDcx5gv6G4AsNOONZ3amReZ9FSlg4N6AcA=;
 b=HWjU5uE4wxDJ9/GSjB0YbSypmUmrPvWltJAv0R8+VomZPOvVctAE6MbHGKJrcQUMuXFPV7YFWOctzF/7ygQJcnGi6HCb7FztHFMTRUrbnIxzsXGC+JSZptCvZEY95+rN4elOyus8LaFipN01oeXMcYvbL48qcDdJJHKektvuNPQ=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB1536.namprd11.prod.outlook.com (10.172.53.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Thu, 27 Jun 2019 10:23:08 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::7d59:2a2f:90f1:2720]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::7d59:2a2f:90f1:2720%9]) with mapi id 15.20.2008.018; Thu, 27 Jun 2019
 10:23:08 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <sboyd@kernel.org>, <Ludovic.Desroches@microchip.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <mark.rutland@arm.com>, <mturquette@baylibre.com>,
        <robh+dt@kernel.org>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 4/4] clk: at91: sckc: add support for SAM9X60
Thread-Topic: [PATCH v4 4/4] clk: at91: sckc: add support for SAM9X60
Thread-Index: AQHVD72Q4ne6wpY5kEOC3wMr7TLsAQ==
Date:   Thu, 27 Jun 2019 10:23:08 +0000
Message-ID: <cc8b808e-d6b5-8ba1-13ff-218876d1b398@microchip.com>
References: <1558433454-27971-1-git-send-email-claudiu.beznea@microchip.com>
 <1558433454-27971-5-git-send-email-claudiu.beznea@microchip.com>
 <20190626183658.BA53A216FD@mail.kernel.org>
In-Reply-To: <20190626183658.BA53A216FD@mail.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR04CA0071.eurprd04.prod.outlook.com
 (2603:10a6:802:2::42) To MWHPR11MB1549.namprd11.prod.outlook.com
 (2603:10b6:301:c::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190627132300653
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31398580-f122-44ba-737b-08d6fae972b5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR11MB1536;
x-ms-traffictypediagnostic: MWHPR11MB1536:
x-microsoft-antispam-prvs: <MWHPR11MB153635DD96F349AC202ED1C187FD0@MWHPR11MB1536.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 008184426E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(396003)(376002)(346002)(189003)(199004)(4326008)(8676002)(2501003)(486006)(446003)(66946007)(66556008)(66446008)(11346002)(64756008)(476003)(73956011)(86362001)(81156014)(2201001)(81166006)(5660300002)(8936002)(2616005)(66476007)(6246003)(31696002)(7736002)(66066001)(4744005)(25786009)(305945005)(31686004)(72206003)(68736007)(2906002)(71200400001)(71190400001)(256004)(14454004)(36756003)(478600001)(53936002)(6512007)(99286004)(6436002)(6486002)(110136005)(316002)(52116002)(76176011)(3846002)(53546011)(102836004)(26005)(186003)(386003)(6506007)(6116002)(229853002)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1536;H:MWHPR11MB1549.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GX3PYNlv8z9aJ7NN26nmePu+j2ub3VFciQt+O3fRMA+USxMIdZTAyqQgJWspZLENignE5O7gJBT+lGw3iXUudKBeIynqABauebJIdHu1ZMgLH2HFqdY+F2K6rmMnbXtXDf7Z34Z010OtmNJDoeIJXZqtuNlYY6a8g3ti5Qjp1sXi8vVEbjCgfRhXnboZdxMLEPgXtBy5NG371MjLzJpJ71HTGJx6Akif3NNX9gqA1b9+MsMVxXChBYh7hFHMppYNRFiKyzfK9si+t2YruLaMkyQ/Rtko+FUavgQ6o4kFj9CtGlRvJGZeT27f6gYd4FeDRY8Lw7Tj+BV6d0L+nK1abxeGscgc8rcRxYag9/rhDwmBtrexqaRVovbhNm/ew0EcJIW8j6XJINIwS2AeCBbFOtxn74ZHOiNx6T7QB0R5Xyk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F8DE88AC1A63DC43A1B6B0C9677F015F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 31398580-f122-44ba-737b-08d6fae972b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2019 10:23:08.2905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: claudiu.beznea@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1536
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDI2LjA2LjIwMTkgMjE6MzYsIFN0ZXBoZW4gQm95ZCB3cm90ZToNCj4gUXVvdGluZyBD
bGF1ZGl1LkJlem5lYUBtaWNyb2NoaXAuY29tICgyMDE5LTA1LTIxIDAzOjExOjMzKQ0KPj4gRnJv
bTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQo+Pg0KPj4g
QWRkIHN1cHBvcnQgZm9yIFNBTTlYNjAncyBzbG93IGNsb2NrLg0KPj4NCj4+IFNpZ25lZC1vZmYt
Ynk6IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KPj4gQWNr
ZWQtYnk6IEFsZXhhbmRyZSBCZWxsb25pIDxhbGV4YW5kcmUuYmVsbG9uaUBib290bGluLmNvbT4N
Cj4+IC0tLQ0KPiANCj4gRllJLCB0aGlzIHBhdGNoIGlzIGJhc2U2NCBlbmNvZGVkIGFuZCBjYXVz
ZXMgbXkgTVVBIHRvIGhhdmUgbG90cyBvZg0KPiBwYWluLiBJdCB3b3VsZCBiZSBuaWNlIGlmIHlv
dSBjb3VsZCBzZW5kIHBsYWluIHRleHQgZW1haWxzLCBvdGhlcndpc2UgaXQNCj4gdGFrZXMgbWUg
YSBmZXcgbW9yZSBzZWNvbmRzIHRvIGV4dHJhY3QgdGhlIHBhdGNoLiBPZiBjb3Vyc2UsIGl0IHJl
bWluZHMNCj4gbWUgdGhhdCBJIG5lZWQgdG8gZml4IG15IE1VQSBzbyBtYXliZSB0aGlzIGlzIE9L
IQ0KPiANCg0KU29ycnkgZm9yIHRoYXQsIEkgd2lsbCByZXNlbmQgYWxsIHNlcmllcy4gSSBzZWUg
dGhhdCBhbGwgcGF0Y2hlcyBpbiB0aGlzIHNlcmllcw0KYXJlIGFmZmVjdGVkLg0KDQpUaGFuayB5
b3UsDQpDbGF1ZGl1IEJlem5lYQ0K
