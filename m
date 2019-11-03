Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287F2CA9EB0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 20:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F26872190F
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 20:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="cVdRMZAI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbfKCUUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 15:20:22 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:16575 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbfKCUUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 15:20:22 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dbf36850000>; Sun, 03 Nov 2019 12:20:22 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 03 Nov 2019 12:20:16 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 03 Nov 2019 12:20:16 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 3 Nov
 2019 20:20:16 +0000
Subject: Re: [RFC] mm: gup: add helper page_try_gup_pin(page)
To:     Hillf Danton <hdanton@sina.com>, linux-mm <linux-mm@kvack.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jan Kara <jack@suse.cz>,
        Mel Gorman <mgorman@suse.de>,
        Jerome Glisse <jglisse@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Jonathan Corbet <corbet@lwn.net>
References: <20191103112113.8256-1-hdanton@sina.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <51e8cee5-704f-9a6f-7e39-2c8b5050e0a9@nvidia.com>
Date:   Sun, 3 Nov 2019 12:20:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191103112113.8256-1-hdanton@sina.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1572812422; bh=1WddofDs8AP/zQmou9ypT/z1t2lraSgfbS9gxVcbq6U=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=cVdRMZAINoC1A6ZGOjFs6GdIiGRwP8AFIAgl8jDDTddHbTX+V8XJWdwgcYl10lSSJ
         LHAMVpVQwCecnPJox/CxdaNu7mZjrr/maNMRb/LyLUDZYOvOwdYdUERfBOqrT/MEJz
         jRSH2UH95go64w9djr8LWCDXx7GuZA9ERPhSKeh4z5/Tr8ihsFgDQQT8kLOJOkJSyv
         /y/WeEFfgaFt+EQNQ70pRYlvYNnKlno/E8oYClA49TIk1Pi1+I2H0bhKcUtjsCi/D+
         FAzcDkt15R4oSRJR2kpVlUu8QNBAE4t86i58g33XEY+sSmmesHyUXTVIiDTP5oq/rQ
         jBXNdZlKLsrSw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/19 3:21 AM, Hillf Danton wrote:
> 
> A helper is added for mitigating the gup issue described at
> https://lwn.net/Articles/784574/. It is unsafe to write out
> a dirty page that is already gup pinned for DMA.
> 
> In the current writeback context, dirty pages are written out with
> no detecting whether they have been gup pinned; Nor mark to keep
> gupers off. In the gup context, file pages can be pinned with other
> gupers and writeback ignored.
> 
> The factor, that no room, supposedly even one bit, in the current
> page struct can be used for tracking gupers, makes the issue harder
> to tackle.

Well, as long as we're counting bits, I've taken 21 bits (!) to track
"gupers". :)  More accurately, I'm sharing 31 bits with get_page()...please
see my recently posted patchset for tracking dma-pinned pages:

https://lore.kernel.org/r/20191030224930.3990755-1-jhubbard@nvidia.com

Once that is merged, you will have this available:

   static inline bool page_dma_pinned(struct page *page);

...which will reliably track dma-pinned pages.

After that, we still need to convert a some more call sites (block/bio 
in particular) to the new pin_user_pages()/put_user_page() system, in 
order for filesystems to take advantage of it, but this approach has 
the advantage of actually tracking such pages, rather than faking it by 
hoping that there is only one gup caller at a time.


> 
> The approach here is, because it makes no sense to allow a file page
> to have multiple gupers at the same time, looking to make gupers

ohhh...no, that's definitely not a claim you can make.


> mutually exclusive, and then guper's singulairty helps to tell if a
> guper is existing by staring at the change in page count.
> 
> The result of that sigularity is not yet 100% correct but something
> of "best effort" as the effect of random get_page() is perhaps also
> folded in it.
> It is assumed the best effort is feasible/acceptable in practice
> without the the cost of growing the page struct size by one bit,
> were it true that something similar has been applied to the page
> migrate and reclaim contexts for a while.
> 
> With the helper in place, we skip writing out a dirty page if a
> guper is detected; On gupping, we give up pinning a file page due
> to writeback or losing the race to become a guper.
> 
> The end result is, no gup-pinned page will be put under writeback.

I think you must have missed the many contentious debates about the
tension between gup-pinned pages, and writeback. File systems can't
just ignore writeback in all cases. This patch leads to either
system hangs or filesystem corruption, in the presence of long-lasting
gup pins.

Really, this won't work. sorry.


thanks,

John Hubbard
NVIDIA
