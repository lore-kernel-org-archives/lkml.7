Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CC8C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 07:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B2E22070D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 07:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbfDJHUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 03:20:36 -0400
Received: from foss.arm.com ([217.140.101.70]:48846 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728787AbfDJHUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 03:20:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15131A78;
        Wed, 10 Apr 2019 00:20:35 -0700 (PDT)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A5AC3F68F;
        Wed, 10 Apr 2019 00:20:33 -0700 (PDT)
Subject: Re: [PATCH 0/6] objtool: Add support for Arm64
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Raphael Gault <raphael.gault@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
References: <20190409135243.12424-1-raphael.gault@arm.com>
 <CAKv+Gu_qGN8SG7ajkF7zAoAJd=qskC1oonmjzsqzZyGb9rYGLA@mail.gmail.com>
 <20190410033732.ibtpnd36655afpfj@treble>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <a96b5410-ce2a-2e7c-57ec-4f92fcc1652a@arm.com>
Date:   Wed, 10 Apr 2019 08:20:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190410033732.ibtpnd36655afpfj@treble>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/04/2019 04:37, Josh Poimboeuf wrote:
> On Tue, Apr 09, 2019 at 10:43:18AM -0700, Ard Biesheuvel wrote:
>> On Tue, 9 Apr 2019 at 06:53, Raphael Gault <raphael.gault@arm.com> wrote:
>>>
>>> Hi,
>>>
>>> As of now, objtool only supports the x86_64 architecture but the
>>> groundwork has already been done in order to add support for other
>>> architecture without too much effort.
>>>
>>> This series of patches adds support for the arm64 architecture
>>> based on the Armv8.5 Architecture Reference Manual.
>>>
>>
>> I think it makes sense to clarify *why* we want this on arm64. Also,
>> we should identify things that objtool does today that maybe we don't
>> want on arm64, rather than buy into all of it by default.
> 
> Agreed, the "why" should at least be in the cover letter.  From my
> perspective, the "why" includes:
> 
> - Live patching - objtool stack validation is the foundation for a
>   reliable unwinder
> 

Yes, as I understand Live patching is a work in progress for arm64.
Having objtool to provide more guarantees would be nice.

> - ORC unwinder - benefits include presumed improved overall performance
>   from disabling frame pointers, and the ability to unwind across
>   interrupts and exceptions
> 

I'm unsure this will be part of the plan. I believe so far arm64 code
heavily relies on the presence of frame pointers. It's also part of the
Aarch64 Procedure Call Standard.

But who knows.

> - PeterZ's new uaccess validation?
> 

Yes, we've reverted twice our implementation of user_access_begin/end()
on arm64 because of the issue of potentially calling sleeping functions.

Once we have the base of objtool work, this would be one of the next
work items.

Thanks,

-- 
Julien Thierry
