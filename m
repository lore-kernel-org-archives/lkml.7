Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C53AC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15222204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfDSSei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:34:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43264 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727995AbfDSSeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:34:36 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3JFTsqA080949
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 11:34:20 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rybt5m7yb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 11:34:20 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <groug@kaod.org>;
        Fri, 19 Apr 2019 16:34:18 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 19 Apr 2019 16:34:15 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3JFYERa43253856
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Apr 2019 15:34:14 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 211ACA4060;
        Fri, 19 Apr 2019 15:34:14 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E0DADA405B;
        Fri, 19 Apr 2019 15:34:13 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.170.150])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 19 Apr 2019 15:34:13 +0000 (GMT)
Subject: [PATCH] powerpc/powernv/npu: Fix reference leak
From:   Greg Kurz <groug@kaod.org>
To:     linux-kernel@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Alistair Popple <alistair@popple.id.au>
Date:   Fri, 19 Apr 2019 17:34:13 +0200
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19041915-0020-0000-0000-00000331A9DC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041915-0021-0000-0000-00002183FFAE
Message-Id: <155568805354.600470.13376593185688810607.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-19_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=955 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904190114
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 902bdc57451c, get_pci_dev() calls pci_get_domain_bus_and_slot(). This
has the effect of incrementing the reference count of the PCI device, as
explained in drivers/pci/search.c:

 * Given a PCI domain, bus, and slot/function number, the desired PCI
 * device is located in the list of PCI devices. If the device is
 * found, its reference count is increased and this function returns a
 * pointer to its data structure.  The caller must decrement the
 * reference count by calling pci_dev_put().  If no device is found,
 * %NULL is returned.

Nothing was done to call pci_dev_put() and the reference count of GPU and
NPU PCI devices rockets up.

A natural way to fix this would be to teach the callers about the change,
so that they call pci_dev_put() when done with the pointer. This turns
out to be quite intrusive, as it affects many paths in npu-dma.c,
pci-ioda.c and vfio_pci_nvlink2.c. Also, the issue appeared in 4.16 and
some affected code got moved around since then: it would be problematic
to backport the fix to stable releases.

All that code never cared for reference counting anyway. Call pci_dev_put()
from get_pci_dev() to revert to the previous behavior.

Fixes: 902bdc57451c ("powerpc/powernv/idoa: Remove unnecessary pcidev from pci_dn")
Cc: stable@vger.kernel.org # v4.16
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 arch/powerpc/platforms/powernv/npu-dma.c |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
index e713ade30087..d8f3647e8fb2 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -31,9 +31,22 @@ static DEFINE_SPINLOCK(npu_context_lock);
 static struct pci_dev *get_pci_dev(struct device_node *dn)
 {
 	struct pci_dn *pdn = PCI_DN(dn);
+	struct pci_dev *pdev;
 
-	return pci_get_domain_bus_and_slot(pci_domain_nr(pdn->phb->bus),
+	pdev = pci_get_domain_bus_and_slot(pci_domain_nr(pdn->phb->bus),
 					   pdn->busno, pdn->devfn);
+
+	/*
+	 * pci_get_domain_bus_and_slot() increased the reference count of
+	 * the PCI device, but callers don't need that actually as the PE
+	 * already holds a reference to the device. Since callers aren't
+	 * aware of the reference count change, call pci_dev_put() now to
+	 * avoid leaks.
+	 */
+	if (pdev)
+		pci_dev_put(pdev);
+
+	return pdev;
 }
 
 /* Given a NPU device get the associated PCI device. */

