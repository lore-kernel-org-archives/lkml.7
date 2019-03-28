Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE107C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B051206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BP45Z85P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbfC1QoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:44:01 -0400
Received: from mail-eopbgr10063.outbound.protection.outlook.com ([40.107.1.63]:62215
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725849AbfC1QoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:44:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/er7Q5Tt4a+6fEptQfsv2UImUz7V8125PRBD+T71Zo=;
 b=BP45Z85P0Bu9XEEDT0puWNKgqtenFG+RPOhHPCv4ERgilSlXzxGi1n9V+rzc+zcrcjJgWlHbA4DYvU4xkSAB8OW4rLBTAZdNgSBJQSTkIVUL6CsUcqHNUgE76ZWGY2rCM3qnKWhlgEDgX29pxa2txuyOQ1qoWuFOl0vN8jsXo0w=
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com (20.178.122.159) by
 VI1PR04MB6256.eurprd04.prod.outlook.com (20.179.25.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Thu, 28 Mar 2019 16:43:55 +0000
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::35aa:e13a:52ea:e5e6]) by VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::35aa:e13a:52ea:e5e6%4]) with mapi id 15.20.1730.019; Thu, 28 Mar 2019
 16:43:55 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        Anson Huang <anson.huang@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>, Ye Li <ye.li@nxp.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [RESEND v2] soc: imx: Add generic i.MX8 SoC driver
