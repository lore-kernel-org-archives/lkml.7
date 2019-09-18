Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96109C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 18:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6000021920
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 18:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dEA3GATt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731265AbfIRSqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 14:46:32 -0400
Received: from mail-eopbgr80077.outbound.protection.outlook.com ([40.107.8.77]:44706
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726527AbfIRSqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 14:46:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ODVvmy9mZ2UgmiJWUP3IldUWlWA0qF1XhZ0Uzp1lKppIGqNkrPyIxzJy7pp0KDoIHLEZoxMJBbz/hvMy4ZHBLbeWgWD0ssYRZthjqF7R+tjeDRuyVy5T8qhPKAwu6mwI03PfFciyisoX4oo3eD9HJmbpMcapXXYXsccfHQ1UeSZbhZT73YPl8uHra3D9pHjtAFhlHOARruva8Cg5wN8V5HHIizXPlWUlid+Hwu98Sw1NNXPwQTl2mFNVnNa3IFpmFU6jXkYtHtBD86n+76XN7jiNuufzVM3pYpxzD5EzjaZ9n7o/Ip9NQsNrWecHCDx1Xqzt6cdgRVQS69iFKlQDTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7wJbWssIKZxJmAuFU0UyteBUu0xij640+jqCt8X5fE=;
 b=ZPz7g30LBZiNNZOW/LWKemtwEdRtUKPl2nP8YG0RMFCQy7tY3FW9K86sUatBiROySHnySOuGxns30oBXai+4rzdppnTrC2DJzykDnNVV9n9/ObjGasfYdGLAgsGUgB0Y+aE42mODJuxnRA6qOqAcX4l5ZuiyggjwiGI7T7eoJThMFZUO0MaOatYTWgdhm3wqZsEVwSPfLJlxgwXM58Ij7Wil8DPgdMuJyGRJpOpKDq4xLLKd+4ff7pZrn0YMF6Qf6NktiC05Y4bHdLNPhFg9d67a3xiXWlIXl/Opuj0vbvzsSXCAJWsScVxuavZdv4cCUq6htaDHEEB22uiXSaLFrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7wJbWssIKZxJmAuFU0UyteBUu0xij640+jqCt8X5fE=;
 b=dEA3GATt2d2g4xpXYTrNIzVMRFvVFexqm9g9wgiGduCGmMontngRKdYpsTUxC1LEeH7pEHddVGHcw7S8rEdpBdOHvXN3VIyoUYg4oLDtxwNenZfaL6oUU1dws+0zse8kY1RxqBzQ9cUnanVx2ilXP5MPtS1Kr1X8vRAe+/DyMiA=
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com (10.175.20.18) by
 VI1PR0402MB2768.eurprd04.prod.outlook.com (10.175.24.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.15; Wed, 18 Sep 2019 18:45:49 +0000
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::19cd:9f82:31ce:fbbb]) by VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::19cd:9f82:31ce:fbbb%8]) with mapi id 15.20.2263.023; Wed, 18 Sep 2019
 18:45:49 +0000
