Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFB1C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 19:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC2A220672
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 19:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XMfzQIYt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfKUTjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 14:39:07 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:47070 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbfKUTjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 14:39:07 -0500
Received: by mail-pj1-f66.google.com with SMTP id a16so1935810pjs.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 11:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=COatpzDuZgl9WMg8hp9kMY5ElrlJCYz6DmuSXPX+4MI=;
        b=XMfzQIYtZ59LpXSVL0ZsuREdO/zTlCEpjB3yrDBDcaEUp07a/rl9MG1vi8zsNQniFI
         EY26nphwA7xJfu/RQBhzFdqIgC5vy6jR7lMWx1+YO0LZvM3Rq7kJqBjSHxvvD+7SiwDF
         YoEbTBxvincX2cA/1K7Y11EdYqH2RY+fv7Uks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=COatpzDuZgl9WMg8hp9kMY5ElrlJCYz6DmuSXPX+4MI=;
        b=GKlEqT+4HcmmWqD8DOQZr5obRtH8wxkdcOTxNh3q3cD8TUnK069T/8wBNAXoQoLMz+
         +7WzBQ+1gbXDsyQhv2b//9Za997WRzApQUeAomU1xbHW7wnEgqjLSL5ZnUeltI5azO0c
         h/9ivgRyq2vL3YwGyZw8mxrzacZxve1clmU/YyXwCg1IZBj4VfuMzYKJ6WKECiYyU2LY
         MSs/HEToixFJ7OyEmuCzU6LaGGAUa4lKDLK1ytBZOJsUIJGklcsd4RKY45QTbLR0uSdR
         ajPrD0/6+C+7sE1KZ3ZqzKhwAjMfzUlgJG1pspIZJBY3zcwGEWnpDM6AVfIU4N9gM6ME
         FZhw==
X-Gm-Message-State: APjAAAVIcizrTox0EjRpEY5rLYwe5RT4aE1QLQXtrY8ZFduIpR4i4YGa
        6Ym8oQEwaP3Z5y91ZfmC8FGvLg==
X-Google-Smtp-Source: APXvYqz/jtL9tVfuwcoRhIixv519GB1afp4iPElbqeuxfM7fkUi9Gv03HiJSgOyNJ38Uc33MLBVSFQ==
X-Received: by 2002:a17:90a:23e2:: with SMTP id g89mr13232298pje.127.1574365145234;
        Thu, 21 Nov 2019 11:39:05 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k13sm3978316pgl.69.2019.11.21.11.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 11:39:04 -0800 (PST)
Date:   Thu, 21 Nov 2019 11:39:03 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] docs, parallelism: Rearrange how jobserver
 reservations are made
Message-ID: <201911211122.02F3646@keescook>
References: <20191121000304.48829-1-keescook@chromium.org>
 <20191121000304.48829-4-keescook@chromium.org>
 <656afebc-fc60-7502-40a3-52d2662c1d27@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <656afebc-fc60-7502-40a3-52d2662c1d27@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 09:09:37AM +0100, Rasmus Villemoes wrote:
> On 21/11/2019 01.03, Kees Cook wrote:
> > diff --git a/Documentation/sphinx/parallel-wrapper.sh b/Documentation/sphinx/parallel-wrapper.sh
> > new file mode 100644
> > index 000000000000..a416dbfd2025
> > --- /dev/null
> > +++ b/Documentation/sphinx/parallel-wrapper.sh
> > @@ -0,0 +1,25 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0+
> > +#
> > +# Figure out if we should follow a specific parallelism from the make
> > +# environment (as exported by scripts/jobserver-exec), or fall back to
> > +# the "auto" parallelism when "-jN" is not specified at the top-level
> > +# "make" invocation.
> > +
> > +sphinx="$1"
> > +shift || true
> > +
> > +parallel="${PARALLELISM:-1}"
> > +if [ ${parallel} -eq 1 ] ; then
> > +	auto=$(perl -e 'open IN,"'"$sphinx"' --version 2>&1 |";
> > +			while (<IN>) {
> > +				if (m/([\d\.]+)/) {
> > +					print "auto" if ($1 >= "1.7")
> > +				}
> > +			}
> > +			close IN')
> > +	if [ -n "$auto" ] ; then
> > +		parallel="$auto"
> > +	fi
> > +fi
> > +exec "$sphinx" "-j$parallel" "$@"
> 
> I don't understand this logic. If the parent failed to claim any tokens
> (likely because the top make and its descendants are already running 16
> gcc processes), just let sphinx run #cpus jobs in parallel? That doesn't
> make sense - it gets us back to the "we've now effectively injected K
> tokens to the jobserver that weren't there originally".

I was going to say "but jobserver-exec can't be running unless there are
available slots", but I see the case is "if there are 16 slots and
jobserver-exec gets _1_, it should not fall back to 'auto'".

> From the comment above, what you want is to use "auto" if the top
> invocation was simply "make docs". Well, I kind of disagree with falling
> back to auto in that case; the user can say "make -j8 docs" and the
> wrapper is guaranteed to claim them all. But if you really want, the
> jobserver-count script needs to detect and export the "no parallelism
> requested at top level" in some way distinct from "PARALLELISM=1",
> because that's ambiguous.

Right -- failure needs to be be distinct from "only 1 available".

> > +	# Read out as many jobserver slots as possible.
> > +	while True:
> > +		try:
> > +			slot = os.read(reader, 1)
> > +			jobs += slot
> 
> I'd just try to slurp in 8 or 16 tokens at a time, there's no reason to
> limit to 1 in each loop.

Good point. I will change that.

> > +rc = subprocess.call(sys.argv[1:])
> > +
> > +# Return all the actually reserved slots.
> > +if len(jobs):
> > +	os.write(writer, jobs)
> > +
> > +sys.exit(rc)
> 
> What happens if the child dies from a signal? Will this correctly
> forward that information?

As far as I understand, yes, signal codes are passed through via the exit
code (i.e. see WIFSIGNALED, etc).

> Similarly (and the harder problem), what happens when our parent wants
> to send its child a signal to say "stop what you're doing, return the
> tokens, brush your teeth and go to bed". We should forward that signal
> to the real job instead of just dying, losing track of both the tokens
> we've claimed as well as orphaning the child.

Hm, hm. I guess I could pass INT and TERM to the child. That seems like
the most sensible best-effort here. It seems "make" isn't only looking
at the slots to determine process management.

-- 
Kees Cook
