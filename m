Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BD5C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C68DE206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MIQdTRoH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbfDWNvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:51:46 -0400
Received: from mail-eopbgr140079.outbound.protection.outlook.com ([40.107.14.79]:50145
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728142AbfDWNvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 09:51:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6sqrqxqwTiZ4tbyJIcnvRvAcZq7pQfaNREQf2oUNJU=;
 b=MIQdTRoH0tSR3RI0g6AzqeC7Y6ok79dSs0a/DbZMMQI4e5SVH7ewrNbIBGttwNr2CokiLkzm91ZgApaeQXH8yJTPdevs2tcJwm1eVcrYdqsx37Y1eF1fRupS9AiAPfxI1q1qbelifBYsWvOV7u5aR/g8NZ/7topoXDbX6YIge8s=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB5854.eurprd04.prod.outlook.com (20.178.204.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Tue, 23 Apr 2019 13:51:40 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525%4]) with mapi id 15.20.1813.017; Tue, 23 Apr 2019
 13:51:40 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "sean.nyekjaer@prevas.dk" <sean.nyekjaer@prevas.dk>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: [PATCH v1 13/15] ARM: dts: imx6ul: add dma support on ecspi
Thread-Topic: [PATCH v1 13/15] ARM: dts: imx6ul: add dma support on ecspi
Thread-Index: AQHU+dutugEMiGj9xk+jZrzaDWBFJA==
Date:   Tue, 23 Apr 2019 13:51:40 +0000
Message-ID: <1556027045-5269-14-git-send-email-yibin.gong@nxp.com>
References: <1556027045-5269-1-git-send-email-yibin.gong@nxp.com>
In-Reply-To: <1556027045-5269-1-git-send-email-yibin.gong@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0044.apcprd04.prod.outlook.com
 (2603:1096:202:14::12) To VI1PR04MB4543.eurprd04.prod.outlook.com
 (2603:10a6:803:6d::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 99fb5b8f-3c72-4483-d44f-08d6c7f2cf99
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5854;
x-ms-traffictypediagnostic: VI1PR04MB5854:
x-microsoft-antispam-prvs: <VI1PR04MB5854CB53256A9C61D11C879289230@VI1PR04MB5854.eurprd04.prod.outlook.com>
x-forefront-prvs: 0016DEFF96
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(376002)(346002)(39860400002)(189003)(199004)(25786009)(2201001)(71200400001)(86362001)(54906003)(110136005)(52116002)(6116002)(3846002)(2906002)(71190400001)(76176011)(14454004)(73956011)(2616005)(5660300002)(446003)(476003)(68736007)(6436002)(97736004)(11346002)(99286004)(478600001)(316002)(486006)(2501003)(66446008)(66476007)(102836004)(66066001)(26005)(6486002)(66556008)(386003)(53936002)(6506007)(50226002)(4326008)(186003)(6512007)(7736002)(81166006)(81156014)(305945005)(8676002)(8936002)(14444005)(256004)(36756003)(66946007)(7416002)(64756008)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5854;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: p4KdCx2SgQLZHSD0tVTouoyFYQ44J6M5nFm473/MyQ9F3klOWBGo7N4TPOpWUKjtEzIjoH8HfnAUs5agxwzJG6kxXKeKGgj7aIkA9ZWx9S+hLoDQlI4DCyh3awNiBeBkl7ttHhPT15DZeTTkocuVppeq9iXVz0wnyIiZJv2J+0eML6owmjdF9plQWSaxmMma6/Dmw2/U6xmw27axHWwPq2vKG5lOv/Z7cXl5STIilVaia8/FQeK3K9Alfyim2NUgB5vguWxpAeDSNG8A9xNegvbmS76KleXmYbBwmkQrSdkWVJknod6VfWJXdJi1W0eLbWRkvCA0qUQCQc/MzsIvX5gTiyFUNw1JNNqD/lRB+NhMFJ4dnuyMca/b5+Hxto4EHguQ9FfcgV8oQz7aVjEl+JmpErK+jOS16Dzh5HjJdgY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99fb5b8f-3c72-4483-d44f-08d6c7f2cf99
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2019 13:51:40.2504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5854
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGRtYSBzdXBwb3J0IG9uIGVjc3BpLg0KDQpTaWduZWQtb2ZmLWJ5OiBSb2JpbiBHb25nIDx5
aWJpbi5nb25nQG54cC5jb20+DQotLS0NCiBhcmNoL2FybS9ib290L2R0cy9pbXg2dWwuZHRzaSB8
IDggKysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1n
aXQgYS9hcmNoL2FybS9ib290L2R0cy9pbXg2dWwuZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lt
eDZ1bC5kdHNpDQppbmRleCBiYmYwMTBjLi44ODBiOWVlIDEwMDY0NA0KLS0tIGEvYXJjaC9hcm0v
Ym9vdC9kdHMvaW14NnVsLmR0c2kNCisrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1bC5kdHNp
DQpAQCAtMjI2LDYgKzIyNiw4IEBADQogCQkJCQljbG9ja3MgPSA8JmNsa3MgSU1YNlVMX0NMS19F
Q1NQSTE+LA0KIAkJCQkJCSA8JmNsa3MgSU1YNlVMX0NMS19FQ1NQSTE+Ow0KIAkJCQkJY2xvY2st
bmFtZXMgPSAiaXBnIiwgInBlciI7DQorCQkJCQlkbWFzID0gPCZzZG1hIDMgNyAxPiwgPCZzZG1h
IDQgNyAyPjsNCisJCQkJCWRtYS1uYW1lcyA9ICJyeCIsICJ0eCI7DQogCQkJCQlzdGF0dXMgPSAi
ZGlzYWJsZWQiOw0KIAkJCQl9Ow0KIA0KQEAgLTIzOCw2ICsyNDAsOCBAQA0KIAkJCQkJY2xvY2tz
ID0gPCZjbGtzIElNWDZVTF9DTEtfRUNTUEkyPiwNCiAJCQkJCQkgPCZjbGtzIElNWDZVTF9DTEtf
RUNTUEkyPjsNCiAJCQkJCWNsb2NrLW5hbWVzID0gImlwZyIsICJwZXIiOw0KKwkJCQkJZG1hcyA9
IDwmc2RtYSA1IDcgMT4sIDwmc2RtYSA2IDcgMj47DQorCQkJCQlkbWEtbmFtZXMgPSAicngiLCAi
dHgiOw0KIAkJCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCiAJCQkJfTsNCiANCkBAIC0yNTAsNiAr
MjU0LDggQEANCiAJCQkJCWNsb2NrcyA9IDwmY2xrcyBJTVg2VUxfQ0xLX0VDU1BJMz4sDQogCQkJ
CQkJIDwmY2xrcyBJTVg2VUxfQ0xLX0VDU1BJMz47DQogCQkJCQljbG9jay1uYW1lcyA9ICJpcGci
LCAicGVyIjsNCisJCQkJCWRtYXMgPSA8JnNkbWEgNyA3IDE+LCA8JnNkbWEgOCA3IDI+Ow0KKwkJ
CQkJZG1hLW5hbWVzID0gInJ4IiwgInR4IjsNCiAJCQkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQog
CQkJCX07DQogDQpAQCAtMjYyLDYgKzI2OCw4IEBADQogCQkJCQljbG9ja3MgPSA8JmNsa3MgSU1Y
NlVMX0NMS19FQ1NQSTQ+LA0KIAkJCQkJCSA8JmNsa3MgSU1YNlVMX0NMS19FQ1NQSTQ+Ow0KIAkJ
CQkJY2xvY2stbmFtZXMgPSAiaXBnIiwgInBlciI7DQorCQkJCQlkbWFzID0gPCZzZG1hIDkgNyAx
PiwgPCZzZG1hIDEwIDcgMj47DQorCQkJCQlkbWEtbmFtZXMgPSAicngiLCAidHgiOw0KIAkJCQkJ
c3RhdHVzID0gImRpc2FibGVkIjsNCiAJCQkJfTsNCiANCi0tIA0KMi43LjQNCg0K
