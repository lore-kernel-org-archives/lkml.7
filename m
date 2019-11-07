Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22EE8C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E952F2187F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tPW66xsu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388808AbfKGNfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 08:35:17 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:36621 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbfKGNfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:35:17 -0500
Received: by mail-yb1-f196.google.com with SMTP id v17so928675ybs.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 05:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QsMx/Rzi9jt1CVd6i1Bxf3rbgQgAbHydGZouy+SYvww=;
        b=tPW66xsu1HWtLQdDzyNzHf0Wvlz0PNeThuxTCTYCe/JCb2vJQODRh8bWiZxGvn0Bt7
         LR7RdcPYIl1IUVS7epNqoCYV6CawmyNvXhV5mWRlZb13fv/LMYw6lBxqpy3gsYa74EnW
         0CWgdv/tvmdLrtq7/LERynoczFTBnpBddzZWuE96ELBU7OTbOyVq/VglbK+56Lc28ipm
         riWsDYp+rI9MGDc/36Dp2igeGLAjnQbQbiqsupzN+RgO6bQpMk4K3nIM+5rnYCGoJRLQ
         dNJ66epfzFso3O9SJII3x7iUP6w2j4d6TRTqg2PtabNgy4FLbUKJsJe3wNxoGnyUUgw/
         FdBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QsMx/Rzi9jt1CVd6i1Bxf3rbgQgAbHydGZouy+SYvww=;
        b=ebwzWZll8sgKqupy5I0Lb4/ycI/pfT3+rJJ9nMPcajwSpJ58cEvCjD1s/tomS82dBI
         o9t65dwazmot9m9UUJUjurYgRa4Pxg4la0VNPun6LeutYqx3rH+ekn0EW3svxTxtCVAx
         6fMjcB9iDZ5lUX7KvPdVd5OJXDWEVSPaP9neJtYF48d49F0Us07bEUYUl24gFMMCEOJF
         AF/5ydo9mY1C791MMUF63XCK8ly95bK1iJGmEOLGFPNFilLF7oPiSr3hPhrhksfobwsN
         +QgqSE7u8JkVNDSFX7Xo6HNh4l9f53Yk8X7R9KbfTwfQjiWELHEgZfDl0MmBq9sWycSf
         aQxw==
X-Gm-Message-State: APjAAAWyeisY8QXMSKau+UL0+xRubMdEdthSa9g09eArOOdYBudw+I9p
        ZxlKGoduh1pNbbChb0/fDZ3Xyg==
X-Google-Smtp-Source: APXvYqyUDueymjzEPxzynAM7zH6Jz5qHc+1TKzX+yHSQqqN7N0Ju7np6Jl4Q/s0+wlvc1ZfcY3UaQw==
X-Received: by 2002:a25:b704:: with SMTP id t4mr3209953ybj.281.1573133716218;
        Thu, 07 Nov 2019 05:35:16 -0800 (PST)
Received: from leoy-ThinkPad-X240s (li1038-30.members.linode.com. [45.33.96.30])
        by smtp.gmail.com with ESMTPSA id p126sm733804ywc.16.2019.11.07.05.35.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Nov 2019 05:35:15 -0800 (PST)
Date:   Thu, 7 Nov 2019 21:35:07 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH v2] perf tests: Fix out of bounds memory access
Message-ID: <20191107133507.GB32679@leoy-ThinkPad-X240s>
References: <20191107020244.2427-1-leo.yan@linaro.org>
 <20191107094226.GC14657@krava>
 <20191107102029.GA32679@leoy-ThinkPad-X240s>
 <20191107120643.GA11372@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107120643.GA11372@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 09:06:43AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Nov 07, 2019 at 06:20:29PM +0800, Leo Yan escreveu:
> > On Thu, Nov 07, 2019 at 10:42:26AM +0100, Jiri Olsa wrote:
>  
> > [...]
>  
> > > > To fix this issue, we will use evlist__open() and evlist__close() pair
> > > > functions to prepare and cleanup context for evlist; so 'evsel->id' and
> > > > 'evsel->ids' can be initialized properly when invoke do_test() and avoid
> > > > the out of bounds memory access.
>  
> > > right, we need to solve this on libperf level, so it's possible
> > > to call mmap/munmap multiple time without close/open.. I'll try
> > > to send something, but meanwhile this is good workaround
> > > 
> > > Reviewed-by: Jiri Olsa <jolsa@kernel.org>
>  
> > Thanks for reviewing, Jiri.
>  
> > You are welcome to send us the fixing patches, I am glad to test it on
> > qemu_arm.
> 
> Thanks, applied after adding:
> 
> Fixes: ee74701ed8ad ("perf tests: Add test to check backward ring buffer")
> Cc: stable@vger.kernel.org # v4.10+
> 
> Please consider doing it next time,

Thanks a lot for helping to add 'Fixes' tag, Arnaldo.

Will note this for later patches.

Thanks,
Leo Yan
