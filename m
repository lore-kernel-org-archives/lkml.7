Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30AAECE58C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 16:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70D342067B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 16:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="L1LgQkaa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731798AbfJIQUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 12:20:36 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:49724 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731083AbfJIQUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 12:20:36 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id E43AA3F503;
        Wed,  9 Oct 2019 18:20:27 +0200 (CEST)
Authentication-Results: pio-pvt-msa3.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=L1LgQkaa;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XHAqkNolIUYl; Wed,  9 Oct 2019 18:20:24 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 95D1C3F315;
        Wed,  9 Oct 2019 18:20:22 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id F0AC936016C;
        Wed,  9 Oct 2019 18:20:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1570638022; bh=15nrot/7wNjB0kN4+a5UAu154h85Yrs+uYJfO3V81ZI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=L1LgQkaa61DY0KI5m3lwcwTx0pPa3Jl4tKDsCKiHxLn2Kv4bhXtKKhdHjJ9ok69OA
         qe44WjgVeRB0eyhf7YyfKwgHD/7TdPOHPUqMlkgNbvNT4BOBMdejyxs93VMYaGe8r/
         neaDUtO2LuwYqORXgYFLnzZdZxFrgwiM3vlYJVtk=
Subject: Re: [PATCH v4 3/9] mm: pagewalk: Don't split transhuge pmds when a
 pmd_entry is present
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        torvalds@linux-foundation.org,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
References: <20191008091508.2682-1-thomas_os@shipmail.org>
 <20191008091508.2682-4-thomas_os@shipmail.org>
 <20191009152737.p42w7w456zklxz72@box>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <467a4a34-27be-8f46-2c9a-c5b335d11438@shipmail.org>
Date:   Wed, 9 Oct 2019 18:20:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191009152737.p42w7w456zklxz72@box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Kirill.

Thanks for reviewing.

On 10/9/19 5:27 PM, Kirill A. Shutemov wrote:
> On Tue, Oct 08, 2019 at 11:15:02AM +0200, Thomas Hellström (VMware) wrote:
>> From: Thomas Hellstrom <thellstrom@vmware.com>
>>
>> The pagewalk code was unconditionally splitting transhuge pmds when a
>> pte_entry was present. However ideally we'd want to handle transhuge pmds
>> in the pmd_entry function and ptes in pte_entry function. So don't split
>> huge pmds when there is a pmd_entry function present, but let the callback
>> take care of it if necessary.
> Do we have any current user that expect split_huge_pmd() in this scenario.

No. All current users either have pmd_entry (no splitting) or pte_entry 
(unconditional splitting)

>
>> In order to make sure a virtual address range is handled by one and only
>> one callback, and since pmd entries may be unstable, we introduce a
>> pmd_entry return code that tells the walk code to continue processing this
>> pmd entry rather than to move on. Since caller-defined positive return
>> codes (up to 2) are used by current callers, use a high value that allows a
>> large range of positive caller-defined return codes for future users.
>>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Rik van Riel <riel@surriel.com>
>> Cc: Minchan Kim <minchan@kernel.org>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Huang Ying <ying.huang@intel.com>
>> Cc: Jérôme Glisse <jglisse@redhat.com>
>> Cc: Kirill A. Shutemov <kirill@shutemov.name>
>> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
>> Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
>> ---
>>   include/linux/pagewalk.h |  8 ++++++++
>>   mm/pagewalk.c            | 28 +++++++++++++++++++++-------
>>   2 files changed, 29 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
>> index bddd9759bab9..c4a013eb445d 100644
>> --- a/include/linux/pagewalk.h
>> +++ b/include/linux/pagewalk.h
>> @@ -4,6 +4,11 @@
>>   
>>   #include <linux/mm.h>
>>   
>> +/* Highest positive pmd_entry caller-specific return value */
>> +#define PAGE_WALK_CALLER_MAX     (INT_MAX / 2)
>> +/* The handler did not handle the entry. Fall back to the next level */
>> +#define PAGE_WALK_FALLBACK       (PAGE_WALK_CALLER_MAX + 1)
>> +
> That's hacky.
>
> Maybe just use an error code for this? -EAGAIN?

I agree this is hacky. But IMO it's a reasonably safe option. My 
thinking was that in the long run we'd move the positive return codes to 
the mm_walk private and introduce a PAGE_WALK_TERMINATE code as well.

Perhaps a completely clean and safe way would be to add an "int 
walk_control" in the struct mm_walk?

I'm pretty sure using an error code will come back and bite us at some 
point, if someone just blindly forwards error messages. But if you 
insist, I'll use -EAGAIN.

Please let me know what you think.

Thanks,

Thomas


