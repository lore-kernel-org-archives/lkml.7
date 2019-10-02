Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB98FC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 19:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89C6A21D82
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 19:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="Vv50zyjE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729702AbfJBTJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 15:09:50 -0400
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:36064 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729337AbfJBTJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 15:09:48 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id BDE753F31A;
        Wed,  2 Oct 2019 21:09:45 +0200 (CEST)
Authentication-Results: ste-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=Vv50zyjE;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VgvaLYn_a4rC; Wed,  2 Oct 2019 21:09:44 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 0B70E3F247;
        Wed,  2 Oct 2019 21:09:41 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 20E7036005C;
        Wed,  2 Oct 2019 21:09:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1570043381; bh=un9Yli6t+rpUOQrchmJq2mc/5qmOJ2r/ZU8Lu7dWySs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Vv50zyjEH94ORp4kXZ+FlQiRtzGFnTsl5Oj1OPFHbWYQApu4nh74c4WjqkEPdCxtV
         NGuOhQVfYQSTsXzmy927FMiSXbUIunG2gIf6kzqFKRGk/8iTcmH1cF7vMLbTmHLS4e
         Lz+7feRjwvV6itx+zr37L1X8S00HCTcyw5/U5RUg=
Subject: Re: [PATCH v3 3/7] mm: Add write-protect and clean utilities for
 address space ranges
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
References: <20191002134730.40985-1-thomas_os@shipmail.org>
 <20191002134730.40985-4-thomas_os@shipmail.org>
 <CAHk-=wic5vXCxpH-+UTtmH_t-EDBKrKnDhxQk=t_N20aiWnqUg@mail.gmail.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <516814a5-a616-b15e-ac87-26ede681da85@shipmail.org>
Date:   Wed, 2 Oct 2019 21:09:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wic5vXCxpH-+UTtmH_t-EDBKrKnDhxQk=t_N20aiWnqUg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/19 8:06 PM, Linus Torvalds wrote:
> On Wed, Oct 2, 2019 at 6:48 AM Thomas Hellström (VMware)
> <thomas_os@shipmail.org> wrote:
>> From: Thomas Hellstrom <thellstrom@vmware.com>
>>
>> Add two utilities to a) write-protect and b) clean all ptes pointing into
>> a range of an address space.
> This one I still don't exactly love.
>
> I'm not entirely sure what rubs me the wrong way, but part of it is
> naming. We don't use the name "as", because it reads as (sic) an
> English word.
>
> The name we use for address_space pointers is "mapping", both for
> variables and for existing functions.
>
> See for example "pte_same_as_swp()" which uses "as" as the _word_ 'as'.
>
> Contrast that with "unmap_mapping_range()" or
> "mapping_set_unevictable()" or "read_mapping_page()" or
> "invalidate_mapping_pages()", that all work on address spaces.
>
> So please don't use 'as' as shorthand for that - eithe rin the
> function names or the filename.
>
> I'm not sure if that's the _only_ thing that raises my heckles when I
> read this patch, but I think it might be. So I'm not saying "ack with
> naming change", but I suspect that if the naming was changed, it would
> look much better to me.
>
> Yes, it's a bit more typing. But I really think
> "clean_mapping_dirty_pages()" is just not only more in line with the
> mm naming, I think it's a lot more legible and understandable than
> "as_dirty_clean()", which just makes me go "what the heck does that
> function do?"
>
> And I really think it needs more than just "as" -> "mapping".
> "mapping_dirty_clean()" still makes me go "what?" in a way that
> "clean_mapping_dirty_pages()" does not. One name reads as a series or
> random words, the other reads as a "this is what the function does".
>
> I know I sometimes get hung up about naming, but I do think naming
> matters.  A descriptive name that just reads as what the function does
> makes it much easier to read the logic of code, imnsho.
>
>                Linus

Yes I typically tend towards using a "namespace_object_operation" naming 
scheme, with "as_dirty" being the namespace here,

But I'll give it a shot to see if I can rename it more in line with the 
above.

Looking at Matthew's suggestion but lining up with 
"unmap_mapping_range()", perhaps we could use "clean_mapping_range" and 
"wp_mapping_range"?

Thanks,

Thomas


