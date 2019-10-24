Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BF1CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 11:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EF0720684
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 11:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="FyDP7u6j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392172AbfJXLBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 07:01:47 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:29298 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730032AbfJXLBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 07:01:47 -0400
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: sjSMwU5rLXXe7c6hoZtqn44KVmRqZWEDosgFlZCg4pqufQSAh6SlFcerohbDyWadszAAbiPPhL
 PyDjes3vcYYy81F+oK/GI75jlF4mdluFdVmx9tPv0IenSEQsvM3mxQ81oVD5l359hmJmmDwKgB
 7SzMHivCwBa//l9a0xdjP/SojjvtsEavpiWRbAO/CSluC6ouOZGpLu/jxUMPna+nlH08VyfFLF
 18fjWNniNNIddwXU1LUPoOG9KZgT8uR0al/OBlvlFpSMi+iU97aS+APMaPAKvhDBt9aen0WS+P
 jck=
X-IronPort-AV: E=Sophos;i="5.68,224,1569308400"; 
   d="scan'208";a="52745880"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Oct 2019 04:01:45 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 24 Oct 2019 04:01:43 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Thu, 24 Oct 2019 04:01:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WC5HKudfzV77CaNRhLOvxmcjZk4RS5kfbs2sLCx890SeLACKhvLzGGC15F6svMZqd6Div/W41XWN4tvzPgFJReYWudsGzfwwnWli1/Eu9pjM/dZ/vFSYuwHFvnSmFpxGyN/VKujm1iHbVhUQhzAAB9j8JpYIHTXRZ/OpNS/Y0Y/ThOaiYCar5h+JvB4bx1kh7NETGWrEccDq/8ZkHMgHpydC2G9HHf9iJw8K3zWR9FS7PJqnmgEqP+x+zmc0WSk9oPoX42yxdn39IOYz4f6Tt7mR0ko86uqjPQrWVIuFMJXZW+3cCwTEP6PwkbiqSrNWWO2VtU2GJEreC/g/3YxROQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tDu91HlPGHYfW+KnCVpz8LQdGOPu3IbIo2ZvQSvh5zc=;
 b=Mnd4q/3Zh+yTqhpWhjf5Xblu+d5Rnw7ntVQBwiAEO4FxSZ0mU0nNBJArHOjxEjwIWnpBDL58rjVgTE+ibRZ0xAfg9SglP1ZmwaNCg+V94cRCuk+qwP7Nd74AYdUj1VFR6ZsJLI+MVy0hvCzKRy5OsHvYK1byWkHWiwL2sU/iLm7sM8dPEXEr7EcjgmmrzHLN2tjZ9Xo0+TZeouCJwJKtOF9i1sCdhAKWCJFGbSJ7uqWHOKt+oE/iVHjf/XKLSPGiwocw5YxVVfTUTMfkWxBFxsSx3fjtK8cMx6bqBqtoW7Q05CCXbBkldmP3KWAxCIigmPbK7fX++dkz4BlWO8DT9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tDu91HlPGHYfW+KnCVpz8LQdGOPu3IbIo2ZvQSvh5zc=;
 b=FyDP7u6jTuPNqBYa2gS/P7tc+mpCq0iyh5Gxa1EdK2/daJ0V4/C4uRQ/PRpCjFogcLMAqND+VoIdY9LqQOqR/Y7k/cz4ZBrjFCWXYuZT1JX05vsize8crW3k1/ct24fl1YF56Zx/EBzlD91TMUfeeq/Q5A9WXqvHOw3Q/lX3Z/s=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4303.namprd11.prod.outlook.com (52.135.37.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.24; Thu, 24 Oct 2019 11:01:43 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2347.030; Thu, 24 Oct 2019
 11:01:42 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>
CC:     <linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
        <geert+renesas@glider.be>, <andrew@aj.id.au>, <richard@nod.at>,
        <linux-kernel@vger.kernel.org>, <vz@mleia.com>,
        <marek.vasut@gmail.com>, <jonas@norrbonn.se>,
        <linux-mtd@lists.infradead.org>, <joel@jms.id.au>,
        <miquel.raynal@bootlin.com>, <matthias.bgg@gmail.com>,
        <linux-mediatek@lists.infradead.org>,
        <computersforpeace@gmail.com>, <dwmw2@infradead.org>,
        <linux-aspeed@lists.ozlabs.org>
Subject: Re: [PATCH v2 08/22] mtd: spi-nor: Rework write_enable/disable()
Thread-Topic: [PATCH v2 08/22] mtd: spi-nor: Rework write_enable/disable()
Thread-Index: AQHVcqwmGxayarzEFkyHj/sWgnNJNqdTkUSAgBV/k4CAAGu3AIAAUuMA
Date:   Thu, 24 Oct 2019 11:01:42 +0000
Message-ID: <3e11ac30-98fa-98c5-3f2e-3fb1f373ffe1@microchip.com>
References: <20190924074533.6618-1-tudor.ambarus@microchip.com>
 <20190924074533.6618-9-tudor.ambarus@microchip.com>
 <20191010092117.4c5018a8@dhcp-172-31-174-146.wireless.concordia.ca>
 <34fbb0d7-ee8f-a6d7-4a3e-d64f2f8555ff@microchip.com>
 <20191024080452.522b6447@collabora.com>
In-Reply-To: <20191024080452.522b6447@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR0P264CA0075.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:18::15) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.120.239.29]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a234a4b-16b6-4243-79d1-08d758718d8e
x-ms-traffictypediagnostic: MN2PR11MB4303:
x-microsoft-antispam-prvs: <MN2PR11MB430340495273680B28D95F7CF06A0@MN2PR11MB4303.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(346002)(376002)(396003)(199004)(189003)(478600001)(386003)(229853002)(7416002)(66066001)(99286004)(6506007)(66446008)(7736002)(64756008)(305945005)(66476007)(66556008)(4326008)(3846002)(14454004)(8676002)(316002)(81156014)(54906003)(81166006)(6116002)(8936002)(486006)(6486002)(6246003)(52116002)(11346002)(31686004)(476003)(6916009)(71200400001)(76176011)(14444005)(71190400001)(66946007)(2616005)(5660300002)(36756003)(26005)(25786009)(6512007)(53546011)(102836004)(31696002)(256004)(186003)(2906002)(6436002)(86362001)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4303;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SxkkELEaNrkNMzbAX/Bym2hKq7u+K0pFCVxd7ChQI98cfz2h0hN9iSXGAkWBb9AZB91mArVB2yTL6uSLTDljYHVIFtKQF9k3urirdu6LcICRztcXuNgxxg6gKsbfNZvT6+Fn5rJc96gzb5uS1diOClZAhoce0V/gJo/N0jYylH0PSeirj0nTW1RZNZ9v1VmYRSE96bSKnCQkEVRRraVh2ZHX3lIaPW1kWfvHFwTqKMeD1ddhl3YVQ/iglLQ6c0OUpzxGPEJpTugPlReGDHE+Em7Kv3AX2Lx2HwuqYJPqm2PTB7TpgT3F1vFASEu2SYECZivFDkodkaeJWVL0s5vbMLU5iCp6jIJJNxVJFOIHheAvpAQU4Uwa4EaKG1xM7l524XvsDLTNG2GOyNNtVDefI6vOnnPdbtxoz0sjbdVFzL1lrXFW/byDix9S/bseVFZr
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <40D5304F00A23D439C5EBC86E4E15200@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a234a4b-16b6-4243-79d1-08d758718d8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 11:01:42.7027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x+LnAxtKIg7YFg8LJajqZ5Z376lMdvE2gsc5nt7l6dMLHJGyaDgE8vktY/NzvsmFef9ddCfFEDt5NecLmb1De9gsO6zR+SMtVjyf7La1ZLI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4303
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDEwLzI0LzIwMTkgMDk6MDQgQU0sIEJvcmlzIEJyZXppbGxvbiB3cm90ZToNCj4gT24g
V2VkLCAyMyBPY3QgMjAxOSAyMzozOTozMSArMDAwMA0KPiA8VHVkb3IuQW1iYXJ1c0BtaWNyb2No
aXAuY29tPiB3cm90ZToNCj4gDQo+PiBPbiAxMC8xMC8yMDE5IDEwOjIxIEFNLCBCb3JpcyBCcmV6
aWxsb24gd3JvdGU6DQo+Pj4gRXh0ZXJuYWwgRS1NYWlsDQo+Pj4NCj4+Pg0KPj4+IE9uIFR1ZSwg
MjQgU2VwIDIwMTkgMDc6NDY6MTggKzAwMDANCj4+PiA8VHVkb3IuQW1iYXJ1c0BtaWNyb2NoaXAu
Y29tPiB3cm90ZToNCj4+PiAgIA0KPj4+PiBGcm9tOiBUdWRvciBBbWJhcnVzIDx0dWRvci5hbWJh
cnVzQG1pY3JvY2hpcC5jb20+DQo+Pj4+DQo+Pj4+IHN0YXRpYyBpbnQgd3JpdGVfZW5hYmxlKHN0
cnVjdCBzcGlfbm9yICpub3IpDQo+Pj4+IHN0YXRpYyBpbnQgd3JpdGVfZGlzYWJsZShzdHJ1Y3Qg
c3BpX25vciAqbm9yKQ0KPj4+PiBiZWNvbWUNCj4+Pj4gc3RhdGljIGludCBzcGlfbm9yX3dyaXRl
X2VuYWJsZShzdHJ1Y3Qgc3BpX25vciAqbm9yKQ0KPj4+PiBzdGF0aWMgaW50IHNwaV9ub3Jfd3Jp
dGVfZGlzYWJsZShzdHJ1Y3Qgc3BpX25vciAqbm9yKQ0KPj4+Pg0KPj4+PiBDaGVjayBmb3IgZXJy
b3JzIGFmdGVyIGVhY2ggY2FsbCB0byB0aGVtLiBNb3ZlIHRoZW0gdXAgaW4gdGhlDQo+Pj4+IGZp
bGUgYXMgdGhlIGZpcnN0IFNQSSBOT1IgUmVnaXN0ZXIgT3BlcmF0aW9ucywgdG8gYXZvaWQgZnVy
dGhlcg0KPj4+PiBmb3J3YXJkIGRlY2xhcmF0aW9ucy4gIA0KPj4+DQo+Pj4gU2FtZSBoZXJlLCBz
cGxpdCB0aGF0IGluIDMgcGF0Y2hlcyBwbGVhc2UuICANCj4gDQo+IEluIG9yZGVyIHRvIGtlZXAg
dGhlIG51bWJlciBvZiBwYXRjaCBpbiB0aGlzIHNlcmllcyBzbWFsbCwgSSdkDQo+IHJlY29tbWVu
ZCBkb2luZyBhbGwgc3BpX25vcl8gcHJlZml4aW5nIGluIGEgcGF0Y2gsIGFsbCBmdW5jdGlvbg0K
PiBtb3ZlcyBpbiBhbm90aGVyIG9uZSBhbmQgYWxsIGVycm9yIGNoZWNraW5nIGluIGEgdGhpcmQg
cGF0Y2gsIGluc3RlYWQgb2YNCj4gc3BsaXR0aW5nIGl0IHBlci1mdW5jdGlvbi4NCj4gDQoNCklm
IEkgZG8gYWxsIHRoZSBmdW5jdGlvbnMgbW92ZW1lbnQgaW4gb25lIHBhdGNoLCB0aGUgZ2l0IGRp
ZmYgb3V0cHV0IGJlY29tZXMNCnVucmVhZGFibGUuIEknbGwgc3BsaXQgcGF0Y2hlcyB3aGVyZSBu
ZWVkZWQsIGZvciByZWFkYWJpbGl0eSBwdXJwb3Nlcy4NCg==
