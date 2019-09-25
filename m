Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E241C432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 10:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 503B620872
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 10:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="gvj2J3yC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387569AbfIYKMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 06:12:02 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:40265 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfIYKMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 06:12:02 -0400
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
IronPort-SDR: FEGV6e7H53UMdySlKCXJ/HvsP95pAH4Brsxh7Yt/j/ndA+0aLu1T/5p13Md9c/MYJiO3xkzjmP
 KhZ1LswfTT25tFO6+A4JvMVwa8GJvZgghQzhkFLYc9xQpRRPrD0e1syr+tbKeOgijlJvcuVVfv
 TzEpHR7C6gNCCeCyjdNHGz8KDs2A6/KcpM8CoRoSyKdy/LnW09Z+P0Xmon6GZzyMTi/gP+lTND
 lSqJXA29SZMCt49YfvoEmgDVi4TYG+wuF8cwLyC8EyVWO7u1bKvIKKjqOAxvb4OKM43Ky8vaGZ
 8+0=
X-IronPort-AV: E=Sophos;i="5.64,547,1559545200"; 
   d="scan'208";a="47552187"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Sep 2019 03:11:59 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 25 Sep 2019 03:11:58 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 25 Sep 2019 03:11:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HXREl4OUVIcOZt1QB26PJtmQlrizN5J0aydPLRWjpCa+q82GJ2N3t3ovaZ8K6qoEUsYqYucoTax+5j+0qwKdOxUBvj/5xNO7VmZhvkSJ/BBBeymqiTXvpUlAVx5mnbLVeuSl+C3zIjzcnTCULRsEwYochoWSK9JBVdjxlwS63oXVA5uIMlS5CkCqTPJtSoaLkNoSp/juCIffLI4Y4ph6iEApJ+rsVGSW8vnOhl1gwF+E7g9oF2Qrb+akrxF4wlq3yFTY9RNOBsVi6fhozyxSDC3KHPMgo2smTSgjXBSSKHJcjXcJQkr9dyEM7cG9eMiqWEIRp3IOcsmBD3nzwjmTUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2BjSMR3yr+5J102XjPxyn7QY8odpJUIW6ihHfy51bzs=;
 b=a8874xNtftAzeJd0FRoe/vMueE2QZyXy3u+8OcaOjgQ7Rx3GTTirdvtKw45xoKJlPjsBa2X3MIvmZETh0xLtdCUM2rfWncqwmtBgX3DXr6Fbv5MxXsngTlnbzMalw8CjTFV1gtSlV3rM+wZhziLF9Bt91Xa50jyMxRa5TK6YCwN+oncHVbo9XD/loytLqMBX4JjhzcblpH1bc7VeyDP0h7tX559ZHQxE/vmZhV6aLV+ufNfXJ0nbLJIhfj0fJQIjv81uFAnbXmVxvTftnq9oAiix4FDQVVdrnRjBP8BVAR9IacNaqud71LNUOgC98ImBvzQ+6Ht++iiTSMOjoYt9zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2BjSMR3yr+5J102XjPxyn7QY8odpJUIW6ihHfy51bzs=;
 b=gvj2J3yCQNjetf7PbpXfqy8zecg9fMl9vm7N3ioghrJ8nteTApLBZxyxDNzG4lEcZPyqrFJQszgWdPkw7itRCQ+asu3R6BbGUn98umqkbVnnwc4P/ijKsFcM+wlDMjIGLo10jEA4VIUkIRb0qb05v+tUz50QgvbNjzMUW3TSa4o=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3870.namprd11.prod.outlook.com (10.255.180.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.23; Wed, 25 Sep 2019 10:11:57 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7%7]) with mapi id 15.20.2284.023; Wed, 25 Sep 2019
 10:11:57 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <linux-mtd@lists.infradead.org>, <jonas@norrbonn.se>
