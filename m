Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EDDC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 16:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 978FC2082E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 16:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="GLdXXnhL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733270AbfIEQ3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 12:29:37 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:43220 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730777AbfIEQ3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 12:29:36 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 352D23FBBA;
        Thu,  5 Sep 2019 18:29:29 +0200 (CEST)
Authentication-Results: pio-pvt-msa3.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=GLdXXnhL;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GkcQmJL962Gx; Thu,  5 Sep 2019 18:29:28 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 99AC53FA34;
        Thu,  5 Sep 2019 18:29:26 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 25A64360160;
        Thu,  5 Sep 2019 18:29:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1567700966; bh=pG0TnA/QjvfGPWD0SGrgVkNWASVfS3us4YRoLbkZweY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GLdXXnhLdXo93d/AM7fRLLrTjXj3fu7aaTaeuCI4iZREMNJ+ZsgPjdeS+6AT+ixkt
         q/8CIqkJRBuS6OlPPSCqjgoZkgt4cCoaKZDdmjMMVfXUudhhI2HDTmuR+MtVxeJuXc
         lD1eDeynjNfo15bMPuyzhaC240h/m3KKT/sg0wcc=
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
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>
References: <20190905103541.4161-1-thomas_os@shipmail.org>
 <20190905103541.4161-2-thomas_os@shipmail.org>
 <608bbec6-448e-f9d5-b29a-1984225eb078@intel.com>
 <b84d1dca-4542-a491-e585-a96c9d178466@shipmail.org>
 <1badd275-91aa-45a6-0a89-ded65c7c3829@intel.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <1ceb9abc-7a11-eaa1-b286-11647211e2fc@shipmail.org>
Date:   Thu, 5 Sep 2019 18:29:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1badd275-91aa-45a6-0a89-ded65c7c3829@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/19 5:59 PM, Dave Hansen wrote:
> On 9/5/19 8:21 AM, Thomas Hellström (VMware) wrote:
>>>>    #define pgprot_modify pgprot_modify
>>>>    static inline pgprot_t pgprot_modify(pgprot_t oldprot, pgprot_t
>>>> newprot)
>>>>    {
>>>> -    pgprotval_t preservebits = pgprot_val(oldprot) & _PAGE_CHG_MASK;
>>>> -    pgprotval_t addbits = pgprot_val(newprot);
>>>> +    pgprotval_t preservebits = pgprot_val(oldprot) &
>>>> +        (_PAGE_CHG_MASK | sme_me_mask);
>>>> +    pgprotval_t addbits = pgprot_val(newprot) & ~sme_me_mask;
>>>>        return __pgprot(preservebits | addbits);
>>>>    }
>>> _PAGE_CHG_MASK is claiming similar functionality about preserving bits
>>> when changing PTEs:
> ...
>>>> #define _PAGE_CHG_MASK  (PTE_PFN_MASK | _PAGE_PCD | _PAGE_PWT
>>>> |         \
>>>>                            _PAGE_SPECIAL | _PAGE_ACCESSED |
>>>> _PAGE_DIRTY | \
>>>>                            _PAGE_SOFT_DIRTY | _PAGE_DEVMAP)
>>> This makes me wonder if we should be including sme_me_mask in
>>> _PAGE_CHG_MASK (logically).
>> I was thinking the same. But what confuses me is that addbits isn't
>> masked with ~_PAGE_CHG_MASK, which is needed for sme_me_mask, since the
>> problem otherwise is typically that the encryption bit is incorrectly
>> set in addbits. I wonder whether it's an optimization or intentional.
> I think there's a built-in assumption that 'newprot' won't have any of
> the _PAGE_CHG_MASK bits set.  That makes sense because there are no
> protection bits in the mask.  But, the code certainly doesn't enforce that.
>
> Are you seeing 'sme_me_mask' bits set in 'newprot'?

Yes. AFAIK it's only one bit, and typically always set.

/Thomas


