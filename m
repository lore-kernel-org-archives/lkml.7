Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75CFC2BD09
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 12:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1F5121823
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 12:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbfLFMYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 07:24:47 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50148 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726140AbfLFMYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 07:24:47 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB6CGtWT109362
        for <linux-kernel@vger.kernel.org>; Fri, 6 Dec 2019 07:24:46 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wq9hm9st1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 07:24:45 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <sourabhjain@linux.ibm.com>;
        Fri, 6 Dec 2019 12:24:42 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 6 Dec 2019 12:24:40 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB6COclV38207704
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Dec 2019 12:24:38 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0FDA4C040;
        Fri,  6 Dec 2019 12:24:38 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16A064C044;
        Fri,  6 Dec 2019 12:24:37 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.124.35.191])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  6 Dec 2019 12:24:36 +0000 (GMT)
From:   Sourabh Jain <sourabhjain@linux.ibm.com>
To:     mpe@ellerman.id.au
Cc:     mahesh@linux.vnet.ibm.com, hbathini@linux.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        gregkh@linuxfoundation.org,
        Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: [PATCH v4 0/6] reorganize and add FADump sysfs files
Date:   Fri,  6 Dec 2019 17:54:28 +0530
X-Mailer: git-send-email 2.17.2
X-TM-AS-GCONF: 00
x-cbid: 19120612-0020-0000-0000-00000394F60D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120612-0021-0000-0000-000021EC28EA
Message-Id: <20191206122434.29587-1-sourabhjain@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-06_03:2019-12-05,2019-12-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 adultscore=0 suspectscore=1 impostorscore=0
 clxscore=1015 spamscore=0 mlxlogscore=769 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912060105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, FADump sysfs files are present inside /sys/kernel directory.
But as the number of FADump sysfs file increases it is not a good idea to
push all of them in /sys/kernel directory. It is better to have separate
directory to keep all the FADump sysfs files.

Patch series reorganizes the FADump sysfs files and avail all the existing
FADump sysfs files present inside /sys/kernel into a new directory
/sys/kernel/fadump. The backward compatibility is maintained by adding a
symlink for every sysfs file that has moved to new location. Also a new
FADump sys interface is added to get the amount of memory reserved by FADump
for saving the crash dump.

Changelog:
v1 -> v2:
 - Move fadump_release_opalcore sysfs to FADump Kobject instead of
   replicating.
 - Changed the patch order 1,2,3,4 -> 2,1,3,4 (First add the ABI doc for
   exisiting sysfs file then replicate them under FADump kobject).

v2 -> v3:
 - Remove the fadump_ prefix from replicated FADump sysfs file names.

 v3 -> v4:
 - New patch that adds a wrapper function to create symlink with
   custom symlink file name.
 - Add symlink instead of replicating the FADump sysfs files.
 - Move the OPAL core rel

Sourabh Jain (6):
  Documentation/ABI: add ABI documentation for /sys/kernel/fadump_*
  sysfs: wrap __compat_only_sysfs_link_entry_to_kobj function to change
    the symlink name
  powerpc/fadump: reorganize /sys/kernel/fadump_* sysfs files
  powerpc/powernv: move core and fadump_release_opalcore under new
    kobject
  Documentation/ABI: mark /sys/kernel/fadump_* sysfs files deprecated
  powerpc/fadump: sysfs for fadump memory reservation

 .../ABI/obsolete/sysfs-kernel-fadump_enabled  |  9 +++
 .../obsolete/sysfs-kernel-fadump_registered   | 10 +++
 .../obsolete/sysfs-kernel-fadump_release_mem  | 10 +++
 .../sysfs-kernel-fadump_release_opalcore      |  9 +++
 Documentation/ABI/testing/sysfs-kernel-fadump | 40 +++++++++
 .../powerpc/firmware-assisted-dump.rst        | 28 +++++--
 arch/powerpc/kernel/fadump.c                  | 81 +++++++++++++++----
 arch/powerpc/platforms/powernv/opal-core.c    | 31 +++++--
 fs/sysfs/group.c                              | 28 ++++++-
 include/linux/sysfs.h                         | 12 +++
 10 files changed, 225 insertions(+), 33 deletions(-)
 create mode 100644 Documentation/ABI/obsolete/sysfs-kernel-fadump_enabled
 create mode 100644 Documentation/ABI/obsolete/sysfs-kernel-fadump_registered
 create mode 100644 Documentation/ABI/obsolete/sysfs-kernel-fadump_release_mem
 create mode 100644 Documentation/ABI/removed/sysfs-kernel-fadump_release_opalcore
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-fadump

-- 
2.17.2

