Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3824C3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 20:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84A4720830
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 20:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729468AbfIVUDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 16:03:40 -0400
Received: from ms.lwn.net ([45.79.88.28]:47738 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726188AbfIVUDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 16:03:39 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 4FAAE728;
        Sun, 22 Sep 2019 20:03:37 +0000 (UTC)
Date:   Sun, 22 Sep 2019 14:03:31 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: Use make invocation's -j argument for
 parallelism
Message-ID: <20190922140331.3ffe8604@lwn.net>
In-Reply-To: <201909191438.C00E6DB@keescook>
References: <201909191438.C00E6DB@keescook>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Sep 2019 14:44:37 -0700
Kees Cook <keescook@chromium.org> wrote:

> While sphinx 1.7 and later supports "-jauto" for parallelism, this
> effectively ignores the "-j" flag used in the "make" invocation, which
> may cause confusion for build systems. Instead, extract the available

What sort of confusion might we expect?  Or, to channel akpm, "what are the
user-visible effects of this bug"?

> parallelism from "make"'s job server (since it is not exposed in any
> special variables) and use that for the "sphinx-build" run. Now things
> work correctly for builds where -j is specified at the top-level:
> 
> 	make -j16 htmldocs
> 
> If -j is not specified, continue to fallback to "-jauto" if available.

So this seems like a good thing to do.  I do have a couple of small issues,
though... 

[...]

> +	-j $(shell python3 $(srctree)/scripts/jobserver-count $(SPHINX_PARALLEL)) \

This (and the shebang line in the script itself) will cause the docs build
to fail on systems lacking Python 3.  While we have talked about requiring
Python 3 for the docs build, we have not actually taken that step yet.  We
probably shouldn't sneak it in here.  I don't see anything in the script
that should require a specific Python version, so I think it should be
tweaked to be version-independent and just invoke "python".

>  	-b $2 \
>  	-c $(abspath $(srctree)/$(src)) \
>  	-d $(abspath $(BUILDDIR)/.doctrees/$3) \
> diff --git a/scripts/jobserver-count b/scripts/jobserver-count
> new file mode 100755
> index 000000000000..ff6ebe6b0194
> --- /dev/null
> +++ b/scripts/jobserver-count
> @@ -0,0 +1,53 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0-or-later

By license-rules.rst, this should be GPL-2.0+

> +#
> +# This determines how many parallel tasks "make" is expecting, as it is
> +# not exposed via an special variables.
> +# https://www.gnu.org/software/make/manual/html_node/POSIX-Jobserver.html#POSIX-Jobserver
> +import os, sys, fcntl
> +
> +# Default parallelism is "1" unless overridden on the command-line.
> +default="1"
> +if len(sys.argv) > 1:
> +	default=sys.argv[1]
> +
> +# Set non-blocking for a given file descriptor.
> +def nonblock(fd):
> +	flags = fcntl.fcntl(fd, fcntl.F_GETFL)
> +	fcntl.fcntl(fd, fcntl.F_SETFL, flags | os.O_NONBLOCK)
> +	return fd
> +
> +# Extract and prepare jobserver file descriptors from envirnoment.
> +try:
> +	# Fetch the make environment options.
> +	flags = os.environ['MAKEFLAGS']
> +
> +	# Look for "--jobserver=R,W"
> +	opts = [x for x in flags.split(" ") if x.startswith("--jobserver")]
> +
> +	# Parse out R,W file descriptor numbers and set them nonblocking.
> +	fds = opts[0].split("=", 1)[1]
> +	reader, writer = [nonblock(int(x)) for x in fds.split(",", 1)]
> +except:

So I have come to really dislike bare "except" clauses; I've seen them hide
too many bugs.  In this case, perhaps it's justified, but still ... it bugs
me ...

> +	# Any failures here should result in just using the default
> +	# specified parallelism.
> +	print(default)
> +	sys.exit(0)
> +
> +# Read out as many jobserver slots as possible.
> +jobs = b""
> +while True:
> +	try:
> +		slot = os.read(reader, 1)
> +		jobs += slot
> +	except:

This one, I think, should be explicit; anything other than EWOULDBLOCK
indicates a real problem, right?

> +		break
> +# Return all the reserved slots.
> +os.write(writer, jobs)

You made writer nonblocking, so it seems plausible that we could leak some
slots here, no?  Does writer really need to be nonblocking?

> +# If the jobserver was (impossibly) full or communication failed, use default.
> +if len(jobs) < 1:
> +	print(default)
> +
> +# Report available slots (with a bump for our caller's reserveration).
> +print(len(jobs) + 1)

The last question I have is...why is it that we have to do this complex
dance rather than just passing the "-j" option through directly to sphinx?
That comes down to the "confusion" mentioned at the top, I assume.  It
would be good to understand that?

Thanks,

jon
