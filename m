Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696E0C3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 12:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2229420870
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 12:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="cmxtziTw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbfHYM5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 08:57:42 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:36322 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbfHYM5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 08:57:42 -0400
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: BqTBbhOz71ulhhwt8Fc8CR2dTLjZfjiP8ouMRaOAbbdOvdTcgiSLSxsK1jf6PDXhK2koRnDErW
 L7cG3ZmnxSHXG0fb9+NbgVKMEiAVEzoa/Avqdw2p/fRH1JUHNBmBlaWviBg4YHgEs5YD8CHd4r
 tg3tMZUXAOJ+u5Q32wjPa4yrCtVi+HRm7wgl2CWs1GMBz0ha5lknjh8moTL2nWxxdDXiqSgMCz
 b9HGjbPHCR2rX9kU2CFkx+xFo+DXqB67FpWKJlBaqz+tmI/YO3MM/7TKKvxpLvnYeiBokh7Uab
 RPo=
X-IronPort-AV: E=Sophos;i="5.64,429,1559545200"; 
   d="scan'208";a="43600850"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Aug 2019 05:57:39 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 25 Aug 2019 05:57:39 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 25 Aug 2019 05:57:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b93LrDpr9ivTM+0cECfsbAiDpQAbzbQYw1Co0IWGud7YxBrDbCXmBO84eRhfMIo5aaGcPNcdFTiO7Ml7ut9xtBHc2Ymg9YFNhAirPAHnI9Iz3IovdiAZWq6BcCXzLJHBjNVUWSkg+P/P1U5TylWbQJ8oF2fs5KCkZU00P0VBjr4lI5omMCC7nEkxpjlNi7t0dol9aJOFk10Cz/B27AgXQ4jRfLJCsMr+t2rNWUizuOLkiuLwJTqpg4BayYN5bCDAZwWl5xJ9HpMvDvU4Y7RLwOL/fV77LxhFF/k4Wifz0kufqNgeiAqhMtV3SYhO1N5G/5+2/h9ddODiFjP7nb32Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLHoupxZLKIpkyZtzfi4g7eSWxnCmK9ZCMrju3uJz/g=;
 b=B8A4HzbAk6pCRtuOARQd7w5tS/q1Q0Ospvopzv6lAW+5ItLfGhd0V/cjv2vS96UQfnQmxdNZ8gJ5rC+TB0PhK+/8Vzx38J4vjCziVsoehrZHZzKahDQVDgOdsIYy+gmcWixxUu9adp39sQ9m8hJRcfdoo4urKe73HF77QEYD7e41mpweuI02sphmfA9yyOQjVEA5UL2slB8xRl1+UinZuxfNyJsIzqVUxNg7G++cjpakUxhC5V+CYypmwMzKRuQOX9CxSsVxPNzuQyDcsUqVsUXCatvpfM4m2sxLs51rZMsC6QgdGc229A1XmdoCfnQ6SVKSVAR8R6iXpFjzLMH11Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLHoupxZLKIpkyZtzfi4g7eSWxnCmK9ZCMrju3uJz/g=;
 b=cmxtziTwIYmZmrtCgx1NoAclqZpfrkUqHyT2vbmiHPz3t7DqEYeTHCkRKRUob8eonMelFlOd2jC9gVuZGMFU9l4z984/u0HkboIJQSPN+NhAfZ7ldZ6HfZfazx1p1CadjYFToChPVtEZlNv/FqD7FMtOdEDldQQWlmnBhvOumw4=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3549.namprd11.prod.outlook.com (20.178.250.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.19; Sun, 25 Aug 2019 12:57:35 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2199.021; Sun, 25 Aug 2019
 12:57:35 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>
CC:     <marek.vasut@gmail.com>, <vigneshr@ti.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 7/7] mtd: spi-nor: Rework the disabling of block write
 protection
Thread-Topic: [PATCH v2 7/7] mtd: spi-nor: Rework the disabling of block write
 protection
