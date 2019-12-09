Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7893C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 04:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8272F2071E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 04:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfLIE7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 23:59:04 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15440 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727133AbfLIE6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 23:58:53 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB94uqZq102256
        for <linux-kernel@vger.kernel.org>; Sun, 8 Dec 2019 23:58:52 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wrte5a4wu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 23:58:52 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <sourabhjain@linux.ibm.com>;
        Mon, 9 Dec 2019 04:58:50 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 9 Dec 2019 04:58:48 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB94wkbh18153684
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Dec 2019 04:58:46 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0BE5A4051;
        Mon,  9 Dec 2019 04:58:46 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C819A4040;
        Mon,  9 Dec 2019 04:58:45 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.124.35.249])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  9 Dec 2019 04:58:44 +0000 (GMT)
From:   Sourabh Jain <sourabhjain@linux.ibm.com>
To:     mpe@ellerman.id.au
Cc:     mahesh@linux.vnet.ibm.com, hbathini@linux.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        gregkh@linuxfoundation.org,
        Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: [PATCH v5 6/6] powerpc/fadump: sysfs for fadump memory reservation
Date:   Mon,  9 Dec 2019 10:28:26 +0530
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20191209045826.30076-1-sourabhjain@linux.ibm.com>
References: <20191209045826.30076-1-sourabhjain@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19120904-0028-0000-0000-000003C6B563
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120904-0029-0000-0000-00002489DF31
Message-Id: <20191209045826.30076-7-sourabhjain@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-09_01:2019-12-09,2019-12-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=1 mlxscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 mlxlogscore=985
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912090042
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a sys interface to allow querying the memory reserved by FADump for
saving the crash dump.

Also added Documentation/ABI for the new sysfs file.

Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 Documentation/ABI/testing/sysfs-kernel-fadump    | 7 +++++++
 Documentation/powerpc/firmware-assisted-dump.rst | 5 +++++
 arch/powerpc/kernel/fadump.c                     | 9 +++++++++
 3 files changed, 21 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-fadump b/Documentation/ABI/testing/sysfs-kernel-fadump
index 5d988b919e81..8f7a64a81783 100644
--- a/Documentation/ABI/testing/sysfs-kernel-fadump
+++ b/Documentation/ABI/testing/sysfs-kernel-fadump
@@ -31,3 +31,10 @@ Description:	write only
 		the system is booted to capture the vmcore using FADump.
 		It is used to release the memory reserved by FADump to
 		save the crash dump.
+
+What:		/sys/kernel/fadump/mem_reserved
+Date:		Dec 2019
+Contact:	linuxppc-dev@lists.ozlabs.org
+Description:	read only
+		Provide information about the amount of memory reserved by
+		FADump to save the crash dump in bytes.
diff --git a/Documentation/powerpc/firmware-assisted-dump.rst b/Documentation/powerpc/firmware-assisted-dump.rst
index 365c10209ef3..04993eaf3113 100644
--- a/Documentation/powerpc/firmware-assisted-dump.rst
+++ b/Documentation/powerpc/firmware-assisted-dump.rst
@@ -268,6 +268,11 @@ Here is the list of files under kernel sysfs:
     be handled and vmcore will not be captured. This interface can be
     easily integrated with kdump service start/stop.
 
+ /sys/kernel/fadump/mem_reserved
+
+   This is used to display the memory reserved by FADump for saving the
+   crash dump.
+
  /sys/kernel/fadump_release_mem
     This file is available only when FADump is active during
     second kernel. This is used to release the reserved memory
diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 35ecb51edc50..6f367e5b7970 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -1364,6 +1364,13 @@ static ssize_t enabled_show(struct kobject *kobj,
 	return sprintf(buf, "%d\n", fw_dump.fadump_enabled);
 }
 
+static ssize_t mem_reserved_show(struct kobject *kobj,
+				 struct kobj_attribute *attr,
+				 char *buf)
+{
+	return sprintf(buf, "%ld\n", fw_dump.reserve_dump_area_size);
+}
+
 static ssize_t registered_show(struct kobject *kobj,
 			       struct kobj_attribute *attr,
 			       char *buf)
@@ -1431,10 +1438,12 @@ EXPORT_SYMBOL_GPL(fadump_kobj);
 static struct kobj_attribute release_attr = __ATTR_WO(release_mem);
 static struct kobj_attribute enable_attr = __ATTR_RO(enabled);
 static struct kobj_attribute register_attr = __ATTR_RW(registered);
+static struct kobj_attribute mem_reserved_attr = __ATTR_RO(mem_reserved);
 
 static struct attribute *fadump_attrs[] = {
 	&enable_attr.attr,
 	&register_attr.attr,
+	&mem_reserved_attr.attr,
 	NULL,
 };
 
-- 
2.17.2

