Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D328C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 08:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AB052067D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 08:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="URvIklek"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbfHEIAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 04:00:11 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:45095 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfHEIAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 04:00:11 -0400
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: lRtyY+Vtk5bv5n848imIHdRFlWrg59tauXup6dBFhlfKfrV9/88rDJMoSyYRRT+loDi0sLPg7f
 VfnvF9fUwZ4cwIY3Haxr2IV6ElBSt+teQX0VP1EdeM5UwPcU5yBQ3VBVHmQdWewdej1Mf7VHhL
 3qlka6DMLapnyisgW7QWzlCPsBqSA8XIke2/XG+yl2nB1XuJowhvV2qHoRE1xmMHoqoY0zmth9
 oYtAZrbDgrfwredlUPNUjLaEU4Nw7oOv9HCWEB01yNHg8bB1JEN5PAiozdLE80a7Bgu1xXtW9J
 YM8=
X-IronPort-AV: E=Sophos;i="5.64,349,1559545200"; 
   d="scan'208";a="45333401"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Aug 2019 01:00:10 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 5 Aug 2019 01:00:02 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 5 Aug 2019 01:00:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ay8V2t+dbio4qqHNq3orM6ZqQDsi/WUJnQLw21DC9vT6bH30MYdKtKGQFvTxsPh9QMtSPL4ckO1le8dPmevqjrHpQDOlanyYeVamEudVWB43Q82+ZJGSP6pEHgS18LcdKd9bOdQe2/1UFekSHTOeXFoV0AsjrsvggKcBRHehc23c4UiE8nbQVKx2+JAWyGO3GB+xeDYw+KTiGjmuj/gnvXfeYAhf+sX3yKB2LSDCWw8jnJtSSenmfL+4W/HTm1uev8+2mU70YY/+VaSxRu+JSGDpLEqJmWN2o+KXM/REBbVu/KIpO26opWHlE47X1nxuiDDZJ0152R9oP+x4mFPYcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01c1Kb6crj7WRNb1SZde8BFTGRemxxRsJpODHBSLTf8=;
 b=MWNevdtFzxHcX9abwQ5iuWHAR2KyTvvezVrV7TTo35P9J0wfdGBFbbBzvXfA/6uknjNm1lDDaW0PEeuA1KmsIXWcr2UzyBL14kMw6spndW/97umVLoBuYjTcJHSzK/fiuHFKoC0JhiHnOPutzeBzfDmIAMzoqWm9XlvnZWIfFxFoB5BsfJ2oTaxwvVTT2Y8Ai2o7LUSJYZxiHP637sXUPTuiqSoEYhcYmQR4AJr2ohZQlyeIe9gRHnysNxasxdC5zY1JSEe1g7lhKrin1l0u6/P7gNQeXLV6nqcXWHEZ5WUeQibcSd8GNbI9WH2rEbuM9RVRXjFI967IXp6qSRpznw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01c1Kb6crj7WRNb1SZde8BFTGRemxxRsJpODHBSLTf8=;
 b=URvIklekAwz5GVf/Njl1nFKDNRm7ziMCaucPfekx77ZiX9chZMlRMjgj/LzWvysUoFGBfUeFxcoxzZZY41oGexuYKHQys15tXVYS41iSfZZ1Kkt36Lyw/mrrcV4hmD0f492ZfcBCI7WQg/loAADlmGAFEJmmy8IU54junME68aY=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3680.namprd11.prod.outlook.com (20.178.252.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.17; Mon, 5 Aug 2019 08:00:00 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 08:00:00 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>, <boris.brezillon@collabora.com>,
        <marek.vasut@gmail.com>
CC:     <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <boris.brezillon@bootlin.com>
Subject: Re: [PATCH 6/7] mtd: spi-nor: Rework the SPI NOR lock/unlock logic
Thread-Topic: [PATCH 6/7] mtd: spi-nor: Rework the SPI NOR lock/unlock logic
Thread-Index: AQHVR37XrXJde/MfmUq32aDZ/X2NkabrFOaAgAEjpAA=
Date:   Mon, 5 Aug 2019 08:00:00 +0000
Message-ID: <d02fc366-55b6-f698-2419-f277e88dfe02@microchip.com>
References: <20190731090315.26798-1-tudor.ambarus@microchip.com>
 <20190731090315.26798-7-tudor.ambarus@microchip.com>
 <21112f0c-abf0-2b86-5847-2ad7676a29be@ti.com>
In-Reply-To: <21112f0c-abf0-2b86-5847-2ad7676a29be@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0502CA0010.eurprd05.prod.outlook.com
 (2603:10a6:803:1::23) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f7932a17-910b-49cf-7177-08d7197aea6e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB3680;
x-ms-traffictypediagnostic: MN2PR11MB3680:
x-microsoft-antispam-prvs: <MN2PR11MB3680A7005B1465A52E6AD40FF0DA0@MN2PR11MB3680.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(346002)(366004)(39860400002)(199004)(189003)(14444005)(54906003)(66066001)(476003)(53546011)(6506007)(386003)(14454004)(102836004)(2616005)(11346002)(229853002)(446003)(76176011)(4326008)(305945005)(31686004)(52116002)(36756003)(25786009)(486006)(186003)(256004)(7736002)(6436002)(478600001)(71190400001)(71200400001)(99286004)(31696002)(66446008)(81166006)(86362001)(8936002)(64756008)(66556008)(66476007)(26005)(81156014)(8676002)(53936002)(5660300002)(6486002)(66946007)(6512007)(7416002)(2906002)(2201001)(3846002)(6116002)(110136005)(6246003)(2501003)(68736007)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3680;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3gv+v90mxoYI7hiGafc20d4C+lYmk8s2Jty/9/G112N4qYGHASqBGhDY9f2BCjLqJQHlcs1f6YYYqq++ZBPmUdH1BdZrQB/CWKhKI1qthxmGuO1RSCJlSMz4oIpbHFSnZ1kO2b8tHB7Vbx0yYY1wpkSfz8TA8eAsS8xDi47oDhKCs+6xMNeXZAEOcjh/SC7/q33xETLlyMvX6Jc9rj4hvAdfae8y9j/JOQVbdVW/lTt+KKgKPexZW7CUL5pg6pXnqSdr4YuVUeq1w4BJeQtcd492vc1nCoYNUmgBguliNPs3THdgV0bK8XN4TV4iJCwLmbOzwIw6uzBS/ZRFK+c++HhAr1MnWHBTVfRIGgiSmXMlb8H3NkRRakXsAdx4ghQ00BKgVSHm619qKuzDbRO0vlChRnjCvmXMorA7OW7tKU4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5FA36FED9DFA4349BDCBD2285EB049D9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f7932a17-910b-49cf-7177-08d7197aea6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 08:00:00.7564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tudor.ambarus@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3680
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA4LzA0LzIwMTkgMDU6MzYgUE0sIFZpZ25lc2ggUmFnaGF2ZW5kcmEgd3JvdGU6DQo+
IEV4dGVybmFsIEUtTWFpbA0KPiANCj4gDQo+IEhpIFR1ZG9yLA0KPiANCj4gT24gMzEtSnVsLTE5
IDI6MzMgUE0sIFR1ZG9yLkFtYmFydXNAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+IEZyb206IEJv
cmlzIEJyZXppbGxvbiA8Ym9yaXMuYnJlemlsbG9uQGJvb3RsaW4uY29tPg0KPj4NCj4+IE1vdmUg
dGhlIGxvY2tpbmcgaG9va3MgaW4gYSBzZXBhcmF0ZSBzdHJ1Y3Qgc28gdGhhdCB3ZSBoYXZlIGp1
c3QNCj4+IG9uZSBmaWVsZCB0byB1cGRhdGUgd2hlbiB3ZSBjaGFuZ2UgdGhlIGxvY2tpbmcgaW1w
bGVtZW50YXRpb24uDQo+Pg0KPj4gc3RtX2xvY2tpbmdfb3BzLCB0aGUgbGVnYWN5IGxvY2tpbmcg
b3BlcmF0aW9ucywgY2FuIGJlIG92ZXJ3cml0dGVuDQo+PiBsYXRlciBvbiBieSBpbXBsZW1lbnRp
bmcgbWFudWZhY3R1cmVyIHNwZWNpZmljIGRlZmF1bHRfaW5pdCgpIGhvb2tzLg0KPj4NCj4+IFNp
Z25lZC1vZmYtYnk6IEJvcmlzIEJyZXppbGxvbiA8Ym9yaXMuYnJlemlsbG9uQGJvb3RsaW4uY29t
Pg0KPj4gW3R1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbTogdXNlIC0+ZGVmYXVsdF9pbml0KCkg
aG9va10NCj4+IFNpZ25lZC1vZmYtYnk6IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbWlj
cm9jaGlwLmNvbT4NCj4gDQo+IFsuLi5dDQo+IA0KPj4gQEAgLTE3ODIsNyArMTc4OCw3IEBAIHN0
YXRpYyBpbnQgc3BpX25vcl9pc19sb2NrZWQoc3RydWN0IG10ZF9pbmZvICptdGQsIGxvZmZfdCBv
ZnMsIHVpbnQ2NF90IGxlbikNCj4+ICAJaWYgKHJldCkNCj4+ICAJCXJldHVybiByZXQ7DQo+PiAg
DQo+PiAtCXJldCA9IG5vci0+Zmxhc2hfaXNfbG9ja2VkKG5vciwgb2ZzLCBsZW4pOw0KPj4gKwly
ZXQgPSBub3ItPmxvY2tpbmdfb3BzLT5pc19sb2NrZWQobm9yLCBvZnMsIGxlbik7DQo+PiAgDQo+
PiAgCXNwaV9ub3JfdW5sb2NrX2FuZF91bnByZXAobm9yLCBTUElfTk9SX09QU19MT0NLKTsNCj4+
ICAJcmV0dXJuIHJldDsNCj4+IEBAIC00ODA1LDYgKzQ4MTEsMTAgQEAgaW50IHNwaV9ub3Jfc2Nh
bihzdHJ1Y3Qgc3BpX25vciAqbm9yLCBjb25zdCBjaGFyICpuYW1lLA0KPj4gIAlub3ItPnF1YWRf
ZW5hYmxlID0gc3BhbnNpb25fcXVhZF9lbmFibGU7DQo+PiAgCW5vci0+c2V0XzRieXRlID0gc3Bh
bnNpb25fc2V0XzRieXRlOw0KPj4gIA0KPj4gKwkvKiBEZWZhdWx0IGxvY2tpbmcgb3BlcmF0aW9u
cy4gKi8NCj4+ICsJaWYgKGluZm8tPmZsYWdzICYgU1BJX05PUl9IQVNfTE9DSykNCj4+ICsJCW5v
ci0+bG9ja2luZ19vcHMgPSAmc3RtX2xvY2tpbmdfb3BzOw0KPj4gKw0KPiANCj4gVGhpcyBjb25k
aXRpb24gaXMgZGlmZmVyZW50IHRoYW4gaG93IGxvY2svdW5sb2NrIG9wcyBhcmUgcG9wdWxhdGVk
DQo+IHRvZGF5LiBXZSB3b3VsZCBuZWVkIHRvIGFkZCBTUElfTk9SX0hBU19MT0NLIHRvIGFsbCBT
Tk9SX01GUl9TVCBhbmQNCj4gU05PUl9NRlJfTUlDUk9OIGVudHJpZXMgdG8gYmUgYmFja3dhcmQg
Y29tcGF0aWJsZSBvciBrZWVwIHRoZSBjb25kaXRpb24NCj4gYXMgaXMuDQoNCldpbGwgZG8sIHRo
YW5rcyENCg0KPiANCj4+ICAJLyogSW5pdCBmbGFzaCBwYXJhbWV0ZXJzIGJhc2VkIG9uIGZsYXNo
X2luZm8gc3RydWN0IGFuZCBTRkRQICovDQo+PiAgCXNwaV9ub3JfaW5pdF9wYXJhbXMobm9yLCAm
cGFyYW1zKTsNCj4+ICANCj4+IEBAIC00ODE5LDIxICs0ODI5LDYgQEAgaW50IHNwaV9ub3Jfc2Nh
bihzdHJ1Y3Qgc3BpX25vciAqbm9yLCBjb25zdCBjaGFyICpuYW1lLA0KPj4gIAltdGQtPl9yZWFk
ID0gc3BpX25vcl9yZWFkOw0KPj4gIAltdGQtPl9yZXN1bWUgPSBzcGlfbm9yX3Jlc3VtZTsNCj4+
ICANCj4+IC0JLyogTk9SIHByb3RlY3Rpb24gc3VwcG9ydCBmb3IgU1RtaWNyby9NaWNyb24gY2hp
cHMgYW5kIHNpbWlsYXIgKi8NCj4+IC0JaWYgKEpFREVDX01GUihpbmZvKSA9PSBTTk9SX01GUl9T
VCB8fA0KPj4gLQkgICAgSkVERUNfTUZSKGluZm8pID09IFNOT1JfTUZSX01JQ1JPTiB8fA0KPj4g
LQkgICAgaW5mby0+ZmxhZ3MgJiBTUElfTk9SX0hBU19MT0NLKSB7DQo+PiAtCQlub3ItPmZsYXNo
X2xvY2sgPSBzdG1fbG9jazsNCj4+IC0JCW5vci0+Zmxhc2hfdW5sb2NrID0gc3RtX3VubG9jazsN
Cj4+IC0JCW5vci0+Zmxhc2hfaXNfbG9ja2VkID0gc3RtX2lzX2xvY2tlZDsNCj4+IC0JfQ0KPj4g
LQ0KPiANCj4gWy4uLl0NCj4gDQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9tdGQvc3Bp
LW5vci5oIGIvaW5jbHVkZS9saW51eC9tdGQvc3BpLW5vci5oDQo+PiBpbmRleCBhNDM0YWI3YTUz
ZTYuLmJkNjhlYzVhMTBlNyAxMDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUvbGludXgvbXRkL3NwaS1u
b3IuaA0KPj4gKysrIGIvaW5jbHVkZS9saW51eC9tdGQvc3BpLW5vci5oDQo+PiBAQCAtNDI1LDkg
KzQyNSwyMyBAQCBzdHJ1Y3Qgc3BpX25vciB7DQo+PiAgCWludCAoKnNldF80Ynl0ZSkoc3RydWN0
IHNwaV9ub3IgKm5vciwgYm9vbCBlbmFibGUpOw0KPj4gIAlpbnQgKCpjbGVhcl9zcl9icCkoc3Ry
dWN0IHNwaV9ub3IgKm5vcik7DQo+PiAgDQo+PiArCWNvbnN0IHN0cnVjdCBzcGlfbm9yX2xvY2tp
bmdfb3BzICpsb2NraW5nX29wczsNCj4+ICsNCj4gDQo+IEFsc28sIHRvIGJlIGNvbnNpc3RlbnQs
IGRvY3VtZW50IHRoaXMgbmV3IG1lbWJlci4NCg0KV2lsbCBkby4NCj4gDQo+IA0KPj4gIAl2b2lk
ICpwcml2Ow0KPj4gIH07DQo+PiAgDQo+PiArLyoqDQo+PiArICogc3RydWN0IHNwaV9ub3JfbG9j
a2luZ19vcHMgLSBTUEkgTk9SIGxvY2tpbmcgbWV0aG9kcw0KPj4gKyAqIEBsb2NrOiBsb2NrIGEg
cmVnaW9uIG9mIHRoZSBTUEkgTk9SDQo+PiArICogQHVubG9jazogdW5sb2NrIGEgcmVnaW9uIG9m
IHRoZSBTUEkgTk9SDQo+PiArICogQGlzX2xvY2tlZDogY2hlY2sgaWYgYSByZWdpb24gb2YgdGhl
IFNQSSBOT1IgaXMgY29tcGxldGVseSBsb2NrZWQNCj4+ICsgKi8NCj4+ICtzdHJ1Y3Qgc3BpX25v
cl9sb2NraW5nX29wcyB7DQo+PiArCWludCAoKmxvY2spKHN0cnVjdCBzcGlfbm9yICpub3IsIGxv
ZmZfdCBvZnMsIHVpbnQ2NF90IGxlbik7DQo+PiArCWludCAoKnVubG9jaykoc3RydWN0IHNwaV9u
b3IgKm5vciwgbG9mZl90IG9mcywgdWludDY0X3QgbGVuKTsNCj4+ICsJaW50ICgqaXNfbG9ja2Vk
KShzdHJ1Y3Qgc3BpX25vciAqbm9yLCBsb2ZmX3Qgb2ZzLCB1aW50NjRfdCBsZW4pOw0KPiANCj4g
Y2hlY2twYXRjaCBkb2VzIG5vdCBsaWtlIHVpbnQ2NF90LiBQbGVhc2UgY2hhbmdlcyB0aGVzZSB0
byBzaXplX3QNCg0KVGhpcyByZXNwZWN0cyB3aGF0IHN0cnVjdCBtdGRfaW5mbyBpcyBleHBlY3Rp
bmc6DQoNCiAgICAgICAgaW50ICgqX2xvY2spIChzdHJ1Y3QgbXRkX2luZm8gKm10ZCwgbG9mZl90
IG9mcywgdWludDY0X3QgbGVuKTsNCiAgICAgICAgaW50ICgqX3VubG9jaykgKHN0cnVjdCBtdGRf
aW5mbyAqbXRkLCBsb2ZmX3Qgb2ZzLCB1aW50NjRfdCBsZW4pOw0KICAgICAgICBpbnQgKCpfaXNf
bG9ja2VkKSAoc3RydWN0IG10ZF9pbmZvICptdGQsIGxvZmZfdCBvZnMsIHVpbnQ2NF90IGxlbik7
DQoNCkkgaGF2ZW4ndCBzZWVuIHRoZSB3YXJuaW5ncywgd291bGQgeW91IG1pbmQgcGFzdGluZyB0
aGVtPw0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1zdHJpY3QgNi03LW10ZC1zcGktbm9yLVJl
d29yay10aGUtU1BJLU5PUi1sb2NrLXVubG9jay1sb2dpYy5wYXRjaA0KdG90YWw6IDAgZXJyb3Jz
LCAwIHdhcm5pbmdzLCAwIGNoZWNrcywgMTAyIGxpbmVzIGNoZWNrZWQNCg0KNi03LW10ZC1zcGkt
bm9yLVJld29yay10aGUtU1BJLU5PUi1sb2NrLXVubG9jay1sb2dpYy5wYXRjaCBoYXMgbm8gb2J2
aW91cyBzdHlsZSBwcm9ibGVtcyBhbmQgaXMgcmVhZHkgZm9yIHN1Ym1pc3Npb24uDQoNCkNoZWVy
cywNCnRhDQoNCj4gDQo+IFJlZ2FyZHMNCj4gVmlnbmVzaA0KPiANCj4gDQo+PiArfTsNCj4+ICsN
Cj4+ICBzdGF0aWMgdTY0IF9fbWF5YmVfdW51c2VkDQo+PiAgc3BpX25vcl9yZWdpb25faXNfbGFz
dChjb25zdCBzdHJ1Y3Qgc3BpX25vcl9lcmFzZV9yZWdpb24gKnJlZ2lvbikNCj4+ICB7DQo+Pg0K
