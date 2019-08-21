Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678ABC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 05:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B75B22CE3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 05:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="UpS/fdGV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfHUFyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 01:54:05 -0400
Received: from mail-eopbgr750054.outbound.protection.outlook.com ([40.107.75.54]:3232
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725385AbfHUFyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 01:54:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a9xEvBWnaDKorHaCIGtWN551ZPW6VTUo7/QsvHTdkDG3Gbw5LoDytehICJlw6RfT7IwuVK7nswyyzED5IA0K/GYmGCmhJb5OJG5tKbVdLE+CJ0LFDP7hvRM0vhmyFR/fnatLYotY+JFUQyd6OZ2UC5uXxGHFLLUv+xkQq97yGcQKRceNRrwjR7ADsLLLwTmdNVwk9Zrb4nvnyihnN1MVeksymDd6jg7WxoI1Ea9PVVRvLStq6VXufsbcIxmvNdUGXN2T3nKxiWfGDO5lab2VQffSh1FczQ36h2/PLVFDg+4FzL2DAlBaIF/P6qLUfVbqvoQ3xyiCf0agFm4Dpvt8Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9JbMeUlRIfVfV57ePPUUyha9C6TMBOO8gbxEc7THhGQ=;
 b=Dsu8HzWXXFzi4rc/JMuHqDmi2zEh8BAmP796KYqz5qR5fbNvsY4Fh2AYm5SxNbP5RA7SkRe2lcPz2paPpzpJXB8uh5U942xARhcKNi0wUYsBHjTjcgtVt+cCbmdOn5YRCn2R10qbNJlDUM11joOA0YPlIYDgaB+pU+E8FIrOZYPCDNUl21Ne0GWjx9zsNaRFO5Tia/ptTkVh8TCbYUbByHyjau11wH224x0M3n7OgAtLJUn9Tho+6Vcz4I3k4d2eOfO3Xt9SayQH8JBHW39e2A04C6A50SDqr8LsGxPsllREF0YEEvfLygqBXK6cArb4Xl6hd3Rk/z6c11ODb2o0LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9JbMeUlRIfVfV57ePPUUyha9C6TMBOO8gbxEc7THhGQ=;
 b=UpS/fdGVGQ70SQI7slqxQUtWWJQhHmzkI/iGytmh71G3+LQSfhGCGCoAMtpFee/61165ECND+P+ABiO5sBPgOpx++LMwMmIk1pg2Kc/D0iLTMMxahBgRDKBPxss++iaCRKVcNbLfeZlV5GIG0WI66aKIC/zB3Az3Z/PjJ2SAEW8=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB4134.namprd03.prod.outlook.com (20.177.184.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Wed, 21 Aug 2019 05:54:01 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::a517:3578:67bf:6c88]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::a517:3578:67bf:6c88%7]) with mapi id 15.20.2157.022; Wed, 21 Aug 2019
 05:54:01 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: [PATCH] kprobes/x86: use instruction_pointer and
 instruction_pointer_set
Thread-Topic: [PATCH] kprobes/x86: use instruction_pointer and
 instruction_pointer_set
Thread-Index: AQHVV+TUwrb6uOjtvE6JCpjQy3YaDQ==
Date:   Wed, 21 Aug 2019 05:54:00 +0000
Message-ID: <20190821134244.2e0f248c@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TY2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:404:a6::31) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 67365847-2918-4c3c-bbc6-08d725fbf6cd
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR03MB4134;
x-ms-traffictypediagnostic: BYAPR03MB4134:
x-microsoft-antispam-prvs: <BYAPR03MB4134FA99FEAB5846BD9E8FEEEDAA0@BYAPR03MB4134.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(136003)(376002)(366004)(39860400002)(189003)(199004)(305945005)(1076003)(476003)(486006)(7736002)(99286004)(86362001)(66066001)(54906003)(316002)(110136005)(66556008)(66476007)(5660300002)(478600001)(14454004)(52116002)(66946007)(64756008)(66446008)(2906002)(25786009)(71190400001)(8676002)(50226002)(53936002)(71200400001)(6512007)(4326008)(3846002)(6116002)(9686003)(256004)(26005)(102836004)(6506007)(386003)(186003)(8936002)(6486002)(6436002)(81156014)(81166006)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4134;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BuY4ppQ+PRDhOaDh0YHbJEdXvt0eP5sDiPERRrlhCnAl/gLwKq3ZiAIxg7yxyhX57nNEPjIsLuVOSm3m8GRIxBt2o5OJHd/NsDNg7enWbyiSJmohUAsXY0PW7l1qPhni24ssT3+bo8l1O4RMtUFtthFSImeXOGG43N1ZUkoaeG9brpGTFX/rc2EWCiOf97mUt49wl4ZQM5BcNZosB4CpwkJZU/c7uzt8cy79tAe32ZMnmLAl2Ptz1W9AG3FVE18xpLGn6pREkGh7n4DxaJqQcUi7ylOrp/ztkGo9+ZhWD/jJz8pYlgpweDw3M0IS6p7sMgcfMoqFJQSJRO647boYesPGDUGHRpTSVe0HTndQTc2tJt0zHrWctWVyDyMs8VfsiD85mIPxP+yIJ7yy3Ah3m9uKoX7g0ht9TFrLutPPQPI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DEEE2F1A353C73418FF7608641C0974D@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67365847-2918-4c3c-bbc6-08d725fbf6cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 05:54:00.8039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ms4FktkfA1UWZOKd0ZB6K4IRMxaqlkwffD+Ahc1HuQ5+fQRw9Qdc/W1/MsgMJz9c/yT5IjgJaMW7upKKATF2tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use an arch-independent way to get/set the instruction pointer, we can
make the x86 kprobe_ftrace_handler() more common.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
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

