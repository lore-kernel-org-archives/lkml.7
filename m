Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2857C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 12:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7933F208CA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 12:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RkcP6ugO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732490AbfFYMBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 08:01:01 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39112 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728365AbfFYMBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 08:01:00 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5PBwX7f034947;
        Tue, 25 Jun 2019 12:00:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=EMb96t5WuJs0JYsPKdZC7E6ogPsiS0s7Bn+LAKFUFOo=;
 b=RkcP6ugO5B/V6L4Gii2r0I1mE75z/MSvzTdT69uvlEwGcewX/RDt5usbISd03uSsM8z8
 LrRqJEVtJTtndV+h46oiYyCeE8gLWfDjydbFTwxYLN/FDRTn0H2XHq+CLsiezo/2ffIu
 OXpBGcXKwaHA0iwZv+BwN2kOzTv7bHL5XlxzVRpSFn81vZP3PZmKkadbWn4VYeLc8Mso
 sM5H+qKQMczF0szdapkQMXBk/VLpj4i8hPpR4QQ7rBT2RecLun4/KMyEl70HpM/lrl3r
 kMdRJjSrh2W7cirJenv4USgSjdNCt8kGheEjYnt739I26wPeJfvc88WgHAbf9a3WpfTh Aw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2t9cyqbuda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jun 2019 12:00:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5PBxTGE065052;
        Tue, 25 Jun 2019 12:00:14 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2t9acc2gty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jun 2019 12:00:13 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5PC0Cwn012306;
        Tue, 25 Jun 2019 12:00:12 GMT
Received: from z2.cn.oracle.com (/10.182.69.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 25 Jun 2019 05:00:11 -0700
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@kernel.org, bp@alien8.de, hpa@zytor.com,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, peterz@infradead.org,
        srinivas.eeda@oracle.com,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: [PATCH v2 7/7] Revert "x86/paravirt: Set up the virt_spin_lock_key after static keys get initialized"
Date:   Mon, 24 Jun 2019 20:02:59 +0800
Message-Id: <1561377779-28036-8-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1561377779-28036-1-git-send-email-zhenzhong.duan@oracle.com>
References: <1561377779-28036-1-git-send-email-zhenzhong.duan@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9298 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906250097
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9298 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906250097
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit ca5d376e17072c1b60c3fee66f3be58ef018952d.

Commit 8990cac6e5ea ("x86/jump_label: Initialize static branching
early") adds jump_label_init() call in setup_arch() to make static
keys initialized early, so we could use the original simpler code
again.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>
---
 arch/x86/kernel/smpboot.c | 3 +--
 arch/x86/xen/spinlock.c   | 6 ++----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 362dd89..44472ca 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1308,8 +1308,6 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 	pr_info("CPU0: ");
 	print_cpu_info(&cpu_data(0));
 
-	native_pv_lock_init();
-
 	uv_system_init();
 
 	set_mtrr_aps_delayed_init();
@@ -1339,6 +1337,7 @@ void __init native_smp_prepare_boot_cpu(void)
 	/* already set me in cpu_online_mask in boot_cpu_init() */
 	cpumask_set_cpu(me, cpu_callout_mask);
 	cpu_set_state_online(me);
+	native_pv_lock_init();
 }
 
 void __init calculate_max_logical_packages(void)
diff --git a/arch/x86/xen/spinlock.c b/arch/x86/xen/spinlock.c
index 3776122..6deb490 100644
--- a/arch/x86/xen/spinlock.c
+++ b/arch/x86/xen/spinlock.c
@@ -68,11 +68,8 @@ void xen_init_lock_cpu(int cpu)
 	int irq;
 	char *name;
 
-	if (!xen_pvspin) {
-		if (cpu == 0)
-			static_branch_disable(&virt_spin_lock_key);
+	if (!xen_pvspin)
 		return;
-	}
 
 	WARN(per_cpu(lock_kicker_irq, cpu) >= 0, "spinlock on CPU%d exists on IRQ%d!\n",
 	     cpu, per_cpu(lock_kicker_irq, cpu));
@@ -124,6 +121,7 @@ void __init xen_init_spinlocks(void)
 
 	if (!xen_pvspin) {
 		printk(KERN_DEBUG "xen: PV spinlocks disabled\n");
+		static_branch_disable(&virt_spin_lock_key);
 		return;
 	}
 	printk(KERN_DEBUG "xen: PV spinlocks enabled\n");
-- 
1.8.3.1

