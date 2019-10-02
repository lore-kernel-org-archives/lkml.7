Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579C9ECE58A
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 13:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EF2C21783
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 13:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="nVm9z/Us"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbfJBN2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 09:28:17 -0400
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:35728 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfJBN2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 09:28:16 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id AE1453F4B9;
        Wed,  2 Oct 2019 15:28:13 +0200 (CEST)
Authentication-Results: pio-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=nVm9z/Us;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id l3Tlv0lnB0UB; Wed,  2 Oct 2019 15:28:12 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id DC4CE3F3FF;
        Wed,  2 Oct 2019 15:28:10 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 49E1F36016A;
        Wed,  2 Oct 2019 15:28:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1570022890; bh=/EBugeJrTD+nCNKHyemgWq/G9ItARTz8ze1eDBUS3kA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=nVm9z/UsSusOXVV/5lmZ5iCgZMAg7oYsmpJvJCpcTBb7wuwFjhUs9DI8sKTgsAmua
         Nh+RigK157768aZhapIU3mwPUQkaHFZC8Jv37gBY9bz1lGoPZMvlNQKMt1qUkH+vJV
         Jn6xfmiBeA7HevOIv1Mf3hP+CfOLMp4yLXewUEko=
Subject: Re: Ack to merge through DRM? WAS Re: [PATCH v2 1/5] mm: Add
 write-protect and clean utilities for address space ranges
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
 <50e83aeb-e971-f0ad-f034-ed592588eba7@shipmail.org>
 <20191002131819.asjr2tsx6lcmmbof@box>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <b574e08e-70ce-2cce-03d9-0052bb3f9f87@shipmail.org>
Date:   Wed, 2 Oct 2019 15:28:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191002131819.asjr2tsx6lcmmbof@box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/19 3:18 PM, Kirill A. Shutemov wrote:
> On Wed, Oct 02, 2019 at 11:21:01AM +0200, Thomas Hellström (VMware) wrote:
>> On 9/26/19 10:16 PM, Linus Torvalds wrote:
>>> On Thu, Sep 26, 2019 at 1:09 PM Thomas Hellström (VMware)
>>> <thomas_os@shipmail.org> wrote:
>>>> That said, if people are OK with me modifying the assert in
>>>> pud_trans_huge_lock() and make __walk_page_range non-static, it should
>>>> probably be possible to make it work, yes.
>>> I don't think you need to modify that assert at all.
>>>
>>> That thing only exists when there's a "pud_entry" op in the walker,
>>> and then you absolutely need to have that mmap_lock.
>>>
>>> As far as I can tell, you fundamentally only ever work on a pte level
>>> in your address space walker already and actually have a WARN_ON() on
>>> the pud_huge thing, so no pud entry can possibly apply.
>>>
>>> So no, the assert in pud_trans_huge_lock() does not seem to be a
>>> reason not to just use the existing page table walkers.
>>>
>>> And once you get rid of the walking, what is left? Just the "iterate
>>> over the inode mappings" part. Which could just be done in
>>> mm/pagewalk.c, and then you don't even need to remove the static.
>>>
>>> So making it be just another walking in pagewalk.c would seem to be
>>> the simplest model.
>>>
>>> Call it "walk_page_mapping()". And talk extensively about how the
>>> locking differs a lot from the usual "walk_page_vma()" things.
>>>
>>> The then actual "apply" functions (what a horrid name) could be in the
>>> users. They shouldn't be mixed in with the walking functions anyway.
>>> They are callbacks, not walkers.
>>>
>>>                Linus
>> Linus, Kirill
>>
>> I've pushed a reworked version based on the pagewalk code here:
>>
>> https://cgit.freedesktop.org/~thomash/linux/log/?h=pagewalk
>>
>> (top three patched)
>>
>> with users included here:
>>
>> https://cgit.freedesktop.org/~thomash/linux/log/?h=coherent-rebased
>>
>> Do you think this could work? The reason that the "mm: Add write-protect and
>> clean.." code is still in mm as a set of helpers, is of course that much of
>> the needed functionality is not exported, presumably since we want to keep
>> page table manipulation in mm.
> Could you post it to the mailing list? It's easier to review this way.
>
Sure.

/Thomas


