Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACBAC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38454208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="EJOKJ4s8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfH2IJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 04:09:24 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:4504 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfH2IJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 04:09:24 -0400
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
IronPort-SDR: aBiHHtAF0SXHRnOFZ3EupBhemLMeoLdiXr7DBUg2LJu6MLUN7wzuJeMj/Iwhs+6BNAxgIe8i1Y
 DJhKkxIrDC3HJlpdLQcllYLmi6mrQ3IUhLdpXHXeEuyFE1VTpGupqy1aLm+sLOtnyFU45/FHQv
 KavkaUdbDPGg/GizdiuHUS9eE5QG1YpUCHkD9FQfDXaiRtV4ibxeYxXauwD3kHLuuk8qRmN6dJ
 7aYSAY5pT4Mr+tTEbPNigrPgn4df+ahzW/B6iWicRprPtQUSTJ5lFEJtL4XL8hKWch/xN6+VVM
 Y5A=
X-IronPort-AV: E=Sophos;i="5.64,442,1559545200"; 
   d="scan'208";a="47067660"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Aug 2019 01:09:22 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 29 Aug 2019 01:09:19 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 29 Aug 2019 01:09:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CX+NTksMmLIcNHemPFrmiitIeVyk66egBillShGSonG6MRTIjrnevpKVL/n/qf6kE8rD42jn46PDCyc+FQhZpy9USv1giXy6iwru4zgNRz2LemONgojq2gaoIp2G1FUkh04NLMyo3fZD9OsN32Sw3XblHPl+fAkicMGHSQCHScL8D/zRdG9bGH+AlzB2bnlg9gTivndxs2UPsk9+V0eiEe2aCIj063pTUbVutQQUdtL3v98gzH8y2XzCitKCxjPMc4MFl/4Ix8Uky/xn0nQscnj8l8PhR0SsmyaYhNqgxea3TENuGP/k0Xyy/+SFwBcHI4mywxwd5CFtKm0xVBIk+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ES/DJARpdwOfq1ShRnlX/u+RkquoAkF73ASGWfqpzdg=;
 b=Kg6AP5ApzOM3JAYOAPmj2wu6PqcLEVaaJn68TPRz2oNjpxlKpj7JTAlFFF8ntW7lOeAweiIwc8OQOkPpgCqkUUK2IzNuNUZh7y7H8hSCTZoYMmxrLxsrfibIxD5F8Gi9tl1VpRPp+cBKfUX/4SAmxE8ajtEsuHxEB+HfClZNIPxsMA35ir22RbdBCsez9cUUuFt7sPTA9btDkh7y98yJKhVgn8xilhyVuLM8BsvEARyJX9C7QglAYvP1v1cNKh/scQSruYIJF6IxnOIxIqIc+NPnJ2FKzzDnp3PP0AN2YyT9IDeBr0rjCcJ7Moq7fksUtI3R1cVgn55Oui1IYO2gAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ES/DJARpdwOfq1ShRnlX/u+RkquoAkF73ASGWfqpzdg=;
 b=EJOKJ4s8mpdPjE33GmyVqfsmHtqUgEKEjazPNFuwYkVKGpFY7RQc62TWTaEmvJh4Seybvt8v4ZOJeiNThLI6D7G1DTef9AwUIiz9ezobm+WQ3PGR2QCOcfRp894XIxWMvEBO6VBXtRjQihs4jGWvG8m62a73QvZWp1jrhdq/llM=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4352.namprd11.prod.outlook.com (52.135.38.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Thu, 29 Aug 2019 08:09:18 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2199.021; Thu, 29 Aug 2019
 08:09:18 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <ashish.kumar@nxp.com>, <marek.vasut@gmail.com>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>
CC:     <kuldeep.singh@nxp.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [EXT] Re: [Patch v3] drivers: mtd: spi-nor: Add flash property
 for mt25qu512a and mt35xu02g
Thread-Topic: [EXT] Re: [Patch v3] drivers: mtd: spi-nor: Add flash property
 for mt25qu512a and mt35xu02g
Thread-Index: AQHVUcNYVX8MlxJF80625T3aIY1jHqcO+5qAgALc5gCAAAYCAA==
Date:   Thu, 29 Aug 2019 08:09:17 +0000
Message-ID: <a5049dca-e00e-ca28-7853-526ec7eac281@microchip.com>
References: <1565692705-27749-1-git-send-email-Ashish.Kumar@nxp.com>
 <e55cd1f9-7359-5484-d258-1f3ea51584b6@microchip.com>
 <VI1PR04MB4015E5BA7BE9763A105AD47D95A20@VI1PR04MB4015.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB4015E5BA7BE9763A105AD47D95A20@VI1PR04MB4015.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0701CA0044.eurprd07.prod.outlook.com
 (2603:10a6:800:90::30) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: abe8cb2d-2c6c-418d-e009-08d72c583084
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB4352;
x-ms-traffictypediagnostic: MN2PR11MB4352:
x-microsoft-antispam-prvs: <MN2PR11MB4352799C7D62E78CB4B31DDCF0A20@MN2PR11MB4352.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0144B30E41
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(39860400002)(376002)(366004)(396003)(13464003)(189003)(199004)(76176011)(386003)(6506007)(53546011)(102836004)(2501003)(7416002)(11346002)(66946007)(476003)(2616005)(66476007)(186003)(66556008)(66446008)(64756008)(446003)(26005)(5660300002)(14444005)(7736002)(2906002)(229853002)(256004)(36756003)(305945005)(14454004)(86362001)(71190400001)(31696002)(71200400001)(3846002)(6116002)(6246003)(66066001)(31686004)(54906003)(81166006)(81156014)(8676002)(8936002)(316002)(110136005)(486006)(478600001)(53936002)(6512007)(4326008)(25786009)(52116002)(99286004)(2201001)(6436002)(6486002)(138113003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4352;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vYEUPQtT2OngswJWNy0e2UYIuCV84zBLMjMqs/ySh+rQFBQOJe2L7suy18+TPAILOq4BLiutuV7a/XTKUT+V8yd5uLc9qEY5qoTqA1At3B13nMvqguERrEe9luvsvMXZo3F8CFuKy8VefdA6e3aN0ADWxjcDI8oz9cQ4s4wdnWfHHDIE7qlzVqHHCZh+FsWPQwf34B/6ziR/KIn6mleIDtSVdS/GmhZ1UFEzJzBoaNLO1H8APU578apyhl3Zyff2z0yBUdbeln4zkbOmCMF5NbH7vDxtAykjsqbCHKpqgossjTEYzdh5BL8yoLpiLkapPXfPPI02xjoQ6Esp/Oy+ck6zhpudfJsE70K277WLFFf6KmwtXVtfypD8zpy/yAC4GXLlrarPl+cWM3hkXfhY4u3uXCBHQs7TnW1mr9l3t9o=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <45D04FD31922344C9A51C5D83810FB83@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: abe8cb2d-2c6c-418d-e009-08d72c583084
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2019 08:09:18.0322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9HeVVRK3OBELr0eJiogruQ2Tc6zGPYQdaZY4UOgKLeSydjxtbFDjv62e1atLXnB4c2cWT7jJgLPmqQN3qviF5ECUbE+GCSgdbWVCOzExS1w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4352
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA4LzI5LzIwMTkgMTA6NDcgQU0sIEFzaGlzaCBLdW1hciB3cm90ZToNCj4gRXh0ZXJu
YWwgRS1NYWlsDQo+IA0KPiANCj4gDQo+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4g
RnJvbTogbGludXgtbXRkIDxsaW51eC1tdGQtYm91bmNlc0BsaXN0cy5pbmZyYWRlYWQub3JnPiBP
biBCZWhhbGYgT2YNCj4+IFR1ZG9yLkFtYmFydXNAbWljcm9jaGlwLmNvbQ0KPj4gU2VudDogVHVl
c2RheSwgQXVndXN0IDI3LCAyMDE5IDU6MzQgUE0NCj4+IFRvOiBBc2hpc2ggS3VtYXIgPGFzaGlz
aC5rdW1hckBueHAuY29tPjsgbWFyZWsudmFzdXRAZ21haWwuY29tOw0KPj4gZHdtdzJAaW5mcmFk
ZWFkLm9yZzsgY29tcHV0ZXJzZm9ycGVhY2VAZ21haWwuY29tOw0KPj4gbWlxdWVsLnJheW5hbEBi
b290bGluLmNvbTsgcmljaGFyZEBub2QuYXQ7IHZpZ25lc2hyQHRpLmNvbTsgbGludXgtDQo+PiBt
dGRAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPj4gQ2M6IEt1bGRlZXAgU2luZ2ggPGt1bGRlZXAuc2lu
Z2hAbnhwLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4+IFN1YmplY3Q6IFtF
WFRdIFJlOiBbUGF0Y2ggdjNdIGRyaXZlcnM6IG10ZDogc3BpLW5vcjogQWRkIGZsYXNoIHByb3Bl
cnR5IGZvcg0KPj4gbXQyNXF1NTEyYSBhbmQgbXQzNXh1MDJnDQo+Pg0KPj4gQ2F1dGlvbjogRVhU
IEVtYWlsDQo+Pg0KPj4gSGksIEFzaGlzaCwNCj4+DQo+PiBPbiAwOC8xMy8yMDE5IDAxOjM4IFBN
LCBBc2hpc2ggS3VtYXIgd3JvdGU6DQo+Pj4gRXh0ZXJuYWwgRS1NYWlsDQo+Pj4NCj4+Pg0KPj4+
IG10MjVxdTUxMmEgaXMgcmVicmFuZGVkIGFmdGVyIGl0cyBzcGlub2ZmIGZyb20gU1RNLCBzbyBp
dCBpcyBkaWZmZXJlbnQNCj4+PiBvbmx5IGluIHRlcm0gb2Ygb3BlcmF0aW5nIGZyZXF1ZW5jeSwg
aW5pdGlhbCBKRURFQyBpZCBpcyBzYW1lIGFzIHRoYXQNCj4+PiBvZiBuMjVxNTEyYS4gSW4gb3Jk
ZXIgdG8gYXZvaWQgYW55IGNvbmZ1c3Npb24gd2l0aCByZXNwZWN0IHRvIG5hbWUgbmV3DQo+Pj4g
ZW50cnkgaXMgYWRkZWQuDQo+Pj4gVGhpcyBmbGFzaCBpcyB0ZXN0ZWQgZm9yIFNpbmdsZSBJL08g
YW5kIFFVQUQgSS9PIG1vZGUgb24gTFMxMDQ2RlJXWS4NCj4+Pg0KPj4+IG10MzV4dTAyZyBpcyBP
Y3RhbCBmbGFzaCBzdXBwb3J0aW5nIFNpbmdsZSBJL08gYW5kIFFDVEFMIEkvTyBhbmQgaXQNCj4+
PiBoYXMgYmVlbiB0ZXN0ZWQgb24gTFMxMDI4QVJEQg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTog
S3VsZGVlcCBTaW5naCA8a3VsZGVlcC5zaW5naEBueHAuY29tPg0KPj4+IFNpZ25lZC1vZmYtYnk6
IEFzaGlzaCBLdW1hciA8YXNoaXNoLmt1bWFyQG54cC5jb20+DQo+Pj4gLS0tDQoNCmN1dA0KDQo+
Pj4gKw0KPj4+ICsgICAgIC8qIE1pY3JvbiAqLw0KPj4+ICsgICAgIHsgIm10MjVxdTUxMmEiLCBJ
TkZPNigweDIwYmIyMCwgMHgxMDQ0MDAsIDY0ICogMTAyNCwgMTAyNCwgU0VDVF80SyB8DQo+Pj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVVNFX0ZTUiB8IFNQSV9OT1JfRFVBTF9SRUFE
IHwNCj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBTUElfTk9SX1FVQURfUkVBRCB8
IFNQSV9OT1JfNEJfT1BDT0RFUykNCj4+PiArIH0sDQo+Pg0KPj4gSSdtIGxvb2tpbmcgYXQgdGhl
IGZvbGxvd2luZyBkYXRhc2hlZXRzOiBtdDI1cXU1MTJhIFsxXSBhbmQgbjI1cTUxMmEgWzJdLg0K
Pj4gQm90aCBmbGFzaGVzIGhhdmUgdGhlIHNhbWUgRXh0ZW5kZWQgRGV2aWNlIElEIGRhdGEuIFdo
YXQgd2lsbCBoYXBwZW4sIGlzDQo+PiB0aGF0IHlvdSdsbCBhbHdheXMgaGl0IHRoZSBmaXJzdCB2
YWxpZCBlbnRyeSwgc28gIm10MjVxdTUxMmEiLCBhbmQgeW91J2xsIGluZGljYXRlDQo+PiBhICd3
cm9uZycgZmxhc2ggbmFtZSBmb3IgbjI1cTUxMmEuIElmIHRoZXJlIGlzIG5vdGhpbmcgdGhhdCBk
aWZmZXJlbnRpYXRlDQo+PiBiZXR3ZWVuIHRoZSB0d28sIG1heWJlIHlvdSBjYW4gYWRkIGEgY29t
bWVudCBpbiB0aGUgY29kZSB0aGF0IHNheXMgdGhhdA0KPj4gIm4yNXE1MTJhIiB3YXMgcmUtYnJh
bmRlZCB0byAibXQyNXF1NTEyYSIgYWZ0ZXIgdGhlIFNUTSBzcGluLW9mZi4NCj4+IFdoYXRldmVy
IHNvbHV0aW9uIHdpbGwgYmUsIGl0IHdpbGwgYmUgYmV0dGVyIGlmIHlvdSBkbyBpdCBpbiBhIHNl
cGFyYXRlIHBhdGNoLg0KPiBIaSBUdWRvciwNCj4gQ29uc2lkZXJpbmcgYm90aCBhcmUgc2FtZSwg
c2hvdWxkIEkgcmVuYW1lIHRvIG10MjVxdTUxYSwgYW5kIGFkZCBTUElfTk9SXzRCX09QQ09ERVMg
b3INCj4gS2VlcCBuMjVxNTEyYSwgYW5kIGNvbW1lbnQgYWJvdXQgbXQyNXF1NTFhICBhbmQgYWRk
IFNQSV9OT1JfNEJfT1BDT0RFUy4NCg0KSSBzZWUgdHdvIG9wdGlvbnM6DQoxLyBlaXRoZXIgcmVu
YW1lICJuMjVxNTEyYSIgdG8gIm10MjVxdTUxMmEgKG4yNXE1MTJhKSIgYW5kIGFkZCB0aGUNClNQ
SV9OT1JfNEJfT1BDT0RFUw0KMi8gb3Iga2VlcCAibjI1cTUxMmEiLCBhZGQgU1BJX05PUl80Ql9P
UENPREVTLCBhbmQgYWRkIGEgY29tbWVudCBhYm91dA0KcmUtYnJhbmRpbmcgdG8gbXQyNXF1NTEy
YS4NCg0KV2hpY2ggb25lIGRvIHlvdSBsaWtlIGJldHRlcj8gV2hhdCBhYm91dCB5b3UsIFZpZ25l
c2g/DQoNCj4gDQo+IEZvciBzZXBhcmF0ZSBwYXRjaCBjb21tZW50IHlvdSBtZWFuIHNwbGl0IG10
MjVxdTUxMmEgYW5kIG10MzV4dTAyZyBpbnRvIDIgcGF0Y2guDQoNCnllcywgc2VuZCBhIHNlcGFy
YXRlIHBhdGNoIGZvciBtdDM1eHUwMmcsIGFzIHRoZSBjaGFuZ2VzIGFyZSBub3QgcmVsYXRlZC4N
Cj4gDQo+Pg0KDQpjdXQNCg0KPj4+ICsgICAgIHsgIm10MzV4dTAyZyIsICBJTkZPKDB4MmM1YjFj
LCAwLCAxMjggKiAxMDI0LCAyMDQ4LA0KPj4+ICsgICAgICAgICAgICAgICAgICAgICBTRUNUXzRL
IHwgVVNFX0ZTUiB8IFNQSV9OT1JfT0NUQUxfUkVBRCB8DQo+Pj4gKyAgICAgICAgICAgICAgICAg
ICAgIFNQSV9OT1JfNEJfT1BDT0RFUykgfSwNCj4+DQo+PiBJcyB0aGVyZSBhIHB1YmxpYyBkYXRh
c2hlZXQgZm9yIHRoaXMgZmxhc2g/DQo+IE5vLCAgZGF0YSBzaGVldCBpbiB1bmRlciBOREEsIEkg
aGF2ZSBhc2tlZCBtaWNyb24gRkFFIGZvciBwdWJsaWMgZGF0YSBzaGVldCwgd2lsbCByZXNlbmQg
YWZ0ZXIgdGhlIHNhbWUgaXMgcHVibGlzaGVkLiANCj4gDQoNCk5vIG5lZWQgdG8gd2FpdCwgSSds
bCB0cnVzdCB5b3UuIEl0IHdhcyBiZXR0ZXIgaWYgSSBjb3VsZCB2ZXJpZnkgdGhlIGluZm8sIGJ1
dA0KaWYgd2UgY2FuJ3QsIHRoYXQncyBpdC4gSnVzdCBzZW5kIGEgZGlmZmVyZW50IHBhdGNoIGZv
ciB0aGlzIGNoYW5nZS4NCg0KQ2hlZXJzLA0KdGENCg==
