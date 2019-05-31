Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED283C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 19:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B841926E8D
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 19:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="H06IvE9G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfEaTtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 15:49:07 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45126 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727343AbfEaTtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 15:49:06 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4VJf8tH024565;
        Fri, 31 May 2019 12:48:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=F3AqsJcah4GIcgPT0/+5kExX5tqdoxZ29ByRG5iNwTw=;
 b=H06IvE9GRDH1sOBESJGfJPtR4GCttSqBbUFjXedIfRujx5SlWjAT2S6sz1quRn5b6xu7
 qhxCAOFGT1wJBiSQ1WyzDlCCAhn/iJRoOHmTHrJJR4JsQn0V1e0WM/Fg8Yb4AKXlQJX/
 Xb1WA1NKEleU3o2YfcyFnfD5+nM1jQ1kpTA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2su10ka05j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 31 May 2019 12:48:24 -0700
Received: from mmullins-1.thefacebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server id
 15.1.1713.5; Fri, 31 May 2019 12:48:21 -0700
From:   Matt Mullins <mmullins@fb.com>
To:     <mmullins@fb.com>, <bp@alien8.de>, <mingo@redhat.com>,
        <luto@kernel.org>, <namit@vmware.com>, <peterz@infradead.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, <x86@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        "Rick Edgecombe" <rick.p.edgecombe@intel.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Douglas Anderson <dianders@chromium.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/kgdb: return 0 from kgdb_arch_set_breakpoint
Date:   Fri, 31 May 2019 12:47:54 -0700
Message-ID: <20190531194755.6320-1-mmullins@fb.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c0a8:1b::d]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-31_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905310119
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

err must be nonzero in order to reach text_poke(), which caused kgdb to
fail to set breakpoints:

	(gdb) break __x64_sys_sync
	Breakpoint 1 at 0xffffffff81288910: file ../fs/sync.c, line 124.
	(gdb) c
	Continuing.
	Warning:
	Cannot insert breakpoint 1.
	Cannot access memory at address 0xffffffff81288910

	Command aborted.

Fixes: 86a22057127d ("x86/kgdb: Avoid redundant comparison of patched code")
Signed-off-by: Matt Mullins <mmullins@fb.com>
---
 arch/x86/kernel/kgdb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kgdb.c b/arch/x86/kernel/kgdb.c
index 9a8c1648fc9a..6690c5652aeb 100644
--- a/arch/x86/kernel/kgdb.c
+++ b/arch/x86/kernel/kgdb.c
@@ -758,7 +758,7 @@ int kgdb_arch_set_breakpoint(struct kgdb_bkpt *bpt)
 		       BREAK_INSTR_SIZE);
 	bpt->type = BP_POKE_BREAKPOINT;
 
-	return err;
+	return 0;
 }
 
 int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt)
-- 
2.17.1

