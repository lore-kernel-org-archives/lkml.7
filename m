Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C643DC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91EF5214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbfDYJBr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 05:01:47 -0400
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:52075 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfDYJBr (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:6:1>);
        Thu, 25 Apr 2019 05:01:47 -0400
Received: from INET-PRV1-MTA by prv1-mh.provo.novell.com
        with Novell_GroupWise; Thu, 25 Apr 2019 03:01:46 -0600
Message-Id: <5CC177740200007800228EB2@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.1.0 
Date:   Thu, 25 Apr 2019 03:01:40 -0600
From:   "Jan Beulich" <JBeulich@suse.com>
To:     "Juergen Gross" <jgross@suse.com>
Cc:     "Stefano Stabellini" <sstabellini@kernel.org>,
        <iommu@lists.linux-foundation.org>,
        "xen-devel" <xen-devel@lists.xenproject.org>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [Xen-devel] [PATCH 3/3] xen/swiotlb: remember having
 called xen_create_contiguous_region()
References: <20190423105457.17502-1-jgross@suse.com>
 <20190423105457.17502-4-jgross@suse.com>
 <alpine.DEB.2.10.1904230955190.24598@sstabellini-ThinkPad-X260>
 <e744c7eb-1685-13b6-7ae9-e952f8f53ab0@suse.com>
In-Reply-To: <e744c7eb-1685-13b6-7ae9-e952f8f53ab0@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> On 23.04.19 at 20:36, <jgross@suse.com> wrote:
> On 23/04/2019 19:05, Stefano Stabellini wrote:
>> On Tue, 23 Apr 2019, Juergen Gross wrote:
>>> Instead of always calling xen_destroy_contiguous_region() in case the
>>> memory is DMA-able for the used device, do so only in case it has been
>>> made DMA-able via xen_create_contiguous_region() before.
>>>
>>> This will avoid a lot of xen_destroy_contiguous_region() calls for
>>> 64-bit capable devices.
>>>
>>> As the memory in question is owned by swiotlb-xen the PG_owner_priv_1
>>> flag of the first allocated page can be used for remembering.
>> 
>> Although the patch looks OK, this sentence puzzles me. Why do you say
>> that the memory in question is owned by swiotlb-xen? Because it was
>> returned by xen_alloc_coherent_pages? Both the x86 and the Arm
>> implementation return fresh new memory, hence, it should be safe to set
>> the PageOwnerPriv1 flag?
>> 
>> My concern with this approach is with the semantics of PG_owner_priv_1.
>> Is a page marked with PG_owner_priv_1 only supposed to be used by the
>> owner?
> 
> The owner of the page is free to use the flag.
> 
> Like Grant pages are marked by the grant driver using this flag. And
> Xen page tables are using it in PV-guests for indicating a "Pinned"
> page table.

Considering the background of the series, isn't such multi-purpose use
of the flag a possible problem? You're already suspecting a wrong call
into here. The function finding the flag set (but for another reason)
might add to the confusion. But I realize there are only so many page
flags available.

Perhaps the freeing function should, first thing, check the handed
space actually matches the criteria (within dma_mask and contiguous)?

Jan


