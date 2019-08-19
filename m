Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38155C3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0964A20851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="EZN53o4d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfHSLgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 07:36:13 -0400
Received: from mail-eopbgr770041.outbound.protection.outlook.com ([40.107.77.41]:61973
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726717AbfHSLgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 07:36:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ob/qWgPxLDbO1j2rVc45mkZRHnS6njXTehJk2JeEQmWwRrt1QtP0/RiPvdRUDr5YPRvgNCBigJ0+2AUV+m5IO1EgbvYX1lY+MryQWgVhliYjE4pVIWQLWcTDDvX0rzEDtoGvch/JamldjdhownxiwsXNTsT8XzbG9Q0QfaAGYK1odjudyOBs0bfeSTm2kU57O6PvQU34V46i+qLOrGSMEgpgA6s0kViOp67MckzwKDCPR6xfMzmEXIEtuzvlTWXNsRJub8Vy6Yo5M/fNCUyUIw5uWg8dZYWqSTKyTq7BSJNuwjMOnJg3dPQTb7oLWrb5LA/9I6xsMkH5MUcgfUhBKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKpBe//J7CHtDTR2w3jG8GwEs1XJGPcWYz2zYmDSEZs=;
 b=bNFk7nEZ95GGwtx6TBuaxp6RgpHFN8+zdI7+g3LYJDtYE1vgUHiEF/HrIWSlXZ47bSC4cDpVr6hGKGYU46rXiIiE0CDdUiY5BswHj4r2EWecquLo0XdRcUfspQIC7f6xqMfv9WsqIlnm8ewqoAGNUoAA2XH19xOBKdQcuat4uA+8ATfvOo+kZS2r5y8hR3Ad1Aj5CZEaTHZRDZ5mvXesTcZmmy9hUaC5rH1SDggssk3BbMS7f9PtRoqMib8S5wfBhsF+4Ogq+89VG3L+Nt+xauXsEcHpzFpXGQtSwlEWYTdP46cga0wGcqxqs4ea37G8lUsA3K1aObuZ7b8ahyuN4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKpBe//J7CHtDTR2w3jG8GwEs1XJGPcWYz2zYmDSEZs=;
 b=EZN53o4d/t7XYuciWjmoGPuY7Y7LlGFxAAJcCujA2ZGaInhPIcGOMv0z6jyJ4c2TojPAh2VpcLOCyIhHa73nBjykq/UU1hHsFHg8Qxl26yjGkWk0u55gdQgo/CFTXF0AeOSqMpn/ckAZvYJ2/L3sYmK9C1IqYrBVF+KX9WAWf8w=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB4838.namprd03.prod.outlook.com (20.179.93.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Mon, 19 Aug 2019 11:36:10 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::a517:3578:67bf:6c88]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::a517:3578:67bf:6c88%7]) with mapi id 15.20.2157.022; Mon, 19 Aug 2019
 11:36:10 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/4] kprobes: adjust kprobe addr for KPROBES_ON_FTRACE
Thread-Topic: [PATCH 1/4] kprobes: adjust kprobe addr for KPROBES_ON_FTRACE
Thread-Index: AQHVVoJMyFG9yAYnDUGqVMEGNEXBVw==
Date:   Mon, 19 Aug 2019 11:36:09 +0000
Message-ID: <20190819192505.483c0bf0@xhacker.debian>
References: <20190819192422.5ed79702@xhacker.debian>
In-Reply-To: <20190819192422.5ed79702@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TYCPR01CA0053.jpnprd01.prod.outlook.com
 (2603:1096:405:2::17) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c17c311-704d-49d0-e979-08d724996e64
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR03MB4838;
x-ms-traffictypediagnostic: BYAPR03MB4838:
x-microsoft-antispam-prvs: <BYAPR03MB4838B9844640A19A5DE7FB8FEDA80@BYAPR03MB4838.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:478;
x-forefront-prvs: 0134AD334F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(376002)(346002)(366004)(189003)(199004)(316002)(50226002)(7416002)(52116002)(99286004)(6486002)(478600001)(2906002)(66066001)(71200400001)(54906003)(86362001)(14454004)(3846002)(5660300002)(71190400001)(110136005)(76176011)(4744005)(8936002)(6436002)(66946007)(305945005)(81156014)(66446008)(64756008)(81166006)(66556008)(66476007)(8676002)(6116002)(7736002)(186003)(102836004)(1076003)(26005)(6512007)(446003)(9686003)(11346002)(53936002)(486006)(6506007)(386003)(476003)(256004)(25786009)(4326008)(921003)(1121003)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4838;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: c81MKNF1YphsHMlylKiRBU9aJ/xP+u1Lbl7wz7r9VK8QVsMiwQP716huOxdjDlYnF3KL+jyYIKS4gjY3lHngl/P/23jPM9fCt2/k3VtDdDwn+AIR6grdlMY+S5qfz3xrgJFmDLnobohoEwX7oOwWMAgF4ycFuG1NF0UOkpVzYQ9fW3Rislt7AcgmT/c0OUsteCC1jJYPK9bDRsdFzqcmvT5IVTHTxFpphG/zgd+P/wbo7/DO6ZROzcSSVwmtCviGynM31y+8rPofZShups3RsSPd7udYV8sLqaVTuOcmuSvTtRRU+jBGL4tHZhQRrKIHdLnJ0N1gmdz8ShX/4mhGEaS8ZaALF5r1jESAFJnLCQHRhwZD6cGeqiUrBRPpNOIzUpzoU5mnWrybcJFHBfhce+A/UViQTaqshE7eWp5lsTU=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C2360F92B5CA694C9B2DBE540C46BC57@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c17c311-704d-49d0-e979-08d724996e64
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2019 11:36:10.0036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0nXnn4v0KeDRAUFNixQYt1ALLlXZaxisepbnOOmcF1QL3/QeF5ra00On90OhH//GuJZKNwV0Ve2tlIF6fTLQPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4838
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For KPROBES_ON_FTRACE case, we need to adjust the kprobe's addr
correspondingly.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 kernel/kprobes.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 9873fc627d61..f8400753a8a9 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1560,6 +1560,9 @@ int register_kprobe(struct kprobe *p)
 	addr =3D kprobe_addr(p);
 	if (IS_ERR(addr))
 		return PTR_ERR(addr);
+#ifdef CONFIG_KPROBES_ON_FTRACE
+	addr =3D (kprobe_opcode_t *)ftrace_call_adjust((unsigned long)addr);
+#endif
 	p->addr =3D addr;
=20
 	ret =3D check_kprobe_rereg(p);
--=20
2.23.0.rc1

