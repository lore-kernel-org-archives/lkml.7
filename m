Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310CAC04AA7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 04:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F310820815
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 04:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfEOE1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 00:27:06 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36246 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbfEOE1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 00:27:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2DD2374;
        Tue, 14 May 2019 21:27:05 -0700 (PDT)
Received: from [10.163.1.137] (unknown [10.163.1.137])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 844E43F703;
        Tue, 14 May 2019 21:27:01 -0700 (PDT)
Subject: Re: [PATCH] mm: refactor __vunmap() to avoid duplicated call to
 find_vm_area()
To:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
References: <20190514235111.2817276-1-guro@fb.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <78d9b650-4b47-60c5-4212-601c1719dba5@arm.com>
Date:   Wed, 15 May 2019 09:57:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190514235111.2817276-1-guro@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/15/2019 05:21 AM, Roman Gushchin wrote:
> __vunmap() calls find_vm_area() twice without an obvious reason:
> first directly to get the area pointer, second indirectly by calling
> vm_remove_mappings()->remove_vm_area(), which is again searching
> for the area.
> 
> To remove this redundancy, let's split remove_vm_area() into
> __remove_vm_area(struct vmap_area *), which performs the actual area
> removal, and remove_vm_area(const void *addr) wrapper, which can
> be used everywhere, where it has been used before. Let's pass
> a pointer to the vm_area instead of vm_struct to vm_remove_mappings(),
> so it can pass it to __remove_vm_area() and avoid the redundant area
> lookup.
> 
> On my test setup, I've got 5-10% speed up on vfree()'ing 1000000
> of 4-pages vmalloc blocks.

Though results from  1000000 single page vmalloc blocks remain inconclusive,
4-page based vmalloc block's result shows improvement in the range of 5-10%.
