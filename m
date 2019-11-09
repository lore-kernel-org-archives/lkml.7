Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49017C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 12:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1987A20659
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 12:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfKIMYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 07:24:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45782 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726591AbfKIMYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 07:24:08 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA9C6ZgZ016287
        for <linux-kernel@vger.kernel.org>; Sat, 9 Nov 2019 07:24:07 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w5s53e0fu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 09 Nov 2019 07:24:06 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <sourabhjain@linux.ibm.com>;
        Sat, 9 Nov 2019 12:24:04 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 9 Nov 2019 12:24:01 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA9CNNhM28639526
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 9 Nov 2019 12:23:24 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7FE7BA4055;
        Sat,  9 Nov 2019 12:23:59 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7384CA4051;
        Sat,  9 Nov 2019 12:23:57 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.73.97])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat,  9 Nov 2019 12:23:57 +0000 (GMT)
From:   Sourabh Jain <sourabhjain@linux.ibm.com>
To:     mpe@ellerman.id.au
Cc:     mahesh@linux.vnet.ibm.com, hbathini@linux.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: [PATCH v3 2/4] powerpc/fadump: reorganize /sys/kernel/fadump_* sysfs files
Date:   Sat,  9 Nov 2019 17:53:37 +0530
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20191109122339.20484-1-sourabhjain@linux.ibm.com>
References: <20191109122339.20484-1-sourabhjain@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19110912-0028-0000-0000-000003B46542
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19110912-0029-0000-0000-0000247768F0
Message-Id: <20191109122339.20484-3-sourabhjain@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-09_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911090131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the number of FADump sysfs files increases it is hard to manage all of
them inside /sys/kernel directory. It's better to have all the FADump
related sysfs files in a dedicated directory /sys/kernel/fadump. But in
order to maintain the backward compatibility the /sys/kernel/fadump_*
sysfs files are replicated inside /sys/kernel/fadump/ and eventually get
removed in future.

As the FADump sysfs files are now part of dedicated directory there is no
need to prefix their name with fadump_, hence sysfs file names are also
updated. For example fadump_enabled sysfs file is now referred as enabled.

Also consolidate ABI documentation for all the FADump sysfs files in a
single file Documentation/ABI/testing/sysfs-kernel-fadump.

Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 Documentation/ABI/testing/sysfs-kernel-fadump | 41 +++++++++++++++++++
 arch/powerpc/kernel/fadump.c                  | 38 +++++++++++++++++
 arch/powerpc/platforms/powernv/opal-core.c    | 10 +++--
 3 files changed, 86 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-fadump

