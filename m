Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DBAC48BD6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 19:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1619620883
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 19:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="yvActXPp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbfFYTa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 15:30:56 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34186 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfFYTa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 15:30:56 -0400
Received: by mail-ed1-f67.google.com with SMTP id s49so28871604edb.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 12:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8hFBKYM+mhnSbYOdJPqi+cF6rA4KH13Vh7o34AxMKhE=;
        b=yvActXPpQAoyQKEPRQXuVUCTP75rnNZAveMhCnpAXScUu66tiz+DSyJ9qNbBVcimZH
         0pfaF6B6lICAzFnmRl/k9hXLBSFe/gxf4fh6z1dzVlrmNoq4/ZumrCvGLJSaHNyg3Ans
         V6NQpbCsBII8GSJFdi4s99NUcTonV/p4+kcQeWAp6+DdNgXrWXF8Xb1oKrUscxgdV5oN
         9LQpeiBam0gjYioicWnO4UUfxJZoigvTF4VTFIed2RRQh88JIhCQiDa/1LacUu/3LOkl
         yGx6Vd6fCyAsRoOtTTkaixLGLKuQSWEJbZF11D+kPmzYdrTPcg+E8OZhnXMyGTpTkBgK
         laHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8hFBKYM+mhnSbYOdJPqi+cF6rA4KH13Vh7o34AxMKhE=;
        b=hyl47graSzEXlpWwcIH72d1rBZTX/5Or4yuQU2IrlqdHs+h/zQvTU47nDFI+2ehEcI
         DqnGK7jZlIuHZy7wAS2Gb75XHXL6qFWsfMAwSplQs1mrhiApjBDqprgL4iUOi7Ruy8lr
         vQBwQWff3U09t8Op+VkPkIInUMtJ4Rfj95nh50wDefk+GPoPNODJzsz1EbxqT6jhnuYC
         +p4/za1fcCPAVU/OjNoMufZObKGWr1jPsRt3wO6NdMp1LDRel9s43toOprH7HZ5bGjME
         JTM1tRRL3ShzOVrn1kFcHpASN6H+T1jDXkOIDdF0+r4w2zhG9YFhwoJBxRfNEGB9O5JV
         q1ag==
X-Gm-Message-State: APjAAAXeEnJMuv0veRXlM43BbdJcZypgnsZnM5J3yQxOvupgvnV7k3KO
        Apnw+aIsWSYysTu4YKq9DorZpA==
X-Google-Smtp-Source: APXvYqzJYEP63mmmIVDYbtNLICyilUALTc4c09u1x+oOjaJeMui2oQ1CyK0f5l73QuE7q8AaAxX4Kw==
X-Received: by 2002:a17:906:d797:: with SMTP id pj23mr209193ejb.223.1561491054480;
        Tue, 25 Jun 2019 12:30:54 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id z22sm5042550edz.6.2019.06.25.12.30.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 12:30:53 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id E4F5A1043B9; Tue, 25 Jun 2019 22:30:53 +0300 (+03)
Date:   Tue, 25 Jun 2019 22:30:53 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH] x86/boot/64: Fix crash if kernel images crosses page
 table boundary
Message-ID: <20190625193053.g5zngehu3ozgzkeg@box>
References: <20190620112345.28833-1-kirill.shutemov@linux.intel.com>
 <alpine.DEB.2.21.1906252100290.32342@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1906252100290.32342@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 09:04:39PM +0200, Thomas Gleixner wrote:
> On Thu, 20 Jun 2019, Kirill A. Shutemov wrote:
> > @@ -190,18 +190,18 @@ unsigned long __head __startup_64(unsigned long physaddr,
> >  		pgd[i + 0] = (pgdval_t)p4d + pgtable_flags;
> >  		pgd[i + 1] = (pgdval_t)p4d + pgtable_flags;
> >  
> > -		i = (physaddr >> P4D_SHIFT) % PTRS_PER_P4D;
> > -		p4d[i + 0] = (pgdval_t)pud + pgtable_flags;
> > -		p4d[i + 1] = (pgdval_t)pud + pgtable_flags;
> > +		i = physaddr >> P4D_SHIFT;
> > +		p4d[(i + 0) % PTRS_PER_P4D] = (pgdval_t)pud + pgtable_flags;
> > +		p4d[(i + 1) % PTRS_PER_P4D] = (pgdval_t)pud + pgtable_flags;
> >  	} else {
> >  		i = (physaddr >> PGDIR_SHIFT) % PTRS_PER_PGD;
> >  		pgd[i + 0] = (pgdval_t)pud + pgtable_flags;
> >  		pgd[i + 1] = (pgdval_t)pud + pgtable_flags;
> >  	}
> >  
> > -	i = (physaddr >> PUD_SHIFT) % PTRS_PER_PUD;
> > -	pud[i + 0] = (pudval_t)pmd + pgtable_flags;
> > -	pud[i + 1] = (pudval_t)pmd + pgtable_flags;
> > +	i = physaddr >> PUD_SHIFT;
> > +	pud[(i + 0) % PTRS_PER_PUD] = (pudval_t)pmd + pgtable_flags;
> > +	pud[(i + 1) % PTRS_PER_PUD] = (pudval_t)pmd + pgtable_flags;
> >  
> >  	pmd_entry = __PAGE_KERNEL_LARGE_EXEC & ~_PAGE_GLOBAL;
> >  	/* Filter out unsupported __PAGE_KERNEL_* bits: */
> > @@ -211,8 +211,8 @@ unsigned long __head __startup_64(unsigned long physaddr,
> >  	pmd_entry +=  physaddr;
> >  
> >  	for (i = 0; i < DIV_ROUND_UP(_end - _text, PMD_SIZE); i++) {
> > -		int idx = i + (physaddr >> PMD_SHIFT) % PTRS_PER_PMD;
> > -		pmd[idx] = pmd_entry + i * PMD_SIZE;
> > +		int idx = i + (physaddr >> PMD_SHIFT);;
> 
> double semicolon

Will fix.

> > +		pmd[idx % PTRS_PER_PMD] = pmd_entry + i * PMD_SIZE;
> 
> This part is functionally equivivalent. So what's the value of this change?

Precedence of operators were broken

	idx =  i + (physaddr >> PMD_SHIFT) % PTRS_PER_PMD;

reads by compiler as

	idx = i + ((physaddr >> PMD_SHIFT) % PTRS_PER_PMD);

not as

	idx =  (i + (physaddr >> PMD_SHIFT)) % PTRS_PER_PMD;

Therefore 'idx' can become >= PTRS_PER_PMD.

-- 
 Kirill A. Shutemov
