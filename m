Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96FDCA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 14:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 801C92083E
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 14:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="B9EbPqdi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbfJaO0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 10:26:20 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:5132 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727862AbfJaO0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 10:26:20 -0400
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: wwGWFDu7QhdAxv+PF9O2hWrWGT49+t086N/oAzIxIBLQmHvCWMp9GOMSSiJOlvydQIub/LcXJU
 CRZC2NIGn23up2X1RFyNmjAe0vl4Z3yLvAvsYbyVwhtPTF0wXYDjkMVGrFyKsmDvNFFzhbmtbO
 z9pBj7iZ0atP6DeEYEey2FpOZpUDnXC5TtQHHKfdWjnGMsR+P6ei7efg1J67reMDj2GC0emwss
 Jsddp5yXLhBEpzotHUnunJCiwYhuxdM5sgEoilNRa6ZNUa8cufCqs9Z4ttDdgojy9ojj2Yev2N
 70k=
X-IronPort-AV: E=Sophos;i="5.68,250,1569308400"; 
   d="scan'208";a="52346302"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Oct 2019 07:26:18 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 31 Oct 2019 07:26:18 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 31 Oct 2019 07:26:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OgqMZaZXXA7kB6knWCMVTxupD7UI2gEztcYB4+KCVb+lu/CPWoRNn2dOfaAAo5EttSgFbYzIwJDEqlXMEV24wn0ASk8MVVNu5Bjf2pRraDzeQbafXutqBgEdhoPk4DkiIlrJ8J6VHwaEAwJIcmyrtVjk3AHVWyDSKVa3vqHMBBuPwGRwfiBYJ2JzddRs79swaGCV8XVXLe1RgWmnxKwpffP21sFpBm0cZ4JqA1zP20jFmT6eeFP2FZ7FzdrE4NlDJe74MwMg1jQJS2tCb9arTw6LH1DZlR4iUPAFWZjjZk3wFNYWXp0Tc+anm8iWIB7mus1fL44uU0EwkQ+dPL5pog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a22TJkfWtwtA4OLzYgMIiq0VB27cOFVJTDk7/um822I=;
 b=YElM/UoYZsIEMVSyMGXF8d3Ix9FRWfgIhkQf+btErz4tz39FjFt1MPXWME6xU0dGbfJAbKXWcUCGd3vv6aLENdTYG2UXyPHxusRSLHRbStizKu9QZD/vLj8Mi3GQvMkykOa5uEgjsHwL+SYCWlQCJjUBLeFq76zvAQDT6ZWuMDmYvSXTijOJkHdPW2DcS5s2bt0eG1niJzGq6s6EQGJ0HR2VF7Kk2yXGmtjREkcPcTFZCPYnXAnVvo9SPbkmFc3FiFQ1b3F4OqOEvCExBoFq9KtpIuxcGIlFLoGTZSwjQwevr8WiCSB3RQ0h+7xScIyHWW62KI3YxjL7d1My0yLSBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a22TJkfWtwtA4OLzYgMIiq0VB27cOFVJTDk7/um822I=;
 b=B9EbPqdiOwjo4089y4BL4KhRB1RrUahi0GPs2EzKqdfuBYIKKQetSbLP2zqHiDS6wGINJsy/kBJCiCmFTRrtiiKjiq9+S5UuuhNy5HNe092hrUXf4fa0qoe8nTEYVt1hQ9HVJAVsYx7YC5gKmpoRwU4oq+kREoZk3fY+Nqo6KzY=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4480.namprd11.prod.outlook.com (52.135.39.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Thu, 31 Oct 2019 14:26:17 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2408.018; Thu, 31 Oct 2019
 14:26:17 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 10/32] mtd: spi-nor: Pointer parameter for CR in
 spi_nor_read_cr()
Thread-Topic: [PATCH v3 10/32] mtd: spi-nor: Pointer parameter for CR in
 spi_nor_read_cr()
Thread-Index: AQHVjkpkiF1slcDF2Ua4XfvPGlZW3Kd0l8wAgAA55wA=
Date:   Thu, 31 Oct 2019 14:26:17 +0000
Message-ID: <f203cc52-7082-5e89-e6de-9bf44dafebb3@microchip.com>
References: <20191029111615.3706-1-tudor.ambarus@microchip.com>
 <20191029111615.3706-11-tudor.ambarus@microchip.com>
 <20191031115856.4dacc552@collabora.com>
In-Reply-To: <20191031115856.4dacc552@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0093.eurprd08.prod.outlook.com
 (2603:10a6:800:d3::19) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.120.239.29]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 34207ea3-7c39-4786-0bfb-08d75e0e4a84
