Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2833BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E12D021738
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="M3GiV2oj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730457AbfC0NVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:21:31 -0400
Received: from mail-eopbgr150048.outbound.protection.outlook.com ([40.107.15.48]:27108
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730156AbfC0NVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:21:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ro9O727XiFJ7pYrZbuEZxzdJtDA1YxkME8Y1TiR0iaw=;
 b=M3GiV2oj+EL1BHV0eEPpZnWCbbbmdv+Akvu7L+Ii/psActR/uNRH3MEnwR2g3mpeVO8YIxz29Qq9KoUKgOIR3CHhKNcLQYxvNLdLEDhV4gpUQ1bgNT6+rY6ox9sJBo30eCIgrx4DQn9g9zr3iNu9xa2Q+UPVmcSwKj8kScIQvDo=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB5907.eurprd04.prod.outlook.com (20.178.202.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Wed, 27 Mar 2019 13:21:15 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769%2]) with mapi id 15.20.1730.019; Wed, 27 Mar 2019
 13:21:15 +0000
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
Subject: [RFC 5/7] cpuidle-arm: Add ops to support poke alonside enter
Thread-Topic: [RFC 5/7] cpuidle-arm: Add ops to support poke alonside enter
Thread-Index: AQHU5J/0oZvb5mpe4UOY+zfz3ulcdA==
Date:   Wed, 27 Mar 2019 13:21:14 +0000
Message-ID: <1553692845-20983-6-git-send-email-abel.vesa@nxp.com>
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
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31761e12-411b-4442-33d6-08d6b2b71690
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5907;
x-ms-traffictypediagnostic: AM0PR04MB5907:
x-microsoft-antispam-prvs: <AM0PR04MB59074CB5CE1833A74383AFCEF6580@AM0PR04MB5907.eurprd04.prod.outlook.com>
x-forefront-prvs: 0989A7979C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(376002)(346002)(39860400002)(396003)(199004)(189003)(25786009)(2906002)(26005)(386003)(54906003)(8676002)(68736007)(102836004)(6512007)(71200400001)(7416002)(71190400001)(446003)(5660300002)(8936002)(50226002)(4326008)(81166006)(2616005)(476003)(81156014)(44832011)(97736004)(11346002)(6116002)(3846002)(36756003)(105586002)(86362001)(106356001)(2501003)(6486002)(76176011)(6636002)(14454004)(478600001)(6506007)(316002)(52116002)(7736002)(186003)(53936002)(110136005)(6346003)(66066001)(99286004)(14444005)(256004)(486006)(6436002)(305945005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5907;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ms6hoU/zq6ahFQ6UiKW2lhRZHR966xH3XgXwf7jpcFj9HKf/1Q1TBxaipvjwvKM3j7ZRi+ifAf7KVB8olztyQW7L45ryhEO1jswLnfac5v3Ok4mbZk0WYX6wvgh+suAjXyPQKuZ+18EYwV/wZ/P4xVyNleN8DzMIxmgCqILiq2KoXV2LkICSTjc7QjNETAWteowAExlNgyI0WF61VDGOdSQzkfLyAYn0HBpP7gsJ+bm8U68vklFwg2jjFgIXrU93UoqQrz4R/0IWz4nSqiJh/Pl1VTGUR0sZHGOUZOGwOGyESnQvNCp6JTx+25jOcfPe1vNBYLkohfEFy4KObo/TplctKet1hHcwpGQy4cQGMDO3fy/ZKjQi5dxyGpPaU8qR2kfX380YUd6YqRt5rHC9KzmqbnndcA+nitZAErBAgdo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31761e12-411b-4442-33d6-08d6b2b71690
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2019 13:21:14.9744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5907
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to support poking alongside the enter operation,
the cpuidle_dt_ops are added. On each state initialization,
if the state has the property "local-wakeup-poke" set, then
gets to have the poking mechanims enabled. For now,
the arm_poke_idle_state doesn't do anything.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/cpuidle/cpuidle-arm.c    | 13 ++++++++++++-
 drivers/cpuidle/dt_idle_states.c | 15 ++++++++++-----
 drivers/cpuidle/dt_idle_states.h | 10 ++++++++++
 3 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
index 3a407a3..76ee7ac 100644
--- a/drivers/cpuidle/cpuidle-arm.c
+++ b/drivers/cpuidle/cpuidle-arm.c
@@ -45,6 +45,12 @@ static int arm_enter_idle_state(struct cpuidle_device *d=
ev,
 	return CPU_PM_CPU_IDLE_ENTER(arm_cpuidle_suspend, idx);
 }
=20
+static int arm_poke_idle_state(struct cpuidle_device *dev,
+				struct cpuidle_driver *drv, int cpu)
+{
+	return 0;
+}
+
 static struct cpuidle_driver arm_idle_driver __initdata =3D {
 	.name =3D "arm_idle",
 	.owner =3D THIS_MODULE,
@@ -65,9 +71,14 @@ static struct cpuidle_driver arm_idle_driver __initdata =
=3D {
 	}
 };
=20
+static const struct cpuidle_dt_ops cpuidle_ops =3D {
+	.enter =3D arm_enter_idle_state,
+	.poke =3D arm_poke_idle_state
+};
+
 static const struct of_device_id arm_idle_state_match[] __initconst =3D {
 	{ .compatible =3D "arm,idle-state",
-	  .data =3D arm_enter_idle_state },
+	  .data =3D &cpuidle_ops },
 	{ },
 };
