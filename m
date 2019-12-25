Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7115EC2D0DC
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 09:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 468072075B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 09:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="mdoO1Ok+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfLYJmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 04:42:11 -0500
Received: from mail-bn8nam11on2073.outbound.protection.outlook.com ([40.107.236.73]:63489
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726025AbfLYJmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 04:42:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GmDzoU6LfS9861GwusgyfGrjrU3lbkGZE+BEEsyfqcElBcBcq3SIovvoI8h4RtPiy4xTonIT5u5wSzqUTXtARAICkQbidXTLlRRcv9jWLx7PoMmDlkILqT+p9CbxFhSV5y+VuLqwJuGpUVN+zGgMwK5gsYDKBmdDKG9LlhgPHYDwxEr5DJa+6N6Hx4OMW7+bHWlqdDBa6YudH70vHfFf59Qrvhe/sfGnYMUVr9tlNhcNbdXMD3VObn6HROG6C1DyErazthygLUd2q7j1sXjsoo0++DHcjOCqs8qAkqlk/WFuveMyCT8ZdNaU+aoxWnLSprvy0ZLp+rzV/0n1z5L8Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILbzOurn3R6bsV0bRaBNRAdQHJ40b9HcElY3vUMCP8M=;
 b=FlNjpLEkMnrZRYmQ3Xd2ihGjAt97roUNI8rISZXk4rNXGn0IYSk3RZkPbntfc9WsbSmGWYpJXsn7wmewwjBIdbphTLNFdGwG2mQI2gLz3KRIYR0PBWDy2lxoFpITMbKDjVZCzgpI+Lif/MIAZrsWj3776svZ2yKt60teUsOJogz0ZJ9l7qQC6Vfi5w/99RyPDNaBEdaXlm2TXefSzKqFf/0y6tvZu/yiQsq706gi6fCMXhfykjsh+JZ3DWCTLB2a7kum3minon5zIZZuX7UK0Z/gB3uLo0qQYAkJ31fwfPK4ADDh2AGKewkCB0X172BgWBor+TfRPV9fFlMKQ9zV2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILbzOurn3R6bsV0bRaBNRAdQHJ40b9HcElY3vUMCP8M=;
 b=mdoO1Ok+O6dK+kPx9NkC7cOAOp+PVixC6acesVQdcdv2lS5us+VdFxjZfD6ZirQWaDolDT+K6dQT3jsgQSgSB1XQMnEn8DAyCwnl+cJCkBKor4LFgGkaGYsQxPLvRdE6WV0pldhD3ZKYXkraX20sTFBeRJ5am0LbKEm5H+qKyhE=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.93.213) by
 BYAPR03MB4661.namprd03.prod.outlook.com (20.179.91.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.11; Wed, 25 Dec 2019 09:42:07 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::708d:91cc:79a7:9b9a]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::708d:91cc:79a7:9b9a%6]) with mapi id 15.20.2559.017; Wed, 25 Dec 2019
 09:42:07 +0000
