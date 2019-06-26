Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139DBC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 11:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E5D8204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 11:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lMktFmMm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfFZLuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 07:50:22 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:59595 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfFZLuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 07:50:21 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190626115018epoutp022435649e5995fa1af67615789ade8274~rvUlpIcMc3171831718epoutp02Z
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 11:50:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190626115018epoutp022435649e5995fa1af67615789ade8274~rvUlpIcMc3171831718epoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561549818;
        bh=Rkq7DEDyErtaZQ8jeJ0L+lufdkPG1uI6401iyLHsv3s=;
        h=From:To:Cc:Subject:Date:References:From;
        b=lMktFmMmpC9cnTeTeebrFpZNJvz3XYN5vUWbczhj1sE22mLWqXzHKBqkq0zwV3dez
         DBC64eZHXTjxt1l94tx51/G3koNUnVSui8UDDpQrEsDgmoBMf/HCkAKcd8BSTEc/OU
         eTfmwgvY+HkP5CEoIsUwcoxl1FpH69WMsnxbJdvQ=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.160]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190626115017epcas1p2c401e841486df141df1ab3299aec1312~rvUkGlQgI1331813318epcas1p2E;
        Wed, 26 Jun 2019 11:50:17 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        DE.E8.04143.9FB531D5; Wed, 26 Jun 2019 20:50:17 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190626115016epcas1p455530417de86ea2e72ce1b389ae57a75~rvUjyoO-z2980629806epcas1p46;
        Wed, 26 Jun 2019 11:50:16 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190626115016epsmtrp1bef4df790f9b038e22d782e1acac33fe~rvUjvT_Od3121131211epsmtrp12;
        Wed, 26 Jun 2019 11:50:16 +0000 (GMT)
