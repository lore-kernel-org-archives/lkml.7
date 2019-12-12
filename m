Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3662AC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 06:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00F1B21655
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 06:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbfLLGpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 01:45:19 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41246 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727972AbfLLGpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 01:45:18 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBC6fsVK034850
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 01:45:16 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wtbt2ywas-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 01:45:16 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <linuxram@us.ibm.com>;
        Thu, 12 Dec 2019 06:45:14 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 12 Dec 2019 06:45:10 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBC6j8o630933420
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Dec 2019 06:45:08 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 76A08A4068;
        Thu, 12 Dec 2019 06:45:08 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 31DA3A4062;
        Thu, 12 Dec 2019 06:45:05 +0000 (GMT)
Received: from oc0525413822.ibm.com (unknown [9.80.213.32])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 12 Dec 2019 06:45:04 +0000 (GMT)
Date:   Wed, 11 Dec 2019 22:45:02 -0800
From:   Ram Pai <linuxram@us.ibm.com>
To:     Michael Roth <mdroth@linux.vnet.ibm.com>
Cc:     mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        benh@kernel.crashing.org, david@gibson.dropbear.id.au,
        paulus@ozlabs.org, hch@lst.de, andmike@us.ibm.com,
        sukadev@linux.vnet.ibm.com, mst@redhat.com, ram.n.pai@gmail.com,
        aik@ozlabs.ru, cai@lca.pw, tglx@linutronix.de,
        bauerman@linux.ibm.com, linux-kernel@vger.kernel.org,
        leonardo@linux.ibm.com
Subject: Re: [PATCH v5 2/2] powerpc/pseries/iommu: Use dma_iommu_ops for
 Secure VM.
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1575681159-30356-1-git-send-email-linuxram@us.ibm.com>
 <1575681159-30356-2-git-send-email-linuxram@us.ibm.com>
 <1575681159-30356-3-git-send-email-linuxram@us.ibm.com>
 <157602860458.3810.8599908751067047456@sif>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157602860458.3810.8599908751067047456@sif>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19121206-0012-0000-0000-000003740526
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121206-0013-0000-0000-000021AFDF29
Message-Id: <20191212064502.GC5709@oc0525413822.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-12_01:2019-12-12,2019-12-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 impostorscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1912120043
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 07:43:24PM -0600, Michael Roth wrote:
> Quoting Ram Pai (2019-12-06 19:12:39)
> > Commit edea902c1c1e ("powerpc/pseries/iommu: Don't use dma_iommu_ops on
> >                 secure guests")
> > disabled dma_iommu_ops path, for secure VMs. Disabling dma_iommu_ops
> > path for secure VMs, helped enable dma_direct path.  This enabled
> > support for bounce-buffering through SWIOTLB.  However it fails to
> > operate when IOMMU is enabled, since I/O pages are not TCE mapped.
> > 
> > Renable dma_iommu_ops path for pseries Secure VMs.  It handles all
> > cases including, TCE mapping I/O pages, in the presence of a
> > IOMMU.
> 
> Wasn't clear to me at first, but I guess the main gist of this series is
> that we want to continue to use SWIOTLB, but also need to create mappings
> of it's bounce buffers in the IOMMU, so we revert to using dma_iommu_ops
> and rely on the various dma_iommu_{map,alloc}_bypass() hooks throughout
> to call into dma_direct_* ops rather than relying on the dma_is_direct(ops)
> checks in DMA API functions to do the same.
> 
> That makes sense, but one issue I see with that is that
> dma_iommu_map_bypass() only tests true if all the following are true:
> 
> 1) the device requests a 64-bit DMA mask via
>    dma_set_mask/dma_set_coherent_mask
> 2) DDW is enabled (i.e. we don't pass disable_ddw on command-line)
> 
> dma_is_direct() checks don't have this limitation, so I think for
> anything cases, such as devices that use a smaller DMA mask, we'll
> end up falling back to the non-bypass functions in dma_iommu_ops, which
> will likely break for things like dma_alloc_coherent/dma_map_single
> since they won't use SWIOTLB pages and won't do the necessary calls to
> set_memory_unencrypted() to share those non-SWIOTLB buffers with
> hypervisor.
> 
> Maybe that's ok, but I think we should be clearer about how to
> fail/handle these cases.

Yes. makes sense. Device that cannot handle 64bit dma mask will not work.

> 
> Though I also agree with some concerns Alexey stated earlier: it seems
> wasteful to map the entire DDW window just so these bounce buffers can be
> mapped.  Especially if you consider the lack of a mapping to be an additional
> safe-guard against things like buggy device implementations on the QEMU
> side. E.g. if we leaked pages to the hypervisor on accident, those pages
> wouldn't be immediately accessible to a device, and would still require
> additional work get past the IOMMU.

Well, an accidental unintented page leak to the hypervisor, is a very
bad thing, regardless of any DMA mapping. The device may not be able to
access it, but the hypervisor still can access it.

> 
> What would it look like if we try to make all this work with disable_ddw passed
> to kernel command-line (or forced for is_secure_guest())?
> 
>   1) dma_iommu_{alloc,map}_bypass() would no longer get us to dma_direct_* ops,
>      but an additional case or hook that considers is_secure_guest() might do
>      it.
>      
>   2) We'd also need to set up an IOMMU mapping for the bounce buffers via
>      io_tlb_start/io_tlb_end. We could do it once, on-demand via
>      dma_iommu_bypass_supported() like we do for the 64-bit DDW window, or
>      maybe in some init function.

