Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0430BC432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 16:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6EDA2068E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 16:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfLCQwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 11:52:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51616 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726422AbfLCQwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 11:52:19 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB3Gi35V095152
        for <linux-kernel@vger.kernel.org>; Tue, 3 Dec 2019 11:52:18 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wnqn4dad9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 11:52:17 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <linuxram@us.ibm.com>;
        Tue, 3 Dec 2019 16:52:15 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 3 Dec 2019 16:52:11 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB3GqAbJ58064996
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Dec 2019 16:52:11 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DBD864204B;
        Tue,  3 Dec 2019 16:52:10 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D9E242045;
        Tue,  3 Dec 2019 16:52:07 +0000 (GMT)
Received: from oc0525413822.ibm.com (unknown [9.80.193.7])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  3 Dec 2019 16:52:06 +0000 (GMT)
Date:   Tue, 3 Dec 2019 08:52:04 -0800
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
 <f08ace25-fa94-990b-1b6d-a1c0f30d6348@ozlabs.ru>
 <20191203020850.GA12354@oc0525413822.ibm.com>
 <0b56ce3e-6c32-5f3b-e7cc-0d419a61d71d@ozlabs.ru>
 <20191203040509.GB12354@oc0525413822.ibm.com>
 <a0f19e65-81eb-37bd-928b-7a57a8660e3d@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0f19e65-81eb-37bd-928b-7a57a8660e3d@ozlabs.ru>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19120316-0012-0000-0000-0000037077B2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120316-0013-0000-0000-000021AC3511
Message-Id: <20191203165204.GA5079@oc0525413822.ibm.com>
Subject: RE: [PATCH v4 1/2] powerpc/pseries/iommu: Share the per-cpu TCE page with
 the hypervisor.
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-03_05:2019-12-02,2019-12-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 priorityscore=1501 suspectscore=18 adultscore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912030125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2019 at 03:24:37PM +1100, Alexey Kardashevskiy wrote:
> 
> 
> On 03/12/2019 15:05, Ram Pai wrote:
> > On Tue, Dec 03, 2019 at 01:15:04PM +1100, Alexey Kardashevskiy wrote:
> >>
> >>
> >> On 03/12/2019 13:08, Ram Pai wrote:
> >>> On Tue, Dec 03, 2019 at 11:56:43AM +1100, Alexey Kardashevskiy wrote:
> >>>>
> >>>>
> >>>> On 02/12/2019 17:45, Ram Pai wrote:
> >>>>> H_PUT_TCE_INDIRECT hcall uses a page filled with TCE entries, as one of
> >>>>> its parameters. One page is dedicated per cpu, for the lifetime of the
> >>>>> kernel for this purpose. On secure VMs, contents of this page, when
> >>>>> accessed by the hypervisor, retrieves encrypted TCE entries.  Hypervisor
> >>>>> needs to know the unencrypted entries, to update the TCE table
> >>>>> accordingly.  There is nothing secret or sensitive about these entries.
> >>>>> Hence share the page with the hypervisor.
> >>>>
> >>>> This unsecures a page in the guest in a random place which creates an
> >>>> additional attack surface which is hard to exploit indeed but
> >>>> nevertheless it is there.
> >>>> A safer option would be not to use the
> >>>> hcall-multi-tce hyperrtas option (which translates FW_FEATURE_MULTITCE
> >>>> in the guest).
> >>>
> >>>
> >>> Hmm... How do we not use it?  AFAICT hcall-multi-tce option gets invoked
> >>> automatically when IOMMU option is enabled.
> >>
> >> It is advertised by QEMU but the guest does not have to use it.
> > 
> > Are you suggesting that even normal-guest, not use hcall-multi-tce?
> > or just secure-guest?  
> 
> 
> Just secure.

hmm..  how are the TCE entries communicated to the hypervisor, if
hcall-multi-tce is disabled?

> 
> 
> > 
> >>
> >>> This happens even
> >>> on a normal VM when IOMMU is enabled.
> >>>
> >>>
> >>>>
> >>>> Also what is this for anyway? 
> >>>
> >>> This is for sending indirect-TCE entries to the hypervisor.
> >>> The hypervisor must be able to read those TCE entries, so that it can 
> >>> use those entires to populate the TCE table with the correct mappings.
> >>>
> >>>> if I understand things right, you cannot
> >>>> map any random guest memory, you should only be mapping that 64MB-ish
> >>>> bounce buffer array but 1) I do not see that happening (I may have
> >>>> missed it) 2) it should be done once and it takes a little time for
> >>>> whatever memory size we allow for bounce buffers anyway. Thanks,
> >>>
> >>> Any random guest memory can be shared by the guest. 
> >>
> >> Yes but we do not want this to be this random. 
> > 
> > It is not sharing some random page. It is sharing a page that is
> > ear-marked for communicating TCE entries. Yes the address of the page
> > can be random, depending on where the allocator decides to allocate it.
> > The purpose of the page is not random.
> 
> I was talking about the location.
> 
> 
> > That page is used for one specific purpose; to communicate the TCE
> > entries to the hypervisor.  
> > 
> >> I thought the whole idea
> >> of swiotlb was to restrict the amount of shared memory to bare minimum,
> >> what do I miss?
> > 
> > I think, you are making a incorrect connection between this patch and
> > SWIOTLB.  This patch has nothing to do with SWIOTLB.
> 
> I can see this and this is the confusing part.
> 
> 
> >>
> >>> Maybe you are confusing this with the SWIOTLB bounce buffers used by
> >>> PCI devices, to transfer data to the hypervisor?
> >>
> >> Is not this for pci+swiotlb? 
> > 
> > 
> > No. This patch is NOT for PCI+SWIOTLB.  The SWIOTLB pages are a
> > different set of pages allocated and earmarked for bounce buffering.
> > 
> > This patch is purely to help the hypervisor setup the TCE table, in the
> > presence of a IOMMU.
> 
> Then the hypervisor should be able to access the guest pages mapped for
> DMA and these pages should be made unsecure for this to work. Where/when
> does this happen?

This happens in the SWIOTLB code.  The code to do that is already
upstream.  

The sharing of the pages containing the SWIOTLB bounce buffers is done
in init_svm() which calls swiotlb_update_mem_attributes() which calls
set_memory_decrypted().  In the case of pseries, set_memory_decrypted() calls 
uv_share_page().

The code that bounces the contents of a I/O buffer through the 
SWIOTLB buffers, is in swiotlb_bounce().

> 
> 
> >> The cover letter suggests it is for
> >> virtio-scsi-_pci_ with 	iommu_platform=on which makes it a
> >> normal pci device just like emulated XHCI. Thanks,
> > 
> > Well, I guess, the cover letter is probably confusing. There are two
> > patches, which togather enable virtio on secure guests, in the presence
> > of IOMMU.
> > 
> > The second patch enables virtio in the presence of a IOMMU, to use
> > DMA_ops+SWIOTLB infrastructure, to correctly navigate the I/O to virtio
> > devices.
> 
> The second patch does nothing in relation to the problem being solved.

The second patch registers dma_iommu_ops with the PCI-system.  Doing so
enables I/O to take the dma_iommu_ops path, which internally 
leads it through the SWIOTLB path. Without that, the I/O fails to reach
its destination.

> 
> 
> > However that by itself wont work if the TCE entires are not correctly
> > setup in the TCE tables.  The first patch; i.e this patch, helps
> > accomplish that.
> >> Hope this clears up the confusion.
> 
> 
> 
> 
> 
> -- 
> Alexey

-- 
Ram Pai

