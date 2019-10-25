Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D106FCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 06:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B94520867
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 06:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="uUGAJE1e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405962AbfJYG7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 02:59:45 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:63194 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405864AbfJYG7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 02:59:44 -0400
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: WpMPd/3qHhjuNhqunq0mnyNDbhC9Oe80eurncOKXp+imaA9bwFEyIV+91E1LD3qB2wsCgt1wbb
 XFitdOTSJAVhfUZIwiZQeWDDAotzsI4ts9nvbN94cuee67xISnIBIarkfTtU2JCaLYTYJW4mau
 rtbKRNs/XSUvCOT6p1hfIXOcApV5Q3cZpbR9sN44Q/7aItnewOYXbCkHcqfkCI8p9YrXy5ZXAT
 lnAeP3jpMrH767Ajvc+D+JVA7473yTz75Z6hoC2SOjARP+Czpm00I3yKiChRBdLgD0M6sKZJS1
 wkQ=
X-IronPort-AV: E=Sophos;i="5.68,227,1569308400"; 
   d="scan'208";a="54058074"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Oct 2019 23:59:43 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 24 Oct 2019 23:59:43 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Thu, 24 Oct 2019 23:59:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIQLAhG4r8u4SJlejTsSrLqT1ndT+0fKbIa4szpPHmZwNkHKG2y7AS3s2lZuUnSZvpuLNChnanqzXVwL9uX2vRBQXFiUFQIJ7/AFXG9dnoSyaq/LHEp0bF2oO2CYDfmvedF6nTe/7UyNCvnnzVdi9hNzwXnparfakdUF10i+nH3NPJtecOSEweTN1utU5KP6J5wLoUny+nSYxFtBY6CXMwOy849ZlrQ+RwLnexxswi+xUqAQH/pYH5LshdpvG6Q0Lssvjj82mjx9MYWiBSRa4+Rrm0Q07pPIK8HCGUHbwK4Fw3xmZR+756xe1HAoUfzV9OHm84y0l0e4tBvrFavUpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dwxj+V2SqQ5FkCpx0Kr//KASxasTejkuoiTZGzxwOfs=;
 b=mBeVR9VP6x7iW6sUzscfUfCSM82GCM9De03YfbX3FT629SjgUBoUE3vz3J7FUlGr1Zhd7/K07/QRM2W2u4eKuTh3CUsi41SulVO6+cgN3gX4kA4SIxAI/QzbTrY1heBi0+cNocJhgHkN5x+9Q625U1sa+mEYS8PNiBEMxttQZv6K1fYSOR/DLl6Wo8bAUgcMRTjqi/lRtHUc5tG/3q8+BY9y+BroSg2Ud/8daO9jMBGFKroDM7Yj2ROYa1hEsEQOSGlbWPp39JwjiqXWQN1+e1vP33d+TI8lDNcjS0W81Dclq/X50Ql28TlDRj0fqFVRosuP7LnllcE/TnJC7VcYJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dwxj+V2SqQ5FkCpx0Kr//KASxasTejkuoiTZGzxwOfs=;
 b=uUGAJE1eyuPRLtIB8Qftp+n+NAXr1Kdmz1ZH/ds38FJPzCkRGdnNsNHPAf4A4xhayMkxKi8Fyhp6Gpu6VkMaN6Zv5otZ3hAo42zrTNte3AEtemwSCUBpB8ZFsphdQUL7jBS5OTr/tz4xL8O5ZJE7CyfRI583f3uzvGO6zf5pC5I=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4383.namprd11.prod.outlook.com (52.135.36.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Fri, 25 Oct 2019 06:59:37 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2347.030; Fri, 25 Oct 2019
 06:59:37 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <geert+renesas@glider.be>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>, <trivial@kernel.org>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH trivial] mtd: spi-nor: Spelling
 s/Configuraiton/Configuration/
Thread-Topic: [PATCH trivial] mtd: spi-nor: Spelling
 s/Configuraiton/Configuration/
