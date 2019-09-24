Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F93DC432C2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 04:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F382D214D9
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 04:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391276AbfIXEMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 00:12:18 -0400
Received: from foss.arm.com ([217.140.110.172]:52960 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725308AbfIXEMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 00:12:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DE641000;
        Mon, 23 Sep 2019 21:12:17 -0700 (PDT)
Received: from [10.162.40.141] (p8cg001049571a15.blr.arm.com [10.162.40.141])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 88F293F59C;
        Mon, 23 Sep 2019 21:12:14 -0700 (PDT)
Subject: Re: [PATCH] mm/hotplug: Reorder memblock_[free|remove]() calls in
 try_remove_memory()
To:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>
References: <1568612857-10395-1-git-send-email-anshuman.khandual@arm.com>
 <20190923105224.GH6016@dhcp22.suse.cz>
 <9b85f517-fee5-650a-4e18-29408ca85804@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <ef55498f-a410-bb51-389c-7ac09641c51a@arm.com>
Date:   Tue, 24 Sep 2019 09:42:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <9b85f517-fee5-650a-4e18-29408ca85804@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/23/2019 04:24 PM, David Hildenbrand wrote:
> On 23.09.19 12:52, Michal Hocko wrote:
>> On Mon 16-09-19 11:17:37, Anshuman Khandual wrote:
>>> In add_memory_resource() the memory range to be hot added first gets into
>>> the memblock via memblock_add() before arch_add_memory() is called on it.
>>> Reverse sequence should be followed during memory hot removal which already
>>> is being followed in add_memory_resource() error path. This now ensures
>>> required re-order between memblock_[free|remove]() and arch_remove_memory()
>>> during memory hot-remove.
>>
>> This changelog is not really easy to follow. First of all please make
>> sure to explain whether there is any actual problem to solve or this is
>> an aesthetic matter. Please think of people reading this changelog in
>> few years and scratching their heads what you were thinking back then...
>>
> 
> I think it would make sense to just draft the current call sequence in
> the add and the removal path (instead of describing it) - then it
> becomes obvious why this is a cosmetic change.

Does this look okay ?

mm/hotplug: Reorder memblock_[free|remove]() calls in try_remove_memory()

Currently during memory hot add procedure, memory gets into memblock before
calling arch_add_memory() which creates it's linear mapping.

add_memory_resource() {
        ..................
        memblock_add_node()
        ..................
        arch_add_memory()
        ..................
}

But during memory hot remove procedure, removal from memblock happens first
before it's linear mapping gets teared down with arch_remove_memory() which
is not coherent. Resource removal should happen in reverse order as they
were added.

try_remove_memory() {
        ..................
        memblock_free()
        memblock_remove()
        ..................
        arch_remove_memory()
        ..................
}

This changes the sequence of resource removal including memblock and linear
mapping tear down during memory hot remove which will now be the reverse
order in which they were added during memory hot add. The changed removal
order looks like the following.

try_remove_memory() {
        ..................
        arch_remove_memory()
        ..................
        memblock_free()
        memblock_remove()
        ..................
}
