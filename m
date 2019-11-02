Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1065CA9EC7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 10:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68DA4217D9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 10:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="mwz1j4eR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfKBKrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 06:47:52 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:19734 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfKBKrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 06:47:51 -0400
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: 9M00b+C65qKZajD43LEINBO2rYH5A2WnxVmgrykPqlYYf7a64c0hGSR76uHKMKT+IHVMrsH0Q9
 m+F8Gt3Rz+zVX1cI/9QcCCP7ZhH+OudPrZpSVFurrvb78vRnWioACG2dV8OdA9rZ5kHXxd8Drx
 Hl6uWWFjTM9k4qGNKe9OUtmhYrpCjc8WBO4/+01jAIkF+VBIElDdZ510RDRgFHBW+S2HzjiOxx
 yY+k9hUYBrtJU2Ma2kpqGGW/rGQhWU6qbc830lq528eUD2TnYAz8jwpLYsHkBI+/6hsPj1zaWg
 meY=
X-IronPort-AV: E=Sophos;i="5.68,259,1569308400"; 
   d="scan'208";a="53899521"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Nov 2019 03:47:50 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 2 Nov 2019 03:47:35 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Sat, 2 Nov 2019 03:47:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LL3Y80KZsTPcvUcwVxKoJaquDYYklWaICqOC3voTprzkz5i3wmHUXERdgrNsAsNJc8URmViGWaefFus+8iw5sbB12NfdN0D04/peIfOgxJVCQ92en4DS8rmznoyb8b//f4l1m2+yrYEsV2DguygQUYdWwzatnlHJh5mzJTplry5eYz5V7DgFmzDPfEPIphWWgkd/xsDwpPAM0TtKdQzv7K7SYzaH8S+17PJ9e70wm7a+r4kPre/wS114PrDIc51FA2kyOvo7EgfiHCoGYKHSVTa2RMjppwBcROhKMozTuArvg5hwDyo6osllfuMwcYuElSIjB/vatHXcZzcODzobag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhAMS7cwe2rJ4m3YkVKFaoYmZum8IIGKJctujC4QiFQ=;
 b=jmRJCxagbJGl05+4Tn7mzkquRTgVaCFF2hV9WwxdOhXOxM2cTjdkD/aArE0+SFg8Zq0WGn8/DS6lW4URuuShDVCw8J7H7/kqU2e8N2xRalv8IiCc2PI6F8uaqhM6ZNnQlZPdfXh7M+Kog4zdLm7BACzJXFpgIYyRTYPb1LKf/dHddXXnSwcqSaABiNzYxTPI+pojch5cBlyKSIO+RPDHb1K8jm8iWbQAZmP9EbdV8DS1b79FODpEgcree55fRL5T/f7cxrC/8B7sqaRE3Vqm3sNbFEFkg9uyXKpEwVyzeTPPshCm0r6hh83h/lWKlRcbXBpDM/zpv+VZWEXl/iST2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhAMS7cwe2rJ4m3YkVKFaoYmZum8IIGKJctujC4QiFQ=;
 b=mwz1j4eRP3AsPDcw4r6t9WEeEVecgbYsvW0uyZssTtvagm2JGLj8ahaazzI+s2Hb1VWYKIW2EhGIG+7GRpt51jHHLfIcpoNBvVYSDHk8RZ2qKQwcbpgEyTqjEHba+Kh4Vs8HRoyFXNxrv4feXz0SZRODwdHhTWdizkYf5RQR7A8=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3629.namprd11.prod.outlook.com (20.178.252.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Sat, 2 Nov 2019 10:47:34 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2408.018; Sat, 2 Nov 2019
 10:47:34 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <boris.brezillon@collabora.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 14/32] mtd: spi-nor: Fix retlen handling in sst_write()
Thread-Topic: [PATCH v3 14/32] mtd: spi-nor: Fix retlen handling in
 sst_write()
