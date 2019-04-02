Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33752C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9F7E20674
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xBffgtoj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfDBVwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 17:52:30 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46546 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfDBVwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 17:52:30 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x32Kd3X1163998;
        Tue, 2 Apr 2019 20:42:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=sUcjXY3uzftbRPA/qx9LGu6+ef2CXjVd6ceZM9+b18U=;
 b=xBffgtojFULgQywk6dg++phJ4dRh6ZFh7wsyFjoG1MnC+TBYtmtYjJElPMLapMw7cm8c
 VErNSijyy6Pj+8n4yE9yB/x8mMPgiR2/kTuoakitYDqe98KORwjyj0/R2IX7F7kwJfuS
 35MlOD9NugPRLgKZF+gPHWJCVtOk/RiUVaDNeVrsrVRH3bJCwL/Oa8L7vMS1F5iukMRh
 EoCVrL95xhmbuHu7GtL70vFi58jRPIMVnNuSTNy8PI6N34JZS3qvld0+RTBNxhy9t/AR
 loky0Zi2Y94RsT48wmNjpC2uJc3HpzEyMRCi3pu1G0E5UgmKcN0G/stq5GDGiP6E6oxt IQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2rj0dnkywp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Apr 2019 20:42:26 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x32KfI3M103083;
        Tue, 2 Apr 2019 20:42:25 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2rm9mhp3nq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Apr 2019 20:42:25 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x32KgPpX030145;
        Tue, 2 Apr 2019 20:42:25 GMT
Received: from localhost.localdomain (/73.60.114.248)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 02 Apr 2019 13:42:25 -0700
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     akpm@linux-foundation.org
Cc:     daniel.m.jordan@oracle.com, Alexey Kardashevskiy <aik@ozlabs.ru>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christoph Lameter <cl@linux.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@ozlabs.org>, linux-mm@kvack.org,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] kvm/book3s: drop mmap_sem now that locked_vm is atomic
Date:   Tue,  2 Apr 2019 16:41:58 -0400
Message-Id: <20190402204158.27582-7-daniel.m.jordan@oracle.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190402204158.27582-1-daniel.m.jordan@oracle.com>
References: <20190402204158.27582-1-daniel.m.jordan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9215 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=29 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904020138
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9215 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=29 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904020138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With locked_vm now an atomic, there is no need to take mmap_sem as
writer.  Delete and refactor accordingly.

Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@ozlabs.org>
Cc: <linux-mm@kvack.org>
Cc: <kvm-ppc@vger.kernel.org>
Cc: <linuxppc-dev@lists.ozlabs.org>
Cc: <linux-kernel@vger.kernel.org>
---
 arch/powerpc/kvm/book3s_64_vio.c | 34 +++++++++++---------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index e7fdb6d10eeb..8e034c3a5d25 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -56,7 +56,7 @@ static unsigned long kvmppc_stt_pages(unsigned long tce_pages)
 	return tce_pages + ALIGN(stt_bytes, PAGE_SIZE) / PAGE_SIZE;
 }
 
-static long kvmppc_account_memlimit(unsigned long stt_pages, bool inc)
+static long kvmppc_account_memlimit(unsigned long pages, bool inc)
 {
 	long ret = 0;
 	s64 locked_vm;
@@ -64,33 +64,23 @@ static long kvmppc_account_memlimit(unsigned long stt_pages, bool inc)
 	if (!current || !current->mm)
 		return ret; /* process exited */
 
-	down_write(&current->mm->mmap_sem);
-
-	locked_vm = atomic64_read(&current->mm->locked_vm);
 	if (inc) {
-		unsigned long locked, lock_limit;
+		unsigned long lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
 
-		locked = locked_vm + stt_pages;
-		lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
-		if (locked > lock_limit && !capable(CAP_IPC_LOCK))
+		locked_vm = atomic64_add_return(pages, &current->mm->locked_vm);
+		if (locked_vm > lock_limit && !capable(CAP_IPC_LOCK)) {
 			ret = -ENOMEM;
-		else
-			atomic64_add(stt_pages, &current->mm->locked_vm);
+			atomic64_sub(pages, &current->mm->locked_vm);
+		}
 	} else {
-		if (WARN_ON_ONCE(stt_pages > locked_vm))
-			stt_pages = locked_vm;
-
-		atomic64_sub(stt_pages, &current->mm->locked_vm);
+		locked_vm = atomic64_sub_return(pages, &current->mm->locked_vm);
+		WARN_ON_ONCE(locked_vm < 0);
 	}
 
-	pr_debug("[%d] RLIMIT_MEMLOCK KVM %c%ld %ld/%ld%s\n", current->pid,
-			inc ? '+' : '-',
-			stt_pages << PAGE_SHIFT,
-			atomic64_read(&current->mm->locked_vm) << PAGE_SHIFT,
-			rlimit(RLIMIT_MEMLOCK),
-			ret ? " - exceeded" : "");
-
-	up_write(&current->mm->mmap_sem);
+	pr_debug("[%d] RLIMIT_MEMLOCK KVM %c%lu %lld/%lu%s\n", current->pid,
+			inc ? '+' : '-', pages << PAGE_SHIFT,
+			locked_vm << PAGE_SHIFT,
+			rlimit(RLIMIT_MEMLOCK), ret ? " - exceeded" : "");
 
 	return ret;
 }
-- 
2.21.0

