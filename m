Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CE3C2D0B1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 12:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7259C24675
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 12:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfLFMZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 07:25:02 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24846 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726261AbfLFMY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 07:24:57 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB6CGwdG015153
        for <linux-kernel@vger.kernel.org>; Fri, 6 Dec 2019 07:24:55 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wq9hg9r1d-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 07:24:55 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <sourabhjain@linux.ibm.com>;
        Fri, 6 Dec 2019 12:24:53 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 6 Dec 2019 12:24:51 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB6COn9f60489814
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Dec 2019 12:24:49 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 89A094C050;
        Fri,  6 Dec 2019 12:24:49 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E720A4C046;
        Fri,  6 Dec 2019 12:24:47 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.124.35.191])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  6 Dec 2019 12:24:47 +0000 (GMT)
From:   Sourabh Jain <sourabhjain@linux.ibm.com>
To:     mpe@ellerman.id.au
Cc:     mahesh@linux.vnet.ibm.com, hbathini@linux.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        gregkh@linuxfoundation.org,
        Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: [PATCH v4 4/6] powerpc/powernv: move core and fadump_release_opalcore under new kobject
Date:   Fri,  6 Dec 2019 17:54:32 +0530
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20191206122434.29587-1-sourabhjain@linux.ibm.com>
References: <20191206122434.29587-1-sourabhjain@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19120612-0016-0000-0000-000002D241F2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120612-0017-0000-0000-000033344BFE
Message-Id: <20191206122434.29587-5-sourabhjain@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-06_03:2019-12-05,2019-12-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 mlxscore=0 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=1 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912060105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The /sys/firmware/opal/core and /sys/kernel/fadump_release_opalcore sysfs
files are used to export and release the OPAL memory on PowerNV platform.
let's organize them into a new kobject under /sys/firmware/opal/mpipl/
directory.

A symlink is added to maintain the backward compatibility for
/sys/firmware/opal/core sysfs file.

Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 .../sysfs-kernel-fadump_release_opalcore      |  2 ++
 .../powerpc/firmware-assisted-dump.rst        | 15 +++++----
 arch/powerpc/platforms/powernv/opal-core.c    | 31 ++++++++++++++-----
 3 files changed, 34 insertions(+), 14 deletions(-)
 rename Documentation/ABI/{testing => removed}/sysfs-kernel-fadump_release_opalcore (82%)

diff --git a/Documentation/ABI/testing/sysfs-kernel-fadump_release_opalcore b/Documentation/ABI/removed/sysfs-kernel-fadump_release_opalcore
similarity index 82%
rename from Documentation/ABI/testing/sysfs-kernel-fadump_release_opalcore
rename to Documentation/ABI/removed/sysfs-kernel-fadump_release_opalcore
index 53313c1d4e7a..a8d46cd0f4e6 100644
--- a/Documentation/ABI/testing/sysfs-kernel-fadump_release_opalcore
+++ b/Documentation/ABI/removed/sysfs-kernel-fadump_release_opalcore
@@ -1,3 +1,5 @@
+This ABI is moved to /sys/firmware/opal/mpipl/release_core.
+
 What:		/sys/kernel/fadump_release_opalcore
 Date:		Sep 2019
 Contact:	linuxppc-dev@lists.ozlabs.org
diff --git a/Documentation/powerpc/firmware-assisted-dump.rst b/Documentation/powerpc/firmware-assisted-dump.rst
index 0455a78486d5..345a3405206e 100644
--- a/Documentation/powerpc/firmware-assisted-dump.rst
+++ b/Documentation/powerpc/firmware-assisted-dump.rst
@@ -112,13 +112,13 @@ to ensure that crash data is preserved to process later.
 
 -- On OPAL based machines (PowerNV), if the kernel is build with
    CONFIG_OPAL_CORE=y, OPAL memory at the time of crash is also
-   exported as /sys/firmware/opal/core file. This procfs file is
+   exported as /sys/firmware/opal/mpipl/core file. This procfs file is
    helpful in debugging OPAL crashes with GDB. The kernel memory
    used for exporting this procfs file can be released by echo'ing
