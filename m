Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5991EC28CC3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3373B24D92
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfFDILX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 04:11:23 -0400
Received: from mga18.intel.com ([134.134.136.126]:26955 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726828AbfFDILX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 04:11:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jun 2019 01:11:21 -0700
X-ExtLoop1: 1
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.150])
  by fmsmga001.fm.intel.com with ESMTP; 04 Jun 2019 01:11:20 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 09/10] docs: by default, build docs a lot faster with Sphinx >= 1.7
In-Reply-To: <46c958ec4e460f138c0d087bdff40ec60d060b83.1559170790.git.mchehab+samsung@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <cover.1559170790.git.mchehab+samsung@kernel.org> <46c958ec4e460f138c0d087bdff40ec60d060b83.1559170790.git.mchehab+samsung@kernel.org>
Date:   Tue, 04 Jun 2019 11:14:27 +0300
Message-ID: <877ea14vj0.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 May 2019, Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
> Since Sphinx version 1.7, it is possible to use "-jauto" in
> order to speedup documentation builds. On older versions,
> while -j was already supported, one would need to set the
> number of threads manually.
>
> So, if SPHINXOPTS is not provided, add -jauto, in order to
> speed up the build. That makes it *a lot* times faster than
> without -j.
>
> If one really wants to slow things down, it can just use:
>
> 	make SPHINXOPTS=-j1 htmldocs
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  Documentation/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 380e24053d6f..794233d05789 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -28,6 +28,8 @@ ifeq ($(HAVE_SPHINX),0)
>  
>  else # HAVE_SPHINX
>  
> +SPHINXOPTS = $(shell perl -e 'open IN,"sphinx-build --version |"; while (<IN>) { if (m/([\d\.]+)/) { print "-jauto" if ($$1 >= "1.7") } ;} close IN')
> +

Setting SPHINXOPTS like this means you can't pass additional Sphinx
options without also dropping -jauto. Which means whenever you want to
use SPHINXOPTS for what it's meant for, you also need to provide -jauto
to get the same result.

BR,
Jani.

>  # User-friendly check for pdflatex and latexmk
>  HAVE_PDFLATEX := $(shell if which $(PDFLATEX) >/dev/null 2>&1; then echo 1; else echo 0; fi)
>  HAVE_LATEXMK := $(shell if which latexmk >/dev/null 2>&1; then echo 1; else echo 0; fi)

-- 
Jani Nikula, Intel Open Source Graphics Center
