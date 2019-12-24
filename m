Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11EBC2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 09:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A85CE20643
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 09:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Ghn3k6FO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbfLXJEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 04:04:32 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:15183 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfLXJEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 04:04:32 -0500
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: Azk9pNy7+pAwE6tuvyPtJI/gOC5xN7Bn9NhLYcczex0XChUqRpwlepaJtytDYoZWGpYzH1fJmB
 QnFTjBNgCwGBkSXfurpT16m0uYOeZfr030/hfN5izeLssYv20lGBAumRt+aicrN4EulkbYDpbM
 R8Yn8EWX+8JGWuUI16YbobLMDu+Pmlhn5ES1k4Eh1OT6IxtptDXy80DevxkCWI6K7qipWsN/FL
 iwoUMEhDccVEYFHKN+Z7WZI+L+fLMFBh/XX2i7+KC5bVNF+FX4jAs9Vwp2OCvGeak+1gaC/PSl
 cIA=
X-IronPort-AV: E=Sophos;i="5.69,351,1571727600"; 
   d="scan'208";a="60026750"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Dec 2019 02:04:31 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 24 Dec 2019 02:04:26 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 24 Dec 2019 02:04:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FRuHTmQvnGj8PoOfZkrTy7ySKqtrlDhzfRmkQCHUzlxXYMEuoownIeP144aUwfNOlQmkO0MC1sga1GJ1EC52CZh8kfCTsICcJwwmc7Urp5qrhkKZLxNhyOA5eXpABVwx6/rQk4HkAMD3C7L2W6vt6G/wqCqM0KbRZfuaFhuAA+eweUzM7ASQI0mA9L+EkRNmu7/PPCg5Qb6kyBJsMquD+GmXiKChoWdnswoOblt8vTJphpDj/fBBTph7anI8jX1I5b2eAOV0MKPNMQxh+Pgj82vmEL2XQ62e7FssUJ8y55fjr74TujfQb+bDl+21utJdQa4P5s2D3G1rZbl75JZc5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSmV1U794QPSmuV3qyuFoYps4lY38LubL2oF4pLtrCQ=;
 b=Ee7SN4MMWFV/KblT54Gjf6oP/t3vT7sJehvA5aVV4Sc1jDnnUAxJkOddL1M4FWY02YrUZUC+1VsBIE/+DjBoKs4qnoum4SVLb90ALGHVLvdnl8TL6Ri89XDzATaq40sNN7O9/kXpr0+GstkrvUtoDPMrFyr10nl6BqMTJ/5TVd8m7gjx4yMt93DUWW6LDNsEScBIS3/C1l91XYFg9H4n5j3yA+dOF/jKaHGpi+8PhAgj/F63ex3e28hw5YUVC7xGhCNtuDJQ1vZ55IHyHr+4p6w9T3e2SKVvmzlQZu6LdoOzrv9aqS5hrRR8OMRvWX2zoHL4k1+hfmPIcKZ8ZLrOfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSmV1U794QPSmuV3qyuFoYps4lY38LubL2oF4pLtrCQ=;
 b=Ghn3k6FOe1Fz46OnrUITda/E/N7q1Utxkcy7P/hSauwKDR9DiKpjbiOEAkgMq/12Ed7+d8w/qVRqCqCV+jlf6ThNJOEIgQooP7nlnv8RxUjqPSy34aWRswW3RSPshYSF0gRJ1eWpEfseBXpQz6QdinWsW/Jp3iowcZSWPcbKUTY=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3631.namprd11.prod.outlook.com (20.178.251.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.13; Tue, 24 Dec 2019 09:04:25 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::71cc:a5d4:8e1a:198b]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::71cc:a5d4:8e1a:198b%7]) with mapi id 15.20.2559.017; Tue, 24 Dec 2019
 09:04:25 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <jbrunet@baylibre.com>, <marek.vasut@gmail.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: add Gigadevice gd25lq128d support