x-ms-traffictypediagnostic: MN2PR11MB4480:
x-microsoft-antispam-prvs: <MN2PR11MB448017B48C11B6B42B49EBEEF0630@MN2PR11MB4480.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02070414A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(396003)(39860400002)(136003)(189003)(199004)(53546011)(386003)(6116002)(52116002)(186003)(7736002)(26005)(66476007)(66556008)(305945005)(71200400001)(66946007)(64756008)(102836004)(66446008)(6506007)(486006)(5660300002)(6916009)(71190400001)(229853002)(76176011)(3846002)(476003)(6246003)(11346002)(2616005)(446003)(31696002)(36756003)(6512007)(86362001)(316002)(8676002)(6486002)(66066001)(2906002)(81156014)(6436002)(25786009)(4326008)(81166006)(54906003)(99286004)(8936002)(31686004)(14444005)(256004)(14454004)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4480;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kpcBR3rhmIjSYYwl4dxtY58FkhvRHuGzckhAfWWYGy9TdR/zqGcBfWeZ5zFaT0Bdq7Fy7GodYMCwWuRi1qIsu78HcgSOkE4vEvMLOdH+4AVqevTyrbbzAao3E9P836iUjWuP8f8APd57vByI5y3o/1iOSX/YFEW81t/OuvYsu5+Lq3B2Xi116zxWTc3zQXXFNAGXWRM32pbZ8ZEde1fO0XgDhZkTI91ErNkxFhaI8TNo5X2qRMrX4DmWDVCJdvXPriwexHcJsVKzgZIG3eoAIR2qAfMnUXckPt02w/D4r5vZLUm3AN/Kf7g1MmEZKcZZI0E3M7iLoRr2tjxFCtp2ZrZnKA8+DBsp3FUEw1q/Y9hlyauZHr0GUrRo7GPEJU8MHLg67CTlL93d5YJDOlMR24W+Na+qqGuYJYtMKEltIkzCKHC1SV6iSCX252BVrP0i
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5BF333E6E7A5644EA4F7A7A4F2402EAB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 34207ea3-7c39-4786-0bfb-08d75e0e4a84
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2019 14:26:17.1913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NoZ7J4TYKFQiW02dfBycN8wUiFGeHEwDHGyuM38fXwZZ2tO48kbDN+egWykKC22NJNxG0gFGw8mDZmGAXynek8JmTPMALFLX7Y2ke1p9Vsk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4480
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDEwLzMxLzIwMTkgMTI6NTggUE0sIEJvcmlzIEJyZXppbGxvbiB3cm90ZToNCj4gRXh0
ZXJuYWwgRS1NYWlsDQo+IA0KPiANCj4gT24gVHVlLCAyOSBPY3QgMjAxOSAxMToxNzowNCArMDAw
MA0KPiA8VHVkb3IuQW1iYXJ1c0BtaWNyb2NoaXAuY29tPiB3cm90ZToNCj4gDQo+PiBGcm9tOiBU
dWRvciBBbWJhcnVzIDx0dWRvci5hbWJhcnVzQG1pY3JvY2hpcC5jb20+DQo+Pg0KPj4gTGV0IHRo
ZSBjYWxsZXJzIHBhc3MgdGhlIHBvaW50ZXIgdG8gdGhlIERNQS1hYmxlIGJ1ZmZlciB3aGVyZQ0K
Pj4gdGhlIHZhbHVlIG9mIHRoZSBDb25maWd1cmF0aW9uIFJlZ2lzdGVyIHdpbGwgYmUgd3JpdHRl
bi4gVGhpcyB3YXkgd2UNCj4+IGF2b2lkIHRoZSBjYXN0cyBiZXR3ZWVuIGludCBhbmQgdTgsIHdo
aWNoIGNhbiBiZSBjb25mdXNpbmcuDQo+Pg0KPj4gQ2FsbGVycyBzdG9wIGNvbXBhcmUgdGhlIHJl
dHVybiB2YWx1ZSBvZiBzcGlfbm9yX3JlYWRfY3IoKSB3aXRoIG5lZ2F0aXZlLA0KPj4gc3BpX25v
cl9yZWFkX2NyKCkgcmV0dXJucyAwIG9uIHN1Y2Nlc3MgYW5kIC1lcnJubyBvdGhlcndpc2UuDQo+
Pg0KPj4gU2lnbmVkLW9mZi1ieTogVHVkb3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BtaWNyb2No
aXAuY29tPg0KPiANCj4gUmV2aWV3ZWQtYnk6IEJvcmlzIEJyZXppbGxvbiA8Ym9yaXMuYnJlemls
bG9uQGNvbGxhYm9yYS5jb20+DQo+IA0KPiBUaGVyZSdzIGp1c3QgdGhpcyAmbm9yLT5ib3VuY2Vi
dWZbMF0gdGhhdCBJJ2QgcHJlZmVyIHRvIGJlIHR1cm5lZCBpbnRvDQo+IG5vci0+Ym91bmNlYnVm
IGlmIHlvdSdyZSBva2F5Lg0KPiANCg0KSSB1c2VkICZub3ItPmJvdW5jZWJ1ZlswXSBhbmQgbm90
IG5vci0+Ym91bmNlYnVmIGZvciBjb25zaXN0ZW5jeSByZWFzb25zLCBidXQNCnN1cmUgSSBjYW4g
dXBkYXRlIHRoaXMuIFdoZW4gd3JpdGluZyB0aGUgU3RhdHVzIFJlZ2lzdGVyIHdpdGggdHdvIGJ5
dGVzLCBpdA0KaGFwcGVucyB0aGF0IGluIHRoZSBjb2RlIEkgcGFzcyBwb2ludGVyIHRvIHRoZSBz
ZWNvbmQgYnl0ZSwgc28gJm5vci0+Ym91bmNlYnVmWzFdLg0KDQpJJ20gb2sgd2l0aCBib3RoIHdh
eXMsIGFuZCBzaW5jZSB5b3Ugc2lnbmFsZWQgaXQsIEknbGwgY2hhbmdlIGFjY29yZGluZyB0byB5
b3VyDQpzdWdnZXN0aW9uLg0KDQpUaGFua3MgZm9yIHJldmlld2luZyB0aGUgc2VyaWVzIQ0K
