Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBF1C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 04:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8C65217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 04:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731717AbfEXEwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 00:52:15 -0400
Received: from foss.arm.com ([217.140.101.70]:33468 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbfEXEwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 00:52:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D285374;
        Thu, 23 May 2019 21:52:14 -0700 (PDT)
Received: from [10.162.42.134] (p8cg001049571a15.blr.arm.com [10.162.42.134])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D2773F703;
        Thu, 23 May 2019 21:52:07 -0700 (PDT)
Subject: Re: [PATCH V4 3/4] arm64/mm: Hold memory hotplug lock while walking
 for kernel page table dump
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        akpm@linux-foundation.org, catalin.marinas@arm.com,
        will.deacon@arm.com, mark.rutland@arm.com, ira.weiny@intel.com,
        david@redhat.com, cai@lca.pw, logang@deltatee.com,
        james.morse@arm.com, cpandya@codeaurora.org, arunks@codeaurora.org,
        dan.j.williams@intel.com, mgorman@techsingularity.net,
        osalvador@suse.de, ard.biesheuvel@arm.com
References: <1558329516-10445-1-git-send-email-anshuman.khandual@arm.com>
 <1558329516-10445-4-git-send-email-anshuman.khandual@arm.com>
 <20190521101457.GK32329@dhcp22.suse.cz>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <4a9e0e2a-2acd-11b5-5181-41801cd11d98@arm.com>
Date:   Fri, 24 May 2019 10:22:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190521101457.GK32329@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/21/2019 03:44 PM, Michal Hocko wrote:
> On Mon 20-05-19 10:48:35, Anshuman Khandual wrote:
>> The arm64 page table dump code can race with concurrent modification of the
>> kernel page tables. When a leaf entries are modified concurrently, the dump
>> code may log stale or inconsistent information for a VA range, but this is
>> otherwise not harmful.
>>
>> When intermediate levels of table are freed, the dump code will continue to
>> use memory which has been freed and potentially reallocated for another
>> purpose. In such cases, the dump code may dereference bogus addresses,
>> leading to a number of potential problems.
>>
>> Intermediate levels of table may by freed during memory hot-remove,
>> which will be enabled by a subsequent patch. To avoid racing with
>> this, take the memory hotplug lock when walking the kernel page table.
> 
> I've had a comment on this patch in the previous version which didn't
> get answered completely AFAICS. If you really insist then please make
> sure to describe why does this really matter because this will make
> any further changes to the hotplug locking harder and I would to see
> that it is worth the additional trouble.

Hello Michal,

I was under the impression (seems wrongful now) that the previous discussion
was complete. Nonetheless we can still discuss it further. Mark has responded
on the previous V3 thread [1] and because this particular patch does not have
any changes from last time, we can continue discussing this in that thread.

[1] https://lkml.org/lkml/2019/5/22/613   

- Anshuman
