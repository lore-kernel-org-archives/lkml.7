Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06D7C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 19:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4D822053B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 19:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568921157;
	bh=55/U6Bd+njNcoRUR4rYx0oA8fiyhvo9srawFTBaua6I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=sPOgGgoJC9lfGcWCAwa03wfeRAxxmwbERHjpx/XPBfrQLHaqJm/118WdSwx8gqrnM
	 q5OqQSUyO4ZQUn713CKpJ90cxNg9fp1HMb6p9T6Wtv5cKUqOSjYjen0pj+1rncUTqc
	 LT1WySCR1sQIDlbNDhupxHKL4qYZpfsbeDC/0nNE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404433AbfISTZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 15:25:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52612 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404419AbfISTZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 15:25:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3vJe3OMoI9/fq2WHf+U73uPJ4vyM059pSbCzmST6qPQ=; b=BGQVcMartnwZd1GiAMWMsufYs
        DHfSQ1lrTCooCqwFpGEeHsN2xJiMAFvx0hsUO4aG5GZAO9hloi0XaJG5GH07mARrm+bj8rApUEYVb
        5VIK2ILOq49RUIBvPcuQR2pJ4ELd4F+gShfI2J3tNi9cGSMusJn5uxnRMgPtgQG5BLQMZMQe7t9RL
        dn3JHXYHbXl1k60kSFeoiMgInXOxZny6DbA2GHHppvcGLoiHke3/zqQDzu/u4S5Gt+oJYfXRIn8j5
        OE/TwRRgvU2NDIbQUAl9Rp3BysfnUc+YY2PN+tN1DJASSemKkt7aBSvzaMgCe+xJ6NSaXhIEKYhha
        CQOJ1nYlw==;
Received: from 201.86.135.82.dynamic.adsl.gvt.net.br ([201.86.135.82] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iB23u-0000Gh-8N; Thu, 19 Sep 2019 19:25:54 +0000
Date:   Thu, 19 Sep 2019 16:25:49 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: Use make invocation's -j argument for parallelism
Message-ID: <20190919162549.5ccdab62@coco.lan>
In-Reply-To: <201909191116.192A096C68@keescook>
References: <201909191116.192A096C68@keescook>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 19 Sep 2019 11:18:52 -0700
Kees Cook <keescook@chromium.org> escreveu:

> While sphinx 1.7 and later supports "-jauto" for parallelism, this
> effectively ignores the "-j" flag used in the "make" invocation, which
> may cause confusion for build systems. Instead, extract the available
> parallelism from "make"'s job server (since it is not exposed in any
> special variables) and use that for the "sphinx-build" run. Now things
> work correctly for builds where -j is specified at the top-level:
> 
> 	make -j16 htmldocs
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  Documentation/Makefile  |  3 +--
>  scripts/jobserver-count | 46 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 47 insertions(+), 2 deletions(-)
>  create mode 100755 scripts/jobserver-count
> 
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index e145e4db508b..4408eeaf2891 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -33,8 +33,6 @@ ifeq ($(HAVE_SPHINX),0)
>  
>  else # HAVE_SPHINX
>  
> -export SPHINXOPTS = $(shell perl -e 'open IN,"sphinx-build --version 2>&1 |"; while (<IN>) { if (m/([\d\.]+)/) { print "-jauto" if ($$1 >= "1.7") } ;} close IN')
> -
>  # User-friendly check for pdflatex and latexmk
>  HAVE_PDFLATEX := $(shell if which $(PDFLATEX) >/dev/null 2>&1; then echo 1; else echo 0; fi)
>  HAVE_LATEXMK := $(shell if which latexmk >/dev/null 2>&1; then echo 1; else echo 0; fi)
> @@ -68,6 +66,7 @@ quiet_cmd_sphinx = SPHINX  $@ --> file://$(abspath $(BUILDDIR)/$3/$4)
>  	PYTHONDONTWRITEBYTECODE=1 \
>  	BUILDDIR=$(abspath $(BUILDDIR)) SPHINX_CONF=$(abspath $(srctree)/$(src)/$5/$(SPHINX_CONF)) \
>  	$(SPHINXBUILD) \
> +	-j $(shell $(srctree)/scripts/jobserver-count) \
>  	-b $2 \
>  	-c $(abspath $(srctree)/$(src)) \
>  	-d $(abspath $(BUILDDIR)/.doctrees/$3) \
> diff --git a/scripts/jobserver-count b/scripts/jobserver-count
> new file mode 100755
> index 000000000000..5fc9d2fd5254
> --- /dev/null
> +++ b/scripts/jobserver-count
> @@ -0,0 +1,46 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# This determines how many parallel tasks "make" is expecting, as it is
> +# not exposed via an special variables.
> +# https://www.gnu.org/software/make/manual/html_node/POSIX-Jobserver.html#POSIX-Jobserver
> +import os, sys, fcntl
> +
> +# Set non-blocking for a given file descriptor.
> +def nonblock(fd):
> +	flags = fcntl.fcntl(fd, fcntl.F_GETFL)
> +	fcntl.fcntl(fd, fcntl.F_SETFL, flags | os.O_NONBLOCK)
> +	return fd
> +


> +# Fetch the make environment options.
> +flags = os.environ.get('MAKEFLAGS', None)
> +if flags == None:
> +	print("1")
> +	sys.exit(0)
> +
> +# Look for "--jobserver=R,W"
> +opts = [x for x in flags.split(" ") if x.startswith("--jobserver")]
> +if len(opts) != 1:
> +	print("1")
> +	sys.exit(0)

Using "1" as default if -j is not specified doesn't sound a good idea. I 
mean, Sphinx is very slow without any parallelism. I would keep "auto" as
default here, if version >= 1.7 (and if there's no explicit SPHINXOPTS).


> +
> +# Parse out R,W file descriptor numbers and set them nonblocking.
> +fds = opts[0].split("=", 1)[1]
> +reader, writer = [nonblock(int(x)) for x in fds.split(",", 1)]
> +
> +# Read out as many jobserver slots as possible.
> +jobs = b""
> +while True:
> +	try:
> +		slot = os.read(reader, 1)
> +		jobs += slot
> +	except:
> +		break
> +# Return all the reserved slots.
> +os.write(writer, jobs)
> +
> +# Report available slots (with a bump for our caller's reserveration).
> +if len(jobs) < 1:
> +	print("1")
> +else:
> +	print(len(jobs) + 1)



Thanks,
Mauro
