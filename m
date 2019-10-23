Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E964CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 21:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E710D2084C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 21:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="I8LL2BuR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407426AbfJWVWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 17:22:09 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:25231 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406354AbfJWVWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 17:22:09 -0400
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: B0yzWFEFA9iilFlC95sNZ8/vhiG7A/Cb9oFUXG+RKR2Khm5icCwcvIm4Fq81e6lHFp/BCQVVTF
 43QtS1wrw7Jl7jWZWrhJhbcqYvG5afNBHeGnS7ZhmlkFrXYqg+qZS/9qA0J6+pbxeJSjCKFM/U
 5UslmMLxBlC9ws3dckBFFKPz9mKYAhUBru5grWqRvqy0vs3c6EnZ18s3as9jVorLpJ+cToqCvy
 ywRWcGTQXjqTeJMuuvK1RTanhVRdwqtswzaPCQ598q5dmUW6mrsoAzYDZyRst0+TvRQN+sNnFD
 6fM=
X-IronPort-AV: E=Sophos;i="5.68,222,1569308400"; 
   d="scan'208";a="52671808"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Oct 2019 14:22:08 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 23 Oct 2019 14:22:07 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 23 Oct 2019 14:22:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=axow9Yb9YhwvoAwEVVRznRfGSNbuQLN9FsReph6yb9vG0DQibDJlxzsX6gCf1QqcEJkTmshPwyoNn0gOwX6gGkEi9sQwgf3BORDTwSWsAPxsZmRZPvdG+6PQTnr/2eD3CeM1UneYfCGHIcfxD4rnWMHLeSOL4/BgsOfW7ygFZ6+IFA5CnsToRP45kLCuFM4qcwJ6LSiBOPq28CyR9nG2OwC8nqnUEHpDwjtegS9mzZZknui2yVDPvYWqmzRzLmBb3gEXLMt0FoNGlRFcgAoK3J8LdzBVQSIM3pArT74tTpNWhv6XSJMY4KjmLPImNBfYk/rJ04slLIERe6qBOLL2ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3S8knFwXDkPLe8pFQjKxsdFeoK0SUUfViX9afafjPA=;
 b=DOGcV7cSB1N8NI3zGGvQ7FjOlgyac5Lc/x6/l1mRb3tbWzH2yCb9iB9XfB15LxZmsH3nbOyAoRVbmYcVtu3yfLpYiw6lqQQ4Dp4/i8Nm0cHJXWQPPZzSJQF+8IKT7FtI55cQo6WgFCnQSeg4kB6fVQim7nKLIu6YsmkJeHlEBAdW2gqXea+d+s3AnL+WVkiZF2tv6d1N4U9flOJAwOn69ncOJXEg9IuWOyNrI131AFjhgj71zG517v0jhurxxDWFGYKHhD9Oc71fDLnIfgG2b9qpwn92fhSKnfmgDd0KlwOSl6wUkGyccIrm6KXyWEq3T/aACICErqHCLSHt7IpbXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3S8knFwXDkPLe8pFQjKxsdFeoK0SUUfViX9afafjPA=;
 b=I8LL2BuRud5y9e/B3CLuFAHJZa2GZrQXzcByluvcxaee44mMoMjqTopSDrO4fy6FWAr8PRN/bUvAit9sbGb6XxWYYcXqoAFN3RpHmnGDm58+N3vno4kVSJG8zlxehKLnK5i3WwVvbB3oFQGuMUe6ncTlh16kf4wtoiPACBvga0Y=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4416.namprd11.prod.outlook.com (52.135.36.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.18; Wed, 23 Oct 2019 21:22:05 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2347.029; Wed, 23 Oct 2019
 21:22:05 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <jethro@fortanix.com>, <marek.vasut@gmail.com>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] mtd: spi-nor: intel-spi: support chips without
 software sequencer
Thread-Topic: [PATCH v2 1/2] mtd: spi-nor: intel-spi: support chips without
 software sequencer
