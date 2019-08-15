Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F42C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 22:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB47D206C1
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 22:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E9uVc3iP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733088AbfHOWba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 18:31:30 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35489 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728861AbfHOWba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 18:31:30 -0400
Received: by mail-pg1-f193.google.com with SMTP id n4so1938416pgv.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 15:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7Ds0h1FP0bEgRj2xqqDvmLUZg/XyAVILJjOYQC+kx/s=;
        b=E9uVc3iPa0qz5N5StTnHPAFEPpJeYe7gXMF2B36UCHogMYyWsSbfD0+7W4J/YkG6K8
         fdCEcLiWwTaEvD+t4DC6yVIFiOO3rsJDqJiR+PX+3AbENbO1MPCzBtE3SK63sVl/P2JO
         9jSmyHGs8JOZArcxdthVT7gUCtpG8VoPbBjig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7Ds0h1FP0bEgRj2xqqDvmLUZg/XyAVILJjOYQC+kx/s=;
        b=CXNS8mw1UTCfROfC48wfo2yQ6ylXzLDNrC8Mn+SMeUEJvqheCSychYYY8HO6KHo9ck
         6afOy3I9wT0LKXTjDrUcPQztksGzhA4e8GL1uvIKxt1n2A9XRtk5apEfgZ62b0608QIu
         rIFWFPJrtITmdtLVtqjjeFtpKbrXhSFIWIKjam/CVihKCrbhYroPD8jEwSBQ8WiUEhGE
         OZnyhCp8NCnyBRDW0DysXFGv0BbpkKS8XFSBrK2u9QyNJ50ivSuUo0ay8cpQGHZWYYQ5
         Duf/CDAl/GnqHXjePZ3zNdiIuQaMrxJeKKpCHcHZDS/yOn1JltZH9fvvb18tKQzKLbY3
         W6kQ==
X-Gm-Message-State: APjAAAVNsUzlnxQZNMAr2+SAMSZTOYEl2YLRvDmhRgOb+SPW7xhcoCkm
        5Jfc22ASMeOAMdviz4IaO0PIvQ==
X-Google-Smtp-Source: APXvYqyVrT6W+ijiPawxCGqxDfkC1EwU/6edenQf8Or9qPivlqdJEkA1rFY43ONK+WAdSHwCx61icA==
X-Received: by 2002:a17:90b:911:: with SMTP id bo17mr4047836pjb.40.1565908289602;
        Thu, 15 Aug 2019 15:31:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p20sm3338967pgj.47.2019.08.15.15.31.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Aug 2019 15:31:28 -0700 (PDT)
Date:   Thu, 15 Aug 2019 15:31:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joe Perches <joe@perches.com>
Cc:     hpa@zytor.com, Peter Zijlstra <peterz@infradead.org>,
        Pavel Machek <pavel@ucw.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Shawn Landden <shawn@git.icu>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] compiler_attributes.h: Add 'fallthrough' pseudo
 keyword for switch/case use
Message-ID: <201908151530.D4B1EF76AA@keescook>
References: <e0dd3af448e38e342c1ac6e7c0c802696eb77fd6.1564549413.git.joe@perches.com>
 <1d2830aadbe9d8151728a7df5b88528fc72a0095.1564549413.git.joe@perches.com>
 <20190731171429.GA24222@amd>
 <ccc7fa72d0f83ddd62067092b105bd801479004b.camel@perches.com>
 <765E740C-4259-4835-A58D-432006628BAC@zytor.com>
 <20190731184832.GZ31381@hirez.programming.kicks-ass.net>
 <201907311301.EC1D84F@keescook>
 <201908151049.809B9AFBA9@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201908151049.809B9AFBA9@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 11:15:53AM -0700, Kees Cook wrote:
> I want to recant my position on Coverity coverage being a requirement
> here. While I was originally concerned about suddenly adding thousands
> more warnings to Coverity scans (if it doesn't support the flag --
> I should know soon), it's been made clear to me we're now at the point

For the record, Coverity *does*[1] support the attribute flag.

-Kees

[1] This should be visible with a Coverity account:
    https://scan3.coverity.com/reports.htm#v39370/p12360/fileInstanceId=27181923&defectInstanceId=7915635&mergedDefectId=220491

-- 
Kees Cook
