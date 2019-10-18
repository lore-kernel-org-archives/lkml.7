Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 576FACA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 13:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DA5120700
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 13:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442825AbfJRNGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 09:06:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21072 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2442814AbfJRNGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 09:06:20 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9ID39TN078648
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 09:06:18 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vqdb99p26-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 09:06:17 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <sourabhjain@linux.ibm.com>;
        Fri, 18 Oct 2019 14:06:15 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 18 Oct 2019 14:06:13 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9ID6CBr44368202
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Oct 2019 13:06:12 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 30556A4051;
        Fri, 18 Oct 2019 13:06:12 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45C23A404D;
        Fri, 18 Oct 2019 13:06:10 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.73.145])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 18 Oct 2019 13:06:10 +0000 (GMT)
From:   Sourabh Jain <sourabhjain@linux.ibm.com>
To:     mpe@ellerman.id.au
Cc:     mahesh@linux.vnet.ibm.com, hbathini@linux.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: [PATCH v2 2/4] powerpc/fadump: reorganize /sys/kernel/fadump_* sysfs files
Date:   Fri, 18 Oct 2019 18:35:55 +0530
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20191018130557.2217-1-sourabhjain@linux.ibm.com>
References: <20191018130557.2217-1-sourabhjain@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19101813-4275-0000-0000-0000037352CC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101813-4276-0000-0000-000038866F0F
Message-Id: <20191018130557.2217-3-sourabhjain@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-18_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910180123
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

Consolidate ABI documentation for all the FADump sysfs file in a single
file Documentation/ABI/testing/sysfs-kernel-fadump.

Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 Documentation/ABI/testing/sysfs-kernel-fadump | 41 +++++++++++++++++++
 arch/powerpc/kernel/fadump.c                  | 28 +++++++++++++
 arch/powerpc/platforms/powernv/opal-core.c    |  6 ++-
 3 files changed, 74 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-fadump

diff --git a/Documentation/ABI/testing/sysfs-kernel-fadump b/Documentation/ABI/testing/sysfs-kernel-fadump
new file mode 100644
index 000000000000..dbf0606ba917
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-kernel-fadump
@@ -0,0 +1,41 @@
+What:		/sys/kernel/fadump/*
+Date:		Oct 2019
+Contact:	linuxppc-dev@lists.ozlabs.org
+Description:
+		The /sys/kernel/fadump/* is a collection of FADump sysfs
+		file provide information about the configuration status
+		of Firmware Assisted Dump (FADump).
+
+What:		/sys/kernel/fadump/fadump_enabled
+Date:		Oct 2019
+Contact:	linuxppc-dev@lists.ozlabs.org
+Description:	read only
+		Primarily used to identify whether the FADump is enabled in
+		the kernel or not.
+User:		Kdump service
+
+What:		/sys/kernel/fadump/fadump_registered
+Date:		Oct 2019
+Contact:	linuxppc-dev@lists.ozlabs.org
+Description:	read/write
+		Helps to control the dump collect feature from userspace.
+		Setting 1 to this file enables the system to collect the
+		dump and 0 to disable it.
+User:		Kdump service
+
+What:		/sys/kernel/fadump/fadump_release_mem
+Date:		Oct 2019
+Contact:	linuxppc-dev@lists.ozlabs.org
+Description:	write only
+		This is a special sysfs file and only available when
+		the system is booted to capture the vmcore using FADump.
+		It is used to release the memory reserved by FADump to
+		save the crash dump.
+
+What:		/sys/kernel/fadump/fadump_release_opalcore
+Date:		Oct 2019
+Contact:	linuxppc-dev@lists.ozlabs.org
+Description:	write only
+		The sysfs file is available when the system is booted to
+		collect the dump on OPAL based machine. It used to release
+		the memory used to collect the opalcore.
diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index ed59855430b9..866eddc279d8 100644
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
@@ -1435,6 +1438,11 @@ static void fadump_init_files(void)
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
@@ -1458,6 +1466,26 @@ static void fadump_init_files(void)
 			printk(KERN_ERR "fadump: unable to create sysfs file"
 				" fadump_release_mem (%d)\n", rc);
 	}
+	/* Replicating the following sysfs attributes under FADump kobject.
+	 *
+	 *	- fadump_enabled
+	 *	- fadump_registered
+	 *	- fadump_release_mem
+	 */
+	rc = sysfs_create_file(fadump_kobj, &fadump_attr.attr);
+	if (rc)
+		pr_err("unable to create fadump/fadump_enabled sysfs file (%d)\n",
+		       rc);
+	rc = sysfs_create_file(fadump_kobj, &fadump_register_attr.attr);
+	if (rc)
+		pr_err("unable to create fadump/fadump_registered sysfs file (%d)\n",
+		       rc);
+	if (fw_dump.dump_active) {
+		rc = sysfs_create_file(fadump_kobj, &fadump_release_attr.attr);
+		if (rc)
+			pr_err("unable to create fadump/fadump_release_mem sysfs file (%d)\n",
+			       rc);
+	}
 	return;
 }
 
diff --git a/arch/powerpc/platforms/powernv/opal-core.c b/arch/powerpc/platforms/powernv/opal-core.c
index ed895d82c048..2c7355768d3f 100644
--- a/arch/powerpc/platforms/powernv/opal-core.c
+++ b/arch/powerpc/platforms/powernv/opal-core.c
@@ -625,7 +625,11 @@ static int __init opalcore_init(void)
 		return rc;
 	}
 
-	rc = sysfs_create_file(kernel_kobj, &opalcore_rel_attr.attr);
+	/*
+	 * Originally fadump_release_opalcore sysfs was part of kernel_kobj
+	 * later moved to fadump_kobj.
+	 */
+	rc = sysfs_create_file(fadump_kobj, &opalcore_rel_attr.attr);
 	if (rc) {
 		pr_warn("unable to create sysfs file fadump_release_opalcore (%d)\n",
 			rc);
-- 
2.17.2

