Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10744C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 04:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B130A2071E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 04:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfLIE6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 23:58:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35246 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727065AbfLIE6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 23:58:40 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB94upMk023552
        for <linux-kernel@vger.kernel.org>; Sun, 8 Dec 2019 23:58:39 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wrt9wa11b-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 23:58:39 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <sourabhjain@linux.ibm.com>;
        Mon, 9 Dec 2019 04:58:38 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 9 Dec 2019 04:58:35 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB94wXaM60882964
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Dec 2019 04:58:33 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BDDF2A4040;
        Mon,  9 Dec 2019 04:58:33 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A881A4053;
        Mon,  9 Dec 2019 04:58:32 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.124.35.249])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  9 Dec 2019 04:58:31 +0000 (GMT)
From:   Sourabh Jain <sourabhjain@linux.ibm.com>
To:     mpe@ellerman.id.au
Cc:     mahesh@linux.vnet.ibm.com, hbathini@linux.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        gregkh@linuxfoundation.org,
        Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: [PATCH v5 1/6] Documentation/ABI: add ABI documentation for /sys/kernel/fadump_*
Date:   Mon,  9 Dec 2019 10:28:21 +0530
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20191209045826.30076-1-sourabhjain@linux.ibm.com>
References: <20191209045826.30076-1-sourabhjain@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19120904-0008-0000-0000-0000033EF8A9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120904-0009-0000-0000-00004A5E23E9
Message-Id: <20191209045826.30076-2-sourabhjain@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-09_01:2019-12-09,2019-12-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 suspectscore=1 mlxscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 mlxlogscore=872 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912090042
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing ABI documentation for existing FADump sysfs files.

Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 Documentation/ABI/testing/sysfs-kernel-fadump_enabled     | 7 +++++++
 Documentation/ABI/testing/sysfs-kernel-fadump_registered  | 8 ++++++++
 Documentation/ABI/testing/sysfs-kernel-fadump_release_mem | 8 ++++++++
 .../ABI/testing/sysfs-kernel-fadump_release_opalcore      | 7 +++++++
 4 files changed, 30 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-fadump_enabled
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-fadump_registered
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-fadump_release_mem
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-fadump_release_opalcore

diff --git a/Documentation/ABI/testing/sysfs-kernel-fadump_enabled b/Documentation/ABI/testing/sysfs-kernel-fadump_enabled
new file mode 100644
index 000000000000..f73632b1c006
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-kernel-fadump_enabled
@@ -0,0 +1,7 @@
+What:		/sys/kernel/fadump_enabled
+Date:		Feb 2012
+Contact:	linuxppc-dev@lists.ozlabs.org
+Description:	read only
+		Primarily used to identify whether the FADump is enabled in
+		the kernel or not.
+User:		Kdump service
diff --git a/Documentation/ABI/testing/sysfs-kernel-fadump_registered b/Documentation/ABI/testing/sysfs-kernel-fadump_registered
new file mode 100644
index 000000000000..dcf925e53f0f
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-kernel-fadump_registered
@@ -0,0 +1,8 @@
+What:		/sys/kernel/fadump_registered
+Date:		Feb 2012
+Contact:	linuxppc-dev@lists.ozlabs.org
+Description:	read/write
+		Helps to control the dump collect feature from userspace.
+		Setting 1 to this file enables the system to collect the
+		dump and 0 to disable it.
+User:		Kdump service
diff --git a/Documentation/ABI/testing/sysfs-kernel-fadump_release_mem b/Documentation/ABI/testing/sysfs-kernel-fadump_release_mem
new file mode 100644
index 000000000000..9c20d64ab48d
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-kernel-fadump_release_mem
@@ -0,0 +1,8 @@
+What:		/sys/kernel/fadump_release_mem
+Date:		Feb 2012
+Contact:	linuxppc-dev@lists.ozlabs.org
+Description:	write only
+		This is a special sysfs file and only available when
+		the system is booted to capture the vmcore using FADump.
+		It is used to release the memory reserved by FADump to
+		save the crash dump.
diff --git a/Documentation/ABI/testing/sysfs-kernel-fadump_release_opalcore b/Documentation/ABI/testing/sysfs-kernel-fadump_release_opalcore
new file mode 100644
index 000000000000..53313c1d4e7a
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-kernel-fadump_release_opalcore
@@ -0,0 +1,7 @@
+What:		/sys/kernel/fadump_release_opalcore
+Date:		Sep 2019
+Contact:	linuxppc-dev@lists.ozlabs.org
+Description:	write only
+		The sysfs file is available when the system is booted to
+		collect the dump on OPAL based machine. It used to release
+		the memory used to collect the opalcore.
-- 
2.17.2

