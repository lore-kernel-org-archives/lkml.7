Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EB2C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 08:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F25EE2089F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 08:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbfFXI0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 04:26:13 -0400
Received: from foss.arm.com ([217.140.110.172]:43574 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbfFXI0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 04:26:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81D042B;
        Mon, 24 Jun 2019 01:26:12 -0700 (PDT)
Received: from [10.162.41.123] (p8cg001049571a15.blr.arm.com [10.162.41.123])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5533C3F71E;
        Mon, 24 Jun 2019 01:26:10 -0700 (PDT)
Subject: Re: [PATCH] mm/hugetlb: allow gigantic page allocation to migrate
 away smaller huge page
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     linux-mm@kvack.org, Mike Kravetz <mike.kravetz@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1561350068-8966-1-git-send-email-kernelfans@gmail.com>
 <216a335d-f7c6-26ad-2ac1-427c8a73ca2f@arm.com>
 <CAFgQCTs14R5P7RpCTMwLCMJrGgPzbTGp4tvxCJA0kFgD8_y==g@mail.gmail.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <5fe6bd80-7801-d81e-7a5e-a90afb697c33@arm.com>
Date:   Mon, 24 Jun 2019 13:56:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAFgQCTs14R5P7RpCTMwLCMJrGgPzbTGp4tvxCJA0kFgD8_y==g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/24/2019 11:40 AM, Pingfan Liu wrote:
> On Mon, Jun 24, 2019 at 1:16 PM Anshuman Khandual
> <anshuman.khandual@arm.com> wrote:
>>
>>
>>
>> On 06/24/2019 09:51 AM, Pingfan Liu wrote:
>>> The current pfn_range_valid_gigantic() rejects the pud huge page allocation
>>> if there is a pmd huge page inside the candidate range.
>>>
>>> But pud huge resource is more rare, which should align on 1GB on x86. It is
>>> worth to allow migrating away pmd huge page to make room for a pud huge
>>> page.
>>>
>>> The same logic is applied to pgd and pud huge pages.
>>
>> The huge page in the range can either be a THP or HugeTLB and migrating them has
>> different costs and chances of success. THP migration will involve splitting if
>> THP migration is not enabled and all related TLB related costs. Are you sure
>> that a PUD HugeTLB allocation really should go through these ? Is there any
> PUD hugetlb has already driven out PMD thp in current. This patch just
> want to make PUD hugetlb survives PMD hugetlb.

You are right. PageHuge() is true only for HugeTLB pages unlike PageTransHuge()
which is true for both HugeTLB and THP pages. So the current code does migrate
the THP out in order to allocate a gigantic HugeTLB. While here just wondering
should not we exclude THP as well unless it supports ARCH_HAS_THP_MIGRATION.
