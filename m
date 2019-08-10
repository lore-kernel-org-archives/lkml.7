Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D1BC32751
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 22:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB83220880
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 22:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvWQEndw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfHJWmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 18:42:11 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37517 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfHJWmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 18:42:11 -0400
Received: by mail-wm1-f66.google.com with SMTP id z23so8681834wmf.2
        for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2019 15:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cm1cTZewDuKp3Wajgal/0P1FJ6bCpkxWTfUFt1xUXhs=;
        b=YvWQEndwda7eSVIrlsE7vqo9ByIKxm6UYmqRi8I6RnykBCbr3BX/erhjlLVL437ysc
         bZI+xCNBolX0mpmlerAo9hfUJd+CGXWpiQNyotqg+vdtSKEQNw4ZdeO/MQhoSnQu34dX
         Xtqyt5o1Q5oTLzAAWI5dTWtabBnlYzvp9XqIkhM0oFQSxW/ZdHn0JDgV/1gfzHnsIpJk
         x6sUxbseWS8WCy0t3/hSWmo0rNOZ4Dqzi6OcKr18WqAmn6DkoJVFNOoLA3HpofzpsDqM
         I9Ycm9fULS+O47gp4IoaHHb/cNLDEu1axhHss08puN8s+vqEjebs6bN0i/41r+Gc6Ten
         lmYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cm1cTZewDuKp3Wajgal/0P1FJ6bCpkxWTfUFt1xUXhs=;
        b=IwYiyS3AHNy+nImH+kk8bUT5Ng14pdm/+w19tlb9r2dSA6z0m25Au+5CZJtwh8/+Oi
         nQR9U7jeYm9GGaew+/JPNW7CadjzpMoIsXuSwwEzsUrcbZhaofxOL4dD9YyIW7jOJ9aJ
         4yXOsft5gwwAdHCyWfTHqvrwt07OFb8mblXqVOAlP3eU7s/6WCpOiYHsepmUszgWvWDt
         AV+i88xGQ9xOvDP1a1kHNsWrz35L6DjRAQ90O58uvGPRBLX/mtTcaqnw6aNtalz+ex5G
         6Qp1XWybSGNt3fEswDH8R1ighBvYrMxOzuMaFLe9iTy/tt8/QKvxQSmQxy8gqGxeMC6i
         fE+A==
X-Gm-Message-State: APjAAAUQ7BAx5DSYxZ6skMz/nIwnFXsxGR7v3HfyU65b3tRmZby3Q2Dc
        +BnZbRQMka+yY5PoYrNdEXE=
X-Google-Smtp-Source: APXvYqx7voVYy8obPH7IH9gpjf7uSzdRqQGq8zrNbfLP6L4bgveW5KnK1WH7isM1C8v5r5fgx+uBOA==
X-Received: by 2002:a1c:f511:: with SMTP id t17mr18874737wmh.53.1565476928602;
        Sat, 10 Aug 2019 15:42:08 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id k13sm18578918wro.97.2019.08.10.15.42.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 10 Aug 2019 15:42:07 -0700 (PDT)
Date:   Sat, 10 Aug 2019 15:42:06 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, clang-built-linux@googlegroups.com
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.3-4 tag
Message-ID: <20190810224206.GA56490@archlinux-threadripper>
References: <87imr5s522.fsf@concordia.ellerman.id.au>
 <CAHk-=whnEp5+EM53MaT-3ep1xjhrUqCdcfBfTF9YxByGsmDMRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whnEp5+EM53MaT-3ep1xjhrUqCdcfBfTF9YxByGsmDMRw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 10, 2019 at 10:21:01AM -0700, Linus Torvalds wrote:
> On Sat, Aug 10, 2019 at 3:11 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
> >
> > Just one fix, a revert of a commit that was meant to be a minor improvement to
> > some inline asm, but ended up having no real benefit with GCC and broke booting
> > 32-bit machines when using Clang.
> 
> Pulled, but whenever there are possible subtle compiler issues I get
> nervous, and wonder if the problem was reported to the clang guys?
> 
> In particular, if the kernel change was technically correct, maybe
> somebody else comes along in a few years and tries the same, and then
> it's another odd "why doesn't this work for person X when it works
> just fine for me"..
> 
>                  Linus

It was.

https://github.com/ClangBuiltLinux/linux/issues/593

https://bugs.llvm.org/show_bug.cgi?id=42762

We're still waiting for input from the PowerPC backend maintainers as
that is most likely where this issue originates from.

Cheers,
Nathan