Received: from xhacker.debian (124.74.246.114) by TYAPR01CA0196.jpnprd01.prod.outlook.com (2603:1096:404:29::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.11 via Frontend Transport; Wed, 25 Dec 2019 09:42:04 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: [PATCH v7 1/3] kprobes/ftrace: Use ftrace_location() when [dis]arming
 probes
Thread-Topic: [PATCH v7 1/3] kprobes/ftrace: Use ftrace_location() when
 [dis]arming probes
Thread-Index: AQHVuweSj3f0oMePuk6TgrRxmwYaVQ==
Date:   Wed, 25 Dec 2019 09:42:07 +0000
Message-ID: <20191225172752.70be1dc1@xhacker.debian>
References: <20191225172625.69811b3e@xhacker.debian>
In-Reply-To: <20191225172625.69811b3e@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TYAPR01CA0196.jpnprd01.prod.outlook.com
 (2603:1096:404:29::16) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:139::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0fce643c-9505-4d9c-7898-08d7891eb4e6
x-ms-traffictypediagnostic: BYAPR03MB4661:
x-microsoft-antispam-prvs: <BYAPR03MB46618FBE261292300FE1820CED280@BYAPR03MB4661.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02622CEF0A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(396003)(39850400004)(366004)(189003)(199004)(1076003)(81166006)(26005)(81156014)(55016002)(9686003)(8936002)(4326008)(186003)(7696005)(66946007)(86362001)(16526019)(8676002)(478600001)(52116002)(66556008)(6506007)(66446008)(64756008)(66476007)(956004)(110136005)(54906003)(7416002)(316002)(5660300002)(2906002)(71200400001)(921003)(1121003)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4661;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iIDb2lOmzzDlxYnZeyTCHC3IYK4mua/N1x0+UwRDYs8KKGunuBNNy4C7CxyD6hY97nJ6ur7cRkPjDW6xDGqUZkx5g6M3aRZDYM3FmlcqaCPAugp5M823a2wF91+rXCV4nY+K55LlwJXT9Yu24ftf19evsO7WrXC+q6DsvVBCbC3Mtmda4KqTQ99rJHka9rNE5QoCanCEcwzevEp2v+8Ufv16PiKbNgYNCAt0aZsj8N6gRHgFP+wPu1lw0ui9Mjy6l7U5KeanfNIScgpgB+lNr5tQJDn5bL7ZpyqWT/dJjzww3xafexbhEWp5CUHegNiwKQOV49lVbdulpyk0mAmxLRvZ8wyjjAQ+F91P6FywEVcEvFUhJQ5nR2L9ui0fat5dApiCvkJ7qK46RZzq7DAolKv21AYdaFf3pqPqyKnZbcmYHO2/FOwyJCuaokTM4r7hL5UXluy+CCl+HfbB70Bje0sf99IfaHV38Ycz0bFu79dozYT9J6v68h4qTS2Vs5THBHOmv7SctDzeDGt7BOcCIVNhq61ceYDw2jcLbDWLoSk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BBF16021EF076B4CBB9FBDA82B40A34C@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fce643c-9505-4d9c-7898-08d7891eb4e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Dec 2019 09:42:07.5320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pMJT/VD22Zhwy7J2nasGbiPwPwvKs/0auBK8J+jYjxEnY3P/yBSIA2TxKNi0SlJPvLwH/dRU0fGYABQ/8GJ18Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4661
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ftrace location could include more than a single instruction in case
of some architectures (powerpc64, for now). In this case, kprobe is
permitted on any of those instructions, and uses ftrace infrastructure
for functioning.

However, [dis]arm_kprobe_ftrace() uses the kprobe address when setting
up ftrace filter IP. This won't work if the address points to any
instruction apart from the one that has a branch to _mcount(). To
resolve this, have [dis]arm_kprobe_ftrace() use ftrace_function() to
identify the filter IP.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/kprobes.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 53534aa258a6..5c630b424e3a 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -986,9 +986,10 @@ static int prepare_kprobe(struct kprobe *p)
 static int __arm_kprobe_ftrace(struct kprobe *p, struct ftrace_ops *ops,
 			       int *cnt)
 {
+	unsigned long ftrace_ip =3D ftrace_location((unsigned long)p->addr);
 	int ret =3D 0;
=20
-	ret =3D ftrace_set_filter_ip(ops, (unsigned long)p->addr, 0, 0);
+	ret =3D ftrace_set_filter_ip(ops, ftrace_ip, 0, 0);
 	if (ret) {
 		pr_debug("Failed to arm kprobe-ftrace at %pS (%d)\n",
 			 p->addr, ret);
@@ -1011,7 +1012,7 @@ static int __arm_kprobe_ftrace(struct kprobe *p, stru=
ct ftrace_ops *ops,
 	 * At this point, sinec ops is not registered, we should be sefe from
 	 * registering empty filter.
 	 */
-	ftrace_set_filter_ip(ops, (unsigned long)p->addr, 1, 0);
+	ftrace_set_filter_ip(ops, ftrace_ip, 1, 0);
 	return ret;
 }
=20
@@ -1028,6 +1029,7 @@ static int arm_kprobe_ftrace(struct kprobe *p)
 static int __disarm_kprobe_ftrace(struct kprobe *p, struct ftrace_ops *ops=
,
 				  int *cnt)
 {
+	unsigned long ftrace_ip =3D ftrace_location((unsigned long)p->addr);
 	int ret =3D 0;
=20
 	if (*cnt =3D=3D 1) {
@@ -1038,7 +1040,7 @@ static int __disarm_kprobe_ftrace(struct kprobe *p, s=
truct ftrace_ops *ops,
=20
 	(*cnt)--;
=20
-	ret =3D ftrace_set_filter_ip(ops, (unsigned long)p->addr, 1, 0);
+	ret =3D ftrace_set_filter_ip(ops, ftrace_ip, 1, 0);
 	WARN_ONCE(ret < 0, "Failed to disarm kprobe-ftrace at %pS (%d)\n",
 		  p->addr, ret);
 	return ret;
--=20
2.24.1

