Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BCEC3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A262820851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="bi5gyHqL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbfHSLgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 07:36:51 -0400
Received: from mail-eopbgr770075.outbound.protection.outlook.com ([40.107.77.75]:47585
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726594AbfHSLgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 07:36:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K5G4ymBeagUvXO75mVIDg/U5aPgbjpxgIAHRBA/Zn5ayvzoR7cRQAakicItUz1EZGLKbM9+nb0nlHU5SwFd9D+nGL2+0xYZekr6OKsfvFVk5AafiDeJqiF0oVooYcBa0F0Af/3MFjPe13pXivpr96gtqQghSNsT/8wEkhRhT9QJPKuNEiKMAocfBHqWQZIFXIg551PxeIwwdX/obNXbia5ydt5idc1yJ9yLSPzrWHa9W+B90+sp1zyzGWVA7l91mHkPucV+XqCu6RHmbTFd8OZ/zJyT53W/vGqKJWuzhs0Hb+TIjRZfCxDR57a4e1LLuvqyFFi7qowrxye5VDsUxoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FyckNaQgSq4hdpvyN5DvPdGi9XkzQjEcuu5+VJl2/ck=;
 b=d/UyaUynqMFSWCPJwDg762QCLS9mOpO/3Ud2MEg36pr3YGkP8kN27nCyDGwJoQjXKq10Re6d3EHA8lGaGzkTtx1OWDvWSCXW+5DbSEJefQp7Px4VI0u0NWXvfRWyrLCH9uhStWdBFZ8mM1RnjOxLWZniyQ6JxA3S/kEyXkn3qLX85bc0Ni4HXXOwBe96+Wqbqca4w+JCGTgmCl7JtXCj7C9GwOVIPLysQ9jnzsZ9RFGVjKBDzu/pXiic345gtp7a9LvnwFbcad4xRd6xFzkJ5hn6gzz5cEDVcWl3c/vQc2Fenj0SVgqr63cQp8BsB5AXt9FSkkXdk8iGdOgin5WXPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FyckNaQgSq4hdpvyN5DvPdGi9XkzQjEcuu5+VJl2/ck=;
 b=bi5gyHqL/T9Zpemz9TItLFIPBjwT47qqwfEgov4IrMGggIemYSPscQd3oB4iwRg1gjGKiz8vy9nb47lP6CJNUReW6sKpa0QTjsepVKBLTiIGDbcG//O+bmvKDpsVLUW+GEu/or2aDp6vdkI/fKx48QNOSxTGlqybC2fZ/nGv5Os=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB4838.namprd03.prod.outlook.com (20.179.93.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Mon, 19 Aug 2019 11:36:48 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::a517:3578:67bf:6c88]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::a517:3578:67bf:6c88%7]) with mapi id 15.20.2157.022; Mon, 19 Aug 2019
 11:36:48 +0000
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
Subject: [PATCH 2/4] kprobes/x86: use instruction_pointer and
 instruction_pointer_set
Thread-Topic: [PATCH 2/4] kprobes/x86: use instruction_pointer and
 instruction_pointer_set
Thread-Index: AQHVVoJjLhLBz1QsakilYQzbvNrNQg==
Date:   Mon, 19 Aug 2019 11:36:48 +0000
Message-ID: <20190819192543.32cec143@xhacker.debian>
References: <20190819192422.5ed79702@xhacker.debian>
In-Reply-To: <20190819192422.5ed79702@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TYAPR01CA0139.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::31) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d88841ae-1f36-46ca-44d6-08d724998573
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR03MB4838;
x-ms-traffictypediagnostic: BYAPR03MB4838:
x-microsoft-antispam-prvs: <BYAPR03MB4838557F8F5E7129AEA9181EEDA80@BYAPR03MB4838.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0134AD334F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(376002)(346002)(366004)(189003)(199004)(316002)(50226002)(7416002)(52116002)(99286004)(6486002)(478600001)(2906002)(66066001)(71200400001)(54906003)(86362001)(14454004)(3846002)(5660300002)(71190400001)(110136005)(76176011)(8936002)(6436002)(66946007)(305945005)(81156014)(66446008)(64756008)(81166006)(66556008)(66476007)(8676002)(6116002)(7736002)(186003)(102836004)(1076003)(26005)(6512007)(446003)(9686003)(11346002)(53936002)(486006)(6506007)(386003)(476003)(256004)(25786009)(4326008)(921003)(1121003)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4838;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: P6oqox4x9vHnqK69OXqXzdM1X6Y92zzDP2yRoHP9nAgPIe8ctzbmXgwugkOPTekCEh6I7YkZZu8CsdJ4VRnQfvuRpXd1/V1czglIzZZv+ZuGf+cq/lKLLniisj/osCwmBBMxzGF8DWlz6/3S3+wSXLp/+qQe6ktvoNDXnK9byu+q/q4pdltq8DWvqDU7q7dzbH4eJu6bP9OP3MzDT7UBOk4l4XRprQls9hGd6GklDKQGo9Nv/c+2PMd+LhRMDuDQmIFgLO1pKIxqgt0AbpBgJKvtpAjid9oxI8imebhN2uCDnzpgCcv0oHyGaLI22rpmD+vInmugR4sqgA7eaBNvSDLB4OYwDh2fEsSW8KOM7gxrvx+XvnTBxVOjAK6NBTkePIseC3rnNiNfFRGnoWh8K2Tnp5eSaRK+d+6OzKbm/tA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <419B39D67DED6746B89233CE29FB2E87@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d88841ae-1f36-46ca-44d6-08d724998573
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2019 11:36:48.6912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B9MBc/P1AMByozT6p/cgpsr1pdSR7atfz62QEH+qVJa7KJ4fL21S9THfTebOgrMWrC+EzpSXVOXOSKndaiJtuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4838
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is to make the kprobe_ftrace_handler() common, so we can move it
to common code in next patch.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 arch/x86/kernel/kprobes/ftrace.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/kprobes/ftrace.c b/arch/x86/kernel/kprobes/ftr=
ace.c
index 681a4b36e9bb..c2ad0b9259ca 100644
--- a/arch/x86/kernel/kprobes/ftrace.c
+++ b/arch/x86/kernel/kprobes/ftrace.c
@@ -28,9 +28,9 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned lon=
g parent_ip,
 	if (kprobe_running()) {
 		kprobes_inc_nmissed_count(p);
 	} else {
-		unsigned long orig_ip =3D regs->ip;
+		unsigned long orig_ip =3D instruction_pointer(regs);
 		/* Kprobe handler expects regs->ip =3D ip + 1 as breakpoint hit */
-		regs->ip =3D ip + sizeof(kprobe_opcode_t);
+		instruction_pointer_set(regs, ip + sizeof(kprobe_opcode_t));
=20
 		__this_cpu_write(current_kprobe, p);
 		kcb->kprobe_status =3D KPROBE_HIT_ACTIVE;
@@ -39,12 +39,13 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned l=
ong parent_ip,
 			 * Emulate singlestep (and also recover regs->ip)
 			 * as if there is a 5byte nop
 			 */
-			regs->ip =3D (unsigned long)p->addr + MCOUNT_INSN_SIZE;
+			instruction_pointer_set(regs,
+				(unsigned long)p->addr + MCOUNT_INSN_SIZE);
 			if (unlikely(p->post_handler)) {
 				kcb->kprobe_status =3D KPROBE_HIT_SSDONE;
 				p->post_handler(p, regs, 0);
 			}
-			regs->ip =3D orig_ip;
+			instruction_pointer_set(regs, orig_ip);
 		}
 		/*
 		 * If pre_handler returns !0, it changes regs->ip. We have to
--=20
2.23.0.rc1

