Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4237AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 23:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 130F22084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 23:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfDAXzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 19:55:40 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43073 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfDAXzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 19:55:40 -0400
Received: by mail-pl1-f196.google.com with SMTP id m10so5269317plt.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 16:55:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=53C+UAYBW94xvPX0bSE+X4pak3bywZ/H7OEveLLLrVc=;
        b=nQbgstZCU+rjmjMdiU5T4393+SoGi1lKKeWERVBM0Vw0IlkdzW8wZBlCSLPC7UwLTC
         ud8oTTfIY6gzv9h0pGu3tRjuEyFi0u44m1rSd6pKAlT75K1Cntb96oN6qRQ+iQY+pKAD
         Amhc4WCFiZ3ozXXVnaSEy5dnJ2rC7NDezf3i81DR7EXgahBYPYzhcujpMVV4OMY46mn1
         99wlS6EbACQYr3198KmMkfTAgTpX10FCaMuV1Ivr0OSgWILrqpppxepnFCoOhtcGhFoN
         sy25/hR1O1CMligTybnx6EYkHQENtj8eQ6cu8fCwkJ/0FZHeH4w4dRPJ/sKQkf3ZNKeS
         MPWg==
X-Gm-Message-State: APjAAAUN+S2qw1ODVsZoJe/le/CG8ODSyQIfdAIOfA2BA04XdGNFLhNg
        ly5votsOR/wuZh6FlkBDPGAfezd6
X-Google-Smtp-Source: APXvYqy2SfyFgVJ0tBcIA5d/AG0rEf8qMGEdVpI4YGPy77yvJPh7am3H3T7wMrFSFcW7I0ykhNSZlA==
X-Received: by 2002:a17:902:2e83:: with SMTP id r3mr49558255plb.153.1554162939659;
        Mon, 01 Apr 2019 16:55:39 -0700 (PDT)
Received: from sultan-box.localdomain ([2601:200:c001:5f40:f27:f07b:c72c:45e3])
        by smtp.gmail.com with ESMTPSA id i79sm22625237pfj.28.2019.04.01.16.55.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 16:55:38 -0700 (PDT)
Date:   Mon, 1 Apr 2019 16:55:36 -0700
From:   Sultan Alsawaf <sultan@kerneltoast.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [RFCv2] string: Use faster alternatives when constant arguments
 are used
Message-ID: <20190401235536.GA874@sultan-box.localdomain>
References: <20190324014445.28688-1-sultan@kerneltoast.com>
 <20190324022406.GA18988@sultan-box.localdomain>
 <2293c54f-40b1-1e59-665a-bd8f2cb957d2@rasmusvillemoes.dk>
 <20190324223202.GA875@sultan-box.localdomain>
 <8672b98c-bf71-7b5b-625e-2f241807d46c@rasmusvillemoes.dk>
 <20190330225941.GA7456@sultan-box.localdomain>
 <ec88d9a2-272e-973e-55ce-f3d411aafcd1@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec88d9a2-272e-973e-55ce-f3d411aafcd1@rasmusvillemoes.dk>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 10:43:13PM +0200, Rasmus Villemoes wrote:
> Consider your patch replacing !strcmp(buf, "123") by !memcmp(buf, "123",
> 4). buf is known to point to a nul-terminated string. But it may point
> at, say, the second-last byte in a page, with the last byte in that page
> being a nul byte, and the following page being MMIO or unmapped or all
> kinds of bad things. On e.g. x86 where unaligned accesses are cheap, and
> seeing that you're only comparing for equality, gcc is likely to compile
> the memcmp version into
> 
>   *(u32*)buf == 0x00333231
> 
> because you've told the compiler that there's no problem accessing four
> bytes starting at buf. Boom. Even without unaligned access being cheap
> this can happen; suppose the length is 8 instead, and gcc somehow knows
> that buf is four-byte aligned (and in this case it happens to point four
> bytes before a page boundary), so it could compile the memcmp(,,8) into
> 
>   *(u32*)(buf+4) == secondword && *(u32*)buf == firstword
> 
> (or do the comparisons in the "natural" order, but it might still do
> both loads first).

Ok, this is the first solid counter I've seen against my patch. I hadn't
considered unaligned word-sized accesses. Thanks.

> > And if there are concerns for some arches but not others, then couldn't this be
> > a feasible optimization for those which would work well with it?
> 
> No. First, these are concerns for all arches. Second, if you can find
> some particular place where string parsing/matching is in any way
> performance relevant and not just done once during driver init or
> whatnot, maybe the maintainers of that file would take a patch
> hand-optimizing some strcmps to memcmps, or, depending on what the code
> does, perhaps replacing the whole *cmp logic with a custom hash table.

FWIW, I didn't have a specific place in the kernel in mind that heavily relied
on str* operations and needed optimization. I just thought it could be a "free"
optimization, but apparently not.

> But a patch implicitly and silently touching thousands of lines of code,
> without an analysis of why none of the above is a problem for any of
> those lines, for any .config, arch, compiler version? No.

Well, I thought it could be proven to be correct regardless of the context,
which would imply that making such a global change touching thousands lof lines
of code would be safe. But sadly it isn't.

This does bring into question a greater problem though: usage of memcmp
throughout the kernel where the size provided is not the size of the smaller
container being compared. This usage of memcmp (which is quite easy to find all
across the kernel) could run into the unaligned memory access across a page
boundary that you gave as an example, no?

Sultan
