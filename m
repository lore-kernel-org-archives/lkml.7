Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4A9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27F09218A5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbfCUINp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 04:13:45 -0400
Received: from foss.arm.com ([217.140.101.70]:51970 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727881AbfCUINp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 04:13:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFB4080D;
        Thu, 21 Mar 2019 01:13:44 -0700 (PDT)
Received: from [10.162.42.102] (p8cg001049571a15.blr.arm.com [10.162.42.102])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D22803F71A;
        Thu, 21 Mar 2019 01:13:42 -0700 (PDT)
Subject: Re: [PATCH] mm/isolation: Remove redundant pfn_valid_within() in
 __first_valid_page()
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mike.kravetz@oracle.com,
        osalvador@suse.de, akpm@linux-foundation.org
References: <1553141595-26907-1-git-send-email-anshuman.khandual@arm.com>
 <8AB57711-48C0-4D95-BC5F-26B266DC3AE8@nvidia.com>
 <cda4f247-4eea-decf-3f4a-3dc09364de27@arm.com>
 <20190321080702.GG8696@dhcp22.suse.cz>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <8a6b3968-a315-07ce-0491-2a5acdd49ab4@arm.com>
Date:   Thu, 21 Mar 2019 13:43:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190321080702.GG8696@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/21/2019 01:37 PM, Michal Hocko wrote:
> On Thu 21-03-19 11:03:18, Anshuman Khandual wrote:
>>
>>
>> On 03/21/2019 10:31 AM, Zi Yan wrote:
>>> On 20 Mar 2019, at 21:13, Anshuman Khandual wrote:
>>>
>>>> pfn_valid_within() calls pfn_valid() when CONFIG_HOLES_IN_ZONE making it
>>>> redundant for both definitions (w/wo CONFIG_MEMORY_HOTPLUG) of the helper
>>>> pfn_to_online_page() which either calls pfn_valid() or pfn_valid_within().
>>>> pfn_valid_within() being 1 when !CONFIG_HOLES_IN_ZONE is irrelevant either
>>>> way. This does not change functionality.
>>>>
>>>> Fixes: 2ce13640b3f4 ("mm: __first_valid_page skip over offline pages")
>>>
>>> I would not say this patch fixes the commit 2ce13640b3f4 from 2017,
>>> because the pfn_valid_within() in pfn_to_online_page() was introduced by
>>> a recent commit b13bc35193d9e last month. :)
>>
>> Right, will update the tag with this commit.
> 
> The patch is correct but I wouldn't bother to add Fixes tag at all. The
> current code is obviously not incorrect. Do you see any actual

Sure.

> performance issue?
> 

No. Just from code inspection. pfn_valid() is anyways expensive on arm64
because of the memblock search so why to make it redundant as well.
