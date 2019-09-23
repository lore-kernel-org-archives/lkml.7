Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED747C432C1
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 22:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B594220578
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 22:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ne7PIJi2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503457AbfIWWkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 18:40:45 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34779 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392282AbfIWWko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 18:40:44 -0400
Received: by mail-pf1-f196.google.com with SMTP id b128so10117321pfa.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 15:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dV/VFIBBnqaIS6aRCC/wcXHFeYbMA2iZ1Q9+7enJTQg=;
        b=Ne7PIJi24GGIHptbAvF1PYuU1lPdUtAI8cUiMgsIavTd3Ni4NUMgE5ngyrSH0WjFpJ
         y6V13OYicPJFLnGdpvQOoM2ZiBUQgeKR6S3xP0qepIBvlRosmtun5YhV47GwZBMhwHIi
         fUrNZg8L5+CM3H1+fM8iP30LIcWfeOB4xauFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dV/VFIBBnqaIS6aRCC/wcXHFeYbMA2iZ1Q9+7enJTQg=;
        b=iICMlj6PkQRlEavKie8wG6dpe8dHWlSCaOoJywrOUb/OHyRMB1rXaif2OWYiMdbPG2
         7DnlmMGWAa8ZrQhmI5h3oHR13fo9ZDWR5J+fswhPAuaRcuBTkwltIZnybY/9iv3xDIR7
         Xgs6hKVONYLNZfjCFe/hm8dcM1B6Eqrqrw4o9abLuhBQDIjOnHXWczJWzN8Kss6ZHUWv
         Ge+dOA6odwv/xGskT/l5J2/7rMqOIKfyIHZwe7XsXXbEAYZh6sLWrwO+1xO7rJNBd82i
         xUU3mBvNuliPnUfNDVGQZO5FA8KYz/pKIUs9opo1iQcyKw0ktX/st+2RXXhmM5OlNUKN
         3PCA==
X-Gm-Message-State: APjAAAUy7XaNZ5vrR/mLDWnGGCk15ZXb2S8s1lWNJvJhkld6ziB2LyMm
        +Ui50eS42ObfWnwpLrts3UqZJQ==
X-Google-Smtp-Source: APXvYqwJ/YZFjqVIePIntTXndtIsstaltiFMdt5JylGJwMjKeHF8y7vM9oVdgnJmvOsINhEnrCrbCw==
X-Received: by 2002:a65:504c:: with SMTP id k12mr2257623pgo.252.1569278443553;
        Mon, 23 Sep 2019 15:40:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o42sm19687393pjo.32.2019.09.23.15.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 15:40:42 -0700 (PDT)
Date:   Mon, 23 Sep 2019 15:40:41 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: Use make invocation's -j argument for
 parallelism
Message-ID: <201909231537.0FC0474C@keescook>
References: <201909191438.C00E6DB@keescook>
 <20190922140331.3ffe8604@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190922140331.3ffe8604@lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 22, 2019 at 02:03:31PM -0600, Jonathan Corbet wrote:
> On Thu, 19 Sep 2019 14:44:37 -0700
> Kees Cook <keescook@chromium.org> wrote:
> 
> > While sphinx 1.7 and later supports "-jauto" for parallelism, this
> > effectively ignores the "-j" flag used in the "make" invocation, which
> > may cause confusion for build systems. Instead, extract the available
> 
> What sort of confusion might we expect?  Or, to channel akpm, "what are the
> user-visible effects of this bug"?

When I run "make htmldocs -j16" with a pre-1.7 sphinx, it is not
parallelized. When I run "make htmldocs -j8" with 1.7+ sphinx, it uses
all my CPUs instead of 8. :)

> > +	-j $(shell python3 $(srctree)/scripts/jobserver-count $(SPHINX_PARALLEL)) \
> 
> This (and the shebang line in the script itself) will cause the docs build
> to fail on systems lacking Python 3.  While we have talked about requiring
> Python 3 for the docs build, we have not actually taken that step yet.  We
> probably shouldn't sneak it in here.  I don't see anything in the script
> that should require a specific Python version, so I think it should be
> tweaked to be version-independent and just invoke "python".

Ah, no problem. I can fix this. In a quick scan it looked like sphinx
was python3, but I see now that's just my install. :)

> >  	-b $2 \
> >  	-c $(abspath $(srctree)/$(src)) \
> >  	-d $(abspath $(BUILDDIR)/.doctrees/$3) \
> > diff --git a/scripts/jobserver-count b/scripts/jobserver-count
> > new file mode 100755
> > index 000000000000..ff6ebe6b0194
> > --- /dev/null
> > +++ b/scripts/jobserver-count
> > @@ -0,0 +1,53 @@
> > +#!/usr/bin/env python3
> > +# SPDX-License-Identifier: GPL-2.0-or-later
> 
> By license-rules.rst, this should be GPL-2.0+

Whoops, thanks.

> > +# Extract and prepare jobserver file descriptors from envirnoment.
> > +try:
> > +	# Fetch the make environment options.
> > +	flags = os.environ['MAKEFLAGS']
> > +
> > +	# Look for "--jobserver=R,W"
> > +	opts = [x for x in flags.split(" ") if x.startswith("--jobserver")]
> > +
> > +	# Parse out R,W file descriptor numbers and set them nonblocking.
> > +	fds = opts[0].split("=", 1)[1]
> > +	reader, writer = [nonblock(int(x)) for x in fds.split(",", 1)]
> > +except:
> 
> So I have come to really dislike bare "except" clauses; I've seen them hide
> too many bugs.  In this case, perhaps it's justified, but still ... it bugs
> me ...

Fair enough. I will adjust this (and the later instance).

> 
> > +	# Any failures here should result in just using the default
> > +	# specified parallelism.
> > +	print(default)
> > +	sys.exit(0)
> > +
> > +# Read out as many jobserver slots as possible.
> > +jobs = b""
> > +while True:
> > +	try:
> > +		slot = os.read(reader, 1)
> > +		jobs += slot
> > +	except:
> 
> This one, I think, should be explicit; anything other than EWOULDBLOCK
> indicates a real problem, right?
> 
> > +		break
> > +# Return all the reserved slots.
> > +os.write(writer, jobs)
> 
> You made writer nonblocking, so it seems plausible that we could leak some
> slots here, no?  Does writer really need to be nonblocking?

Good point. I will fix this too.

> 
> > +# If the jobserver was (impossibly) full or communication failed, use default.
> > +if len(jobs) < 1:
> > +	print(default)
> > +
> > +# Report available slots (with a bump for our caller's reserveration).
> > +print(len(jobs) + 1)
> 
> The last question I have is...why is it that we have to do this complex
> dance rather than just passing the "-j" option through directly to sphinx?
> That comes down to the "confusion" mentioned at the top, I assume.  It
> would be good to understand that?

There is no method I have found to discover the -j option's contents
(intentionally so, it seems) from within make. :(

-- 
Kees Cook
