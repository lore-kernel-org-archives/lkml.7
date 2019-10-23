Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60BBCCA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E6332084C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mZWnG1AU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403861AbfJWJ2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 05:28:43 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46702 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390165AbfJWJ2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 05:28:42 -0400
Received: by mail-qt1-f195.google.com with SMTP id u22so31226611qtq.13
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 02:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CxQSUDAwUTJ6JBYHstQsn9c6fO37M9EWVoTly8Y7vnA=;
        b=mZWnG1AU7ZLOQ+l6FzovRfvmpodyGsRzoK7uOYGSMn8TcIhvqXE2S+FAGIkMT4uKqk
         WVwfXwnP1aBQE0LaTA5Dk70P6pYGE0RYilsXTJm1t9eLMXA+QHe6tojQwKZi6VLpabZ7
         wAK24jjV1r7CmAh6WQ10rNdCXbndROzJYepsR8kWMRAjW3vu199xK1HMAw1+no+RMAN4
         B0QJhCKJqZE86MF6prF6xYnjxLUJor6zEWnkHMw8fyfLZAH++aCHAf1gZiQmWRQOAa3c
         F+Qfi+ya+O1PGcJXuoo4Cb23WzcJVyoWuCD0/HGG3Ey7OCUQrSPghKD1Gprry6R+d7qr
         RR2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CxQSUDAwUTJ6JBYHstQsn9c6fO37M9EWVoTly8Y7vnA=;
        b=BYZYWs09LaUjvqftiS5k5G276yQfx7gJbMB5KNkyM0C97g95bxrZczlly6ufhnAKia
         siHdJipuiQxcigYBib6w/71SFzEvN0uJPfhqpd7DvxobT5RISeGreYVOtxuByBa6R5Ic
         lmlTxf1tqzLa5ooEHS5b1PKhn7tgeqimKV1B4fdJQvtdY4HLKdYVtEIPc97DpEUHfW0T
         2M4e9uLuvLz4UDrLvV/KgFTe0vxwINXxTk5X+cmAtXpIyPcoTclW3EJWT68y4A0KNppt
         ehNukrniOK26VIysjZPwaRdsDGckdya/pPqcxyBaZKko/Gobjdcjtr7Q/KFOrfWe+bT+
         xReg==
X-Gm-Message-State: APjAAAWEzWhnAXOy4i1nUoq3C8rgtmquBQwRY2kZ4npH5xDxEG80F1Cd
        vNQbBi3PF6lbBeILjgO9M6remA==
X-Google-Smtp-Source: APXvYqz6bngA7LUXUP4Y0ou2AtRLuveGpG9KhxsGpgAUMQ3ttWvZ5niWYxpJk4F8oK1e7wwLc4zkuw==
X-Received: by 2002:a0c:f313:: with SMTP id j19mr7701669qvl.137.1571822921644;
        Wed, 23 Oct 2019 02:28:41 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li937-157.members.linode.com. [45.56.119.157])
        by smtp.gmail.com with ESMTPSA id f37sm10193485qtb.65.2019.10.23.02.28.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Oct 2019 02:28:41 -0700 (PDT)
Date:   Wed, 23 Oct 2019 17:28:33 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Will Deacon <will@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tests: Fix a typo
Message-ID: <20191023092833.GE32731@leoy-ThinkPad-X240s>
References: <20191023083324.12093-1-leo.yan@linaro.org>
 <20191023091416.GB25798@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023091416.GB25798@willie-the-truck>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 10:14:17AM +0100, Will Deacon wrote:
> On Wed, Oct 23, 2019 at 04:33:24PM +0800, Leo Yan wrote:
> > Correct typo in comment: s/suck/stuck.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  tools/perf/tests/bp_signal.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/tests/bp_signal.c b/tools/perf/tests/bp_signal.c
> > index 166f411568a5..415903b48578 100644
> > --- a/tools/perf/tests/bp_signal.c
> > +++ b/tools/perf/tests/bp_signal.c
> > @@ -295,7 +295,7 @@ bool test__bp_signal_is_supported(void)
> >  	 * breakpointed instruction.
> >  	 *
> >  	 * Since arm64 has the same issue with arm for the single-step
> > -	 * handling, this case also gets suck on the breakpointed
> > +	 * handling, this case also gets stuck on the breakpointed
> >  	 * instruction.
> >  	 *
> >  	 * Just disable the test for these architectures until these
> 
> Thanks, and sorry for only spotting this after the offending patch was
> merged.

No worries and thanks for review.
