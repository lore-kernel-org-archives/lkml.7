Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7605DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 04:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B73A2070D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 04:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfCMEQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 00:16:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45614 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725893AbfCMEQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 00:16:15 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2D4FHTw041064
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 00:16:14 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2r6nmu3u28-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 00:16:13 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <alastair@au1.ibm.com>;
        Wed, 13 Mar 2019 04:16:11 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 13 Mar 2019 04:16:09 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2D4G87961145200
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Mar 2019 04:16:08 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2730852059;
        Wed, 13 Mar 2019 04:16:08 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id CB39C52054;
        Wed, 13 Mar 2019 04:16:07 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id EBCA8A01B5;
        Wed, 13 Mar 2019 15:16:04 +1100 (AEDT)
From:   "Alastair D'Silva" <alastair@au1.ibm.com>
Cc:     "Alastair D'Silva" <alastair@d-silva.org>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/7] Refactor OCXL driver to allow external drivers to use it
Date:   Wed, 13 Mar 2019 15:15:15 +1100
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19031304-0020-0000-0000-00000321E76C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031304-0021-0000-0000-00002174163C
Message-Id: <20190313041524.14644-1-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-13_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=708 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903130029
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alastair D'Silva <alastair@d-silva.org>

This series reworks the OpenCAPI driver to split frontend
(driver interactions) from backend (hardware interactions).

This allows external drivers to utilise the core of the
generic OpenCAPI driver to communicate with specific
OpenCAPI hardware.

Alastair D'Silva (7):
  ocxl: Provide global MMIO accessors for external drivers
  ocxl: Allow external drivers to use OpenCAPI contexts
  ocxl: Split pci.c
  ocxl: Don't pass pci_dev around
  ocxl: Create a clear delineation between ocxl backend & frontend
  ocxl: afu_irq only deals with IRQ IDs, not offsets
  ocxl: move event_fd handling to frontend

 drivers/misc/ocxl/Makefile        |   3 +-
 drivers/misc/ocxl/afu_irq.c       |  94 ++---
 drivers/misc/ocxl/context.c       |  18 +-
 drivers/misc/ocxl/core.c          | 578 ++++++++++++++++++++++++++++++
 drivers/misc/ocxl/file.c          | 157 +++++---
 drivers/misc/ocxl/mmio.c          | 234 ++++++++++++
 drivers/misc/ocxl/ocxl_internal.h |  49 +--
 drivers/misc/ocxl/pci.c           | 562 ++---------------------------
 drivers/misc/ocxl/sysfs.c         |  58 +--
 drivers/misc/ocxl/trace.h         |  12 +-
 include/misc/ocxl.h               | 322 ++++++++++++++++-
 11 files changed, 1382 insertions(+), 705 deletions(-)
 create mode 100644 drivers/misc/ocxl/core.c
 create mode 100644 drivers/misc/ocxl/mmio.c

-- 
2.20.1

