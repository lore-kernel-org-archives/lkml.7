Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB5BC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 12:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67C882084E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 12:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfFUMxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 08:53:06 -0400
Received: from foss.arm.com ([217.140.110.172]:59926 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbfFUMxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 08:53:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0978E142F;
        Fri, 21 Jun 2019 05:53:05 -0700 (PDT)
Received: from [10.162.42.140] (p8cg001049571a15.blr.arm.com [10.162.42.140])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 158133F718;
        Fri, 21 Jun 2019 05:52:59 -0700 (PDT)
Subject: Re: [PATCH V6 3/3] arm64/mm: Enable memory hot remove
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        catalin.marinas@arm.com, will.deacon@arm.com
Cc:     mark.rutland@arm.com, mhocko@suse.com, ira.weiny@intel.com,
        david@redhat.com, cai@lca.pw, logang@deltatee.com,
        james.morse@arm.com, cpandya@codeaurora.org, arunks@codeaurora.org,
        dan.j.williams@intel.com, mgorman@techsingularity.net,
        osalvador@suse.de, ard.biesheuvel@arm.com, steve.capper@arm.com
References: <1560917860-26169-1-git-send-email-anshuman.khandual@arm.com>
 <1560917860-26169-4-git-send-email-anshuman.khandual@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <bc46b390-01b8-e818-588d-f973dc2c5140@arm.com>
Date:   Fri, 21 Jun 2019 18:23:22 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1560917860-26169-4-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 06/19/2019 09:47 AM, Anshuman Khandual wrote:
> +#ifdef CONFIG_MEMORY_HOTPLUG
> +	/*
> +	 * FIXME: We should have called remove_pagetable(start, end, true).
> +	 * vmemmap and vmalloc virtual range might share intermediate kernel
> +	 * page table entries. Removing vmemmap range page table pages here
> +	 * can potentially conflict with a cuncurrent vmalloc() allocation.
> +	 *
> +	 * This is primarily because valloc() does not take init_mm ptl for
> +	 * the entire page table walk and it's modification. Instead it just
> +	 * takes the lock while allocating and installing page table pages
> +	 * via [p4d|pud|pmd|pte]_aloc(). A cuncurrently vanishing page table
> +	 * entry via memory hotremove can cause vmalloc() kernel page table
> +	 * walk pointers to be invalid on the fly which can cause corruption
> +	 * or worst, a crash.

There are couple of typos above which I will fix along with other reviews.
