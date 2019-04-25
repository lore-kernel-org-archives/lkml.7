Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BB9C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51E75206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388243AbfDYVqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 17:46:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48226 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388205AbfDYVq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 17:46:28 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3PLY6SE137750
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 17:46:28 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2s3metsejw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 17:46:27 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Thu, 25 Apr 2019 22:46:26 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 25 Apr 2019 22:46:20 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3PLkJQT61538416
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Apr 2019 21:46:19 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA28142041;
        Thu, 25 Apr 2019 21:46:19 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 50F4B42049;
        Thu, 25 Apr 2019 21:46:17 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.204.209])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 25 Apr 2019 21:46:17 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation); Fri, 26 Apr 2019 00:46:16 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alexandre Chartre <alexandre.chartre@oracle.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jonathan Adams <jwadams@google.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org, x86@kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [RFC PATCH 5/7] x86/mm/fault: hook up SCI verification
Date:   Fri, 26 Apr 2019 00:45:52 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556228754-12996-1-git-send-email-rppt@linux.ibm.com>
References: <1556228754-12996-1-git-send-email-rppt@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19042521-0016-0000-0000-000002750F36
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042521-0017-0000-0000-000032D18954
Message-Id: <1556228754-12996-6-git-send-email-rppt@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-25_18:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=453 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904250133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a system call runs in isolated context, it's accesses to kernel code and
data will be verified by SCI susbsytem.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/x86/mm/fault.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 9d5c75f..baa2a2f 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -18,6 +18,7 @@
 #include <linux/uaccess.h>		/* faulthandler_disabled()	*/
 #include <linux/efi.h>			/* efi_recover_from_page_fault()*/
 #include <linux/mm_types.h>
+#include <linux/sci.h>			/* sci_verify_and_map()		*/
 
 #include <asm/cpufeature.h>		/* boot_cpu_has, ...		*/
 #include <asm/traps.h>			/* dotraplinkage, ...		*/
@@ -1254,6 +1255,30 @@ static int fault_in_kernel_space(unsigned long address)
 	return address >= TASK_SIZE_MAX;
 }
 
+#ifdef CONFIG_SYSCALL_ISOLATION
+static int sci_fault(struct pt_regs *regs, unsigned long hw_error_code,
+		     unsigned long address)
+{
+	struct task_struct *tsk = current;
+
+	if (!tsk->in_isolated_syscall)
+		return 0;
+
+	if (!sci_verify_and_map(regs, address, hw_error_code)) {
+		this_cpu_write(cpu_sci.sci_syscall, 0);
+		no_context(regs, hw_error_code, address, SIGKILL, 0);
+	}
+
+	return 1;
+}
+#else
+static inline int sci_fault(struct pt_regs *regs, unsigned long hw_error_code,
+			    unsigned long address)
+{
+	return 0;
+}
+#endif
+
 /*
  * Called for all faults where 'address' is part of the kernel address
  * space.  Might get called for faults that originate from *code* that
@@ -1301,6 +1326,9 @@ do_kern_addr_fault(struct pt_regs *regs, unsigned long hw_error_code,
 	if (kprobes_fault(regs))
 		return;
 
+	if (sci_fault(regs, hw_error_code, address))
+		return;
+
 	/*
 	 * Note, despite being a "bad area", there are quite a few
 	 * acceptable reasons to get here, such as erratum fixups
-- 
2.7.4

