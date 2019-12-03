Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1481C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 04:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9023820665
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 04:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfLCEHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 23:07:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16826 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726327AbfLCEHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 23:07:45 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB346s4h095707
        for <linux-kernel@vger.kernel.org>; Mon, 2 Dec 2019 23:07:45 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wnehxjn15-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 23:07:44 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <linuxram@us.ibm.com>;
        Tue, 3 Dec 2019 04:07:42 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 3 Dec 2019 04:07:38 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB346v4S46596372
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Dec 2019 04:06:57 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E66F8A4051;
        Tue,  3 Dec 2019 04:07:37 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16F53A404D;
        Tue,  3 Dec 2019 04:07:34 +0000 (GMT)
Received: from oc0525413822.ibm.com (unknown [9.85.173.229])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  3 Dec 2019 04:07:33 +0000 (GMT)
Date:   Mon, 2 Dec 2019 20:07:31 -0800
From:   Ram Pai <linuxram@us.ibm.com>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        benh@kernel.crashing.org, david@gibson.dropbear.id.au,
        paulus@ozlabs.org, mdroth@linux.vnet.ibm.com, hch@lst.de,
        andmike@us.ibm.com, sukadev@linux.vnet.ibm.com, mst@redhat.com,
        ram.n.pai@gmail.com, cai@lca.pw, tglx@linutronix.de,
        bauerman@linux.ibm.com, linux-kernel@vger.kernel.org
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1575269124-17885-1-git-send-email-linuxram@us.ibm.com>
 <1575269124-17885-2-git-send-email-linuxram@us.ibm.com>
 <1575269124-17885-3-git-send-email-linuxram@us.ibm.com>
 <58b08d09-aaf8-5659-c4e8-c502c508f35c@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58b08d09-aaf8-5659-c4e8-c502c508f35c@ozlabs.ru>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19120304-0012-0000-0000-000003701489
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120304-0013-0000-0000-000021ABCEC5
Message-Id: <20191203040731.GC12354@oc0525413822.ibm.com>
Subject: RE: [PATCH v4 2/2] powerpc/pseries/iommu: Use dma_iommu_ops for Secure VMs
 aswell.
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-02_06:2019-11-29,2019-12-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0
 suspectscore=18 impostorscore=0 mlxlogscore=999 priorityscore=1501
 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912030035
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2019 at 11:58:18AM +1100, Alexey Kardashevskiy wrote:
> 
> 
> On 02/12/2019 17:45, Ram Pai wrote:
> > Commit edea902c1c1e ("powerpc/pseries/iommu: Don't use dma_iommu_ops on
> > 	       secure guests")
> > disabled dma_iommu_ops path, for secure VMs. The rationale for disabling
> > the dma_iommu_ops path, was to use the dma_direct path, since it had
> > inbuilt support for bounce-buffering through SWIOTLB.
> > 
> > However dma_iommu_ops is functionally much richer. Depending on the
> > capabilities of the platform, it can handle direct DMA; with or without
> > bounce buffering, and it can handle indirect DMA. Hence its better to
> > leverage the richer functionality supported by dma_iommu_ops.
> 
> What exactly do we leverage after applying this patch? afaict things are
> going to work in exact same old way with this applied, no? Thanks,

Yes. You got it right. Another way of saying this is, it reverts the changes.

RP