Thread-Topic: [PATCH] mtd: spi-nor: add Gigadevice gd25lq128d support
Thread-Index: AQHVqqaf0NTi8VmO30ee0ZnSi46cfqfJHPgA
Date:   Tue, 24 Dec 2019 09:04:25 +0000
Message-ID: <9622e024-964f-4fb1-4d27-de3b3aa676b6@microchip.com>
References: <20191204132713.6195-1-jbrunet@baylibre.com>
In-Reply-To: <20191204132713.6195-1-jbrunet@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [86.122.210.80]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d95d167f-6857-4c99-0c15-08d78850467c
x-ms-traffictypediagnostic: MN2PR11MB3631:
x-microsoft-antispam-prvs: <MN2PR11MB36310B85E2A5C2B686F7EB2FF0290@MN2PR11MB3631.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:972;
x-forefront-prvs: 0261CCEEDF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(376002)(346002)(136003)(199004)(189003)(36756003)(71200400001)(26005)(6486002)(66946007)(66476007)(66556008)(64756008)(66446008)(186003)(91956017)(76116006)(31686004)(966005)(316002)(54906003)(110136005)(2906002)(5660300002)(478600001)(4744005)(4326008)(53546011)(6506007)(2616005)(86362001)(81156014)(81166006)(8936002)(8676002)(6512007)(31696002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3631;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G5h6HSTxWS0Hdvuex3m3q2vnQMU2ZIl+iTsi3T7GP5JD5bGbMozF900lgjMKbsAWvY+ed+UwOGkqdC0ett3XehdBV+y2zM+hXIjTjKDPj7Vl89k111L4t3TISnSUWCLqvya+0EmAEn8U/gM/SmF8/MXChVCRdiAcGF2Mo3h3oxI0vPELvmrIQpR1EGsDO15zhvCeK2fUjBuHg/2X6UE3Hl/+BGDYfvEaYd7Wj02Cy+dXOsd/LMmakIyzAEu1GtmvWK8AzoM6tmrqy4xGHRV6rGPj4MysNesr36JPPj7MtXYwvJBvvrK2tgh+LH1D0BHT98D3G3atty7pbp4efd3b5G58PvX/bYh9/J2eok2ALyn2txQ+ebeAPhLr1JigbPbO7jP8AZOOv7/Y4FDndVSf+hQf6VGPSS64/Yu5oAv31F4BFv/RRfG5gIfshuCGVRixTiNuaYqiUCjbT/gNGMe0EKMS6DQV/xGejJX4JyJMVvw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <52E8243867568D4C81343FA494EC366D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d95d167f-6857-4c99-0c15-08d78850467c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2019 09:04:25.5291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QVUq35JQ0fIj5KX6WbIDI9FWkA5WqbyOm6KfqMTAuq3FaL7x1x+SIsATl6qlBJB+vG6zVpUX5+8e6lV7QGmYNfXLdYggLJ6vVnCdsz/KSf4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3631
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDEyLzQvMTkgMzoyNyBQTSwgSmVyb21lIEJydW5ldCB3cm90ZToNCj4gVGVzdGVkIG9u
IHRoZSBBbWxvZ2ljIGFtbC1saWJyZXRlY2gtcGMgcGxhdGZvcm0gd2hpY2ggZG9lcyBub3Qgc3Vw
cG9ydA0KPiBkdWFsIG9yIHF1YWQgbW9kZXMNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEplcm9tZSBC
cnVuZXQgPGpicnVuZXRAYmF5bGlicmUuY29tPg0KPiAtLS0NCj4gDQo+ICBEYXRhc2hlZXQgaXMg
YXZhaWxhYmxlIGhlcmU6DQo+ICBodHRwOi8vd3d3LmVsbS10ZWNoLmNvbS9lbi9wcm9kdWN0cy9z
cGktZmxhc2gtbWVtb3J5L2dkMjVscTEyOC9nZDI1bHExMjgucGRmDQo+IA0KPiAgZHJpdmVycy9t
dGQvc3BpLW5vci9zcGktbm9yLmMgfCA1ICsrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNl
cnRpb25zKCspDQoNClBhdGNoIGFwcGxpZWQsIHRoYW5rcy4NCnRh
