Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FB3C17441
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 23:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCBB620865
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 23:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbfKHXAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 18:00:51 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39402 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726121AbfKHXAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 18:00:51 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA8MvEnh060123
        for <linux-kernel@vger.kernel.org>; Fri, 8 Nov 2019 18:00:50 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w5heb09qh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 18:00:49 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <linuxram@us.ibm.com>;
        Fri, 8 Nov 2019 23:00:47 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 8 Nov 2019 23:00:43 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA8N0hGA9240610
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Nov 2019 23:00:43 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E3AD3AE057;
        Fri,  8 Nov 2019 23:00:42 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E075AE05F;
        Fri,  8 Nov 2019 23:00:39 +0000 (GMT)
Received: from oc0525413822.ibm.com (unknown [9.80.217.215])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  8 Nov 2019 23:00:39 +0000 (GMT)
From:   Ram Pai <linuxram@us.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     benh@kernel.crashing.org, david@gibson.dropbear.id.au,
        mpe@ellerman.id.au, paulus@ozlabs.org, mdroth@linux.vnet.ibm.com,
        hch@lst.de, linuxram@us.ibm.com, andmike@us.ibm.com,
        sukadev@linux.vnet.ibm.com, mst@redhat.com, ram.n.pai@gmail.com,
        aik@ozlabs.ru, cai@lca.pw, tglx@linutronix.de,
        bauerman@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: [RFC v2 0/2] Enable IOMMU support for pseries Secure VMs
Date:   Fri,  8 Nov 2019 15:00:09 -0800
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 19110823-0008-0000-0000-0000032CDBBA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19110823-0009-0000-0000-00004A4BE5E7
Message-Id: <1573254011-1604-1-git-send-email-linuxram@us.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-08_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=427 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911080221
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series enables IOMMU support for pseries Secure VMs.

Tested using QEMU command line option:

 "-device virtio-scsi-pci,id=scsi0,bus=pci.0,addr=0x4,
 	iommu_platform=on,disable-modern=off,disable-legacy=on"
 and 

 "-device virtio-blk-pci,scsi=off,bus=pci.0,
 	addr=0x5,drive=drive-virtio-disk0,id=virtio-disk0,
 	iommu_platform=on,disable-modern=off,disable-legacy=on"

changelog:
	v2: added comments describing the changes.
		requested by Alexey and Michael Ellermen.

Ram Pai (2):
  powerpc/pseries/iommu: Share the per-cpu TCE page with the hypervisor.
  powerpc/pseries/iommu: Use dma_iommu_ops for Secure VMs aswell.

 arch/powerpc/platforms/pseries/iommu.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

-- 
1.8.3.1

