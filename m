Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06866C2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 09:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C417820643
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 09:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="m5pQkqHf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfLXJFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 04:05:05 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:17945 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfLXJFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 04:05:05 -0500
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: 46+EoLpnS0ze1u7lJ9aVYKPL/33Ud1U1O1Ax64bD+wlue1s0wglcqAQCD5R2QioxLFwlqy4HYJ
 5lNfjj6itT9nyhLhukbl/UbKh74vt1o/OPH6U7J1v+SAENxr6j7msLq0oxReRvGEiBXv3/4uWL
 cQRLxGC/o/6MCWwi3BLgkboI7jEmEAf+7BtUd2yfzPgg7p8U6DDeSpRCpc51bIM81Bn1jS1Hxt
 5Q6xv+Fgn1IBtOSc56TQ4y3a8VK/j8YZzU9U4Ck1WGR3DBjnr8JwVZD/2xAqyJsjTEjuCtp8wU
 S/4=
X-IronPort-AV: E=Sophos;i="5.69,351,1571727600"; 
   d="scan'208";a="58831388"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Dec 2019 02:05:03 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 24 Dec 2019 02:05:03 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 24 Dec 2019 02:05:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RoJavX/rbGyyYzcp6ArKoScNcyHsloaRGZRD9o6peAlkco5aZeeIZ2b1SXT5ONawt4SQlC/OFBqeOTd72xDZLYGrppey+Zy/VBTEXAZoMAE/qHiuV2iJl2t66r2Zq8eny6+OLJXEsk+sGoEKmxRLaFmF8zhre/fZKfidnpSXnHa/XZhLxKcOCjD80aV8+a/kmOP92vkroKt6TflWZajkMHgGIkX5Jygr9/XRNrqir0vIm3Z0TF6YxIfZAxpRV/Y+eoDvg8FZ0u4lOPaSnoMi/lI8Q5wsnMpfxHkUjAhGzKH1saDLcTlFVyogs5nLA7ahbxTj8Ow1zI561wuf4KpNUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eC/8JxNHlf5YMMv5Qdvb/Ju+gTC/mR5CIS3F1DgTjmw=;
 b=azaoAR9NWz7iXJFffL+EBLbbzkF6CNiHpUI4m/hxDdPsPV+P/XdLWG0AwMVZdVBSWLvDXqr+MnMFSa7S7kIuihKvKJ2skcDl40j/4Bc3bH+63Puht3WoKwiYfXERt0VISY+HkJKgX9j9IlgC+2DhaWjXmQgmzxPTvU0DfSPA3JFcsJtGQgfxQWc04s5CjSDnkhiPorFsExQ46yIV3TpYHs3dyL7YpW0Wp02dbvLBYBAZQO56HTd1u/3NUkEcs+honi0DwJuK8QDjKmckjM8D9xSdD2T+4H/WmyadR7n4tWUV2/lscPVI4ztYUaN0SDEGTZEQKLLTQskZyopoZakQDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eC/8JxNHlf5YMMv5Qdvb/Ju+gTC/mR5CIS3F1DgTjmw=;
 b=m5pQkqHfWAu3jOtZ0THw70CjjTYHqW9Og1hUc+tOVjYivfgQZ6K/Xx5K7/W7EDK7mYZUSoN4mDGFVkMSevnkL6rRCIRnnAG507IeKXd/StfHL/ZN8Q/6UVSOCS0KCOXeVD8fZQFdZ8/GqTcWqgO6eg/j0ZX1Ou/mPVJe7uDG/UY=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3631.namprd11.prod.outlook.com (20.178.251.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.13; Tue, 24 Dec 2019 09:05:01 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::71cc:a5d4:8e1a:198b]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::71cc:a5d4:8e1a:198b%7]) with mapi id 15.20.2559.017; Tue, 24 Dec 2019
 09:05:01 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <Ashish.Kumar@nxp.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <john.garry@huawei.com>
