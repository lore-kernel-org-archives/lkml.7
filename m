Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD185C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 05:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD8A420870
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 05:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729429AbfCYFpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 01:45:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56028 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729275AbfCYFpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 01:45:06 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2P5inHB004298
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 01:45:04 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rejdxnraj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 01:45:04 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <alastair@au1.ibm.com>;
        Mon, 25 Mar 2019 05:45:02 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Mar 2019 05:44:59 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2P5ixQB37552246
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Mar 2019 05:44:59 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF82542049;
        Mon, 25 Mar 2019 05:44:58 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9722F42042;
        Mon, 25 Mar 2019 05:44:58 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 25 Mar 2019 05:44:58 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 5C150A0161;
        Mon, 25 Mar 2019 16:44:57 +1100 (AEDT)
From:   "Alastair D'Silva" <alastair@au1.ibm.com>
To:     alastair@d-silva.org
Cc:     Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 0/7] Refactor OCXL driver to allow external drivers to use it
Date:   Mon, 25 Mar 2019 16:44:29 +1100
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190320053448.2098-1-alastair@au1.ibm.com>
References: <20190320053448.2098-1-alastair@au1.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19032505-0012-0000-0000-00000306B144
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032505-0013-0000-0000-0000213DD341
Message-Id: <20190325054438.15022-1-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-25_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=385 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903250044
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alastair D'Silva <alastair@d-silva.org>

Changelog:
V3:
  - For: 'ocxl: Create a clear delineation between ocxl backend & frontend'
      - Integrate Frederick Barrat's suggestions
      - Further cleanup on error paths
      - Remove release handler for AFU private data
      - Make ocxl_file_make_(in)visibile static & call from ocxl_file_(un)register
V2:
  - Reorder patches as some required structs that were only available later
  - Add dev.release implementation for ocxl_file_info to address warning on
    driver unload (ocxl: Create a clear delineation...)
  - Set output var irq_id in ocxl_afu_irq_alloc (ocxl: afu_irq only deals...)
  - Bump copyright year (ocxl: Provide global MMIO accessors...,
        ocxl: Split pci.c)

Alastair D'Silva (7):
  ocxl: Split pci.c
  ocxl: Don't pass pci_dev around
  ocxl: Create a clear delineation between ocxl backend & frontend
  ocxl: Allow external drivers to use OpenCAPI contexts
  ocxl: afu_irq only deals with IRQ IDs, not offsets
  ocxl: move event_fd handling to frontend
  ocxl: Provide global MMIO accessors for external drivers

 drivers/misc/ocxl/Makefile        |   3 +-
 drivers/misc/ocxl/afu_irq.c       | 104 +++---
 drivers/misc/ocxl/context.c       |  18 +-
 drivers/misc/ocxl/core.c          | 574 ++++++++++++++++++++++++++++++
 drivers/misc/ocxl/file.c          | 172 ++++++---
 drivers/misc/ocxl/mmio.c          | 234 ++++++++++++
 drivers/misc/ocxl/ocxl_internal.h |  46 ++-
 drivers/misc/ocxl/pci.c           | 565 ++---------------------------
 drivers/misc/ocxl/sysfs.c         |  59 +--
 drivers/misc/ocxl/trace.h         |  12 +-
 include/misc/ocxl.h               | 320 ++++++++++++++++-
 11 files changed, 1406 insertions(+), 701 deletions(-)
 create mode 100644 drivers/misc/ocxl/core.c
 create mode 100644 drivers/misc/ocxl/mmio.c

-- 
2.20.1

