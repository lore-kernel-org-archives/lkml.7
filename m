Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649B0C2D0C2
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 15:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24A7822B48
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 15:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fbh6gv89"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgADPj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 10:39:59 -0500
Received: from mail-vi1eur05on2058.outbound.protection.outlook.com ([40.107.21.58]:6169
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725943AbgADPj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 10:39:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=inLntqUFUvVPLgYYxaVOMDX65s7oIXMXCbiO2z3GMELMcJzJmbA1cKU+pw3Tf6MymeSkcmh+naLeH9wlH+o56W65/zKYnXliO36ycdf0Nas1HTqpY/JfmZx1QxHASgU0Kba2ko/3vMRj5fhUovJQmXM1QjP/OKtIg3HDZUIljffS+KinH7yGpCcbhNfnbH1NsfBj8TNIQCwhE3qs5Tyk2oPW24ox0Rl11qNr2ARkrZev99VgtNqP1wFzVvA4mxbXkwVO9BaqPzLo3dJiPxHG1NnW7MCMrC42I1EjAPF4jK3tO/0XBuzvfT0dROR8kKxSaVXGWofrn/ajjfvlt97ClQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tFfAp5prsCAbdDMaJdvcSZtDphqq2YqPlLTYjNcJkTo=;
 b=WAgg76pGW+VWvupRuH58KusDeQDdeYhfvxRFxNgBVXP81u93P0EeSXnxiGx0bSPz9umvEkXMIkWv13QdBc/E2jae7UUykIu6laNd00NNeQp2Uva+vR/J0AZ0Nf7pSJIv/v+/zI1NGkZP+UmGccdw0s1l8MIMHw9XCEwpoekQ/pavEGCKayVInwqNnm4zcOFYNpKbE3Ix+q3A3pEyUUBi71L9kQ5jBrs2wXbDogGJ1k1DTKhOuYqTUsT3e3TvgK1rUi1wuxIUtDY+IKI3bMo9Y4cnsN3P2qkBTGRcg/9QTNV79D+7KXGN8xCv9Gr65K6tBxcLq1kH8cEW2m3dTMckvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tFfAp5prsCAbdDMaJdvcSZtDphqq2YqPlLTYjNcJkTo=;
 b=fbh6gv897nBlZIVryPu5TW+8SI5i8TOLs37C0ynW1hiNmnnn0K6jfd/oNyda4b51iBv4eV5gp056l/ZmObTkDd+w346ISIANGO44ApK3zsQa2Loz6CE6p7rTYdKijFErpktefJbZggRwzycnNko6pK/BvkD0492JRlXEidQNlls=
Received: from VI1PR0402MB3839.eurprd04.prod.outlook.com (52.134.16.147) by
 VI1PR0402MB3664.eurprd04.prod.outlook.com (52.134.15.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Sat, 4 Jan 2020 15:39:53 +0000
Received: from VI1PR0402MB3839.eurprd04.prod.outlook.com
 ([fe80::8881:e155:f058:c0d1]) by VI1PR0402MB3839.eurprd04.prod.outlook.com
 ([fe80::8881:e155:f058:c0d1%4]) with mapi id 15.20.2581.014; Sat, 4 Jan 2020
 15:39:53 +0000
Received: from fsr-ub1864-103.ro-buh02.nxp.com (89.37.124.34) by AM0P190CA0013.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.12 via Frontend Transport; Sat, 4 Jan 2020 15:39:52 +0000
From:   "Daniel Baluta (OSS)" <daniel.baluta@oss.nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [RESEND PATCH] firmware: imx: Allow IMX DSP to be selected as module
Thread-Topic: [RESEND PATCH] firmware: imx: Allow IMX DSP to be selected as
 module
Thread-Index: AQHVwxU1MPlW1r9WV0eXj4cyQwYasg==
Date:   Sat, 4 Jan 2020 15:39:53 +0000
Message-ID: <20200104153940.10683-1-daniel.baluta@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0P190CA0013.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::23) To VI1PR0402MB3839.eurprd04.prod.outlook.com
 (2603:10a6:803:21::19)
x-mailer: git-send-email 2.17.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@oss.nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: acd51dc7-9899-4fab-608a-08d7912c577e
x-ms-traffictypediagnostic: VI1PR0402MB3664:|VI1PR0402MB3664:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB36642C56528C732A8BBF34F7B8220@VI1PR0402MB3664.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 02723F29C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(199004)(189003)(316002)(186003)(26005)(71200400001)(54906003)(52116002)(6512007)(8676002)(81156014)(81166006)(86362001)(16526019)(4744005)(6506007)(1076003)(4326008)(5660300002)(2906002)(2616005)(6486002)(66946007)(64756008)(66446008)(66476007)(8936002)(66556008)(6916009)(956004)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3664;H:VI1PR0402MB3839.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: oss.nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: geipwHuI6k+mc5WhVRVyRBa1gVk1oGAO5eJd5gBCoDBzU62k1XL21rgnPq2kH7SRNVy6XPm3ru+/+/0AsWia81vAz9WxXR6TiYKIGuA1g1GPvf/np03Ktc+wxxTOgxYBFdqkyipK4cntcZtCD8Yo70VV/zDidjpJbuTjqzSmiyjazUvfoHAadeWzz4GQv/ozJTPZL5hBtGSwjy8hT6uwo7MGttHaJXL8b4n1vhxtHc+b2kw7ru4HSLUcvcwGfAqbTbUy8t9wwnvK9kPASWs4FOqiu8NWwQSreUwIrEGEUDTbzIIeObaRt6TgcEqXENKs9VbiaxtVRVq74QAHf98am3upeFHWGlxrKfSPsHIPz14kfpFvGPOh99iwQUKc5Qxyh4ZgBrk4fFKZ2QoowBs3xnsB3jgKcwbggb8BH8yRJJ/NU9lNcqM6LwxBxfMBg6/M
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acd51dc7-9899-4fab-608a-08d7912c577e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2020 15:39:53.2690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SoUN/1fLZy8vnfMNvfLTi0AesF65iQQUjDSZ1zz/Ot6Ws2gN/pGH/eMBNtJ/6gmBNQT3XmEOzVfsaAmJbWBu6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3664
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

IMX DSP is only needed by SOF or any other module that
wants to communicate with the DSP. When SOF is build
as a module IMX DSP is forced to be built inside the
kernel image. This is not optimal, so allow IMX DSP
to be built as a module.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 drivers/firmware/imx/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/imx/Kconfig b/drivers/firmware/imx/Kconfig
index 0dbee32da4c6..1d2e5b85d7ca 100644
--- a/drivers/firmware/imx/Kconfig
+++ b/drivers/firmware/imx/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config IMX_DSP
-	bool "IMX DSP Protocol driver"
+	tristate "IMX DSP Protocol driver"
 	depends on IMX_MBOX
 	help
 	  This enables DSP IPC protocol between host AP (Linux)
--=20
2.17.1

