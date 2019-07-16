Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4A8C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 13:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BB9621743
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 13:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lGia3dcz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbfGQNQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 09:16:48 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34838 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfGQNQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 09:16:48 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6HDDtDc093407;
        Wed, 17 Jul 2019 13:16:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=MJEwO54lmmPvXRI8FYtOyTN+c7zUXuOQr44nzf5sm7Y=;
 b=lGia3dczEYc+Jx5Sud5AixQImtoAKnVWZsB+O63uURD8NR7O6afwJpcZlZsBI4awEVR6
 Goc+nlf9G+mPfIQz6OV8XUichp3IsXX8r6GV/DwuA9RM/661uFUygonIO+rXca0CmWHG
 jaMZgGUL59XSKEH4B2YOJ0KezaWEBWy6Z+u5eNde7huk6JHIvFykbOTCFlosVRIHs0xq
 bbyHz+kEBaAJKruJNxeKjDFKjkOMUQiNR+cAzhpfj+0gKE7NR75J9srbzC4HDjsNY60H
 qWHs3y3tzt0bPMUXKHk5xp9JERh8t71zeQTxFAzdRiW7CEZpF7spoMTbYB6tCo5sh+E1 VA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2tq78ptjp5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 13:16:24 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6HDCl2G074511;
        Wed, 17 Jul 2019 13:14:24 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2tq5bd088x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 13:14:23 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6HDEMeT007829;
        Wed, 17 Jul 2019 13:14:22 GMT
Received: from z2.cn.oracle.com (/10.182.69.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 17 Jul 2019 13:14:22 +0000
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Subject: [PATCH] x86, boot: Remove multiple copy of static function sanitize_boot_params()
Date:   Tue, 16 Jul 2019 21:18:12 +0800
Message-Id: <1563283092-1189-1-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907170161
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907170161
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel build reporting warnings:
 'sanitize_boot_params' defined but not used [-Wunused-function]

at below files:
arch/x86/boot/compressed/cmdline.c
arch/x86/boot/compressed/error.c
arch/x86/boot/compressed/early_serial_console.c
arch/x86/boot/compressed/acpi.c

That's due to they each include misc.h which includes a definition
of sanitize_boot_params().

Remove the inclusion from misc.h and have the c file including
bootparam_utils.h directly.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
---
 arch/x86/boot/compressed/misc.c | 1 +
 arch/x86/boot/compressed/misc.h | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 24e65a0..53ac0cb 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -17,6 +17,7 @@
 #include "pgtable.h"
 #include "../string.h"
 #include "../voffset.h"
+#include <asm/bootparam_utils.h>
 
 /*
  * WARNING!!
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index d2f1841..c818139 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -23,7 +23,6 @@
 #include <asm/page.h>
 #include <asm/boot.h>
 #include <asm/bootparam.h>
-#include <asm/bootparam_utils.h>
 
 #define BOOT_CTYPE_H
 #include <linux/acpi.h>
-- 
1.8.3.1

