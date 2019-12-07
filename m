Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310C4C43603
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 01:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 030002173E
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 01:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfLGBNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 20:13:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28666 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726371AbfLGBNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 20:13:08 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB71CQwF124511
        for <linux-kernel@vger.kernel.org>; Fri, 6 Dec 2019 20:13:05 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wq9hph2ww-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 20:13:05 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <linuxram@us.ibm.com>;
        Sat, 7 Dec 2019 01:13:04 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 7 Dec 2019 01:12:59 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB71CwdX2032102
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 7 Dec 2019 01:12:58 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3AD7F4C04A;
        Sat,  7 Dec 2019 01:12:58 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 217724C040;
        Sat,  7 Dec 2019 01:12:54 +0000 (GMT)
Received: from oc0525413822.ibm.com (unknown [9.80.215.155])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat,  7 Dec 2019 01:12:53 +0000 (GMT)
From:   Ram Pai <linuxram@us.ibm.com>
To:     mpe@ellerman.id.au
Cc:     linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org,
        david@gibson.dropbear.id.au, paulus@ozlabs.org,
        mdroth@linux.vnet.ibm.com, hch@lst.de, linuxram@us.ibm.com,
        andmike@us.ibm.com, sukadev@linux.vnet.ibm.com, mst@redhat.com,
        ram.n.pai@gmail.com, aik@ozlabs.ru, cai@lca.pw, tglx@linutronix.de,
        bauerman@linux.ibm.com, linux-kernel@vger.kernel.org,
        leonardo@linux.ibm.com
Subject: [PATCH v5 0/2] Enable IOMMU support for pseries Secure VMs
Date:   Fri,  6 Dec 2019 17:12:37 -0800
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 19120701-0028-0000-0000-000003C62762
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120701-0029-0000-0000-000024894E8C
Message-Id: <1575681159-30356-1-git-send-email-linuxram@us.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-06_08:2019-12-05,2019-12-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 mlxlogscore=620 suspectscore=1 malwarescore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912070004
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
	v5: unshare the page used in H_PUT_TCE_INDIRECT hcall to
       	    communicate the TCE entries with the hypervisor.
	    Concern raised by Alexey. This minimizes the number
	    of pages shared with the hypervisor.

	v4: Corrected the Subject, to include the keyword 'PATCH'.
		No other changes.

	v3: Better description of 2/2 patch.
		Suggested by David Gibson.

	v2: added comments describing the changes.
		Suggested by Alexey and Michael Ellermen.


Ram Pai (2):
  powerpc/pseries/iommu: Share the per-cpu TCE page with the hypervisor.
  powerpc/pseries/iommu: Use dma_iommu_ops for Secure VM.

 arch/powerpc/platforms/pseries/iommu.c | 43 ++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 13 deletions(-)

-- 
1.8.3.1

