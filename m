Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00A1C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 04:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0997206BF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 04:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="om0/dO3b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfD0EA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 00:00:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43070 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfD0EA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 00:00:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=i/m5ZRNk7cAVz4wurBU96zAR+YAnziWC+vvr6x3mZh0=; b=om0/dO3bdLqw+0zMMvofbYpIq
        NhE77Vxez19Lul4FNwBITl1Nejx9YB+dcWM7ag2HHVekeLvH0gPZ4a/NkdetzB4LL3C0Zu93zAOw7
        JPjNPpW81Wu2XWf7fGKz5S1WsKrdmN+pCu3cu0AcwzKz4DcYYvvKueknUbEYG8YgtL6/izIhv6bG6
        +xb5gFMBMwZ/Dq5tqErP4MeVOZamfVwj6e520tEQSXMRvn+y73coCIYbgLDM/Z1s4PXVlSKWWOKLb
        7MbAMjOg9x6jRgiKWyMy9g/wgS41HC78yOKE1tSI+LAhtWDKqPiGZWOZyesgSIxVFKMRToouDkw5L
        f4ShFEFPA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hKEVn-0000Sd-IV; Sat, 27 Apr 2019 04:00:27 +0000
Subject: Re: [PATCH v2] docs/vm: add documentation of memory models
To:     Mike Rapoport <rppt@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1556228236-12540-1-git-send-email-rppt@linux.ibm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <cb3d9579-ca20-bd16-31d9-78d634e7e635@infradead.org>
Date:   Fri, 26 Apr 2019 21:00:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1556228236-12540-1-git-send-email-rppt@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/19 2:37 PM, Mike Rapoport wrote:
> Describe what {FLAT,DISCONTIG,SPARSE}MEM are and how they manage to
> maintain pfn <-> struct page correspondence.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
> v2 changes:
> * spelling/grammar fixes
> * added note about deprectation of DISCONTIGMEM

                     deprecation

and a few more comments below...


> * added a paragraph about 'struct vmem_altmap'
> 
>  Documentation/vm/index.rst        |   1 +
>  Documentation/vm/memory-model.rst | 183 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 184 insertions(+)
>  create mode 100644 Documentation/vm/memory-model.rst
> 
> diff --git a/Documentation/vm/index.rst b/Documentation/vm/index.rst
> index b58cc3b..e8d943b 100644
> --- a/Documentation/vm/index.rst
> +++ b/Documentation/vm/index.rst
> @@ -37,6 +37,7 @@ descriptions of data structures and algorithms.
>     hwpoison
>     hugetlbfs_reserv
>     ksm
> +   memory-model
>     mmu_notifier
>     numa
>     overcommit-accounting
> diff --git a/Documentation/vm/memory-model.rst b/Documentation/vm/memory-model.rst
> new file mode 100644
> index 0000000..0b4cf19
> --- /dev/null
> +++ b/Documentation/vm/memory-model.rst
> @@ -0,0 +1,183 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. _physical_memory_model:
> +
> +=====================
> +Physical Memory Model
> +=====================
> +
> +Physical memory in a system may be addressed in different ways. The
> +simplest case is when the physical memory starts at address 0 and
> +spans a contiguous range up to the maximal address. It could be,
> +however, that this range contains small holes that are not accessible
> +for the CPU. Then there could be several contiguous ranges at
> +completely distinct addresses. And, don't forget about NUMA, where
> +different memory banks are attached to different CPUs.
> +
> +Linux abstracts this diversity using one of the three memory models:
> +FLATMEM, DISCONTIGMEM and SPARSEMEM. Each architecture defines what
> +memory models it supports, what is the default memory model and

                              what the default memory model is and

> +whether it possible to manually override that default.

   whether it is possible

> +
> +.. note::
> +   At time of this writing, DISCONTIGMEM is considered deprecated,
> +   although it is still in use by several architectures

end with '.'

> +
> +All the memory models track the status of physical page frames using
> +:c:type:`struct page` arranged in one or more arrays.
> +
> +Regardless of the selected memory model, there exists one-to-one
> +mapping between the physical page frame number (PFN) and the
> +corresponding `struct page`.
> +
> +Each memory model defines :c:func:`pfn_to_page` and :c:func:`page_to_pfn`
> +helpers that allow the conversion from PFN to `struct page` and vice
> +versa.

[snip]


thanks.
-- 
~Randy
