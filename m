Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892D8C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7AD220855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VJLrsHwl";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="G/urXn2R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbfDDNCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 09:02:43 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:6729 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728159AbfDDNCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 09:02:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1554382963; x=1585918963;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2LxRBG+bjKdJmTDYJdHMfLyq/vf8R6fXEs1CWCQ+c6s=;
  b=VJLrsHwlQlyooicmiIQeSbg+uyrpBjLBwvxuOsQPYK/k9Sobke6iMsYr
   vANpknsSrgEFup6EnRahddGoiy7lGB0lVqYwwExN2vdBo55MywUh+RBZe
   RRactr5F3nENEyCu5Rsf0bYU798dVmtiRAGYd3S4B3yoaElJipXpfc2ey
   vQ1UPktlYQRUrlUa9EU8xadTh3jf71twBRkIAvkl0R+4BAKxY/4KpsuoC
   YK0R+YLVP/0Et1Pd1tDsHiwc+UIlbm+eVWHAlp1O7jkOX99KNu08QI9oH
   ZhWvIxIdsPFjcbVM5mVacDTyia1J/WrJd/xh53KdgbdB53VOKNaYAxGsX
   A==;
X-IronPort-AV: E=Sophos;i="5.60,308,1549900800"; 
   d="scan'208";a="106351444"
Received: from mail-by2nam01lp2059.outbound.protection.outlook.com (HELO NAM01-BY2-obe.outbound.protection.outlook.com) ([104.47.34.59])
  by ob1.hgst.iphmx.com with ESMTP; 04 Apr 2019 21:02:37 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2LxRBG+bjKdJmTDYJdHMfLyq/vf8R6fXEs1CWCQ+c6s=;
 b=G/urXn2RmcDo/KBvwVGfV5o3sXaFfDI9HBOLtKCxxT+N5I2Xni9ONpjp4oaEil1GZQJAUm7SSQjVlkOpBQubEVn+T/kliXHp/qOYk2027RPnLCYkQsDyFl8HBIT2TDjW5P35FUMOwOnnpVJLOSFDzXe/+88O1t1YBhEsmpR5uYc=
Received: from SN6PR04MB4925.namprd04.prod.outlook.com (52.135.114.82) by
 SN6PR04MB5277.namprd04.prod.outlook.com (20.177.253.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.17; Thu, 4 Apr 2019 13:02:34 +0000
Received: from SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::41d5:ff9d:9889:6d66]) by SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::41d5:ff9d:9889:6d66%2]) with mapi id 15.20.1771.014; Thu, 4 Apr 2019
 13:02:34 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Douglas Gilbert <dgilbert@interlog.com>
CC:     Alim Akhtar <alim.akhtar@samsung.com>,
        SCSI <linux-scsi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: correcting incorrect peripheral device type 0x0
Thread-Topic: correcting incorrect peripheral device type 0x0
Thread-Index: AQHU6pdDxWIvHAc/ikWG8Iy8lFyBPaYr5z2AgAAOKOA=
Date:   Thu, 4 Apr 2019 13:02:34 +0000
Message-ID: <SN6PR04MB4925C4CBA85C47CF865C3732FC500@SN6PR04MB4925.namprd04.prod.outlook.com>
References: <ab8d589f-db76-9a95-1b55-3e906ad89487@free.fr>
 <yq1zhp6satq.fsf@oracle.com> <69474538-b097-f672-a263-aefd5958dc90@free.fr>
