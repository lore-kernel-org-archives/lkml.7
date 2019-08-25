Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4EEC3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 14:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D54320870
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 14:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ve6BQxor"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbfHYOdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 10:33:06 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43456 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728436AbfHYOdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 10:33:06 -0400
Received: by mail-qt1-f196.google.com with SMTP id b11so15577699qtp.10
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2019 07:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OZqyEDU3Oz8mczhnGZvbQocZ4/Kspt/0e7wlQ0xGyGs=;
        b=ve6BQxorZMQhe7qGP3tXO9NgI36xtGkyBTjPS/KsUnr3dwTDCW6lJQsss4Ai3w8j2n
         czV4tm4bZ4Fn02349FuP7TlEK4UJGpRq9pBpo1ppj/+3GYkXGcrErT16adUHvl79WaNc
         PPSYGN4q+0ZJqd3MM5O8pE9ARcuhh0TfQbFTKbXuXRvEUK1cIL15fLmy093ibbB5iBHH
         zc6NDHX3rl3e2U5+TP6S+BS805q/3+gz+3e5g7FqK1zGhqg49nFZTfl/03iKt7gL6fmx
         GuC1iw2CQGW7AYGe9VQ2OAlbpgXhjP8j8ypcxaT7nlD91IXe7AIxVsot8gR1L07cbcd+
         h9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OZqyEDU3Oz8mczhnGZvbQocZ4/Kspt/0e7wlQ0xGyGs=;
        b=iACh66tR/OKHk5jMV2+kwQGMQgLhC0cs3lfWC/vqmMYxJIBzMrRkXRdePHJ9GeJTij
         eIg1BgDY8pA2g9d/JqIfBL4Moy8jDhfEIp/nl/SukQwjYrxvlRKkQ05aN2knvLLcfa3T
         S9UnsVbYx+svj5rrAG9gZtQk515sIOIbg61HnhWqmAd6t/XzVje5tyNn2QZ/6OrEKIlL
         ZOeZP98vj5uRfLTVZ+lpRHnNYg7SRpkU90QpishV7s1A4Od8AtxHyYuTcOLv2Ki7l0Is
         rOtRik7htg62Egv8WWfJ/DuHXhWtbHWTWcH+W1mvWjjluuEJkAQu1NcD7ilVBKMmyckB
         0/fw==
X-Gm-Message-State: APjAAAV1gCE8EpNtjt439wbxd4dsBW3Rgk+O7cbOjlhCqTFxO+9ZJamh
        9P7kCPdviejuS531kpkchrs=
X-Google-Smtp-Source: APXvYqzHXhIaKa7C6EyWaFJVwb6a1CccQLlySREXt/UBuBZPm+I9g6rQPvo5YOR0dX1jtKE4oUjSww==
X-Received: by 2002:a0c:f150:: with SMTP id y16mr11663254qvl.220.1566743585293;
        Sun, 25 Aug 2019 07:33:05 -0700 (PDT)
Received: from quaco.ghostprotocols.net (user.186-235-140-211.acesso10.net.br. [186.235.140.211])
        by smtp.gmail.com with ESMTPSA id p38sm7618846qtc.76.2019.08.25.07.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2019 07:33:04 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4A7C040340; Sun, 25 Aug 2019 11:33:02 -0300 (-03)
Date:   Sun, 25 Aug 2019 11:33:02 -0300
To:     Vince Weaver <vincent.weaver@maine.edu>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [patch] perf tool buffer overflow in perf_header__read_build_ids
Message-ID: <20190825143302.GE26569@kernel.org>
References: <alpine.DEB.2.21.1907231100440.14532@macbook-air>
 <alpine.DEB.2.21.1907231639120.14532@macbook-air>
 <20190726190541.GC20482@kernel.org>
 <alpine.DEB.2.21.1908231641170.7106@macbook-air>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1908231641170.7106@macbook-air>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Aug 23, 2019 at 04:42:47PM -0400, Vince Weaver escreveu:
> On Fri, 26 Jul 2019, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Jul 23, 2019 at 04:42:30PM -0400, Vince Weaver escreveu:
> > > my perf_tool_fuzzer has found another issue, this one a buffer overflow
> > > in perf_header__read_build_ids.  The build id filename is read in with a 
> > > filename length read from the perf.data file, but this can be longer than
> > > PATH_MAX which will smash the stack.
> > > 
> > > This might not be the right fix, not sure if filename should be NUL
> > > terminated or not.
> > > 
> > > Signed-off-by: Vince Weaver <vincent.weaver@maine.edu>
> > > 
> > > diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> > > index c24db7f4909c..9a893a26e678 100644
> > > --- a/tools/perf/util/header.c
> > > +++ b/tools/perf/util/header.c
> > > @@ -2001,6 +2001,9 @@ static int perf_header__read_build_ids(struct perf_header *header,
> > >  			perf_event_header__bswap(&bev.header);
> > >  
> > >  		len = bev.header.size - sizeof(bev);
> > > +
> > > +		if (len>PATH_MAX) len=PATH_MAX;
> > > +
> > 
> > Humm, I wonder if we shouldn't just declare the whole file invalid like
> > you did with the previous patch?

> > >  		if (readn(input, filename, len) != len)
> > >  			goto out;
> > >  		/*
>  
> did we ever decide how to fix this issue?  Or were you waiting on a 
> followup patch from me?

Fell thru the cracks, but yeah, I was waiting for a patch, can you send
it?

- Arnaldo
 
> This is actually an exploitable security bug if you can convince someone 
> to run "perf" on an untrusted perf.data file.

Indeed, and in light of the current discussion about unprivileged eBPF I
think we should start dropping privileges in perf report, etc.

- Arnaldo