Subject: Re: [PATCH 0/3] mtd: spi-nor: Update mt25q/n25q entries
Thread-Topic: [PATCH 0/3] mtd: spi-nor: Update mt25q/n25q entries
Thread-Index: AQHVqzmVtv9sx+38aUycB51V8ngQ5qfJG/6A
Date:   Tue, 24 Dec 2019 09:05:01 +0000
Message-ID: <a64202b8-f425-a6b7-582b-802f2d16599a@microchip.com>
References: <20191205065935.5727-1-vigneshr@ti.com>
In-Reply-To: <20191205065935.5727-1-vigneshr@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [86.122.210.80]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a18cc48-9f6f-492c-353a-08d788505c07
x-ms-traffictypediagnostic: MN2PR11MB3631:
x-microsoft-antispam-prvs: <MN2PR11MB3631B0A170A3FFA4C7181AA5F0290@MN2PR11MB3631.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-forefront-prvs: 0261CCEEDF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(376002)(346002)(136003)(199004)(189003)(36756003)(71200400001)(26005)(6486002)(66946007)(66476007)(66556008)(6916009)(64756008)(66446008)(186003)(91956017)(76116006)(31686004)(316002)(54906003)(2906002)(5660300002)(478600001)(4744005)(4326008)(53546011)(6506007)(2616005)(86362001)(81156014)(81166006)(8936002)(8676002)(6512007)(31696002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3631;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TG6lK7xjV/BtjC7Oesale6A5grGyOWU/UwMPyEsjbe9eAL+MtaxH6optIx4PD8yyjSQNZ19GdYLS3vNIJ/IxFZj0fV18jH1c/oM451HyCfzP0enU/s94PNV29d2oAh8hoyx/rJnQHezYXZEvt2e+J6Ym3AwDRZA/tEeMPR0zhWUMch9IjXWnjOHI2dXK9zo5ankDOZ22uX6MwEc88Ui6BAFaEh+zV3lZsWbwbn6pez1W3dqkYLk3glVRN7hcmsBFVzjNwMofvfkzs0fp8UwS6bx6BUy0cNUDctya3lMTPv0Na+PlWbiiIH3fTp3LVDJMxfdtZj/J0CED3aYbrIEsNsSaecEVirdvInrmv0KA+lUuS2dtY6M0xPe8z+roFS9cj32c8wrsDRPUzBpgeQv5IyrDuVo/yrVBOpxBrKqLPJlhJawRoL5FV2lk+Ly5AW2F
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2E879612C79C9E43BB3EDC431C3F70CB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a18cc48-9f6f-492c-353a-08d788505c07
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2019 09:05:01.6843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eeZIBLhEh6v5MhkEw7Sxgg7lG3WqMcKOpYTNmox21PCoH/SiUuIzuvMu0wSl2NkwC/qNXUZGlaCYY6GlL8+enHwwrsRxY+HbaWlgLZMtYxA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3631
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDEyLzUvMTkgODo1OSBBTSwgVmlnbmVzaCBSYWdoYXZlbmRyYSB3cm90ZToNCj4gRmly
c3QgcGF0Y2ggc3BsaXRzIG4yNXE1MTJhIGFuZCBtdDI1cXU1MTJhIGludG8gdHdvIGFzIHRoZXkg
YXJlDQo+IGRpZmZlcmVudCBkZXZpY2VzLiBTZWNvbmQgcGF0Y2ggYWRkcyBzdXBwb3J0IGZvciBt
b3JlIG10MjVxIGRldmljZXMgYW5kDQo+IGxhc3QgcGF0Y2ggYWRkcyBVU0VfRlNSIGZsYWcgZm9y
IG4yNXEgZW50cmllcyB3aGVyZSBtaXNzaW5nLg0KPiANCj4gVGVzdGVkIHdpdGggbXQyNXF1NTEy
YSBmbGFzaA0KPiANCj4gVmlnbmVzaCBSYWdoYXZlbmRyYSAoMyk6DQo+ICAgbXRkOiBzcGktbm9y
OiBTcGxpdCBtdDI1cXU1MTJhIChuMjVxNTEyYSkgZW50cnkgaW50byB0d28NCj4gICBtdGQ6IHNw
aS1ub3I6IEFkZCBlbnRyaWVzIGZvciBtdDI1cSB2YXJpYW50cw0KPiAgIG10ZDogc3BpLW5vcjog
QWRkIFVTRV9GU1IgZmxhZyBmb3IgbjI1cSogZW50cmllcw0KPiANCj4gIGRyaXZlcnMvbXRkL3Nw
aS1ub3Ivc3BpLW5vci5jIHwgMzEgKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLQ0KPiAg
MSBmaWxlIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQoNCkFsbCBh
cHBsaWVkLCB0aGFua3MuDQp0YQ==
