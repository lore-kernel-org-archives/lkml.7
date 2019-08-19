Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65ED9C3A5A1
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F2E72087B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="d+ejuGhh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbfHSLhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 07:37:38 -0400
Received: from mail-eopbgr810071.outbound.protection.outlook.com ([40.107.81.71]:58709
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726594AbfHSLhh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 07:37:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUNXTWKleVn7T8Y3aSg8Hsyt3ru+36stIpcteUDh7YrvQoxQUKjA8tRqU7BOR663f4JA25Mxh7yZ4UpM8Ap6vYcK3jBHmMmCAFGHOnMhQeHWoUt27HgDJMCg2Z5SqRyVc4Tgncvm2EkaG4KKYHjHa+nOqz1ukw5n9szFa6QC8i9cFeiobLsYARAUu6xsynvV57SiZGGOoPoOyzssn4y3ytCRojEUXPhAsJu9fmV7832H9GRKUO8abuhcDLqVXHzBxJTo6yO6CIoxEZ+4cdDgBRolSgjrwnKT91fpVx3yIbezVAhpMqy88U7tUCW5TptTw7QH8fz4ZRO0VCvCjxlaPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YM3xBnJ1INaBk35kehltk+eqEHmnTVISIfM2FGZwnfw=;
 b=aY6wzCyPzFl7NtfI7Mgnmxe5c1MJqRnZEwwM8fhB2kzhqMmeIO2bToYZV0nraJJzX9RKaLjSXzAhxgQdT4ze7WIwON7fb/ap2wV4kDm/mtRaJu+lTU46gtlhKPuKjtkAR58yATXBd4ZyzNfEgWz2xqDGJ6oDb+p2SGmHslrmPJ3tB5tTIUgq+iDcSxqBK4RopHO4BKDwmE/FrcdfnPzr/IJZKfCfUXVIjL2bi6x+OBcJ0gDPDFNCOJyh7OSqGOnNuOPrmk+FYfsGg8KU3Elj7xbV+P7PTyhshBe8ISmkbJI0ifuhrb/EM0NBI66NpaCdpfavkoHZFHOG18ZQgvwAAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YM3xBnJ1INaBk35kehltk+eqEHmnTVISIfM2FGZwnfw=;
 b=d+ejuGhhe4XzPeCsH+BSgN1nR02RsHHs6X3xqsH0enKVLOgXeFcD166b+fcCg0Wf4JuOfRWYsRTkQgYPxIIjfklWSNpop3gkZXTq+qNFw8g76LWa3Tq0BhSfPsr7hcSaUY4c1o8MqLw/7oPui1z/tMZtZ5MvHCy0lZYVwuOt0ng=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB4838.namprd03.prod.outlook.com (20.179.93.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Mon, 19 Aug 2019 11:37:33 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::a517:3578:67bf:6c88]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::a517:3578:67bf:6c88%7]) with mapi id 15.20.2157.022; Mon, 19 Aug 2019
 11:37:33 +0000
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
Subject: [PATCH 3/4] kprobes: move kprobe_ftrace_handler() from x86 and make
 it weak
Thread-Topic: [PATCH 3/4] kprobes: move kprobe_ftrace_handler() from x86 and
 make it weak
Thread-Index: AQHVVoJ9EHFo1XzjbE6QP8I8uro18g==
Date:   Mon, 19 Aug 2019 11:37:32 +0000
Message-ID: <20190819192628.5f550074@xhacker.debian>
References: <20190819192422.5ed79702@xhacker.debian>
In-Reply-To: <20190819192422.5ed79702@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TY1PR01CA0148.jpnprd01.prod.outlook.com
 (2603:1096:402:1::24) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af81900f-3397-4dd7-3103-08d724999fcc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR03MB4838;
