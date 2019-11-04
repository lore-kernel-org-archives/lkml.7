Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8B2CA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 691BE20B7C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729646AbfKDV3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 16:29:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28836 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728377AbfKDV3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 16:29:41 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA4LT2pZ070320
        for <linux-kernel@vger.kernel.org>; Mon, 4 Nov 2019 16:29:40 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w2un30qyn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 16:29:40 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <linuxram@us.ibm.com>;
        Mon, 4 Nov 2019 21:29:38 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 4 Nov 2019 21:29:35 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA4LTYFU19464226
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Nov 2019 21:29:34 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D264A405B;
        Mon,  4 Nov 2019 21:29:34 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 52178A405F;
        Mon,  4 Nov 2019 21:29:30 +0000 (GMT)
Received: from oc0525413822.ibm.com (unknown [9.85.192.56])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  4 Nov 2019 21:29:30 +0000 (GMT)
From:   Ram Pai <linuxram@us.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     benh@kernel.crashing.org, david@gibson.dropbear.id.au,
        mpe@ellerman.id.au, paulus@ozlabs.org, mdroth@linux.vnet.ibm.com,
        hch@lst.de, linuxram@us.ibm.com, andmike@us.ibm.com,
        sukadev@linux.vnet.ibm.com, mst@redhat.com, ram.n.pai@gmail.com,
        aik@ozlabs.ru, cai@lca.pw, tglx@linutronix.de,
        bauerman@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: [RFC v1 0/2] Enable IOMMU support for pseries Secure VMs
Date:   Mon,  4 Nov 2019 13:28:41 -0800
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 19110421-0008-0000-0000-0000032AAC47
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19110421-0009-0000-0000-00004A4A03AE
Message-Id: <1572902923-8096-1-git-send-email-linuxram@us.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-04_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=408 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1911040205
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

Ram Pai (2):
  powerpc/pseries/iommu: Share the per-cpu TCE page with the hypervisor.
  powerpc/pseries/iommu: Use dma_iommu_ops for Secure VMs aswell.

 arch/powerpc/platforms/pseries/iommu.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

-- 
1.8.3.1

