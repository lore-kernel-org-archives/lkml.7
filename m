Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19891C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 06:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C96D921D6C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 06:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="d7pmmWz+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfKGG1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 01:27:38 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:3935 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbfKGG1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 01:27:38 -0500
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
IronPort-SDR: 70DXJUNXMh+odCrHZA2zHdVuodZctQFJ17vu2A6JWHEjaYwIG50tCvjLMbK6F36k2bWSUpzRSt
 8Fxl/0m68tqHboMb9MibXcJH8MjOZhVvBKIhr32HqV4X5cIsFLKLDtQmhbV7DLJH42KEqOxSjq
 IUrGWMXAVXezWjZUmVr+T2dzUlU/MoKQmEXvL2vr7Cc4wAk8iWoX/RH+SFCbxtHg02uMZE0M/N
 zOVSgnlctnh3xYTYZvwv6PVlGzz/lsveKaG9khuhQMz8Xast2frWjJ8gMUsOXr7l1pvht98zd4
 HxQ=
X-IronPort-AV: E=Sophos;i="5.68,277,1569308400"; 
   d="scan'208";a="53255057"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Nov 2019 23:27:37 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 6 Nov 2019 23:27:23 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 6 Nov 2019 23:27:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jVxOZ1wxPW/8BIbW9C/cA1l8rQ5X1HxH6UFH4d9LAXd2ZCbaVcOO822ODrjuIEjatZOf4cCWMXgM7yCF29Z/8dMY0lHUma+BjhFDEiYjCnnF6+PEL1Rp+bLo0D+6rNUlTdm+ilf4xlwrmVzMJZeUaTgL3xiWtXko3h0C1jTxwRaAYrBziG5RpAfiHN/iWbTv8wFlIMoiUYQyKMZH2gz4UCpM+NbQfWJU+qZ/MQcqfFFPO4vWRnAPtxhaejvd16U9NEfbLOo53EzpMT65cKjcCuyGVE8siyCfW1CmkxVmSkuV3Szgqvc+97ljpSxMimtdmWl1f45ip7lBh8A+QUIpvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8kStirzX+tz+0sU+k84VW+p+QmPLoLYZiDZ1UEiueI=;
 b=FmpvmdsnmHHEy8xJsgGO18zW1VcKoQuWREUIs+rEukgY3uMiFVImkKQiJkqavJ3sCzq5hP7aUwmFXgIwF667xIvADLz8nFXOW3TMKdr03uSKzgZrHQzv05W/e4Xle5tM+gi/977lBzVz+EBjuW2Ns3eQajl25btmE2IO+07dkLrS7k74K5Ai6G5Rjxd8ttBlmWdP7AoPTi6AYQdMfWbKyowtOUo5eipo6Q8+l+pLX4bz8/isItwmYD1dJ3hU4tKMnHqlG2MdDlvfb7m26j5MzLsWLkr9OTk6zplxC1QchSaG3HmapJ2uZGd280ZGp5YLLGadWpG+dwMmbTlqDZ0EDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8kStirzX+tz+0sU+k84VW+p+QmPLoLYZiDZ1UEiueI=;
 b=d7pmmWz+9G+yD92WU5nGMyUwuLavHl+ExFts8CGLW13Qv4ts22BeAgzZyHYnhqxOCqZwKfEgwYLjd5pxIwPhYVlznmyUJmQrRTEocdhLHdckCFlRznkrMff9BybmIYSmWgcireK18XAoJ1uH3BdXOltwGQfOPTowRMc8eMp5I+k=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3984.namprd11.prod.outlook.com (10.255.181.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Thu, 7 Nov 2019 06:27:22 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2408.025; Thu, 7 Nov 2019
 06:27:22 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <vigneshr@ti.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 00/20] mtd: spi-nor: Quad Enable and (un)lock methods
