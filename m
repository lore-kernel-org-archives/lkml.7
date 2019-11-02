Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA2BCA9EC7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 10:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 656B320862
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 10:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="prkKHqYx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfKBKgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 06:36:23 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:4723 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfKBKgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 06:36:22 -0400
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: tZxXQt+l0u7IbMOeYG2MLqkAsY459XZ4xXkMpuIP1AFHU0ZgSZF/4CW68tdNNJLfbSQjrDZbQW
 u5LcwSqndSBVrT2+7xTiFU+ltKLi8icccDRULEwzNZzRvk+ka/jKBlr82N54zhrjY1fn0Lm7l9
 VA6dsNgbNbPMjcP2IrdwncTiRq03jLaCvCMD587pRy2Z8iRxoXg9MMAmc0xo00squkXi5tTa6n
 HBbncq0fPVR+6FkgCQAkdNV34qThNs+QAC6D5bPtcaIaoqCPNDdaq7jI+rIMESZIIXrQG60MEY
 coQ=
X-IronPort-AV: E=Sophos;i="5.68,259,1569308400"; 
   d="scan'208";a="55427370"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Nov 2019 03:36:21 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 2 Nov 2019 03:36:10 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Sat, 2 Nov 2019 03:36:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HlJaPylm4oFn+nOsmxsw2JgpheYF68Fm+ckkG2+1Bd6DlW2sivvgxQc72xsmvJBQGJBavlGAqMiwP5Eo7RJRZvFpFeKeb9nT8xcDuVC2Rn2CMJ1Z1hYhoSB3zeziQp19KEl9um9Qx6uzXKXWI8uiBZnztTN/spB0vGEVYfUOasEYn3tE97KYCuHF1seUqXy7aicgP1zYQOuiLAIfzuifKyOv/8Qui3m1Rq3uWw7gGB/ESQzOhJphm9GsTYp0xkaMTiEdjjAigZMdXFc1UQhMlWAGV/m0my6XuoDHTn0jsGywsal6iM6dWa6b18iVWvHUJV9HOVEmf1RhKlZzwtmXKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKZhokmQFRAniK+k/URmwhSgyyU5KJ5+uQsq1lTQRCY=;
 b=AryqsSd4DIWd3GNBdBTr631cgdRe84366ZuySWcaIeVZPtpb0WlqBBB2cvpUC9i7gcqPGJpAdEeK1yEC/H1eIvFBvCwATP/prfXa7yfZk7LKxi6LjJIU5YYZFocViG9nZlltIrYChd0YGq9jrNc9cICVChlzIwzfBMi6mOdWAyLZdT+f+2c/zHzn2CM2I11PaDeoucsveJO2yTQPRXVo4TcklvBJucM2zz9lzWoNb1nGuTMBTdc3/lbBmcHBlIHOxH5K1rw/dmWgZNx/ykQYvYFzViWZiJxft6QbB7CLN/7QJg/NMPm3zlv2F/vsN+FgOOWW+/QoIf9ImOUHWzF4Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKZhokmQFRAniK+k/URmwhSgyyU5KJ5+uQsq1lTQRCY=;
 b=prkKHqYxeGAigEphrweOxzB8UpTIlY/sXmWKgbSNW/foMaiyK465/LGyu5IdwepUEhd2gpyY8gkf24jHahXpIBx7LqnQAnoNQfb0p0fQ8FTs5CmXP+3RDOvjQOEvNJWHm+S3L7r8ZYw2SQUWVMz8w61PpPbzDFWQSjVvaDlE3uY=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4223.namprd11.prod.outlook.com (52.135.37.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.25; Sat, 2 Nov 2019 10:36:09 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2408.018; Sat, 2 Nov 2019
 10:36:09 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <boris.brezillon@collabora.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 04/32] mtd: spi-nor: Stop compare with negative in Reg
 Ops methods
Thread-Topic: [PATCH v3 04/32] mtd: spi-nor: Stop compare with negative in Reg
 Ops methods
Thread-Index: AQHVjkpe3Aj10gNnVU2+wx1petwKoad3tgQA
Date:   Sat, 2 Nov 2019 10:36:09 +0000
Message-ID: <aefca32f-dfb3-c99c-a796-0d18483b5cb1@microchip.com>
References: <20191029111615.3706-1-tudor.ambarus@microchip.com>
 <20191029111615.3706-5-tudor.ambarus@microchip.com>
