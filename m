Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A786C4CED1
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 11:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF47A2086A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 11:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="OJfAZWca"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730122AbfJCLcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 07:32:25 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:32214 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729942AbfJCLcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 07:32:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 2854E3F6AF;
        Thu,  3 Oct 2019 13:32:15 +0200 (CEST)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=OJfAZWca;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=shipmail.org
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id oYPLsr8Qw99B; Thu,  3 Oct 2019 13:32:11 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id F0E113F606;
        Thu,  3 Oct 2019 13:32:09 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 70EB0360058;
        Thu,  3 Oct 2019 13:32:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1570102329; bh=4R+oNk9LjSksI0IEwsugOtFE/wcCVB50Tp041MEWnHw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OJfAZWcasPC9OIzDgaSFf4Z3aYq1bCXXRjT7k0LLVebI+gvcO7r3JE0TArknPa8Bl
         AT42Fc4cYqToei7CpqclZe+DDm8tRzC9CDGP3Y7m/LXwzzo1O4/9hQs6fiocDg2ZCP
         4hslZ2q3KC6PM3Lr+tfnJT72qURmaPcvPueKDiWE=
Subject: Re: [PATCH v3 1/7] mm: Remove BUG_ON mmap_sem not held from
 xxx_trans_huge_lock()
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
References: <20191002134730.40985-1-thomas_os@shipmail.org>
 <20191002134730.40985-2-thomas_os@shipmail.org>
 <20191003110232.mltuantcw5pcrybo@box>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <aa671279-c874-aedd-667f-e3a604bb0d67@shipmail.org>
Date:   Thu, 3 Oct 2019 13:32:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191003110232.mltuantcw5pcrybo@box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Kirill,

On 10/3/19 1:02 PM, Kirill A. Shutemov wrote:
> On Wed, Oct 02, 2019 at 03:47:24PM +0200, Thomas Hellström (VMware) wrote:
>> From: Thomas Hellstrom <thellstrom@vmware.com>
>>
>> The caller needs to make sure that the vma is not torn down during the
>> lock operation and can also use the i_mmap_rwsem for file-backed vmas.
>> Remove the BUG_ON. We could, as an alternative, add a test that either
>> vma->vm_mm->mmap_sem or vma->vm_file->f_mapping->i_mmap_rwsem are held.
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Rik van Riel <riel@surriel.com>
>> Cc: Minchan Kim <minchan@kernel.org>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Huang Ying <ying.huang@intel.com>
>> Cc: Jérôme Glisse <jglisse@redhat.com>
>> Cc: Kirill A. Shutemov <kirill@shutemov.name>
>> Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
> The patch looks good to me:
>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>
> But I looked at usage at pagewalk.c and it is inconsitent.  The walker
> takes ptl before calling ->pud_entry(), but not for ->pmd_entry().
>
> It should be fixed: do not take the lock before ->pud_entry(). The
> callback must take care of it.
>
> Looks like we have single ->pud_entry() implementation the whole kernel.
> It should be trivial to fix.
>
> Could you do this?
>
I could probably fix that. There are some comments in the patch 
introducing that code as to why it was done that way, though, but I 
don't remember offhand what the arguments were.

But there seems to be more races WRT puds. See my next email. Perhaps 
this should be fixed as part of a larger audit of the huge_pud code?

/Thomas


