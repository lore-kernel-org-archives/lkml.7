Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B372C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 09:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62C7720867
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 09:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="CKx2nl8m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387605AbfJDJP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 05:15:56 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34770 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730179AbfJDJPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 05:15:52 -0400
Received: by mail-lf1-f68.google.com with SMTP id r22so3978067lfm.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 02:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0Us1lDU91ARlIyktnavIDRL8lb/sm12kQiQVA+0Ejvg=;
        b=CKx2nl8mv09gh5ixysIItMN9ZN4Qj/4UWeO1V0Qbj2U6oKrDgc2Too9NWRvTWOP00Q
         UwNvPh29o52J6B4Rhu8iJn5Esmj/2k//OXgsLn/j7ur/t1N3uqWtco6/CKJrEOthzl+b
         cLkj2pGGKqcRuf8ftqe7RGtKZ4NsFRTkLsuV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0Us1lDU91ARlIyktnavIDRL8lb/sm12kQiQVA+0Ejvg=;
        b=aQ9MLgsfPOeHajd0AEL0K5n1TlU6BX0H3j8r4PUB32LknZ3iR2M5MQxjXT+Ng56FZP
         jELgiCrGf7YiURyp7uLC71xFYcgTk5dQbuUdMPQaWnsvgm1Y1W92Ktvqtq/5xrEl7DpX
         V8SnFxnsG4k11b7FMnWMrpmLGzCkDkzcCYTNpPY76CRNBqKMv94wk3Qr2lsilzKs+0Zh
         syIQsIbZiQiLqdW7wtWe/YzR9pikSPmWW0ut2jtxEW5QBoAGrK+rjkjMNUKzpHWVZveR
         kkPHbVniwMMvoyS9gyVrIQyqviOg+0MbMKRJlcNtZUFIBH2QgKvFEkmuDY5nnregceSB
         JLuA==
X-Gm-Message-State: APjAAAWJB07+ZjlYJJE7KYbACsf+/tj7iyfljHLvE45spI+jWJs6XbF9
        K1PZm61xZaD7x4EV44uMPYvgkNychnVOzKdh
X-Google-Smtp-Source: APXvYqx1YjgDQmgOaABKRDpDy+Ve/6T1gPykFB8TapFBVDjVxcp2BwKGTdjsjLXCFgy4RpZ1SGKRGw==
X-Received: by 2002:a19:644c:: with SMTP id b12mr8292937lfj.104.1570180548539;
        Fri, 04 Oct 2019 02:15:48 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id p27sm1066187lfo.95.2019.10.04.02.15.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2019 02:15:48 -0700 (PDT)
Subject: Re: [PATCH v3] docs: Use make invocation's -j argument for
 parallelism
To:     Kees Cook <keescook@chromium.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <201909241627.CEA19509@keescook>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <eb25959a-9ec4-3530-2031-d9d716b40b20@rasmusvillemoes.dk>
Date:   Fri, 4 Oct 2019 11:15:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <201909241627.CEA19509@keescook>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/2019 01.29, Kees Cook wrote:
>  
>  # User-friendly check for pdflatex and latexmk
>  HAVE_PDFLATEX := $(shell if which $(PDFLATEX) >/dev/null 2>&1; then echo 1; else echo 0; fi)
> @@ -68,6 +68,7 @@ quiet_cmd_sphinx = SPHINX  $@ --> file://$(abspath $(BUILDDIR)/$3/$4)
>  	PYTHONDONTWRITEBYTECODE=1 \
>  	BUILDDIR=$(abspath $(BUILDDIR)) SPHINX_CONF=$(abspath $(srctree)/$(src)/$5/$(SPHINX_CONF)) \
>  	$(SPHINXBUILD) \
> +	-j $(shell python $(srctree)/scripts/jobserver-count $(SPHINX_PARALLEL)) \
>  	-b $2 \
>  	-c $(abspath $(srctree)/$(src)) \
>  	-d $(abspath $(BUILDDIR)/.doctrees/$3) \
> diff --git a/scripts/jobserver-count b/scripts/jobserver-count
> new file mode 100755
> index 000000000000..0b482d6884d2
> --- /dev/null
> +++ b/scripts/jobserver-count
> @@ -0,0 +1,58 @@
> +#!/usr/bin/env python
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# This determines how many parallel tasks "make" is expecting, as it is
> +# not exposed via an special variables.
> +# https://www.gnu.org/software/make/manual/html_node/POSIX-Jobserver.html#POSIX-Jobserver
> +from __future__ import print_function
> +import os, sys, fcntl, errno
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

OK, this handles the fact that Make changed from --jobserver-fds to
--jobserver-auth at some point. Probably the comment could be more accurate.

> +	# Parse out R,W file descriptor numbers and set them nonblocking.
> +	fds = opts[0].split("=", 1)[1]
> +	reader, writer = [int(x) for x in fds.split(",", 1)]
> +	reader = nonblock(reader)
> +except (KeyError, IndexError, ValueError, IOError):
> +	# Any missing environment strings or bad fds should result in just
> +	# using the default specified parallelism.
> +	print(default)
> +	sys.exit(0)
> +
> +# Read out as many jobserver slots as possible.
> +jobs = b""
> +while True:
> +	try:
> +		slot = os.read(reader, 1)
> +		jobs += slot
> +	except (OSError, IOError) as e:
> +		if e.errno == errno.EWOULDBLOCK:
> +			# Stop when reach the end of the jobserver queue.
> +			break
> +		raise e

<strikethrough>Only very new Make (e.g. not make 4.1 shipped with Ubuntu
18.04) sets the rfd as O_NONBLOCK (and only when it detected
HAVE_PSELECT at configure time, but that can probably be assumed). So
won't the above just hang forever if run under such a make?</strikethrough>

Ah, reading more carefully you set O_NONBLOCK explicitly. Well, older
Makes are going to be very unhappy about that (remember that it's a
property of the file description and not file descriptor). They don't
expect EAGAIN when fetching a token, so fail hard. Probably not when
htmldocs is the only target, because in that case the toplevel Make just
reads back the exact number of tokens it put in as a sanity check, but
if it builds other targets/spawns other submakes, I think this breaks.

Yeah, it's a mess, and the Make documentation should be much more
explicit about how one is supposed to interact with the job server and
the file descriptors. Some of the pain would vanish if it just used a
named pipe and had each client open its own fds to that so they could
each choose O_NONBLOCK or not.

> +# Return all the reserved slots.
> +os.write(writer, jobs)

Well, that probably works ok for the isolated case of a toplevel "make
-j12 htmldocs", but if you're building other targets ("make -j12
htmldocs vmlinux") this will effectively inject however many tokens the
above loop grabbed (which might not be all if the top-level make has
started things related to the vmlinux target), so for the duration of
the docs build, there will be more processes running than asked for.

> +# If the jobserver was (impossibly) full or communication failed, use default.
> +if len(jobs) < 1:
> +	print(default)
> +
> +# Report available slots (with a bump for our caller's reserveration).
> +print(len(jobs) + 1)

There's a missing exit() or else: here; if len(jobs) < 1 you print both
default (probably "1") and 0+1 aka "1".

Rasmus