X-AuditID: b6c32a37-f19ff7000000102f-32-5d135bf91632
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        16.82.03692.8FB531D5; Wed, 26 Jun 2019 20:50:16 +0900 (KST)
Received: from U16PB1-0090.tn.corp.samsungelectronics.net (unknown
        [10.253.235.20]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190626115016epsmtip1685a43fa3697a0ca0619d3c3da2d53e4~rvUjg8Oa92836328363epsmtip1V;
        Wed, 26 Jun 2019 11:50:16 +0000 (GMT)
From:   jinho lim <jordan.lim@samsung.com>
To:     will.deacon@arm.com
Cc:     mark.rutland@arm.com, ebiederm@xmission.com, marc.zyngier@arm.com,
        anshuman.khandual@arm.com, andreyknvl@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        seroto7@gmail.com, jinho lim <jordan.lim@samsung.com>
Subject: [PATCH v3] arm64: rename dump_instr as dump_kernel_instr
Date:   Wed, 26 Jun 2019 20:50:13 +0900
Message-Id: <20190626115013.13044-1-jordan.lim@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTURz27O7lY3WZPU6j1G4FKU53ndNbqRmJXMjCECSrsS7z4MS92t0k
        I2pQaMh6CEVoWiOblUmaLZnO1JagPawsykKj7PFHkYZa9lCrzavUf9/5zved7+N3fmJMOiaQ
        iQuNVmQxMnpCGMJvuRMtl//cFa5WfPkpoBzeVh7V0aul/rQcEVEv6nKp5nfPBdTTtmohNTP0
        W0i5Bvp51ERdKZ/6ONbLTw+hG841ALq16pWIdjbb6BsXD9HH3fWAnmiOoE/5yvjZop36FB1i
        8pElChm1pvxCY0EqsSVHs1mjSlKQcnIdlUxEGRkDSiUysrLlmYV6fzciqpjR2/xUNsOyRHxa
        isVks6IonYm1phLInK83kwpzHMsYWJuxIE5rMqwnFYoElV+5R69zPRoDZt/CfX3vvwnswBNW
        DoLFEE+EtV19vACW4h4A+yYjykGIH48DeNt5F+MOkwBe7hoA8w7fuVEh57gFYFPlMk50lAft
        lf2zF0J8LXxT6+QH8CJ8KXxQ4Z6NwPAfAJ7xLAvgcHwTfOYe92vEYj6+BnbUUwFagm+AZyvL
        MS4rEl5t6potAfEGIezp7pgrkQH7L/ziczgcfupxizgsgx9PlIo4w2EAu+6NzrntAFY9+Srk
        VEp4zPEYCyRjeDRsbIvn6JWwdaoGcEUXwNFvDkFAAnEJPFoq5eBqOH3p4HzUlOP7XCwNawYn
        5qaohsc8I4KTYEXVv/edANSDJcjMGgoQS5qV//9RM5hdt5hkD2h6mOUDuBgQYRJ7pFQtFTDF
        bInBB6AYIxZJXAyulkrymZL9yGLSWGx6xPqAyj+8Cky2WGvyL6/RqiFVCUqlkkpMSk5SKYml
        Ek3oy91SvICxoiKEzMgy7+OJg2V2EDTuRdmrcq9tokLLJFnd26+/jR12TIM8X4JrubvFbY0l
        w4OaysiiFcqt5zuq6cjMacMHjdXXuVDDJqQj48Y/us6ZQxv2nva+rnDc/5w31NuiTo32Tg/z
        zoZBa4oXc6YUh/R2t2vba12ZaV8P5lx5MDkiv7lOZt5R3Xggb3AbwWd1DBmDWVjmL7KbOIGE
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrALMWRmVeSWpSXmKPExsWy7bCSnO6PaOFYg5NnVS16du9ksth3Itni
        /7YWdosby8IsNj2+xmpxedccNou/d/6xWSy9fpHJ4vOyNhaLlx9PsDhweayZt4bRY+esu+we
        CzaVemxeUu/Rt2UVo8fnTXIeUw61swSwR3HZpKTmZJalFunbJXBlLD3/kbHgEH/F2SdfWRsY
        d/B0MXJySAiYSBya946ti5GLQ0hgN6PE69cPmCASUhIff3czdzFyANnCEocPF0PUtDFJ/GmZ
        yQJSwyagIfFg8QIwW0RAXOLMxC1MIEXMAk1MEl/X/WQGSQgLOEpc3fKJBWQQi4CqxL5VFiBh
        XgFridkzu5ghdslLrN5wgHkCI88CRoZVjJKpBcW56bnFhgWGeanlesWJucWleel6yfm5mxjB
        4aaluYPx8pL4Q4wCHIxKPLwN8kKxQqyJZcWVuYcYJTiYlUR4lyYKxArxpiRWVqUW5ccXleak
        Fh9ilOZgURLnfZp3LFJIID2xJDU7NbUgtQgmy8TBKdXAuGCm0fJjAWy3VnHPueHDs/3y5bVF
        XLc8vVvULyubqn+qYFxbu3Sa9cbeXc9n7PEJ3KI0uSApdKeEY9aJjUsXX53z3GKl77PlB2sd
        Z9ydv74r+1Vr78Kb3n4z73ZodDwqdTiUvDzY0Kuj7OZX21dCdf1dr9bWXnRawtL34+ufw6uT
        PzM+iNTYIqPEUpyRaKjFXFScCABUvwvnMwIAAA==
X-CMS-MailID: 20190626115016epcas1p455530417de86ea2e72ce1b389ae57a75
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190626115016epcas1p455530417de86ea2e72ce1b389ae57a75
References: <CGME20190626115016epcas1p455530417de86ea2e72ce1b389ae57a75@epcas1p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In traps.c, only __die calls dump_instr.
However, this function has sub-function as __dump_instr.

dump_kernel_instr can replace those functions.
By using aarch64_insn_read, it does not have to change fs to KERNEL_DS.

Signed-off-by: jinho lim <jordan.lim@samsung.com>
---
 arch/arm64/kernel/traps.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index ccc13b45d9b1..7e69454fd250 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -66,16 +66,19 @@ static void dump_backtrace_entry(unsigned long where)
 	printk(" %pS\n", (void *)where);
 }
 
-static void __dump_instr(const char *lvl, struct pt_regs *regs)
+static void dump_kernel_instr(const char *lvl, struct pt_regs *regs)
 {
 	unsigned long addr = instruction_pointer(regs);
 	char str[sizeof("00000000 ") * 5 + 2 + 1], *p = str;
 	int i;
 
+	if (user_mode(regs))
+		return;
+
 	for (i = -4; i < 1; i++) {
 		unsigned int val, bad;
 
-		bad = get_user(val, &((u32 *)addr)[i]);
+		bad = aarch64_insn_read(&((u32 *)addr)[i], &val);
 
 		if (!bad)
 			p += sprintf(p, i == 0 ? "(%08x) " : "%08x ", val);
@@ -84,19 +87,8 @@ static void __dump_instr(const char *lvl, struct pt_regs *regs)
 			break;
 		}
 	}
-	printk("%sCode: %s\n", lvl, str);
-}
 
-static void dump_instr(const char *lvl, struct pt_regs *regs)
-{
-	if (!user_mode(regs)) {
-		mm_segment_t fs = get_fs();
-		set_fs(KERNEL_DS);
-		__dump_instr(lvl, regs);
-		set_fs(fs);
-	} else {
-		__dump_instr(lvl, regs);
-	}
+	printk("%sCode: %s\n", lvl, str);
 }
 
 void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
@@ -182,8 +174,7 @@ static int __die(const char *str, int err, struct pt_regs *regs)
 	print_modules();
 	show_regs(regs);
 
-	if (!user_mode(regs))
-		dump_instr(KERN_EMERG, regs);
+	dump_kernel_instr(KERN_EMERG, regs);
 
 	return ret;
 }
-- 
2.17.1

