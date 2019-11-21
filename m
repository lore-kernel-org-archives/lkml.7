Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B15C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 08:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77A5820855
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 08:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="O9HgI3du"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfKUIJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 03:09:42 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38838 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbfKUIJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 03:09:42 -0500
Received: by mail-lf1-f66.google.com with SMTP id q28so1840845lfa.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 00:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DDWVROnFaljaNNmaAzQ4x+4ZlkNQ9P7Z6d8u+o+nQYA=;
        b=O9HgI3duRnemM/1cV0Nj6vrF+1krOVReUyREI0TCc2cQu6RazSEandX1dX1Ba9Uj+V
         T7l1ojhh/vTDQqJ3MG4NDjWMmbuckpXHyCUnE70nX81Syriw6ZACxsyqCNgh4Kt3065h
         dhp0vlU5+MHXSilH8qjSC2MnIQ1Ew4SF7xURo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DDWVROnFaljaNNmaAzQ4x+4ZlkNQ9P7Z6d8u+o+nQYA=;
        b=iRDAeFZvw15lKt9ScfXYpQM+m8JLt9veywsnNaKyv3VtiLlpFdm1adC32XW+OZPazU
         wuE/TYaLJsK0zGxyapxBxgiMRyOEWRrx6Hvc3zaxJdDAgbsGkHqmgAvnibE/zuf1bWMk
         WQtGe+4hDJp9gJ3jMLbaoAmtDpnkUnjNe+Io92xY416k++kei7MP87DYh0p0/VCn5lyV
         YyFJjz9Lbn8wSZDYNTo9BQtWttqNryXMzB9tZibu2fjqEnl81dXHOpvTT81JLnUn3Z+x
         67YRUH/MSH16g8Nc/IQuqtJj0SNI9FkTdKNG2njuPQ5/qtjlSFmfaDTOdvaP2ErFSptB
         anTQ==
X-Gm-Message-State: APjAAAUxqG+0YaRxiyxn94VmCL4xo4TRSEpG/P1uUm+YFbdk+9mLV28P
        7D3SHHYVmtTLuKNa64+2RMYK+r2qLEVfNZi1
X-Google-Smtp-Source: APXvYqyvA62tGtBvAbCwcgoxlezdFk4vMhQIexTneWo+e4emQMejyXTuXgINTgk5VKIQJtsEaYQ/bw==
X-Received: by 2002:a19:c384:: with SMTP id t126mr6435537lff.100.1574323779259;
        Thu, 21 Nov 2019 00:09:39 -0800 (PST)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 206sm897443lfb.20.2019.11.21.00.09.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 00:09:38 -0800 (PST)
Subject: Re: [PATCH 3/3] docs, parallelism: Rearrange how jobserver
 reservations are made
To:     Kees Cook <keescook@chromium.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191121000304.48829-1-keescook@chromium.org>
 <20191121000304.48829-4-keescook@chromium.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <656afebc-fc60-7502-40a3-52d2662c1d27@rasmusvillemoes.dk>
