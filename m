Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CA4C5B57D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 08:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04EAB218A3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 08:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbfGEI35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 04:29:57 -0400
Received: from foss.arm.com ([217.140.110.172]:60928 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726800AbfGEI35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 04:29:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA26C2B;
        Fri,  5 Jul 2019 01:29:56 -0700 (PDT)
Received: from [10.162.41.127] (p8cg001049571a15.blr.arm.com [10.162.41.127])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B2C713F246;
        Fri,  5 Jul 2019 01:29:54 -0700 (PDT)
Subject: Re: [PATCH] mm/isolate: Drop pre-validating migrate type in
 undo_isolate_page_range()
To:     Oscar Salvador <osalvador@suse.de>
Cc:     linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
        Qian Cai <cai@lca.pw>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <1562307161-30554-1-git-send-email-anshuman.khandual@arm.com>
 <20190705075857.GA28725@linux>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <ae5e183b-c5f7-2a37-2c14-110102ec37ed@arm.com>
Date:   Fri, 5 Jul 2019 14:00:22 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190705075857.GA28725@linux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/05/2019 01:29 PM, Oscar Salvador wrote:
> On Fri, Jul 05, 2019 at 11:42:41AM +0530, Anshuman Khandual wrote:
>> unset_migratetype_isolate() already validates under zone lock that a given
>> page has already been isolated as MIGRATE_ISOLATE. There is no need for
>> another check before. Hence just drop this redundant validation.
>>
>> Cc: Oscar Salvador <osalvador@suse.de>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Qian Cai <cai@lca.pw>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: linux-mm@kvack.org
>> Cc: linux-kernel@vger.kernel.org
>>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> Is there any particular reason to do this migratetype pre-check without zone
>> lock before calling unsert_migrate_isolate() ? If not this should be removed.
> 
> I have seen this kinda behavior-checks all over the kernel.
> I guess that one of the main goals is to avoid lock contention, so we check
> if the page has the right migratetype, and then we check it again under the lock
> to see whether that has changed.

So the worst case when it becomes redundant might not affect the performance much ?

> 
> e.g: simultaneous calls to undo_isolate_page_range

Right.

> 
> But I am not sure if the motivation behind was something else, as the changelog
> that added this code was quite modest.

Agreed.

> 
> Anyway, how did you come across with this?
> Do things get speed up without this check? Or what was the motivation to remove it?

Detected this during a code audit. I figured it can help save some cycles. The other
call site start_isolate_page_range() does not check migrate type because the page
block is guaranteed to be MIGRATE_ISOLATE ? I am not sure if a non-lock check first
in this case is actually improving performance. In which case should we just leave
the check as is ?
