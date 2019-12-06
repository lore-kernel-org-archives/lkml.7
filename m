Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68309C2D0C0
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 12:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44BF221823
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 12:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfLFMYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 07:24:54 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36546 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726261AbfLFMYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 07:24:51 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB6CHQMP073710
        for <linux-kernel@vger.kernel.org>; Fri, 6 Dec 2019 07:24:50 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wq9hnsqpr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 07:24:49 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <sourabhjain@linux.ibm.com>;
        Fri, 6 Dec 2019 12:24:48 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 6 Dec 2019 12:24:45 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB6COiZI55312510
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Dec 2019 12:24:44 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 37E374C04A;
        Fri,  6 Dec 2019 12:24:44 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 950D44C044;
        Fri,  6 Dec 2019 12:24:42 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.124.35.191])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  6 Dec 2019 12:24:42 +0000 (GMT)
From:   Sourabh Jain <sourabhjain@linux.ibm.com>
To:     mpe@ellerman.id.au
Cc:     mahesh@linux.vnet.ibm.com, hbathini@linux.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        gregkh@linuxfoundation.org,
        Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: [PATCH v4 2/6] sysfs: wrap __compat_only_sysfs_link_entry_to_kobj function to change the symlink name
Date:   Fri,  6 Dec 2019 17:54:30 +0530
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20191206122434.29587-1-sourabhjain@linux.ibm.com>
References: <20191206122434.29587-1-sourabhjain@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19120612-4275-0000-0000-0000038C6157
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120612-4276-0000-0000-000038A00A09
Message-Id: <20191206122434.29587-3-sourabhjain@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-06_03:2019-12-05,2019-12-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=1 malwarescore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912060105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __compat_only_sysfs_link_entry_to_kobj function creates a symlink to a
kobject but doesn't provide an option to change the symlink file name.

This patch adds a wrapper function create_sysfs_symlink_entry_to_kobj that
extends the __compat_only_sysfs_link_entry_to_kobj functionality which
allows function caller to customize the symlink name.

Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 fs/sysfs/group.c      | 28 +++++++++++++++++++++++++---
 include/linux/sysfs.h | 12 ++++++++++++
 2 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
index d41c21fef138..5eb38145b957 100644
--- a/fs/sysfs/group.c
+++ b/fs/sysfs/group.c
@@ -424,6 +424,25 @@ EXPORT_SYMBOL_GPL(sysfs_remove_link_from_group);
 int __compat_only_sysfs_link_entry_to_kobj(struct kobject *kobj,
 				      struct kobject *target_kobj,
 				      const char *target_name)
+{
+	return create_sysfs_symlink_entry_to_kobj(kobj, target_kobj,
+						target_name, NULL);
+}
+EXPORT_SYMBOL_GPL(__compat_only_sysfs_link_entry_to_kobj);
+
+/**
+ * create_sysfs_symlink_entry_to_kobj - add a symlink to a kobject pointing
+ * to a group or an attribute
+ * @kobj:		The kobject containing the group.
+ * @target_kobj:	The target kobject.
+ * @target_name:	The name of the target group or attribute.
+ * @symlink_name:	The name of the symlink file (target_name will be
+ *			considered if symlink_name is NULL).
+ */
+int create_sysfs_symlink_entry_to_kobj(struct kobject *kobj,
+				       struct kobject *target_kobj,
+				       const char *target_name,
+				       const char *symlink_name)
 {
 	struct kernfs_node *target;
 	struct kernfs_node *entry;
@@ -448,12 +467,15 @@ int __compat_only_sysfs_link_entry_to_kobj(struct kobject *kobj,
 		return -ENOENT;
 	}
 
-	link = kernfs_create_link(kobj->sd, target_name, entry);
+	if (!symlink_name)
+		symlink_name = target_name;
+
+	link = kernfs_create_link(kobj->sd, symlink_name, entry);
 	if (IS_ERR(link) && PTR_ERR(link) == -EEXIST)
-		sysfs_warn_dup(kobj->sd, target_name);
+		sysfs_warn_dup(kobj->sd, symlink_name);
 
 	kernfs_put(entry);
 	kernfs_put(target);
 	return PTR_ERR_OR_ZERO(link);
 }
-EXPORT_SYMBOL_GPL(__compat_only_sysfs_link_entry_to_kobj);
+EXPORT_SYMBOL_GPL(create_sysfs_symlink_entry_to_kobj);
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index 5420817ed317..123c6f10333a 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -300,6 +300,10 @@ void sysfs_remove_link_from_group(struct kobject *kobj, const char *group_name,
 int __compat_only_sysfs_link_entry_to_kobj(struct kobject *kobj,
 				      struct kobject *target_kobj,
 				      const char *target_name);
+int create_sysfs_symlink_entry_to_kobj(struct kobject *kobj,
+				       struct kobject *target_kobj,
+				       const char *target_name,
+				       const char *symlink_name);
 
 void sysfs_notify(struct kobject *kobj, const char *dir, const char *attr);
 
@@ -508,6 +512,14 @@ static inline int __compat_only_sysfs_link_entry_to_kobj(
 	return 0;
 }
 
+static int create_sysfs_symlink_entry_to_kobj(struct kobject *kobj,
+					      struct kobject *target_kobj,
+					      const char *target_name,
+					      const char *symlink_name)
+{
+	return 0;
+}
+
 static inline void sysfs_notify(struct kobject *kobj, const char *dir,
 				const char *attr)
 {
-- 
2.17.2

