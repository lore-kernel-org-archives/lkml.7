Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C06EFC31E4D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94EF021721
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="vR79kuHp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbfFNNDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 09:03:25 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33301 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727654AbfFNNDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 09:03:24 -0400
Received: by mail-ed1-f68.google.com with SMTP id i11so3448781edq.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 06:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1va0Zhc3Ckkn/M19SdwI/BpgUN6PKWmJzS8DDu3XqvU=;
        b=vR79kuHpQYXyxhZu8YR3M90jIJfwFWRVTm/9V5oFLGKzLRardmvObkXq9H4m0Vi6eI
         hdVp7daDWmX4NjKKjpNMRAp78CxDsbQD0dTSkz6kE0JwSfjW+s9yUAyzRWPwZQif4fVH
         nuk2WQZjcSHf09oQmJX2MDlSzVGVSjO4GeyaiD6SyDJEiS8htGGxd7iLNeMT/kxvSm1K
         zL82qR4pLp7Cx5FFMhZ4N0XEq17N7fCBv9xkqog0PGDidrguk0g8sXWzpGmFNuTSt3L+
         RETLZdk/pnPMk4IGiN0Z8/lU/1Wsdyh4AEckoXvUwGz6WE5+ieVSd3lN4xWfjy49IirL
         Tbow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1va0Zhc3Ckkn/M19SdwI/BpgUN6PKWmJzS8DDu3XqvU=;
        b=D3Dt6XV9DeqkAkUv2oj9FGlZfxu1FmS9f2NN3FhiS0QNBMTcIlhjAX0oUb/e32xkK0
         LQYE1HsWJd/+YLXloVVG8K7NKVZ3h7Ech8kNadLRcYTldxFQE0ufXhcegTG1I7vHq6np
         y7vfkfsZAuI2EKUoH75rx20QIVcD8kuNILaHAAGgh0Q8lnb2s8kzBBrt4MjN88Z6REqy
         oQDW4bAHH1Xsqoj8UpQo8Gnd9XRqShDSbiYVKhRgq5QN02qgc9TkOrPaYN3LRj4KEsIp
         GiCvyK17tRdn5TSec6BEX4yuKPF7MIUsk3vJD8EPt82cOelNoSTpys2D6Xr1M5YFJ+7y
         VgXQ==
X-Gm-Message-State: APjAAAU7EItfr7cWOxdAT9QKx2MBdEQrB776d/1GpjWcMJ9A7sqJ+OlQ
        bTIIV20Fgt/ABC0da6/1KPYs8/MbFOA=
X-Google-Smtp-Source: APXvYqyF3tprtqswZ7hH6Vh6WtHyJArFxj3qOaU8YYRPmR2cn7Rbt/kKd3pYO/xaBN40TDf0h7NHSw==
X-Received: by 2002:a17:906:65d7:: with SMTP id z23mr13450758ejn.18.1560517403352;
        Fri, 14 Jun 2019 06:03:23 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id m6sm849255ede.2.2019.06.14.06.03.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 06:03:22 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id CF04110086F; Fri, 14 Jun 2019 16:03:22 +0300 (+03)
Date:   Fri, 14 Jun 2019 16:03:22 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@amacapital.net>,
        David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH, RFC 09/62] x86/mm: Preserve KeyID on pte_modify() and
 pgprot_modify()
Message-ID: <20190614130322.zbpubyxcncysgyi3@box>
References: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
 <20190508144422.13171-10-kirill.shutemov@linux.intel.com>
 <20190614091513.GW3436@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614091513.GW3436@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 11:15:14AM +0200, Peter Zijlstra wrote:
> On Wed, May 08, 2019 at 05:43:29PM +0300, Kirill A. Shutemov wrote:
> > + * Cast PAGE_MASK to a signed type so that it is sign-extended if
> > + * virtual addresses are 32-bits but physical addresses are larger
> > + * (ie, 32-bit PAE).
> 
> On 32bit, 'long' is still 32bit, did you want to cast to 'long long'
> instead? Ideally we'd use pteval_t here, but I see that is unsigned.

It will be cased implecitly to unsigned long long by '& ((1ULL <<
__PHYSICAL_MASK_SHIFT) - 1)' and due to sign-extension it will get it
right for PAE.

Just to be on safe side, I've re-checked that nothing changed for PAE by
the patch using the test below. PTE_PFN_MASK and PTE_PFN_MASK_MAX are
identical when compiled with -m32.

> >   */
> > -#define _PAGE_CHG_MASK	(PTE_PFN_MASK | _PAGE_PCD | _PAGE_PWT |		\
> > +#define PTE_PFN_MASK_MAX \
> > +	(((signed long)PAGE_MASK) & ((1ULL << __PHYSICAL_MASK_SHIFT) - 1))
> > +#define _PAGE_CHG_MASK	(PTE_PFN_MASK_MAX | _PAGE_PCD | _PAGE_PWT |		\
> >  			 _PAGE_SPECIAL | _PAGE_ACCESSED | _PAGE_DIRTY |	\
> >  			 _PAGE_SOFT_DIRTY | _PAGE_DEVMAP)
> >  #define _HPAGE_CHG_MASK (_PAGE_CHG_MASK | _PAGE_PSE)
> 

#include <stdio.h>

typedef unsigned long long u64;
typedef u64 pteval_t;
typedef u64 phys_addr_t;

#define PAGE_SHIFT		12
#define PAGE_SIZE		(1UL << PAGE_SHIFT)
#define PAGE_MASK		(~(PAGE_SIZE-1))
#define __PHYSICAL_MASK_SHIFT	52
#define __PHYSICAL_MASK		((phys_addr_t)((1ULL << __PHYSICAL_MASK_SHIFT) - 1))
#define PHYSICAL_PAGE_MASK	(((signed long)PAGE_MASK) & __PHYSICAL_MASK)
#define PTE_PFN_MASK		((pteval_t)PHYSICAL_PAGE_MASK)
#define PTE_PFN_MASK_MAX	(((signed long)PAGE_MASK) & ((1ULL << __PHYSICAL_MASK_SHIFT) - 1))

int main(void)
{
	printf("PTE_PFN_MASK: %#llx\n", PTE_PFN_MASK);
	printf("PTE_PFN_MASK_MAX: %#llx\n", PTE_PFN_MASK_MAX);

	return 0;
}
-- 
 Kirill A. Shutemov
