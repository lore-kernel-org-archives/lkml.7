Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFE8C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 20:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F0F824135
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 20:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bwKrSUcA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfE2UQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 16:16:14 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45113 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfE2UQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 16:16:12 -0400
Received: by mail-pf1-f193.google.com with SMTP id s11so2329709pfm.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 13:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=byH71jcEnWiZocWjFrPDlTMOE7pd8EPRHoYGyukaY04=;
        b=bwKrSUcAFY5li8JHROxevBRkVdZvfftmbN2jvX4D8l/n4Q/b0ePv+zprqpG2KluSLn
         rSYJBFUhtygfnfgM4xMNPYR/Vp/NGpVKFovwEIHmtk8emThGP6iRNZH+rg7exn2dW3QV
         qTeu7YoFimL+W4CSITeRLNxas0G8YpYTWwbHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=byH71jcEnWiZocWjFrPDlTMOE7pd8EPRHoYGyukaY04=;
        b=hmO1eGF+GBZ4A2YQ9h9mztb59dnFtwA+3+S9mSPp/Ky1Ud1Oqyg7iwxWc7ijt22TCW
         KhhdJS+ksjRCGUc3dnaZIJWwaAGSr9j/GNnlNiwbI51IKoP6p2BFSsB7pze05FARIv+q
         e0dJEBHm//hDfKAPe+6fmKn0s05+noIBXdOGD4Nzra8qatw+gRFgda44IfOoPc6OxVTO
         xsSu5uGxWBTPytbWqpo2lUvEJEJSQ4URyOoUI8NEYGwWJnRbiW5Gt41YblNRqC2NzOIH
         cbF5HsdYIAE51RTE4Q7ItONlwTfioxB0B6jX1k72WpZeBMxdqcFUkTwP3cPVHmtP0Q7O
         GvWA==
X-Gm-Message-State: APjAAAW8O++xu9TAxBsx1yXqbVLqHUAUFHeeXUGOax4RhUqp2S7BRJ7t
        M/K5rnY77VRqq8AqXl2VniDplw==
X-Google-Smtp-Source: APXvYqwOtLbXvQF12v2iQzcTzlTPHXYwr/VbPiH/+9zX0lzSfnaAmA5ZoEnSGfNESsFHQ7AnnjhQoA==
X-Received: by 2002:a63:f44b:: with SMTP id p11mr139393871pgk.225.1559160971649;
        Wed, 29 May 2019 13:16:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u6sm227693pgm.22.2019.05.29.13.16.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 13:16:10 -0700 (PDT)
Date:   Wed, 29 May 2019 13:16:09 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 00/14] Provide generic top-down mmap layout functions
Message-ID: <201905291313.1E6BD2DFB@keescook>
References: <20190526134746.9315-1-alex@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190526134746.9315-1-alex@ghiti.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 26, 2019 at 09:47:32AM -0400, Alexandre Ghiti wrote:
> This series introduces generic functions to make top-down mmap layout
> easily accessible to architectures, in particular riscv which was
> the initial goal of this series.
> The generic implementation was taken from arm64 and used successively
> by arm, mips and finally riscv.

As I've mentioned before, I think this is really great. Making this
common has long been on my TODO list. Thank you for the work! (I've sent
separate review emails for individual patches where my ack wasn't
already present...)

>   - There is no common API to determine if a process is 32b, so I came up with
>     !IS_ENABLED(CONFIG_64BIT) || is_compat_task() in [PATCH v4 12/14].

Do we need a common helper for this idiom? (Note that I don't think it's
worth blocking the series for this.)

-Kees

-- 
Kees Cook
