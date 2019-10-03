Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CC3C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 11:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C43420830
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 11:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730094AbfJCLby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 07:31:54 -0400
Received: from foss.arm.com ([217.140.110.172]:42318 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729987AbfJCLby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 07:31:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97378337;
        Thu,  3 Oct 2019 04:31:53 -0700 (PDT)
Received: from [10.162.40.180] (p8cg001049571a15.blr.arm.com [10.162.40.180])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 695B83F706;
        Thu,  3 Oct 2019 04:31:50 -0700 (PDT)
Subject: Re: [PATCH] mm/page_alloc: Add a reason for reserved pages in
 has_unmovable_pages()
To:     Qian Cai <cai@lca.pw>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        linux-kernel@vger.kernel.org
References: <37b43978-5652-576c-8990-451e751b7c67@arm.com>
 <285C0297-BF27-4095-87B6-AFC88C1F3C0F@lca.pw>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <d3a88afd-63c6-1091-cf4c-75cd10b7f547@arm.com>
Date:   Thu, 3 Oct 2019 17:02:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <285C0297-BF27-4095-87B6-AFC88C1F3C0F@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/03/2019 04:49 PM, Qian Cai wrote:
> 
> 
>> On Oct 3, 2019, at 5:32 AM, Anshuman Khandual <Anshuman.Khandual@arm.com> wrote:
>>
>> Even though page flags does contain reserved bit information, the problem
>> is that we are explicitly printing the reason for this page dump. In this
>> case it is caused by the fact that it is a reserved page.
>>
>> page dumped because: <reason>
>>
>> The proposed change makes it explicit that the dump is caused because a
>> non movable page with reserved bit set. It also helps in differentiating 
>> between reserved bit condition and the last one "if (found > count)".
> 
> Then, someone later would like to add a reason for every different page flags just because they *think* they are special.
> 

Ohh, never meant that the 'Reserved' bit is anything special here but it
is a reason to make a page unmovable unlike many other flags.
