Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D358CCA9EC0
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 01:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E14A217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 01:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JJCpI44R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbfJ2BV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 21:21:27 -0400
Received: from mail-eopbgr10060.outbound.protection.outlook.com ([40.107.1.60]:33398
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727778AbfJ2BV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 21:21:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVe+rpWVPDDjB9ARV8Ru5SdeA3+29izIqLcyqLHYJPlk/Vq0+BeBZODE2Dq7mbQmEfEGDm0kF9klqvp7C6xqNpjlunfro5zzI7/p6so3bo+sP2aGy2NL1uYp90jATBIpOZrwkU3CBCv/ss1mmMbAF+Qn1dNFEjrem/HarefwEIbTGrXDqli4kIWpb9kinD74T4MRW00EbC/AvULhdXhO3j4d5MM4rGe154HKugrMNONLSVxIj/0+WBDywetBcpVGjIq88FNpfYWxjoONbDlRZAFvhBs2+JJis5aJHums/U33wqx4n4sFQYL8fGSrAW/X8ft9xk7j263uHFY0PE4bLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTdi9a4VCwwTJCMtqqbvVkEawfKa6wqgmFd6dqPKk1U=;
 b=Ei0bbnsNT05O3ilkBDqvC3NKmg0MyoPQ/EWls+t/gXBYD/JqvnF/1ooHdwgH+15/sXa4dQk5/3jf2lvN4Gm4Hfv/2WR3EiytvgtZ9ssy9YnMI5HSTukDlzyglrHSvQCVsqd3JbudbNlhB8lfbfPgvtHws9Ey4U3C/TkWT2wlYQjC320ssTNW5JcdkW9WBpJeUgPTV403M2GIykVVGFGxp1rXDItPcJA3uyNm9VWVtnjRCKFBsxgiG4ynl7VcP7j2DKnZNFKkzKH76Bp8S48c+m8TKnyWwwTs4l74Z+kI/yFupEaZHMQEuqyYMJokbXRndbubGwi39ilyO0iZseztMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTdi9a4VCwwTJCMtqqbvVkEawfKa6wqgmFd6dqPKk1U=;
 b=JJCpI44RK3CA9JQFFC99uJtH4PGx+qZceNCvEjrh8HRqltNMpIjHIImOYTggMqM88OKJcIpVxUt/FB4bR2l/4eCGAsxb3l1n5qGK37Dt3Wu1Ij4kLF4x5an4bLozkhqReDU3woBTKv1hRAbIdDcXop4huZTaWqZ5ZLcxgd1woSc=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4291.eurprd04.prod.outlook.com (52.134.126.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Tue, 29 Oct 2019 01:21:24 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1%5]) with mapi id 15.20.2387.023; Tue, 29 Oct 2019
 01:21:24 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/2] regulator: fixed: add off-on-delay-us
Thread-Topic: [PATCH 0/2] regulator: fixed: add off-on-delay-us
Thread-Index: AQHVjfctVRLBMaHZfkaCofJjRp8c+Q==
Date:   Tue, 29 Oct 2019 01:21:23 +0000
Message-ID: <1572311875-22880-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0177.apcprd02.prod.outlook.com
 (2603:1096:201:21::13) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5754ac13-1226-493b-8004-08d75c0e4fd9
x-ms-traffictypediagnostic: AM0PR04MB4291:|AM0PR04MB4291:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB42916550DA0ABE48596DE60488610@AM0PR04MB4291.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(189003)(199004)(14454004)(478600001)(66946007)(8936002)(6512007)(6436002)(99286004)(7736002)(54906003)(316002)(52116002)(81156014)(8676002)(110136005)(305945005)(66066001)(186003)(81166006)(4326008)(50226002)(36756003)(6486002)(4744005)(25786009)(2201001)(86362001)(66446008)(66556008)(476003)(64756008)(5660300002)(44832011)(256004)(486006)(2616005)(3846002)(6116002)(2501003)(71200400001)(71190400001)(386003)(66476007)(6506007)(26005)(102836004)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4291;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T6kVeM2J24lrwd6Nal2U/e70tkLQsFKrkZUx93S86ndUbgIhW0WZW4mpm332mlHgWImalaso+dMCHBb6hPaMyrnpuKTLAxcRUQh3InocnYP3TzxUpZegHxuU2CNg/hgelbzMaTyEekcSdL+poV65TwNzr6EQ6Or/LFyaXGyM95ELO8HeWrxi7adz2eMI7SyiFZZG0F1beNXJV3WuIVNk9iRhspbMaKxEZJIFiABr06hJ5HRw0rx24351C//FKHdLyLDtRlu3eJ9mAw24e2ZnvNgIhX3/sQoCxxa179HlvYFf7U3kGeUaDqBI97+1LDRbU38GS733PLkDErNdJKKRQwOuuc+7MIdSDPh23IVQMrfRA9mzrggAKo1Yj0bmEG4RxYxKxkveoXTqWMWYLotXx/eNlmgj0usnoOBNA1n34QaYsFx7NYl07ZgJKZ0Y+oXQ
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5754ac13-1226-493b-8004-08d75c0e4fd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 01:21:23.9253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n1L4TPUM2YjbcdWf/Mh8+aJu9BFuJ68jeqAJKTHL7MeCDu81WQ2o/g+etzPgBSivdsy16Bu1q8bN7jSD19AM6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4291
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Depends on board design, the gpio controlled fixed regulator might
connect with a large capacitance. It needs time to be truly off when
disabling the regulator. If the delay is not enought, the voltage might
not drop to the expected value, such as 0, then the regulator might
have been always enabled. So introduce off-on-delay-us property and
add the support in fixed regualtor driver.

Peng Fan (2):
  dt-bindings: regulator: fixed: add off-on-delay-us property
  regulator: fixed: add off-on-delay

 Documentation/devicetree/bindings/regulator/fixed-regulator.yaml | 4 ++++
 drivers/regulator/fixed.c                                        | 2 ++
 include/linux/regulator/fixed.h                                  | 1 +
 3 files changed, 7 insertions(+)

--=20
2.16.4

