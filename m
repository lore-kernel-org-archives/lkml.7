Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E954C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 03:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14E57216F4
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 03:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="a8zC5qgk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbfHTDw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 23:52:58 -0400
Received: from mail-eopbgr680042.outbound.protection.outlook.com ([40.107.68.42]:15864
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728647AbfHTDw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 23:52:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fpRyCxWibq62LWZw13MQWuRY3HgprpFLMOZCYXZFVR+EhzVh1BEMKNLfXdH8afh4srgunnfwGdfJm4D+qEqvenHNUB3AeYEfKfKskcNISoc5WCHalCIwPl+EWYHRXNM54QUmAt2u+97mFBH3uLCosr0m0zwg0eQ3oN5NJX+aYyD2C4eIJZoiRw+IYgg/Xaz88H+lQh6tboQqvyn9NutSHFgvCyQ+QnvDgeNVBZixUn3WKbYlX6yefezJFKECQnXgoDVEaYWnevM4SK0YXdooqI1J1fipBvUYSgpFZk9RAq9llMefsJrQh1SsAfVUXYi5Dbki6v8S6M5VkDN0XHBgwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XMKnhsML/1Uy9u2aqC1p0utqYye/7YKAWdCMjGB4d0I=;
 b=CBBI12H8J0J4cXldOGV4t9fu+q1FW+byT+Y5cQdImEDZz+Tr4vH2ts9LLiQgx0/tESJnZpvi43FNuyGXKVDIvND+Fb5rYqQfJb21nepShApurvt5PRK/rcHJHFE49/y7phiapd7hsCn2yvFysW1BRUaDILtcjRYcevQ1yGnVT3S7IYZQGJRfcqF9WKpmzjhFqHJrmEiiHLyGnO/rVwoowKOHbansISjHU0FWUoWxr/DJH2cWsf3Ys5PqLPXiOIGzEcrbIHZLQ7r51UGbweW4jOzPVMOA8cM//4HzL8VXYB6RoEdvngVF+tWcwA1Ag54+kRY4uRHMsqAMx9byyJcOSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XMKnhsML/1Uy9u2aqC1p0utqYye/7YKAWdCMjGB4d0I=;
 b=a8zC5qgkD9vagJmeSo1UfASI3tSdEcohdFC85pY1Ovb9H+mlJ45llFtilX7dQY+wMi1DO/KcysDt7T47g/ufNYdTDbQc+m72HfTw/nMl+EqVsjKF4Fqb09Zwkf5A0WStzMdnaDQresUBax2QHFns92dVUm1TsgD112kHh5S44Lo=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB4373.namprd03.prod.outlook.com (20.178.48.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Tue, 20 Aug 2019 03:52:15 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::a517:3578:67bf:6c88]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::a517:3578:67bf:6c88%7]) with mapi id 15.20.2157.022; Tue, 20 Aug 2019
 03:52:15 +0000
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
Subject: [PATCH v2 1/3] kprobes/x86: use instruction_pointer and
 instruction_pointer_set
Thread-Topic: [PATCH v2 1/3] kprobes/x86: use instruction_pointer and
 instruction_pointer_set
Thread-Index: AQHVVwqnz3HRGv5g102l5gAICz+hHg==
Date:   Tue, 20 Aug 2019 03:52:15 +0000
Message-ID: <20190820114109.4624d56b@xhacker.debian>
References: <20190820113928.1971900c@xhacker.debian>
In-Reply-To: <20190820113928.1971900c@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TYAPR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:404:15::15) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e8b7161-0dc1-4479-6300-08d72521ca2a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR03MB4373;
x-ms-traffictypediagnostic: BYAPR03MB4373:
x-microsoft-antispam-prvs: <BYAPR03MB4373E0CDA0220226BA1111DFEDAB0@BYAPR03MB4373.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(39860400002)(346002)(376002)(199004)(189003)(316002)(6506007)(102836004)(25786009)(6486002)(8676002)(2501003)(486006)(476003)(71190400001)(71200400001)(305945005)(6116002)(3846002)(7736002)(186003)(1076003)(386003)(86362001)(446003)(11346002)(26005)(76176011)(7416002)(52116002)(110136005)(54906003)(81166006)(14454004)(9686003)(5660300002)(66946007)(256004)(8936002)(66446008)(64756008)(81156014)(53936002)(66556008)(99286004)(66476007)(66066001)(478600001)(4326008)(2906002)(50226002)(6512007)(6436002)(921003)(1121003)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4373;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3zRdRfhn4+IFxp3erj4gfrCkjT/dslFPe0psUFfB7/IGubdNv8AgAST1mUZRgadzIL9U2u17OO5j/fMn4sZtoRG0ytlvgxfXqa6LsU50ZKLhl18HTImOEggCLfpCAMkh5ob1D6imFoV6TeteXPTzhkBp+jNiOSkCEviR10eP9ecMvZPhU4sLnvFmKW8vAHthWrH62bX3HLBd5rmHewYfHZxkfZO31XoaWaVHA76Lwk/XyireOT38MzD0U1UMcnZlFg6skZQUsX449GA/gB5Ilg8Tf/zSpzIyFep31TjFox4pLTe98Lv1N/9esR/do6h7kaAHzNHy0HAOUIrvmSoQFM4eJPLsWeVLxbNmT91/Fic6zozVjAaxxMKbkmjk0te7Fvp3rxpRM8vnpw26gMkmuHmltHouIHGe+SZsA60Fo3o=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5E08BC2CF7D78542AF964F0A198BE2FA@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e8b7161-0dc1-4479-6300-08d72521ca2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 03:52:15.5396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b1CWmgtcA0yFo10LmO/c2gE5e6borOYUHeyF/BSsKh4auGGqkLj7MbHwLSaAIsRWZL9Jo3GATo2D/47Wz/RFCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4373
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is to make the x86 kprobe_ftrace_handler() more common so that
the code could be reused in future.

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