Thread-Index: AQHVioBPYn+aX+Y/J0OXaVDDS91dAqdq7n4A
Date:   Fri, 25 Oct 2019 06:59:36 +0000
Message-ID: <0ac009fe-3689-c43a-0c90-7a7a9541b913@microchip.com>
References: <20191024153230.31251-1-geert+renesas@glider.be>
In-Reply-To: <20191024153230.31251-1-geert+renesas@glider.be>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR0P264CA0068.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1d::32) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.120.239.29]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 798c4c9d-2112-4c02-2b2c-08d75918e5e9
x-ms-traffictypediagnostic: MN2PR11MB4383:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MN2PR11MB4383C674E4C9ED5131C9A7A2F0650@MN2PR11MB4383.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02015246A9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(136003)(346002)(39860400002)(199004)(189003)(4326008)(6246003)(6436002)(6306002)(31686004)(6486002)(6116002)(229853002)(6512007)(2906002)(25786009)(7736002)(54906003)(110136005)(305945005)(3846002)(5660300002)(66476007)(66556008)(64756008)(66446008)(71200400001)(71190400001)(66946007)(476003)(4744005)(36756003)(8676002)(81156014)(81166006)(8936002)(26005)(31696002)(52116002)(99286004)(478600001)(14444005)(256004)(966005)(446003)(102836004)(86362001)(11346002)(14454004)(6506007)(386003)(76176011)(53546011)(2616005)(486006)(186003)(66066001)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4383;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QbnhLMJEZOmd8jX/dmQhxoppT52fP8Bb3ZsqhMjzQv1un9nWscHl287Br0tkpvR6/jIyNVLoA3bTjwyX32fW65E722tlTe/unK++xFvfNXNPqV/ay0iFIL692SLvjJcPOQETgO/mKeLkawNwzUr/YsZ9gxJifBql9mCUYO0XL6doJaZvconJ/0CNzx53nvWDSNl7BYpI7aSVW5Efg/BbU0Y99cT8jbmM51W2sOkwbZixCZCnuucFuBsGNELXTq/D3I7wsaRKHf62zZkUtInnf9d4bG9w4BCOcDDlBrWqEng8dR+BF7uxokanJ7YkJoWWDuaHm4fsuDBvM3vd3WtxLIHof2vQW2tmpFeh5hK1tvFCdU8s/4oSNLbHdng5inmOzCx4/OGqlNqefxNCaa0rUs95cOmGJWfqJqBkovDyLUVR3nxBm33hJjoWrBZ7eUtFB+XsXVF/fq7WhnBSYHlFHR+uesj2GSOdL4VMjjei/us=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8CC39A4E5E22E34FA7337D4645465BBE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 798c4c9d-2112-4c02-2b2c-08d75918e5e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2019 06:59:37.0113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rAlcZUIt18ThYweFw79DVBP8eTsogcR0wYv6PO+vn6MbsivuYym7Ox0nH7LrvD4MpZYPStx0osG4inH9zat2SkJ9yMBb2vAgrI4cMrPLbto=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4383
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDEwLzI0LzIwMTkgMDY6MzIgUE0sIEdlZXJ0IFV5dHRlcmhvZXZlbiB3cm90ZToNCj4g
Rml4IG1pc3NwZWxsaW5nIG9mICJDb25maWd1cmF0aW9uIi4NCg0KVGhhbmtzLCBidXQgSSdtIHRy
eWluZyB0byBnZXQgcmlkIG9mIHNwYW5zaW9uX3F1YWRfZW5hYmxlKCkuIFdpbGwgZ2V0IHJpZCBv
Zg0KdGhpcyB0eXBvIHdoZW4gcmVtb3ZpbmcgdGhlIGZ1bmN0aW9uLg0KDQpodHRwczovL3BhdGNo
d29yay5vemxhYnMub3JnL3BhdGNoLzExNjY0MTYvDQoNCj4gU2lnbmVkLW9mZi1ieTogR2VlcnQg
VXl0dGVyaG9ldmVuIDxnZWVydCtyZW5lc2FzQGdsaWRlci5iZT4NCj4gLS0tDQo+ICBkcml2ZXJz
L210ZC9zcGktbm9yL3NwaS1ub3IuYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3Nw
aS1ub3Ivc3BpLW5vci5jIGIvZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9yLmMNCj4gaW5kZXgg
N2FjZjRhOTNiNTkyMzExNi4uOTcwM2U4NzI1ZjQxYjE1OCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9tdGQvc3BpLW5vci9zcGktbm9yLmMNCj4gKysrIGIvZHJpdmVycy9tdGQvc3BpLW5vci9zcGkt
bm9yLmMNCj4gQEAgLTE3MzUsNyArMTczNSw3IEBAIHN0YXRpYyBpbnQgbWFjcm9uaXhfcXVhZF9l
bmFibGUoc3RydWN0IHNwaV9ub3IgKm5vcikNCj4gIH0NCj4gIA0KPiAgLyoqDQo+IC0gKiBzcGFu
c2lvbl9xdWFkX2VuYWJsZSgpIC0gc2V0IFFFIGJpdCBpbiBDb25maWd1cmFpdG9uIFJlZ2lzdGVy
Lg0KPiArICogc3BhbnNpb25fcXVhZF9lbmFibGUoKSAtIHNldCBRRSBiaXQgaW4gQ29uZmlndXJh
dGlvbiBSZWdpc3Rlci4NCj4gICAqIEBub3I6CXBvaW50ZXIgdG8gYSAnc3RydWN0IHNwaV9ub3In
DQo+ICAgKg0KPiAgICogU2V0IHRoZSBRdWFkIEVuYWJsZSAoUUUpIGJpdCBpbiB0aGUgQ29uZmln
dXJhdGlvbiBSZWdpc3Rlci4NCj4gDQo=
