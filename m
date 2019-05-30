Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBBCC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 19:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1C512605B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 19:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ky6dub8Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfE3TAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 15:00:45 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:38454 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbfE3TAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 15:00:44 -0400
Received: by mail-it1-f195.google.com with SMTP id i63so6883783ita.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 12:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g0Bpz5g3wFYP+gFqu/rKlcFZijNC01hWKfryp13lVZg=;
        b=Ky6dub8QT52Rk0/nNqKV5C0hm/w/refBURtacKKAHngq2xoZ7WwVxHRdeC64kDIFdZ
         iquNVWvagd8VLvpGxnwIuugblubUXipLgChUYQn06i62bdbrWXM7Jq3kDNBMVE5qJvNP
         dF/U/SUceJpCYhXyAejmqRczACmE6f+Wx5S15Jl30pJUkLqFuh9iYUMLMDOeohZCw5kX
         e0ugIo2TT2lql+JHsJ/9c9WFHic9OcpLCqLjt2cAW7KAEaYXgBKnpxCCCSXJeivoE7g9
         +6LLI7mRZF7WLo3E5q5xz3XHZEo63zFta0tlRxmuiGhEjd5YiJ7T1TyzrwReBAOyLCsV
         VRpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g0Bpz5g3wFYP+gFqu/rKlcFZijNC01hWKfryp13lVZg=;
        b=DcbVuQjb3lHATwQkuLc7mHWQFMpci0igVsGKnzCt3kYAEFB5VSswfjxHtsOs2rtZBa
         a1g49JWtjwG3MMBpBxNYMTIQomncnObFAufvs6kmpSLM2AvpVsdu5GzRT6MVjdJq4FuB
         4hHzdbYsz/JfebHYmR6ebx7LMYNNfYXS8Acr9Ud9WVmVDeGw8s1837RTJDhIGI0ZR0ca
         3cs31LGWS2kXNEIKEj0vana4te/CXjAi7B3whNPsjMlyNRTrJ53KIRPOHu6d51mzqLdN
         Y9dHzkc2y0k2sinZOHydbDD6k+rpTQdGgm9mX8I/wfQhHh+IVwEtYMdqccn4hv11+RLb
         HX1g==
X-Gm-Message-State: APjAAAXvRPzsHlkonGvSPAK/BgzkThKSV9suVczwYnv2FoqbMqPJTJp/
        4o55GH/2/ds1LZlYBkoOti6OVg==
X-Google-Smtp-Source: APXvYqyKXl2q2RSNBQnP6EwLTaHXV0/ufh3qXiNoV187B71OoVq7DmrXop5Gem4wTHVd/C4cxsGYMw==
X-Received: by 2002:a24:c8c2:: with SMTP id w185mr3850842itf.149.1559242843573;
        Thu, 30 May 2019 12:00:43 -0700 (PDT)
Received: from localhost (c-75-72-120-115.hsd1.mn.comcast.net. [75.72.120.115])
        by smtp.gmail.com with ESMTPSA id x20sm1146240ioa.40.2019.05.30.12.00.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 May 2019 12:00:42 -0700 (PDT)
Date:   Thu, 30 May 2019 14:00:41 -0500
From:   Dan Rue <dan.rue@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kselftest@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: teach kselftest-merge to find nested config files
Message-ID: <20190530190041.m6535ihflbgr2q3m@xps.therub.org>
References: <20190520151614.19188-1-dan.rue@linaro.org>
 <20190520175641.GA14339@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520175641.GA14339@kroah.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 07:56:41PM +0200, Greg KH wrote:
> On Mon, May 20, 2019 at 10:16:14AM -0500, Dan Rue wrote:
> > Current implementation of kselftest-merge only finds config files that
> > are one level deep using `$(srctree)/tools/testing/selftests/*/config`.
> > 
> > Often, config files are added in nested directories, and do not get
> > picked up by kselftest-merge.
> > 
> > Use `find` to catch all config files under
> > `$(srctree)/tools/testing/selftests` instead.
> > 
> > Signed-off-by: Dan Rue <dan.rue@linaro.org>
> > ---
> >  Makefile | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> To be more specific here, the binderfs test is not catching the config
> entry, so it would be nice to get this into the stable trees as well :)
> 
> > diff --git a/Makefile b/Makefile
> > index a45f84a7e811..e99e7f9484af 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1228,9 +1228,8 @@ kselftest-clean:
> >  PHONY += kselftest-merge
> >  kselftest-merge:
> >  	$(if $(wildcard $(objtree)/.config),, $(error No .config exists, config your kernel first!))
> > -	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/kconfig/merge_config.sh \
> > -		-m $(objtree)/.config \
> > -		$(srctree)/tools/testing/selftests/*/config
> > +	$(Q)find $(srctree)/tools/testing/selftests -name config | \
> > +		xargs $(srctree)/scripts/kconfig/merge_config.sh -m $(objtree)/.config
> >  	+$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
> >  
> >  # ---------------------------------------------------------------------------
> 
> is find run with $(Q)?  It isn't with other instances in the Makefile.

I'm not entirely sure all the ways that $(Q) is used (it looks like it
just gets set to @), but if i run 'KBUILD_VERBOSE=1 make
kselftest-merge' I do see the find command printed before running:

    find ./tools/testing/selftests -name config | \
          xargs ./scripts/kconfig/merge_config.sh -m ./.config

I noticed find used inconsistently (sometimes with @, sometimes with
$(Q), sometimes with neither), so I picked the usage that seemed most
correct to me.

Dan

> 
> thanks,
> 
> greg k-h

-- 
Linaro - Kernel Validation
