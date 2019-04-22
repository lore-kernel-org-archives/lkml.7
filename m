Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 941FAC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60C1D2075A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="vULHCCUa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbfDVTCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:02:32 -0400
Received: from mail-eopbgr140053.outbound.protection.outlook.com ([40.107.14.53]:10116
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726430AbfDVTCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:02:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bb82zrKmbm16xt5HL/+4W9f9Z7Emx9BUv630OvZDwmE=;
 b=vULHCCUaHSbUNGS6uA+BgfOwc1MgqLYF1cnPE3FePciN4dZRN1zmpnebCAV3pAsmwM7KqYA2rQv22dHE1zfuJN2SonOQbPJ4KiqfoBLo4Cg09ME5sIRHCJHYgohfkKmvdbaebX34HZceph5W41xQ9vzbdsN7oiXwsE9JZGk/KX4=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB2815.eurprd04.prod.outlook.com (10.172.255.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.14; Mon, 22 Apr 2019 19:02:27 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::c16b:662d:9299:6be6]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::c16b:662d:9299:6be6%6]) with mapi id 15.20.1813.017; Mon, 22 Apr 2019
 19:02:27 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "S.j. Wang" <shengjiu.wang@nxp.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "timur@kernel.org" <timur@kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v3 0/3] Add runtime PM for SAI digital audio interface
Thread-Topic: [PATCH v3 0/3] Add runtime PM for SAI digital audio interface
Thread-Index: AQHU+T3tSn5Uzcioa0qU6cJ3oZM02Q==
Date:   Mon, 22 Apr 2019 19:02:27 +0000
Message-ID: <20190422190213.30726-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR06CA0114.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::43) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a337b98-9158-46ca-7248-08d6c7550fc7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB2815;
x-ms-traffictypediagnostic: VI1PR0402MB2815:
x-microsoft-antispam-prvs: <VI1PR0402MB28156FE934B5EE4BD7E302C5F9220@VI1PR0402MB2815.eurprd04.prod.outlook.com>
x-forefront-prvs: 00159D1518
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(396003)(346002)(39860400002)(199004)(189003)(2906002)(6512007)(53936002)(7736002)(305945005)(316002)(386003)(6506007)(99286004)(102836004)(52116002)(186003)(8936002)(54906003)(50226002)(26005)(25786009)(4326008)(66066001)(8676002)(36756003)(6116002)(3846002)(6916009)(2501003)(81166006)(1730700003)(81156014)(68736007)(2351001)(5640700003)(14454004)(478600001)(71190400001)(64756008)(6486002)(66446008)(5660300002)(66556008)(97736004)(2616005)(476003)(44832011)(4744005)(256004)(14444005)(86362001)(66476007)(73956011)(66946007)(6436002)(7416002)(486006)(1076003)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2815;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VpYRi8hyCAvg+kWCAuOb7eln1kA0CpIIEEJoxwCVMa7RCAE2BXPhgn7BYZj/DF6uAtclJQ57+ozSgHVIeL4G12k4gH+tv4HyNOEaNBUUXiPeaHSasN2t7w/Szfuz+rTggRiYEIaIM1uyzP23aclNDL9Yd+tSzHSxKJGTt5lIbrmVgEEKLbxni6tfMncy+hO7+eYg7wZPBsTa7EUpIH3Okrn412Fj3riPHp9v/i6Nss1wt6QfCKcdAiawAbzGVYsMhORs0qMSkf1ZOgolk19bKodcshhROdQVSjF1FhsHiB4MH7bL82/mr1xy50hlZzcULNsxX75GnNYzUizqDWlGMh/djeTOkFt33r/foW4f1yCkce5CYWahKXPgSPjxmq7U3Pysz41+ZV8c/a6kLwi5HF4xs9qQrduzwpKdPK8hGWA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a337b98-9158-46ca-7248-08d6c7550fc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2019 19:02:27.5053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2815
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rmlyc3QgcGF0Y2ggZml4ZXMgYSBidWcgYnkgY29ycmVjdGx5IHNldHRpbmcgaXNfc2xhdmVfbW9k
ZSwgdGhlbg0Kc2Vjb25kIHBhdGNoIGFkZHMgc3VwcG9ydCBmb3IgcnVudGltZSBQTSBhbmQgZmlu
YWxseSAzcmQgcGF0Y2ggbW92ZXMNCmNsb2NrIGhhbmRsaW5nIGZyb20gc3RhcnR1cC9zaHR1ZG93
biBmdW5jdGlvbiB0byBydW50aW1lIFBNIGhhbmRsZXJzLg0KDQpDaGFuZ2VzIHNpbmNlIHYyOiAo
YWZ0ZXIgVmlvcmVsJ3MgY29tbWVudHMpDQoJLSBubyBuZWVkIHRvIGNoZWNrIGZvciBpc19zbGF2
ZV9tb2RlIHdoZW4gZW5hYmxpbmcvZGlzYWJsaW5nIHRoZSBjbG9ja3MNCgliZWNhdXNlIHNhaS0+
bWNsa19zdHJlYW1zIGlzIG9ubHkgc2V0IHdoZW4gU0FJIGlzIGluIG1hc3RlciBtb2RlLg0KDQpD
aGFuZ2VzIHNpbmNlIHYxOiAoYWZ0ZXIgTmljb2xpbidzIGNvbW1lbnRzKQ0KCS0gYWRkZWQgcGF0
Y2ggMQ0KCS0gYWRkZWQgZnNsX3NhaV9yZW1vdmUgaW4gb3JkZXIgdG8gY2FsbCBwbV9ydW50aW1l
X2Rpc2FibGUNCgktIG9ubHkgZGlzYWJsZS9lbmFibGUgbWNsayB3aGVuIFNBSSBpbiBtYXN0ZXIg
bW9kZS4NCg0KRGFuaWVsIEJhbHV0YSAoMik6DQogIEFTb0M6IGZzbF9zYWk6IFVwZGF0ZSBpc19z
bGF2ZV9tb2RlIHdpdGggY29ycmVjdCB2YWx1ZQ0KICBBU29DOiBmc2xfc2FpOiBBZGQgc3VwcG9y
dCBmb3IgcnVudGltZSBwbQ0KDQpTaGVuZ2ppdSBXYW5nICgxKToNCiAgQVNvQzogZnNsX3NhaTog
TW92ZSBjbG9jayBvcGVyYXRpb24gdG8gUE0gcnVudGltZQ0KDQogc291bmQvc29jL2ZzbC9mc2xf
c2FpLmMgfCA3OCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLQ0KIDEg
ZmlsZSBjaGFuZ2VkLCA2MyBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMoLSkNCg0KLS0gDQoy
LjE3LjENCg0K
