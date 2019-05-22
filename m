Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10086C18E7D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 10:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D70C220868
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 10:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="P2N0wm44"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbfEVKP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 06:15:27 -0400
Received: from mail-eopbgr10047.outbound.protection.outlook.com ([40.107.1.47]:4611
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728406AbfEVKP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 06:15:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+dqo49IE6Hyu28xDXn3CEozEsEu8BstlMk1rq9bA+oI=;
 b=P2N0wm44ZPTPW6LaMtLGQ9q5KnxNcjDv7rnqMjBT5VYl+kMbSo6RUYly/tAUDVfSNkw1CoDdjYsnELIoGbhpCIZ7tbIDmTKHexfS8P+0oUV5SB43xYFA81KROwcywU+k48XDYHp3aopEO9b5+nKjGBFKTJ1BbAQY4hc+aJo3X38=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5092.eurprd04.prod.outlook.com (20.177.40.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.17; Wed, 22 May 2019 10:15:21 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::3173:24:d401:2378]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::3173:24:d401:2378%6]) with mapi id 15.20.1900.020; Wed, 22 May 2019
 10:15:21 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "sudeep.holla@arm.com" <sudeep.holla@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] firmware: arm_scmi: clock: set rate_discrete
Thread-Topic: [PATCH] firmware: arm_scmi: clock: set rate_discrete
Thread-Index: AQHVEIdDeGE/ZUAgK0KBQchFdwpL/g==
Date:   Wed, 22 May 2019 10:15:21 +0000
Message-ID: <20190522102912.1032-1-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.16.4
x-clientproxiedby: HK2PR0401CA0017.apcprd04.prod.outlook.com
 (2603:1096:202:2::27) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cbb28e2f-5a90-45e0-2eb9-08d6de9e65aa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5092;
x-ms-traffictypediagnostic: AM0PR04MB5092:
x-microsoft-antispam-prvs: <AM0PR04MB5092F5D17FDE59DF83AE711F88000@AM0PR04MB5092.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0045236D47
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(189003)(199004)(66066001)(53936002)(14454004)(4744005)(50226002)(6512007)(1076003)(25786009)(305945005)(54906003)(6436002)(5640700003)(4326008)(7736002)(52116002)(2501003)(498600001)(5660300002)(102836004)(99286004)(386003)(6506007)(2906002)(8936002)(8676002)(81166006)(81156014)(68736007)(3846002)(6116002)(26005)(186003)(86362001)(71200400001)(71190400001)(44832011)(2351001)(2616005)(73956011)(66946007)(66446008)(64756008)(66556008)(66476007)(476003)(486006)(6916009)(256004)(6486002)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5092;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: v06QT+psWAQRWPe/zlbAD4HZ8zPuELgiEr7kcTyrINL32g7lFOgxL50T5zQCjZoUb+oJP8UPYyJ8IEAyAItRCdQONkGc/ZldGMaNAi9kNzOHBux8GZ7jjqPn0TUDTDX++HGFKrkorLMK9dVlbXuB/Ak4zb6Trc6EAJ7B6+YQEeO04mXNlf+BrCHWwhd4/CXUHibOe0f/vxsKd1UQYkmk6jo7Yvqqad3RVICcCXgV4SdCyu1W7lBOqJc0YKmgZdjpVhrvl8Yqy9hYwSv8Nxsmc082LyiXygjxw6fUGCNy/pif/2m6SZTN9LQmdN2kXrXSzK2fTg/mQUB+pMKNldCYk2mQyp1aH2fIX4EubFetC0Dei3DXswPX/uK/fCy1Jl7Kd0KabxaLMJtTYlsqHzrR+Yd97Od5FIqkQieBOaYMOqc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbb28e2f-5a90-45e0-2eb9-08d6de9e65aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2019 10:15:21.7271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5092
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIHJhdGVfZGlzY3JldGUgbmVlZHMgdG8gYmUgYXNzaWduZWQgdG8gY2xrLT5yYXRlX2Rpc2Ny
ZXRlLA0KdGhlbiBzY21pX2Nsa19yb3VuZF9yYXRlIGNvdWxkIGdldCB0aGUgdmFsdWUuDQoNCkZp
eGVzOiA1ZjZjNjQzMGU5MDQgKCJmaXJtd2FyZTogYXJtX3NjbWk6IGFkZCBpbml0aWFsIHN1cHBv
cnQgZm9yIGNsb2NrIHByb3RvY29sIikNClNpZ25lZC1vZmYtYnk6IFBlbmcgRmFuIDxwZW5nLmZh
bkBueHAuY29tPg0KLS0tDQogZHJpdmVycy9maXJtd2FyZS9hcm1fc2NtaS9jbG9jay5jIHwgMiAr
Kw0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZmlybXdhcmUvYXJtX3NjbWkvY2xvY2suYyBiL2RyaXZlcnMvZmlybXdhcmUvYXJtX3NjbWkv
Y2xvY2suYw0KaW5kZXggMzBmYzA0ZTI4NDMxLi4wYTE5NGFmOTI0MzggMTAwNjQ0DQotLS0gYS9k
cml2ZXJzL2Zpcm13YXJlL2FybV9zY21pL2Nsb2NrLmMNCisrKyBiL2RyaXZlcnMvZmlybXdhcmUv
YXJtX3NjbWkvY2xvY2suYw0KQEAgLTE4NSw2ICsxODUsOCBAQCBzY21pX2Nsb2NrX2Rlc2NyaWJl
X3JhdGVzX2dldChjb25zdCBzdHJ1Y3Qgc2NtaV9oYW5kbGUgKmhhbmRsZSwgdTMyIGNsa19pZCwN
CiAJaWYgKHJhdGVfZGlzY3JldGUpDQogCQljbGstPmxpc3QubnVtX3JhdGVzID0gdG90X3JhdGVf
Y250Ow0KIA0KKwljbGstPnJhdGVfZGlzY3JldGUgPSByYXRlX2Rpc2NyZXRlOw0KKw0KIGVycjoN
CiAJc2NtaV94ZmVyX3B1dChoYW5kbGUsIHQpOw0KIAlyZXR1cm4gcmV0Ow0KLS0gDQoyLjE2LjQN
Cg0K
