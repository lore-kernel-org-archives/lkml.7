Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C321EC4CECD
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 13:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4C59214D9
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 13:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731090AbfIONX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 09:23:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32384 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730054AbfIONX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 09:23:26 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8FDMc6Y076696
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2019 09:23:26 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v1d9t23ae-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2019 09:23:26 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <sourabhjain@linux.ibm.com>;
        Sun, 15 Sep 2019 14:23:23 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 15 Sep 2019 14:23:21 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8FDNKkh40894762
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 15 Sep 2019 13:23:20 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 66C17A405F;
        Sun, 15 Sep 2019 13:23:20 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C7380A4067;
        Sun, 15 Sep 2019 13:23:17 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.54.91])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 15 Sep 2019 13:23:17 +0000 (GMT)
From:   Sourabh Jain <sourabhjain@linux.ibm.com>
To:     linuxppc-dev@ozlabs.org
Cc:     mahesh@linux.vnet.ibm.com, hbathini@linux.ibm.com,
        linux-kernel@vger.kernel.org, mpe@ellerman.id.au, corbet@lwn.net,
        linux-doc@vger.kernel.org
Subject: [PATCH 2/4] Documentation/ABI: add ABI documentation for /sys/kernel/fadump_*
Date:   Sun, 15 Sep 2019 18:53:08 +0530
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190915132310.13542-1-sourabhjain@linux.ibm.com>
References: <20190915132310.13542-1-sourabhjain@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19091513-4275-0000-0000-00000366642F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091513-4276-0000-0000-00003878C3FA
Message-Id: <20190915132310.13542-3-sourabhjain@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-15_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=902 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909150147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing ABI documentation for the already available fadump
sysfs files.

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
index 000000000000..972e8c427ad4
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-kernel-fadump_registered
@@ -0,0 +1,8 @@
+What:		/sys/kernel/fadump/fadump_registered
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

