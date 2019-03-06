Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00812C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B230220657
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="vqRD5EV0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729903AbfCFKAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 05:00:55 -0500
Received: from mail-eopbgr80077.outbound.protection.outlook.com ([40.107.8.77]:12512
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726596AbfCFKAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 05:00:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRwi+XHfDWbGnUGK4yIZhb8mlzGDsMXYWVICkdb3gNk=;
 b=vqRD5EV0o+ZlCdgy3sJNGMXQsnnUqsVIXQCBF92W3TL0mwSf0Ye4MB2d7OypYsI4AESXSX4dCfaDlMrSxR6A7t7qQknLHNKKh7s2jmpn1S+Vx3JBXKc3lvQtHSyl3bumbDlVWcmK5QBa9EhQvw5QbTJExsVm0Yfa9pwbbVQoC6Q=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB5404.eurprd04.prod.outlook.com (20.178.104.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Wed, 6 Mar 2019 10:00:50 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::2083:76ce:c2b6:6a39]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::2083:76ce:c2b6:6a39%4]) with mapi id 15.20.1686.018; Wed, 6 Mar 2019
 10:00:50 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "wg@grandegger.com" <wg@grandegger.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH RESEND 0/5] can: flexcan: add CAN FD support on i.MX8QM
Thread-Topic: [PATCH RESEND 0/5] can: flexcan: add CAN FD support on i.MX8QM
Thread-Index: AQHU1AN6ot4SeAGOoEmRTppfBgH7KA==
Date:   Wed, 6 Mar 2019 10:00:50 +0000
Message-ID: <20190306095833.20922-1-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SG2PR02CA0106.apcprd02.prod.outlook.com
 (2603:1096:4:92::22) To DB7PR04MB4618.eurprd04.prod.outlook.com
 (2603:10a6:5:36::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e27938b-a999-480c-98b1-08d6a21a9ca2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB5404;
x-ms-traffictypediagnostic: DB7PR04MB5404:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB7PR04MB5404;23:e0fJNRtsf3tAHfLwM0e7XmX/2eqGUOd/v7cjnYf?=
 =?iso-8859-1?Q?jkwweSNa4xBDD/fi4Ln0E4+9E+l+fBqEgemhlUwhuhHdWhP+VZSgCvMpGA?=
 =?iso-8859-1?Q?K9/mKygNRWNw5cFJu53dOuWW3FooDV4bY+6YuoGkVROdfYKzGeb4Vn67WO?=
 =?iso-8859-1?Q?wli3JhnWPIpkhaP0jyd2Wdk46cXSqiJJIva3WCN7w+qLA6Pbe96URslO1U?=
 =?iso-8859-1?Q?7EYx9ie0+T5Q24bb/M5qx5A0Pl5g3q8L2oOXK1o1/HHFA8OtmOoh5E9UwS?=
 =?iso-8859-1?Q?W/bJ/8Jkq/OBw+AJgtVla5yVPz2bUYaJ2sDJxRsLWTwILE4wky/WAeKU+9?=
 =?iso-8859-1?Q?zE2mdfKPVSXdjAGFUkzjSc3PHMFl8m79HLQYw1fAma3YDs9vNePrMme8dT?=
 =?iso-8859-1?Q?6pv35Yr5eMRWHTq/xTSFXAI+4fWOe2ry1YliaKuP3ImXrQR3n15N5GRL8J?=
 =?iso-8859-1?Q?WgwDDOADwz7oi/bi8axh5AGlqUqn0ACdoeK3kHE/bHnyDvAiFatchJ0dX6?=
 =?iso-8859-1?Q?CV2MhTxAydNHxYJp8OBS+gh3rGq3g9Mf+RlCysQKGZ3CyN/9O/FKIGkbHt?=
 =?iso-8859-1?Q?k3iqQ35hrmdzFRchTlYTPHbJxJ6e7ispemjUucZ8iHpVqbdfj9oGuwRWtU?=
 =?iso-8859-1?Q?FqyAYew/kd7kqFTfUwwg/8tbXGq5Btv3Amb3eMg70rYVogIHQrPe5rB4A1?=
 =?iso-8859-1?Q?/Hdw2xhchDYjVk1p1Q+q9vsWTUxsnaQTTkvNrbD6dM84/jQoIFW9LnwPQj?=
 =?iso-8859-1?Q?1Qz+6+fkbYOmBOH2iuXQQMApQPE9B9DbWQ7O9X8JDwCU415q5+5jewxsmz?=
 =?iso-8859-1?Q?0I26zgtA5yKDiPndAa4/tjI9C9rMS9+Tqdri1+EVBoTwdQuXnYINw3AuSa?=
 =?iso-8859-1?Q?lkZBkQT6iS+IkliyDp3A4McIyhYWnfY08IGvHjbw9fdQG3uPKXcOZppNA8?=
 =?iso-8859-1?Q?nc7O3gXgeSAA2B9V4ewfOTEkyl/vJSkODuKBNpzfCBFlDYTbsfFJinyXt1?=
 =?iso-8859-1?Q?R6z1qIUJL/yloKrb0rXtKd3wOldrkMNUG8oGtEtdYb26aSJR+sIa0qqRln?=
 =?iso-8859-1?Q?gJceEsA/fEgjQ2acJdRZGqLWHX8hcL5PdD/yIq7EGYWqB8AqNoSSBPaxys?=
 =?iso-8859-1?Q?GJpSOXjhRYIDI9J44TDFs1xPjEeeljlHqOXXhdpUhweYSavlZLOhX9soIP?=
 =?iso-8859-1?Q?o2vdd1b4c58Ns1j88GQD6wY0QInd5uNDIOUWZ3yxNL0vLhkqPyZQvc=3D?=
x-microsoft-antispam-prvs: <DB7PR04MB5404751F74D60A129448457CE6730@DB7PR04MB5404.eurprd04.prod.outlook.com>
x-forefront-prvs: 0968D37274
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(39860400002)(366004)(396003)(199004)(189003)(54906003)(6436002)(99286004)(8936002)(26005)(305945005)(186003)(4326008)(36756003)(6506007)(102836004)(105586002)(2616005)(486006)(256004)(106356001)(386003)(2906002)(4744005)(71190400001)(25786009)(2501003)(1076003)(71200400001)(476003)(52116002)(81156014)(97736004)(81166006)(6116002)(3846002)(14454004)(68736007)(5660300002)(8676002)(6512007)(110136005)(316002)(53936002)(478600001)(50226002)(86362001)(66066001)(7736002)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5404;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: szIa7aZ6YS6A76u68jZoRToI0OLFn+vWA7/vQDW2ZTauZ90qtDueAUz7SVxTkf99DSAF82rQgxAGcxwFN5XQjlP/IRPC2zOHaChrni8wt2CP+ldapzVVl+y6bFJa41QTVcJlQZpVbtyZEqoMEeVBfMc0q8vK5oX5frYUamP6fNnVKcoyhXlMhiy0KoGSoALWoNQvxbjF5DdDtq0WPu/NZMFFkru655BA/J75NVFE35V4h5KeDVqBWF4ysAxYeipzAjaZO6roO3hE3dAKyYFmYb8d3eRIn3yMm0aDhn3OqotqGyycLud1VHkH9fiYjpzzNvpO1pNDzkUBTlN2XyerwobS7WZx6RLRDjfK+y6mrEP9bQDBdV0mnpa1KleMpSi7GHqehF8sbOyUR6EnhJ9ndfHyOkKT8y2nGOB3pWIP8tk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e27938b-a999-480c-98b1-08d6a21a9ca2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2019 10:00:50.5398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5404
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

This patch set integrates two patch sets which have been sent before.
[PATCH 0/3] can: flexcan: add imx8qm support
[PATCH 0/2] can: flexcan: add CANFD BRS and ISO FD support

I rebase it that will easy your patch review.

Thanks a lot.

Joakim Zhang.

Dong Aisheng (4):
  can: rx-offload: add CANFD support based on offload
  can: flexcan: add CAN FD mode support
  can: flexcan: add CANFD BRS support and improve bittiming setting
  can: flexcan: add imx8qm support

Joakim Zhang (1):
  can: flexcan: add ISO CAN FD feature support

 drivers/net/can/flexcan.c      | 226 ++++++++++++++++++++++++++++-----
 drivers/net/can/rx-offload.c   |  16 ++-
 include/linux/can/rx-offload.h |   4 +-
 3 files changed, 210 insertions(+), 36 deletions(-)

--=20
2.17.1