Thread-Index: AQHVjkpoSVKjPGSGlU2f6aqVnPUv9Kd3uTMA
Date:   Sat, 2 Nov 2019 10:47:33 +0000
Message-ID: <1d182d99-3fec-7380-6722-054388d2d33b@microchip.com>
References: <20191029111615.3706-1-tudor.ambarus@microchip.com>
 <20191029111615.3706-15-tudor.ambarus@microchip.com>
In-Reply-To: <20191029111615.3706-15-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0127.eurprd07.prod.outlook.com
 (2603:10a6:802:16::14) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.120.239.29]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b3a88064-d93d-4eac-6759-08d75f821158
x-ms-traffictypediagnostic: MN2PR11MB3629:
x-microsoft-antispam-prvs: <MN2PR11MB362999DE17C4D8667332C2B9F07D0@MN2PR11MB3629.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 0209425D0A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(376002)(346002)(366004)(396003)(136003)(199004)(189003)(64756008)(5660300002)(3846002)(31686004)(6436002)(7736002)(2501003)(256004)(476003)(4744005)(186003)(486006)(54906003)(26005)(2906002)(110136005)(6512007)(86362001)(76176011)(305945005)(6116002)(386003)(53546011)(14454004)(316002)(66446008)(66556008)(66946007)(52116002)(2201001)(99286004)(102836004)(6506007)(2616005)(66476007)(81166006)(81156014)(71200400001)(8936002)(478600001)(8676002)(11346002)(446003)(6486002)(25786009)(71190400001)(31696002)(229853002)(66066001)(4326008)(6246003)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3629;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LzvQNCJuN60HP9STcMSep8ZpwXHV29Hby1TIT5GoCmsB6yfDjTni5CrlFA/Zbh3HraOrrRGa0p/MaydON/G2217+fI42ul0cqyFbpnGJpJKh8/ws55MecbUyLUvK8ZCl8InOqXOyE0DhsUdpIBlkzBmb8jVmlJkYmUUxEhnhXeQggXEKfBK+rTuVQX42aX/7o7nU2ZUhfp5Gw0pjCqEzfUCz8wixh884riKA9fFsDKUBtV1bI9SBqDAYY1F08EB6OclPKIdUrVhzG9TDVgwVJC//P+XnQKfwg5853U1tIojif85kGJI2T1MfP0wcDGqYcryWdZSTpdxiyQZw4ftnKQtK7+HQLFdjC+raUm2haWuLO+6kdwBPmytNz0hyY5EgDsFVdjdJJh88ouIHZ1DXM6afwot1MS+Ntj5QlPDuH4ls2k6J+d1V11gllXfID3Fo
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <826F8D52F16A5F43A1113CF8B31B498F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b3a88064-d93d-4eac-6759-08d75f821158
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2019 10:47:33.9836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aT52+KOWK9z20+CB0FLkqLgoqBQe5BcqyV8H/CU4GeDaJDpG4O8GYuteggpgVyAiV483phtksvDvoOFJGqqGGA3diHOnJD29HaPwjfen6Ro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3629
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDEwLzI5LzIwMTkgMDE6MTcgUE0sIFR1ZG9yIEFtYmFydXMgLSBNMTgwNjQgd3JvdGU6
DQo+IEZyb206IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbT4NCj4g
DQo+IEluIGNhc2UgdGhlIHdyaXRlIG9mIHRoZSBmaXJzdCBieXRlIGZhaWxlZCwgcmV0bGVuIHdh
cyBpbmNvcnJlY3RseQ0KPiBpbmNyZW1lbnRlZCB0byAqcmV0bGVuICs9IGFjdHVhbDsgb24gdGhl
IGV4aXQgcGF0aC4gcmV0bGVuIHNob3VsZCBiZQ0KPiBpbmNyZW1lbnRlZCB3aGVuIGFjdHVhbCBk
YXRhIHdhcyB3cml0dGVuIHRvIHRoZSBmbGFzaC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFR1ZG9y
IEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJz
L210ZC9zcGktbm9yL3NwaS1ub3IuYyB8IDkgKysrKystLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwg
NSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KDQpBcHBsaWVkIHRvIHNwaS1ub3IvbmV4
dC4gVGhhbmtzLg0K
