Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0FAC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 11:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7727821D71
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 11:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731045AbfJDLny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 07:43:54 -0400
Received: from foss.arm.com ([217.140.110.172]:42562 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725826AbfJDLny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 07:43:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8873015A1;
        Fri,  4 Oct 2019 04:43:53 -0700 (PDT)
Received: from [10.163.1.5] (unknown [10.163.1.5])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 97CAF3F706;
        Fri,  4 Oct 2019 04:43:50 -0700 (PDT)
Subject: Re: [PATCH] mm/page_alloc: Add a reason for reserved pages in
 has_unmovable_pages()
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        linux-kernel@vger.kernel.org
References: <1570090257-25001-1-git-send-email-anshuman.khandual@arm.com>
 <20191004105824.GD9578@dhcp22.suse.cz>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <91128b73-9a47-100b-d3de-e83f0b941e9f@arm.com>
Date:   Fri, 4 Oct 2019 17:14:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191004105824.GD9578@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/04/2019 04:28 PM, Michal Hocko wrote:
> On Thu 03-10-19 13:40:57, Anshuman Khandual wrote:
>> Having unmovable pages on a given pageblock should be reported correctly
>> when required with REPORT_FAILURE flag. But there can be a scenario where a
>> reserved page in the page block will get reported as a generic "unmovable"
>> reason code. Instead this should be changed to a more appropriate reason
>> code like "Reserved page".
> 
> Others have already pointed out this is just redundant but I will have a

Sure.

> more generic comment on the changelog. There is essentially no
> information why the current state is bad/unhelpful and why the chnage is

The current state is not necessarily bad or unhelpful. I just though that it
could be improved upon. Some how calling out explicitly only the CMA page
failure case just felt adhoc, where as there are other reasons like HugeTLB
immovability which might depend on other factors apart from just page flags
(though I did not propose that originally).

> needed. All you claim is that something is a certain way and then assert
> that it should be done differently. That is not how changelogs should
> look like.
> 

Okay, probably I should have explained more on why "unmovable" is less than
adequate to capture the exact reason for specific failure cases and how
"Reserved Page" instead would been better. But got the point, will improve.
