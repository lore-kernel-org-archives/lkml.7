Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4697EC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 07:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C34121835
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 07:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbfJOHaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 03:30:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49864 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725710AbfJOHaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 03:30:24 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9F7IZw9092904
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 03:30:23 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vn4yp8q9a-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 03:30:22 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <linuxram@us.ibm.com>;
        Tue, 15 Oct 2019 08:30:17 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 15 Oct 2019 08:30:13 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9F7UC1u11206828
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Oct 2019 07:30:12 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7FBB9A4051;
        Tue, 15 Oct 2019 07:30:11 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E0DA4A405B;
        Tue, 15 Oct 2019 07:30:06 +0000 (GMT)
Received: from oc0525413822.ibm.com (unknown [9.80.211.120])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 15 Oct 2019 07:30:06 +0000 (GMT)
Date:   Tue, 15 Oct 2019 00:30:03 -0700
From:   Ram Pai <linuxram@us.ibm.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     David Gibson <david@gibson.dropbear.id.au>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        benh@kernel.crashing.org, mpe@ellerman.id.au, paulus@ozlabs.org,
        mdroth@linux.vnet.ibm.com, aik@linux.ibm.com, paul.burton@mips.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com, hch@lst.de,
        jasowang@redhat.com, andmike@us.ibm.com,
        sukadev@linux.vnet.ibm.com, mst@redhat.com, bauerman@linux.ibm.com
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1570843519-8696-1-git-send-email-linuxram@us.ibm.com>
 <1570843519-8696-2-git-send-email-linuxram@us.ibm.com>
 <20191014045139.GN4080@umbus.fritz.box>
 <37609731-5539-b906-aa94-2ef0242795ac@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37609731-5539-b906-aa94-2ef0242795ac@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19101507-0008-0000-0000-000003222573
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101507-0009-0000-0000-00004A413A18
Message-Id: <20191015073003.GA5355@oc0525413822.ibm.com>
Subject: RE: [PATCH 1/2] dma-mapping: Add dma_addr_is_phys_addr()
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-15_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910150066
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 11:29:24AM +0100, Robin Murphy wrote:
> On 14/10/2019 05:51, David Gibson wrote:
> >On Fri, Oct 11, 2019 at 06:25:18PM -0700, Ram Pai wrote:
> >>From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> >>
> >>In order to safely use the DMA API, virtio needs to know whether DMA
> >>addresses are in fact physical addresses and for that purpose,
> >>dma_addr_is_phys_addr() is introduced.
> >>
> >>cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> >>cc: David Gibson <david@gibson.dropbear.id.au>
> >>cc: Michael Ellerman <mpe@ellerman.id.au>
> >>cc: Paul Mackerras <paulus@ozlabs.org>
> >>cc: Michael Roth <mdroth@linux.vnet.ibm.com>
> >>cc: Alexey Kardashevskiy <aik@linux.ibm.com>
> >>cc: Paul Burton <paul.burton@mips.com>
> >>cc: Robin Murphy <robin.murphy@arm.com>
> >>cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> >>cc: Marek Szyprowski <m.szyprowski@samsung.com>
> >>cc: Christoph Hellwig <hch@lst.de>
> >>Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> >>Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> >>Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> >
> >The change itself looks ok, so
> >
> >Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> >
> >However, I would like to see the commit message (and maybe the inline
> >comments) expanded a bit on what the distinction here is about.  Some
> >of the text from the next patch would be suitable, about DMA addresses
> >usually being in a different address space but not in the case of
> >bounce buffering.
> 
> Right, this needs a much tighter definition. "DMA address happens to
> be a valid physical address" is true of various IOMMU setups too,
> but I can't believe it's meaningful in such cases.

The definition by itself is meaningful AFAICT. At its core its just
indicating whether DMA addresses are physical addresses or not.

However its up to the caller to use it meaningfully. For non-virtio caller,
dma_addr_is_phys_addr() by itself may or may not be meaningful.

But for a virtio caller, this information when paired with
mem_encrypt_active() is meaningful.

For IOMMU setups DMA API will get used regardless of "DMA address
happens to be a valid physical address"


> 
> If what you actually want is "DMA is direct or SWIOTLB" - i.e. "DMA
> address is physical address of DMA data (not necessarily the
> original buffer)" - wouldn't dma_is_direct() suffice?

This may also work, I think.  MST: thoughts?

RP

