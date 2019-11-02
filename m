Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6897BCA9EC7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 10:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E64A21726
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 10:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="TIRTpXRZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfKBKpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 06:45:55 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:11248 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfKBKpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 06:45:54 -0400
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
IronPort-SDR: ReQjp5VIBzKa1X5PqM3fmrpxtzjPgDnZCbPHeMapSNbBz2ie0lI6mmalfJppa4xQkpXuDf7QyL
 dx02FEnuQMdgDBLk5I+/gT25bC4sdVr2rWz0omUtQnCT6wC9rOdQkEgmNnMAW7DJd8jAOun7cS
 jvLFAGDtbDTgnTaWAl7oAa6Bu+9y0qETfObD8TsBaoO1EtVv2laOWBPdqYSj2+ZdD76wqRwZ/0
 Uk79iSXd4LF9nJ6DbV9s0HX0CR82JANGGPTbDwAU2bRXLtYEcRcRjxYnld3+d0jHSqfVCIi9Vo
 mFA=
X-IronPort-AV: E=Sophos;i="5.68,259,1569308400"; 
   d="scan'208";a="55427778"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Nov 2019 03:45:53 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 2 Nov 2019 03:45:53 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Sat, 2 Nov 2019 03:45:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ms8KKi1LW6b/xhDXsbNSG+O99Dlpf3mzbffOpIB9fwRCpUxl3XAYV6SrH70ZlXXNHyGkbREtcVI27m0I5lhWcHV+6gzu1b1SDx0oJRB4ftFRsA3Jym2bk3K/p2+e2OXP0dDdJjCKJAlaM4pS+Ppx/KYg3siuFy2ZWUWVWsN/1MZm/LGUT/odT75ToXRTG8RqkBsPY+TesbEYvdrZuVH/wxu0lUV9m/lt4bHbtyqp37vJblXiRtQ5ejpmSt6J1RN62Fj7O0UTK4TllnEka+RmIgO3+kNJnN97EqNwLir3DBJqUTj2BCwNLxeHvfTvOEF964tNQeaux5wFMcR/zRCYEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XhMDqOxNYZVN7Ow1/IYZfrqAoRF/bOm0lUIrEp1dBEY=;
 b=nOd0c9QRygGn/9RCrmhGSqfri639bFgn3BZ2Zj/8jZa2ek4Fxt0lCdnVRmM8DdBpJEtQ03/JFqfdPWbwkgBiXbYb8br9cq+BKI+R30Sdm8026ZfZk6A/8t5b4bagi8YPZjT2o9Nj+l0A8lUB5cTNdnX8ZjTQDX6VU1XUIJlKrWUUcCVHPIqQJflFrhzEuKhFLwnzvAkryYX3kqwvhxd1O8bBzvssRFTwmGjuvJWzZOHezut8tHxr5ZwzMw1Zp7waHML7b+o9kLGPt66zHtp2m4sljwxiKI0YrWq9QoLw1qttwcs4Qgdo5ruQU5HdfPGh19LLVZCl0ITRQLlIXZ0RAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XhMDqOxNYZVN7Ow1/IYZfrqAoRF/bOm0lUIrEp1dBEY=;
 b=TIRTpXRZ93m8+UM93GsqPYXEKvA/R1lzlr2vLW1WaN5AZyJDg5zsidrnU/pWkljD4DINfsfYjNKmjugvVP2ov0/p/t3l49kX6hmnNA21zxUK4sxrTC9XbW9dAk/gHsZ73BXs+Z6d0a4lCq7d/2o6LasT1NVLL1w96U5zE3m/abU=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3629.namprd11.prod.outlook.com (20.178.252.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Sat, 2 Nov 2019 10:45:51 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2408.018; Sat, 2 Nov 2019
 10:45:51 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <boris.brezillon@collabora.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 10/32] mtd: spi-nor: Pointer parameter for CR in
 spi_nor_read_cr()
Thread-Topic: [PATCH v3 10/32] mtd: spi-nor: Pointer parameter for CR in
 spi_nor_read_cr()
Thread-Index: AQHVjkpkiF1slcDF2Ua4XfvPGlZW3Kd3uLuA
Date:   Sat, 2 Nov 2019 10:45:51 +0000
Message-ID: <339365a9-fa0d-ae9c-c047-c9f6a1a553a2@microchip.com>
References: <20191029111615.3706-1-tudor.ambarus@microchip.com>
 <20191029111615.3706-11-tudor.ambarus@microchip.com>
