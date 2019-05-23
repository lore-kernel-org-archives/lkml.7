Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A9BC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F9CC2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729967AbfEWJjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 05:39:48 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55697 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbfEWJjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 05:39:48 -0400
Received: by mail-wm1-f68.google.com with SMTP id x64so5058465wmb.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 02:39:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RVoTZI0VRMg+nPdOPovGlKy5LJCeLlG3SsniOFmKBhQ=;
        b=tDLXEu4cwTDtEczp6gHe8ukg0oxM6a7SnMvE6l8GC0D8eBDuoiAIdTvYe4Dn0Z+jQ7
         mqTalwhIUnRLA4rCTYWN/p02amJ5qTZEvCwxuO5c8D9qFB2iwqOLfz+GUlLEd0l2xC+5
         4agPu+fTPezRmm9pLfOXfl/KMkovfbm/53mckxapy/cnep06nMPwggMNAwKgYJNYcgdK
         kiWBN1vVP4mI7OKezXdTkyMZ3fBiEeE1m2xSza+SOyBzT/4Md5dNNdNTaeCJh3/TnQo1
         aZpc5SCsRhWJVMFwudD3M/+4+uvcrRRgev4zzoDPfm/soZ8GS1jg7fpZuWiolFcXSGH1
         +P8w==
X-Gm-Message-State: APjAAAWeVEm0QZLcnILVUFaytnrQ8trBOvxNp22lEFulv7M9mY0fCScn
        +kCjX6YDe1EpPjaLq1rKcbjrcw==
X-Google-Smtp-Source: APXvYqyjs8AD7KkpFujHc3SACxkZ1LuWBIrqzz8g3Q40GlsnRtOnw7+MtaBSQH3a1/0iXGYAUQbIVA==
X-Received: by 2002:a1c:e386:: with SMTP id a128mr11292003wmh.69.1558604386088;
        Thu, 23 May 2019 02:39:46 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id j9sm33852313wrr.90.2019.05.23.02.39.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 02:39:45 -0700 (PDT)
Date:   Thu, 23 May 2019 11:39:44 +0200
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Markus Heiser <markus.heiser@darmarit.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH 0/8] docs: Fixes for recent versions of Sphinx
Message-ID: <20190523093944.mylk5l3ginkpelfi@butterfly.localdomain>
References: <20190522205034.25724-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522205034.25724-1-corbet@lwn.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, May 22, 2019 at 02:50:26PM -0600, Jonathan Corbet wrote:
> The Sphinx folks deprecated some interfaces in the 2.0 release; one
> immediate result of that is a bunch of warnings that show up when building
> with 1.8.  These two patches make those warnings go away, but at a cost:
> 
>  - It introduces a couple of Sphinx version checks, which are always
>    ugly, but the alternative would be to stop supporting versions
>    before 1.7.  For now, I think we can carry that cruft.
> 
>  - The second patch causes the build to fail horribly on newer
>    Sphinx installations.  The change to switch_source_input() seems
>    to make the parser much more finicky, increasing warnings and
>    eventually failing the build altogether.  In particular, it will
>    scream about problems in .rst files that are not included in the
>    TOC tree at all.
> 
> This version of the patch set fixes up the worst problems (the i915 error
> in particular, which breaks the build hard).  I've tested it with versions
> 1.4, 1.8, and 2.0.
> 
> Given that these problems are already breaking builds on some systems, I
> think I may try to sell these changes to Linus for 5.2 still.
> 
> Changes since v1:
>   - Fix up a couple of logging changes I somehow missed
>   - Don't save state when using switch_source_input()
>   - Fix a few build errors
>   - Add Mauro's sphinx-pre-install improvements
> 
> Jonathan Corbet (7):
>   doc: Cope with Sphinx logging deprecations
>   doc: Cope with the deprecation of AutoReporter
>   docs: fix numaperf.rst and add it to the doc tree
>   lib/list_sort: fix kerneldoc build error
>   docs: fix multiple doc build warnings in enumeration.rst
>   docs/gpu: fix a documentation build break in i915.rst
>   docs: Fix conf.py for Sphinx 2.0
> 
> Mauro Carvalho Chehab (1):
>   scripts/sphinx-pre-install: make it handle Sphinx versions
> 
>  Documentation/admin-guide/mm/index.rst        |  1 +
>  Documentation/admin-guide/mm/numaperf.rst     |  2 +-
>  Documentation/conf.py                         |  2 +-
>  .../firmware-guide/acpi/enumeration.rst       |  2 +-
>  Documentation/gpu/i915.rst                    |  4 +-
>  Documentation/sphinx/kerneldoc.py             | 44 +++++++---
>  Documentation/sphinx/kernellog.py             | 28 +++++++
>  Documentation/sphinx/kfigure.py               | 40 +++++----
>  lib/list_sort.c                               |  3 +-
>  scripts/sphinx-pre-install                    | 81 +++++++++++++++++--
>  10 files changed, 166 insertions(+), 41 deletions(-)
>  create mode 100644 Documentation/sphinx/kernellog.py
> 
> -- 
> 2.21.0
> 

Thanks for the efforts. I've run this on top of Linus' tree, and the
only sphinx-related deprecation warning I've spotted is this one:

/home/onatalen/work/src/linux/Documentation/sphinx/cdomain.py:51: RemovedInSphinx30Warning: app.override_domain() is deprecated. Use app.add_domain() with override option instead.
  app.override_domain(CDomain)

Otherwise, it builds.

-- 
  Best regards,
    Oleksandr Natalenko (post-factum)
    Senior Software Maintenance Engineer
