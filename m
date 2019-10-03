Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56349C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 10:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 260A7218DE
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 10:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Bn/N3x0n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbfJCKY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 06:24:58 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:29372 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728124AbfJCKY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 06:24:58 -0400
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Eugen.Hristev@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="Eugen.Hristev@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; spf=Pass smtp.mailfrom=Eugen.Hristev@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: QVgxug5U2oLQRpMM/8X9xjgpetOAHXjCwc6tDYi3M6Q7nSTsDjPOLJt33YTDUg+zEadAVkSvoY
 FNhFg0yLg/RpKnJ0K+Jb6359YMwrOYWnQCm0Ms7mR4LdPcmlvzoA0uDuq6ISIObBBvZjXINVh/
 o+NgNW4hhcPRkAeADN+BP44vSCkLa7Z8b/GDlA6F8DtJWllTeiajb21RRhfqYN0rEF5PYEeVTp
 zQA7YWRQm5LZaVP0SVhORvJEXIIPiFI+gHHGOMGrMAMECzyC0d2e/iryTqt0U7anMlJiPEa2QB
 iCs=
X-IronPort-AV: E=Sophos;i="5.67,251,1566889200"; 
   d="scan'208";a="51334364"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Oct 2019 03:24:55 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 3 Oct 2019 03:24:55 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 3 Oct 2019 03:24:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YuU8ba1rfyDorFqAP/JIGdH/cHKwoyuy075IO2zH9Rvg+ENIR+OvAuZgitYEjtFRbGLzeMp0ZYWLGibn4mAPdAkA7eeAq2GSP8vTQLzFCwzOaPJMNsg74Bx9JP3oNp4KeenbZH+O6/4DCF6vSKkBLMhrpUw34Et573VQXmKe67/uanz1vhDqmbFhLRN4F7n8NudU2zyJmgwbyQkdPNBBH8gP5JR5QyDlK2s/+G4cGvUrGKZVR3vXI++nWwA+0S1B/HQ3jeZS6It0HUind53KsTHkDyd/gS7yjzWgOyaX6seEOwhr90mAidRHemn1aDGU+WxTsqiRAhYp6t5ZzHBzyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6clNdNLS881tmBpceWlm/EMVNhYbfo7IwIxaQjHThdQ=;
 b=FbCTSWP+3d/jWTxlJFGlsLLD4YWde2R+TxcqSV5fJZfFJtDUQZySq6zkOT5tLeabNa0U2J+sMcEPFkPXKyQwvxQe1FbfZaDuvFl1LPa0lZEhIHuMdZim//VCviD/FwjjBbxqNQW9g33stBRBm1rBolihVH7D7QwXGLyI//FvH7pYNan20T643oS42v2I+66kGF5cfCcQXp2eKO74zDMSpb5dvASCUcMt/OMSnNdw5CniynUYwX05cTgtVaxHfuDEV9a/RV4CNzUTiBarf2/FtTjODAy2fYK++oO+ZP9Pp1AeH8HlM8aNxgNzJu4fqCcfVXZajQiMeRlH4klY/M1JQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6clNdNLS881tmBpceWlm/EMVNhYbfo7IwIxaQjHThdQ=;
 b=Bn/N3x0nq24wjfUBus1s4b092y29iPCpC7PfIE2dNvKltokF9bWDR7daveXfzMVlnr8wPXZybCIZrtPbzFNkoXzij2ivIf0IX0De1J9m1U2Fv18OlAsDnrgTqrmbxvvG5XWIwIS6uKkDU1OxCAxkGc0WNpee8+qbGq5LBbf6NEQ=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB2010.namprd11.prod.outlook.com (10.168.107.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Thu, 3 Oct 2019 10:24:53 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::b125:76c1:c9b1:34f4]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::b125:76c1:c9b1:34f4%10]) with mapi id 15.20.2305.023; Thu, 3 Oct 2019
 10:24:53 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>
