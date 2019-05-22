Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BDDC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 14:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EB5020821
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 14:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729659AbfEVOqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 10:46:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51196 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729375AbfEVOqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 10:46:31 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4MEhx2x019188
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 10:46:30 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2sn6ttnd68-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 10:46:25 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Wed, 22 May 2019 15:46:14 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 22 May 2019 15:46:11 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4MEkAlf48169212
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 May 2019 14:46:10 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A17011C064;
        Wed, 22 May 2019 14:46:10 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E09811C05B;
        Wed, 22 May 2019 14:46:10 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 22 May 2019 14:46:10 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     brueckner@linux.vnet.ibm.com, heiko.carstens@de.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 2/3] perf record: Fix kallsym map size for s390
Date:   Wed, 22 May 2019 16:46:00 +0200
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190522144601.50763-1-tmricht@linux.ibm.com>
References: <20190522144601.50763-1-tmricht@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19052214-0028-0000-0000-00000370590B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052214-0029-0000-0000-0000243007BC
Message-Id: <20190522144601.50763-3-tmricht@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-22_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905220104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On s390 command

   [root@m35lp76 perf]#./perf record -e cycles -- find ~

creates a perf.data file with a strange PERF_RECORD_MMAP for kallsyms:

   [root@m35lp76 perf]# ./perf report -D | fgrep kernel.kallsyms
   0 0x128 [0x50]: PERF_RECORD_MMAP -1/0:
            [0x100000(0x3ff7ff027f0) @ 0x100000]: x [kernel.kallsyms]_text
   [root@m35lp76 perf]#

The size of the kernel is 0x3ff7ff027f0 bytes which is simply wrong.
It is the difference between the kernel's _end symbol and the first module:

  [root@m35lp76 perf]# cat /proc/kallsyms |sort| les
  0000000002472000 B __bss_stop
  0000000002472000 B _end
  000003ff800027f0 T qdio_stop_irq        [qdio]
  000003ff80002898 t qdio_do_eqbs [qdio]

The root cause is the following function sequence:
  cmd__record
    __cmd_record
      perf_session__new
        perf_session__create_kernel_maps
          machine__create_kernel_maps
            machine__get_running_kernel_start
            machine__update_kernel_mmap
            machine__set_kernel_mmap;

Machine__get_running_kernel_start() searches /proc/kallsyms for the
start symbol and then calls machine__update_kernel_mmap() with ~0ULL
for the kernel's end address.
It relies on machine__set_kernel_mmap() to find the next map, which is
usually a module and then uses the first module's start address as
kernel end address.
This works nicely on x86 and similar plattforms but not on s390.

On s390 the kernel starts at address 0x10000 and modules are loaded
at kernel virtual address space somewhere around 0x3ff xxxx xxxx,
leaving a huge gap.

To fix this function machine__create_kernel_maps() also searches for
symbol _end as BSS symbol and if this symbol is found, use this
symbol's address a kernel end in machine__update_kernel_mmap().
Otherwise fall back to the previous method and use the first
kernel module's load address (as before).

Output before:
  [root@m35lp76 perf]# ./perf record -e cycles -- find ~
  [root@m35lp76 perf]# ./perf report -D | fgrep kernel.kallsyms
  0 0x128 [0x50]: PERF_RECORD_MMAP -1/0:
                [0x100000(0x3ff7ff027f0) @ 0x100000]:
                x [kernel.kallsyms]_text
  [root@m35lp76 perf]#