From:   Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jslaby@suse.com" <jslaby@suse.com>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] tty: serial: linflexuart: Fix magic SysRq handling
Thread-Topic: [PATCH] tty: serial: linflexuart: Fix magic SysRq handling
Thread-Index: AQHVblFJs/zkbwp0NESaxrzBZPqzEw==
Date:   Wed, 18 Sep 2019 18:45:49 +0000
Message-ID: <20190918184439.7465-1-stefan-gabriel.mirea@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.22.0
x-clientproxiedby: AM7PR04CA0008.eurprd04.prod.outlook.com
 (2603:10a6:20b:110::18) To VI1PR0402MB2863.eurprd04.prod.outlook.com
 (2603:10a6:800:af::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=stefan-gabriel.mirea@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b7337bd-1995-4bac-0042-08d73c686c5b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB2768;
x-ms-traffictypediagnostic: VI1PR0402MB2768:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR0402MB276884383EC3D9B3102BEDF4DF8E0@VI1PR0402MB2768.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01644DCF4A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(199004)(189003)(486006)(305945005)(25786009)(14454004)(478600001)(2906002)(6506007)(386003)(66066001)(6306002)(66946007)(71190400001)(71200400001)(64756008)(52116002)(966005)(6512007)(7736002)(99286004)(102836004)(66556008)(86362001)(66476007)(66446008)(8676002)(6436002)(4326008)(81156014)(81166006)(316002)(5660300002)(26005)(6486002)(476003)(110136005)(8936002)(54906003)(50226002)(36756003)(14444005)(186003)(256004)(1076003)(2501003)(2616005)(3846002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2768;H:VI1PR0402MB2863.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XdKpXRV7dNJmNrtpsOaDQKuPOdeOpN62ZQORPWiAqnKXFuw0vewYJEXozCR7OPW1iT5Fum/DmlgIImdccSjoITeDZw+tMIrAeGhpXT4AqbvkvmjatYYzEwuW8iHX4EuB/hIuwjO2BtAR/Spy/FZ0haBOA1PwEVneDE5dKrR90DB4qYzyZ7iy1POD/+TVQySNJYrWdaFLEfRlF7GLij9/O8IbV2CAfEC7sC/zquUYB1F/DEru4pf1Kf/YJMrJKk8Us0DqO3qJRbtoWZlanwR4yZ8HmlwUlVjupbTg6c+2hYu+JwbeKSi+bozKH75jLqz2w7/UHqMC1prjDbm7/howg7Pi3ehLB2/ebHH/Xhbwr6isiV9kFyFBhWzUZ4IgLuNKn7jm1xVs3eBEjMB52sHjh3JRbZ4PrxRxGPdFNswruks=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b7337bd-1995-4bac-0042-08d73c686c5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2019 18:45:49.1141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8wIHwa+Cpv+9tZrUrghXuSsvgzwt1mYr7c9hcdXnlRognlJnh8apgNlcqteMQYoHgpIqTexYJWVp3NkPrID5BP9oOk0Zk/EYQCfWJjvnGgY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2768
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following an incorrect indentation reported to me by Dan Carpenter, I
noticed that the SysRq lines were inherited from the lpuart driver[1] (note
how the 'continue' is aligned to 'sport->port.sysrq =3D 0') and we have nev=
er
actually tested the SysRq support.

'sport->sysrq =3D 0' is not necessary neither before nor after 'continue',
because sysrq will already be 0 after uart_handle_sysrq_char() will finish.
Also, since the LINFlexD driver never called uart_handle_break(), sysrq
would have never been set to a nonzero value, so uart_handle_sysrq_char()
was not going to do anything.

Break conditions are detected based on a null data byte along with a
framing error (stop bit sampled to 0).

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/tty/serial/fsl_lpuart.c?h=3Db3e3bf2ef2c74f5ce5c19510edbbb9bfc1d249=
c2#n659

Fixes: 09864c1cdf5c ("tty: serial: Add linflexuart driver for S32V234")
Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/tty/serial/fsl_linflexuart.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/fsl_linflexuart.c b/drivers/tty/serial/fsl_=
linflexuart.c
index 68d74f2b5106..a32f0d2afd59 100644
--- a/drivers/tty/serial/fsl_linflexuart.c
+++ b/drivers/tty/serial/fsl_linflexuart.c
@@ -3,7 +3,7 @@
  * Freescale linflexuart serial port driver
  *
  * Copyright 2012-2016 Freescale Semiconductor, Inc.
- * Copyright 2017-2018 NXP
+ * Copyright 2017-2019 NXP
  */
=20
 #if defined(CONFIG_SERIAL_FSL_LINFLEXUART_CONSOLE) && \
@@ -246,12 +246,14 @@ static irqreturn_t linflex_rxint(int irq, void *dev_i=
d)
 	struct tty_port *port =3D &sport->state->port;
 	unsigned long flags, status;
 	unsigned char rx;
+	bool brk;
=20
 	spin_lock_irqsave(&sport->lock, flags);
=20
 	status =3D readl(sport->membase + UARTSR);
 	while (status & LINFLEXD_UARTSR_RMB) {
 		rx =3D readb(sport->membase + BDRM);
+		brk =3D false;
 		flg =3D TTY_NORMAL;
 		sport->icount.rx++;
=20
@@ -261,8 +263,11 @@ static irqreturn_t linflex_rxint(int irq, void *dev_id=
)
 				status |=3D LINFLEXD_UARTSR_SZF;
 			if (status & LINFLEXD_UARTSR_BOF)
 				status |=3D LINFLEXD_UARTSR_BOF;
-			if (status & LINFLEXD_UARTSR_FEF)
+			if (status & LINFLEXD_UARTSR_FEF) {
+				if (!rx)
+					brk =3D true;
 				status |=3D LINFLEXD_UARTSR_FEF;
+			}
 			if (status & LINFLEXD_UARTSR_PE)
 				status |=3D  LINFLEXD_UARTSR_PE;
 		}
@@ -271,13 +276,15 @@ static irqreturn_t linflex_rxint(int irq, void *dev_i=
d)
 		       sport->membase + UARTSR);
 		status =3D readl(sport->membase + UARTSR);
=20
-		if (uart_handle_sysrq_char(sport, (unsigned char)rx))
-			continue;
-
+		if (brk) {
+			uart_handle_break(sport);
+		} else {
 #ifdef SUPPORT_SYSRQ
-			sport->sysrq =3D 0;
+			if (uart_handle_sysrq_char(sport, (unsigned char)rx))
+				continue;
 #endif
-		tty_insert_flip_char(port, rx, flg);
+			tty_insert_flip_char(port, rx, flg);
+		}
 	}
=20
 	spin_unlock_irqrestore(&sport->lock, flags);
--=20
2.22.0

