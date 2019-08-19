Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B235FC3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7979A2086C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="ZXR0UYE5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbfHSLiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 07:38:52 -0400
Received: from mail-eopbgr770057.outbound.protection.outlook.com ([40.107.77.57]:35790
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726594AbfHSLiw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 07:38:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aYdZV28e+L359dxaYpvoVlGs5//GPoYgjhC3G59oFoGaPJo8jGNmbXTZUGuXeKKV/6bi+zttoQ43sWcAyAz0UXksT73NK658Mb3ZkjF7ZI0Oiw59dXublgWmsD7nPlB2UcwuJbMh5GNJeay7IyJBjm6LkKPi1a7w6Y8ojnYm2CP3dnpn8fsEhLqRqk1cP0n+g4ERoF8s4rr3W+sjDtbh0fKVWtMh8Sgb55G2V4ARd7rU/cME6SBb9dLD7E1yAqpg1L+2uoV6PyJKqA3u9Ks9aGtIfkg7hV//7IBlULx6IvjbDCn5kFOCAMn9csQTPI6NEtMYq7HPg7YcSoW0RetI3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHV4Bmuw5aXp3ktT0yj9WugDe8VRvEdaGtvYNAk1kkU=;
 b=cV5BQwQcdlwKzaJ1z2sqymHLx9I4i3UxNSV2KnOOs9bnNhjzU3pG0iNZ5Z38aMyU7RDVtJz/cQBobxVCytUer/EOQHiq1XmucaCtyNIi4ZPfD21JWAklvQTwzhFtS6M/ipEf0OZjO+fnnuJi1D/eyx9x5Z7YMlGgJABijoOId2Y/HyDMCOPlAep8Np03bAUjncAqM7h0K7TlLZ8U65sP7r8yGWvbokjuFhUHBVw9uZhtF05NRYVkILY+uVaItrjskOkyQm7qRc7eygGIdh6j/ydJTbRAeCCh6T9ShrEJaNiUlA5bYL3H0O38yYxUaEp2HFT/NLn8muiR2E5Wk1aphQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHV4Bmuw5aXp3ktT0yj9WugDe8VRvEdaGtvYNAk1kkU=;
 b=ZXR0UYE50UsiMsQpfsS+Os2Dbqa4Bu2eRgIz3DWkagoJ0WNnD7PnBZbkKHH2FrfUxuww9AmIlSvC2lDjm2h40ys7eMMYjGlyEipewkhMCVIerm0D/k+DHGl1guXP58epCemp4ZD2mKnGbTFX7dK4A2r0ilcmbzpp4p+PJNmX3zs=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB4838.namprd03.prod.outlook.com (20.179.93.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Mon, 19 Aug 2019 11:38:10 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::a517:3578:67bf:6c88]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::a517:3578:67bf:6c88%7]) with mapi id 15.20.2157.022; Mon, 19 Aug 2019
 11:38:10 +0000
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
Subject: [PATCH 4/4] arm64: implement KPROBES_ON_FTRACE
Thread-Topic: [PATCH 4/4] arm64: implement KPROBES_ON_FTRACE
Thread-Index: AQHVVoKTiZqAlY6xIUan+odTmeZEhQ==
Date:   Mon, 19 Aug 2019 11:38:10 +0000
Message-ID: <20190819192706.46ce2c1d@xhacker.debian>
References: <20190819192422.5ed79702@xhacker.debian>
In-Reply-To: <20190819192422.5ed79702@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TY1PR01CA0165.jpnprd01.prod.outlook.com (2603:1096:402::17)
 To BYAPR03MB4773.namprd03.prod.outlook.com (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e69a950a-5303-4eab-cd33-08d72499b63b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR03MB4838;
x-ms-traffictypediagnostic: BYAPR03MB4838:
x-microsoft-antispam-prvs: <BYAPR03MB48387BA42F0F1557763FCCB5EDA80@BYAPR03MB4838.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 0134AD334F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(396003)(136003)(39860400002)(189003)(199004)(7736002)(6116002)(186003)(66476007)(66556008)(81166006)(64756008)(66446008)(8676002)(66946007)(81156014)(305945005)(256004)(25786009)(6506007)(386003)(476003)(4326008)(14444005)(446003)(6512007)(1076003)(102836004)(9686003)(26005)(486006)(53936002)(11346002)(66066001)(2906002)(478600001)(86362001)(71200400001)(7416002)(316002)(50226002)(99286004)(6486002)(52116002)(54906003)(6436002)(8936002)(14454004)(3846002)(76176011)(5660300002)(71190400001)(110136005)(921003)(39210200001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4838;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JVAhzXWGN+RHNc5sOrfygaEeAi90DmW3gKjSTZ7y3PMaw75YOp+qRa6jH0mL8qr4Inja3mngQBfjnh2zbMJs6mJTy6YkUyosKepIH9ZrJaZ34rYrLEOZivrGLcE2yKmu8YXwhfBbmQ1LvF5GLRVmzCGQ6LgQHXPKL3dmnyJYMqEKYgDKMPZnPe8wvcCm087vZCMRTfnfO/JqH2xoGOUtQwgWC7u4HWsEzP58eOHHUXcNHLkP6ePDw5gv/GHgNzfZcOPgMP6qySyEyLKmR1zQ5nEZ3g0CN79bBTJ+FnlSSTmH58JaJidytGtuPR0gI312OHAPvVLe/swV7FLFtO/S89M8AX3wEXvJE8kv49kHuRqgi9r13fez44SpmmQ0mS4pIo/t0lvLm/WH/7FQ2kZYXmtwgm3KVL+LBzkG6AtMsKM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6ADBF4E009D87B44808092E8A8277FF1@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e69a950a-5303-4eab-cd33-08d72499b63b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2019 11:38:10.4321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bAR38t0jHpjA95jDiMRnkkUWTpnf0slOKUzMXKeUA3EI90k9ZG6llx7XRvpDUKvm4qBfQNdvVkuzPehIV76Yqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4838
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements KPROBES_ON_FTRACE for arm64.

~ # mount -t debugfs debugfs /sys/kernel/debug/
~ # cd /sys/kernel/debug/
/sys/kernel/debug # echo 'p _do_fork' > tracing/kprobe_events

before the patch:

/sys/kernel/debug # cat kprobes/list
ffffff801009ff7c  k  _do_fork+0x4    [DISABLED]

after the patch:

/sys/kernel/debug # cat kprobes/list
ffffff801009ff7c  k  _do_fork+0x4    [DISABLED][FTRACE]

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 arch/arm64/Kconfig                |  1 +
 arch/arm64/kernel/probes/Makefile |  1 +
 arch/arm64/kernel/probes/ftrace.c | 16 ++++++++++++++++
 3 files changed, 18 insertions(+)
 create mode 100644 arch/arm64/kernel/probes/ftrace.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 663392d1eae2..928700f15e23 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -167,6 +167,7 @@ config ARM64
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_KPROBES
+	select HAVE_KPROBES_ON_FTRACE
 	select HAVE_KRETPROBES
 	select HAVE_GENERIC_VDSO
 	select IOMMU_DMA if IOMMU_SUPPORT
diff --git a/arch/arm64/kernel/probes/Makefile b/arch/arm64/kernel/probes/M=
akefile
index 8e4be92e25b1..4020cfc66564 100644
--- a/arch/arm64/kernel/probes/Makefile
+++ b/arch/arm64/kernel/probes/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_KPROBES)		+=3D kprobes.o decode-insn.o	\
 				   simulate-insn.o
 obj-$(CONFIG_UPROBES)		+=3D uprobes.o decode-insn.o	\
 				   simulate-insn.o
+obj-$(CONFIG_KPROBES_ON_FTRACE)	+=3D ftrace.o
diff --git a/arch/arm64/kernel/probes/ftrace.c b/arch/arm64/kernel/probes/f=
trace.c
new file mode 100644
index 000000000000..1fe8f105e02e
--- /dev/null
+++ b/arch/arm64/kernel/probes/ftrace.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Dynamic Ftrace based Kprobes Optimization
+ *
+ * Copyright (C) 2019 Synaptics Incorporated
+ *
+ * Author: Jisheng Zhang <jszhang@kernel.org>
+ */
+
+#include <linux/kprobes.h>
+
+int arch_prepare_kprobe_ftrace(struct kprobe *p)
+{
+	p->ainsn.api.insn =3D NULL;
+	return 0;
+}
--=20
2.23.0.rc1

