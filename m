Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A87C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 21:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C1621927
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 21:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfI0VGo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 17:06:44 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:57573 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfI0VGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 17:06:43 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46g49D6DRlz9sDB;
        Sat, 28 Sep 2019 07:06:40 +1000 (AEST)
Date:   Sat, 28 Sep 2019 07:06:37 +1000
User-Agent: K-9 Mail for Android
In-Reply-To: <8c99aeb3-8287-1913-7362-464ac0c59ce1@redhat.com>
References: <20190910163932.13160-1-david@redhat.com> <a2c2f516-c37c-71f5-8f35-c357e8754b17@redhat.com> <8c99aeb3-8287-1913-7362-464ac0c59ce1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v1] powerpc/pseries: CMM: Drop page array
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
From:   Michael Ellerman <michael@ellerman.id.au>
Message-ID: <27742115-E5A4-4DF1-B223-5E6EB7A6E4F3@ellerman.id.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27 September 2019 9:19:49 pm AEST, David Hildenbrand <david@redhat.com> wrote:
>On 25.09.19 09:37, David Hildenbrand wrote:
>> On 10.09.19 18:39, David Hildenbrand wrote:
>>> We can simply store the pages in a list (page->lru), no need for a
>>> separate data structure (+ complicated handling). This is how most
>>> other balloon drivers store allocated pages without additional
>tracking
>>> data.
>>>
>>> For the notifiers, use page_to_pfn() to check if a page is in the
>>> applicable range. plpar_page_set_loaned()/plpar_page_set_active()
>were
>>> called with __pa(page_address()) for now, I assume we can simply
>switch
>>> to page_to_phys() here. The pfn_to_kaddr() handling is now mostly
>gone.
>>>
>>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>> Cc: Paul Mackerras <paulus@samba.org>
>>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>>> Cc: Arun KS <arunks@codeaurora.org>
>>> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: Vlastimil Babka <vbabka@suse.cz>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>
>>> Only compile-tested. I hope the page_to_phys() thingy is correct and
>I
>>> didn't mess up something else / ignoring something important why the
>array
>>> is needed.
>>>
>>> I stumbled over this while looking at how the memory isolation
>notifier is
>>> used - and wondered why the additional array is necessary. Also, I
>think
>>> by switching to the generic balloon compaction mechanism, we could
>get
>>> rid of the memory hotplug notifier and the memory isolation notifier
>in
>>> this code, as the migration capability of the inflated pages is the
>real
>>> requirement:
>>> 	commit 14b8a76b9d53346f2871bf419da2aaf219940c50
>>> 	Author: Robert Jennings <rcj@linux.vnet.ibm.com>
>>> 	Date:   Thu Dec 17 14:44:52 2009 +0000
>>> 	
>>> 	    powerpc: Make the CMM memory hotplug aware
>>> 	
>>> 	    The Collaborative Memory Manager (CMM) module allocates
>individual pages
>>> 	    over time that are not migratable.  On a long running system
>this can
>>> 	    severely impact the ability to find enough pages to support a
>hotplug
>>> 	    memory remove operation.
>>> 	[...]
>>>
>>> Thoughts?
>> 
>> Ping, is still feature still used at all?
>> 
>> If nobody can test, any advise on which HW I need and how to trigger
>it?
>> 
>
>So ... if CMM is no longer alive I propose ripping it out completely.
>Does anybody know if this feature is still getting used? Getting rid of
>the memory isolation notifier sounds desirable - either by scrapping
>CMM
>or by properly wiring up balloon compaction.

It's still used AFAIK, but the people who wrote the code have left IBM, and I'm on leave.

I'll be back in a week or so and will try and track down how to test it then.

cheers
-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
