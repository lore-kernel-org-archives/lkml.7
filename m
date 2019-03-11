Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7B7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C11A20883
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbfCKTRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:17:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53614 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727708AbfCKTRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:17:10 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2BJ9Vah030887
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 15:17:09 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r5v10vvek-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 15:17:08 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ldufour@linux.ibm.com>;
        Mon, 11 Mar 2019 19:17:06 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 11 Mar 2019 19:17:03 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2BJH2KF34930866
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Mar 2019 19:17:02 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E79EA4054;
        Mon, 11 Mar 2019 19:17:02 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8D385A405C;
        Mon, 11 Mar 2019 19:17:01 +0000 (GMT)
Received: from pomme.aus.stglabs.ibm.com (unknown [9.145.164.181])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 11 Mar 2019 19:17:01 +0000 (GMT)
From:   Laurent Dufour <ldufour@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     stable@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] mm/slab: protect cache_reap() against CPU and memory hot plug operations
Date:   Mon, 11 Mar 2019 20:17:01 +0100
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19031119-0008-0000-0000-000002CB630F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031119-0009-0000-0000-000022377F0E
Message-Id: <20190311191701.24325-1-ldufour@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-11_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903110133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 95402b382901 ("cpu-hotplug: replace per-subsystem mutexes with
get_online_cpus()") remove the CPU_LOCK_ACQUIRE operation which was use to
grap the cache_chain_mutex lock which was protecting cache_reap() against
CPU hot plug operations.

Later the commit 18004c5d4084 ("mm, sl[aou]b: Use a common mutex
definition") changed cache_chain_mutex to slab_mutex but this didn't help
fixing the missing the cache_reap() protection against CPU hot plug
operations.

Here we are stopping the per cpu worker while holding the slab_mutex to
ensure that cache_reap() is not running in our back and will not be
triggered anymore for this cpu.

This patch fixes that race leading to SLAB's data corruption when CPU
hotplug are triggered. We hit it while doing partition migration on PowerVM
leading to CPU reconfiguration through the CPU hotplug mechanism.

This fix is covering kernel containing to the commit 6731d4f12315 ("slab:
Convert to hotplug state machine"), ie 4.9.1, earlier kernel needs a
slightly different patch.

Cc: stable@vger.kernel.org
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
---
 mm/slab.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/slab.c b/mm/slab.c
index 28652e4218e0..ba499d90f27f 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1103,6 +1103,7 @@ static int slab_online_cpu(unsigned int cpu)
 
 static int slab_offline_cpu(unsigned int cpu)
 {
+	mutex_lock(&slab_mutex);
 	/*
 	 * Shutdown cache reaper. Note that the slab_mutex is held so
 	 * that if cache_reap() is invoked it cannot do anything
@@ -1112,6 +1113,7 @@ static int slab_offline_cpu(unsigned int cpu)
 	cancel_delayed_work_sync(&per_cpu(slab_reap_work, cpu));
 	/* Now the cache_reaper is guaranteed to be not running. */
 	per_cpu(slab_reap_work, cpu).work.func = NULL;
+	mutex_unlock(&slab_mutex);
 	return 0;
 }
 
-- 
2.21.0

