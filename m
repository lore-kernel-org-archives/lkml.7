Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8C6C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 04:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A36218DA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 04:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Qp5hsXLH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbfGXEVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 00:21:37 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:46678 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725855AbfGXEVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 00:21:37 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6O4IdnS005481;
        Tue, 23 Jul 2019 21:21:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=Wk97K/FpChliCnAWp8qRZILMqltAYsa7445Kk2ubOFc=;
 b=Qp5hsXLHFO/7Gcsdvw0Aylf/mR/ycl7N028073VKfsUN4vgdj+acnXLV2TRGzwcgTSip
 mTbYccW78UeHQ1x8PgUHZwwjg7V+h2hFFXTZYCYWRqf960+rIFjf0EfN1P/V3/Rm3s62
 +aIJ+FOW9VuPuq0cV13s8wLtG/AWlgOGHGI= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2tx621ja2h-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 23 Jul 2019 21:21:12 -0700
Received: from mmullins-1.thefacebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server id
 15.1.1713.5; Tue, 23 Jul 2019 21:21:10 -0700
From:   Matt Mullins <mmullins@fb.com>
To:     <peterz@infradead.org>, <tglx@linutronix.de>, <luto@kernel.org>
CC:     Matt Mullins <mmullins@fb.com>, Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/entry/32: pass cr2 to do_async_page_fault
Date:   Tue, 23 Jul 2019 21:20:58 -0700
Message-ID: <20190724042058.24506-1-mmullins@fb.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c081:10::13]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-24_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907240047
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a0d14b8909de ("x86/mm, tracing: Fix CR2 corruption") added the
address parameter to do_async_page_fault, but does not pass it from the
32-bit entry point.  To plumb it through, factor-out
common_exception_read_cr2 in the same fashion as common_exception, and
uses it from both page_fault and async_page_fault.

For a 32-bit KVM guest, this fixes:

[    1.148669][    T1] Run /sbin/init as init process
[    1.153328][    T1] Starting init: /sbin/init exists but couldn't execute it (error -14)

Fixes: a0d14b8909de ("x86/mm, tracing: Fix CR2 corruption")
Signed-off-by: Matt Mullins <mmullins@fb.com>
---
 arch/x86/entry/entry_32.S | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 2bb986f305ac..4f86928246e7 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1443,8 +1443,12 @@ BUILD_INTERRUPT3(hv_stimer0_callback_vector, HYPERV_STIMER0_VECTOR,
 
 ENTRY(page_fault)
 	ASM_CLAC
-	pushl	$0; /* %gs's slot on the stack */
+	pushl	$do_page_fault
+	jmp	common_exception_read_cr2
+END(page_fault)
 
+common_exception_read_cr2:
+	/* the function address is in %gs's slot on the stack */
 	SAVE_ALL switch_stacks=1 skip_gs=1
 
 	ENCODE_FRAME_POINTER
@@ -1452,6 +1456,7 @@ ENTRY(page_fault)
 
 	/* fixup %gs */
 	GS_TO_REG %ecx
+	movl	PT_GS(%esp), %edi
 	REG_TO_PTGS %ecx
 	SET_KERNEL_GS %ecx
 
@@ -1463,9 +1468,9 @@ ENTRY(page_fault)
 
 	TRACE_IRQS_OFF
 	movl	%esp, %eax			# pt_regs pointer
-	call	do_page_fault
+	CALL_NOSPEC %edi
 	jmp	ret_from_exception
-END(page_fault)
+END(common_exception_read_cr2)
 
 common_exception:
 	/* the function address is in %gs's slot on the stack */
@@ -1595,7 +1600,7 @@ END(general_protection)
 ENTRY(async_page_fault)
 	ASM_CLAC
 	pushl	$do_async_page_fault
-	jmp	common_exception
+	jmp	common_exception_read_cr2
 END(async_page_fault)
 #endif
 
-- 
2.17.1