Thread-Index: AQHVYr406/tKUl7vTUifobCqeM8uGadpCk2A
Date:   Wed, 23 Oct 2019 21:22:05 +0000
Message-ID: <dbe981f1-9910-4c71-741e-f403d2b7f984@microchip.com>
References: <69f4a8e8-7889-8b00-0adc-7faaef6b42e4@fortanix.com>
In-Reply-To: <69f4a8e8-7889-8b00-0adc-7faaef6b42e4@fortanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR06CA0103.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::32) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.120.239.29]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 46a9c57b-c9f2-4fdf-d599-08d757ff0d7c
x-ms-traffictypediagnostic: MN2PR11MB4416:
x-microsoft-antispam-prvs: <MN2PR11MB4416364B734D3B47A9C2DFB7F06B0@MN2PR11MB4416.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 019919A9E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(376002)(346002)(366004)(199004)(189003)(8936002)(8676002)(110136005)(71200400001)(478600001)(31686004)(66556008)(81156014)(2501003)(64756008)(66476007)(66446008)(66946007)(31696002)(2201001)(66066001)(81166006)(71190400001)(14454004)(86362001)(7736002)(476003)(6512007)(3846002)(5660300002)(52116002)(386003)(256004)(2906002)(99286004)(316002)(25786009)(11346002)(2616005)(486006)(446003)(6486002)(6436002)(4744005)(229853002)(76176011)(6246003)(26005)(14444005)(186003)(305945005)(6116002)(53546011)(6506007)(36756003)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4416;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t3txyZNw0CMG35kffQq8uEAMZxEZSRfkNJLjmiYkt1X7EiHQDZcgedvogQFuuBJD9EF9lXyki43NzneXnl7170yyHN9u/1QuIX4ZfK+p+VRFIEo9zgw4pROC1wk96yN8gwlzp6GcKSZ6WoNXelciITVbtXGU31YmKUpPjYmfARd7zUA74DORHPIF7s/9NiWWm/YTU2A3BSBI7Xyp0OeFmvgpBmBthiPOO+W0+sYWWDTNVMcgiyLXOGd01ZjbHO3Dp8ThRZO0YntwPC/4O4z2iEc73Yxu5gf474W5CZgHmHfUE49iAenNtKi7u0gWsJz3bYEmybB/NST4gTlyZ5p5B5gR4sITIuJDbjz1K9cPQh03ozaY2c6YVpDdpPkLvJvtbfGT3C+CBqwq0jHRvu2/YzBpgo62DD//Agxwjmj5c0erxVdqnIf24vvAcEmYXzo5
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <333F84BAB07DF641962868FCBA98C2FA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 46a9c57b-c9f2-4fdf-d599-08d757ff0d7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 21:22:05.2285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XPE6zFXjiQXFWlhNODeAlEaYglvLjewXOgLsQpBNt1RiEQtJzYNWTB6ykfTNTW0WRuKlX6c4VyvLIbNnj3izDB1aYgGkhv4fk6fuqM7hmoU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4416
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA5LzA0LzIwMTkgMDQ6MTUgQU0sIEpldGhybyBCZWVrbWFuIHdyb3RlOg0KPiBFeHRl
cm5hbCBFLU1haWwNCj4gDQo+IA0KPiBTb21lIGZsYXNoIGNvbnRyb2xsZXJzIGRvbid0IGhhdmUg
YSBzb2Z0d2FyZSBzZXF1ZW5jZXIuIEF2b2lkDQo+IGNvbmZpZ3VyaW5nIHRoZSByZWdpc3RlciBh
ZGRyZXNzZXMgZm9yIGl0LCBhbmQgZG91YmxlIGNoZWNrDQo+IGV2ZXJ5d2hlcmUgdGhhdCBpdHMg
bm90IGFjY2lkZW50YWxseSB0cnlpbmcgdG8gYmUgdXNlZC4NCj4gDQo+IEV2ZXJ5IHVzZSBvZiBg
c3JlZ3NgIGlzIG5vdyBndWFyZGVkIGJ5IGEgY2hlY2sgb2YgYHNyZWdzYCBvcg0KPiBgc3dzZXFf
cmVnYC4gVGhlIGNoZWNrIG1pZ2h0IGJlIGRvbmUgaW4gdGhlIGNhbGxpbmcgZnVuY3Rpb24uDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBKZXRocm8gQmVla21hbiA8amV0aHJvQGZvcnRhbml4LmNvbT4N
Cj4gLS0tDQo+ICBkcml2ZXJzL210ZC9zcGktbm9yL2ludGVsLXNwaS5jIHwgMjMgKysrKysrKysr
KysrKysrKy0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCA3IGRl
bGV0aW9ucygtKQ0KDQpBcHBsaWVkIHRvIHNwaS1ub3IvbmV4dC4gVGhhbmtzLg0K