Thread-Topic: [PATCH v4 00/20] mtd: spi-nor: Quad Enable and (un)lock methods
Thread-Index: AQHVkW/w1K7mIia8jkCIYuk++qibt6d/ReIA
Date:   Thu, 7 Nov 2019 06:27:21 +0000
Message-ID: <cee4df21-b2f8-f9a3-d936-e79d57e926f2@microchip.com>
References: <20191102112316.20715-1-tudor.ambarus@microchip.com>
In-Reply-To: <20191102112316.20715-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P195CA0071.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::24) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.120.239.29]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e685fc9-9476-4897-2cd3-08d7634b8baf
x-ms-traffictypediagnostic: MN2PR11MB3984:
x-microsoft-antispam-prvs: <MN2PR11MB39842C54AB62C3DCFBE38A00F0780@MN2PR11MB3984.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0214EB3F68
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(366004)(346002)(136003)(39860400002)(189003)(199004)(486006)(71190400001)(5660300002)(66556008)(66946007)(25786009)(64756008)(31696002)(71200400001)(66446008)(66476007)(31686004)(99286004)(14454004)(110136005)(316002)(14444005)(256004)(7736002)(36756003)(478600001)(54906003)(186003)(305945005)(26005)(2906002)(446003)(229853002)(11346002)(86362001)(2501003)(102836004)(3846002)(6116002)(8936002)(6506007)(81156014)(81166006)(66066001)(386003)(53546011)(76176011)(6436002)(52116002)(8676002)(4326008)(476003)(6246003)(6512007)(6486002)(2616005)(414714003)(473944003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3984;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U3EAZqUkK6ZYrgKRfgtM8tlh8F+Lt4y/cZZa7gW+XrCez3Nk98LpVT0bbt2aqdX40RHmFf0PQyg/+fzWROeKL1+NV6aDOLboGqLDdnG26Rd95D3pOwqrRnCqOPWgO6PazXWqKylBRzMJKaLMYFop6mhqn0Lat95x+adnDvx4qnYXaVknEWp1f6NDMYwmmd53zjHGuIO+x7+cEErPVyCgPa8CBELRTJDSTYMAFI6mGBX/TJ/unSb22YtPAjRbw+n8cQeZzVsreqd8y3ZBaZRk97bLnPBca+cgDoGX3iiKLdyUcXRGttjNC/GeSRuarRDFmXI759b58SubLGbkrH9nyNFuwyKFBzfwOt0AsqFos03os7MxB9vHiwSc2hkwnuKOwOJTChizY0GWk669bI2EUgMcBXlfThb71EVDI/zfS/5nwkKgTjvGnO05PItXtAbD
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <FF63B19E9322C14FB2F2D0AE7D33503E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e685fc9-9476-4897-2cd3-08d7634b8baf
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 06:27:21.7442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8A1vv+VUOreFmAQUlKeLOk2f19b2/Yn0PdA02dpv419o59GBn6v2lWjXk/nmFYlXTY7f++PTZFgxqCK0RlQx8U9YZflBs6Dgl3QWG8csD2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3984
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDExLzAyLzIwMTkgMDE6MjMgUE0sIFR1ZG9yIEFtYmFydXMgLSBNMTgwNjQgd3JvdGU6
DQo+IEZyb206IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbT4NCj4g
DQo+IFRlc3RlZCBvbiBzMjVmbDExNmsgYW5kIHcyNXExMjhqdi1xLg0KPiANCj4gRml4ZWQgdGhl
IGNsZWFyaW5nIG9mIFFFIGJpdCBvbiAodW4pbG9jaygpIG9wZXJhdGlvbnMuIFJld29ya2VkIHRo
ZQ0KPiBRdWFkIEVuYWJsZSBtZXRob2RzIGFuZCB0aGUgZGlzYWJsaW5nIG9mIHRoZSBibG9jayB3
cml0ZSBwcm90ZWN0aW9uDQo+IGF0IHBvd2VyLXVwLg0KPiANCj4gdjQ6DQo+IC0gVXNlIGRldl9k
YmcgaW5zdGVkIG9mIGRldl9lcnIgZm9yIGxvdyBsZXZlbCBpbmZvDQo+IC0gcmVwbGFjZSAiJm5v
ci0+Ym91bmNlYnVmWzBdIiB3aXRoICJub3ItPmJvdW5jZWJ1ZiIgYW5kICImc3JfY3JbMF0iIHdp
dGgNCj4gICAic3JfY3IiLiBVcGRhdGUgYWNyb3NzIGFsbCBwYXRjaGVzLg0KPiANCj4gdjM6IHNw
bGl0IHBhdGNoZXMsIHVwZGF0ZSByZXRsZW4gaGFuZGxpbmcgaW4gc3N0X3dyaXRlLg0KPiANCj4g
djI6DQo+IC0gSW50cm9kdWNlIHNwaV9ub3Jfd3JpdGVfMTZiaXRfY3JfYW5kX2NoZWNrKCkgYXMg
cGVyIFZpZ25lc2gncyBzdWdnZXN0aW9uLiBUaGUNCj4gICBDb25maWd1cmF0aW9uIFJlZ2lzdGVy
IGNvbnRhaW5zIGJpdHMgdGhhdCBjYW4gYmUgdXBkYXRlZCBpbiBmdXR1cmU6IEZSRUVaRSwNCj4g
ICBDTVAuIFByb3ZpZGUgYSBnZW5lcmljIG1ldGhvZCB0aGF0IGFsbG93cyB1cGRhdGluZyBhbGwg
Yml0cyBvZiB0aGUNCj4gICBDb25maWd1cmF0aW9uIFJlZ2lzdGVyLg0KPiAtIEZpeCBTTk9SX0Zf
Tk9fUkVBRF9DUiBjYXNlIGluDQo+ICAgIm10ZDogc3BpLW5vcjogUmV3b3JrIHRoZSBkaXNhYmxp
bmcgb2YgYmxvY2sgd3JpdGUgcHJvdGVjdGlvbiIuIFdoZW4gdGhlIGZsYXNoDQo+ICAgZG9lc24n
dCBzdXBwb3J0IHRoZSBDUiBSZWFkIGNvbW1hbmQsIHdlIG1ha2UgYW4gYXNzdW1wdGlvbiBhYm91
dCB0aGUgdmFsdWUgb2YNCj4gICB0aGUgUUUgYml0LiBJbiBzcGlfbm9yX2luaXQoKSwgY2FsbCBz
cGlfbm9yX3F1YWRfZW5hYmxlKCkgZmlyc3QsIHRoZW4NCj4gICBzcGlfbm9yX3VubG9ja19hbGwo
KSwgc28gdGhhdCBhdCB0aGUgc3BpX25vcl91bmxvY2tfYWxsKCkgdGltZSB3ZSBjYW4gYmUgc3Vy
ZQ0KPiAgIHRoZSBRRSBiaXQgaGFzIHZhbHVlIG9uZSwgYmVjYXVzZSBvZiB0aGUgcHJldmlvdXMg
Y2FsbCB0byBzcGlfbm9yX3F1YWRfZW5hYmxlKCkuDQo+IC0gRml4IGlmIHN0YXRlbWVudCBpbiBz
cGlfbm9yX3dyaXRlX3NyX2FuZF9jaGVjaygpOg0KPiAgIGlmIChub3ItPmZsYWdzICYgU05PUl9G
X0hBU18xNkJJVF9TUikNCj4gLSBGaXggZG9jdW1lbnRhdGlvbiB3YXJuaW5ncy4NCj4gLSBOZXcg
cGF0Y2g6ICJtdGQ6IHNwaS1ub3I6IENoZWNrIGFsbCB0aGUgYml0cyB3cml0dGVuLCBub3QganVz
dCB0aGUgQlAgb25lcyIuDQo+IC0gRHJvcCBHbG9iYWwgVW5sb2NrIHBhdGNoZXMsIHdpbGwgc2Vu
ZCB0aGVtIGluIGEgZGlmZmVyZW50IHBhdGNoIHNldC4NCj4gDQo+IFRoZSBwYXRjaCBzZXQgY2Fu
IGJlIHRlc3RlZCB1c2luZyBtdGQtdXRpbHM6DQo+IDEvIGRvIGEgcmVhZC1lcmFzZS13cml0ZS1y
ZWFkLWJhY2sgdGVzdCBpbW1lZGlhdGVseSBhZnRlciBib290LCB0byBjaGVjaw0KPiB0aGUgc3Bp
X25vcl91bmxvY2tfYWxsKCkgbWV0aG9kLiBUaGUgZm9jdXMgaXMgb24gdGhlIGVyYXNlL3dyaXRl
DQo+IG1ldGhvZHMsIHdlIHdhbnQgdG8gc2VlIGlmIHRoZSBmbGFzaCBpcyB1bmxvY2tlZCBhdCBw
b3dlci11cC4NCj4gICAgICAgICBtdGRfZGVidWcgcmVhZCAvZGV2L210ZC15b3VycyBvZmZzZXQg
c2l6ZSByZWFkLWZpbGUNCj4gICAgICAgICBoZXhkdW1wIHJlYWQtZmlsZQ0KPiAgICAgICAgIG10
ZF9kZWJ1ZyBlcmFzZSAvZGV2L210ZC15b3VycyBvZmZzZXQgc2l6ZQ0KPiAgICAgICAgIGRkIGlm
PS9kZXYvdXJhbmRvbSBvZj13cml0ZS1maWxlIGJzPXBsZWFzZS1jaG9vc2UgY291bnQ9cGxlYXNl
LWNob29zZQ0KPiAgICAgICAgIG10ZF9kZWJ1ZyB3cml0ZSAvZGV2L210ZC15b3VycyBvZmZzZXQg
d3JpdGUtZmlsZS1zaXplIHdyaXRlLWZpbGUNCj4gICAgICAgICBtdGRfZGVidWcgcmVhZCAvZGV2
L210ZC15b3VycyBvZmZzZXQgd3JpdGUtZmlsZS1zaXplIHJlYWQtZmlsZQ0KPiAgICAgICAgIHNo
YTFzdW0gcmVhZC1maWxlIHdyaXRlLWZpbGUNCj4gMi8gbG9jayBmbGFzaCB0aGVuIHRyeSB0byBl
cmFzZS93cml0ZSBpdCwgdG8gc2VlIGlmIHRoZSBsb2NrIHdvcmtzDQo+ICAgICAgICAgZmxhc2hf
bG9jayAvZGV2L210ZC15b3VycyBvZmZzZXQgYmxvY2stY291bnQNCj4gICAgICAgICBEbyB0aGUg
cmVhZC1lcmFzZS13cml0ZS1yZWFkLWJhY2sgdGVzdCBmcm9tIDEvLiBUaGUgY29udGVudHMgb2YN
Cj4gICAgICAgICBmbGFzaCBzaG91bGQgbm90IGNoYW5nZSBpbiB0aGUgZXJhc2UgYW5kIHdyaXRl
IHN0ZXBzLg0KPiAzLyB1bmxvY2sgZmxhc2ggYW5kIGRvIHRoZSByZWFkLWVyYXNlLXdyaXRlLXJl
YWQtYmFjayBmcm9tIDEvLiBUaGUgdmFsdWUgb2YgdGhlDQo+ICAgIFFFRSBzaG91bGQgbm90IGNo
YW5nZSBhbmQgeW91IHNob3VsZCBiZSBhYmxlIHRvIGVyYXNlIGFuZCB3cml0ZSB0aGUgZmxhc2gu
DQo+ICAgIFRlc3QgMS8gc2hvdWxkIGJlIHN1Y2Nlc3NmdWwuDQo+IA0KPiBUdWRvciBBbWJhcnVz
ICgyMCk6DQo+ICAgbXRkOiBzcGktbm9yOiBVc2UgZGV2X2RiZyBpbnN0ZWQgb2YgZGV2X2VyciBm
b3IgbG93IGxldmVsIGluZm8NCj4gICBtdGQ6IHNwaS1ub3I6IFByaW50IGRlYnVnIGluZm8gaW5z
aWRlIFJlZyBPcHMgbWV0aG9kcw0KPiAgIG10ZDogc3BpLW5vcjogQ2hlY2sgZm9yIGVycm9ycyBh
ZnRlciBlYWNoIFJlZ2lzdGVyIE9wZXJhdGlvbg0KPiAgIG10ZDogc3BpLW5vcjogUmVuYW1lIGxh
YmVsIGFzIGl0IGlzIG5vIGxvbmdlciBnZW5lcmljDQo+ICAgbXRkOiBzcGktbm9yOiBWb2lkIHJl
dHVybiB0eXBlIGZvciBzcGlfbm9yX2NsZWFyX3NyL2ZzcigpDQo+ICAgbXRkOiBzcGktbm9yOiBN
b3ZlIHRoZSBXRSBhbmQgd2FpdCBjYWxscyBpbnNpZGUgV3JpdGUgU1IgbWV0aG9kcw0KPiAgIG10
ZDogc3BpLW5vcjogTWVyZ2Ugc3BpX25vcl93cml0ZV9zcigpIGFuZCBzcGlfbm9yX3dyaXRlX3Ny
X2NyKCkNCj4gICBtdGQ6IHNwaS1ub3I6IERlc2NyaWJlIGFsbCB0aGUgUmVnIE9wcw0KPiAgIG10
ZDogc3BpLW5vcjogRHJvcCBzcGFuc2lvbl9xdWFkX2VuYWJsZSgpDQo+ICAgbXRkOiBzcGktbm9y
OiBGaXggZXJybm8gb24gUXVhZCBFbmFibGUgbWV0aG9kcw0KPiAgIG10ZDogc3BpLW5vcjogQ2hl
Y2sgYWxsIHRoZSBiaXRzIHdyaXR0ZW4sIG5vdCBqdXN0IHRoZSBCUCBvbmVzDQo+ICAgbXRkOiBz
cGktbm9yOiBQcmludCBkZWJ1ZyBtZXNzYWdlIHdoZW4gdGhlIHJlYWQgYmFjayB0ZXN0IGZhaWxz
DQo+ICAgbXRkOiBzcGktbm9yOiBGaXggY2xlYXJpbmcgb2YgUUUgYml0IG9uIGxvY2soKS91bmxv
Y2soKQ0KPiAgIG10ZDogc3BpLW5vcjogRXh0ZW5kIHRoZSBRRSBSZWFkIEJhY2sgdGVzdCB0byB0
aGUgZW50aXJlIFNSIGJ5dGUNCj4gICBtdGQ6IHNwaS1ub3I6IEV4dGVuZCB0aGUgUUUgUmVhZCBC
YWNrIHRlc3QgdG8gYm90aCBTUjEgYW5kIFNSMg0KPiAgIG10ZDogc3BpLW5vcjogUmVuYW1lIENS
X1FVQURfRU5fU1BBTiB0byBTUjJfUVVBRF9FTl9CSVQxDQo+ICAgbXRkOiBzcGktbm9yOiBNZXJn
ZSBzcGFuc2lvbiBRdWFkIEVuYWJsZSBtZXRob2RzDQo+ICAgbXRkOiBzcGktbm9yOiBSZW5hbWUg
bWFjcm9uaXhfcXVhZF9lbmFibGUgdG8NCj4gICAgIHNwaV9ub3Jfc3IxX2JpdDZfcXVhZF9lbmFi
bGUNCj4gICBtdGQ6IHNwaS1ub3I6IFByZXBlbmQgInNwaV9ub3JfIiB0byAic3IyX2JpdDdfcXVh
ZF9lbmFibGUiDQo+ICAgbXRkOiBzcGktbm9yOiBSZXdvcmsgdGhlIGRpc2FibGluZyBvZiBibG9j
ayB3cml0ZSBwcm90ZWN0aW9uDQo+IA0KPiAgZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9yLmMg
fCA5NTIgKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tDQo+ICBpbmNs
dWRlL2xpbnV4L210ZC9zcGktbm9yLmggICB8ICAxMiArLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA1
ODMgaW5zZXJ0aW9ucygrKSwgMzgxIGRlbGV0aW9ucygtKQ0KPiANCg0KVXBkYXRlZCAxLzIwIHRv
IHVzZSBkZXZfZXJyKCkgd2hlbiB0aGUgU1IvRlNSIHJlcG9ydCBwcm9ncmFtIG9yIGVyYXNlIGZh
aWxzLCBvcg0KYXR0ZW1wdHMgb2YgbW9kaWZ5aW5nIGEgcHJvdGVjdGVkIHNlY3Rvci4gUGF0Y2hl
cyAxLTEyIGFwcGxpZWQgdG8gc3BpLW5vci9uZXh0Lg0KVGhhbmtzLg0K
