Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD6DFA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 15:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC0DB2067D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 15:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="fLrCSFHA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392991AbfJPPTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 11:19:04 -0400
Received: from mail-eopbgr00099.outbound.protection.outlook.com ([40.107.0.99]:40845
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389491AbfJPPTD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 11:19:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oFR9rak1vCrSFL9giQMHglA+hVyuoYTPwNCMKpyg+HtyznYEUEtM/dkxCyVuFGHW8RWkOeUGnkJMUefApGs3rwvEzrDKf09/xLih9ar+tqJQVjQqg2uH/vLatv9gT7l9a70T0EJ5ynb+ugwRXrxB7Xvuu15aizyQ6Yvl6fhkZMRQgx8yTlHirlUrMKe2iVl18ZwNyNGimpbbheYQ6VOHYibK6I0IrJb6ZqP3jmpgDFZOiJb7SYBPMoULgNxLwRxA/v+KxVvGKAtLbMDZuC5v4bExu6APRSZ7tEfaP4w7OdCYpd+x6FJWQZbSfi1ZWHXvu26+upjJz5N8t9JlNezd3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nR9yoF1JpLwYSiqpWxXpnF8trAmHxRH+FAlrkUN46Ck=;
 b=EEkiIGcrku6QwDIbV1OYCWjG/d1tlWEzlJCYDx84IFyxbCppxDUwbF6D7r+Z3UT+i+GbLoJxcBsNnS+TV9tp5wwAataTUlo+43m6/KbGP3d4fJTHNUInI2jQLt1b0rZiMyeKP+OOczJRT0FRrSKvvNMScYk9Il+sU3jvHCAiUfXXQjAAEXyf+oAxF9KMYJfoEWH63aRfCcK8bE6OJumvD2cSTA3rTa5Spn45hcuWZkzLAYMSQvsL84F4Zso3FGS91M6/dWbW6mpr9EulxB7BYkcjBe/FFfYOD2gZ2tro9d3uAHyc8elp2aKUtQfelJyAfVX9OwO7ZtkbxARnoYRUAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nR9yoF1JpLwYSiqpWxXpnF8trAmHxRH+FAlrkUN46Ck=;
 b=fLrCSFHAwAMw6OIUu17KSxvATgJc9vlLq+z9UlujplHhN9BcB45CUoOm1r+LWTHxZLU6bGgAC1z6iEqr5GVGzE4n+NdU5xRkP/VRSQfG221wmb5oWc4E6Xyj2VYPH+1jICi4LRefzLKvQbExirDiUHtmZLAz9hzY388s9BRFTz8=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.19.20) by
 VI1PR0502MB2989.eurprd05.prod.outlook.com (10.175.21.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Wed, 16 Oct 2019 15:18:58 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f427:26bb:85cf:abad]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f427:26bb:85cf:abad%7]) with mapi id 15.20.2347.023; Wed, 16 Oct 2019
 15:18:58 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
CC:     Max Krummenacher <max.krummenacher@toradex.com>,
        Jiri Slaby <jslaby@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fugang Duan <fugang.duan@nxp.com>,
        Stefan Agner <stefan@agner.ch>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Philippe Schenker <philippe.schenker@toradex.com>
Subject: [PATCH v1 2/3] tty: serial: lpuart: Use defines that correspond to
 correct register
Thread-Topic: [PATCH v1 2/3] tty: serial: lpuart: Use defines that correspond
 to correct register
Thread-Index: AQHVhDUHkqKVuU+c6E+orQizzb4u3g==
Date:   Wed, 16 Oct 2019 15:18:57 +0000
Message-ID: <20191016151845.15859-2-philippe.schenker@toradex.com>
References: <20191016151845.15859-1-philippe.schenker@toradex.com>
In-Reply-To: <20191016151845.15859-1-philippe.schenker@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR10CA0029.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::39) To VI1PR0502MB3965.eurprd05.prod.outlook.com
 (2603:10a6:803:26::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.23.0
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 920d0434-e11d-418f-389b-08d7524c2a47
x-ms-traffictypediagnostic: VI1PR0502MB2989:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB298992A847A7B6D33EE393DAF4920@VI1PR0502MB2989.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:741;
x-forefront-prvs: 0192E812EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(396003)(376002)(39850400004)(136003)(366004)(189003)(199004)(81156014)(2906002)(5660300002)(44832011)(476003)(486006)(8936002)(14454004)(110136005)(50226002)(2501003)(2616005)(8676002)(66066001)(11346002)(1076003)(446003)(54906003)(316002)(81166006)(86362001)(4744005)(3846002)(478600001)(6116002)(25786009)(66556008)(6436002)(66946007)(66476007)(66446008)(26005)(6512007)(36756003)(107886003)(6486002)(305945005)(52116002)(71200400001)(71190400001)(99286004)(64756008)(4326008)(186003)(7736002)(76176011)(386003)(102836004)(256004)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB2989;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mWHpUYSmd7IIZt4z20AUO/wvHCLlIaatLqATXtmj9nhTti6DsZmH7FzKIamCFIVI8eUB61qXaIwDMkQ76ulLyVTTRV//DNlaiToeQM1DwM3hlpT7P7/RvTZwxPPvjW/mVKbzcxP5yP7Kyxv853QaMGXtBfiXe29zze0jbYas0Kst0SH3Ox+kGPqk4itPOHsSgQl//pRwMYv3TVkJ6szFIi73d403o4Rruai5LIbA5kh5RF396aUSxSgewile3lOFFj7LDfjqgfieFPa5Ixy0tGKl8V6ogQUMtWtyJ5bwjptBpSk2uDOEgiu+RfqXoX+Ef2I/Yus0XRvWZi+7I+oEPKLzbOv8fAYtta/FHvcnfKRjMXOK0agrNqTWpYLXhuAx15uzf02CP56LLXwu7UoOqA6/vanyowcLpyivRnm0cEg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 920d0434-e11d-418f-389b-08d7524c2a47
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2019 15:18:58.0424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m232DPHBzkXAdpTA6yj2EsUSIYs8fFrXeM7EjZdJQH7LARymPEAD+QQ6CsyjhCiMZuBAZfUSAdnTGGAE5W7/9Vg2AtWR8nCjX8k3Ld2ossI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB2989
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use UARTMODIR defines instead of UARTMODEM as it is a 32-bit function

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

 drivers/tty/serial/fsl_lpuart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuar=
t.c
index f3271857621c..346b4a070ce9 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1879,10 +1879,10 @@ lpuart32_set_termios(struct uart_port *port, struct=
 ktermios *termios,
 	}
=20
 	if (termios->c_cflag & CRTSCTS) {
-		modem |=3D UARTMODEM_RXRTSE | UARTMODEM_TXCTSE;
+		modem |=3D (UARTMODIR_RXRTSE | UARTMODIR_TXCTSE);
 	} else {
 		termios->c_cflag &=3D ~CRTSCTS;
-		modem &=3D ~(UARTMODEM_RXRTSE | UARTMODEM_TXCTSE);
+		modem &=3D ~(UARTMODIR_RXRTSE | UARTMODIR_TXCTSE);
 	}
=20
 	if (termios->c_cflag & CSTOPB)
--=20
2.23.0

