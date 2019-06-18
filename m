Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C364C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 16:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29F7F2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 16:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="sp219faf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729830AbfFRQPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 12:15:06 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34290 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729249AbfFRQPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 12:15:06 -0400
Received: by mail-ed1-f67.google.com with SMTP id s49so22600842edb.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 09:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TV0b7JjOzi3iVkcg5Sm68/8xpqk1N7OtdOwvdmMSM/4=;
        b=sp219fafTDU9AF/f/dDdjrZCyZ0ajovfZ5IsEGibzM7oT+JPXHoqtpUp9y+/FKsAwK
         cLIQ+SaiFpOVgcfnmqkW9kh5ZPD933ncGaqvOqcRXz/pzYG3CBjS75hfB8b9mHWeavRe
         9YN1tKGr4uMlODuJh8c/skxvKjR4ZWdBSfgEzgsswaLzfDNG+8bqhpgeVcbY2wroQOgm
         m8yqhLkLzqsfAkLZhQk83MDmYYETbswPrTbUk+blwkZ74EGdHU7kVpaDKfhD/bL/qi0Z
         PjZ6O9mRV5k2iiT8GT6xBwuzKmNmxmOfoNm4dcg+n+TIGqaR7jY0hQPi6Dux1UfSzHJt
         f5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TV0b7JjOzi3iVkcg5Sm68/8xpqk1N7OtdOwvdmMSM/4=;
        b=Ub1p/et0DKcDc5mDoHI2ux7rWZ6LOLN/f4AtKIz1LskkyuTlQ4jhCnY6fz+6Lzj8CG
         eW2wg/LYLlLFcIttsLdL9D4KMjKfxxR8YIbmeDIctroH1YyVg/xPButd68NpoB6apYT7
         xBhCzfbXFKqrxL0uvCp5GxBD9Cz7YG0HnoURFe0q806u6pVlhbDBF1e8qciQ2lI3/xTO
         Ze7bNf/x+0Q2lwosJ5he8jI7AcMA/ajyIZzhunFjLBnDONhw1oy38mu3mBRUCUO8jBhd
         bl1C0//tSI8oquxpMCpPU6KeLyJAu1W3a2/ioMZ0y6bP3glYszJV3zaKCTl+EACppFCG
         bj9Q==
X-Gm-Message-State: APjAAAUtku4PhIKg/5s+GPsFdwJds/r6/dR7FFaYBjf4FBwYOyUpW0AK
        w0FZBPLdH/BNgB6Vd68puEgl9w==
X-Google-Smtp-Source: APXvYqxkJFdEknnrEDQYFG7Dsrv3QgF4P1fh93uo1KXJbSzbgkocrY1GYGzkIA2M5LkSkPJAL6JZ8Q==
X-Received: by 2002:a17:906:2890:: with SMTP id o16mr76685704ejd.80.1560874504188;
        Tue, 18 Jun 2019 09:15:04 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id a6sm4612918eds.19.2019.06.18.09.15.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 09:15:03 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id E6FF61036B4; Tue, 18 Jun 2019 19:15:02 +0300 (+03)
Date:   Tue, 18 Jun 2019 19:15:02 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Kai Huang <kai.huang@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        X86 ML <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Linux-MM <linux-mm@kvack.org>, kvm list <kvm@vger.kernel.org>,
        keyrings@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH, RFC 45/62] mm: Add the encrypt_mprotect() system call
 for MKTME
Message-ID: <20190618161502.jiuqhvs3wvnac5ow@box.shutemov.name>
References: <CALCETrUPSv4Xae3iO+2i_HecJLfx4mqFfmtfp+cwBdab8JUZrg@mail.gmail.com>
 <5cbfa2da-ba2e-ed91-d0e8-add67753fc12@intel.com>
 <CALCETrWFXSndmPH0OH4DVVrAyPEeKUUfNwo_9CxO-3xy9awq0g@mail.gmail.com>
 <1560816342.5187.63.camel@linux.intel.com>
 <CALCETrVcrPYUUVdgnPZojhJLgEhKv5gNqnT6u2nFVBAZprcs5g@mail.gmail.com>
 <1560821746.5187.82.camel@linux.intel.com>
 <CALCETrUrFTFGhRMuNLxD9G9=GsR6U-THWn4AtminR_HU-nBj+Q@mail.gmail.com>
 <1560824611.5187.100.camel@linux.intel.com>
 <20190618091246.GM3436@hirez.programming.kicks-ass.net>
 <2ec26c05-7c57-d0e0-a628-94d581b96b63@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ec26c05-7c57-d0e0-a628-94d581b96b63@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 07:09:36AM -0700, Dave Hansen wrote:
> On 6/18/19 2:12 AM, Peter Zijlstra wrote:
> > On Tue, Jun 18, 2019 at 02:23:31PM +1200, Kai Huang wrote:
> >> Assuming I am understanding the context correctly, yes from this perspective it seems having
> >> sys_encrypt is annoying, and having ENCRYPT_ME should be better. But Dave said "nobody is going to
> >> do what you suggest in the ptr1/ptr2 example"? 
> > 
> > You have to phrase that as: 'nobody who knows what he's doing is going
> > to do that', which leaves lots of people and fuzzers.
> > 
> > Murphy states that if it is possible, someone _will_ do it. And this
> > being something that causes severe data corruption on persistent
> > storage,...
> 
> I actually think it's not a big deal at all to avoid the corruption that
> would occur if it were allowed.  But, if you're even asking to map the
> same data with two different keys, you're *asking* for data corruption.
>  What we're doing here is continuing to  preserve cache coherency and
> ensuring an early failure.
> 
> We'd need two rules:
> 1. A page must not be faulted into a VMA if the page's page_keyid()
>    is not consistent with the VMA's
> 2. Upon changing the VMA's KeyID, all underlying PTEs must either be
>    checked or zapped.
> 
> If the rules are broken, we SIGBUS.  Andy's suggestion has the same
> basic requirements.  But, with his scheme, the error can be to the
> ioctl() instead of in the form of a SIGBUS.  I guess that makes the
> fuzzers' lives a bit easier.

I see a problem with the scheme: if we don't have a way to decide if the
key is right for the file, user without access to the right key is able to
prevent legitimate user from accessing the file. Attacker just need read
access to the encrypted file to prevent any legitimate use to access it.

The problem applies to ioctl() too.

To make sense of it we must have a way to distinguish right key from
wrong. I don't see obvious solution with the current hardware design.

-- 
 Kirill A. Shutemov