Date:   Thu, 21 Nov 2019 09:09:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191121000304.48829-4-keescook@chromium.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2019 01.03, Kees Cook wrote:
> Rasmus correctly observed that the existing jobserver reservation only
> worked if no other build targets were specified. The correct approach
> is to hold the jobserver slots until sphinx has finished. To fix this,
> the following changes are made:
> 
> - refactor (and rename) scripts/jobserver-exec to set an environment
>   variable for the maximally reserved jobserver slots and exec a
>   child, to release the slots on exit.
> 
> - create Documentation/scripts/parallel-wrapper.sh which examines both
>   $PARALLELISM and the detected "-jauto" logic from Documentation/Makefile
>   to decide sphinx's final -j argument.
> 
> - chain these together in Documentation/Makefile
> 
> Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Link: https://lore.kernel.org/lkml/eb25959a-9ec4-3530-2031-d9d716b40b20@rasmusvillemoes.dk
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  Documentation/Makefile                      |  5 +-
>  Documentation/sphinx/parallel-wrapper.sh    | 25 +++++++
>  scripts/{jobserver-count => jobserver-exec} | 73 ++++++++++++---------
>  3 files changed, 68 insertions(+), 35 deletions(-)
>  create mode 100644 Documentation/sphinx/parallel-wrapper.sh
>  rename scripts/{jobserver-count => jobserver-exec} (50%)
>  mode change 100755 => 100644
> 
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index ce8eb63b523a..30554a2fbdd7 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -33,8 +33,6 @@ ifeq ($(HAVE_SPHINX),0)
>  
>  else # HAVE_SPHINX
>  
> -export SPHINX_PARALLEL = $(shell perl -e 'open IN,"sphinx-build --version 2>&1 |"; while (<IN>) { if (m/([\d\.]+)/) { print "auto" if ($$1 >= "1.7") } ;} close IN')
> -
>  # User-friendly check for pdflatex and latexmk
>  HAVE_PDFLATEX := $(shell if which $(PDFLATEX) >/dev/null 2>&1; then echo 1; else echo 0; fi)
>  HAVE_LATEXMK := $(shell if which latexmk >/dev/null 2>&1; then echo 1; else echo 0; fi)
> @@ -67,8 +65,9 @@ quiet_cmd_sphinx = SPHINX  $@ --> file://$(abspath $(BUILDDIR)/$3/$4)
>        cmd_sphinx = $(MAKE) BUILDDIR=$(abspath $(BUILDDIR)) $(build)=Documentation/media $2 && \
>  	PYTHONDONTWRITEBYTECODE=1 \
>  	BUILDDIR=$(abspath $(BUILDDIR)) SPHINX_CONF=$(abspath $(srctree)/$(src)/$5/$(SPHINX_CONF)) \
> +	$(PYTHON) $(srctree)/scripts/jobserver-exec \
> +	$(SHELL) $(srctree)/Documentation/sphinx/parallel-wrapper.sh \
>  	$(SPHINXBUILD) \
> -	-j $(shell python $(srctree)/scripts/jobserver-count $(SPHINX_PARALLEL)) \
>  	-b $2 \
>  	-c $(abspath $(srctree)/$(src)) \
>  	-d $(abspath $(BUILDDIR)/.doctrees/$3) \
> diff --git a/Documentation/sphinx/parallel-wrapper.sh b/Documentation/sphinx/parallel-wrapper.sh
> new file mode 100644
> index 000000000000..a416dbfd2025
> --- /dev/null
> +++ b/Documentation/sphinx/parallel-wrapper.sh
> @@ -0,0 +1,25 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# Figure out if we should follow a specific parallelism from the make
> +# environment (as exported by scripts/jobserver-exec), or fall back to
> +# the "auto" parallelism when "-jN" is not specified at the top-level
> +# "make" invocation.
> +
> +sphinx="$1"
> +shift || true
> +
> +parallel="${PARALLELISM:-1}"
> +if [ ${parallel} -eq 1 ] ; then
> +	auto=$(perl -e 'open IN,"'"$sphinx"' --version 2>&1 |";
> +			while (<IN>) {
> +				if (m/([\d\.]+)/) {
> +					print "auto" if ($1 >= "1.7")
> +				}
> +			}
> +			close IN')
> +	if [ -n "$auto" ] ; then
> +		parallel="$auto"
> +	fi
> +fi
> +exec "$sphinx" "-j$parallel" "$@"

I don't understand this logic. If the parent failed to claim any tokens
(likely because the top make and its descendants are already running 16
gcc processes), just let sphinx run #cpus jobs in parallel? That doesn't
make sense - it gets us back to the "we've now effectively injected K
tokens to the jobserver that weren't there originally".

From the comment above, what you want is to use "auto" if the top
invocation was simply "make docs". Well, I kind of disagree with falling
back to auto in that case; the user can say "make -j8 docs" and the
wrapper is guaranteed to claim them all. But if you really want, the
jobserver-count script needs to detect and export the "no parallelism
requested at top level" in some way distinct from "PARALLELISM=1",
because that's ambiguous.

> diff --git a/scripts/jobserver-count b/scripts/jobserver-exec
> old mode 100755
> new mode 100644
> similarity index 50%
> rename from scripts/jobserver-count
> rename to scripts/jobserver-exec
> index a68a04ad304f..4593b2a1e36d
> --- a/scripts/jobserver-count
> +++ b/scripts/jobserver-exec
> @@ -2,17 +2,16 @@
>  # SPDX-License-Identifier: GPL-2.0+
>  #
>  # This determines how many parallel tasks "make" is expecting, as it is
> -# not exposed via an special variables.
> +# not exposed via an special variables, reserves them all, runs a subprocess
> +# with PARALLELISM environment variable set, and releases the jobs back again.
> +#
>  # https://www.gnu.org/software/make/manual/html_node/POSIX-Jobserver.html#POSIX-Jobserver
>  from __future__ import print_function
>  import os, sys, fcntl, errno
> -
> -# Default parallelism is "1" unless overridden on the command-line.
> -default="1"
> -if len(sys.argv) > 1:
> -	default=sys.argv[1]
> +import subprocess
>  
>  # Extract and prepare jobserver file descriptors from envirnoment.
> +jobs = b""
>  try:
>  	# Fetch the make environment options.
>  	flags = os.environ['MAKEFLAGS']
> @@ -30,31 +29,41 @@ try:
>  	reader = os.open("/proc/self/fd/%d" % (reader), os.O_RDONLY)
>  	flags = fcntl.fcntl(reader, fcntl.F_GETFL)
>  	fcntl.fcntl(reader, fcntl.F_SETFL, flags | os.O_NONBLOCK)
> -except (KeyError, IndexError, ValueError, IOError, OSError) as e:
> -	print(e, file=sys.stderr)
> +
> +	# Read out as many jobserver slots as possible.
> +	while True:
> +		try:
> +			slot = os.read(reader, 1)
> +			jobs += slot

I'd just try to slurp in 8 or 16 tokens at a time, there's no reason to
limit to 1 in each loop.

> +		except (OSError, IOError) as e:
> +			if e.errno == errno.EWOULDBLOCK:
> +				# Stop at the end of the jobserver queue.
> +				break
> +			# If something went wrong, give back the jobs.
> +			if len(jobs):
> +				os.write(writer, jobs)
> +			raise e
> +except (KeyError, IndexError, ValueError, OSError, IOError) as e:
>  	# Any missing environment strings or bad fds should result in just
> -	# using the default specified parallelism.
> -	print(default)
> -	sys.exit(0)
> +	# not being parallel.
> +	pass
>  
> -# Read out as many jobserver slots as possible.
> -jobs = b""
> -while True:
> -	try:
> -		slot = os.read(reader, 1)
> -		jobs += slot
> -	except (OSError, IOError) as e:
> -		if e.errno == errno.EWOULDBLOCK:
> -			# Stop when reach the end of the jobserver queue.
> -			break
> -		raise e
> -# Return all the reserved slots.
> -os.write(writer, jobs)
> -
> -# If the jobserver was (impossibly) full or communication failed, use default.
> -if len(jobs) < 1:
> -	print(default)
> -	sys.exit(0)
> -
> -# Report available slots (with a bump for our caller's reserveration).
> -print(len(jobs) + 1)
> +claim = len(jobs)
> +if claim < 1:
> +	# If the jobserver was (impossibly) full or communication failed
> +	# in some way do not use parallelism.
> +	claim = 0

Eh, "claim < 1" is the same as "claim == 0", right? So this doesn't seem
to do much. But what seems to be missing is that after you write back
the tokens in the error case above (os.write(writer, jobs)), jobs is not
set back to the empty string. That needs to be done either there or in
the outer exception handler (where you just have a "pass" currently).

> +# Launch command with a bump for our caller's reserveration,
> +# since we're just going to sit here blocked on our child.
> +claim += 1
> +
> +os.unsetenv('MAKEFLAGS')
> +os.environ['PARALLELISM'] = '%d' % (claim)
> +rc = subprocess.call(sys.argv[1:])
> +
> +# Return all the actually reserved slots.
> +if len(jobs):
> +	os.write(writer, jobs)
> +
> +sys.exit(rc)

What happens if the child dies from a signal? Will this correctly
forward that information?

Similarly (and the harder problem), what happens when our parent wants
to send its child a signal to say "stop what you're doing, return the
tokens, brush your teeth and go to bed". We should forward that signal
to the real job instead of just dying, losing track of both the tokens
we've claimed as well as orphaning the child.

Rasmus