CC:     <vigneshr@ti.com>, <boris.brezillon@collabora.com>,
        <marek.vasut@gmail.com>, <geert+renesas@glider.be>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <matthias.bgg@gmail.com>, <vz@mleia.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v2 00/22] mtd: spi-nor: Quad Enable and (un)lock methods
Thread-Topic: [PATCH v2 00/22] mtd: spi-nor: Quad Enable and (un)lock methods
Thread-Index: AQHVcqwSdD6kLiVX1Emf+kHUSzIQ7qc8Le+A
Date:   Wed, 25 Sep 2019 10:11:57 +0000
Message-ID: <f5d876a7-4610-2729-8f4a-0c122946d436@microchip.com>
References: <20190924074533.6618-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190924074533.6618-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0502CA0024.eurprd05.prod.outlook.com
 (2603:10a6:803:1::37) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d6c43738-a951-46fb-2863-08d741a0cc2b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB3870;
x-ms-traffictypediagnostic: MN2PR11MB3870:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <MN2PR11MB38706EB7671ECD18C60DDAFBF0870@MN2PR11MB3870.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(366004)(376002)(346002)(199004)(189003)(31686004)(5660300002)(2501003)(8676002)(86362001)(7416002)(14454004)(52116002)(2616005)(6306002)(11346002)(8936002)(6246003)(966005)(36756003)(256004)(110136005)(6512007)(6506007)(53546011)(386003)(446003)(26005)(3846002)(14444005)(71190400001)(66446008)(66556008)(64756008)(66476007)(99286004)(66946007)(476003)(305945005)(54906003)(31696002)(478600001)(486006)(25786009)(81166006)(81156014)(71200400001)(7736002)(76176011)(316002)(186003)(2906002)(66066001)(102836004)(6436002)(229853002)(6116002)(4326008)(6486002)(473944003)(414714003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3870;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: toIlL00ROZwV/ZskYiI85nPFJGiGNIVtUfJVvSQgrD4GRUfsD+3Qmydm+HKbiDSywNSHmJhJtWDaH3NZ9WbD80h4MfVyypYsaARPgMdWIoVg50B9HnxwzzpQijrSnAf+OEo6UyhUzz3sjnQ2I+g+7eeZE1BzaySsaMFC5itxYTY5Lq57dcyWFFCE/w3FhTrf0X+mJJHjKVEUIfjd/6nwCxzkf493AWjsuujoh4/fqnRDCby8gyYILnz5hetJcYPjoycOP9csAChhQRcjKLlSby4BrCHxfvdWFFwYTxPc710MIKuarqE6xgqD1x2zXeNEbDtovHPI3oMvp+BHbHEHwtz1/X3izxjQZXPrHXEpT0IlKxBjZfiUs1l3H4f6c6tOiPgNodc2TQNWSG9k3YRzsmP1oS6m/RYiwFreKLrFRSXowqDmHs+eOB/pG1vzcBaY/0sobqHBXckfReJAXvaBmg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED60A6E11FA76044AF3DE5FE82590E5E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d6c43738-a951-46fb-2863-08d741a0cc2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 10:11:57.4716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WEA05J6V5HDPq+ccMjJdQxZ+GQQZzerE7BikNzJJb8lW1l5zfkhX8/T54zWpmSN5aLUWX7DCyLJFcBz9hsxbjdkYztxxZPXgeIpRSKJ2+cU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3870
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEpvbmFzLA0KDQpzMjVmbDUxMnMgaXMgaW1wYWN0ZWQgYnkgdGhpcyBwYXRjaCBzZXQuIFdv
dWxkIHlvdSBwbGVhc2UgZG8gYSBsaXR0bGUgdGVzdCB0bw0Kc2VlIGlmIGV2ZXJ5dGhpbmcgaXMg
b2sgZm9yIHlvdXIgZmxhc2ggd2l0aCB0aGVzZSBwYXRjaGVzIGFwcGxpZWQ/IEkgZG9uJ3QgaGF2
ZQ0KdGhlIGZsYXNoLCBzbyBJIGNhbid0IGRvIHRoZSB0ZXN0cyBieSBteXNlbGYuIFRoZXJlIGlz
IGEgcG9zc2libGUgdGVzdCBtZXRob2QNCmRlc2NyaWJlZCBiZWxvdyBpbiB0aGUgY292ZXIgbGV0
dGVyLg0KDQpZb3UgY2FuIGZpbmQgdGhlIHBhdGNoZXMgYXQNCmh0dHBzOi8vcGF0Y2h3b3JrLm96
bGFicy5vcmcvcHJvamVjdC9saW51eC1tdGQvbGlzdC8/c2VyaWVzPTEzMjI3MCBvciBhdA0KaHR0
cHM6Ly9naXRodWIuY29tL2FtYmFydXMvbGludXgtMGRheSwgYnJhbmNoIHNwaS1ub3IvcXVhZC1l
bmFibGUtcmV3b3JrLXYyLg0KDQpUaGFuayB5b3UsDQp0YQ0KDQpPbiAwOS8yNC8yMDE5IDEwOjQ1
IEFNLCBUdWRvciBBbWJhcnVzIC0gTTE4MDY0IHdyb3RlOg0KPiBGcm9tOiBUdWRvciBBbWJhcnVz
IDx0dWRvci5hbWJhcnVzQG1pY3JvY2hpcC5jb20+DQo+IA0KPiBQYXRjaGVzIDEgLSAxNCBhcmUg
anVzdCBjbGVhbiB1cCBwYXRjaGVzIGZvciB0aGUgRmxhc2ggUmVnaXN0ZXINCj4gT3BlcmF0aW9u
cy4NCj4gDQo+IFBhdGNoZXMgMTUgLSAyMiBkZWFsIHdpdGggdGhlIFF1YWQgRW5hYmxlIGFuZCB0
aGUgKHVuKWxvY2sgbWV0aG9kcy4NCj4gRml4ZWQgdGhlIGNsZWFyaW5nIG9mIFFFIGJpdCBvbiAo
dW4pbG9jaygpIG9wZXJhdGlvbnMuIFJld29ya2VkIHRoZQ0KPiBRdWFkIEVuYWJsZSBtZXRob2Rz
IGFuZCB0aGUgZGlzYWJsaW5nIG9mIHRoZSBibG9jayB3cml0ZSBwcm90ZWN0aW9uDQo+IGF0IHBv
d2VyLXVwLg0KPiANCj4gQWdhaW4sIHRoaXMgaXMganVzdCBjb21waWxlIHRlc3RlZCwgSSBkb24n
dCBoYXZlICh5ZXQpIGEgcmVsZXZhbnQNCj4gc3BhbnNpb24tbGlrZSBmbGFzaCBtZW1vcnkgdG8g
dGVzdCB0aGUgKHVuKWxvY2soKSBtZXRob2RzLCBzbyBJJ2xsIG5lZWQNCj4geW91ciBoZWxwIGZv
ciB0ZXN0aW5nIHRoaXMgcGF0Y2ggc2V0Lg0KPiANCj4gVGhlIHBhdGNoIHNldCBjYW4gYmUgdGVz
dGVkIHVzaW5nIG10ZC11dGlsczoNCj4gMS8gZG8gYSByZWFkLWVyYXNlLXdyaXRlLXJlYWQtYmFj
ayB0ZXN0IGltbWVkaWF0ZWx5IGFmdGVyIGJvb3QsIHRvIGNoZWNrDQo+IHRoZSBzcGlfbm9yX3Vu
bG9ja19hbGwoKSBtZXRob2QuIFRoZSBmb2N1cyBpcyBvbiB0aGUgZXJhc2Uvd3JpdGUNCj4gbWV0
aG9kcywgd2Ugd2FudCB0byBzZWUgaWYgdGhlIGZsYXNoIGlzIHVubG9ja2VkIGF0IHBvd2VyLXVw
Lg0KPiAgICAgICAgIG10ZF9kZWJ1ZyByZWFkIC9kZXYvbXRkLXlvdXJzIG9mZnNldCBzaXplIHJl
YWQtZmlsZQ0KPiAgICAgICAgIGhleGR1bXAgcmVhZC1maWxlDQo+ICAgICAgICAgbXRkX2RlYnVn
IGVyYXNlIC9kZXYvbXRkLXlvdXJzIG9mZnNldCBzaXplDQo+ICAgICAgICAgZGQgaWY9L2Rldi91
cmFuZG9tIG9mPXdyaXRlLWZpbGUgYnM9cGxlYXNlLWNob29zZSBjb3VudD1wbGVhc2UtY2hvb3Nl
DQo+ICAgICAgICAgbXRkX2RlYnVnIHdyaXRlIC9kZXYvbXRkLXlvdXJzIG9mZnNldCB3cml0ZS1m
aWxlLXNpemUgd3JpdGUtZmlsZQ0KPiAgICAgICAgIG10ZF9kZWJ1ZyByZWFkIC9kZXYvbXRkLXlv
dXJzIG9mZnNldCB3cml0ZS1maWxlLXNpemUgcmVhZC1maWxlDQo+ICAgICAgICAgc2hhMXN1bSBy
ZWFkLWZpbGUgd3JpdGUtZmlsZQ0KPiAyLyBsb2NrIGZsYXNoIHRoZW4gdHJ5IHRvIGVyYXNlL3dy
aXRlIGl0LCB0byBzZWUgaWYgdGhlIGxvY2sgd29ya3MNCj4gICAgICAgICBmbGFzaF9sb2NrIC9k
ZXYvbXRkLXlvdXJzIG9mZnNldCBibG9jay1jb3VudA0KPiAgICAgICAgIERvIHRoZSByZWFkLWVy
YXNlLXdyaXRlLXJlYWQtYmFjayB0ZXN0IGZyb20gMS8uIFRoZSBjb250ZW50cyBvZg0KPiAgICAg
ICAgIGZsYXNoIHNob3VsZCBub3QgY2hhbmdlIGluIHRoZSBlcmFzZSBhbmQgd3JpdGUgc3RlcHMu
DQo+IDMvIHVubG9jayBmbGFzaCBhbmQgZG8gdGhlIHJlYWQtZXJhc2Utd3JpdGUtcmVhZC1iYWNr
IGZyb20gMS8uIFRoZSB2YWx1ZSBvZiB0aGUNCj4gICAgUUVFIHNob3VsZCBub3QgY2hhbmdlIGFu
ZCB5b3Ugc2hvdWxkIGJlIGFibGUgdG8gZXJhc2UgYW5kIHdyaXRlIHRoZSBmbGFzaC4NCj4gICAg
VGVzdCAxLyBzaG91bGQgYmUgc3VjY2Vzc2Z1bC4NCj4gDQo+IHYyOg0KPiAtIEludHJvZHVjZSBz
cGlfbm9yX3dyaXRlXzE2Yml0X2NyX2FuZF9jaGVjaygpIGFzIHBlciBWaWduZXNoJ3Mgc3VnZ2Vz
dGlvbi4gVGhlDQo+ICAgQ29uZmlndXJhdGlvbiBSZWdpc3RlciBjb250YWlucyBiaXRzIHRoYXQg
Y2FuIGJlIHVwZGF0ZWQgaW4gZnV0dXJlOiBGUkVFWkUsDQo+ICAgQ01QLiBQcm92aWRlIGEgZ2Vu
ZXJpYyBtZXRob2QgdGhhdCBhbGxvd3MgdXBkYXRpbmcgYWxsIGJpdHMgb2YgdGhlDQo+ICAgQ29u
ZmlndXJhdGlvbiBSZWdpc3Rlci4NCj4gLSBGaXggU05PUl9GX05PX1JFQURfQ1IgY2FzZSBpbg0K
PiAgICJtdGQ6IHNwaS1ub3I6IFJld29yayB0aGUgZGlzYWJsaW5nIG9mIGJsb2NrIHdyaXRlIHBy
b3RlY3Rpb24iLiBXaGVuIHRoZSBmbGFzaA0KPiAgIGRvZXNuJ3Qgc3VwcG9ydCB0aGUgQ1IgUmVh
ZCBjb21tYW5kLCB3ZSBtYWtlIGFuIGFzc3VtcHRpb24gYWJvdXQgdGhlIHZhbHVlIG9mDQo+ICAg
dGhlIFFFIGJpdC4gSW4gc3BpX25vcl9pbml0KCksIGNhbGwgc3BpX25vcl9xdWFkX2VuYWJsZSgp
IGZpcnN0LCB0aGVuDQo+ICAgc3BpX25vcl91bmxvY2tfYWxsKCksIHNvIHRoYXQgYXQgdGhlIHNw
aV9ub3JfdW5sb2NrX2FsbCgpIHRpbWUgd2UgY2FuIGJlIHN1cmUNCj4gICB0aGUgUUUgYml0IGhh
cyB2YWx1ZSBvbmUsIGJlY2F1c2Ugb2YgdGhlIHByZXZpb3VzIGNhbGwgdG8gc3BpX25vcl9xdWFk
X2VuYWJsZSgpLg0KPiAtIEZpeCBpZiBzdGF0ZW1lbnQgaW4gc3BpX25vcl93cml0ZV9zcl9hbmRf
Y2hlY2soKToNCj4gICBpZiAobm9yLT5mbGFncyAmIFNOT1JfRl9IQVNfMTZCSVRfU1IpDQo+IC0g
Rml4IGRvY3VtZW50YXRpb24gd2FybmluZ3MuDQo+IC0gTmV3IHBhdGNoOiAibXRkOiBzcGktbm9y
OiBDaGVjayBhbGwgdGhlIGJpdHMgd3JpdHRlbiwgbm90IGp1c3QgdGhlIEJQIG9uZXMiLg0KPiAt
IERyb3AgR2xvYmFsIFVubG9jayBwYXRjaGVzLCB3aWxsIHNlbmQgdGhlbSBpbiBhIGRpZmZlcmVu
dCBwYXRjaCBzZXQuDQo+IA0KPiBUdWRvciBBbWJhcnVzICgyMik6DQo+ICAgbXRkOiBzcGktbm9y
OiBoaXNpLXNmYzogRHJvcCBub3ItPmVyYXNlIE5VTEwgYXNzaWdubWVudA0KPiAgIG10ZDogc3Bp
LW5vcjogSW50cm9kdWNlICdzdHJ1Y3Qgc3BpX25vcl9jb250cm9sbGVyX29wcycNCj4gICBtdGQ6
IHNwaS1ub3I6IGNhZGVuY2UtcXVhZHNwaTogRml4IGNxc3BpX2NvbW1hbmRfcmVhZCgpIGRlZmlu
aXRpb24NCj4gICBtdGQ6IHNwaS1ub3I6IFJlbmFtZSBub3ItPnBhcmFtcyB0byBub3ItPmZsYXNo
DQo+ICAgbXRkOiBzcGktbm9yOiBSZXdvcmsgcmVhZF9zcigpDQo+ICAgbXRkOiBzcGktbm9yOiBS
ZXdvcmsgcmVhZF9mc3IoKQ0KPiAgIG10ZDogc3BpLW5vcjogUmV3b3JrIHJlYWRfY3IoKQ0KPiAg
IG10ZDogc3BpLW5vcjogUmV3b3JrIHdyaXRlX2VuYWJsZS9kaXNhYmxlKCkNCj4gICBtdGQ6IHNw
aS1ub3I6IEZpeCByZXRsZW4gaGFuZGxpbmcgaW4gc3N0X3dyaXRlKCkNCj4gICBtdGQ6IHNwaS1u
b3I6IFJld29yayB3cml0ZV9zcigpDQo+ICAgbXRkOiBzcGktbm9yOiBSZXdvcmsgc3BpX25vcl9y
ZWFkL3dyaXRlX3NyMigpDQo+ICAgbXRkOiBzcGktbm9yOiBSZXBvcnQgZXJyb3IgaW4gc3BpX25v
cl94cmVhZF9zcigpDQo+ICAgbXRkOiBzcGktbm9yOiBWb2lkIHJldHVybiB0eXBlIGZvciBzcGlf
bm9yX2NsZWFyX3NyL2ZzcigpDQo+ICAgbXRkOiBzcGktbm9yOiBEcm9wIGR1cGxpY2F0ZWQgbmV3
IGxpbmUNCj4gICBtdGQ6IHNwaS1ub3I6IERyb3Agc3BhbnNpb25fcXVhZF9lbmFibGUoKQ0KPiAg
IG10ZDogc3BpLW5vcjogRml4IGVycm5vIG9uIHF1YWRfZW5hYmxlIG1ldGhvZHMNCj4gICBtdGQ6
IHNwaS1ub3I6IENoZWNrIGFsbCB0aGUgYml0cyB3cml0dGVuLCBub3QganVzdCB0aGUgQlAgb25l
cw0KPiAgIG10ZDogc3BpLW5vcjogRml4IGNsZWFyaW5nIG9mIFFFIGJpdCBvbiBsb2NrKCkvdW5s
b2NrKCkNCj4gICBtdGQ6IHNwaS1ub3I6IFJld29yayBtYWNyb25peF9xdWFkX2VuYWJsZSgpDQo+
ICAgbXRkOiBzcGktbm9yOiBSZXdvcmsgc3BhbnNpb24oX25vKV9yZWFkX2NyX3F1YWRfZW5hYmxl
KCkNCj4gICBtdGQ6IHNwaS1ub3I6IFVwZGF0ZSBzcjJfYml0N19xdWFkX2VuYWJsZSgpDQo+ICAg
bXRkOiBzcGktbm9yOiBSZXdvcmsgdGhlIGRpc2FibGluZyBvZiBibG9jayB3cml0ZSBwcm90ZWN0
aW9uDQo+IA0KPiAgZHJpdmVycy9tdGQvc3BpLW5vci9hc3BlZWQtc21jLmMgICAgICB8ICAgMjMg
Ky0NCj4gIGRyaXZlcnMvbXRkL3NwaS1ub3IvY2FkZW5jZS1xdWFkc3BpLmMgfCAgIDU0ICstDQo+
ICBkcml2ZXJzL210ZC9zcGktbm9yL2hpc2ktc2ZjLmMgICAgICAgIHwgICAyMyArLQ0KPiAgZHJp
dmVycy9tdGQvc3BpLW5vci9pbnRlbC1zcGkuYyAgICAgICB8ICAgMjQgKy0NCj4gIGRyaXZlcnMv
bXRkL3NwaS1ub3IvbXRrLXF1YWRzcGkuYyAgICAgfCAgIDI1ICstDQo+ICBkcml2ZXJzL210ZC9z
cGktbm9yL254cC1zcGlmaS5jICAgICAgIHwgICAyMyArLQ0KPiAgZHJpdmVycy9tdGQvc3BpLW5v
ci9zcGktbm9yLmMgICAgICAgICB8IDE3MTYgKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0t
LS0tDQo+ICBpbmNsdWRlL2xpbnV4L210ZC9zcGktbm9yLmggICAgICAgICAgIHwgICA3NCArLQ0K
PiAgOCBmaWxlcyBjaGFuZ2VkLCAxMDU4IGluc2VydGlvbnMoKyksIDkwNCBkZWxldGlvbnMoLSkN
Cj4gDQo=