Output after:
  [root@m35lp76 perf]# ./perf record -e cycles -- find ~
  [root@m35lp76 perf]# ./perf report -D | fgrep kernel.kallsyms
  0 0x128 [0x50]: PERF_RECORD_MMAP -1/0:
                [0x100000(0x2372000) @ 0x100000]:
                x [kernel.kallsyms]_text
  [root@m35lp76 perf]#

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
---
 tools/perf/util/event.c   |  4 ++--
 tools/perf/util/machine.c | 29 +++++++++++++++++++++++------
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index d1ad6c419724..96b4cbdb655e 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -876,11 +876,11 @@ static int find_symbol_cb(void *arg, const char *name, char type,
 	/*
 	 * Must be a function or at least an alias, as in PARISC64, where "_text" is
 	 * an 'A' to the same address as "_stext".
+	 * When searching for symbol _end allow symbol type 'B'.
 	 */
 	if (!(kallsyms__is_function(type) ||
-	      type == 'A') || strcmp(name, args->name))
+	      type == 'A' || type == 'B') || strcmp(name, args->name))
 		return 0;
-
 	args->start = start;
 	return 1;
 }
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 28a9541c4835..c278c1fe6dd3 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -918,13 +918,18 @@ void machine__get_kallsyms_filename(struct machine *machine, char *buf,
 }
 
 const char *ref_reloc_sym_names[] = {"_text", "_stext", NULL};
+static const char *const ref_sym_endnames[] = {"_end", NULL};
 
 /* Figure out the start address of kernel map from /proc/kallsyms.
  * Returns the name of the start symbol in *symbol_name. Pass in NULL as
  * symbol_name if it's not that important.
+ *
+ * Get kernel end address for kernel map from /proc/kallsyms by
+ * searching for symbol _end.
  */
 static int machine__get_running_kernel_start(struct machine *machine,
-					     const char **symbol_name, u64 *start)
+					     const char **symbol_name,
+					     u64 *start, u64 *kernel_end)
 {
 	char filename[PATH_MAX];
 	int i, err = -1;
@@ -949,6 +954,16 @@ static int machine__get_running_kernel_start(struct machine *machine,
 		*symbol_name = name;
 
 	*start = addr;
+
+	/* Get kernel end address and store it when found */
+	for (i = 0; (name = ref_sym_endnames[i]) != NULL; i++) {
+		err = kallsyms__get_function_start(filename, name, &addr);
+		if (!err) {
+			*kernel_end = addr;
+			break;
+		}
+	}
+
 	return 0;
 }
 
@@ -1441,7 +1456,7 @@ int machine__create_kernel_maps(struct machine *machine)
 	struct dso *kernel = machine__get_kernel(machine);
 	const char *name = NULL;
 	struct map *map;
-	u64 addr = 0;
+	u64 addr = 0, e_addr = 0;
 	int ret;
 
 	if (kernel == NULL)
@@ -1460,7 +1475,7 @@ int machine__create_kernel_maps(struct machine *machine)
 				 "continuing anyway...\n", machine->pid);
 	}
 
-	if (!machine__get_running_kernel_start(machine, &name, &addr)) {
+	if (!machine__get_running_kernel_start(machine, &name, &addr, &e_addr)) {
 		if (name &&
 		    map__set_kallsyms_ref_reloc_sym(machine->vmlinux_map, name, addr)) {
 			machine__destroy_kernel_maps(machine);
@@ -1472,15 +1487,17 @@ int machine__create_kernel_maps(struct machine *machine)
 		 * we have a real start address now, so re-order the kmaps
 		 * assume it's the last in the kmaps
 		 */
-		machine__update_kernel_mmap(machine, addr, ~0ULL);
+		machine__update_kernel_mmap(machine, addr, e_addr ?: ~0ULL);
 	}
 
 	if (machine__create_extra_kernel_maps(machine, kernel))
 		pr_debug("Problems creating extra kernel maps, continuing anyway...\n");
 
-	/* update end address of the kernel map using adjacent module address */
+	/* update end address of the kernel map using adjacent module address
+	 * only when the kernel end could not be determined.
+	 */
 	map = map__next(machine__kernel_map(machine));
-	if (map)
+	if (!e_addr && map)
 		machine__set_kernel_mmap(machine, addr, map->start);
 out_put:
 	dso__put(kernel);
-- 
2.19.1

