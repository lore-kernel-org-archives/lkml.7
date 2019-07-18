Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10DCBC76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 02:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA99C21848
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 02:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733059AbfGRCmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 22:42:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11460 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727804AbfGRCmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 22:42:38 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6I2bkH8014658
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 22:42:37 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ttd9adag3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 22:42:36 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <leonardo@linux.ibm.com>;
        Thu, 18 Jul 2019 03:42:35 +0100
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 18 Jul 2019 03:42:30 +0100
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6I2gT4Q42598804
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Jul 2019 02:42:29 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6C30AE062;
        Thu, 18 Jul 2019 02:42:29 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE5C0AE05C;
        Thu, 18 Jul 2019 02:42:17 +0000 (GMT)
Received: from LeoBras.ibmuc.com (unknown [9.85.131.254])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 18 Jul 2019 02:42:16 +0000 (GMT)
From:   Leonardo Bras <leonardo@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Leonardo Bras <leonardo@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Pasha Tatashin <Pavel.Tatashin@microsoft.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 1/1] mm/memory_hotplug: Adds option to hot-add memory in ZONE_MOVABLE
Date:   Wed, 17 Jul 2019 23:41:34 -0300
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19071802-2213-0000-0000-000003B290F7
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011449; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01233723; UDB=6.00650096; IPR=6.01015051;
 MB=3.00027769; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-18 02:42:33
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071802-2214-0000-0000-00005F49F2FE
Message-Id: <20190718024133.3873-1-leonardo@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-18_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907180028
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds an option on kernel config to make hot-added memory online in
ZONE_MOVABLE by default.

This would be great in systems with MEMORY_HOTPLUG_DEFAULT_ONLINE=y by
allowing to choose which zone it will be auto-onlined

Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
---
 drivers/base/memory.c |  3 +++
 mm/Kconfig            | 14 ++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index f180427e48f4..378b585785c1 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -670,6 +670,9 @@ static int init_memory_block(struct memory_block **memory,
 	mem->state = state;
 	start_pfn = section_nr_to_pfn(mem->start_section_nr);
 	mem->phys_device = arch_get_memory_phys_device(start_pfn);
+#ifdef CONFIG_MEMORY_HOTPLUG_MOVABLE
+	mem->online_type = MMOP_ONLINE_MOVABLE;
+#endif
 
 	ret = register_memory(mem);
 
diff --git a/mm/Kconfig b/mm/Kconfig
index f0c76ba47695..74e793720f43 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -180,6 +180,20 @@ config MEMORY_HOTREMOVE
 	depends on MEMORY_HOTPLUG && ARCH_ENABLE_MEMORY_HOTREMOVE
 	depends on MIGRATION
 
+config MEMORY_HOTPLUG_MOVABLE
+	bool "Enhance the likelihood of hot-remove"
+	depends on MEMORY_HOTREMOVE
+	help
+	  This option sets the hot-added memory zone to MOVABLE which
+	  drastically reduces the chance of a hot-remove to fail due to
+	  unmovable memory segments. Kernel memory can't be allocated in
+	  this zone.
+
+	  Say Y here if you want to have better chance to hot-remove memory
+	  that have been previously hot-added.
+	  Say N here if you want to make all hot-added memory available to
+	  kernel space.
+
 # Heavily threaded applications may benefit from splitting the mm-wide
 # page_table_lock, so that faults on different parts of the user address
 # space can be handled with less contention: split it at this NR_CPUS.
-- 
2.20.1

