Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59409C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B7E420856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBKWtCG3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730737AbfDBLqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 07:46:03 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36545 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729568AbfDBLqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 07:46:02 -0400
Received: by mail-pf1-f195.google.com with SMTP id z5so5236971pfn.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 04:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1VTcSLXYSsBEOyWJ8Ysyz+JgBnGd4PIPikuc8Mzq9qM=;
        b=gBKWtCG3zYJt8kRqPcVOsNL7iPchQvCJA87/Z//A5FwPxwzs75RmwujTpoT3c5n+kL
         WCT+2atpxa+iR3EGXwNxmw/vBCD3Xdk6nXSS2BJQX0rvmd/UsXi3gdQL9WNeTpq8W6fL
         bW0iDKS9CXBTjxrHRizcI56Qwyzm/8yrgBB4y4P7DdDQa7evwcF3rN8fldY3oE5ZLdbA
         hRSkPhqGItQYscGe/FI0EzwZ6Zi7WX/iMtRJ5iECFGUIS97fNtqI4XCJYnH5LWudULxF
         8iJRRz8GkZ4r6QCjdK7QEw67q8l+qtCfRg7XRmHcXpq0zNTUklsac3XPz93MNIAmxK5K
         ReJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1VTcSLXYSsBEOyWJ8Ysyz+JgBnGd4PIPikuc8Mzq9qM=;
        b=gJLGnXb7rmxLWJ8ZYsVaz9GFAZmRX0rMbHpr8C3R7oTMRBgRLpUQ1VavKDzw4154Z+
         c8GRLoIvdd685jM4njStztHZQKAqRQNGAcZhFmeEIrBDYEPfkT2UNaRz1rsmRh52m9Yd
         js5yEa9KjswmBVIeBz9RNnuTWjb+B34Tf3/j7TzR7dTJVdVP4PkClMnj+S0eBjrQQrLA
         E5wye6+cORHFnltD2+HmFEnbqN6ZU2x+JgDeG3nvVZBSgKmkdj6hcPjOte3VNjA1TP/B
         cMYiILUpeb9QxbcpRNX/6Rssd8yZIwO2yYIkv9A3FXgcZ5yI1ctiRdrXMU8VTwc5KFoo
         liWQ==
X-Gm-Message-State: APjAAAUIf6JMxTl1+J/DbB+/Mm+RfNMFqJN8f8kT75OIUKHsNCcUcZg2
        a1b/Qe+TLDrKf/80XiHxxG+5JZ4v
X-Google-Smtp-Source: APXvYqyf8QzwcBCzdFb4farzCeOP4tnS45qv1XN1tFAjymAqd4fHF2h49Pgp9b4FMiatZ88R/ZJTjg==
X-Received: by 2002:a65:4844:: with SMTP id i4mr64687606pgs.347.1554205561707;
        Tue, 02 Apr 2019 04:46:01 -0700 (PDT)
Received: from localhost ([2601:648:8303:5c60:99d9:8017:7699:cf76])
        by smtp.gmail.com with ESMTPSA id s5sm16953889pfm.184.2019.04.02.04.46.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 04:46:01 -0700 (PDT)
Date:   Tue, 2 Apr 2019 14:45:59 +0300
From:   Yury Norov <yury.norov@gmail.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, Yury Norov <ynorov@marvell.com>
Subject: Re: PATCH 2/2] lib/bitmap.c: guard exotic bitmap functions by
 CONFIG_NUMA
Message-ID: <20190402114559.GA17500@yury-thinkpad>
References: <20190330185436.GA19813@yury-thinkpad>
 <9ad8cb18-ba77-c659-4f44-4ab4f810f9f1@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ad8cb18-ba77-c659-4f44-4ab4f810f9f1@rasmusvillemoes.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 10:10:33PM +0200, Rasmus Villemoes wrote:
> On 30/03/2019 19.54, Yury Norov wrote:
> > Hi Rasmus!
> > 
> >> From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> >> Sent: Saturday, March 30, 2019 12:53:51 AM
> >> To: Rasmus Villemoes; Andrew Morton; Andy Shevchenko
> >> Cc: Yury Norov; linux-kernel@vger.kernel.org
> >> Subject: [PATCH 2/2] lib/bitmap.c: guard exotic bitmap functions by CONFIG_NUMA
> >>
> >> The bitmap_remap, _bitremap, _onto and _fold functions are only used,
> >> via their node_ wrappers, in mm/mempolicy.c, which is only built for
> >> CONFIG_NUMA. The helper bitmap_ord_to_pos used by these functions is
> >> global, but its only external caller is node_random() in lib/nodemask.c,
> >> which is also guarded by CONFIG_NUMA.
> > 
> > Nice catch. I think you should protect declaration of those functions
> > in include/linux/bitmap.h as well.
> 
> Yeah, well, it's not that simple, because one would also need to wrap
> the static inline __nodes_onto etc. in ifdefs. Normally, there'd be an
> #else branch defining simple static inline replacements that always fail
> or return 0, but we can't do that here.

There are enough examples of conditionally defined functions without
stubs, I don't see any problem with it. Anyways, if you don't like
doing that, moving the code and declarations to new files would help.

> So I'd prefer a simple linker
> error should any user outside NUMA ever appear. Which I very highly doubt.

Linker errors are usually less specific and much longer to obtain
at the linker-stage, which is not good.

> > I'm concerned about pollution of such a generic portion of code with
> > subsystem-related #ifdefs. Would it make more sense to move numa-specific
> > stuff to lib/bitmap_numa.c and include/linux/bitmap_numa.h (or *_nodemask.h,
> > or whatever)?
> 
> Well, yes, that might be better, but a lot bigger patch. One could also
> argue that bitmap.c is _already_ polluted with subsystem specific code
> (though not in the form of preprocessor directives).

I probably don't understand the argument. If we find bitmap.c polluted, we
should try clean it, right?
