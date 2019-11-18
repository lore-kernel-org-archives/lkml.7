Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8932AC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 12:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41AE7206D4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 12:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="eabxb1st"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfKRM6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 07:58:18 -0500
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:60278 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfKRM6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 07:58:17 -0500
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id E7CA83F731;
        Mon, 18 Nov 2019 13:58:14 +0100 (CET)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=eabxb1st;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=shipmail.org
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1OKBn0n20cbF; Mon, 18 Nov 2019 13:58:10 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 8B8783F6AF;
        Mon, 18 Nov 2019 13:58:05 +0100 (CET)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id C6DA0360070;
        Mon, 18 Nov 2019 13:58:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1574081884; bh=AFDCrmlbjICMQZSk5hGF7cpQTlFoaR/bVow1qk93kfs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=eabxb1stIuKrkqGocBX6wlcN+Vsl3Ml+lvM15Z9rzFU/k6+3D1OOmGzr/0RdpYC4C
         EyVHCjUubPlth+gEJoRjOTwLwmbWcIPDYJz/E/Ul1iAxbVUaHjihH2oxXW1Fm1yzxi
         9Mflq8G4RASgUVWHN9eI0QWRr+zFMe3SmpidQ6Lk=
Subject: Re: [PATCH 2/2] mm: Fix a huge pud insertion race during faulting
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20191115115808.21181-1-thomas_os@shipmail.org>
 <20191115115808.21181-2-thomas_os@shipmail.org>
 <20191115115800.45c053abcdb550d70b9baec9@linux-foundation.org>
 <20191118102219.om5monxih7kfodyz@box>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <b8600932-517d-99d3-90b4-d9b9e8a6f641@shipmail.org>
Date:   Mon, 18 Nov 2019 13:58:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191118102219.om5monxih7kfodyz@box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/19 11:22 AM, Kirill A. Shutemov wrote:
> On Fri, Nov 15, 2019 at 11:58:00AM -0800, Andrew Morton wrote:
>> On Fri, 15 Nov 2019 12:58:08 +0100 Thomas Hellström (VMware) <thomas_os@shipmail.org> wrote:
>>
>>> A huge pud page can theoretically be faulted in racing with pmd_alloc()
>>> in __handle_mm_fault(). That will lead to pmd_alloc() returning an
>>> invalid pmd pointer. Fix this by adding a pud_trans_unstable() function
>>> similar to pmd_trans_unstable() and check whether the pud is really stable
>>> before using the pmd pointer.
>>>
>>> Race:
>>> Thread 1:             Thread 2:                 Comment
>>> create_huge_pud()                               Fallback - not taken.
>>> 		      create_huge_pud()         Taken.
>>> pmd_alloc()                                     Returns an invalid pointer.
>> What are the user-visible runtime effects of this change?
> Data corruption: kernel writes to a huge page thing it's page table.
>
>> Is a -stable backport warranted?
> I believe it is.

Note that this was caught during a code audit rather than a real 
experienced problem. It looks to me like the only implementation that 
currently creates huge pud pagetable entries is dev_dax_huge_fault() 
which doesn't appear to care much about private (COW) mappings or 
write-tracking which is, I believe, a prerequisite for create_huge_pud() 
falling back on thread 1, but not in thread 2.

This means (assuming that's intentional) that a stable backport 
shouldn't be needed.

For the WIP huge page support for graphics memory we'll be allowing both 
COW mappings and write-tracking, though, but that's still some time away.

In any case, I think this patch needs -rc testing to catch potential 
pud_devmap issues before submitted to stable.

Thanks,

Thomas

>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>

