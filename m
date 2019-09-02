Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3928CC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 09:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 089EC21897
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 09:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rhJwHQyA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731108AbfIBJbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 05:31:45 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60010 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730427AbfIBJbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 05:31:44 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x829U99n118435;
        Mon, 2 Sep 2019 09:31:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2019-08-05;
 bh=Xew4yVHBdOcJz+ZaJzNSbTMrzBAhAXlxXa9HdCk99/s=;
 b=rhJwHQyA2Yfn83hHGLHkwFDdKcSBIReUksYKUcVubXosAgHRAtWMHYCZxxFi+OHCeNwr
 0ssdKPzheK+aMiUeB3/6WQpqfhME9GdH9OyM4Ngy4UF0qFfjxVg3xHnrWXxyM/Bw2Khn
 1V+LL7n7RYcgbXI6VjD8TcApF/1zz0Pzn/YwbfrmgRMqLQjzYDAoUJexcjlo3Fw+NUXE
 BqTSv4N9hZ48NYD4kOEG7hVeLURNrt/FpX7Po1YLMywTQUF+vTULjZpJOmr8bLuoSMn5
 J0bf5MYltV+RcmxXZYe21zBHgRAKHcKasbhJaU3ENdx1j8j8jYTyF3tNkWmISiSP54Rn mA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2us0gcg06e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Sep 2019 09:31:16 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x829T7d5016388;
        Mon, 2 Sep 2019 09:31:15 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2uryv514jf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Sep 2019 09:31:15 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x829VC7c002000;
        Mon, 2 Sep 2019 09:31:12 GMT
Received: from z2.cn.oracle.com (/10.182.71.205)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 02 Sep 2019 02:31:11 -0700
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86-ml <x86@kernel.org>
Subject: [PATCH] x86/boot/compressed/64: Fix 'may be used uninitialized' issue
Date:   Mon,  2 Sep 2019 17:30:24 +0800
Message-Id: <1567416624-26727-1-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9367 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=934
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909020108
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9367 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=992 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909020108
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Builds kernel with "make bzImage EXTRA_CFLAGS=-Wall", gcc complains:

arch/x86/boot/compressed/pgtable_64.c: In function 'paging_prepare':
arch/x86/boot/compressed/pgtable_64.c:92:7: warning: 'new' may be used uninitialized in this function [-Wmaybe-uninitialized]
   new = round_down(new, PAGE_SIZE);

In theory a random value of variable new may pass all the check and be
assigned to bios_start, fixing it by assigning it an initial value.

Fixes: 0a46fff2f910 ("x86/boot/compressed/64: Fix boot on machines with broken E820 table")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc: Kirill A. Shutemov <kirill@shutemov.name>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86-ml <x86@kernel.org>
---
 arch/x86/boot/compressed/pgtable_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index 2faddeb..c886269 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -72,7 +72,7 @@ static unsigned long find_trampoline_placement(void)
 
 	/* Find the first usable memory region under bios_start. */
 	for (i = boot_params->e820_entries - 1; i >= 0; i--) {
-		unsigned long new;
+		unsigned long new = bios_start;
 
 		entry = &boot_params->e820_table[i];
 
-- 
1.8.3.1

