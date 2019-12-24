Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04AA8C2D0C0
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 00:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5C4320643
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 00:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="nfq+JgaJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbfLXA3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 19:29:21 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:24080 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbfLXA3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 19:29:21 -0500
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: vZNaaRtZBFkRG9hMLwkbsNkHNrkr1PZqsgBvdSmi+tJTgwptMmB4lmZhlV94aSFiA1b2KtW6o7
 O6AZxRM5qmyGN2wDF1gIH2Xmm+6KWqeyvP0VmbjhJG958/j2vqQm2HEgctfonb700j0ADTKNp9
 yzGzZuK9+I2YHyhNDvF5iy3plebJKehpzgTuH4u5WuR/JgUs4N+0NlIumeknjJO1va7vjfH74D
 kU9b8sbi1K7UejLJbPkB1JBUg5v72xPuMiuY0Y3gIrPMngwydIvhObrZnOQvxlhq4ZHIBbGi2I
 iV8=
X-IronPort-AV: E=Sophos;i="5.69,349,1571727600"; 
   d="scan'208";a="60826018"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Dec 2019 17:29:20 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 23 Dec 2019 17:29:20 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 23 Dec 2019 17:29:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVkBDzs1jVouKTFtAq9ddsH6Pv+8Fd5Ul8+lNgkjkN62SJbBZxOOF+94iUqVyxmtSfQhLaam9eVO6J8ZUbZ03dOc43zONeip9EDxd5eyPDAKiYCKWVLR/KGxGutC5FaEhXa+PZ5ZhzTWcDhmAuI+Z/gXQisSQiDvt/tDrddPhq3eM/hHO0aU6oVlh/2OMUXrmOtQfoMI5c/B2k4FSQKwkuK+2u/afRWJa1mh7temG6/g9XwMfg3HDs4pPSCZ0unt51T93jPY99F8M5/hutxCPhP0423CvdOJ8w64kc/KPDiOQKJVoR4zj7xXpMbXzFe4V8BJOMfcqCAEmNQzQQnhPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tlo7PE1Jgp67c9ZOD933Cwn3YWxiCQkHrMY4XcWXO2E=;
 b=Krxz0DsbQVxv8msIlRtW06poiIoEIBn1qEZ0B9hVhfm9rODJBWP+X5f5SrFKPOBzs21Fm9BULabDhUv/keNi7mI2VEtSBoArnquCZfznQB6meTgCOdB4Qz7G8eeBxyeipdekv43JKEM7fytM5ImdFFvz9ZE7/l3OGYTjvEqdbN/byvkL5eP1+DM1GoCKQHueXKxdq0fdlXVzJHWCyhIWBenB0Ei0WwRTnaWFYWj+5n7NdK4R8dyYYIumsrdNyyVNBpPKVH8SAjcbDCJzc9PojEGyaQIX12k44jgZcE9rxNZCWPxC0ahtu418e3NGvC3p60QgP58qV/J7ccK5/qcdqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tlo7PE1Jgp67c9ZOD933Cwn3YWxiCQkHrMY4XcWXO2E=;
 b=nfq+JgaJwUXQ6BlYQm92EOQSMkVKNba4mnMhMDEfVIHIRzYvnNtyzl+VPXGQ4LTGkKbDx4oViL1716Y6g7gcrxaL4A5d7R2uWbDLbc+JPBfIoBDtONyHYGHgVg6bhL3eEVCEGpo/Imf6a/2oqiTv8irSbwoCf0sEItUjvaetkMk=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3663.namprd11.prod.outlook.com (20.178.253.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.16; Tue, 24 Dec 2019 00:29:19 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::71cc:a5d4:8e1a:198b]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::71cc:a5d4:8e1a:198b%7]) with mapi id 15.20.2559.017; Tue, 24 Dec 2019
 00:29:19 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <jiwei.sun@windriver.com>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <jiwei.sun.bj@qq.com>
