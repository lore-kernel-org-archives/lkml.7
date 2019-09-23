Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A418C32755
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A31420835
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394551AbfIWMfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 08:35:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29594 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2394414AbfIWMfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 08:35:17 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8NCRPwP103522
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 08:35:15 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v6v2sw5h8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 08:35:13 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Mon, 23 Sep 2019 13:35:05 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 23 Sep 2019 13:35:01 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8NCYxoB39387640
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Sep 2019 12:34:59 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C919411C04C;
        Mon, 23 Sep 2019 12:34:59 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6988F11C052;
        Mon, 23 Sep 2019 12:34:59 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 23 Sep 2019 12:34:59 +0000 (GMT)
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Christoph Hellwig <hch@lst.de>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [RFC PATCH 0/3] fix dma_mask for CCW devices 
Date:   Mon, 23 Sep 2019 14:34:15 +0200
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
x-cbid: 19092312-0028-0000-0000-000003A17E63
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19092312-0029-0000-0000-000024638F43
Message-Id: <20190923123418.22695-1-pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-23_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=698 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909230124
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 37db8985b211 ("s390/cio: add basic protected virtualization
support") breaks virtio-ccw devices with VIRTIO_F_IOMMU_PLATFORM for non
Protected Virtualization (PV) guests. The problem is that the dma_mask
of the CCW device, which is used by virtio core, gets changed from 64 to
31 bit. This is done because some of the DMA allocations do require 31
bit addressable memory, but it has unfavorable side effects. 

For PV the only drawback is that some of the virtio structures must end
up in ZONE_DMA (with PV we have the bounce the buffers mapped via DMA
API anyway).

But for non PV guests we have a problem: because of the 31 bit mask
guests bigger than 2G are likely to try bouncing buffers. The swiotlb
however is only initialized for PV guests (because we don't want to
bounce anything for non PV guests). The first map of a buffer with
an address beyond 0x7fffffff kills the guest.

This series sets out to fix this problem by first making the GPF_DMA
flag count for DMA API allocations -- on s390 at least.  Then we set
dma_mask to 64 bit and do the allocations for the memory that needs to
be 31 bit addressable with the GPF_DMA flag.

For CCW devices we could probably just not clear any GFP flags at
all but, I decided to be conservative and change only what really needs
to be changed.

I'm not perfectly satisfied with this solution, but I believe it is good
enough, and I can't think of anything better at the moment. Ideas
welcome.

Halil Pasic (3):
  dma-mapping: make overriding GFP_* flags arch customizable
  s390/virtio: fix virtio-ccw DMA without PV
  dma-mapping: warn on harmful GFP_* flags

 arch/s390/Kconfig             |  1 +
 arch/s390/include/asm/cio.h   |  5 +++--
 arch/s390/mm/init.c           | 20 ++++++++++++++++++++
 drivers/s390/cio/css.c        | 16 +++++++++-------
 drivers/s390/cio/device.c     |  5 +++--
 drivers/s390/cio/device_ops.c |  3 ++-
 include/linux/dma-mapping.h   | 13 +++++++++++++
 kernel/dma/Kconfig            |  6 ++++++
 kernel/dma/mapping.c          |  4 +---
 9 files changed, 58 insertions(+), 15 deletions(-)

-- 
2.17.1