Hmm... i not sure how to accomplish (2).   we need use some DDW window
to setup the mappings. right?  If disable_ddw is set, there wont be any
ddw.  What am i missing?

> 
> That also has the benefit of not requiring devices to support 64-bit DMA.
> 
> Alternatively, we could continue to rely on the 64-bit DDW window, but
> modify call to enable_ddw() to only map the io_tlb_start/end range in
> the case of is_secure_guest(). This is a little cleaner implementation-wise
> since we can rely on the existing dma_iommu_{alloc,map}_bypass() hooks.

I have been experimenting with this.  Trying to map only the memory
range from io_tlb_start/io_tlb_end though the 64-bit ddw window.  But
due to some reason, it wants the io_tlb_start to be aligned to some
boundary. It looks like a 2^28 boundary. Not sure what dictates that
boundary.
   

> , but
> devices that don't support 64-bit will fail back to not using dma_direct_* ops
> and fail miserably. We'd probably want to handle that more gracefully.

Yes i will put a warning message to indicate the failure.

> 
> Or we handle both cases gracefully. To me it makes more sense to enable
> non-DDW case, then consider adding DDW case later if there's some reason
> why 64-bit DMA is needed. But would be good to hear if there are other
> opinions.

educate me a bit here. What is a non-DDW case?  is it possible for a
device to acccess memory, in the presence of a IOMMU, without a window-mapping?

> 
> > 
> > Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> > ---
> >  arch/powerpc/platforms/pseries/iommu.c | 11 +----------
> >  1 file changed, 1 insertion(+), 10 deletions(-)
> > 
> > diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> > index 67b5009..4e27d66 100644
> > --- a/arch/powerpc/platforms/pseries/iommu.c
> > +++ b/arch/powerpc/platforms/pseries/iommu.c
> > @@ -36,7 +36,6 @@
> >  #include <asm/udbg.h>
> >  #include <asm/mmzone.h>
> >  #include <asm/plpar_wrappers.h>
> > -#include <asm/svm.h>
> >  #include <asm/ultravisor.h>
> > 
> >  #include "pseries.h"
> > @@ -1346,15 +1345,7 @@ void iommu_init_early_pSeries(void)
> >         of_reconfig_notifier_register(&iommu_reconfig_nb);
> >         register_memory_notifier(&iommu_mem_nb);
> > 
> > -       /*
> > -        * Secure guest memory is inacessible to devices so regular DMA isn't
> > -        * possible.
> > -        *
> > -        * In that case keep devices' dma_map_ops as NULL so that the generic
> > -        * DMA code path will use SWIOTLB to bounce buffers for DMA.
> > -        */
> > -       if (!is_secure_guest())
> > -               set_pci_dma_ops(&dma_iommu_ops);
> > +       set_pci_dma_ops(&dma_iommu_ops);
> >  }
> > 
> >  static int __init disable_multitce(char *str)
> > -- 
> > 1.8.3.1
> > 

-- 
Ram Pai