In-Reply-To: <20191029111615.3706-11-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P195CA0006.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:800:d0::16) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.120.239.29]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c264b536-f02e-4a04-884c-08d75f81d44b
x-ms-traffictypediagnostic: MN2PR11MB3629:
x-microsoft-antispam-prvs: <MN2PR11MB3629346679ECC1BD8AD1A95DF07D0@MN2PR11MB3629.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 0209425D0A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(376002)(39850400004)(136003)(189003)(199004)(66946007)(66556008)(316002)(66446008)(52116002)(2201001)(86362001)(76176011)(6512007)(53546011)(386003)(14454004)(305945005)(6116002)(229853002)(31696002)(6486002)(446003)(71190400001)(25786009)(36756003)(4326008)(66066001)(6246003)(6506007)(102836004)(2616005)(99286004)(8936002)(478600001)(71200400001)(11346002)(8676002)(81166006)(66476007)(81156014)(2501003)(256004)(3846002)(5660300002)(64756008)(7736002)(31686004)(6436002)(186003)(4744005)(2906002)(26005)(110136005)(54906003)(486006)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3629;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tpn0YasCOfnPBwNPlR2TcbL75iNAQKBTxqud1vduYBjI5dDjwf/AIEtt8eI0Z6vYyO9jC3b5LCNJQSQ1dR87x2OxwOe8MtOspL7hBiAPlNEN0G7aOlU2N+6qJ/nZI+zeFnkWrCxXk7WNwpE97S3HchF3mUOxUDckQINNvzMPsGBOI6MqAiNGgo00RGBg7kwdeQ92uQO3eQLxYgfbHrGs2NrElQzJ9f5OxQb4z60vd+EXNidzd6xDcGrvNlWDvxeBoqduiS3BlEG63vveN/ZcaAGrm4IAlzL1B5tf4DfrmY1rXZT7C/NK6wQC+11+zcA2PHZecyzScUgrHFV0ll6hcYqNWBl9Xwl8NfCBkTysqE0dGI29hgomnZkVetbz1E04hDDHaFIrArdrO2kIomO0T13zs/5tPV2Z8niYc7G7zr/3wYHcdmbh6VXNrjLWFa/T
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C15A497EC161D45969A015C64D70BAB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c264b536-f02e-4a04-884c-08d75f81d44b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2019 10:45:51.5593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PAfFiYQMI1oayWjzqgN7YE87Eaum5lnkIg6nYXQujIcnYjlfZ5CVOJmvMdUlkDNFiL8XMFXRlZqPPEiy5XBSkDNAvvruYOEZiWAEhyCWE6U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3629
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDEwLzI5LzIwMTkgMDE6MTcgUE0sIFR1ZG9yIEFtYmFydXMgLSBNMTgwNjQgd3JvdGU6
DQo+IEZyb206IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbT4NCj4g
DQo+IExldCB0aGUgY2FsbGVycyBwYXNzIHRoZSBwb2ludGVyIHRvIHRoZSBETUEtYWJsZSBidWZm
ZXIgd2hlcmUNCj4gdGhlIHZhbHVlIG9mIHRoZSBDb25maWd1cmF0aW9uIFJlZ2lzdGVyIHdpbGwg
YmUgd3JpdHRlbi4gVGhpcyB3YXkgd2UNCj4gYXZvaWQgdGhlIGNhc3RzIGJldHdlZW4gaW50IGFu
ZCB1OCwgd2hpY2ggY2FuIGJlIGNvbmZ1c2luZy4NCj4gDQo+IENhbGxlcnMgc3RvcCBjb21wYXJl
IHRoZSByZXR1cm4gdmFsdWUgb2Ygc3BpX25vcl9yZWFkX2NyKCkgd2l0aCBuZWdhdGl2ZSwNCj4g
c3BpX25vcl9yZWFkX2NyKCkgcmV0dXJucyAwIG9uIHN1Y2Nlc3MgYW5kIC1lcnJubyBvdGhlcndp
c2UuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBUdWRvciBBbWJhcnVzIDx0dWRvci5hbWJhcnVzQG1p
Y3JvY2hpcC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9yLmMgfCA1
NSArKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMzAgaW5zZXJ0aW9ucygrKSwgMjUgZGVsZXRpb25zKC0pDQoNClJlcGxhY2VkICZu
b3ItPmJvdW5jZWJ1ZlswXSB3aXRoIG5vci0+Ym91bmNlYnVmIGFuZCBhcHBsaWVkIHRvIHNwaS1u
b3IvbmV4dC4gVGhhbmtzLg0K