=20
diff --git a/drivers/cpuidle/dt_idle_states.c b/drivers/cpuidle/dt_idle_sta=
tes.c
index add9569..6490ed4 100644
--- a/drivers/cpuidle/dt_idle_states.c
+++ b/drivers/cpuidle/dt_idle_states.c
@@ -27,19 +27,18 @@ static int init_state_node(struct cpuidle_state *idle_s=
tate,
 {
 	int err;
 	const char *desc;
-
+	const struct cpuidle_dt_ops *ops =3D match_id->data;
 	/*
 	 * CPUidle drivers are expected to initialize the const void *data
-	 * pointer of the passed in struct of_device_id array to the idle
-	 * state enter function.
+	 * pointer of the passed in struct of_device_id array to the ops.
 	 */
-	idle_state->enter =3D match_id->data;
+	idle_state->enter =3D ops->enter;
 	/*
 	 * Since this is not a "coupled" state, it's safe to assume interrupts
 	 * won't be enabled when it exits allowing the tick to be frozen
 	 * safely. So enter() can be also enter_s2idle() callback.
 	 */
-	idle_state->enter_s2idle =3D match_id->data;
+	idle_state->enter_s2idle =3D (void *)ops->enter;
=20
 	err =3D of_property_read_u32(state_node, "wakeup-latency-us",
 				   &idle_state->exit_latency);
@@ -83,6 +82,12 @@ static int init_state_node(struct cpuidle_state *idle_st=
ate,
 	idle_state->flags =3D 0;
 	if (of_property_read_bool(state_node, "local-timer-stop"))
 		idle_state->flags |=3D CPUIDLE_FLAG_TIMER_STOP;
+
+	if (of_property_read_bool(state_node, "local-wakeup-poke")) {
+		WARN_ONCE(!ops->poke, "cpuidle driver: missing poke function\n");
+		idle_state->poke =3D ops->poke;
+	}
+
 	/*
 	 * TODO:
 	 *	replace with kstrdup and pointer assignment when name
diff --git a/drivers/cpuidle/dt_idle_states.h b/drivers/cpuidle/dt_idle_sta=
tes.h
index 14ae88c..901a40e 100644
--- a/drivers/cpuidle/dt_idle_states.h
+++ b/drivers/cpuidle/dt_idle_states.h
@@ -2,6 +2,16 @@
 #ifndef __DT_IDLE_STATES
 #define __DT_IDLE_STATES
=20
+struct cpuidle_dt_ops {
+	int (*enter)	(struct cpuidle_device *dev,
+			struct cpuidle_driver *drv,
+			int index);
+
+	int (*poke)	(struct cpuidle_device *dev,
+			struct cpuidle_driver *drv,
+			int cpu);
+};
+
 int dt_init_idle_driver(struct cpuidle_driver *drv,
 			const struct of_device_id *matches,
 			unsigned int start_idx);
--=20
2.7.4