diff --git a/Documentation/ABI/testing/sysfs-kernel-fadump b/Documentation/ABI/testing/sysfs-kernel-fadump
new file mode 100644
index 000000000000..a77f1a5ba389
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-kernel-fadump
@@ -0,0 +1,41 @@
+What:		/sys/kernel/fadump/*
+Date:		Nov 2019
+Contact:	linuxppc-dev@lists.ozlabs.org
+Description:
+		The /sys/kernel/fadump/* is a collection of FADump sysfs
+		file provide information about the configuration status
+		of Firmware Assisted Dump (FADump).
+
+What:		/sys/kernel/fadump/enabled
+Date:		Nov 2019
+Contact:	linuxppc-dev@lists.ozlabs.org
+Description:	read only
+		Primarily used to identify whether the FADump is enabled in
+		the kernel or not.
+User:		Kdump service
+
+What:		/sys/kernel/fadump/registered
+Date:		Nov 2019
+Contact:	linuxppc-dev@lists.ozlabs.org
+Description:	read/write
+		Helps to control the dump collect feature from userspace.
+		Setting 1 to this file enables the system to collect the
+		dump and 0 to disable it.
+User:		Kdump service
+
+What:		/sys/kernel/fadump/release_mem
+Date:		Nov 2019
+Contact:	linuxppc-dev@lists.ozlabs.org
+Description:	write only
+		This is a special sysfs file and only available when
+		the system is booted to capture the vmcore using FADump.
+		It is used to release the memory reserved by FADump to
+		save the crash dump.
+
+What:		/sys/kernel/fadump/release_opalcore
+Date:		Nov 2019
+Contact:	linuxppc-dev@lists.ozlabs.org
+Description:	write only
+		The sysfs file is available when the system is booted to
+		collect the dump on OPAL based machine. It used to release
+		the memory used to collect the opalcore.
diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index ed59855430b9..a9591def0c84 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -1418,6 +1418,9 @@ static int fadump_region_show(struct seq_file *m, void *private)
 	return 0;
 }
 
+struct kobject *fadump_kobj;
+EXPORT_SYMBOL_GPL(fadump_kobj);
+
 static struct kobj_attribute fadump_release_attr = __ATTR(fadump_release_mem,
 						0200, NULL,
 						fadump_release_memory_store);
@@ -1428,6 +1431,16 @@ static struct kobj_attribute fadump_register_attr = __ATTR(fadump_registered,
 						0644, fadump_register_show,
 						fadump_register_store);
 
+static struct kobj_attribute release_attr = __ATTR(release_mem,
+						0200, NULL,
+						fadump_release_memory_store);
+static struct kobj_attribute enable_attr = __ATTR(enabled,
+						0444, fadump_enabled_show,
+						NULL);
+static struct kobj_attribute register_attr = __ATTR(registered,
+						0644, fadump_register_show,
+						fadump_register_store);
+
 DEFINE_SHOW_ATTRIBUTE(fadump_region);
 
 static void fadump_init_files(void)
@@ -1435,6 +1448,11 @@ static void fadump_init_files(void)
 	struct dentry *debugfs_file;
 	int rc = 0;
 
+	fadump_kobj = kobject_create_and_add("fadump", kernel_kobj);
+	if (!fadump_kobj) {
+		pr_err("failed to create fadump kobject\n");
+		return;
+	}
 	rc = sysfs_create_file(kernel_kobj, &fadump_attr.attr);
 	if (rc)
 		printk(KERN_ERR "fadump: unable to create sysfs file"
@@ -1458,6 +1476,26 @@ static void fadump_init_files(void)
 			printk(KERN_ERR "fadump: unable to create sysfs file"
 				" fadump_release_mem (%d)\n", rc);
 	}
+	/* Replicating the following sysfs attributes under FADump kobject.
+	 *
+	 *	- fadump_enabled -> enabled
+	 *	- fadump_registered -> registered
+	 *	- fadump_release_mem -> release_mem
+	 */
+	rc = sysfs_create_file(fadump_kobj, &enable_attr.attr);
+	if (rc)
+		pr_err("unable to create enabled sysfs file (%d)\n",
+		       rc);
+	rc = sysfs_create_file(fadump_kobj, &register_attr.attr);
+	if (rc)
+		pr_err("unable to create registered sysfs file (%d)\n",
+		       rc);
+	if (fw_dump.dump_active) {
+		rc = sysfs_create_file(fadump_kobj, &release_attr.attr);
+		if (rc)
+			pr_err("unable to create release_mem sysfs file (%d)\n",
+			       rc);
+	}
 	return;
 }
 
diff --git a/arch/powerpc/platforms/powernv/opal-core.c b/arch/powerpc/platforms/powernv/opal-core.c
index ed895d82c048..b001e2242909 100644
--- a/arch/powerpc/platforms/powernv/opal-core.c
+++ b/arch/powerpc/platforms/powernv/opal-core.c
@@ -589,7 +589,7 @@ static ssize_t fadump_release_opalcore_store(struct kobject *kobj,
 	return count;
 }
 
-static struct kobj_attribute opalcore_rel_attr = __ATTR(fadump_release_opalcore,
+static struct kobj_attribute opalcore_rel_attr = __ATTR(release_opalcore,
 						0200, NULL,
 						fadump_release_opalcore_store);
 
@@ -625,9 +625,13 @@ static int __init opalcore_init(void)
 		return rc;
 	}
 
-	rc = sysfs_create_file(kernel_kobj, &opalcore_rel_attr.attr);
+	/*
+	 * Originally fadump_release_opalcore sysfs was part of kernel_kobj
+	 * later moved to fadump_kobj and renamed to release_opalcore.
+	 */
+	rc = sysfs_create_file(fadump_kobj, &opalcore_rel_attr.attr);
 	if (rc) {
-		pr_warn("unable to create sysfs file fadump_release_opalcore (%d)\n",
+		pr_warn("unable to create sysfs file release_opalcore (%d)\n",
 			rc);
 	}
 
-- 
2.17.2

