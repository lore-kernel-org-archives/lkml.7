Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6589FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6AE8218DE
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732037AbfJPM3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 08:29:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52906 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbfJPM3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 08:29:10 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B0BA33066F49;
        Wed, 16 Oct 2019 12:29:09 +0000 (UTC)
Received: from [10.36.116.19] (ovpn-116-19.ams2.redhat.com [10.36.116.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A012160C5E;
        Wed, 16 Oct 2019 12:29:06 +0000 (UTC)
Subject: Re: [PATCH V2] mm/page_alloc: Add alloc_contig_pages()
To:     Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
References: <1571223765-10662-1-git-send-email-anshuman.khandual@arm.com>
 <40b8375c-5291-b477-1519-fd7fa799a67d@redhat.com>
 <cdcf77a5-e5c9-71ff-811d-ecd1c1e80f00@arm.com>
 <20191016115119.GA317@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <fe8cae46-6bd8-88eb-d3fe-2740bb79ee58@redhat.com>
Date:   Wed, 16 Oct 2019 14:29:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191016115119.GA317@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 16 Oct 2019 12:29:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.10.19 13:51, Michal Hocko wrote:
> On Wed 16-10-19 16:43:57, Anshuman Khandual wrote:
>>
>>
>> On 10/16/2019 04:39 PM, David Hildenbrand wrote:
> [...]
>>> Just to make sure, you ignored my comment regarding alignment
>>> although I explicitly mentioned it a second time? Thanks.
>>
>> I had asked Michal explicitly what to be included for the respin. Anyways
>> seems like the previous thread is active again. I am happy to incorporate
>> anything new getting agreed on there.
> 
> Your patch is using the same alignment as the original code would do. If
> an explicit alignement is needed then this can be added on top, right?
> 

Again, the "issue" I see here is that we could now pass in numbers that 
are not a power of two. For gigantic pages it was clear that we always 
have a number of two. The alignment does not make any sense otherwise.

What I'm asking for is

a) Document "The resulting PFN is aligned to nr_pages" and "nr_pages 
should be a power of two".

b) Eventually adding something like

if (WARN_ON_ONCE(!is_power_of_2(nr_pages)))
	return NULL;

Once we need other granularities we can think about the alignment and an 
optimized search-process.

-- 

Thanks,

David / dhildenb