In-Reply-To: <20191029111615.3706-5-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P18901CA0013.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:801::23) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.120.239.29]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f060f79-b117-4806-e771-08d75f80791e
x-ms-traffictypediagnostic: MN2PR11MB4223:
x-microsoft-antispam-prvs: <MN2PR11MB4223FBFDDB8EFD3525F68325F07D0@MN2PR11MB4223.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1201;
x-forefront-prvs: 0209425D0A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(376002)(396003)(346002)(199004)(189003)(8676002)(6436002)(5660300002)(52116002)(36756003)(81166006)(4744005)(81156014)(486006)(71200400001)(256004)(7736002)(229853002)(71190400001)(25786009)(476003)(99286004)(6486002)(2616005)(54906003)(31686004)(478600001)(3846002)(6116002)(2501003)(11346002)(305945005)(2906002)(26005)(446003)(14454004)(186003)(64756008)(4326008)(6246003)(66066001)(6512007)(31696002)(110136005)(53546011)(6506007)(76176011)(66446008)(86362001)(8936002)(386003)(2201001)(66946007)(66476007)(66556008)(102836004)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4223;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fh1mAWW3PGNDPgJU6llBZc1zVceg2G+nxPk9Bo25ZTDqw1uFRpcbjQld5L46FF/OPwxMpPacBvST2oHNfHbKQG0roJuTUMmC9xIrJo5xuqU8RwB7biKYZNp2e5+F08KtiZxHRFXKeei7dMBzUrDzdjPFYmJe2od1NxzAMqMX36C2NB/QKxElryce/ahHxa0RWlJCOMhIMQITdCLT/wojVN2quGfIA+gshYw0QKVk/ucM4RD9BIjI2F1yurnZcNel8td2u68keaLzfkk9kXG7YRvK4jgesJSxEmYEmXqYqA5Fz0YBkuMyP4m9fnNAbuAWaRbh6MF0ZpEoX1J3FoG7zdhZD2ph4k4dAItyWPlE8aOMEMTCrGVcOt8FwCBoskNndBF+B9x2prt4Jb6yRBKVOMLN/yMbSFr2WA+jzE14Vuq2D6HjvtiBbnGYbRc1ES6/
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5AEA356FA25B244CB100E6BABB2B85C1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f060f79-b117-4806-e771-08d75f80791e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2019 10:36:09.0624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q+VfBKmFGRj0tIhDmcCnVzjjftNeJQppxgLvkbu3wBtzEnMT7g2FL5Ol4d9ppbD+atqJTuweQi/3OUY4lNCpepQuoPCuU27aUd2Z5s2r3yE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDEwLzI5LzIwMTkgMDE6MTYgUE0sIFR1ZG9yIEFtYmFydXMgLSBNMTgwNjQgd3JvdGU6
DQo+IEZyb206IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbT4NCj4g
DQo+IHNwaV9tZW1fZXhlY19vcCgpDQo+IG5vci0+Y29udHJvbGxlcl9vcHMtPndyaXRlX3JlZygp
DQo+IG5vci0+Y29udHJvbGxlcl9vcHMtPnJlYWRfcmVnKCkNCj4gc3BpX25vcl93YWl0X3RpbGxf
cmVhZHkoKQ0KPiBSZXR1cm4gMCBvbiBzdWNjZXNzLCAtZXJybm8gb3RoZXJ3aXNlLg0KPiANCj4g
U3RvcCBjb21wYXJlIHdpdGggbmVnYXRpdmUgYW5kIGNvbXBhcmUgd2l0aCB6ZXJvIGluIGFsbCB0
aGUgcmVnaXN0ZXINCj4gb3BlcmF0aW9ucyBtZXRob2RzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
VHVkb3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29tPg0KPiAtLS0NCj4gIGRy
aXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jIHwgMjMgKysrKysrKysrKysrKy0tLS0tLS0tLS0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCg0K
QXBwbGllZCB0byBzcGktbm9yL25leHQuIFRoYW5rcy4NCg==
