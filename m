Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73175C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 15:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A27F820820
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 15:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="KAkWOu+x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390021AbfIEPVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 11:21:37 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:61181 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388057AbfIEPVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 11:21:36 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id D8C7F3F478;
        Thu,  5 Sep 2019 17:21:28 +0200 (CEST)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=KAkWOu+x;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=shipmail.org
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WTG1gvVG6mPF; Thu,  5 Sep 2019 17:21:27 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id B49B73F6DE;
        Thu,  5 Sep 2019 17:21:24 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 40C64360160;
        Thu,  5 Sep 2019 17:21:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1567696884; bh=NG8liGCrurC3Kiw5aHunM7ayFbaO22LNknP8UX20R8A=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KAkWOu+xaC7GJBsRMY4xoJkMaq6SYn/mhV+QeVqOHLj/AZGAbCSmFa+29JWCp4jNY
         hsM9PrQd/CgGI1evlVZ0n3opn8VR7YSQudWfMfFKBNYRnikSuGdIbkJK91RDncpdD5
         FDyyTmK+JjSyGOcuFr7Y/vhb+2fdEKmfzPIocJ7Q=
Subject: Re: [RFC PATCH 1/2] x86: Don't let pgprot_modify() change the page
 encryption bit
To:     Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, pv-drivers@vmware.com
Cc:     Thomas Hellstrom <thellstrom@vmware.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Christoph Hellwig <hch@infradead.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20190905103541.4161-1-thomas_os@shipmail.org>
 <20190905103541.4161-2-thomas_os@shipmail.org>
 <608bbec6-448e-f9d5-b29a-1984225eb078@intel.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <b84d1dca-4542-a491-e585-a96c9d178466@shipmail.org>
Date:   Thu, 5 Sep 2019 17:21:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <608bbec6-448e-f9d5-b29a-1984225eb078@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/19 4:15 PM, Dave Hansen wrote:
> Hi Thomas,
>
> Thanks for the second batch of patches!  These look much improved on all
> fronts.

Yes, although the TTM functionality isn't in yet. Hopefully we won't 
have to bother you with those though, since this assumes TTM will be 
using the dma API.

> On 9/5/19 3:35 AM, Thomas Hellström (VMware) wrote:
>> -/* mprotect needs to preserve PAT bits when updating vm_page_prot */
>> +/*
>> + * mprotect needs to preserve PAT and encryption bits when updating
>> + * vm_page_prot
>> + */
>>   #define pgprot_modify pgprot_modify
>>   static inline pgprot_t pgprot_modify(pgprot_t oldprot, pgprot_t newprot)
>>   {
>> -	pgprotval_t preservebits = pgprot_val(oldprot) & _PAGE_CHG_MASK;
>> -	pgprotval_t addbits = pgprot_val(newprot);
>> +	pgprotval_t preservebits = pgprot_val(oldprot) &
>> +		(_PAGE_CHG_MASK | sme_me_mask);
>> +	pgprotval_t addbits = pgprot_val(newprot) & ~sme_me_mask;
>>   	return __pgprot(preservebits | addbits);
>>   }
> _PAGE_CHG_MASK is claiming similar functionality about preserving bits
> when changing PTEs:
>
>> /*
>>   * Set of bits not changed in pte_modify.  The pte's
>>   * protection key is treated like _PAGE_RW, for
>>   * instance, and is *not* included in this mask since
>>   * pte_modify() does modify it.
>>   */
>> #define _PAGE_CHG_MASK  (PTE_PFN_MASK | _PAGE_PCD | _PAGE_PWT |         \
>>                           _PAGE_SPECIAL | _PAGE_ACCESSED | _PAGE_DIRTY | \
>>                           _PAGE_SOFT_DIRTY | _PAGE_DEVMAP)
> This makes me wonder if we should be including sme_me_mask in
> _PAGE_CHG_MASK (logically).

I was thinking the same. But what confuses me is that addbits isn't 
masked with ~_PAGE_CHG_MASK, which is needed for sme_me_mask, since the 
problem otherwise is typically that the encryption bit is incorrectly 
set in addbits. I wonder whether it's an optimization or intentional.

/Thomas



