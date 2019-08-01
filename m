Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B39C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 22:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD8D2206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 22:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389891AbfHAWnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 18:43:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31256 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728719AbfHAWnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 18:43:07 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71MffhW030429
        for <linux-kernel@vger.kernel.org>; Thu, 1 Aug 2019 18:43:05 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u460eeeuw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 18:43:05 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 1 Aug 2019 23:43:05 +0100
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 1 Aug 2019 23:43:00 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x71MgxRs17170756
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Aug 2019 22:42:59 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 38A9BB206C;
        Thu,  1 Aug 2019 22:42:59 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C0D2B2073;
        Thu,  1 Aug 2019 22:42:59 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  1 Aug 2019 22:42:59 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 2787716C9A4F; Thu,  1 Aug 2019 15:43:00 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 8/8] acpi: Use built-in RCU list checking for acpi_ioremaps list
Date:   Thu,  1 Aug 2019 15:42:58 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190801224240.GA16092@linux.ibm.com>
References: <20190801224240.GA16092@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19080122-0060-0000-0000-000003677137
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011535; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01240735; UDB=6.00654295; IPR=6.01022160;
 MB=3.00028000; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-01 22:43:04
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080122-0061-0000-0000-00004A62795A
Message-Id: <20190801224258.16679-8-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-01_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908010239
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

This commit applies the consolidated list_for_each_entry_rcu() support
for lockdep conditions.

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 drivers/acpi/osl.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 9c0edf2fc0dd..2f9d0d20b836 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/mm.h>
 #include <linux/highmem.h>
+#include <linux/lockdep.h>
 #include <linux/pci.h>
 #include <linux/interrupt.h>
 #include <linux/kmod.h>
@@ -80,6 +81,7 @@ struct acpi_ioremap {
 
 static LIST_HEAD(acpi_ioremaps);
 static DEFINE_MUTEX(acpi_ioremap_lock);
+#define acpi_ioremap_lock_held() lock_is_held(&acpi_ioremap_lock.dep_map)
 
 static void __init acpi_request_region (struct acpi_generic_address *gas,
 	unsigned int length, char *desc)
@@ -206,7 +208,7 @@ acpi_map_lookup(acpi_physical_address phys, acpi_size size)
 {
 	struct acpi_ioremap *map;
 
-	list_for_each_entry_rcu(map, &acpi_ioremaps, list)
+	list_for_each_entry_rcu(map, &acpi_ioremaps, list, acpi_ioremap_lock_held())
 		if (map->phys <= phys &&
 		    phys + size <= map->phys + map->size)
 			return map;
@@ -249,7 +251,7 @@ acpi_map_lookup_virt(void __iomem *virt, acpi_size size)
 {
 	struct acpi_ioremap *map;
 
-	list_for_each_entry_rcu(map, &acpi_ioremaps, list)
+	list_for_each_entry_rcu(map, &acpi_ioremaps, list, acpi_ioremap_lock_held())
 		if (map->virt <= virt &&
 		    virt + size <= map->virt + map->size)
 			return map;
-- 
2.17.1

