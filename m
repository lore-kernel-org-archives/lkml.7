Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB79C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 03:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DBE122CE8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 03:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="QaRLnHir"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbfHTDxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 23:53:34 -0400
Received: from mail-eopbgr710061.outbound.protection.outlook.com ([40.107.71.61]:30752
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728647AbfHTDxd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 23:53:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F7q68aOII07dbCPVlZDbWL/VA4WV1ZTem58jonRUwqBzHS6aArLR2z3ojB65Gr42V8jz5c7K57GjHQ1hU9OzvGNFdcmaGWobDRYPoOAjVVC+107PCj+5OFk52e7LNxpiYcc3bFUM71C+uHlGuAFQY4/6R609FGytneVCm3evn/CWemhT10GptLSBHSefj+hyZrcCFZCsRtvzB3kI1PsOEVyVC6eYE8A+PTRcSn6W/20R0WqazfuqF78jItRknEZBP303fKbBIiycOMK095IeZUWqSB68HhOp3WKYwLWUHltz57Nm4zACJjicW0CvHALJh3XjYDKvyV58004Ran1rFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M6liWGvIujiyKQMbDLvytJ2ECSW3hXjgw7Be6M5leWU=;
 b=JEC0j0jBv5Fvy8EjBUTePLjBwbl6oepnpYpRk0tFoNXQ2QIzP7D9w4AygVLjLjBn1WCh8vcScKLZY0AQGwhwNldgp/JSs7DjGawkoy9y/V4Um3DMDhpN3EH1VcD/IHAQU2jyDpMtk5dgYNqEFA73C6Zz26U3ByQB3AfW/1fNpUuUUMIXYOCltCne4zE/Ljq8Rs9yhc0XxNByB07FXl8DDDaEDKYJPVCgMJ+Drc7eSEjcLjWelOcEz5tPZHTNN/pkjG+uGKSuoHmwZ80CPgKycObYumWfoqBRZvuUCbqUP0yF2oTzvxJ/bRXGD4aYWQ4ZmtmNPnMoXwbDvtyvMhe/4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M6liWGvIujiyKQMbDLvytJ2ECSW3hXjgw7Be6M5leWU=;
 b=QaRLnHirbl599QEXr+mhGFW92RpiC3VmmFS76kctwTGFkyBquo5No4uLBhmQinsRWuHkSNHp2GLWPu37Cgay/MIRFETF8brueVBRgueDV5KHmm3Wk/kIquT9n9SZeULo5W1MxXIkTcZV8LCsC2i9WIZ+tcV1dINllIXucvCsCco=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB4870.namprd03.prod.outlook.com (20.179.93.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.16; Tue, 20 Aug 2019 03:53:31 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::a517:3578:67bf:6c88]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::a517:3578:67bf:6c88%7]) with mapi id 15.20.2157.022; Tue, 20 Aug 2019
 03:53:31 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
CC:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 2/3] kprobes: adjust kprobe addr for KPROBES_ON_FTRACE
Thread-Topic: [PATCH v2 2/3] kprobes: adjust kprobe addr for KPROBES_ON_FTRACE
Thread-Index: AQHVVwrVXMrB52r5zEm7ypsroIKAaw==
Date:   Tue, 20 Aug 2019 03:53:31 +0000
Message-ID: <20190820114224.0c8963c4@xhacker.debian>
References: <20190820113928.1971900c@xhacker.debian>
In-Reply-To: <20190820113928.1971900c@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TY1PR01CA0180.jpnprd01.prod.outlook.com (2603:1096:402::32)
 To BYAPR03MB4773.namprd03.prod.outlook.com (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 736b347f-b974-409b-2ee0-08d72521f77c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR03MB4870;
x-ms-traffictypediagnostic: BYAPR03MB4870:
x-microsoft-antispam-prvs: <BYAPR03MB48704C345D8BCC1042ACCAF5EDAB0@BYAPR03MB4870.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1417;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(136003)(346002)(39860400002)(376002)(366004)(396003)(189003)(199004)(6116002)(6486002)(3846002)(53936002)(76176011)(2906002)(6436002)(86362001)(1076003)(64756008)(71190400001)(6512007)(110136005)(9686003)(6506007)(71200400001)(54906003)(66066001)(5660300002)(4326008)(14454004)(316002)(52116002)(66556008)(476003)(7736002)(99286004)(446003)(2501003)(486006)(386003)(8676002)(81166006)(66946007)(256004)(478600001)(50226002)(102836004)(8936002)(26005)(305945005)(66446008)(66476007)(7416002)(186003)(11346002)(25786009)(81156014)(921003)(39210200001)(1121003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4870;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jCr85pMSBpZf/iiTBNOAhYnJ5xFbTKe8X4xtmJrxBD1sszI8fCBxWBiAAZX9NObyVHX+0xGGFib9crGswXfiAyEZap4+Qu6pIhDxPfj3DJZqVLRXBlWdJF7e44bp7C47xf705mr5vrPAtB7g9b4RNUc0RCZFENiZsBMTtfxdLsCYQab2+04ApIhLbHSaHl+VR77t10kDwbOTH98GZzJAhAHxceZimhePqoMUbaOtLc5NdKHNhxNt4pzVaTUywHXLxFxNuq6zPav10heXZVs8okBbQ74ogUlEqhtU3U0ijRx0jB0DkghlpPiZg2MLxJKl6zPV4B8ZbqcHnMmL9ok89/SjIgMGd7hNEuz3IvCWCz0yj1Cey5ykRdFwCKKPbwABmImQOCewNI+6xYv2etadp0BEEK0vrgUK/9mJkJNG8+A=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CBA4773DF0ABEF45A1A321C6C29F817F@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 736b347f-b974-409b-2ee0-08d72521f77c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 03:53:31.5622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DVcKL1qaCY64uLm1mYUqT7Zuz8nHg1XeXtugrzuWZIjXzbRfk1okiEyjk1Mmgnk+ZT7yxJtG433sq+cGKgSicg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4870
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For KPROBES_ON_FTRACE case, we need to adjust the kprobe's addr
correspondingly.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 kernel/kprobes.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 9873fc627d61..3fd2f68644da 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1484,15 +1484,19 @@ static inline int check_kprobe_rereg(struct kprobe =
*p)
=20
 int __weak arch_check_ftrace_location(struct kprobe *p)
 {
-	unsigned long ftrace_addr;
+	unsigned long ftrace_addr, addr =3D (unsigned long)p->addr;
=20
-	ftrace_addr =3D ftrace_location((unsigned long)p->addr);
+#ifdef CONFIG_KPROBES_ON_FTRACE
+	addr =3D ftrace_call_adjust(addr);
+#endif
+	ftrace_addr =3D ftrace_location(addr);
 	if (ftrace_addr) {
 #ifdef CONFIG_KPROBES_ON_FTRACE
 		/* Given address is not on the instruction boundary */
-		if ((unsigned long)p->addr !=3D ftrace_addr)
+		if (addr !=3D ftrace_addr)
 			return -EILSEQ;
 		p->flags |=3D KPROBE_FLAG_FTRACE;
+		p->addr =3D (kprobe_opcode_t *)addr;
 #else	/* !CONFIG_KPROBES_ON_FTRACE */
 		return -EINVAL;
 #endif
--=20
2.23.0.rc1