x-ms-traffictypediagnostic: BYAPR03MB4838:
x-microsoft-antispam-prvs: <BYAPR03MB483852E1B9539E3DE9FCE75DEDA80@BYAPR03MB4838.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0134AD334F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(396003)(136003)(39860400002)(189003)(199004)(7736002)(6116002)(186003)(66476007)(66556008)(81166006)(64756008)(66446008)(8676002)(66946007)(81156014)(305945005)(256004)(25786009)(6506007)(386003)(476003)(4326008)(14444005)(446003)(6512007)(1076003)(102836004)(9686003)(26005)(486006)(53936002)(11346002)(66066001)(2906002)(478600001)(86362001)(71200400001)(7416002)(316002)(50226002)(99286004)(6486002)(52116002)(54906003)(6436002)(8936002)(14454004)(3846002)(76176011)(5660300002)(71190400001)(110136005)(921003)(39210200001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4838;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TRbGHV/bNSK9gR/7lLolSXh0Btevan+hOMNQeRQJWQSEr5JVuMvOaxhLsN/YHPkEwCCmFk0juIlkddlPTbosuOSnFsKuSfg1Y+Prb/4jAwin+oOkGIXSW+p9rhjpvEPWLHYPo0Jv8pAh018pSIMdIzZKPyML8XHxqb98e6Gqw7wNQV72lRDF6VZH4CUWYqG/LbLQZ3Y92Gmq6p3EcgMmK8hjfihsOjA1BMTSOtiWQjW2bzcUKcpPrduDEMqHR3ROkqBWhr129Bwjbgz2oTXMbqYfPGbpTCfnT1jw/J6u6BYh5kj+BCq4fpfx8JQ6+SdUN4O1e1zlbrsrFzfiynTi0XuLzfXo3FmbxUx/hj+xIUEMv4NQhH1FbEeJAM/Yx297k6Rk+i57tF9i2S7RqGxBfADJvfhyjN7eOKVXxYG7zOs=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <54801A62D85C784CAA892ABC7B87B5E2@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af81900f-3397-4dd7-3103-08d724999fcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2019 11:37:32.9008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ujeHGpVVncm+KeVzATZe2w8Z2tYaOh0c+2sQ8S5/KE9RbOhfmQmUr78xJKUYw14foNUi7DvOFCamaBa9V129bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4838
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code could be reused. So move it from x86 to common code.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 arch/x86/kernel/kprobes/ftrace.c | 44 --------------------------------
 kernel/kprobes.c                 | 44 ++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/arch/x86/kernel/kprobes/ftrace.c b/arch/x86/kernel/kprobes/ftr=
ace.c
index c2ad0b9259ca..91ae1e3e65f7 100644
--- a/arch/x86/kernel/kprobes/ftrace.c
+++ b/arch/x86/kernel/kprobes/ftrace.c
@@ -12,50 +12,6 @@
=20
 #include "common.h"
=20
-/* Ftrace callback handler for kprobes -- called under preepmt disabed */
-void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
-			   struct ftrace_ops *ops, struct pt_regs *regs)
-{
-	struct kprobe *p;
-	struct kprobe_ctlblk *kcb;
-
-	/* Preempt is disabled by ftrace */
-	p =3D get_kprobe((kprobe_opcode_t *)ip);
-	if (unlikely(!p) || kprobe_disabled(p))
-		return;
-
-	kcb =3D get_kprobe_ctlblk();
-	if (kprobe_running()) {
-		kprobes_inc_nmissed_count(p);
-	} else {
-		unsigned long orig_ip =3D instruction_pointer(regs);
-		/* Kprobe handler expects regs->ip =3D ip + 1 as breakpoint hit */
-		instruction_pointer_set(regs, ip + sizeof(kprobe_opcode_t));
-
-		__this_cpu_write(current_kprobe, p);
-		kcb->kprobe_status =3D KPROBE_HIT_ACTIVE;
-		if (!p->pre_handler || !p->pre_handler(p, regs)) {
-			/*
-			 * Emulate singlestep (and also recover regs->ip)
-			 * as if there is a 5byte nop
-			 */
-			instruction_pointer_set(regs,
-				(unsigned long)p->addr + MCOUNT_INSN_SIZE);
-			if (unlikely(p->post_handler)) {
-				kcb->kprobe_status =3D KPROBE_HIT_SSDONE;
-				p->post_handler(p, regs, 0);
-			}
-			instruction_pointer_set(regs, orig_ip);
-		}
-		/*
-		 * If pre_handler returns !0, it changes regs->ip. We have to
-		 * skip emulating post_handler.
-		 */
-		__this_cpu_write(current_kprobe, NULL);
-	}
-}
-NOKPROBE_SYMBOL(kprobe_ftrace_handler);
-
 int arch_prepare_kprobe_ftrace(struct kprobe *p)
 {
 	p->ainsn.insn =3D NULL;
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index f8400753a8a9..479148ee1822 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -960,6 +960,50 @@ static struct kprobe *alloc_aggr_kprobe(struct kprobe =
*p)
 #endif /* CONFIG_OPTPROBES */
=20
 #ifdef CONFIG_KPROBES_ON_FTRACE
+/* Ftrace callback handler for kprobes -- called under preepmt disabed */
+void __weak kprobe_ftrace_handler(unsigned long ip, unsigned long parent_i=
p,
+				  struct ftrace_ops *ops, struct pt_regs *regs)
+{
+	struct kprobe *p;
+	struct kprobe_ctlblk *kcb;
+
+	/* Preempt is disabled by ftrace */
+	p =3D get_kprobe((kprobe_opcode_t *)ip);
+	if (unlikely(!p) || kprobe_disabled(p))
+		return;
+
+	kcb =3D get_kprobe_ctlblk();
+	if (kprobe_running()) {
+		kprobes_inc_nmissed_count(p);
+	} else {
+		unsigned long orig_ip =3D instruction_pointer(regs);
+		/* Kprobe handler expects regs->ip =3D ip + 1 as breakpoint hit */
+		instruction_pointer_set(regs, ip + sizeof(kprobe_opcode_t));
+
+		__this_cpu_write(current_kprobe, p);
+		kcb->kprobe_status =3D KPROBE_HIT_ACTIVE;
+		if (!p->pre_handler || !p->pre_handler(p, regs)) {
+			/*
+			 * Emulate singlestep (and also recover regs->ip)
+			 * as if there is a 5byte nop
+			 */
+			instruction_pointer_set(regs,
+				(unsigned long)p->addr + MCOUNT_INSN_SIZE);
+			if (unlikely(p->post_handler)) {
+				kcb->kprobe_status =3D KPROBE_HIT_SSDONE;
+				p->post_handler(p, regs, 0);
+			}
+			instruction_pointer_set(regs, orig_ip);
+		}
+		/*
+		 * If pre_handler returns !0, it changes regs->ip. We have to
+		 * skip emulating post_handler.
+		 */
+		__this_cpu_write(current_kprobe, NULL);
+	}
+}
+NOKPROBE_SYMBOL(kprobe_ftrace_handler);
+
 static struct ftrace_ops kprobe_ftrace_ops __read_mostly =3D {
 	.func =3D kprobe_ftrace_handler,
 	.flags =3D FTRACE_OPS_FL_SAVE_REGS | FTRACE_OPS_FL_IPMODIFY,
--=20
2.23.0.rc1

