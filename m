Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B966AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 08:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DEE5218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 08:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZKF8hb4I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbfCOIlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 04:41:51 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46720 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbfCOIlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 04:41:50 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2F8Y0tn189554;
        Fri, 15 Mar 2019 08:41:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=eUi/Z3srTW7VGIU/Le8s83ye5rAezoTzGaE+UHOcjcE=;
 b=ZKF8hb4Ia7esX1f+QTF90tI+0GurF70uNwiYEdqm8lPrAw8NQ2s/tH+ppa+apYHNqMsg
 vzVMBdDi3tJJzj9bO/IKxyb+25tRa8Bze99/qe/A8KcqAZlRx1ng3rUlAcl06IS8O/Pe
 oDmV4rZ/PaNenUm2vRWe0ghgfrDHthv0+896mn41VLMjXoKXfgHG0di3MDZDEnGaKdm+
 fdlDNQF3YKIpZbml1vfaaBdHPgKtQnxQX0ScWSdYw2ewK3iuqrWFTGOVMzdjjOiG7dds
 u7EOl0R27cw0nN8cZ2yqCZLU3oUNaIe0Xwd8TJRHS2Rp5PAlsWdkpt1X4FDySuCeTtSR 1g== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2r44wuncmb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Mar 2019 08:41:29 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2F8fSxe022996
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Mar 2019 08:41:29 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2F8fRVL001381;
        Fri, 15 Mar 2019 08:41:27 GMT
Received: from z2.cn.oracle.com (/10.182.69.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 Mar 2019 08:41:27 +0000
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Waiman Long <longman@redhat.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>, x86@kernel.org
Subject: [PATCH 2/2] Revert "x86/hpet: Reduce HPET counter read contention"
Date:   Thu, 14 Mar 2019 16:42:12 +0800
Message-Id: <1552552932-21821-2-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1552552932-21821-1-git-send-email-zhenzhong.duan@oracle.com>
References: <1552552932-21821-1-git-send-email-zhenzhong.duan@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9195 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=678 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903150064
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit f99fd22e4d4bc84880a8a3117311bbf0e3a6a9dc.

It's unnecessory after commit "acpi_pm: Fix bootup softlockup due to PMTMR
counter read contention", the simple HPET access code could be restored.

On a general system with good TSC, TSC is the final default clocksource.
So the potential performce loss is only at bootup stage before TSC
replacing HPET, we didn't observe obvious delay of bootup.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Tested-by: Kin Cho <kin.cho@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Srinivas Eeda <srinivas.eeda@oracle.com>
Cc: x86@kernel.org
---
 arch/x86/kernel/hpet.c | 94 --------------------------------------------------
 1 file changed, 94 deletions(-)

diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index dfd3aca..b4fdee6a 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -749,104 +749,10 @@ static void hpet_reserve_msi_timers(struct hpet_data *hd)
 /*
  * Clock source related code
  */
-#if defined(CONFIG_SMP) && defined(CONFIG_64BIT)
-/*
- * Reading the HPET counter is a very slow operation. If a large number of
- * CPUs are trying to access the HPET counter simultaneously, it can cause
- * massive delay and slow down system performance dramatically. This may
- * happen when HPET is the default clock source instead of TSC. For a
- * really large system with hundreds of CPUs, the slowdown may be so
- * severe that it may actually crash the system because of a NMI watchdog
- * soft lockup, for example.
- *
- * If multiple CPUs are trying to access the HPET counter at the same time,
- * we don't actually need to read the counter multiple times. Instead, the
- * other CPUs can use the counter value read by the first CPU in the group.
- *
- * This special feature is only enabled on x86-64 systems. It is unlikely
- * that 32-bit x86 systems will have enough CPUs to require this feature
- * with its associated locking overhead. And we also need 64-bit atomic
- * read.
- *
- * The lock and the hpet value are stored together and can be read in a
- * single atomic 64-bit read. It is explicitly assumed that arch_spinlock_t
- * is 32 bits in size.
- */
-union hpet_lock {
-	struct {
-		arch_spinlock_t lock;
-		u32 value;
-	};
-	u64 lockval;
-};
-
-static union hpet_lock hpet __cacheline_aligned = {
-	{ .lock = __ARCH_SPIN_LOCK_UNLOCKED, },
-};
-
-static u64 read_hpet(struct clocksource *cs)
-{
-	unsigned long flags;
-	union hpet_lock old, new;
-
-	BUILD_BUG_ON(sizeof(union hpet_lock) != 8);
-
-	/*
-	 * Read HPET directly if in NMI.
-	 */
-	if (in_nmi())
-		return (u64)hpet_readl(HPET_COUNTER);
-
-	/*
-	 * Read the current state of the lock and HPET value atomically.
-	 */
-	old.lockval = READ_ONCE(hpet.lockval);
-
-	if (arch_spin_is_locked(&old.lock))
-		goto contended;
-
-	local_irq_save(flags);
-	if (arch_spin_trylock(&hpet.lock)) {
-		new.value = hpet_readl(HPET_COUNTER);
-		/*
-		 * Use WRITE_ONCE() to prevent store tearing.
-		 */
-		WRITE_ONCE(hpet.value, new.value);
-		arch_spin_unlock(&hpet.lock);
-		local_irq_restore(flags);
-		return (u64)new.value;
-	}
-	local_irq_restore(flags);
-
-contended:
-	/*
-	 * Contended case
-	 * --------------
-	 * Wait until the HPET value change or the lock is free to indicate
-	 * its value is up-to-date.
-	 *
-	 * It is possible that old.value has already contained the latest
-	 * HPET value while the lock holder was in the process of releasing
-	 * the lock. Checking for lock state change will enable us to return
-	 * the value immediately instead of waiting for the next HPET reader
-	 * to come along.
-	 */
-	do {
-		cpu_relax();
-		new.lockval = READ_ONCE(hpet.lockval);
-	} while ((new.value == old.value) && arch_spin_is_locked(&new.lock));
-
-	return (u64)new.value;
-}
-#else
-/*
- * For UP or 32-bit.
- */
 static u64 read_hpet(struct clocksource *cs)
 {
 	return (u64)hpet_readl(HPET_COUNTER);
 }
-#endif
 
 static struct clocksource clocksource_hpet = {
 	.name		= "hpet",
-- 
1.8.3.1

