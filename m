Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBAFC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EA69208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="jbAHSy0h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387915AbfGaMi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:38:58 -0400
Received: from mail-eopbgr00137.outbound.protection.outlook.com ([40.107.0.137]:9952
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387832AbfGaMik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:38:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDxChlWW6BFhVfdxjOcdGifGShjkTHaV48sqvh5gXcjjqj9NqhOc3AGyOJ6IX8KfxLZwY5bilbqI0KGS1dk6pi8qjx9+ugJBK+qUXBA8ELW2F6o4iMVojCfHIoP/6ZOB7QxL+w9ic7TXuhusSmHZuf6e9XfOBQP0Fk9QVbiqCjdx6yaj3jcYHQl9BwZU8knaWq3s+bQ5lk4bRuDsKGAN2WF4hu5/gNX7kAoDL68FpBAmxPffVrhB+ou6VZwsR7g9wot5t/sw0u2QLAo+BDpr3p91Vtspki/OYm8ugYpZajRxD8Z9IxIfC9KWi/ONGEuX0qlhleyvHzxMhaMJChLkkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P44h+lwM6YvWHCN1T0PGsFLlCbfAiPM3WVMRkGXVB1I=;
 b=b1sn7V4uUaHvaQOUvl9DkyCxRRbvHpReyOyjnuhFIWFmPSBjfsba+D0Pi9wVy3/OFmYWOWRSGRF/TcYpiFOVRvRZno4xG1xR59hWsAvJy8aY28SbeQCwd1TS7GdpE+dgXWN/VLHt9bCuDhy/pfdqgdCHKnjLERFEa+4Z4eLgZirBSOZD1h5f+TNDrMvsGBiHUsJznhiBSbczxv7oD2mGGIOvhsrP5SLbpLZQKdERTJT7aaDhRvUxhcpFOm0cr9E6I3u6khp2FtdU90x37xHqjjmKUSg26T971NJIdvV7+zibCMnVo0ztbFkixqZpdETYs6CzqbmPk41vqYuvF5ymsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=toradex.com;dmarc=pass action=none
 header.from=toradex.com;dkim=pass header.d=toradex.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P44h+lwM6YvWHCN1T0PGsFLlCbfAiPM3WVMRkGXVB1I=;
 b=jbAHSy0hHLIT02wB1cazHtvksRYR9sFJRXpo8PMjAKDmKkPd7ULQnawnwuL2dpqXE3ZkvPp+6TGTPLb2oPfr9CeKC4nl1ZmjQTfGNTPP16XzJ3UkZnJCHyjNmIy3h8DDVE5JBR4nnncbrUhfUhq2xx3G3WS9Fhe59jdZEA/ph6c=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3615.eurprd05.prod.outlook.com (52.134.7.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Wed, 31 Jul 2019 12:38:35 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2115.005; Wed, 31 Jul 2019
 12:38:35 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?utf-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>,
        Fabio Estevam <festevam@gmail.com>
CC:     Philippe Schenker <philippe.schenker@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v2 20/20] ARM: dts: imx6ull-colibri: Add touchscreen used with
 Eval Board
Thread-Topic: [PATCH v2 20/20] ARM: dts: imx6ull-colibri: Add touchscreen used
 with Eval Board
Thread-Index: AQHVR5zeW+px2/law0qMCWO5IZ0sxg==
Date:   Wed, 31 Jul 2019 12:38:35 +0000
Message-ID: <20190731123750.25670-21-philippe.schenker@toradex.com>
References: <20190731123750.25670-1-philippe.schenker@toradex.com>
In-Reply-To: <20190731123750.25670-1-philippe.schenker@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR02CA0012.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::25) To VI1PR0502MB3965.eurprd05.prod.outlook.com
 (2603:10a6:803:23::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.22.0
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1da1691c-076b-4c12-d95d-08d715b40108
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB3615;
x-ms-traffictypediagnostic: VI1PR0502MB3615:
x-microsoft-antispam-prvs: <VI1PR0502MB36154DF6B2CE34D4C74D9DB6F4DF0@VI1PR0502MB3615.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39850400004)(376002)(136003)(396003)(366004)(346002)(199004)(189003)(66946007)(52116002)(66446008)(64756008)(66556008)(66476007)(76176011)(99286004)(53936002)(6512007)(6436002)(5660300002)(4326008)(7416002)(66066001)(6486002)(25786009)(478600001)(14454004)(7736002)(305945005)(71190400001)(71200400001)(3846002)(6116002)(36756003)(2501003)(68736007)(2906002)(2201001)(44832011)(486006)(476003)(86362001)(446003)(2616005)(14444005)(11346002)(256004)(186003)(81166006)(81156014)(26005)(102836004)(50226002)(8936002)(8676002)(6506007)(386003)(316002)(54906003)(110136005)(1076003)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3615;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fK26W+dFd4/zXfY8obejS04Kk99pK+wmDiOnIZAR4Un7ueLqd2vKwzx6732w2/9+Xml1Dsr6kHrE/VzogtRq8DyUtVXGBFtP+E3oMWyL4wFSLc4aZ3xrsTCTtcfnBy9Rse/rRb9OPQNwdhtfmyEJCDVU3+yOm8T34cFwMPrADIeM/qzO2HKAau+gb1AysrU6D73UPXwYS30h8uOvfFcyohuP1pnLvkrxGlfYpcRcaDEK8RZCsVLubc+BaqXTOGchN+iJ71VlONXDhEZNAL0u0/YxREMtxHBK3WYDFrxEzLqOLjoK+VyJHU8N43XYA+9P2k691K9i4YmHdGx39k+cG97V3QKUUHMzeUY8gmBCBXsmOE633kGHwA00lXXahA9dc6WYh/zJtITdjhOzOHfyBniy0wVJyuS+oaFwlCG6fRw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D7D52C126B4AFE41A30C7E92EA22457B@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1da1691c-076b-4c12-d95d-08d715b40108
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 12:38:35.3527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: philippe.schenker@toradex.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3615
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBhZGRzIHRoZSBjb21tb24gdG91Y2hzY3JlZW4gdGhhdCBpcyB1c2VkIHdpdGggVG9yYWRl
eCdzDQpFdmFsIEJvYXJkcy4NCg0KU2lnbmVkLW9mZi1ieTogUGhpbGlwcGUgU2NoZW5rZXIgPHBo
aWxpcHBlLnNjaGVua2VyQHRvcmFkZXguY29tPg0KDQotLS0NCg0KQ2hhbmdlcyBpbiB2MjoNCi0g
UmVtb3ZlZCBmMDcxMGEsIHRoYXQgaXMgZG93bnN0cmVhbSBvbmx5DQotIENoYW5nZWQgdG8gZ2Vu
ZXJpYyBub2RlIG5hbWUNCi0gQmV0dGVyIGNvbW1lbnQNCg0KIC4uLi9hcm0vYm9vdC9kdHMvaW14
NnVsbC1jb2xpYnJpLWV2YWwtdjMuZHRzaSB8IDI0ICsrKysrKysrKysrKysrKysrKysNCiAxIGZp
bGUgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9v
dC9kdHMvaW14NnVsbC1jb2xpYnJpLWV2YWwtdjMuZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lt
eDZ1bGwtY29saWJyaS1ldmFsLXYzLmR0c2kNCmluZGV4IGQzYzQ4MDlmMTQwZS4uNzhlNzRiZmVj
YTFiIDEwMDY0NA0KLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnVsbC1jb2xpYnJpLWV2YWwt
djMuZHRzaQ0KKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnVsbC1jb2xpYnJpLWV2YWwtdjMu
ZHRzaQ0KQEAgLTExMiw2ICsxMTIsMjEgQEANCiAmaTJjMSB7DQogCXN0YXR1cyA9ICJva2F5IjsN
CiANCisJLyoNCisJICogVG91Y2hzY3JlZW4gaXMgdXNpbmcgU09ESU1NIDI4LzMwLCBhbHNvIHVz
ZWQgZm9yIFBXTTxCPiwgUFdNPEM+LA0KKwkgKiBha2EgcHdtMiwgcHdtMy4gc28gaWYgeW91IGVu
YWJsZSB0b3VjaHNjcmVlbiwgZGlzYWJsZSB0aGUgcHdtcw0KKwkgKi8NCisJdG91Y2hzY3JlZW5A
NGEgew0KKwkJY29tcGF0aWJsZSA9ICJhdG1lbCxtYXh0b3VjaCI7DQorCQlwaW5jdHJsLW5hbWVz
ID0gImRlZmF1bHQiOw0KKwkJcGluY3RybC0wID0gPCZwaW5jdHJsX2dwaW90b3VjaD47DQorCQly
ZWcgPSA8MHg0YT47DQorCQlpbnRlcnJ1cHQtcGFyZW50ID0gPCZncGlvND47DQorCQlpbnRlcnJ1
cHRzID0gPDE2IElSUV9UWVBFX0VER0VfRkFMTElORz47CS8qIFNPRElNTSAyOCAqLw0KKwkJcmVz
ZXQtZ3Bpb3MgPSA8JmdwaW8yIDUgR1BJT19BQ1RJVkVfSElHSD47CS8qIFNPRElNTSAzMCAqLw0K
KwkJc3RhdHVzID0gImRpc2FibGVkIjsNCisJfTsNCisNCiAJLyogTTQxVDBNNiByZWFsIHRpbWUg
Y2xvY2sgb24gY2FycmllciBib2FyZCAqLw0KIAltNDF0MG02OiBydGNANjggew0KIAkJY29tcGF0
aWJsZSA9ICJzdCxtNDF0MCI7DQpAQCAtMTg4LDMgKzIwMywxMiBAQA0KIAlzZC11aHMtc2RyMTA0
Ow0KIAlzdGF0dXMgPSAib2theSI7DQogfTsNCisNCismaW9tdXhjIHsNCisJcGluY3RybF9ncGlv
dG91Y2g6IHRvdWNoZ3Bpb3Mgew0KKwkJZnNsLHBpbnMgPSA8DQorCQkJTVg2VUxfUEFEX05BTkRf
RFFTX19HUElPNF9JTzE2CQkweDc0DQorCQkJTVg2VUxfUEFEX0VORVQxX1RYX0VOX19HUElPMl9J
TzA1CTB4MTQNCisJCT47DQorCX07DQorfTsNCi0tIA0KMi4yMi4wDQoNCg==