CC:     <adrian.hunter@intel.com>, <Nicolas.Ferre@microchip.com>,
        <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] ARM: dts: at91: sama5d27_som1_ek: add mmc
 capabilities for SDMMC0
Thread-Topic: [PATCH 2/2] ARM: dts: at91: sama5d27_som1_ek: add mmc
 capabilities for SDMMC0
Thread-Index: AQHVTcREWHJkbws9ckOkZIu1sPO5NabxMeQAgAAEQACAASQ2AIAFUKOAgAEA/wCAUGBlgA==
Date:   Thu, 3 Oct 2019 10:24:52 +0000
Message-ID: <c2c355cd-b798-02de-0606-0f6442f6fdca@microchip.com>
References: <1565252928-28994-1-git-send-email-eugen.hristev@microchip.com>
 <1565252928-28994-2-git-send-email-eugen.hristev@microchip.com>
 <20190808124217.wrmcxohw5i6ju2qe@M43218.corp.atmel.com>
 <04fd74c3-a828-1064-b77b-f3de07a26190@intel.com>
 <20190809062322.syuieymdqjs4e7lh@M43218.corp.atmel.com>
 <fa0debbb-b84c-1f74-f8b8-8fdd7812aaee@microchip.com>
 <20190813065306.tqz57hqeiofofbnz@M43218.corp.atmel.com>