Thread-Topic: [RESEND v2] soc: imx: Add generic i.MX8 SoC driver
Thread-Index: AQHU4M8x51owZIDO7UOOFQ/teNRhv6YhST0A
Date:   Thu, 28 Mar 2019 16:43:55 +0000
Message-ID: <8df8afc4a50512d28247743e06f9ed30534da921.camel@nxp.com>
References: <1553273350-28852-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1553273350-28852-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0632b7dd-d8f2-4bd1-61b9-08d6b39c9184
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB6256;
x-ms-traffictypediagnostic: VI1PR04MB6256:
x-microsoft-antispam-prvs: <VI1PR04MB62564F6718FA1332D72A6CA0EE590@VI1PR04MB6256.eurprd04.prod.outlook.com>
x-forefront-prvs: 0990C54589
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(396003)(39860400002)(136003)(189003)(199004)(26005)(305945005)(2906002)(97736004)(6486002)(71200400001)(102836004)(5660300002)(4326008)(229853002)(6506007)(186003)(76176011)(50226002)(6436002)(99286004)(8936002)(71190400001)(86362001)(81166006)(8676002)(81156014)(14454004)(53936002)(316002)(14444005)(6116002)(256004)(118296001)(2501003)(68736007)(36756003)(6512007)(105586002)(478600001)(6246003)(66066001)(446003)(6636002)(486006)(25786009)(54906003)(11346002)(3846002)(2616005)(106356001)(476003)(110136005)(44832011)(7736002)(41533002)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6256;H:VI1PR04MB5533.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: I+/0N0weurVq2az0lupEX7VEljh/LZNpGyNJ7GMV0qTzfeWVrMPhdX3+rXNnORRaNYOHuZV/xe+5hCbeUukNdSpLxBPXbvYKLbYoidxpeoNtusUsI2AZ/OtPpOv/pNl6xlRhQnbowYZrAGNzxzVzeyLgclcesDGTHrVIjAl7GCtBqFDdUz7nUnAExR9EFugkUpGYaTLvXJHwtwuX4GAk07eHEChH+7OdEcuofLt1B1wrTPeZDN86yR5kL028eOpSmZkwJkMbORsK0SjARrClBF0nxBHk1e/aH+eHyoyEauzskHSRzaQy9EFJm4VQgxrJCVs5WoR5g4U6vINVtaFIOqZh2fWGSKL+Ktz02bmQOMsoM6l9tYr1lPGqqxV0i+35U+k2lizt5oG0NS0X3ssDtYOT+Q6hNI0NJows1RZjrf0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C5739006320D594FB0C385565864E8A8@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0632b7dd-d8f2-4bd1-61b9-08d6b39c9184
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2019 16:43:55.6535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE5LTAzLTIyIGF0IDE2OjQ5ICswMDAwLCBBYmVsIFZlc2Egd3JvdGU6DQo+IEFk
ZCBnZW5lcmljIGkuTVg4IFNvQyBkcml2ZXIgYWxvbmcgd2l0aCB0aGUgaS5NWDhNUSBTb0Mgc3Bl
Y2lmaWMgY29kZS4NCj4gRm9yIG5vdywgb25seSBpLk1YOE1RIHJldmlzaW9uIEIxIGlzIHN1cHBv
cnRlZC4gRm9yIGFueSBvdGhlciwgaS5NWDhNUQ0KPiByZXZpc2lvbiBpdCB3aWxsIHByaW50ICd1
bmtub3duJy4NCg0KPiArI2RlZmluZSBSRVZfQjEJCQkJMHgyMQ0KPiArDQo+ICsjZGVmaW5lIElN
WDhNUV9TV19JTkZPX0IxCQkweDQwDQo+ICsjZGVmaW5lIElNWDhNUV9TV19NQUdJQ19CMQkJMHhm
ZjAwNTVhYQ0KPiArDQo+ICsJbnAgPSBvZl9maW5kX2NvbXBhdGlibGVfbm9kZShOVUxMLCBOVUxM
LCAiZnNsLGlteDhtcS1vY290cCIpOysNCj4gKwlvY290cF9iYXNlID0gb2ZfaW9tYXAobnAsIDAp
Ow0KPiArDQo+ICsJbWFnaWMgPSByZWFkbF9yZWxheGVkKG9jb3RwX2Jhc2UgKyBJTVg4TVFfU1df
SU5GT19CMSk7DQo+ICsJaWYgKG1hZ2ljID09IElNWDhNUV9TV19NQUdJQ19CMSkNCj4gKwkJcmV2
ID0gUkVWX0IxOw0KDQpUaGlzIGlzIGJhc2VkIG9uIEFURiBjb2RlIGluIHZlbmRvciB0cmVlLCBi
dXQgc2hvdWxkbid0IHdlIGhhdmUgc29tZQ0Kc29ydCBvZiBleHBsYW5hdGlvbiBmb3IgdGhpcyAi
bWFnaWMiPw0KDQpMb29raW5nIGF0IHRoZSBPQ09UUCBkcml2ZXIgcmVnIDB4NDAgaXMgSU1YX09D
T1RQX0FERFJfREFUQTIgYW5kIGl0J3MNCnVzZWQgYXMgcGFydCBvZiBmdXNlIHdyaXRlcy4gQWNj
b3JkaW5nIHRvIHRoZSBkcml2ZXIgY29kZSA4bXEgaXMNCmNvbXBhdGlibGUgd2l0aCA3ZCBhbmQg
dGhpcyB3cml0ZSBwYXRoIGlzIGVuYWJsZWQgZm9yIGlteDhtcS1vY290cC4gDQoNCkxvb2tpbmcg
YXQgdGhlIE9DT1RQIG1hbnVhbCByZWcgMHg0MCBpcyBPQ09UUF9IV19PQ09UUF9SRUFEX0ZVU0Vf
REFUQQ0KYW5kIGl0J3MgbWVhbnQgdG8gYmUgdXNlZCB0b2dldGhlciB3aXRoIElNWF9PQ09UUF9B
RERSX0NUUkwgdG8gcmVhZA0KaW5mby4gTWF5YmUgbXkgbWFudWFsIChyZXYwIDIwMTgtMDEpIGlz
IGluY29ycmVjdD8NCg0KTG9va2luZyBhdCB0aGUgbWFudWFsIHRoaXMgd2lsbCByZXR1cm4gdGhl
IHZhbHVlIG9mIHRoZSBmdXNlIGxhc3QNCnJlcXVlc3RlZCB2aWEgSU1YX09DT1RQX0FERFJfQ1RS
TCBidXQgbm8gc3VjaCByZXF1ZXN0IGlzIG1hZGUgaW4gdGhpcw0KZHJpdmVyLiBTbyByZWFkaW5n
IGZyb20gT0NPVFAgMHg0MCBtaWdodCByZXR1cm4gYW4gdW5yZWxhdGVkIHZhbHVlPyENCg0KVGhl
IG1hbnVhbCBkb2VzIGRvY3VtZW50IHRoYXQgZnVzZSAweDQ0MFszOjBdIGlzIGEgInNpbGljb24g
cmV2aXNpb24NCm51bWJlciI7IG1heWJlIHdlIHNob3VsZCByZWFkIHRoYXQ/DQoNCi0tDQpSZWdh
cmRzLA0KTGVvbmFyZA0K