-   '1' to /sys/kernel/fadump_release_opalcore node.
+   '1' to /sys/firmware/opal/mpipl/release_core node.
 
    e.g.
-     # echo 1 > /sys/kernel/fadump_release_opalcore
+     # echo 1 > /sys/firmware/opal/mpipl/release_core
 
 Implementation details:
 -----------------------
@@ -283,14 +283,17 @@ Here is the list of files under kernel sysfs:
     enhanced to use this interface to release the memory reserved for
     dump and continue without 2nd reboot.
 
- /sys/kernel/fadump_release_opalcore
+Note: /sys/kernel/fadump_release_opalcore sysfs has moved to
+      /sys/firmware/opal/mpipl/release_core
+
+ /sys/firmware/opal/mpipl/release_core
 
     This file is available only on OPAL based machines when FADump is
     active during capture kernel. This is used to release the memory
-    used by the kernel to export /sys/firmware/opal/core file. To
+    used by the kernel to export /sys/firmware/opal/mpipl/core file. To
     release this memory, echo '1' to it:
 
-    echo 1  > /sys/kernel/fadump_release_opalcore
+    echo 1  > /sys/firmware/opal/mpipl/release_core
 
 Here is the list of files under powerpc debugfs:
 (Assuming debugfs is mounted on /sys/kernel/debug directory.)
diff --git a/arch/powerpc/platforms/powernv/opal-core.c b/arch/powerpc/platforms/powernv/opal-core.c
index ed895d82c048..7fcc092d065e 100644
--- a/arch/powerpc/platforms/powernv/opal-core.c
+++ b/arch/powerpc/platforms/powernv/opal-core.c
@@ -589,7 +589,8 @@ static ssize_t fadump_release_opalcore_store(struct kobject *kobj,
 	return count;
 }
 
-static struct kobj_attribute opalcore_rel_attr = __ATTR(fadump_release_opalcore,
+struct kobject *mpipl_kobj;
+static struct kobj_attribute opalcore_rel_attr = __ATTR(release_core,
 						0200, NULL,
 						fadump_release_opalcore_store);
 
@@ -609,7 +610,7 @@ static int __init opalcore_init(void)
 	 * then capture the dump.
 	 */
 	if (!(is_opalcore_usable())) {
-		pr_err("Failed to export /sys/firmware/opal/core\n");
+		pr_err("Failed to export /sys/firmware/opal/mpipl/core\n");
 		opalcore_cleanup();
 		return rc;
 	}
@@ -617,18 +618,32 @@ static int __init opalcore_init(void)
 	/* Set OPAL core file size */
 	opal_core_attr.size = oc_conf->opalcore_size;
 
+	mpipl_kobj = kobject_create_and_add("mpipl", opal_kobj);
+	if (!mpipl_kobj) {
+		pr_err("unable to create mpipl kobject\n");
+		return -ENOMEM;
+	}
+
 	/* Export OPAL core sysfs file */
-	rc = sysfs_create_bin_file(opal_kobj, &opal_core_attr);
+	rc = sysfs_create_bin_file(mpipl_kobj, &opal_core_attr);
 	if (rc != 0) {
-		pr_err("Failed to export /sys/firmware/opal/core\n");
+		pr_err("Failed to export /sys/firmware/opal/mpipl/core\n");
 		opalcore_cleanup();
 		return rc;
 	}
-
-	rc = sysfs_create_file(kernel_kobj, &opalcore_rel_attr.attr);
+	/* The /sys/firmware/opal/core is moved to /sys/firmware/opal/mpipl/
+	 * directory, need to create symlink at old location to maintain
+	 * backward compatibility.
+	 */
+	rc = create_sysfs_symlink_entry_to_kobj(opal_kobj, mpipl_kobj,
+						"core", NULL);
+	if (rc) {
+		pr_err("unable to create core symlink (%d)\n", rc);
+		return rc;
+	}
+	rc = sysfs_create_file(mpipl_kobj, &opalcore_rel_attr.attr);
 	if (rc) {
-		pr_warn("unable to create sysfs file fadump_release_opalcore (%d)\n",
-			rc);
+		pr_warn("unable to create sysfs file release_core (%d)\n", rc);
 	}
 
 	return 0;
-- 
2.17.2

