Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94EDC3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 08:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80C8220870
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 08:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OReKZoti"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732149AbfHVIMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 04:12:46 -0400
Received: from mail-eopbgr30081.outbound.protection.outlook.com ([40.107.3.81]:24129
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728952AbfHVIMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 04:12:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J47PsnD+UkSTv/d+spcS+bJH9FoqGLU7L+J9QQDV+bojBGP+1JvRgwqXxWEXjDocOlVoD+A0VIPG3LEhd/jwQmibP3o1vcOZsreBmvBVyvOp0plcwSJE35uoPe6PoNtVzaxbE6FoiKQ2yaGUmLmNbpnfhstlikdGpd5kBMUxMi5J2hJQL2yWvc4SPPbGmxA2zhvppLA8r5m2gpeIH+rqCIGqMJkarinoumKQPzIU4ADwPW8jm9z0DkkOIF2SAD+KcPLgTVqJGJxrbXDXymA1vwhi3m1/2OnLV4wNKXzDnn3Zevic3mFsABzeHlhf+bavSi8XSa6LHptQYGIpu2VcKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RY2QFor1bpfw1XLvsGfcTLracdfzoN6ZXByEwvgvims=;
 b=brOqsvg6t9aMafAqsmLcG9dp/OQYc5RVNXtrgNl9Jo7fR0CnVyHbRIKbRXUX4KZS7Xzlr6UWTw49ZNnYTdOXdry924w817KOaDLsK4rX/InAZ2emLXhKjpb7keXB2GtruFp2JPHcaA7DBR2FKeoRsIqgUfvaIT06+sXmaQn6N8CbCNZMuEOQCdvnOXigSVT6o/no9q63s4zB7ip+NvuImsEIhVksrEdSLSPnU/Da/NDnHo1/xPeetCo+lokyLzpJXZRnX8bMVwJSqXmJhWiCagzQBWl5NvAXicbcGkSVa4RGZaWGzCo5vpn4fWUCaIJLswM8pZ9evkRkByx9kKO8lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RY2QFor1bpfw1XLvsGfcTLracdfzoN6ZXByEwvgvims=;
 b=OReKZotiFhP1pd0ilVRccktWFNgO0twlRgVIVAJy+XYGR2j8thcJ1udOI978HEIaLRrO0New4JYvOz0oV7aSeIJ1ZTyuVWn6ZG3YmVBkaoMamEByAs483AjHpfuehq0TJNZ5ALgKiQUwZcJDEcq6DjJX4d4o9Su5pl3CGFHFa88=
Received: from VI1PR04MB4094.eurprd04.prod.outlook.com (52.133.13.160) by
 VI1PR04MB3229.eurprd04.prod.outlook.com (10.170.227.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Thu, 22 Aug 2019 08:12:41 +0000
Received: from VI1PR04MB4094.eurprd04.prod.outlook.com
 ([fe80::c85e:7409:9270:3c3c]) by VI1PR04MB4094.eurprd04.prod.outlook.com
 ([fe80::c85e:7409:9270:3c3c%7]) with mapi id 15.20.2178.020; Thu, 22 Aug 2019
 08:12:41 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: Re: [PATCH] soc: imx: gpcv2: Print the correct error code
Thread-Topic: [PATCH] soc: imx: gpcv2: Print the correct error code
Thread-Index: AQHVWD4fgayU539kwkO1006xyo5ogKcG0j8A
Date:   Thu, 22 Aug 2019 08:12:41 +0000
Message-ID: <075dae8683762c2ea2bd8f7d8f539d79a0660f86.camel@nxp.com>
References: <ceab1bb4984d0a4f59a580cd9956c1fd6d6a78f3.1566405120.git.agx@sigxcpu.org>
In-Reply-To: <ceab1bb4984d0a4f59a580cd9956c1fd6d6a78f3.1566405120.git.agx@sigxcpu.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 95612c4f-4b47-42ea-aacf-08d726d880f2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR04MB3229;
x-ms-traffictypediagnostic: VI1PR04MB3229:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB3229E5503C366B531616D6F4F9A50@VI1PR04MB3229.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(396003)(39860400002)(376002)(366004)(199004)(189003)(86362001)(66574012)(2616005)(486006)(5660300002)(4744005)(44832011)(6436002)(316002)(446003)(118296001)(66066001)(11346002)(76176011)(476003)(14454004)(6116002)(3846002)(2201001)(186003)(6486002)(66476007)(229853002)(66946007)(26005)(66446008)(64756008)(50226002)(76116006)(102836004)(2501003)(6506007)(256004)(7416002)(99286004)(8676002)(7736002)(14444005)(8936002)(25786009)(6246003)(36756003)(6512007)(71200400001)(53936002)(2906002)(110136005)(71190400001)(305945005)(81156014)(478600001)(81166006)(66556008)(99106002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3229;H:VI1PR04MB4094.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 47ASpHnu2zqR+KUDEQgckaQBkSs0T6q3nidkWQye5/c/oApAZdHXKoXF5z0QZJHO66jsXs31WJ4n9YUyC99ouqxQuCE2z9yDmDOb9A7E2MoQ+8ZmxPF7RUJq50BYkNG4GHQCGCZxtXiCHMQTtDWxuiv5uYZbYaXUWHGiGORRPqHM3lOhUi75TqHXYERW6OMGjrrmtBDvzLM01ZsaSHad1NoACFngdfkxOKQdeYmQ82Jp1/zAGnmuKPb9RP8tOgO3P3q7EWmPa0tm+ow0a1fl20ODOEj1Vlh9VYzqvlE7d/qCls7pMxorM90mvdPrht+HYG03Wp6E1USK8LsHd0KQM+rPdoQALS1WnRUvZkgOo0e7uTGYuKYhrpadtdV3d3EFOjfHI6RKbEvPKlyQK5YwD2fgs3pOcwzknDXJMamAZ4o=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0D832D7F0A81D6458CAAFB73AD2A126E@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95612c4f-4b47-42ea-aacf-08d726d880f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 08:12:41.3323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nyd46aiXblzJQPxb9goG+kamhKuO/ts2HV9qP+2ZtF6GBakrX8H0ArYs7hxlfbfYDsfAVJHNgKNVf0eQWd1Sog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3229
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTA4LTIxIGF0IDE4OjMzICswMjAwLCBHdWlkbyBHw7xudGhlciB3cm90ZToN
Cj4gVGhlIGN1cnJlbnQgY29kZSBwcmludHMgJ3JldCcgKHRodXMgMCkgd2hpbGUgaXQgc2hvdWxk
IHVzZSAnZXJyJy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEd1aWRvIEfDvG50aGVyIDxhZ3hAc2ln
eGNwdS5vcmc+DQoNClJldmlld2VkLWJ5OiBEYW5pZWwgQmFsdXRhIDxkYW5pZWwuYmFsdXRhQG54
cC5jb20+DQoNCj4gLS0tDQo+ICBkcml2ZXJzL3NvYy9pbXgvZ3BjdjIuYyB8IDIgKy0NCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvc29jL2lteC9ncGN2Mi5jIGIvZHJpdmVycy9zb2MvaW14L2dwY3YyLmMN
Cj4gaW5kZXggMzFiOGQwMDJkODU1Li5iMGRmZmIwNmMwNWQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvc29jL2lteC9ncGN2Mi5jDQo+ICsrKyBiL2RyaXZlcnMvc29jL2lteC9ncGN2Mi5jDQo+IEBA
IC0xOTgsNyArMTk4LDcgQEAgc3RhdGljIGludCBpbXhfZ3BjX3B1X3BnY19zd19weHhfcmVxKHN0
cnVjdA0KPiBnZW5lcmljX3BtX2RvbWFpbiAqZ2VucGQsDQo+ICAJCWVyciA9IHJlZ3VsYXRvcl9k
aXNhYmxlKGRvbWFpbi0+cmVndWxhdG9yKTsNCj4gIAkJaWYgKGVycikNCj4gIAkJCWRldl9lcnIo
ZG9tYWluLT5kZXYsDQo+IC0JCQkJImZhaWxlZCB0byBkaXNhYmxlIHJlZ3VsYXRvcjogJWRcbiIs
DQo+IHJldCk7DQo+ICsJCQkJImZhaWxlZCB0byBkaXNhYmxlIHJlZ3VsYXRvcjogJWRcbiIsDQo+
IGVycik7DQo+ICAJCS8qIFByZXNlcnZlIGVhcmxpZXIgZXJyb3IgY29kZSAqLw0KPiAgCQlyZXQg
PSByZXQgPzogZXJyOw0KPiAgCX0NCg==
