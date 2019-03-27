Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02D7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6538921734
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NsUquUgN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbfC0NVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:21:14 -0400
Received: from mail-eopbgr20057.outbound.protection.outlook.com ([40.107.2.57]:29764
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728790AbfC0NVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:21:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LR48d2g1vkoK40i8uWTgFtA7Op5aZtshDE+l5myETRI=;
 b=NsUquUgNsTpO92i0D91klAb/ZbWbonUzt88kmQTOFrj6Ivummgv+OQ991xlu8cfXfb6kkeTvHrOUs8XhiU/ffe45YK5liMoi/ENj6bShG9YsBc0XyHbZgo80Jt/33mI8/F0xuYlU/OKxX+Sdk2YpcyXGnPIMaLP5S54ld3Hz3IA=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB6051.eurprd04.prod.outlook.com (20.179.35.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.15; Wed, 27 Mar 2019 13:21:08 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769%2]) with mapi id 15.20.1730.019; Wed, 27 Mar 2019
 13:21:08 +0000
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
Subject: [RFC 1/7] sched: idle: Add sched get idle state helper
Thread-Topic: [RFC 1/7] sched: idle: Add sched get idle state helper
Thread-Index: AQHU5J/wYerhjHZf+0GO74u+rDGu6Q==
Date:   Wed, 27 Mar 2019 13:21:07 +0000
Message-ID: <1553692845-20983-2-git-send-email-abel.vesa@nxp.com>
References: <1553692845-20983-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1553692845-20983-1-git-send-email-abel.vesa@nxp.com>
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
x-ms-office365-filtering-correlation-id: b86b3313-a923-40fb-4cc8-08d6b2b711ed
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB6051;
x-ms-traffictypediagnostic: AM0PR04MB6051:
x-microsoft-antispam-prvs: <AM0PR04MB6051FC6CCFC425CAE281747AF6580@AM0PR04MB6051.eurprd04.prod.outlook.com>
x-forefront-prvs: 0989A7979C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(396003)(346002)(376002)(199004)(189003)(25786009)(14444005)(68736007)(4326008)(6436002)(5660300002)(6116002)(71200400001)(71190400001)(3846002)(256004)(8936002)(8676002)(6636002)(2501003)(66066001)(305945005)(2906002)(53936002)(81156014)(6512007)(7736002)(81166006)(7416002)(97736004)(6486002)(36756003)(54906003)(44832011)(50226002)(486006)(106356001)(6506007)(386003)(186003)(110136005)(102836004)(446003)(14454004)(476003)(86362001)(99286004)(11346002)(52116002)(478600001)(316002)(2616005)(26005)(105586002)(76176011)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6051;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vmOOorQZXAGQNM5Depghx6Zq76DGExyX1Hv/jWWvLTso5nqYjGo/4ee2wHaBhccJRjZEryZyxd+Kx4tAerSosZjlLqQGoAkDNymzsNBogrl2Swj1BoCxc50jA3BF/Gx2/eqQ8nuSEjD+DwETAtX/SNY0vVHmeoaeFBM/ecUw1G10zSU/9BrOCXKp7ZqxdrwJ+orprLAJTnQ/zabmOQz15Tw8WL8aNyAEba4vGuK3EGWehHG/vgaJ3YU0GEL3FK1DTLzdOc43Yt6oOPUIirKygx/CCNrv7IWDy3qLGUUTBSdRLdfUgZDAQdl7zZSXfkKDAox9MGBZWDbWeefoqx28T3Dr+FyIAnmIB/I+L1TWVm5V2zp9px0Ur7ygWwcs7+8/A/JIejKKXrmOoCvtuJwvXYloaRWnezR0ZQIQKPycVFc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b86b3313-a923-40fb-4cc8-08d6b2b711ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2019 13:21:08.2226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6051
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This helper is useful in order to get the idle state of a specific cpu.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 include/linux/cpuidle.h |  1 +
 kernel/sched/idle.c     | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 3b39472..88a9119 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -211,6 +211,7 @@ static inline void cpuidle_use_deepest_state(bool enabl=
e)
=20
 /* kernel/sched/idle.c */
 extern void sched_idle_set_state(struct cpuidle_state *idle_state);
+extern struct cpuidle_state *sched_idle_get_state(int cpu);
 extern void default_idle_call(void);
=20
 #ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index f5516ba..484825d 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -21,6 +21,17 @@ void sched_idle_set_state(struct cpuidle_state *idle_sta=
te)
 	idle_set_state(this_rq(), idle_state);
 }
=20
+/**
+ * sched_idle_get_state - Get idle state for the specified CPU.
+ * @index: CPU index.
+ */
+
+struct cpuidle_state *sched_idle_get_state(int cpu)
+{
+	return idle_get_state(cpu_rq(cpu));
+}
+
+
 static int __read_mostly cpu_idle_force_poll;
=20
 void cpu_idle_poll_ctrl(bool enable)
--=20
2.7.4

