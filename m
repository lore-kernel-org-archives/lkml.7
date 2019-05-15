Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4969BC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 07:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BE6520862
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 07:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbfEOHOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 03:14:12 -0400
Received: from foss.arm.com ([217.140.101.70]:37204 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbfEOHOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 03:14:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 161C9374;
        Wed, 15 May 2019 00:14:11 -0700 (PDT)
Received: from [10.163.1.137] (unknown [10.163.1.137])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C13ED3F71E;
        Wed, 15 May 2019 00:14:07 -0700 (PDT)
Subject: Re: [PATCH RESEND] mm: show number of vmalloc pages in /proc/meminfo
To:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Johannes Weiner <hannes@cmpxchg.org>
References: <20190514235111.2817276-1-guro@fb.com>
 <20190514235111.2817276-2-guro@fb.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <f0e640c9-2eff-ffc5-8558-4bc1b374eb2a@arm.com>
Date:   Wed, 15 May 2019 12:44:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190514235111.2817276-2-guro@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/15/2019 05:21 AM, Roman Gushchin wrote:
> Vmalloc() is getting more and more used these days (kernel stacks,
> bpf and percpu allocator are new top users), and the total %
> of memory consumed by vmalloc() can be pretty significant
> and changes dynamically.
> 
> /proc/meminfo is the best place to display this information:
> its top goal is to show top consumers of the memory.
> 
> Since the VmallocUsed field in /proc/meminfo is not in use
> for quite a long time (it has been defined to 0 by the
> commit a5ad88ce8c7f ("mm: get rid of 'vmalloc_info' from
> /proc/meminfo")), let's reuse it for showing the actual
> physical memory consumption of vmalloc().
The primary concern which got addressed with a5ad88ce8c7f was that computing
get_vmalloc_info() was taking long time. But here its reads an already updated
value which gets added or subtracted during __vmalloc_area_node/__vunmap cycle.
Hence this should not cost much (like get_vmalloc_info). But is not this similar
to the caching solution Linus mentioned.
