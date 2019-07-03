Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF631C5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 20:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D8CB21852
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 20:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GWUHjYLf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbfGCU7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 16:59:41 -0400
Received: from mail-eopbgr20068.outbound.protection.outlook.com ([40.107.2.68]:3438
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727300AbfGCU7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 16:59:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aBWOZB9A9QLCsl/EiU2J6XfBNYpFfgi0BtBgM52Vh8M=;
 b=GWUHjYLf3CHm0xpy4YXu++4SQUXekVebpdtOR9wqjqYmP0SC3NYR5ddtn10KzCO6M7F9klyqrgL9rxovfx89UndNLOlWSUMtdK+YXmLGP0cMa9fRo3poWfiHpBTyrOJF4EZTdwjXWj3JafxYwWscchQPF0WDNUjCrJz8UPEexRA=
Received: from VE1PR04MB6463.eurprd04.prod.outlook.com (20.179.233.20) by
 VE1PR04MB6464.eurprd04.prod.outlook.com (20.179.233.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Wed, 3 Jul 2019 20:59:32 +0000
Received: from VE1PR04MB6463.eurprd04.prod.outlook.com
 ([fe80::a5ca:7c9c:6b18:eb0a]) by VE1PR04MB6463.eurprd04.prod.outlook.com
 ([fe80::a5ca:7c9c:6b18:eb0a%6]) with mapi id 15.20.2032.019; Wed, 3 Jul 2019
 20:59:32 +0000
From:   Roy Pledge <roy.pledge@nxp.com>
To:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leo Li <leoyang.li@nxp.com>
CC:     Roy Pledge <roy.pledge@nxp.com>
Subject: [PATCH v2 4/7] soc/fsl/qbman: Fix drain_mr_fqni()
Thread-Topic: [PATCH v2 4/7] soc/fsl/qbman: Fix drain_mr_fqni()
Thread-Index: AQHVMeI2ME1gMBvnEEexZOxSvQbPcQ==
Date:   Wed, 3 Jul 2019 20:59:32 +0000
Message-ID: <1562187548-32261-5-git-send-email-roy.pledge@nxp.com>
References: <1562187548-32261-1-git-send-email-roy.pledge@nxp.com>
In-Reply-To: <1562187548-32261-1-git-send-email-roy.pledge@nxp.com>
Reply-To: Roy Pledge <roy.pledge@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: SN6PR15CA0005.namprd15.prod.outlook.com
 (2603:10b6:805:16::18) To VE1PR04MB6463.eurprd04.prod.outlook.com
 (2603:10a6:803:11d::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=roy.pledge@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [72.142.119.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d720509e-0387-4930-f31a-08d6fff95890
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR04MB6464;
x-ms-traffictypediagnostic: VE1PR04MB6464:
x-microsoft-antispam-prvs: <VE1PR04MB64649B779713A606914690CD86FB0@VE1PR04MB6464.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:330;
x-forefront-prvs: 00872B689F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(39860400002)(346002)(366004)(136003)(189003)(199004)(14454004)(2501003)(81156014)(81166006)(4326008)(478600001)(305945005)(8676002)(14444005)(2906002)(7736002)(50226002)(476003)(486006)(2616005)(446003)(25786009)(11346002)(3450700001)(86362001)(2201001)(68736007)(44832011)(36756003)(66946007)(26005)(66476007)(66556008)(64756008)(73956011)(71200400001)(71190400001)(66066001)(53936002)(6116002)(52116002)(386003)(6506007)(66446008)(8936002)(256004)(102836004)(186003)(99286004)(6486002)(4744005)(5660300002)(110136005)(316002)(3846002)(6436002)(43066004)(6512007)(6636002)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6464;H:VE1PR04MB6463.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NDF3W43Bc8GTmZEyXWvMSqgg6Pj4S9eVCPz3GH2CwV2IT3BpHNeZ2p4QrzV2jx3bOE7eNM8tbxT3/pMyruMqKA5rz9S+AHsJLM4t7UAbjCGLNhGQxwGb2XuS///rkbInu6SMRPvLUU/fNmqWMEc7Pgdm0qijML+2Oo/fILzyznNhYDZd8PBKDdA/M5XboSc5b5Hr/3GiGQiHXNQim4sI6yuObk7NGmShBChBB7DO4IZ7Tu2KsC/aQmTWMZvr9CKpBGOJjrGgXPLzdCJLMvubcvxcqVO0/Ip8AAo7wfOZNT5mafrmK9oJQek9V/q6gai0kR9QXtc8Zmu2wFa52G8JctWBwwqu4PVZ9c4L2Sd5AR22jflX8Uz8MwKoOR/gXvDPGDThLE5KiDfDYSG+zhqhpbcACYHPLmn9/SOEZ4xiUk8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d720509e-0387-4930-f31a-08d6fff95890
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2019 20:59:32.2764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: roy.pledge@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6464
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The drain_mr_fqni() function may be called fron uninterruptable
context so convert the msleep() to an mdelay().  Also ensure that
the valid bit is updated while polling.

Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 drivers/soc/fsl/qbman/qman.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index f10f77d..2989504 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -1164,6 +1164,7 @@ static int drain_mr_fqrni(struct qm_portal *p)
 {
 	const union qm_mr_entry *msg;
 loop:
+	qm_mr_pvb_update(p);
 	msg =3D qm_mr_current(p);
 	if (!msg) {
 		/*
@@ -1180,7 +1181,8 @@ static int drain_mr_fqrni(struct qm_portal *p)
 		 * entries well before the ring has been fully consumed, so
 		 * we're being *really* paranoid here.
 		 */
-		msleep(1);
+		mdelay(1);
+		qm_mr_pvb_update(p);
 		msg =3D qm_mr_current(p);
 		if (!msg)
 			return 0;
--=20
2.7.4

