Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059D8CA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 13:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D875020700
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 13:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442810AbfJRNGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 09:06:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16414 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2442800AbfJRNGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 09:06:12 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9ID3DII020977
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 09:06:11 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vqcatuypm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 09:06:10 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <sourabhjain@linux.ibm.com>;
        Fri, 18 Oct 2019 14:06:08 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 18 Oct 2019 14:06:06 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9ID64kX32243746
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Oct 2019 13:06:04 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C5420A404D;
        Fri, 18 Oct 2019 13:06:04 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6900A4051;
        Fri, 18 Oct 2019 13:06:02 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.73.145])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 18 Oct 2019 13:06:02 +0000 (GMT)
From:   Sourabh Jain <sourabhjain@linux.ibm.com>
To:     mpe@ellerman.id.au
Cc:     mahesh@linux.vnet.ibm.com, hbathini@linux.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: [PATCH v2 0/4] reorganize and add FADump sysfs files
Date:   Fri, 18 Oct 2019 18:35:53 +0530
X-Mailer: git-send-email 2.17.2
X-TM-AS-GCONF: 00
x-cbid: 19101813-0008-0000-0000-000003234936
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101813-0009-0000-0000-00004A426AFB
Message-Id: <20191018130557.2217-1-sourabhjain@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-18_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=892 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910180123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, FADump sysfs files are present inside /sys/kernel directory.
But as the number of FADump sysfs file increases it is not a good idea to
push all of them in /sys/kernel directory. It is better to have separate
directory to keep all the FADump sysfs files.

The patch series reorganizes the FADump sysfs files and avail all the
existing FADump sysfs files present inside /sys/kernel into a new
directory /sys/kernel/fadump. Currently, all the FADump sysfs files
are replicated into a new directory to maintain the backward compatibility
and will eventually get removed in future. In addition to this a new FADump
sys interface is added to get the amount of memory reserved by FADump for
saving the crash dump.

Changelog v1->v2:
 - Move fadump_release_opalcore sysfs to FADump Kobject instead of
   replicating.
 - Changed the patch order 1,2,3,4 -> 2,1,3,4 (First add the ABI doc for
   exisiting sysfs file then replicate them under FADump kobject).

Sourabh Jain (4):
  Documentation/ABI: add ABI documentation for /sys/kernel/fadump_*
  powerpc/fadump: reorganize /sys/kernel/fadump_* sysfs files
  Documentation/ABI: mark /sys/kernel/fadump_* sysfs files deprecated
  powerpc/fadump: sysfs for fadump memory reservation

 .../ABI/obsolete/sysfs-kernel-fadump_enabled  | 10 ++++
 .../obsolete/sysfs-kernel-fadump_registered   | 11 +++++
 .../obsolete/sysfs-kernel-fadump_release_mem  | 11 +++++
 .../sysfs-kernel-fadump_release_opalcore      |  9 ++++
 Documentation/ABI/testing/sysfs-kernel-fadump | 48 +++++++++++++++++++
 .../powerpc/firmware-assisted-dump.rst        | 20 +++++++-
 arch/powerpc/kernel/fadump.c                  | 42 ++++++++++++++++
 arch/powerpc/platforms/powernv/opal-core.c    |  6 ++-
 8 files changed, 154 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/ABI/obsolete/sysfs-kernel-fadump_enabled
 create mode 100644 Documentation/ABI/obsolete/sysfs-kernel-fadump_registered
 create mode 100644 Documentation/ABI/obsolete/sysfs-kernel-fadump_release_mem
 create mode 100644 Documentation/ABI/removed/sysfs-kernel-fadump_release_opalcore
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-fadump

-- 
2.17.2

