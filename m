Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C04C4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 05:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A04A720872
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 05:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="fJJ8stiF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388043AbfJPF7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 01:59:22 -0400
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:36756 "EHLO
        pio-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387456AbfJPF7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 01:59:22 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id AA8013F58C;
        Wed, 16 Oct 2019 07:59:19 +0200 (CEST)
Authentication-Results: pio-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b="fJJ8stiF";
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Db7RCe3ck6eR; Wed, 16 Oct 2019 07:59:18 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id E3D573F3E9;
        Wed, 16 Oct 2019 07:59:16 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 08B6D36016A;
        Wed, 16 Oct 2019 07:59:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1571205556; bh=G8caty1vfjDKgi8cYpMLHgDk8AAGh2FELnAVuxzsrGU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fJJ8stiF8BY75eQIWwHussZcTxefdSlKA3a3c52QcdUDaoJ545f9fZ/C3wNU0v3Nw
         j8vn8rcAXmRixyOBgetmXAdYUYq2oEgoLd5RYJMLI1R5a+Kot2Ceucki6X1U4GhNHG
         y9bbPAtb52PwZZ9TfF7pKESpgdPpEV+OSH7bF4V0=
Subject: Re: [RFC PATCH] mm: Fix a huge pud insertion race during faulting
To:     Dan Williams <dan.j.williams@intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Hellstrom <thellstrom@vmware.com>
References: <20191008093711.3410-1-thomas_os@shipmail.org>
 <20191015100653.ittq4b2mx7pszky5@box>
 <CAA9_cmcSXYB1jo1=CQ78eXVcyGWm1_TjQKd-Gmg0yAO3tObOFw@mail.gmail.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <3a16a199-a4bd-5503-3146-3fb24bfb2638@shipmail.org>
Date:   Wed, 16 Oct 2019 07:59:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAA9_cmcSXYB1jo1=CQ78eXVcyGWm1_TjQKd-Gmg0yAO3tObOFw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Dan,

On 10/16/19 3:44 AM, Dan Williams wrote:
> On Tue, Oct 15, 2019 at 3:06 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>> On Tue, Oct 08, 2019 at 11:37:11AM +0200, Thomas Hellström (VMware) wrote:
>>> From: Thomas Hellstrom <thellstrom@vmware.com>
>>>
>>> A huge pud page can theoretically be faulted in racing with pmd_alloc()
>>> in __handle_mm_fault(). That will lead to pmd_alloc() returning an
>>> invalid pmd pointer. Fix this by adding a pud_trans_unstable() function
>>> similar to pmd_trans_unstable() and check whether the pud is really stable
>>> before using the pmd pointer.
>>>
>>> Race:
>>> Thread 1:             Thread 2:                 Comment
>>> create_huge_pud()                               Fallback - not taken.
>>>                      create_huge_pud()         Taken.
>>> pmd_alloc()                                     Returns an invalid pointer.
>>>
>>> Cc: Matthew Wilcox <willy@infradead.org>
>>> Fixes: a00cc7d9dd93 ("mm, x86: add support for PUD-sized transparent hugepages")
>>> Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
>>> ---
>>> RFC: We include pud_devmap() as an unstable PUD flag. Is this correct?
>>>       Do the same for pmds?
>> I *think* it is correct and we should do the same for PMD, but I may be
>> wrong.
>>
>> Dan, Matthew, could you comment on this?
> The _devmap() check in these paths near _trans_unstable() has always
> been about avoiding assumptions that the corresponding page might be
> page cache or anonymous which for dax it's neither and does not behave
> like a typical page.

The concern here is that _trans_huge() returns false for _devmap() 
pages, which means that also _trans_unstable() returns false.

Still, I figure someone could zap the entry at any time using madvise(), 
so AFAICT the entry is indeed unstable, and it's a bug not to include 
_devmap() in the _trans_unstable() functions?

Thanks,

Thomas


