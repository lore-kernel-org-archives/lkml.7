Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6EDC2BD09
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 12:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C1721823
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 12:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfLFMY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 07:24:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51928 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726322AbfLFMYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 07:24:55 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB6CHKIn066987
        for <linux-kernel@vger.kernel.org>; Fri, 6 Dec 2019 07:24:54 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wq2t3ygbb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 07:24:53 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <sourabhjain@linux.ibm.com>;
        Fri, 6 Dec 2019 12:24:51 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 6 Dec 2019 12:24:48 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB6COlXQ2097652
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Dec 2019 12:24:47 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F328C4C046;
        Fri,  6 Dec 2019 12:24:46 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C70D4C044;
        Fri,  6 Dec 2019 12:24:45 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.124.35.191])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  6 Dec 2019 12:24:45 +0000 (GMT)
From:   Sourabh Jain <sourabhjain@linux.ibm.com>
To:     mpe@ellerman.id.au
Cc:     mahesh@linux.vnet.ibm.com, hbathini@linux.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        gregkh@linuxfoundation.org,
        Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: [PATCH v4 3/6] powerpc/fadump: reorganize /sys/kernel/fadump_* sysfs files
Date:   Fri,  6 Dec 2019 17:54:31 +0530
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20191206122434.29587-1-sourabhjain@linux.ibm.com>
References: <20191206122434.29587-1-sourabhjain@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19120612-0028-0000-0000-000003C5F9B3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120612-0029-0000-0000-000024891F3F
Message-Id: <20191206122434.29587-4-sourabhjain@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-06_03:2019-12-05,2019-12-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=1 adultscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=999 mlxscore=0 impostorscore=0 clxscore=1015 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912060105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the number of FADump sysfs files increases it is hard to manage all of
them inside /sys/kernel directory. It's better to have all the FADump
related sysfs files in a dedicated directory /sys/kernel/fadump. But in
order to maintain backward compatibility a symlink has been added for every
sysfs that has moved to new location.

As the FADump sysfs files are now part of a dedicated directory there is no
need to prefix their name with fadump_, hence sysfs file names are also
updated. For example fadump_enabled sysfs file is now referred as enabled.

Also consolidate ABI documentation for all the FADump sysfs files in a
single file Documentation/ABI/testing/sysfs-kernel-fadump.

Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 Documentation/ABI/testing/sysfs-kernel-fadump | 33 ++++++++++
 arch/powerpc/kernel/fadump.c                  | 66 ++++++++++++++-----
 2 files changed, 83 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-fadump

diff --git a/Documentation/ABI/testing/sysfs-kernel-fadump b/Documentation/ABI/testing/sysfs-kernel-fadump
new file mode 100644
index 000000000000..5d988b919e81
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-kernel-fadump
@@ -0,0 +1,33 @@
+What:		/sys/kernel/fadump/*
+Date:		Dec 2019
+Contact:	linuxppc-dev@lists.ozlabs.org
+Description:
+		The /sys/kernel/fadump/* is a collection of FADump sysfs
+		file provide information about the configuration status
+		of Firmware Assisted Dump (FADump).
+
+What:		/sys/kernel/fadump/enabled
+Date:		Dec 2019
+Contact:	linuxppc-dev@lists.ozlabs.org
+Description:	read only
+		Primarily used to identify whether the FADump is enabled in
+		the kernel or not.
+User:		Kdump service
+
+What:		/sys/kernel/fadump/registered
+Date:		Dec 2019
+Contact:	linuxppc-dev@lists.ozlabs.org
+Description:	read/write
+		Helps to control the dump collect feature from userspace.
+		Setting 1 to this file enables the system to collect the
+		dump and 0 to disable it.
+User:		Kdump service
+
+What:		/sys/kernel/fadump/release_mem
+Date:		Dec 2019
+Contact:	linuxppc-dev@lists.ozlabs.org
+Description:	write only
+		This is a special sysfs file and only available when
+		the system is booted to capture the vmcore using FADump.
+		It is used to release the memory reserved by FADump to
+		save the crash dump.
diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index ed59855430b9..41a3cda81791 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -1418,13 +1418,16 @@ static int fadump_region_show(struct seq_file *m, void *private)
 	return 0;
 }
 
-static struct kobj_attribute fadump_release_attr = __ATTR(fadump_release_mem,
+struct kobject *fadump_kobj;
+EXPORT_SYMBOL_GPL(fadump_kobj);
+
+static struct kobj_attribute release_attr = __ATTR(release_mem,
 						0200, NULL,
 						fadump_release_memory_store);
-static struct kobj_attribute fadump_attr = __ATTR(fadump_enabled,
+static struct kobj_attribute enable_attr = __ATTR(enabled,
 						0444, fadump_enabled_show,
 						NULL);
-static struct kobj_attribute fadump_register_attr = __ATTR(fadump_registered,
+static struct kobj_attribute register_attr = __ATTR(registered,
 						0644, fadump_register_show,
 						fadump_register_store);
 
@@ -1435,16 +1438,11 @@ static void fadump_init_files(void)
 	struct dentry *debugfs_file;
 	int rc = 0;
 
-	rc = sysfs_create_file(kernel_kobj, &fadump_attr.attr);
-	if (rc)
-		printk(KERN_ERR "fadump: unable to create sysfs file"
-			" fadump_enabled (%d)\n", rc);
-
-	rc = sysfs_create_file(kernel_kobj, &fadump_register_attr.attr);
-	if (rc)
-		printk(KERN_ERR "fadump: unable to create sysfs file"
-			" fadump_registered (%d)\n", rc);
-
+	fadump_kobj = kobject_create_and_add("fadump", kernel_kobj);
+	if (!fadump_kobj) {
+		pr_err("failed to create fadump kobject\n");
+		return;
+	}
 	debugfs_file = debugfs_create_file("fadump_region", 0444,
 					powerpc_debugfs_root, NULL,
 					&fadump_region_fops);
@@ -1452,11 +1450,47 @@ static void fadump_init_files(void)
 		printk(KERN_ERR "fadump: unable to create debugfs file"
 				" fadump_region\n");
 
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
+
+	/* The FADump sysfs are moved from kernel_kobj to fadump_kobj need to
+	 * create symlink at old location to maintain backward compatibility.
+	 *
+	 *      - fadump_enabled -> fadump/enabled
+	 *      - fadump_registered -> fadump/registered
+	 *      - fadump_release_mem -> fadump/release_mem
+	 */
+	rc = create_sysfs_symlink_entry_to_kobj(kernel_kobj, fadump_kobj,
+						"enabled", "fadump_enabled");
+	if (rc)
+		pr_err("unable to create fadump_enabled symlink (%d)\n", rc);
+
+	rc = create_sysfs_symlink_entry_to_kobj(kernel_kobj, fadump_kobj,
+						"registered",
+						"fadump_registered");
+	if (rc)
+		pr_err("unable to create fadump_registered symlink (%d)\n", rc);
+
 	if (fw_dump.dump_active) {
-		rc = sysfs_create_file(kernel_kobj, &fadump_release_attr.attr);
+		rc = create_sysfs_symlink_entry_to_kobj(kernel_kobj,
+							fadump_kobj,
+							"release_mem",
+							"fadump_release_mem");
 		if (rc)
-			printk(KERN_ERR "fadump: unable to create sysfs file"
-				" fadump_release_mem (%d)\n", rc);
+			pr_err("unable to create fadump_release_mem symlink (%d)\n",
+			       rc);
 	}
 	return;
 }
-- 
2.17.2