In-Reply-To: <20190813065306.tqz57hqeiofofbnz@M43218.corp.atmel.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0198.eurprd07.prod.outlook.com
 (2603:10a6:802:3f::22) To DM5PR11MB1242.namprd11.prod.outlook.com
 (2603:10b6:3:14::8)
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191003131853387
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 945bafe7-2b32-4af0-0f84-08d747ebedc5
x-ms-traffictypediagnostic: DM5PR11MB2010:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB2010014407FD08DC22026717E89F0@DM5PR11MB2010.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 01792087B6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(376002)(346002)(39860400002)(199004)(189003)(6506007)(386003)(53546011)(256004)(71200400001)(71190400001)(66556008)(64756008)(66476007)(5660300002)(36756003)(66446008)(66946007)(31686004)(2501003)(66066001)(8936002)(6246003)(6512007)(2906002)(305945005)(14454004)(81156014)(81166006)(8676002)(7736002)(6116002)(6436002)(4326008)(31696002)(478600001)(476003)(25786009)(86362001)(2201001)(446003)(2616005)(11346002)(186003)(6486002)(486006)(54906003)(99286004)(110136005)(76176011)(52116002)(316002)(26005)(102836004)(229853002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB2010;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ai8MTev9t9hAgeGS6+EdtgO2EcEI93eGlBBByM2d0PN6HjIeBK4KkWC94QMC8FtUBpsOINtRjd2tMzWkhRPv47HsakhIMsv+OGxQl/U4pnbbchYK7dSAx6LgAYBAV1rTyACZnwNVNRPEogh+GOGDrtaDjioSiJPnqE1be5jR/Y0wejtkEb5OQ8Hps/yop8i49WIgA11nB57BYHzfkALC2SNDBjcovDlFqJ/iLOLgmFxNEZXxDWH+4/ZzhrP/mDEiSV7pLxYpMAsHaneFR6R+WdUtlKcxErs9A00JV+TV1hfCs4B2WDVCOn0ThqmIeJpxopUVTmVJKAE7yltS+IPRy/K4rSO6I4Az7RztMwpJxucvD4PfEXn3lwKm+L28skIxNGrL5fgkbh9wvuQnl5dEmsTqOUQSSaoVE5Vafjlf4Tc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B477413D9188AE4692F41B4A177C285D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 945bafe7-2b32-4af0-0f84-08d747ebedc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2019 10:24:52.9885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hc+qcfIsizXfEFv6hKwD9CJY3LpVtPSlzZ2ILaoleM/ShaUyFqRpapO1Wz+ZLAa8knEKwVNSx93Tzel3Wk4oTOVgVvyQdEcMMTsPNwiJGO4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB2010
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDEzLjA4LjIwMTkgMDk6NTMsIEx1ZG92aWMgRGVzcm9jaGVzIHdyb3RlOg0KPiBPbiBN
b24sIEF1ZyAxMiwgMjAxOSBhdCAwMzozODozNFBNICswMDAwLCBFdWdlbi5IcmlzdGV2QG1pY3Jv
Y2hpcC5jb20gd3JvdGU6DQo+PiBPbiAwOS4wOC4yMDE5IDA5OjIzLCBMdWRvdmljIERlc3JvY2hl
cyB3cm90ZToNCj4+PiBPbiBUaHUsIEF1ZyAwOCwgMjAxOSBhdCAwMzo1NzozMFBNICswMzAwLCBB
ZHJpYW4gSHVudGVyIHdyb3RlOg0KPj4+PiBPbiA4LzA4LzE5IDM6NDIgUE0sIEx1ZG92aWMgRGVz
cm9jaGVzIHdyb3RlOg0KPj4+Pj4gT24gVGh1LCBBdWcgMDgsIDIwMTkgYXQgMTA6MzU6NDNBTSAr
MDIwMCwgRXVnZW4gSHJpc3RldiAtIE0xODI4MiB3cm90ZToNCj4+Pj4+PiBGcm9tOiBFdWdlbiBI
cmlzdGV2IDxldWdlbi5ocmlzdGV2QG1pY3JvY2hpcC5jb20+DQo+Pj4+Pj4NCj4+Pj4+PiBBZGQg
bW1jIGNhcGFiaWxpdGllcyBmb3IgU0RNTUMwIGZvciB0aGlzIGJvYXJkLg0KPj4+Pj4+IFdpdGgg
dGhpcyBlbmFibGVkLCBlTU1DIGNvbm5lY3RlZCBjYXJkIGlzIGRldGVjdGVkIGFzOg0KPj4+Pj4+
DQo+Pj4+Pj4gbW1jMDogbmV3IEREUiBNTUMgY2FyZCBhdCBhZGRyZXNzIDAwMDENCj4+Pj4+Pg0K
Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEV1Z2VuIEhyaXN0ZXYgPGV1Z2VuLmhyaXN0ZXZAbWljcm9j
aGlwLmNvbT4NCj4+Pj4+IEFja2VkLWJ5OiBMdWRvdmljIERlc3JvY2hlcyA8bHVkb3ZpYy5kZXNy
b2NoZXNAbWljcm9jaGlwLmNvbT4NCj4+Pj4+DQo+Pj4+PiBJIGFtIGludGVyZXN0ZWQgdG8gaGF2
ZSB0aGUgc29tZSBpbnNpZ2h0cyBhYm91dCB0aGUgdXNlIG9mIHNkLXVocy0qDQo+Pj4+PiBwcm9w
ZXJ0aWVzLg0KPj4+Pj4NCj4+Pj4+IE91ciBJUCBjYW4ndCBkZWFsIHdpdGggMVY4IGJ5IGl0c2Vs
Zi4gSXQgaGFzIGEgMVY4U0VMIHNpZ25hbCB3aGljaCBjYW4NCj4+Pj4+IGJlIHVzZWQgYXMgdGhl
IGxvZ2ljIGNvbnRyb2wgaW5wdXQgb2YgYSBtdXguIFNvIGV2ZW4gaWYgdGhlIElQIGNsYWltcw0K
Pj4+Pj4gdG8gc3VwcG9ydCBVSFMgbW9kZXMsIGl0IGRlcGVuZHMgb24gdGhlIGJvYXJkLg0KPj4+
Pj4NCj4+Pj4+IEFyZSB0aGUgc2QtdWhzLSogcHJvcGVydGllcyBhIHdheSB0byBkZWFsIHdpdGgg
dGhpcz8gSSB0ZW5kIHRvIHRoaW5rIG5vDQo+Pj4+PiBhcyBzZGhjaV9zZXR1cF9ob3N0KCkgd2ls
bCBzZXQgdGhlIGNhcHMgZGVwZW5kaW5nIG9uIHRoZSBjb250ZW50IG9mIHRoZQ0KPj4+Pj4gY2Fw
YWJpbGl0aWVzIHJlZ2lzdGVyLiBEbyB3ZSBoYXZlIHRvIHVzZSB0aGUgU0RIQ0lfUVVJUktfTUlT
U0lOR19DQVBTDQo+Pj4+PiBxdWlyayBvciBzZGhjaS1jYXBzL3NkaGNpLWNhcHMtbWFzaz8NCj4+
Pj4NCj4+Pj4gVGhlcmUgaXMgIm5vLTEtOC12IiB3aGljaCBpdCBsb29rcyBsaWtlIHNkaGNpLW9m
LWF0OTEuYyBhbHJlYWR5IHN1cHBvcnRzOg0KPj4+Pg0KPj4+PiAgICAgc2RoY2lfYXQ5MV9wcm9i
ZSgpIC0+IHNkaGNpX2dldF9vZl9wcm9wZXJ0eSgpIC0+IHNkaGNpX2dldF9wcm9wZXJ0eSgpDQo+
Pj4+DQo+Pj4+ICAgICAgIAlpZiAoZGV2aWNlX3Byb3BlcnR5X3ByZXNlbnQoZGV2LCAibm8tMS04
LXYiKSkNCj4+Pj4gCQlob3N0LT5xdWlya3MyIHw9IFNESENJX1FVSVJLMl9OT18xXzhfVjsNCj4+
Pj4NCj4+Pg0KPj4+IFJpZ2h0LCBJIGZvcmdvdCB0aGlzIHByb3BlcnR5LiBUaGFua3MuDQo+Pj4N
Cj4+PiBFdWdlbiwgZG8geW91IHNlZSBjYXNlcyB3ZSBjYW4ndCBjb3ZlciB3aXRoIHRoaXMgcHJv
cGVydHk/DQo+Pg0KPj4gSGksDQo+Pg0KPj4gRm9yIGN1cnJlbnQgcmVxdWlyZW1lbnRzIGFuZCBk
cml2ZXIgc3VwcG9ydCwgdGhpcyBzaG91bGQgYmUgZW5vdWdoLg0KPj4NCj4+IEkgbm90aWNlZCBv
bmUgdGhpbmcgcmVnYXJkaW5nIFNELUNhcmRzLCBpZiBJIGFkZCBwcm9wZXJ0eSBzZC11aHMtc2Ry
MTA0DQo+PiB0aGUgY2xhc3MgMTAgdWhzMSBjYXJkcyBhcmUgZGV0ZWN0ZWQgYXMgU0RSMTA0IC4g
V2l0aG91dCB0aGlzIHByb3BlcnR5DQo+PiB0aGV5IGFyZSBkZXRlY3RlZCBhcyBERFI1MC4gQW55
IGlkZWEgd2h5IHRoZSBkaWZmZXJlbmNlID8gVGhlIGNvbnRyb2xsZXINCj4+IGRvZXMgbm90IGNs
YWltIHRvIGhhdmUgU0RSMTA0IHN1cHBvcnQgPyAgV2Ugc2hvdWxkIGFkZCBpdCA/DQo+IA0KPiBX
aXRoIHRoZSBtYWlubGluZSwgb3VyIHRyZWUgb3IgYm90aD8gSW4gb3VyIHRyZWUsIFNEUjEwNCBp
cyByZW1vdmVkIGZyb20NCj4gdGhlIGNhcGFiaWxpdGllcy4NCj4gDQo+IEx1ZG92aWMNCj4gDQoN
Cg0KSGVsbG8gQWxleGFuZHJlLA0KDQpBbnl0aGluZyBtb3JlIG5lZWRlZCByZWdhcmRpbmcgdGhp
cyBwYXRjaCA/DQoNClRoYW5rcywNCkV1Z2VuDQo=
