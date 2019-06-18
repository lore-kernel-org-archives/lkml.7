Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA021C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC3AC2080C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q3hIMOin"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbfFRHXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 03:23:15 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38091 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfFRHXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 03:23:14 -0400
Received: by mail-pf1-f194.google.com with SMTP id a186so7119093pfa.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 00:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dEsKaJXoDJkA5TF5UYVq8fg5KxBVITSyK3x9GUtiEtI=;
        b=Q3hIMOin+2zsiD8vYGq/3X6J1SuuZzyIZPPwpUEiQeLrbWpi/e1dq/7SIryYs4OKgc
         z3rBAFLdOtYt5Z6olZwKQ9lf4/HPu177OQzeogJM6fwI+hQdSKKC1Lc2JnWSoyRQ5HQj
         0ZhHg35UUTzkR/GiUtfC7uR78c1KItYhO5Bb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dEsKaJXoDJkA5TF5UYVq8fg5KxBVITSyK3x9GUtiEtI=;
        b=FAVvBfK87iABI7oBccWaIGuK4+SDWyxTISIfyIJphRG+BTl2wqqdbkXdSbKBUTD2Bj
         GN3YJPDir0rDw0XyoLl/ISmUsjy0rpzYXDYRdEL0l7qrz9HUJ6Ym2ISDHngTq4wrlLYC
         WECNwT8Shal9lxQsyp7Yvb3sYwNzYQphivtWi2JZBLj8MxYEDJ2bjaR4HVmXlXnebELv
         peRxqSHkkDu8ad1GUO5IilIZNJk1BjNTZpIJtewAyAszDfxXeh8wJQ2aMG2rmf9JrwoD
         GhryG9Ikag+vya/229rGS8j7VTR8nbsRbaL36Xv1dpZnL/068EpySwwI1hrEQKCFejwE
         j0IA==
X-Gm-Message-State: APjAAAWlGU05Ds8LlCTuQWjJqxeyq68kImxVWezU1ZFbltpxRzbPQdLG
        4yhksrP1RoLYV4Kn4FsXnW1R7Q==
X-Google-Smtp-Source: APXvYqzD7fAz73M0c0VOd4C2AvHukf6CXWL7neDgSk4Ft1Gef+dHJA31Bnp0vePUR0O2PI6rnZm4qA==
X-Received: by 2002:a63:5c15:: with SMTP id q21mr1379707pgb.248.1560842594126;
        Tue, 18 Jun 2019 00:23:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u23sm12579075pfh.84.2019.06.18.00.23.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jun 2019 00:23:13 -0700 (PDT)
Date:   Tue, 18 Jun 2019 00:23:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v3 1/3] lkdtm: Check for SMEP clearing protections
Message-ID: <201906180019.EEA60F3@keescook>
References: <20190618045503.39105-1-keescook@chromium.org>
 <20190618045503.39105-2-keescook@chromium.org>
 <580611da-fd97-e82e-b604-581f105416ee@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <580611da-fd97-e82e-b604-581f105416ee@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 09:10:13AM +0200, Rasmus Villemoes wrote:
> On 18/06/2019 06.55, Kees Cook wrote:
> 
> > +#else
> > +	pr_err("FAIL: this test is x86_64-only\n");
> > +#endif
> > +}
> 
> Why expose it at all on all other architectures? If you wrap the
> CRASHTYPE() in an #ifdef, you can also guard the whole lkdtm_UNSET_SMEP
> definition (the declaration in lkdtm.h can stay, possibly with a comment
> saying /* x86-64 only */).

My preference for LKDTM is for all the tests to be visible regardless
of architecture so that the testing "environment" doesn't have to change
depending on architecture. I've found it easier to deal with when I ran
test harnesses on Chrome OS where I had cross-architectural scripts.
Doing a side-by-side with a PASS and an XFAIL was more sensible to
compare than a PASS and a missing test.

-- 
Kees Cook
