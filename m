Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85AAC31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A78A02080C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aHxwffp9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbfFRHcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 03:32:41 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:36797 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfFRHck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 03:32:40 -0400
Received: by mail-pf1-f174.google.com with SMTP id r7so7144709pfl.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 00:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cNzM2YMgB5QeOFqcE5XWudMdVUdieIunz+pw2P2nkps=;
        b=aHxwffp9j1MuUtfKW9XicOHm7mPw/i8Dm7DrqoJfs0QQJhFSy9piSmKPw2fRGqaCuT
         FJygeuUaisRAmeI6dI6mA2O7CBRKaMX0cALjItDW567ZxjdyTPNmMb08qVvPSCUGgT7Z
         S57CNfTHcNt+WD885RoBDwLz13vcgo6D+DQOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cNzM2YMgB5QeOFqcE5XWudMdVUdieIunz+pw2P2nkps=;
        b=tQ+C5pVTuSpgtfkjCEbaBqeGQv2mRsFir0me/U5epQvlOWmZwX/EydyEli1N0b7GzP
         jxY2vLZ+WBt4Gf+LRJ4AaeVzEdeUZqzfuIx8tqRbWx5i8QV7457pO3nwOBbaT9XuzdY6
         rg+qp/heqBk2/WNpW4tI4awMFNrY+LHOzU5fIRrL0KurQftVBcLBmi/BC78hMPbD1rJm
         7KvpWRhmlFKwBvcT++SQYmbVsV6GX9xHO34V2yX2kNiZSVwMvQhdK5nodlQfgZ/0HsUY
         of7X7IYjz4BWFW0QOeVdBuYolRucLPsC9LlWOC+6XsAQcyJ1iTXVHKcBy0vpVxopx8Mg
         rZxQ==
X-Gm-Message-State: APjAAAWtiBASYGatxj7oaHyQYSVOIo/szYXsM9Wp9BbyAGkq8sRgctfG
        h7PS2wSJZx68o/vqxlE4jmXg3j9igCPrcA==
X-Google-Smtp-Source: APXvYqxn5zv7Vekhs0XYFSBVPMRKfnBoqvJIOiHchJjuRLxEyoQhCqoP/ayzffUK9jSqUj3vSTcjZg==
X-Received: by 2002:a62:6303:: with SMTP id x3mr101686139pfb.261.1560836502925;
        Mon, 17 Jun 2019 22:41:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u20sm12277118pgm.56.2019.06.17.22.41.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Jun 2019 22:41:42 -0700 (PDT)
Date:   Mon, 17 Jun 2019 22:41:41 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Jan Glauber <jglauber@marvell.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC] Disable lockref on arm64
Message-ID: <201906172233.F753B92@keescook>
References: <20190614095846.GC10506@fuggles.cambridge.arm.com>
 <CAKv+Gu_Kdq=UPijjA84FpmO=ZsdEO9EyyF7GeOQ+WmfqtO_hMg@mail.gmail.com>
 <20190614103850.GG10659@fuggles.cambridge.arm.com>
 <201906142026.1BC27EDB1E@keescook>
 <CAKv+Gu_XuhgUCYOeykrbaxJz-wL1HFrc_O+HeZHqaGkMHd2J9Q@mail.gmail.com>
 <201906150654.FF4400F7C8@keescook>
 <CAKv+Gu9-rZ16Nb9t3=knzW0BHu0eNxQoPwWS4c8UMMm=2iqiuw@mail.gmail.com>
 <201906161429.BCE1083@keescook>
 <CAKv+Gu_8ibO4D01DZv6KjL2GnvKuVBVnt=doxkN0w=4utJ7NvQ@mail.gmail.com>
 <20190617172620.GK30800@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617172620.GK30800@fuggles.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 06:26:20PM +0100, Will Deacon wrote:
> On Mon, Jun 17, 2019 at 01:33:19PM +0200, Ard Biesheuvel wrote:
> > On my single core TX2, the comparative performance is as follows
> > 
> > Baseline: REFCOUNT_TIMING test using REFCOUNT_FULL (LSE cmpxchg)
> >       191057942484      cycles                    #    2.207 GHz
> >       148447589402      instructions              #    0.78  insn per
> > cycle
> > 
> >       86.568269904 seconds time elapsed
> > 
> > Upper bound: ATOMIC_TIMING
> >       116252672661      cycles                    #    2.207 GHz
> >        28089216452      instructions              #    0.24  insn per
> > cycle
> > 
> >       52.689793525 seconds time elapsed
> > 
> > REFCOUNT_TIMING test using LSE atomics
> >       127060259162      cycles                    #    2.207 GHz
> 
> Ok, so assuming JC's complaint is valid, then these numbers are compelling.
> In particular, my understanding of this thread is that your optimised
> implementation doesn't actually sacrifice any precision; it just changes
> the saturation behaviour in a way that has no material impact. Kees, is that
> right?

That is my understanding, yes. There is no loss to detection precision.
But for clarity, I should point out it has one behavioral change that is
the same change as on x86: the counter is now effectively a 31 bit counter
not a 32 bit counter, as the signed bit is being used for saturation.

> If so, I'm not against having this for arm64, with the premise that we can
> hide the REFCOUNT_FULL option entirely given that it would only serve to
> confuse if exposed.

If the LSE atomics version has overflow, dec-to-zero, and inc-from-zero
protections, then as far as I'm concerned, REFCOUNT_FULL doesn't need
to exist for arm64. On the Kconfig front, as long as there isn't a way
to revert refcount_t to atomic_t, I'm happy. :)

-- 
Kees Cook