In-Reply-To: <69474538-b097-f672-a263-aefd5958dc90@free.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7c2703a0-9a4d-4925-ead4-08d6b8fdce43
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:SN6PR04MB5277;
x-ms-traffictypediagnostic: SN6PR04MB5277:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB52770E8761B896079CFD759DFC500@SN6PR04MB5277.namprd04.prod.outlook.com>
x-forefront-prvs: 0997523C40
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(136003)(366004)(396003)(346002)(199004)(189003)(74316002)(9686003)(229853002)(71200400001)(476003)(486006)(105586002)(106356001)(68736007)(53936002)(11346002)(446003)(76176011)(81166006)(81156014)(33656002)(52536014)(3846002)(7696005)(4326008)(6116002)(6506007)(8676002)(305945005)(14444005)(14454004)(54906003)(72206003)(25786009)(4744005)(26005)(97736004)(256004)(86362001)(99286004)(102836004)(6246003)(66066001)(316002)(2906002)(110136005)(6436002)(55016002)(8936002)(478600001)(186003)(71190400001)(5660300002)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB5277;H:SN6PR04MB4925.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2kAAeVVXfcyzPQevPHKxXvBqX57YLISsWemwRUkuPiiDrmX5DVDYiunEgmWNsFVxhbV1t/0to8x8BGPIc3Il5YEQhWVIAPYs0fXFv8hZPt9CNaaHmJHN5qzpf5UvLWyYpy1nXj74Rlu4N4o+ia5d6RO4yFCy+iqEwgL0Z1rc8RlN9/23TDQAnViuLPEigwGtflISd/zt83BgBBx7vQQMurrApCn4U2oJXd6dDqvTHufyO8t7i1S86rVpdraXSFoImqWPX54GHCfQ2c/oWM84MpVl+cs5qVy7sYDvZjDORfNxft4h8ZeaekY1oOYMA2k5AtS9RtgNEwzisv833MJJqEc+gvuQuWPBF0Zx0BlDXrg/5AQwRaNuTM5cKcfvLslyjUTjZ/lvyR4ogrmEUsNgp9t9HNmnQgftuEUM+VTiScY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c2703a0-9a4d-4925-ead4-08d6b8fdce43
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2019 13:02:34.4877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5277
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IA0KPiA+IE1hcmMgd3JvdGU6DQo+ID4NCj4gPj4gc2NzaSAwOjA6MDo0OTQ4ODogc2NzaV9h
ZGRfbHVuOiBjb3JyZWN0aW5nIGluY29ycmVjdCBwZXJpcGhlcmFsIGRldmljZSB0eXBlDQo+IDB4
MCBmb3IgVy1MVU4gMHggICAgICAgICAgICBjMTUwaE4NCj4gPg0KPiA+ICAgICAgICAgICAgIF5e
Xl5eIFdoZXJlIGRvIHRoZXNlIGNyYXp5IExVTiBudW1iZXJzIGNvbWUgZnJvbT8gVGhhdA0KPiA+
ICAgICAgICAgICAgIGxvb2tzIGxpa2Ugc29tZXRoaW5nIHdoaWNoIG5lZWRzIGZpeGluZy4uLg0K
PiANCj4gCXNkZXZfcHJpbnRrKEtFUk5fV0FSTklORywgc2RldiwgIiVzOiBjb3JyZWN0aW5nIGlu
Y29ycmVjdA0KPiBwZXJpcGhlcmFsIGRldmljZSB0eXBlIDB4JXggZm9yIFctTFVOIDB4JTE2eGhO
XG4iLA0KPiAJCQlfX2Z1bmNfXywgc2Rldi0+dHlwZSwgKHVuc2lnbmVkIGludClzZGV2LT5sdW4p
Ow0KPiANCj4gV2hhdCBkb2VzIHRoZSAiaE4iIHN1ZmZpeCBzdGFuZCBmb3I/IEl0IHNlZW1zIHJl
ZHVuZGFudCB3aXRoIHRoZSAiMHgiDQo+IHByZWZpeC4uLg0KPiAoTG9va3MgbGlrZSBoTiBtaWdo
dCBiZSAiaGV4YWRlY2ltYWwgTnVtYmVyIikNCj4gDQo+IA0KPiBzY3NpIDA6MDowOjQ5NDg4IC0+
IDB4YzE1MA0KPiBzY3NpIDA6MDowOjQ5NDc2IC0+IDB4YzE0NA0KPiBzY3NpIDA6MDowOjQ5NDU2
IC0+IDB4YzEzMA0KVGhvc2UgYXJlIGNvbWluZyBmcm9tIHVmc2hjZF9zY3NpX2FkZF93bHVzKCks
IA0KSW4gd2hpY2ggd2UgY2FsbCBfX3Njc2lfYWRkX2RldmljZSgpICBmb3IgZWFjaCBvbmUgb2Yg
dGhlIDMgdy1sdW5zOg0KVUZTIERldmljZSAtIDB4NTAsIEJvb3QgLSAweDMwLCBSUE1CIC0gMHg0
NC4NCkV2ZXJ5dGhpbmcgc2VlbXMgaW4gb3JkZXIuDQoNClRoYW5rcywNCkF2cmkNCg==
