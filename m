Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED571C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 07:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7A7F2082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 07:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SHTjsy96"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfCEHzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 02:55:46 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:52428 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbfCEHzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 02:55:45 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x257s1qu089065;
        Tue, 5 Mar 2019 07:55:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=5EgQtO9dM3pUMoWARn+BpYfichpL9PwjEVaSPS2KExs=;
 b=SHTjsy96+vgnlZnFb7k9UP+D2FygYPksPCJBIMOY5Rh+UnZzaRn3PvtE+sOGcyIFuq9d
 /3Ta7v/g+Hnyw2uSNgL66001/a08aDrzA+KJnpZ8kIVBQKyogf3qXfIRXbn0mDVawyw7
 PU0E2K/y6Br8IAOPrLMxMIIQCqENXpK59cQRbugUPoGUS0rjAIKtM4UvLsmWrkN8/oyV
 iHkKz4TE4tGScX/YHf60pz8JkgZeLctYXE5rTkco3jcbX4mPcOcMjZqawLlHEpBxboD7
 ZVKaiJ2GlFKkCFWeS5Pe0oh9tMU8jEzKRgWAG5uo2if3ljTsCucDChymBpg1eDnPFMAY DQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2qyfbe3wv7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Mar 2019 07:55:26 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x257tPW1000753
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Mar 2019 07:55:25 GMT
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x257tPee016496;
        Tue, 5 Mar 2019 07:55:25 GMT
Received: from linux.cn.oracle.com (/10.182.69.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Mar 2019 23:55:24 -0800
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     stable@vger.kernel.org
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        boris.ostrovsky@oracle.com, sstabellini@kernel.org,
        jgross@suse.com, tglx@linutronix.de, sboyd@kernel.org,
        john.stultz@linaro.org, frederic@kernel.org, joe.jin@oracle.com,
        herbert.van.den.bergh@oracle.com
Subject: [PATCH v4.9 1/1] jiffies: use jiffies64_to_nsecs() to fix 100% steal usage for xen vcpu hotplug
Date:   Tue,  5 Mar 2019 15:59:04 +0800
Message-Id: <1551772744-524-1-git-send-email-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9185 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=984 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903050059
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Not relevant upstream, therefore no upstream commit. ]

To fix, use jiffies64_to_nsecs() directly instead of deriving the result
according to jiffies_to_usecs().

As the return type of jiffies_to_usecs() is 'unsigned int', when the return
value is more than the size of 'unsigned int', the leading 32 bits would be
discarded.

Suppose USEC_PER_SEC=1000000L and HZ=1000, below are the expected and
actual incorrect result of jiffies_to_usecs(0x7770ef70):

- expected  : jiffies_to_usecs(0x7770ef70) = 0x000001d291274d80
- incorrect : jiffies_to_usecs(0x7770ef70) = 0x0000000091274d80

The leading 0x000001d200000000 is discarded.

After xen vcpu hotplug and when the new vcpu steal clock is calculated for
the first time, the result of this_rq()->prev_steal_time in
steal_account_process_tick() would be far smaller than the expected
value, due to that jiffies_to_usecs() discards the leading 32 bits.

As a result, the diff between current steal and this_rq()->prev_steal_time
is always very large. Steal usage would become 100% when the initial steal
clock obtained from xen hypervisor is very large during xen vcpu hotplug,
that is, when the guest is already up for a long time.

The bug can be detected by doing the following:

* Boot xen guest with vcpus=2 and maxvcpus=4
* Leave the guest running for a month so that the initial steal clock for
  the new vcpu would be very large
* Hotplug 2 extra vcpus
* The steal time of new vcpus in /proc/stat would increase abnormally and
  sometimes steal usage in top can become 100%

This was incidentally fixed in the patch set starting by
commit 93825f2ec736 ("jiffies: Reuse TICK_NSEC instead of NSEC_PER_JIFFY")
and ended with
commit b672592f0221 ("sched/cputime: Remove generic asm headers").

This version applies to the v4.9 series.

Link: https://lkml.org/lkml/2019/2/28/1373
Suggested-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 include/linux/jiffies.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/jiffies.h b/include/linux/jiffies.h
index 734377a..94aff43 100644
--- a/include/linux/jiffies.h
+++ b/include/linux/jiffies.h
@@ -287,13 +287,13 @@ extern unsigned long preset_lpj;
 extern unsigned int jiffies_to_msecs(const unsigned long j);
 extern unsigned int jiffies_to_usecs(const unsigned long j);
 
+extern u64 jiffies64_to_nsecs(u64 j);
+
 static inline u64 jiffies_to_nsecs(const unsigned long j)
 {
-	return (u64)jiffies_to_usecs(j) * NSEC_PER_USEC;
+	return jiffies64_to_nsecs(j);
 }
 
-extern u64 jiffies64_to_nsecs(u64 j);
-
 extern unsigned long __msecs_to_jiffies(const unsigned int m);
 #if HZ <= MSEC_PER_SEC && !(MSEC_PER_SEC % HZ)
 /*
-- 
2.7.4

