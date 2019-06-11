Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67622C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3925A206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVwBmPNj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390143AbfFKOeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 10:34:03 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34362 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388292AbfFKOeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 10:34:02 -0400
Received: by mail-qk1-f196.google.com with SMTP id t8so4091088qkt.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 07:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x5MD+DeNQctHQznuuG5DArytM9Ulz9sKBFJ7MSffu8s=;
        b=AVwBmPNjHGeSvBMkGNNUGW05JuQYvjBtqI6CJKr6eaFYIsDIQiQmCTG+2jKpDWoD68
         mne7HsBkGQd8rXUYqisV5sa1R/fVrUu061fFTRPja2PuLYf098nwqFyhXs7iKSBQYti7
         pf5ZjU7480aVp/mI+JVUrRuVpkkp5UoWXpYqiyn359/tXACB+Mat4vOfrwiiK9+nUVEo
         MnJM6DPIg+8NwkpLQFPCOE5b0obL+u23eTNjvevZHXKdRf9o/jhzMiaxOlHCHYUu63TO
         ipwGLhoR/Ov3IXFiPIJiZzlEWXOYUU0LRwpo1wot79+ELc+u850zP9z7gGBr/ntapKgK
         MQwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x5MD+DeNQctHQznuuG5DArytM9Ulz9sKBFJ7MSffu8s=;
        b=ki7yyrPsx6r1OuFK3p2aNzss6saaxoBTat26E1Z/XzNLw7gPHhGzuX2YI6k67Rsvik
         RU11YQ2RmGLV3thOfTvdW8qZQujeD2zg7LPmY7oVG95eIAa3j3KcgLxRcADrMx3FiBZi
         JJqAWoFmgbhz2rab6LX8a4nViTI8YwfaTKpjR+9ZWftzLvSgssRUZym+T3T4XCt3XuXg
         K+D4jz4Uqf64FoL8zMzl4+krGw9hepqEZBitXZfuFApTyDpolrNIugx/xMo7StadXJ55
         e9j62JAh2Zc6Kaie1D0S+K93LstkJlljLTsjZ5qvga0cHvIVQfCNjuBY2fLWweR4LatW
         vgKg==
X-Gm-Message-State: APjAAAXyvpv/a7kQ5fKwHBhwloaGjdBwlEeCGt46hiE4v/uK3r2Sfrql
        t4Wmx2fUQiv1ntYdTLaPNWUgAmQlDzw=
X-Google-Smtp-Source: APXvYqwn1C+0v1xejCoPdR32sI+SiyR9ewFUPmckfHadbPqcPp4wEwE2mg6Zv2lXbPrdkhMOW7XldQ==
X-Received: by 2002:a05:620a:55c:: with SMTP id o28mr58031193qko.86.1560263641893;
        Tue, 11 Jun 2019 07:34:01 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id t67sm6665395qkf.34.2019.06.11.07.34.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 07:34:01 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CF8A641149; Tue, 11 Jun 2019 11:23:56 -0300 (-03)
Date:   Tue, 11 Jun 2019 11:23:56 -0300
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Raphael Gault <raphael.gault@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com
Subject: Re: [PATCH 1/7] perf: arm64: Compile tests unconditionally
Message-ID: <20190611142356.GA28689@kernel.org>
References: <20190611125315.18736-1-raphael.gault@arm.com>
 <20190611125315.18736-2-raphael.gault@arm.com>
 <20190611140907.GF29008@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611140907.GF29008@lakrids.cambridge.arm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jun 11, 2019 at 03:09:07PM +0100, Mark Rutland escreveu:
> On Tue, Jun 11, 2019 at 01:53:09PM +0100, Raphael Gault wrote:
> > In order to subsequently add more tests for the arm64 architecture
> > we compile the tests target for arm64 systematically.
> 
> Given prior questions regarding this commit, it's probably worth
> spelling things out more explicitly, e.g.
> 
>   Currently we only build the arm64/tests directory if
>   CONFIG_DWARF_UNWIND is selected, which is fine as the only test we
>   have is arm64/tests/dwarf-unwind.o.
> 
>   So that we can add more tests to the test directory, let's
>   unconditionally build the directory, but conditionally build
>   dwarf-unwind.o depending on CONFIG_DWARF_UNWIND.
> 
>   There should be no functional change as a result of this patch.
> 
> > 
> > Signed-off-by: Raphael Gault <raphael.gault@arm.com>
> 
> Either way, the patch looks good to me:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>

I'll update the comment, collect your Acked-by and apply the patch.

- Arnaldo
 
> Mark.
> 
> > ---
> >  tools/perf/arch/arm64/Build       | 2 +-
> >  tools/perf/arch/arm64/tests/Build | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/perf/arch/arm64/Build b/tools/perf/arch/arm64/Build
> > index 36222e64bbf7..a7dd46a5b678 100644
> > --- a/tools/perf/arch/arm64/Build
> > +++ b/tools/perf/arch/arm64/Build
> > @@ -1,2 +1,2 @@
> >  perf-y += util/
> > -perf-$(CONFIG_DWARF_UNWIND) += tests/
> > +perf-y += tests/
> > diff --git a/tools/perf/arch/arm64/tests/Build b/tools/perf/arch/arm64/tests/Build
> > index 41707fea74b3..a61c06bdb757 100644
> > --- a/tools/perf/arch/arm64/tests/Build
> > +++ b/tools/perf/arch/arm64/tests/Build
> > @@ -1,4 +1,4 @@
> >  perf-y += regs_load.o
> > -perf-y += dwarf-unwind.o
> > +perf-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
> >  
> >  perf-y += arch-tests.o
> > -- 
> > 2.17.1
> > 

-- 

- Arnaldo
