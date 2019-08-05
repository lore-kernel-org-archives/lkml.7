Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11041C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 04:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5C132086D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 04:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qNSSHBmI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfHEEnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 00:43:37 -0400
Received: from mail-eopbgr10086.outbound.protection.outlook.com ([40.107.1.86]:40834
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725782AbfHEEnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 00:43:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RCVscB5nCrYNaC7epyaGUKu+x3ieinkHRd1dh6Z5xo0/NGznnNI7I3hCJtS9d7eFV7xQLIoSzUhU0hpopQ1TYHf01f+xhddxJOIhBMimahRfeUsR1SCICsp7ZSvOwLviiz6jChNPONn0CYeOu2Z/jJzyPQLhkUnRC6/oL/75+W/FS6UgRq7N0/YyMUVHV6eeRyoD3yzuyBYW7j/8AcUUAaQvHtuTP7q3g21TP4Igckf44sG0zue6/Kz8PRhIF/0HzxhWgyb2+yKwoE24mNNoQ3+xFZytwlFZQ7rzk52eklFN1/9d4exCBWPdOYBPeBhxntjzptL1rjYPQcgjRUkw8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXpQ398Ss/+OpEOoNror9sQM89T4nx7yOqWHspdvXZ4=;
 b=e6ym6U6yiVuHsK4EZ6TAmj9AN86pKIS51jmJ0oprivKBjT4HnQ9U03kpypiq8PKfMM5swjcsWXXABCxf2n8AFLZA6dUvIjGvndVic30JAo6rb8e6RouIzFEni5Wn3wxH3U55VKMf+w1NU1Y7s4nIAOu1JMhp5ZM+vX+qsyiGiNkehc+eTwPsQGSTJ3Nc85CTuwdGk3bqhog6oF19LZMBZuwfP6w7gDbx7QuSirifSXjWzeQzsSAiZX7Vpwrs7a0fDNRcnp+9G9j5EYYY6EpQDKsYL6SDuVwE0DlD1Qbwp+0TEf1XY57psCrAZHR2MVtkfEIGiTHxkAiOCH0HMXc6Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXpQ398Ss/+OpEOoNror9sQM89T4nx7yOqWHspdvXZ4=;
 b=qNSSHBmIOnazhJhXiYufNn5D6kdxJJbkK2b0DgKPNX4MdTKPUfP9+6BNLK1y8nXJ5UQLqMpgq+HP8IhD0hPeqVIl2FDK/i3Du2RDv/I0d5us/dIHEfjWbryFX1L46Iy8IFnieppD9HGg/yMfBu6q4lS02n7NlU5ckyc/rffiBCo=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB4708.eurprd04.prod.outlook.com (20.177.41.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.14; Mon, 5 Aug 2019 04:43:33 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::5553:29b6:d66c:6afe]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::5553:29b6:d66c:6afe%5]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 04:43:33 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Richard Zhu <hongxing.zhu@nxp.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
        Daniel Baluta <daniel.baluta@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Richard Zhu <hongxing.zhu@nxp.com>
Subject: RE: [PATCH v5 2/4] mailbox: imx: Clear the right interrupts at
 shutdown
Thread-Topic: [PATCH v5 2/4] mailbox: imx: Clear the right interrupts at
 shutdown
Thread-Index: AQHVSzveTVDkYvl4CU+OG2/I92EF2qbr+Z4Q
Date:   Mon, 5 Aug 2019 04:43:33 +0000
Message-ID: <AM0PR04MB4211D61BDF46688E5825DF0F80DA0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1564973491-18286-1-git-send-email-hongxing.zhu@nxp.com>
 <1564973491-18286-3-git-send-email-hongxing.zhu@nxp.com>
