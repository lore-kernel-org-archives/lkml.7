Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23C9C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 09:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F2C120748
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 09:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RhuImplX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfKOJpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 04:45:05 -0500
Received: from mail-eopbgr130042.outbound.protection.outlook.com ([40.107.13.42]:48980
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727183AbfKOJpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 04:45:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WpgJ/NX1P7YCV8c0WH8pJh2G/4aOhjEX+kfTZWSwxoHpYKESXde0Pu9nNIEqKcznRJ4+eU3pPlHmDHvn6w0W4uCkLH9koanuHheNmRyf+O8n35l5VE/XBeXkZhnocEaN3pH34WKVtR+tLUPE+OGSMw5X3GYqgoL+p7ch2TDezWon//cfz7A6pAfkci/A/xp7XxW9D6CWCuImC7SGEjIgPFHaHdbm2aH8RzzdajJ8QZGMkFKohNprbVHrAbXUBQ4elDBWjSLX/VrLe/HGjsH3Zg4EzKZkSpM2d9L28tEwNHc3H2aUbUdz1SEJrCq41c/64IDPVSFx9Mn07NOGxoELXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zsDiIsGKN1JZwMR0iGFgZl4Eiww48ALEr8hE1RkIRUs=;
 b=f+iG0TfN51ZteXJZ3+a0scSLpCcm5OYvZlBH1z8Ywwwp3GYi4kAv/7RiF6SI5yNeKkqZViGemSIj4HP5q2dmzn5XTjOjxb0tmiQlKQDqUVRsparcTgtGO2k2LP1VSJ4kIgvUBDqDVGnlWyRYE36coobu8Qky0dVCHc+CcH39iRbyYROvtLs6EgB1Dej7JfAVnvVVxT/wVHUUFThuamS0WNE4oo+bBeiInS88B91v2z106VqMunEra6SN2q+wXmfBRs70xSzZVuusSOm6ASoJWQKJ+qfCZTUnviRwWH1/BA0IYizzaVgH4Q/tNfT36ghUaDm2nufGwmMagn80ydhghQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zsDiIsGKN1JZwMR0iGFgZl4Eiww48ALEr8hE1RkIRUs=;
 b=RhuImplX2cbias9YgPdqiItdkBR3MPBou5SLOqZre9tg1OGDVEmQ4uxiEUzJSQ31FBJF/NvIpTfny7C+Rj3P06ksArAnCv4w1SQ6zUM6id2nhZcHS8ZBRbQ3rOckQnygxAzxIh6JSA4h7w3Cvou0OwKRZZ4t88BCeS/niGCuh6s=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4146.eurprd04.prod.outlook.com (52.134.93.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Fri, 15 Nov 2019 09:45:00 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c%4]) with mapi id 15.20.2451.024; Fri, 15 Nov 2019
 09:45:00 +0000
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
Subject: [PATCH 2/2] arm64: export __hyp_stub_vectors
Thread-Topic: [PATCH 2/2] arm64: export __hyp_stub_vectors
Thread-Index: AQHVm5lZpVu/s7W1Uk+l10ntkFA81g==
Date:   Fri, 15 Nov 2019 09:45:00 +0000
Message-ID: <1573810972-2159-2-git-send-email-peng.fan@nxp.com>
References: <1573810972-2159-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1573810972-2159-1-git-send-email-peng.fan@nxp.com>
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
x-ms-office365-filtering-correlation-id: dbeb9bce-553b-4ebf-d09b-08d769b07b4e
x-ms-traffictypediagnostic: AM0PR04MB4146:|AM0PR04MB4146:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB41469FE5053B791FA359E81888700@AM0PR04MB4146.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:873;
x-forefront-prvs: 02229A4115
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(136003)(346002)(366004)(39860400002)(199004)(189003)(476003)(14454004)(8936002)(66946007)(386003)(6506007)(5660300002)(305945005)(316002)(110136005)(76176011)(50226002)(102836004)(7736002)(66446008)(64756008)(66556008)(66476007)(8676002)(478600001)(256004)(186003)(14444005)(26005)(81156014)(81166006)(11346002)(446003)(86362001)(6512007)(6436002)(486006)(4326008)(54906003)(52116002)(44832011)(25786009)(6486002)(71200400001)(71190400001)(2501003)(6116002)(99286004)(2616005)(66066001)(3846002)(2906002)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4146;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v0ZUtZQFysbCIHv1zoN6NImCGM1eIjM6oo1IAqjfLV1nYlNiXpzHpcZv3XR3X400pcI/G4s0kTywzfvSdqhi99+Rt/dWG2kuaUdqrMzFnviIErdvtfmfTdl411YsRdgYF27ydeXzNVuBKsWxfSjHavmyLG3zyspGybVZr0VNeeJGey9oUtP7tnxlJ94oJ/4jEV3LKApwD9fKVWx6HsMwcIqw62cvS+XQJlJ7hzwut9B/gSmeMxuYB5Ifs7CfLXqYiFmfRmKl4tkqVZh2/vAruGzoK9qF8S93+XP4Usx2kxJauQ6h/3pCqk706/7BaeeHCn86YSHoLirTnrZdKOLfMdLQhF7R548SwqW6JUlVfy8gZda8b7jshazGV6DGmYS2kXr5JidRDTZFthFAjdnwgZ+gVAnKWkLyh9qMT9uHt2FVD1oBSNa5xdMZbHEYN2rE
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbeb9bce-553b-4ebf-d09b-08d769b07b4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2019 09:45:00.4225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MqHSLQp6Lg6opJ9RvuacljAp6PfzCrkb7aDoa8fCAyue3l6/qZDLk4AJXCeQwHWsZQc9yVJE8BvPJv6a53T4/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4146
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

External hypervisors, like Jailhouse, need this address when they are
deactivated, in order to restore original state.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/include/asm/virt.h | 2 ++
 arch/arm64/kernel/hyp-stub.S  | 1 +
 2 files changed, 3 insertions(+)

diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
index 0958ed6191aa..b1b48353e3b3 100644
--- a/arch/arm64/include/asm/virt.h
+++ b/arch/arm64/include/asm/virt.h
@@ -62,6 +62,8 @@
  */
 extern u32 __boot_cpu_mode[2];
=20
+extern char __hyp_stub_vectors[];
+
 void __hyp_set_vectors(phys_addr_t phys_vector_base);
 void __hyp_reset_vectors(void);
=20
diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
index f17af9a39562..22b728fb14bd 100644
--- a/arch/arm64/kernel/hyp-stub.S
+++ b/arch/arm64/kernel/hyp-stub.S
@@ -38,6 +38,7 @@ ENTRY(__hyp_stub_vectors)
 	ventry	el1_fiq_invalid			// FIQ 32-bit EL1
 	ventry	el1_error_invalid		// Error 32-bit EL1
 ENDPROC(__hyp_stub_vectors)
+EXPORT_SYMBOL(__hyp_stub_vectors);
=20
 	.align 11
=20
--=20
2.16.4

