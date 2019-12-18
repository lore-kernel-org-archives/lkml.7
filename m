Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 697C9C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 02:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B936206D8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 02:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="g0fLgO1V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfLRC5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 21:57:02 -0500
Received: from mail-eopbgr10061.outbound.protection.outlook.com ([40.107.1.61]:24480
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726692AbfLRC5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 21:57:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m6Ns/OJpYxZ8UnzDg/18EJjWfd/4pz9ELPjD4Zrvv1wSVVsSV7Egdy1dt0mmxQPKKSGi3d5qR0T/WxGAjWs7GcxzTdzHz4eEP3+OEhmsx3027i9vwKw/kVzHKz0AdyTgCfNbIl2q9a+a9QRP09mplIJwM78+AwSDgaULNbXxlgMV1F5/65BBR1X2UY0pnqBvRJJVfIPygyJ1JoaUvY0TWmSGxGWibSOBDMCltSoYuCQFz0u3KPnjwElt719tKuukrCkRvTIFLJUcHUTmln6DJugoMUsr78FHrHIilaaMHc0IXnhDMGCnLR34GaWNj6Qlz63/4WW/cunVZ/RJui38CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5p2VusnXK40CMyc4GtZRup+0926cc6bW/dyjLs9kp0=;
 b=n/JSPnqd8b7Nv9r9/irLapFKj2YW/Hl4W7Wr61Sm1wvrYV8LIAX8CjhlRljFfCeQlO9m9CztpB4gujvUHGgXpGvfmO2dVSKi5/H2j5MH7B/aOQWxQCOKY9P4DRCKvP0Lbl1lAyay6FXeOqJh2NmfY60ZZvV8MBPdTuVjKuaI+3RIk3MMVlF6w/tSggEQifoMO0RYbPMIqCjaDdjgc56ViZTez++de63sz88ohLMQ9+49nq2wyjwKIbspbkPLbqvuOFoDK3nud5ilvwGrrF205jayj0CpND13wY0Gu+IPm0FPTIlxbg+udFA1o5sA91hJo6bVoYXgZ03xqlt4mYZLyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5p2VusnXK40CMyc4GtZRup+0926cc6bW/dyjLs9kp0=;
 b=g0fLgO1VUbR1GONX0oH2UvRRF8HezbQN+jpdccl2aGWg8mFev9oBYBXYZV3HauzZb8krl75moN0AnXoV9WBhLqbSjhdKs0oNshjnI50jXZSFn682snN+77NYieqWofsWja7f1mqkCoMqcSqpY8EpsDV5sXhnZeD5b7FEz9vxG1U=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5715.eurprd04.prod.outlook.com (20.178.117.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Wed, 18 Dec 2019 02:56:56 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::505:87e7:6b49:3d29]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::505:87e7:6b49:3d29%7]) with mapi id 15.20.2559.012; Wed, 18 Dec 2019
 02:56:56 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jslaby@suse.com" <jslaby@suse.com>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>, Alice Guo <alice.guo@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 3/3] tty: serial: fsl_lpuart: drop earlycon entry for i.MX8QXP
Thread-Topic: [PATCH 3/3] tty: serial: fsl_lpuart: drop earlycon entry for
 i.MX8QXP
Thread-Index: AQHVtU7O/Pw5Mf6Bq0uOwGYlxwXgIw==
Date:   Wed, 18 Dec 2019 02:56:55 +0000
Message-ID: <1576637626-19317-5-git-send-email-peng.fan@nxp.com>
References: <1576637626-19317-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1576637626-19317-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: KL1PR01CA0100.apcprd01.prod.exchangelabs.com
 (2603:1096:820:3::16) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d1bc45a5-2243-4ac5-9b74-08d78365f0da
x-ms-traffictypediagnostic: AM0PR04MB5715:|AM0PR04MB5715:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5715693FC1FA69C25B8CE3A288530@AM0PR04MB5715.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:372;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(189003)(199004)(110136005)(54906003)(316002)(71200400001)(5660300002)(26005)(186003)(66476007)(86362001)(66946007)(64756008)(66446008)(6506007)(52116002)(66556008)(8936002)(81156014)(81166006)(4326008)(2906002)(478600001)(36756003)(44832011)(2616005)(6512007)(4744005)(6486002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5715;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x4AdkUriB6lIYEH/pdiR53ao2Z9msYOqf8HftMHE+ZVCjCXfWquH0424gXjH0vTLZOV/NcNzQtqGUrCdoc0Io1LW5dzHwvxITcDOUKvAoGzIqoqrB4pqxarvzRDQVP1eFXDAMciUB6xV3ma/vI8KAe5kKMjXG53SukHXMMRzKwoDddYynJLh+++EWXsFrzGUQyprWcUhmO3bpN6fhXkLfDsVNvV0SqcV0vXE1CH5WABEUkIvkLNfY+mGVuRMHVixDjoYRzmp2SmL3d8P6KKxSrX+3KN/EI61twCYyjuaj1IfwAiIZ+D/zR9HNy5CzF0YIUZ+NXFlExIWh54jVNQ/9q/d+s3DyzCoJ40OJVKMIOl1RBDDI+4Dteg3CP/I53CnPUNnpC5q9AoXU6yZi5Fxu9cY1RbDd4cnh+nDY+xvCbQIYKchXf08t/t7Yr8yv40m
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1bc45a5-2243-4ac5-9b74-08d78365f0da
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 02:56:56.2962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NJmsq/CjiZwpz/MlfUxf4LhhAJ9zG2f4Av+HZw779bYcGJy89LEj6K9eyshRTOqG792P3o0qA/g6H6qXTyPZlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5715
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX8QXP lpuart is compatible with i.MX7ULP, so no need
an extra  entry for i.MX8QXP.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuar=
t.c
index 6ad0af073e62..00cf72e9e9e8 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2398,7 +2398,6 @@ static int __init lpuart32_imx_early_console_setup(st=
ruct earlycon_device *devic
 OF_EARLYCON_DECLARE(lpuart, "fsl,vf610-lpuart", lpuart_early_console_setup=
);
 OF_EARLYCON_DECLARE(lpuart32, "fsl,ls1021a-lpuart", lpuart32_early_console=
_setup);
 OF_EARLYCON_DECLARE(lpuart32, "fsl,imx7ulp-lpuart", lpuart32_imx_early_con=
sole_setup);
-OF_EARLYCON_DECLARE(lpuart32, "fsl,imx8qxp-lpuart", lpuart32_imx_early_con=
sole_setup);
=20
 #define LPUART_CONSOLE	(&lpuart_console)
 #define LPUART32_CONSOLE	(&lpuart32_console)
--=20
2.16.4

