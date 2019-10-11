Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4011FC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 18:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F2D520673
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 18:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbfJKSQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 14:16:57 -0400
Received: from foss.arm.com ([217.140.110.172]:39244 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728470AbfJKSQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 14:16:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4212F142F;
        Fri, 11 Oct 2019 11:16:56 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B7AAC3F703;
        Fri, 11 Oct 2019 11:16:52 -0700 (PDT)
Subject: Re: [PATCH v3 06/17] arm64, hibernate: add trans_pgd public functions
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20190821183204.23576-1-pasha.tatashin@soleen.com>
 <20190821183204.23576-7-pasha.tatashin@soleen.com>
 <bcc3f71f-97d2-dff4-c55a-4798c6e2bede@arm.com>
 <CA+CK2bCwRm_AQHzrJ8tdjp5k6Yj+32yRsvQsOoy7b44GTdd6wQ@mail.gmail.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <f1dbf5c6-7caf-daae-aec4-9a47a367c119@arm.com>
Date:   Fri, 11 Oct 2019 19:16:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CA+CK2bCwRm_AQHzrJ8tdjp5k6Yj+32yRsvQsOoy7b44GTdd6wQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 06/09/2019 17:00, Pavel Tatashin wrote:
> On Fri, Sep 6, 2019 at 11:18 AM James Morse <james.morse@arm.com> wrote:
>> On 21/08/2019 19:31, Pavel Tatashin wrote:
>>> trans_pgd_create_copy() and trans_pgd_map_page() are going to be
>>> the basis for public interface of new subsystem that handles page
>>
>> Please don't call this a subsystem. 'sound' and 'mm' are subsystems, this is just some
>> shared code.

> Sounds good: just could not find a better term to call trans_pgd_*.

I don't like the trans_pgd_ name either, but I can't think of anything better, and its
only a name.


> I won't fix log commits.

Please avoid the word 'subsystem',


>>> diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
>>> index 750ecc7f2cbe..2e29d620b56c 100644
>>> --- a/arch/arm64/kernel/hibernate.c
>>> +++ b/arch/arm64/kernel/hibernate.c
>>> @@ -182,39 +182,15 @@ int arch_hibernation_header_restore(void *addr)
>>
>>> +int trans_pgd_map_page(pgd_t *trans_pgd, void *page,
>>> +                    unsigned long dst_addr,
>>> +                    pgprot_t pgprot)
>>
>> If this thing is going to be exposed, its name should reflect that its creating a set of
>> page tables, to map a single page.
>>
>> A function called 'map_page' with this prototype should 'obviously' map @page at @dst_addr
>> in @trans_pgd using the provided @pgprot... but it doesn't.
> 
> Answered below...
> 
>>
>> This is what 'create' was doing in the old name, if that wasn't obvious, its because
>> naming things is hard!
>> | trans_create_single_page_mapping()?
>>
>> (might be too verbose)
>>
>> I think this bites you in patch 8, where you 'generalise' this.

> The new naming makes more sense to me. The old code had function named:
> 
> create_safe_exec_page()
> 
> It was doing four things: 1. creating the actual page via provided
> allocator, 2. copying content from the provided page to new page, 3
> creating a new page table. 4 mapping it to a new page table at
> specified destination address

Yup, all implied in the work of creation.


> After, I generalize this the function the prototype looks like this:
> 
> int trans_pgd_map_page(struct trans_pgd_info *info, pgd_t *trans_pgd,
>                                          void *page, unsigned long
> dst_addr, pgprot_t pgprot)
> 
> The function only does the "4" from the old code: map the specified
> page at dst_addr.


> The trans_pgd is already created.

Which one is this?
The existing hibernate code has two PGD. One for the copy of the linear-map, one for this
safe page that contains the code doing the copying.


> Of course, and
> mapping function will have to allocate missing tables in the page
> tables when necessary.

I think you are over generalising this, to support a case that doesn't exist.

Hibernate needs a copy of the linear map to relocate memory, without stepping in
page-table, and an executable page it can do that from.

To get kexec to relocate the kernel with the MMU on... you need the same.

When do you need to add an arbitrary page to either of these sets of tables? Its either a
copy of the linear-map, or the single executable page.

When would does 'trans_pgd_map_page()' get used outside those two?

(looking in your later series, I see you are using it to try and idmap stuff into the low
memory. We can't do stuff like this because there may not be any memory in range of the
page table helpers. More details in that patch)


Thanks,

James
