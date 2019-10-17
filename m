Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F61ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 08:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 360E320663
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 08:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408442AbfJQI7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 04:59:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7992 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404051AbfJQI73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 04:59:29 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9H8vAIS049285
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 04:59:26 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vpjavx1g9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 04:59:26 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <iii@linux.ibm.com>;
        Thu, 17 Oct 2019 09:59:24 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 17 Oct 2019 09:59:21 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9H8xKoD40697858
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Oct 2019 08:59:20 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 28E61A4054;
        Thu, 17 Oct 2019 08:59:20 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6A40A405C;
        Thu, 17 Oct 2019 08:59:19 +0000 (GMT)
Received: from white.boeblingen.de.ibm.com (unknown [9.152.99.142])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 17 Oct 2019 08:59:19 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2] scripts/gdb: fix debugging modules on s390
Date:   Thu, 17 Oct 2019 10:59:17 +0200
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19101708-4275-0000-0000-00000372E37A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101708-4276-0000-0000-00003885FB4D
Message-Id: <20191017085917.81791-1-iii@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-17_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=910 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910170081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently lx-symbols assumes that module text is always located at
module->core_layout->base, but s390 uses the following layout:

+------+  <- module->core_layout->base
| GOT  |
+------+  <- module->core_layout->base + module->arch->plt_offset
| PLT  |
+------+  <- module->core_layout->base + module->arch->plt_offset +
| TEXT |     module->arch->plt_size
+------+

Therefore, when trying to debug modules on s390, all the symbol
addresses are skewed by plt_offset + plt_size.

Fix by adding plt_offset + plt_size to module_addr in
load_module_symbols().

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---

v1 -> v2: print the adjusted address.

 scripts/gdb/linux/symbols.py | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
index f0d8f2ecfde7..df4c810de663 100644
--- a/scripts/gdb/linux/symbols.py
+++ b/scripts/gdb/linux/symbols.py
@@ -15,7 +15,7 @@ import gdb
 import os
 import re
 
-from linux import modules
+from linux import modules, utils
 
 
 if hasattr(gdb, 'Breakpoint'):
@@ -111,6 +111,12 @@ lx-symbols command."""
             module_file = self._get_module_file(module_name)
 
         if module_file:
+            if utils.is_target_arch('s390'):
+                # Module text is preceded by PLT stubs on s390.
+                module_arch = module['arch']
+                plt_offset = int(module_arch['plt_offset'])
+                plt_size = int(module_arch['plt_size'])
+                module_addr = hex(int(module_addr, 0) + plt_offset + plt_size)
             gdb.write("loading @{addr}: {filename}\n".format(
                 addr=module_addr, filename=module_file))
             cmdline = "add-symbol-file {filename} {addr}{sections}".format(
-- 
2.23.0