Thread-Index: AQHVWnORmecMuD4IS0mom6s4UeawIacLyySAgAAJPgA=
Date:   Sun, 25 Aug 2019 12:57:35 +0000
Message-ID: <836fcecd-766c-c7e3-74aa-06a148b146f8@microchip.com>
References: <20190824120027.14452-1-tudor.ambarus@microchip.com>
 <20190824120027.14452-8-tudor.ambarus@microchip.com>
 <20190825142421.35d31a9b@collabora.com>
In-Reply-To: <20190825142421.35d31a9b@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR06CA0085.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::14) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.127.53.184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f83e9fdc-78ce-48be-e880-08d7295bccbf
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB3549;
x-ms-traffictypediagnostic: MN2PR11MB3549:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <MN2PR11MB3549D93A79ED500996F8165FF0A60@MN2PR11MB3549.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01401330D1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(199004)(189003)(66946007)(6916009)(6116002)(3846002)(14454004)(305945005)(966005)(66066001)(66446008)(64756008)(66556008)(66476007)(14444005)(256004)(498600001)(7736002)(5660300002)(8936002)(26005)(102836004)(386003)(6506007)(53546011)(186003)(81156014)(81166006)(8676002)(36756003)(2616005)(476003)(25786009)(486006)(11346002)(53936002)(31686004)(54906003)(6246003)(446003)(6512007)(6306002)(31696002)(52116002)(86362001)(76176011)(2906002)(4326008)(6486002)(6436002)(229853002)(71190400001)(71200400001)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3549;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: M6T/7tJQExDC9RGVL0Phjqekt31JNXoIKkSreNaDsMJW9iFd51IKmYwCKfxocq50Z8TmgDprAiHPxxnwOXaq7UoKui2RWnFEda0vvkV4u1Lrc9dCLFFRBdKBGliNNYEo6aSM9hRyc2RGhlGIRZXZlEupxAK6yH6IqlrGNNzqRs7HgreU17wb9d2oh3t+F4Ib/YzOSceyljYrI3fa8OirudyEFvn9nT7wVRlymaWHyP2Odcu1AI4IMZ5bd4Jtg5tN9qUfATBkgNyDo7U+Ju6MCZu7ptI1rUKj83ST5xci+F10Epqsf2hzn/Dw7T4svQqaMpV98w6T9c44YIK4nveY7OD01D/Cx2JburO54FjY5FTZq9E4eh/JQYrNQWEkRiv9lXeH5SU2au2wiO5qcDHw3bK4g/sVACo8sg2rpJuNXDo=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B499477680E2A5449D8FE9048514BDA4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f83e9fdc-78ce-48be-e880-08d7295bccbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2019 12:57:35.1635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mr2PV9mNgjwvDga1KKW3k5Z1ywQbEXQU/B/ZeT97FTiE+mxj9ovTikdgPPIng2G97nbBoVujI+7AwKAHgScXUjjQjy82kWseffF87pOw0OU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3549
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA4LzI1LzIwMTkgMDM6MjQgUE0sIEJvcmlzIEJyZXppbGxvbiB3cm90ZToNCj4gT24g
U2F0LCAyNCBBdWcgMjAxOSAxMjowMDo0OCArMDAwMA0KPiA8VHVkb3IuQW1iYXJ1c0BtaWNyb2No
aXAuY29tPiB3cm90ZToNCj4gDQo+PiBGcm9tOiBUdWRvciBBbWJhcnVzIDx0dWRvci5hbWJhcnVz
QG1pY3JvY2hpcC5jb20+DQo+Pg0KPj4gR2V0IHJpZCBvZiBNRlIgaGFuZGxpbmcgYW5kIGltcGxl
bWVudCBzcGVjaWZpYyBtYW51ZmFjdHVyZXINCj4+IGRlZmF1bHRfaW5pdCgpIGZpeHVwIGhvb2tz
Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbWlj
cm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gIGRyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jIHwg
MzAgKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDIw
IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYyBiL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5j
DQo+PiBpbmRleCBmYzllMTQ3NzcyMTIuLmY0ZTlmY2NhNjE5ZiAxMDA2NDQNCj4+IC0tLSBhL2Ry
aXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jDQo+PiArKysgYi9kcml2ZXJzL210ZC9zcGktbm9y
L3NwaS1ub3IuYw0KPj4gQEAgLTQxNDYsNiArNDE0NiwxNiBAQCBzdGF0aWMgaW50IHNwaV9ub3Jf
cGFyc2Vfc2ZkcChzdHJ1Y3Qgc3BpX25vciAqbm9yLA0KPj4gIAlyZXR1cm4gZXJyOw0KPj4gIH0N
Cj4+ICANCj4+ICtzdGF0aWMgdm9pZCBhdG1lbF9zZXRfZGVmYXVsdF9pbml0KHN0cnVjdCBzcGlf
bm9yICpub3IpDQo+PiArew0KPj4gKwlub3ItPnBhcmFtcy5kaXNhYmxlX2Jsb2NrX3Byb3RlY3Rp
b24gPSBzcGlfbm9yX2NsZWFyX3NyX2JwOw0KPj4gK30NCj4+ICsNCj4+ICtzdGF0aWMgdm9pZCBp
bnRlbF9zZXRfZGVmYXVsdF9pbml0KHN0cnVjdCBzcGlfbm9yICpub3IpDQo+PiArew0KPj4gKwlu
b3ItPnBhcmFtcy5kaXNhYmxlX2Jsb2NrX3Byb3RlY3Rpb24gPSBzcGlfbm9yX2NsZWFyX3NyX2Jw
Ow0KPiANCj4gVGhhdCdzIHdlaXJkOiB5b3UgY2FuIHVubG9jayBibG9ja3MgYnV0IGxvY2tpbmcg
aXMgbm90DQo+IGV4cGxpY2l0bHkgZmxhZ2dlZCBhcyBzdXBwb3J0ZWQgKFNOT1JfRl9IQVNfTE9D
SyBpcyBub3Qgc2V0KS4gSXMgdGhhdA0KPiBleHBlY3RlZD8NCg0KWWVzLiBNYW51ZmFjdHVyZXJz
IGhhdmUgZGlmZmVyZW50IG1ldGhvZHMgZm9yIGxvY2tpbmcvdW5sb2NraW5nIGJsb2NrcyBvZg0K
bWVtb3J5LiBSaWdodCBub3cgd2Ugc3VwcG9ydCBqdXN0IHRoZSBzdG0vc3IgbG9ja2luZyBvcGVy
YXRpb25zLiBzc3QyNnZmMDY0YiBmb3INCmV4YW1wbGUsIHVzZXMgZGVkaWNhdGVkIHJlZ2lzdGVy
cyBmb3IgcmVhZGluZy93cml0aW5nIHdoaWNoIGJsb2NrcyBhcmUNCnByb3RlY3RlZCwgYW5kIG5v
dCB0aGUgU3RhdHVzIFJlZ2lzdGVyLg0KDQpUaGUgcmVhc29uIGZvciBoYXZpbmcgZGlzYWJsZV9i
bG9ja19wcm90ZWN0aW9uKCksIGlzIHRoYXQgc29tZSBzcGktbm9yIGZsYXNoZXMNCmFyZSB3cml0
ZSBwcm90ZWN0ZWQgYnkgZGVmYXVsdCBhZnRlciBhIHBvd2VyLW9uIHJlc2V0IGN5Y2xlLCBpbiBv
cmRlciB0byBhdm9pZA0KaW5hZHZlcnRlbnQgd3JpdGVzIGR1cmluZyBwb3dlci11cC4gQmFja3dh
cmQgY29tcGF0aWJpbGl0eSBpbXBvc2VzIHRvIGRpc2FibGUNCnRoZSB3cml0ZSBibG9jayBwcm90
ZWN0aW9uIGF0IHBvd2VyLXVwIGJ5IGRlZmF1bHQsIHNvIHRoYXQgeW91IGNhbiBlcmFzZS93cml0
ZQ0KdGhlIG1lbW9yeSB3aXRob3V0IGhhdmluZyB0byBzZW5kIGFuIHVubG9jay1hbGwgY29tbWFu
ZC4gV2hpY2ggaXMgYmFkIGluIG15DQpvcGluaW9uIGFuZCB0aGF0J3Mgd2h5IEkgcHJvcG9zZWQg
aHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wYXRjaC8xMTMzMjc4Ly4NCg0KRXZlbiBpZiBz
c3QyNnZmMDY0YiBkb2VzIG5vdCB5ZXQgaGF2ZSB0aGUgbG9jayBvcHMgaW1wbGVtZW50ZWQgKFNO
T1JfRl9IQVNfTE9DSw0KaXMgbm90IHNldCksIEkgd291bGQgbGlrZSB0byBiZSBhYmxlIHRvIGlu
dGVyYWN0IHdpdGggaXQsIHNvIHRvIGRpc2FibGUgdGhlDQpibG9jayBwcm90ZWN0aW9uIGF0IHBv
d2VyLXVwLiBUaGlzIGZsYXNoLCBhbmQgb3RoZXJzLCBzdXBwb3J0IGEgR2xvYmFsIFVubG9jaw0K
Q29tbWFuZCB3aGljaCB1bmxvY2tzIHRoZSBlbnRpcmUgbWVtb3J5IGFycmF5IGluIGEgc2luZ2xl
IGN5Y2xlLiBXZSBjYW4ndA0KZGV0ZXJtaW5lIHdobyBzdXBwb3J0cyB0aGlzIGNvbW1hbmQgcHVy
ZWx5IGJ5IG1hbnVmYWN0dXJlciB0eXBlLCBhbmQgaXQncyBub3QNCmRpc2NvdmVyYWJsZSB0aHJv
dWdoIFNGRFAsIHNvIHdlJ2xsIGhhdmUgdG8gYWRkIGEgbm9yLT5pbmZvIGZsYWcgZm9yIGl0Og0K
VU5MT0NLX0dMT0JBTF9CTE9DSyAoc2VlIGh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcGF0
Y2gvMTE1MjYwNi8pLg0KDQpJbiBjb25jbHVzaW9uLCBldmVuIGlmIFNOT1JfRl9IQVNfTE9DSyBp
cyBub3Qgc2V0ICh0aGUgbG9ja2luZyBvcHMgYXJlIG5vdA0KaW1wbGVtZW50ZWQpLCB3ZSBjYW4g
c3RpbGwgaGF2ZSBkaXNhYmxlX2Jsb2NrX3Byb3RlY3Rpb24oKSBtZWNoYW5pc21zIHRvIHVubG9j
aw0KdGhlIGVudGlyZSBmbGFzaCBhdCBwb3dlci11cC4NCg0KPiANCj4+ICt9DQo+PiArDQo+PiAg
c3RhdGljIHZvaWQgbWFjcm9uaXhfc2V0X2RlZmF1bHRfaW5pdChzdHJ1Y3Qgc3BpX25vciAqbm9y
KQ0KPj4gIHsNCj4+ICAJbm9yLT5wYXJhbXMucXVhZF9lbmFibGUgPSBtYWNyb25peF9xdWFkX2Vu
YWJsZTsNCj4+IEBAIC00MTczLDYgKzQxODMsMTQgQEAgc3RhdGljIHZvaWQgc3BpX25vcl9tYW51
ZmFjdHVyZXJfaW5pdF9wYXJhbXMoc3RydWN0IHNwaV9ub3IgKm5vcikNCj4+ICB7DQo+PiAgCS8q
IEluaXQgZmxhc2ggcGFyYW1ldGVycyBiYXNlZCBvbiBNRlIgKi8NCj4+ICAJc3dpdGNoIChKRURF
Q19NRlIobm9yLT5pbmZvKSkgew0KPj4gKwljYXNlIFNOT1JfTUZSX0FUTUVMOg0KPj4gKwkJYXRt
ZWxfc2V0X2RlZmF1bHRfaW5pdChub3IpOw0KPj4gKwkJYnJlYWs7DQo+PiArDQo+PiArCWNhc2Ug
U05PUl9NRlJfSU5URUw6DQo+PiArCQlpbnRlbF9zZXRfZGVmYXVsdF9pbml0KG5vcik7DQo+PiAr
CQlicmVhazsNCj4+ICsNCj4+ICAJY2FzZSBTTk9SX01GUl9NQUNST05JWDoNCj4+ICAJCW1hY3Jv
bml4X3NldF9kZWZhdWx0X2luaXQobm9yKTsNCj4+ICAJCWJyZWFrOw0KPj4gQEAgLTQ3NjAsMTgg
KzQ3NzgsMTAgQEAgaW50IHNwaV9ub3Jfc2NhbihzdHJ1Y3Qgc3BpX25vciAqbm9yLCBjb25zdCBj
aGFyICpuYW1lLA0KPj4gIAlpZiAoaW5mby0+ZmxhZ3MgJiBTUElfUzNBTikNCj4+ICAJCW5vci0+
ZmxhZ3MgfD0gIFNOT1JfRl9SRUFEWV9YU1JfUkRZOw0KPj4gIA0KPj4gLQlpZiAoaW5mby0+Zmxh
Z3MgJiBTUElfTk9SX0hBU19MT0NLKQ0KPj4gKwlpZiAoaW5mby0+ZmxhZ3MgJiBTUElfTk9SX0hB
U19MT0NLKSB7DQo+IA0KPiBJZiB0aGlzIGZsYWcgaW1wbGllcyBTUl9CUC1iYXNlZCBsb2NraW5n
IHdlIHNob3VsZCByZWFsbHkgcmVuYW1lIGl0IGludG8NCj4gU1BJX05PUl9IQVNfU1JfQlBfTE9D
SyB0byBhdm9pZCBhbnkgY29uZnVzaW9uLg0KDQpOb3Qgb25seSBTUi1iYXNlZCBsb2NraW5nLCBz
aG91bGQgYmUgYSBnZW5lcmFsIGZsYWcgdGhhdCBpbmRpY2F0ZXMgdGhhdCBsb2NraW5nDQpvcHMg
YXJlIHN1cHBvcnRlZCB3aGljaGV2ZXIgdGhleSBhcmUuIEkgd291bGQga2VlcCB0aGUgU1BJX05P
Ul9IQVNfTE9DSyBhbmQgbGV0DQp0aGUgbWFudWZhY3R1cmVyIHNldCBpdHMgbG9ja2luZyBvcHMg
dXNpbmcgdGhlIC0+ZGVmYXVsdF9pbml0KCkgaG9vay4NCg0KPiANCj4+ICAJCW5vci0+ZmxhZ3Mg
fD0gU05PUl9GX0hBU19MT0NLOw0KPj4gLQ0KPj4gLQkvKg0KPj4gLQkgKiBBdG1lbCwgU1NULCBJ
bnRlbC9OdW1vbnl4LCBhbmQgb3RoZXJzIHNlcmlhbCBOT1IgdGVuZCB0byBwb3dlciB1cA0KPj4g
LQkgKiB3aXRoIHRoZSBzb2Z0d2FyZSBwcm90ZWN0aW9uIGJpdHMgc2V0Lg0KPj4gLQkgKi8NCj4+
IC0JaWYgKEpFREVDX01GUihub3ItPmluZm8pID09IFNOT1JfTUZSX0FUTUVMIHx8DQo+PiAtCSAg
ICBKRURFQ19NRlIobm9yLT5pbmZvKSA9PSBTTk9SX01GUl9JTlRFTCB8fA0KPj4gLQkgICAgSkVE
RUNfTUZSKG5vci0+aW5mbykgPT0gU05PUl9NRlJfU1NUIHx8DQo+PiAtCSAgICBub3ItPmluZm8t
PmZsYWdzICYgU1BJX05PUl9IQVNfTE9DSykNCj4+ICAJCW5vci0+cGFyYW1zLmRpc2FibGVfYmxv
Y2tfcHJvdGVjdGlvbiA9IHNwaV9ub3JfY2xlYXJfc3JfYnA7DQo+PiArCX0NCj4+ICANCj4+ICAJ
LyogSW5pdCBmbGFzaCBwYXJhbWV0ZXJzIGJhc2VkIG9uIGZsYXNoX2luZm8gc3RydWN0IGFuZCBT
RkRQICovDQo+PiAgCXNwaV9ub3JfaW5pdF9wYXJhbXMobm9yKTsNCj4gDQo+IA0K
