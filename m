Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E143DC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 15:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD1452083E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 15:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kP5ojcPf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbfEQPx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 11:53:57 -0400
Received: from mail-pg1-f170.google.com ([209.85.215.170]:40819 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728664AbfEQPx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 11:53:57 -0400
Received: by mail-pg1-f170.google.com with SMTP id d30so3488684pgm.7
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 08:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DeWYh2wXHt0SGoJqX0T0F4RONBrBgIxGbZCJ2kdSH6I=;
        b=kP5ojcPfRjRGKbxsO4pF79WW/kSRZaLu97/2LsHLFWXmA56eKS99Mt+3JVChAIHpWm
         /edz0dqcheadE+lCi2SLduXDhlV/p2PinTyIt4lzceJGxetX1fUXdKy/JmwgB4UYvVNK
         Brmr62mRz4mVtq7sVy58XKgfbiMqAH/4IEa8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DeWYh2wXHt0SGoJqX0T0F4RONBrBgIxGbZCJ2kdSH6I=;
        b=WB+pc7SL0X0TTXqGQGkIw3k6t1JtUzg132sUV8fjVwKslVflauCShCehGyow6gULxW
         83xbVb8yXa7pkC1BY6GmN0NFBh7lECeluB7lRo0/3GXd65hMIWxinnSpVg824iQO+02s
         J2wmFzw64fz8zXBxjRA5LZhyKCtYV9Xjc2eZEFHaB+EHvoszY9bJgMro+vfWs7Fs3C3Z
         GTmtCZz7IIGD9/fEJxgwnAM6EvVMsB0FIbRzD3d9033APwtnR9/QnLnWuM6TwIOjcHhH
         5Vaowa4xPyJSbU3V7MBRyJ/gwL9/eGbED/PaH84Fal00ud4vApc5mGzoGx6umQ8pMwma
         J2jA==
X-Gm-Message-State: APjAAAWvlunypPjFCIgA6TJTQkITddKvpzoHqHGcibG7yJrF4evzzaR1
        TPtE88NCzXdxuOhsIqvZBNCUlA==
X-Google-Smtp-Source: APXvYqyvXdwCR61IEEY49hfPBp0/QulW7H4+PkBv7xWEeGfEdGz2OO8yjJsd70M5DeFCJZN6lhnfqQ==
X-Received: by 2002:a62:8893:: with SMTP id l141mr4899472pfd.261.1558108436771;
        Fri, 17 May 2019 08:53:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m12sm5169259pgi.56.2019.05.17.08.53.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 May 2019 08:53:55 -0700 (PDT)
Date:   Fri, 17 May 2019 08:53:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Jan Kara' <jack@suse.cz>, Dan Williams <dan.j.williams@intel.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Jeff Moyer <jmoyer@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Smits <jeff.smits@intel.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] libnvdimm/pmem: Bypass CONFIG_HARDENED_USERCOPY overhead
Message-ID: <201905170845.1B4E2A03@keescook>
References: <155805321833.867447.3864104616303535270.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190517084739.GB20550@quack2.suse.cz>
 <2d8b1ba7890940bf8a512d4eef0d99b3@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d8b1ba7890940bf8a512d4eef0d99b3@AcuMS.aculab.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 09:06:26AM +0000, David Laight wrote:
> From: Jan Kara
> > Sent: 17 May 2019 09:48
> ...
> > So this last paragraph is not obvious to me as check_copy_size() does a lot
> > of various checks in CONFIG_HARDENED_USERCOPY case. I agree that some of
> > those checks don't make sense for PMEM pages but I'd rather handle that by
> > refining check_copy_size() and check_object_size() functions to detect and
> > appropriately handle pmem pages rather that generally skip all the checks
> > in pmem_copy_from/to_iter(). And yes, every check in such hot path is going
> > to cost performance but that's what user asked for with
> > CONFIG_HARDENED_USERCOPY... Kees?
> 
> Except that all the distros enable it by default.
> So you get the performance cost whether you (as a user) want it or not.

Note that it can be disabled on the kernel command line, but that seems
like a last resort. :)

> 
> I've changed some of our code to use __get_user() to avoid
> these stupid overheads.

__get_user() skips even access_ok() checking too, so that doesn't seem
like a good idea. Did you run access_ok() checks separately? (This
generally isn't recommended.)

The usercopy hardening is intended to only kick in when the copy size
isn't a builtin constant -- it's attempting to do a bounds check on
the size, with the pointer used to figure out what bounds checking is
possible (basically "is this stack? check stack location/frame size"
or "is this kmem cache? check the allocation size") and then do bounds
checks from there. It tries to bail out early to avoid needless checking,
so if there is some additional logic to be added to check_object_size()
that is globally applicable, sure, let's do it.

I'm still not clear from this thread about the case that is getting
tripped/slowed? If you're already doing bounds checks somewhere else
and there isn't a chance for the pointer or size to change, then yeah,
it seems safe to skip the usercopy size checks. But what's the actual
code that is having a problem?

-- 
Kees Cook
