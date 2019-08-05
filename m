Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCF7C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 06:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9544320B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 06:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="nmVlA0Ev"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfHEGaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 02:30:07 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:13271 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfHEGaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 02:30:07 -0400
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: ffGBlOmvhbDASDbfNA2CqhwbafydiCMnax7MWs1onlVfkGv1vcBG0x68WzY8cdmZfWrundzPyv
 gNvun8iuyFFzbGodabamhIHOOyRtemCa6y+z4YnAG9taAObKcAJDWAhEHluz20Fr3JT0pU6Oqr
 +Wf3X3cvePQlvyIUp01PiRF4NvyUD+rigQkidwIAo3PvraZgOwl0S4qZCh1u0B9NIrysgvoygd
 nsc1mEB5zBIEqf5Pa3gcVrz28n2iP54ARAytA1FPwnZq/I4n+tJu6K13dJloMebsckCZXhHKKn
 +2U=
X-IronPort-AV: E=Sophos;i="5.64,348,1559545200"; 
   d="scan'208";a="43147950"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Aug 2019 23:30:06 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 4 Aug 2019 23:30:03 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Sun, 4 Aug 2019 23:30:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QPwatadpHh/x8cIQuuawYqoSYnZpe12jsw+2UVvyzfb5oRAKhDo6nlIsicflhAtAKSZQc0t74apcrnSbdbTBm+ChmsS6vcyO+x17/p0d75jW17Bws33y5sBdUC3jlLuV1ueOUQ2Jop0qjeoJA34R4djXQEiQH/y+piJou+oMoqJQXgMGpDOKvED6sw/uf2zvDlVHrCQ/eL/FauUIvflHzW/afkrmKdx4CxV86OKjID7NxqTcJEatfu35yacbgb8HWxage6ZQ+Xzqo+r70rM4c+shDkbxlt+lLqqaQqC2zhWGaQS62sa3yzpUsAvsvkSFnxkDSC0VhlaGNbcY5nZ8Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0kfdAjviWQ57du6l4FlC5VdV1tqFV3VyZwwWOU2DgYk=;
 b=ARx6uzS0+FEawIjfg4s14LxmPAbUri4ixKsP/aV3CCRs4VZ/cd0LqZqH83N2mMEv0W5Dpyy4NUwxsIpK8wCcIwtMcZeClh0tFwgOmp1FaPE4RjgUpcpuKowSmthyRQpCvHYqxEPiCMpU5BbbDLcnMIKt7p4LFOKNICyxMP/ZP4G+OzX0hgVVug2b8WSJ4iXKcVjjsQsgs5SXzYtdKx02olPdmXRIqOIrGgMUuVQxHi/7wfiY5Tq22TvDWf+T26ZJS4zMi4ozSWajANCzjU786h0RLsIa34PXzJV0WpVT+HujFUPUJFMjniiKuVDn5toIver1JZNokes7pdwJvKqlqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0kfdAjviWQ57du6l4FlC5VdV1tqFV3VyZwwWOU2DgYk=;
 b=nmVlA0EvWNlBcmp64FWtA52js5kNX6PhPvNmLQM22xb6mY/OLHUMf4iRqVsGi5ZyrmyFzRfBWCTn4RcZaj19Qsey7BYYsgngB3cCdZ3FzSsgCTc4YsHpEZ+L7Qa069/AfdIjtLtSGO9Va7py611+MC5C347fWSjul8LIA/aCc6E=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4159.namprd11.prod.outlook.com (20.179.150.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Mon, 5 Aug 2019 06:30:02 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 06:30:02 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>, <marek.vasut@gmail.com>
CC:     <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <boris.brezillon@collabora.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Nicolas.Ferre@microchip.com>
Subject: Re: [PATCH 2/5] mtd: spi-nor: group the code about the write
 protection at power-up
Thread-Topic: [PATCH 2/5] mtd: spi-nor: group the code about the write
 protection at power-up
Thread-Index: AQHVPHxbXzKnWnPqC02RF1i1z4jGIKbsKKuAgAAMwIA=
Date:   Mon, 5 Aug 2019 06:30:02 +0000
Message-ID: <8b756716-aa00-7c97-3eb9-252eaf891cdd@microchip.com>
References: <20190717084745.19322-1-tudor.ambarus@microchip.com>
 <20190717084745.19322-3-tudor.ambarus@microchip.com>
 <9fee8e16-b2f6-2428-f42b-281db01e3706@ti.com>
In-Reply-To: <9fee8e16-b2f6-2428-f42b-281db01e3706@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VE1PR03CA0004.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::16) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e2191f1d-17d8-46b6-c697-08d7196e58ad
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB4159;
x-ms-traffictypediagnostic: MN2PR11MB4159:
x-microsoft-antispam-prvs: <MN2PR11MB41592FE3816199C7567878FFF0DA0@MN2PR11MB4159.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(346002)(366004)(396003)(189003)(199004)(6506007)(6512007)(99286004)(25786009)(256004)(14454004)(66946007)(81166006)(31696002)(52116002)(66446008)(2906002)(66476007)(66556008)(64756008)(76176011)(8936002)(36756003)(81156014)(86362001)(6436002)(71190400001)(107886003)(26005)(386003)(53546011)(102836004)(6246003)(229853002)(316002)(110136005)(6486002)(31686004)(3846002)(6116002)(4744005)(68736007)(8676002)(446003)(2616005)(486006)(476003)(478600001)(53936002)(4326008)(11346002)(2501003)(5660300002)(186003)(7736002)(66066001)(54906003)(71200400001)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4159;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OyA+jms/OnIXGsv2K8x0QJD6x1H4cKZRZeQ1nYDrLGfBlve4CcLArMmIRDYpI8Vs7vlcYsxfZiHZjudsMQaPow5Z90i+ycxpi9qiu+GBWRn0OzuX2slscAaHmdwbPAQlmE7X0lH4Ntr9+q+7Ki8KoLzLFR3dGth0m747/oqxRu9CroqwEBSACOsrw21dFdEG0UBRPtKDYEYQ2PEdsMt5YOVHtkhiuaLOcL1qFF/M82jO8qDS5B4rHtqA9Urve04zsqPWJ/PNprRj+U6Afpum88PkiW8iQ1zc7TYVHxRyl8fQPGNmQEBXI0fTOucVyi9bhQ2MRoL7yf9YqYkn7VGjgz8/KE0GG4BZRs5lg4UI1Fthkm1JEQjvdoMmwZ7k/5LYJXbuBpf+QJ7yn+XE5x+/Se0od/6d5lyM8tXQHj+MuKc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <622EEAD7E536EF47827E4EB24AC7FC44@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e2191f1d-17d8-46b6-c697-08d7196e58ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 06:30:02.3253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tudor.ambarus@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4159
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA4LzA1LzIwMTkgMDg6NDQgQU0sIFZpZ25lc2ggUmFnaGF2ZW5kcmEgd3JvdGU6DQo+
PiBGcm9tOiBUdWRvciBBbWJhcnVzIDx0dWRvci5hbWJhcnVzQG1pY3JvY2hpcC5jb20+DQo+Pg0K
Pj4gVGhlIHdyaXRlIHByb3RlY3Rpb24gYXQgcG93ZXItdXAgbG9naWMgd2FzIHNwbGl0IGFjcm9z
cyBmdW5jdGlvbnMNCj4+IGJlY2F1c2Ugb2YgYSBkZXBlbmRlbmN5IHRvIHNwYW5zaW9uX3F1YWRf
ZW5hYmxlKCkuIEdyb3VwIHRoZSBjb2RlDQo+PiBpbiBzcGlfbm9yX2luaXQoKSBhcyB0aGUgcG9p
bnRlciB0byBzcGFuc2lvbl9xdWFkX2VuYWJsZSgpIGNhbiBiZQ0KPj4gcmV0cmlldmVkIGZyb20g
bm9yLT5xdWFkX2VuYWJsZS4NCj4+DQo+PiBXaGlsZSB0b3VjaGluZyB0aGlzIGNvZGUsIHJlbmFt
ZSBub3ItPmNsZWFyX3NyX2JwKCkgdG8NCj4+IG5vci0+ZGlzYWJsZV93cml0ZV9wcm90ZWN0aW9u
KCkgdG8gYmV0dGVyIGluZGljYXRlIGl0cyBzY29wZTogaXQNCj4+IGRpc2FibGVzIHRoZSBkZWZh
dWx0IHdyaXRlIHByb3RlY3Rpb24gYWZ0ZXIgYSBwb3dlci1vbiByZXNldCBjeWNsZS4NCj4gSSBw
cmVmZXIgdGhpcyBmdW5jdGlvbiB0byBiZSByZW5hbWVkIHRvIG5vci0+ZGlzYWJsZV9ibG9ja19w
cm90ZWN0aW9uKCkNCj4gc28gYXMgdG8gYXZvaWQgYmVpbmcgY29uZnVzZWQgd2l0aCB3cml0ZSBw
cm90ZWN0IHNpZ25hbCBpbnB1dCB0byB0aGUgZmxhc2guDQoNCllvdSdyZSByaWdodCwgSSdsbCBy
ZW5hbWUgaXQuDQoNClRoYW5rcywNCnRhDQo=
