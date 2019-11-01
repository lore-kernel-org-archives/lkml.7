Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC31BCA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 18:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B87E8217F9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 18:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbfKASLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 14:11:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30424 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726866AbfKASLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 14:11:36 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA1HqF51171860;
        Fri, 1 Nov 2019 14:11:33 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w0ce1ft56-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Nov 2019 14:11:32 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id xA1HqF22171855;
        Fri, 1 Nov 2019 14:11:32 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w0ce1ft4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Nov 2019 14:11:31 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xA1I9TNR018896;
        Fri, 1 Nov 2019 18:11:31 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma05wdc.us.ibm.com with ESMTP id 2vxwh6jdxh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Nov 2019 18:11:31 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA1IBUU951708184
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 Nov 2019 18:11:30 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C052124054;
        Fri,  1 Nov 2019 18:11:30 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4B64124052;
        Fri,  1 Nov 2019 18:11:29 +0000 (GMT)
Received: from rascal.austin.ibm.com (unknown [9.41.179.32])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  1 Nov 2019 18:11:29 +0000 (GMT)
From:   Scott Cheloha <cheloha@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Hildenbrand <david@redhat.com>
Cc:     nathanl@linux.ibm.com, ricklind@linux.vnet.ibm.com,
        Scott Cheloha <cheloha@linux.vnet.ibm.com>
Subject: [PATCH] drivers/base/memory.c: memory subsys init: skip search for missing blocks
Date:   Fri,  1 Nov 2019 13:10:54 -0500
Message-Id: <20191101181054.11521-1-cheloha@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.24.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-01_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1911010163
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a flag to init_memory_block() to  enable/disable searching for a
matching block before creating a device for the block and adding it to
the memory subsystem's bus.

When the memory subsystem is being initialized there is no need to check
if a given block has already been added to its bus.  The bus is new, so the
block in question cannot yet have a corresponding device.

The search for a missing block is O(n) so this saves substantial time at
boot if there are many such blocks to add.

Signed-off-by: Scott Cheloha <cheloha@linux.vnet.ibm.com>
---
 drivers/base/memory.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 55907c27075b..1160df4a8feb 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -643,17 +643,21 @@ int register_memory(struct memory_block *memory)
 }
 
 static int init_memory_block(struct memory_block **memory,
-			     unsigned long block_id, unsigned long state)
+			     unsigned long block_id, unsigned long state,
+			     bool may_exist)
 {
 	struct memory_block *mem;
 	unsigned long start_pfn;
 	int ret = 0;
 
-	mem = find_memory_block_by_id(block_id);
-	if (mem) {
-		put_device(&mem->dev);
-		return -EEXIST;
+	if (may_exist) {
+		mem = find_memory_block_by_id(block_id);
+		if (mem) {
+			put_device(&mem->dev);
+			return -EEXIST;
+		}
 	}
+
 	mem = kzalloc(sizeof(*mem), GFP_KERNEL);
 	if (!mem)
 		return -ENOMEM;
@@ -684,7 +688,7 @@ static int add_memory_block(unsigned long base_section_nr)
 	if (section_count == 0)
 		return 0;
 	ret = init_memory_block(&mem, base_memory_block_id(base_section_nr),
-				MEM_ONLINE);
+				MEM_ONLINE, false);
 	if (ret)
 		return ret;
 	mem->section_count = section_count;
@@ -720,7 +724,7 @@ int create_memory_block_devices(unsigned long start, unsigned long size)
 
 	mutex_lock(&mem_sysfs_mutex);
 	for (block_id = start_block_id; block_id != end_block_id; block_id++) {
-		ret = init_memory_block(&mem, block_id, MEM_OFFLINE);
+		ret = init_memory_block(&mem, block_id, MEM_OFFLINE, true);
 		if (ret)
 			break;
 		mem->section_count = sections_per_block;
-- 
2.24.0.rc1