In-Reply-To: <1564973491-18286-3-git-send-email-hongxing.zhu@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7abbbc75-288e-4ece-7752-08d7195f78b9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4708;
x-ms-traffictypediagnostic: AM0PR04MB4708:
x-microsoft-antispam-prvs: <AM0PR04MB4708B508E759D62D7BBCBBB180DA0@AM0PR04MB4708.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:489;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(136003)(346002)(39860400002)(366004)(199004)(189003)(6436002)(5660300002)(9686003)(2501003)(81166006)(44832011)(26005)(486006)(14454004)(11346002)(186003)(6506007)(52536014)(66446008)(8676002)(110136005)(66946007)(53936002)(6636002)(55016002)(305945005)(4326008)(71190400001)(66476007)(76116006)(64756008)(8936002)(54906003)(66556008)(99286004)(86362001)(256004)(66066001)(15650500001)(229853002)(25786009)(68736007)(71200400001)(6246003)(2906002)(102836004)(316002)(446003)(7696005)(81156014)(74316002)(2201001)(7736002)(33656002)(76176011)(478600001)(6116002)(3846002)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4708;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: G+MkYqgODGy1ue2j5e1TVmd07rKFKn7UryUzo1yMNY8Sa3Gs2TC4wXD+pZsNYwGUiqnKsgUONQ+yD6dLERvVH8SemqERalpECaKEsVtOJ8kg1AaCi6Kh3bhL/u32qeOAzR2G6TlSrh3FkbnjjsrD34lERW3EARvmSFXGae7pCfBphgr/LopcrSdE0Zvy1T6Msb6a4Lmuw6Fkez4wXbtT3Vlo7+LP0KuTNfwkyPamSB/D8Gb5OPLu9mto0b5AWi0XxuitxgZrTotuApsP6H7VXYFr3v4qdoXj2fgKZGckzNtE0F71N+LqD4ZA4N3Z9ckDXEmeM3gjuXATiv2dKUdiMqDlD5vy/N5C4+T3IBAauQxrl85n2Qqb52IiT1vfn3jDU+VBv6sULcfQH5SqhqmYePjf4+TXaZF7Y4cD/x3NLN0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7abbbc75-288e-4ece-7752-08d7195f78b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 04:43:33.2983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aisheng.dong@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4708
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+IFNlbnQ6IE1vbmRh
eSwgQXVndXN0IDUsIDIwMTkgMTA6NTEgQU0NCj4gDQo+IE1ha2Ugc3VyZSB0byBvbmx5IGNsZWFy
IGVuYWJsZWQgaW50ZXJydXB0cyBrZWVwaW5nIGNvdW50IG9mIHRoZSBjb25uZWN0aW9uDQo+IHR5
cGUuDQo+IA0KPiBTdWdnZXN0ZWQtYnk6IE9sZWtzaWogUmVtcGVsIDxvLnJlbXBlbEBwZW5ndXRy
b25peC5kZT4NCj4gU2lnbmVkLW9mZi1ieTogRGFuaWVsIEJhbHV0YSA8ZGFuaWVsLmJhbHV0YUBu
eHAuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5j
b20+DQoNCktlZXAgb3JpZ2luYWwgYXV0aG9yIGlmIGFueS4NCk90aGVyd2lzZToNClJldmlld2Vk
LWJ5OiBEb25nIEFpc2hlbmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPg0KDQpSZWdhcmRzDQpBaXNo
ZW5nDQoNCj4gLS0tDQo+ICBkcml2ZXJzL21haWxib3gvaW14LW1haWxib3guYyB8IDE1ICsrKysr
KysrKysrKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tYWlsYm94L2lteC1tYWlsYm94LmMg
Yi9kcml2ZXJzL21haWxib3gvaW14LW1haWxib3guYw0KPiBpbmRleCAxZWVhYmM1Li5hZmU2MjVl
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL21haWxib3gvaW14LW1haWxib3guYw0KPiArKysgYi9k
cml2ZXJzL21haWxib3gvaW14LW1haWxib3guYw0KPiBAQCAtMjE5LDggKzIxOSwxOSBAQCBzdGF0
aWMgdm9pZCBpbXhfbXVfc2h1dGRvd24oc3RydWN0IG1ib3hfY2hhbg0KPiAqY2hhbikNCj4gIAkJ
cmV0dXJuOw0KPiAgCX0NCj4gDQo+IC0JaW14X211X3hjcl9ybXcocHJpdiwgMCwNCj4gLQkJICAg
SU1YX01VX3hDUl9USUVuKGNwLT5pZHgpIHwgSU1YX01VX3hDUl9SSUVuKGNwLT5pZHgpKTsNCj4g
Kwlzd2l0Y2ggKGNwLT50eXBlKSB7DQo+ICsJY2FzZSBJTVhfTVVfVFlQRV9UWDoNCj4gKwkJaW14
X211X3hjcl9ybXcocHJpdiwgMCwgSU1YX01VX3hDUl9USUVuKGNwLT5pZHgpKTsNCj4gKwkJYnJl
YWs7DQo+ICsJY2FzZSBJTVhfTVVfVFlQRV9SWDoNCj4gKwkJaW14X211X3hjcl9ybXcocHJpdiwg
MCwgSU1YX01VX3hDUl9SSUVuKGNwLT5pZHgpKTsNCj4gKwkJYnJlYWs7DQo+ICsJY2FzZSBJTVhf
TVVfVFlQRV9SWERCOg0KPiArCQlpbXhfbXVfeGNyX3Jtdyhwcml2LCAwLCBJTVhfTVVfeENSX0dJ
RW4oY3AtPmlkeCkpOw0KPiArCQlicmVhazsNCj4gKwlkZWZhdWx0Og0KPiArCQlicmVhazsNCj4g
Kwl9DQo+IA0KPiAgCWZyZWVfaXJxKHByaXYtPmlycSwgY2hhbik7DQo+ICB9DQo+IC0tDQo+IDIu
Ny40DQoNCg==