Subject: Re: [PATCH] mtd: spi-nor: make s25fl129p1 skip SFDP parsing
Thread-Topic: [PATCH] mtd: spi-nor: make s25fl129p1 skip SFDP parsing
Thread-Index: AQHVufEtkjcsEusGKUy7fGgj5WyAIg==
Date:   Tue, 24 Dec 2019 00:29:18 +0000
Message-ID: <7f0a49d4-b693-f18d-50ff-4ad5b4fc05e3@microchip.com>
References: <20191219081212.16927-1-jiwei.sun@windriver.com>
In-Reply-To: <20191219081212.16927-1-jiwei.sun@windriver.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [86.122.210.80]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 514dd99a-c09b-4ea0-16f0-08d7880850b0
x-ms-traffictypediagnostic: MN2PR11MB3663:
x-microsoft-antispam-prvs: <MN2PR11MB3663576BAB0C433F2BB2E122F0290@MN2PR11MB3663.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0261CCEEDF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(39860400002)(136003)(396003)(199004)(189003)(110136005)(36756003)(5660300002)(6486002)(66476007)(76116006)(54906003)(91956017)(4326008)(64756008)(66556008)(66446008)(66946007)(71200400001)(478600001)(31686004)(86362001)(2616005)(2906002)(186003)(53546011)(6506007)(316002)(8936002)(31696002)(26005)(81166006)(81156014)(8676002)(6512007)(4744005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3663;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3zTJ/g/IBljkKLh9XfqntJhEwoIpLoYLccnEM9QMy7o4cXpqQAVoAxu/1BjNjEwer1SWpvyT6QkJFy1HaLFYS1PNqqXni23fE9lR74wE7ZYthUPpCFnXyZeW2heft+uRS0/r6uj697JHAupH0iVAocdjEW05RYP2/R4Ra0x0KpZeryddU9iyqeuZP0apbsSvAgCpqLX5iAhUkb8yUAOTKHYUSlQ+57bDMkVpGpu/rsyAhRUVRZu2Tg7yWo7IvPo1iP+sid2j2PcaO5PjB73zoOHX65S3R9nA1Jc4oxDlshvCBMkT09YP16w7XjYYJc6ngHE4PQbJy+wjJxakd8opVHfPnKlKfrVgogN7uUk4eOV2TuaqEqpCkc/3Xg+wnpKc3PR1/TJ4ubvT9h9XyxgU0ErY0VdsSw64CsX8+f2ocP1N4VGYkrSpGCyauFZSfSSN
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0BFB2F2C9062A344AAC9E9CEC6EBE18F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 514dd99a-c09b-4ea0-16f0-08d7880850b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2019 00:29:18.8929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VjkuZ9CIx4gPAO+7thXkye+bfo2Tuk925atdNjV7pQEGqJT8bVhUGKzKav6DNuy9I7YQpbnMq6BdtJ0X2xrvrjIc/LISmkFfqLflA/tGMbo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3663
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEppd2VpLA0KDQpPbiAxMi8xOS8xOSAxMDoxMiBBTSwgSml3ZWkgU3VuIHdyb3RlOg0KPiBF
WFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5s
ZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEZyb206IGpzdW40IDxqaXdl
aS5zdW5Ad2luZHJpdmVyLmNvbT4NCj4gDQo+IFRoZSByaWdodCBwYWdlIHNpemUgb2YgUzI1Rkwx
MjlQIGhhcyBiZWVuIGdvdHRlbiBpbiB0aGUgZnVuY3Rpb24NCj4gc3BpX25vcl9pbmZvX2luaXRf
cGFyYW1zKCkgYmVmb3JlIGludm9raW5nIHNwaV9ub3JfcGFyc2VfYmZwdCgpLA0KPiBpdCBpcyAy
NTYtYnl0ZXMsIGJ1dCB0aGUgc2l6ZSB3aWxsIGJlIGNoYW5nZWQgdG8gNTEyIGJ5dGVzIGluIHRo
ZQ0KPiBmb2xsb3dpbmcgZnVuY3Rpb24gc3BpX25vcl9wYXJzZV9iZnB0KCkuIEFuZCB0aGVyZSBp
cyBubyBleHBsYW5hdGlvbiBvZg0KPiB0aGUgU0ZEUCBhY2NvcmRpbmcgdG8gdGhlIGRhdGFzaGVl
dCBvZiBTMjVGTDEyOVAuIFNvIHdlIGNhbiBza2lwDQo+IFNGRFAgcGFyc2luZy4NCj4gDQoNCldv
dWxkIHlvdSBwbGVhc2UgZHVtcCB0aGUgc2ZkcCBzbyB0aGF0IHdlIGNhbiBjaGVjayB3aGF0J3Mg
Z29pbmcgb24/DQpJZiB0aGUgQkZQVCB0YWJsZSBoYXMgdGhlIHBhZ2Ugc2l6ZSBwYXJhbSB3cm9u
Zywgd2UgY2FuIHVzZSB0aGUNCnBvc3RfYmZwdCBob29rIHRvIGNvcnJlY3QgaXQuIFRoaXMgd2F5
IHdlIHdpbGwgc3RpbGwgYmVuZWZpdCBvZg0KdGhlIHJlc3Qgb2YgdGhlIGluZm8gZnJvbSBCRlBU
Lg0KDQpDaGVlcnMsDQp0YQ==
