Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65A5C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BDB12146F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QqSyu0VY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729762AbfC0NVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:21:10 -0400
Received: from mail-eopbgr20057.outbound.protection.outlook.com ([40.107.2.57]:29764
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725829AbfC0NVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:21:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4blFGcbg9F5HkNxQleqIKChFzEPTqs2mXu435AnAu0=;
 b=QqSyu0VYQMlJANBQmhNAe981HpGT6g7pEaV8fuhbHAbxjVuHT14LxCpnSjRGLkPIV1sTQOMs+iJpM+UQoqlCFmbtOWiOQw/vAk2qeenKVjDaQpMpYdfk82IZnLVJ7/iN8qc3qwsTfjfZqbXNg0g98s4uFgAnjhRWTEvwEuuKcfQ=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB6051.eurprd04.prod.outlook.com (20.179.35.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.15; Wed, 27 Mar 2019 13:21:05 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769%2]) with mapi id 15.20.1730.019; Wed, 27 Mar 2019
 13:21:05 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Aisheng Dong <aisheng.dong@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [RFC 0/7] cpuidle: Add poking mechanism to support non-IPI wakeup
Thread-Topic: [RFC 0/7] cpuidle: Add poking mechanism to support non-IPI
 wakeup
Thread-Index: AQHU5J/uL6RBBX3AA0GxPKCBIrMc4A==
Date:   Wed, 27 Mar 2019 13:21:05 +0000
Message-ID: <1553692845-20983-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0701CA0038.eurprd07.prod.outlook.com
 (2603:10a6:800:90::24) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [212.146.100.6]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a5bd5ea-8e37-42a4-f439-08d6b2b710e8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB6051;
x-ms-traffictypediagnostic: AM0PR04MB6051:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM0PR04MB60518A37EF1ED816E77C3A0DF6580@AM0PR04MB6051.eurprd04.prod.outlook.com>
x-forefront-prvs: 0989A7979C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(396003)(346002)(376002)(199004)(189003)(25786009)(14444005)(68736007)(4326008)(6436002)(5660300002)(6116002)(71200400001)(71190400001)(3846002)(256004)(8936002)(8676002)(6636002)(2501003)(66066001)(305945005)(2906002)(53936002)(81156014)(6512007)(7736002)(81166006)(7416002)(97736004)(6486002)(36756003)(54906003)(6306002)(44832011)(50226002)(486006)(106356001)(6506007)(386003)(186003)(110136005)(102836004)(966005)(14454004)(476003)(86362001)(99286004)(52116002)(478600001)(316002)(2616005)(26005)(105586002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6051;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xfNChds0TnW/8KAmZfUTn60p4tg5NdXtUJGJevvC5OAK2sF7p7MrbS6ZAA+bUeISCbMSZDkKd8+Lfhv5zXMizqYf9hZNIfIS+ktey9+cl/8YIeUr7xjKEGmklOPfKhkTxLdY3Bl1X/fXPUZZQJZtcVccmAfPRPFxgdGMKvwBr9lit8KODC6C4KFqSTNzYKKfuZX5YgjHYLhALfXsB4cvYGEkt+O+Ftp1uhCD7dv4/0+qq/2msuF6Zl2/tWkaLU4jMv+hZTG5GZd/BjiFNUUwUfYILmuDBTbpGmZ9qZnCfur4KIu8SoqZzymVSIZFrzmRWzhlvlTlyf00RLQ2bsBMLHohHG36ZPxZoLZLuM2pMbUcZPuioofR7WDYcLCiS+09WvVmk14qXfBlD8GSAHaPahswIX+/bi9++M9w0z3bcSA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a5bd5ea-8e37-42a4-f439-08d6b2b710e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2019 13:21:05.4897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6051
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This work is a workaround I'm looking into (more as a background task)
in order to add support for cpuidle on i.MX8MQ based platforms.

The main idea here is getting around the missing GIC wake_request signal
(due to integration design issue) by waking up a each individual core throu=
gh
some dedicated SW power-up bits inside the power controller (GPC) right bef=
ore
every IPI is requested for that each individual core.

This work is basically composed of four parts (in kernel):

 - the cpuidle core poking mechanism along with the related sched/irq_work =
calls
 - the cpuidle-arm ops addition in order to support poking, along with the
   'local-wakeup-poke' DT idle state knob
 - the psci and cpu_ops cpu_poke addition
 - the i.MX8MQ specific idle states in dts

There is also a change needed in TF-A which is available here:

  https://lists.trustedfirmware.org/pipermail/tf-a/2019-March/000009.html

Abel Vesa (7):
  sched: idle: Add sched get idle state helper
  cpuidle: Add cpu poke support
  smp: Poke the cores before requesting IPI
  psci: Add cpu_poke ops to support core poking
  cpuidle-arm: Add ops to support poke alonside enter
  cpuidle-arm: Add arm64 wake helper for cpu_poke op
  arm64: dts: imx8mq: Add cpu-sleep state with poke wake-up enabled

 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 20 ++++++++++++++++++
 arch/arm64/include/asm/cpu_ops.h          |  1 +
 arch/arm64/include/asm/cpuidle.h          |  6 ++++++
 arch/arm64/kernel/cpuidle.c               |  8 ++++++++
 arch/arm64/kernel/psci.c                  |  1 +
 drivers/cpuidle/cpuidle-arm.c             | 13 +++++++++++-
 drivers/cpuidle/cpuidle.c                 | 34 +++++++++++++++++++++++++++=
++++
 drivers/cpuidle/dt_idle_states.c          | 15 +++++++++-----
 drivers/cpuidle/dt_idle_states.h          | 10 +++++++++
 drivers/firmware/psci.c                   |  6 ++++++
 include/linux/cpuidle.h                   |  7 +++++++
 include/linux/psci.h                      |  1 +
 include/uapi/linux/psci.h                 |  2 ++
 kernel/irq_work.c                         | 19 ++++++++++++++---
 kernel/sched/core.c                       | 16 ++++++++++-----
 kernel/sched/idle.c                       | 11 ++++++++++
 kernel/smp.c                              | 10 ++++++++-
 kernel/time/tick-broadcast.c              |  4 ++++
 18 files changed, 169 insertions(+), 15 deletions(-)

--=20
2.7.4

