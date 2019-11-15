Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3252C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 09:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A905A20740
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 09:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qmV6JkgP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbfKOJpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 04:45:00 -0500
Received: from mail-eopbgr150052.outbound.protection.outlook.com ([40.107.15.52]:28227
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726920AbfKOJo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 04:44:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CS/pMTbyI/0miJ3UkFWluYWw3tN5XwP6VYGD+634odR0apqBNqtGbolEtlqT5p08PZW9YNXFq8y+Rp295rdlzfbE3ENnX8pwYMxZVVOaTS8ZSvVhxjkSonUk8w9SrwMrmk5JLV2AgquX8JY/2FmVzLjpXTfacg6ErojvDWwjV/RmN/w5KoSWGXUygBpwV6EQSIjNR3gkYlSQ3KDvZwskwM4isq+YTAuO03CqI4f+Dxjj8Tif6lxwdsmLhpAWvOpIbCnMt77vYWXZVF12KUJF9HTibUMQ/ZAva0mIZX/G1R8V7TdbokZe3eGyzLgndKc9BGcGfpPJUhRoB9eqTLaC3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJZfFuTnbCx8UjUCbAUHEAXt/UD+sEx/l/f4hZGjbGk=;
 b=jEBqdXdru8S/jDo83yWTQxEryXM94HuMq9Qt0v4mkbTqJxtkFZBZDI7BrT06zlzy4QcsBjnVS82KHc8XPb1G18AdpNuvxOjt/DGniwtnS/gL2jsVmYhhZod90wvW3ux4fvcCKxq3f7few9kIGhYa0IfGvcHHFYxpkLGk+HUK3TMiq9xjfWhfQVxfCpeo59MyzoAuekRRHxvv1di9rosClP+bikDAliWMIn7Y5eXMie7UQFdYxNrUcTrvuacGLfV+KHhgLQZ0po9inhLMXxH3V8iYE6K/yOBgFZTK9mjCzRUjuNWxEtLxdYJVMHDBgEvcJVQpbOdfL+adF64MFfChag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJZfFuTnbCx8UjUCbAUHEAXt/UD+sEx/l/f4hZGjbGk=;
 b=qmV6JkgPVj+eEndShtFMxylcjwSQWuH8CPl68qkM0hc9SjEaX0gk5wIMzfb+5THrrM1PqKrakcMkYwDX0H05wiwaIVOfPaiN04RlA582MKmFOsW/XRQ0s5XnEWEPlZyJ72WR0RltPJSTiYZD6QSZJVZ0WKxEotOGXPl3aLG0TWA=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4883.eurprd04.prod.outlook.com (20.176.215.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.26; Fri, 15 Nov 2019 09:44:56 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c%4]) with mapi id 15.20.2451.024; Fri, 15 Nov 2019
 09:44:56 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>
CC:     "allison@lohutok.net" <allison@lohutok.net>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
        "ralf.ramsauer@oth-regensburg.de" <ralf.ramsauer@oth-regensburg.de>,
        Alice Guo <alice.guo@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/2] arm64: kernel: hyp-stub: drop unneeded including files
Thread-Topic: [PATCH 1/2] arm64: kernel: hyp-stub: drop unneeded including
 files
Thread-Index: AQHVm5lWKrMcQvbyVEW9TIQ/py78Hg==
Date:   Fri, 15 Nov 2019 09:44:56 +0000
Message-ID: <1573810972-2159-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0010.apcprd03.prod.outlook.com
 (2603:1096:203:2e::22) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6fb2b17e-b6ad-4532-3813-08d769b078c8
x-ms-traffictypediagnostic: AM0PR04MB4883:|AM0PR04MB4883:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB488382C3983860A77A4B715788700@AM0PR04MB4883.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:586;
x-forefront-prvs: 02229A4115
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(136003)(366004)(376002)(39860400002)(189003)(199004)(66556008)(6506007)(25786009)(14454004)(305945005)(110136005)(54906003)(4744005)(66946007)(86362001)(66476007)(50226002)(256004)(8936002)(5660300002)(8676002)(99286004)(81166006)(81156014)(4326008)(2616005)(66066001)(486006)(3846002)(6116002)(316002)(7736002)(52116002)(64756008)(66446008)(36756003)(186003)(102836004)(26005)(71200400001)(71190400001)(2906002)(44832011)(2501003)(6512007)(478600001)(476003)(6486002)(386003)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4883;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JyEPlNDfXkZcjSQ8kclYbKpaX9eBxrG6MK1ljCWH00p8IWqjUvv6RyGiMGYNO0KzD31WoczatVjdd6TY9+z/JrnhojD8aPsTvYcfmXY5oF/Yihfw9Fop8tyV6yS3vwsPrn0hjv79LmZDLaNpZgWlulH1ejuVIYnvtgCFbdWmirO2OCInFDRLFEDkEw4+U5wz8FXpgHvdlsSV20NsKZ2x+tEbCdqhzvgbOvBK3LSnUrWwa0SlpD2OFZDKlXctdBOIB3U/wwRyv7esQ3Wkdmp5eA9gvUIP1MsLKEkFB7t8fmc81yWkN2BNFnVvb/HswTPd/t0WTsA8S4xXIyOCrF8NsKrmCvrV9PhdwMBy3OhpwAGqR98jI0io5iNoIuQigxsk+ORVGGwt815JqkcbZ/aYWqA6AwlhxymK3cHFW4v1zNLaFmCZWQozM+nWqzeyiI8d
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fb2b17e-b6ad-4532-3813-08d769b078c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2019 09:44:56.1900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sJfTIl+6xPUkLx0TzQXBliG1Jdu0MbwjQTxprGMFYTZLoOBpL4LpmEMV49S0iZYtLLb2PHsCSu5+7qWAkQ1C6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4883
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

These files are not needed to be included, so remove them.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/kernel/hyp-stub.S | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
index 73d46070b315..f17af9a39562 100644
--- a/arch/arm64/kernel/hyp-stub.S
+++ b/arch/arm64/kernel/hyp-stub.S
@@ -8,12 +8,8 @@
=20
 #include <linux/init.h>
 #include <linux/linkage.h>
-#include <linux/irqchip/arm-gic-v3.h>
=20
 #include <asm/assembler.h>
-#include <asm/kvm_arm.h>
-#include <asm/kvm_asm.h>
-#include <asm/ptrace.h>
 #include <asm/virt.h>
=20
 	.text
--=20
2.16.4

