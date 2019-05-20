Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC08C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 05:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C78672081C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 05:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbfETFh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 01:37:27 -0400
Received: from foss.arm.com ([217.140.101.70]:37460 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727069AbfETFh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 01:37:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9293180D;
        Sun, 19 May 2019 22:37:26 -0700 (PDT)
Received: from [10.162.41.132] (p8cg001049571a15.blr.arm.com [10.162.41.132])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA61F3F5AF;
        Sun, 19 May 2019 22:37:24 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH] mm/dev_pfn: Exclude MEMORY_DEVICE_PRIVATE while computing
 virtual address
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dan.j.williams@intel.com, jglisse@redhat.com,
        ldufour@linux.vnet.ibm.com
References: <1558089514-25067-1-git-send-email-anshuman.khandual@arm.com>
 <20190517145050.2b6b0afdaab5c3c69a4b153e@linux-foundation.org>
Message-ID: <cb8cbd57-9220-aba9-7579-dbcf35f02672@arm.com>
Date:   Mon, 20 May 2019 11:07:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190517145050.2b6b0afdaab5c3c69a4b153e@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/18/2019 03:20 AM, Andrew Morton wrote:
> On Fri, 17 May 2019 16:08:34 +0530 Anshuman Khandual <anshuman.khandual@arm.com> wrote:
> 
>> The presence of struct page does not guarantee linear mapping for the pfn
>> physical range. Device private memory which is non-coherent is excluded
>> from linear mapping during devm_memremap_pages() though they will still
>> have struct page coverage. Just check for device private memory before
>> giving out virtual address for a given pfn.
> 
> I was going to give my standard "what are the user-visible runtime
> effects of this change?", but...
> 
>> All these helper functions are all pfn_t related but could not figure out
>> another way of determining a private pfn without looking into it's struct
>> page. pfn_t_to_virt() is not getting used any where in mainline kernel.Is
>> it used by out of tree drivers ? Should we then drop it completely ?
> 
> Yeah, let's kill it.
> 
> But first, let's fix it so that if someone brings it back, they bring
> back a non-buggy version.

Makes sense.

> 
> So...  what (would be) the user-visible runtime effects of this change?

I am not very well aware about the user interaction with the drivers which
hotplug and manage ZONE_DEVICE memory in general. Hence will not be able to
comment on it's user visible runtime impact. I just figured this out from
code audit while testing ZONE_DEVICE on arm64 platform. But the fix makes
the function bit more expensive as it now involve some additional memory
references.
