Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B02AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 05:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53BA320989
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 05:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dpKP6y9D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbfCSFRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 01:17:22 -0400
Received: from mail-eopbgr00043.outbound.protection.outlook.com ([40.107.0.43]:47940
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725287AbfCSFRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 01:17:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2P5EglqkUu908KeIfFfw6tVE4HjJerrrs1Wg3BxpnaY=;
 b=dpKP6y9Dk1SeF4u7AVHkCWHypwpTzsJmg2xY+h1QSh6NO4qroRClcG24haLuppyXkdlTLQOGofHEtWTlSGKoS9Cfo4ub0x2ZUdexkAmE4PNmNMz6PPmkY4kvva/O2kkQL/2Yt2FflyW0Gu4SDsYrOT91sSPQzjZeYOSix5kKt1U=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB4796.eurprd04.prod.outlook.com (20.176.233.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Tue, 19 Mar 2019 05:17:16 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::39a4:c735:c8ef:afd5]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::39a4:c735:c8ef:afd5%4]) with mapi id 15.20.1709.015; Tue, 19 Mar 2019
 05:17:16 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "wg@grandegger.com" <wg@grandegger.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH V2 0/5] can: flexcan: add CAN FD support on i.MX8QM
Thread-Topic: [PATCH V2 0/5] can: flexcan: add CAN FD support on i.MX8QM
Thread-Index: AQHU3hME3SOkYFf4ZU2Iven+aBmRlA==
Date:   Tue, 19 Mar 2019 05:17:16 +0000
Message-ID: <20190319051512.14950-1-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SG2PR04CA0137.apcprd04.prod.outlook.com
 (2603:1096:3:16::21) To DB7PR04MB4618.eurprd04.prod.outlook.com
 (2603:10a6:5:36::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 300878d2-d546-4975-6aa2-08d6ac2a26a3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4796;
x-ms-traffictypediagnostic: DB7PR04MB4796:
x-microsoft-antispam-prvs: <DB7PR04MB47962457CB3A7D4442D614DCE6400@DB7PR04MB4796.eurprd04.prod.outlook.com>
x-forefront-prvs: 0981815F2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(366004)(346002)(39860400002)(189003)(199004)(5660300002)(1076003)(7736002)(52116002)(53936002)(478600001)(6512007)(14454004)(305945005)(4326008)(71190400001)(99286004)(6506007)(106356001)(102836004)(105586002)(26005)(2501003)(8936002)(97736004)(71200400001)(25786009)(50226002)(86362001)(66066001)(81166006)(476003)(81156014)(186003)(486006)(6116002)(256004)(68736007)(8676002)(386003)(6436002)(2616005)(3846002)(6486002)(110136005)(2906002)(54906003)(316002)(4744005)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4796;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eZLE+FIfnCqJD3M+vZZQ/nvXlW69VTqiqXCaem/tWg0OlZX1xgKkdspsBlqnRokVaAEIs1RcTsNuE1ncS5vuO2CfRZsv2tNSZadB5PmMcLm4vXGQWOaE8g9u48FUTd5IvS2ogheQBArGNaa4f+zJZtGpuKNICilDPso0t8R9otZdWpWG2+Gm1Qxk0Rm1vhwfz8QMrMkzR757avaVkc0CObHsuGwHSIgBSU0LXzVd6GymDaUtCsZyPy1QG75Co40l1QMvD5p3FN4GmcJ1qrHtaYlrxsYCei+Eoo2pLrRT2lENpmDDulHRgEkZDePhavPHusxIUYdpK5KyODU/tbn3Wbrnx84NYAv0Q00///3pQN2wY0Hq1+XCCr5zgtP09FhgI9A1ROe7TFjXkFp4DWncOnN2Yf3ejx8x7RF4nLGEs1c=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 300878d2-d546-4975-6aa2-08d6ac2a26a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2019 05:17:16.0814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4796
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set intends to add fd mode support on i.MX8QM platform.

Dong Aisheng (4):
  can: rx-offload: add CANFD support based on offload
  can: flexcan: add CAN FD mode support
  can: flexcan: add CANFD BRS support and improve bittiming setting
  can: flexcan: add imx8qm support

Joakim Zhang (1):
  can: flexcan: add ISO CAN FD feature support

 drivers/net/can/flexcan.c      | 222 ++++++++++++++++++++++++++++-----
 drivers/net/can/rx-offload.c   |  16 ++-
 include/linux/can/rx-offload.h |   4 +-
 3 files changed, 206 insertions(+), 36 deletions(-)

--=20
2.17.1

