Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498AAC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1747E21537
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="eFeAcZtg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbfFNNO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 09:14:57 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41378 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbfFNNO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 09:14:56 -0400
Received: by mail-ed1-f67.google.com with SMTP id p15so3437534eds.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 06:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lo8jzIeEl3qvMScl2nYeZEzcklK1JpdjNABkHh1fbHg=;
        b=eFeAcZtgO0/eRC+taEsG3o/626r+gJzLYZLu6JCyggVrs1QqMuSldztZimYV/jdkJJ
         KpqfmnAYmMswNNumhYoKPsqVbi6oXCsorOhOJsdBSnOChpopGRX1/ui0nf+Nlcf6FXPr
         gGpw+PJGJIdyx5tMB8ohHf7Qp8YL0Pn4pTIC3KYego9Ujsgpyiq4SkfHbxvn1Rplq1Pp
         IoST/0AGJDllFkhSDArOhMHcOdLQczefbj/Em08KjBQgqt7nPa6It4nRH8wS9yRppE3g
         SyL/Y8mhbNTD3QF8XNH0x1JlkrNyAot22I9vIuPdXcIIAhttxk+quH+74xWONAEiEFsY
         kixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lo8jzIeEl3qvMScl2nYeZEzcklK1JpdjNABkHh1fbHg=;
        b=asYUK+eMAZJo7SRD2+aeLAg6CCRuvrYu6NZr08fVvCTqXM1aD+a5wpSrQggXjfTq4/
         O333emWncafII73K5SVzD26aanybhYsMA/6FLkbQJHD2LwQJBp7KVPOtK+WCwkmE81vn
         gkioFlbHHMqoOJ8kthggrkr9BSS3h6O8NjaKw2XGtZL974jmOVYSc/T4R/Ko1OLQL7qD
         35l8UQVjjqBHuLPXHmwD/lCWnTW6NfdmPjwee2tZQBN1hkiONdEIy1KfSrgIpwtKktKf
         Kvt3hcQUR5ZICmVvxJfF/DZEly4PCI6oKhKxij5mlA6rNUMCD9aw1G7h329QSeX7CJmt
         KV0A==
X-Gm-Message-State: APjAAAUxC1BrsvRFLFaCHdDpBhjDins6rHhszPBODuQ4LXe8HghXqb/w
        9IQfIImpicuForDMDXfbXbNSLg==
X-Google-Smtp-Source: APXvYqys9UpU3EDiYN8BSuwDi62d18/VihRzxeEm4B3CXY1/sZgOqGoIC2XqSZyXoR/BuWpsRnWF+g==
X-Received: by 2002:aa7:c619:: with SMTP id h25mr39051647edq.295.1560518094495;
        Fri, 14 Jun 2019 06:14:54 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id t3sm593997ejk.56.2019.06.14.06.14.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 06:14:53 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id BB20210086F; Fri, 14 Jun 2019 16:14:53 +0300 (+03)
Date:   Fri, 14 Jun 2019 16:14:53 +0300
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
Subject: Re: [PATCH, RFC 13/62] x86/mm: Add hooks to allocate and free
 encrypted pages
Message-ID: <20190614131453.ludfm4ufzqwa326k@box>
References: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
 <20190508144422.13171-14-kirill.shutemov@linux.intel.com>
 <20190614093409.GX3436@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614093409.GX3436@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 11:34:09AM +0200, Peter Zijlstra wrote:
> On Wed, May 08, 2019 at 05:43:33PM +0300, Kirill A. Shutemov wrote:
> 
> > +/* Prepare page to be used for encryption. Called from page allocator. */
> > +void __prep_encrypted_page(struct page *page, int order, int keyid, bool zero)
> > +{
> > +	int i;
> > +
> > +	/*
> > +	 * The hardware/CPU does not enforce coherency between mappings
> > +	 * of the same physical page with different KeyIDs or
> > +	 * encryption keys. We are responsible for cache management.
> > +	 */
> 
> On alloc we should flush the unencrypted (key=0) range, while on free
> (below) we should flush the encrypted (key!=0) range.
> 
> But I seem to have missed where page_address() does the right thing
> here.

As you've seen by now, it will be addressed later in the patchset. I'll
update the changelog to indicate that page_address() handles KeyIDs
correctly.

> > +	clflush_cache_range(page_address(page), PAGE_SIZE * (1UL << order));
> > +
> > +	for (i = 0; i < (1 << order); i++) {
> > +		/* All pages coming out of the allocator should have KeyID 0 */
> > +		WARN_ON_ONCE(lookup_page_ext(page)->keyid);
> > +		lookup_page_ext(page)->keyid = keyid;
> > +
> 
> So presumably page_address() is affected by this keyid, and the below
> clear_highpage() then accesses the 'right' location?

Yes. clear_highpage() -> kmap_atomic() -> page_address().

> > +		/* Clear the page after the KeyID is set. */
> > +		if (zero)
> > +			clear_highpage(page);
> > +
> > +		page++;
> > +	}
> > +}
> > +
> > +/*
> > + * Handles freeing of encrypted page.
> > + * Called from page allocator on freeing encrypted page.
> > + */
> > +void free_encrypted_page(struct page *page, int order)
> > +{
> > +	int i;
> > +
> > +	/*
> > +	 * The hardware/CPU does not enforce coherency between mappings
> > +	 * of the same physical page with different KeyIDs or
> > +	 * encryption keys. We are responsible for cache management.
> > +	 */
> 
> I still don't like that comment much; yes the hardware doesn't do it,
> and yes we have to do it, but it doesn't explain the actual scheme
> employed to do so.

Fair enough. I'll do better.

> > +	clflush_cache_range(page_address(page), PAGE_SIZE * (1UL << order));
> > +
> > +	for (i = 0; i < (1 << order); i++) {
> > +		/* Check if the page has reasonable KeyID */
> > +		WARN_ON_ONCE(lookup_page_ext(page)->keyid > mktme_nr_keyids);
> 
> It should also check keyid > 0, so maybe:
> 
> 	(unsigned)(keyid - 1) > keyids-1
> 
> instead?

Makes sense.

-- 
 Kirill A. Shutemov
