Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D57C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 09:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7D50217D9
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 09:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="aVVJqjzH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfI0J1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 05:27:12 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:48770 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfI0J1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 05:27:11 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 85F7E3F4B6;
        Fri, 27 Sep 2019 11:27:09 +0200 (CEST)
Authentication-Results: pio-pvt-msa3.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=aVVJqjzH;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bnsC5UR0WgFA; Fri, 27 Sep 2019 11:27:08 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 98AE13F36B;
        Fri, 27 Sep 2019 11:27:07 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 0FDA53600A4;
        Fri, 27 Sep 2019 11:27:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1569576427; bh=XRuI+mdK64UN9f0IeE6ubS+3LhYSwvzPKVNTt/eWvTo=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=aVVJqjzHaKb9eBsNDILfQZF2R14j+nRA+RRDjqzGB9Ej0EE7hrJHuKL3+ulcpRIfB
         XjiX9tOA6tJtNW2ryPe5tnZqjd+uax5e5edCN+eNbz3Y8EwMEviyf+l3tCW3su16IG
         NXyLR9s7+TVF4PZqCiB99XcOuPUXLkpPjgp/DvMk=
Subject: Re: Ack to merge through DRM? WAS Re: [PATCH v2 1/5] mm: Add
 write-protect and clean utilities for address space ranges
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
References: <20190926115548.44000-1-thomas_os@shipmail.org>
 <20190926115548.44000-2-thomas_os@shipmail.org>
 <85e31bcf-d3c8-2fcf-e659-2c9f82ebedc7@shipmail.org>
 <CAHk-=wifjLeeMEtMPytiMAKiWkqPorjf1P4PbB3dj17Y3Jcqag@mail.gmail.com>
 <a48a93d2-03e9-40d3-3b4c-a301632d3121@shipmail.org>
 <CAHk-=whwN+CvaorsmczZRwFhSV+1x98xg-zajVD1qKmN=9JhBQ@mail.gmail.com>
 <c58cdb3d-4f5e-7bfc-06b3-58c27676d101@shipmail.org>
 <CAHk-=wh_+Co=T8wG8vb5akMP=7H4BN=Qpq6PsKh8rcmT8MCV+Q@mail.gmail.com>
 <e8954bda-671c-c680-8d0e-8993c0085401@shipmail.org>
Organization: VMware Inc.
Message-ID: <e809a1f3-cf80-87f9-4337-03e92af73bc9@shipmail.org>
Date:   Fri, 27 Sep 2019 11:27:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e8954bda-671c-c680-8d0e-8993c0085401@shipmail.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/19 7:55 AM, Thomas Hellström (VMware) wrote:
> On 9/27/19 12:20 AM, Linus Torvalds wrote:
>> On Thu, Sep 26, 2019 at 1:55 PM Thomas Hellström (VMware)
>> <thomas_os@shipmail.org> wrote:
>>> Well, we're working on supporting huge puds and pmds in the graphics
>>> VMAs, although in the write-notify cases we're looking at here, we 
>>> would
>>> probably want to split them down to PTE level.
>> Well, that's what the existing walker code does if you don't have that
>> "pud_entry()" callback.
>>
>> That said, I assume you would *not* want to do that if the huge
>> pud/pmd is already clean and read-only, but just continue.
>>
>> So you may want to have a special pud_entry() that handles that case.
>> Eventually. Maybe. Although honestly, if you're doing dirty tracking,
>> I doubt it makes much sense to use largepages.
>
> The approach we're looking at in this case is to keep huge entries 
> write-protected and split them in the wp_huge_xxx() code's fallback 
> path with the mmap_sem held. This means that there will actually be 
> huge entries in the page-walking code soon, but as you say, only 
> entries that we want to ignore and not split. So we'd also need a way 
> to avoid the pagewalk splitting for the situation when someone faults 
> a huge entry in just before the call to split_huge_xxx.
>
>>
>>> Looking at zap_pud_range() which when called from unmap_mapping_pages()
>>> uses identical locking (no mmap_sem), it seems we should be able to get
>>> away with i_mmap_lock(), making sure the whole page table doesn't
>>> disappear under us. So it's not clear to me why the mmap_sem is 
>>> strictly
>>> needed here. Better to sort those restrictions out now rather than when
>>> huge entries start appearing.
>> zap_pud_range()actually does have that
>>
>> VM_BUG_ON_VMA(!rwsem_is_locked(&tlb->mm->mmap_sem), vma);
>>
>> exactly for the case where it might have to split the pud entry.
>
> Yes. My take on this is that locking the PUD ptl can be done either 
> with the mmap_sem or the i_mmap_lock if present and that we should 
> update the asserts in xxx_trans_huge_lock to reflect that. But when 
> actually splitting transhuge pages you don't want to race with 
> khugepaged, so you need the mmap_sem. For the graphics VMAs 
> (MIXEDMAP), khugepaged never touches them. Yet.
>
>>
>> It's why they've never gotten translated to use the generic walker code.
>
> OK. Yes there are a number of various specialized pagewalks all over 
> the mm code.
>
> But another thing that worries me is that the page-table modifications 
> that happen in the callback use functionality that is not guaranteed 
> to be exported, and that mm people don't want them to be exported 
> because you don't want the drivers to go hacking around in page 
> tables, which means that the two callbacks used here would need to be 
> a set of core helpers anyway.
>
> So I figure what I would end up with would actually be an extern 
> __walk_page_range anyway, and slightly modified asserts. Do you think 
> that could be acceptible?


Actually, I'll give your original suggestion a try and see what I come 
up with.

Thanks,
Thomas

