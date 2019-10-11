Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D8B2C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 22:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5210A2084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 22:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AUmbSlE2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729369AbfJKWIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 18:08:04 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39780 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729269AbfJKWID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 18:08:03 -0400
Received: by mail-pg1-f196.google.com with SMTP id e1so6546881pgj.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 15:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=u657WMybRKGf4iTEdbvgPKUQHMvQCoMqXMiRc7mnyNw=;
        b=AUmbSlE2jrKfmGq51Nnu0DTKILtSqFr/lgvJE3gHd/UhnFDMR4LvhUquwiYY4yI1UG
         GQjwC95tlThgfHSDmX5isdgd8rfRVIVuXg8LM5+EKX3RU75Tm86erjWm8b7IPX1aL+fQ
         PhW9UWXV+kPuuyJxGmEnU4tHZfDaLYbNp5Gws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u657WMybRKGf4iTEdbvgPKUQHMvQCoMqXMiRc7mnyNw=;
        b=nlEYYOGAYbUZkc09YRgkEr6RJJsoHWzUhrzaQ/SHTbwB0D8UtYJh6CmHLR2Oh8RHjF
         CgTzPt9HwlSvim+MXg/ZpJPhk4p+Z0FMfjCEZFM/1jHDcxQtf29bBPHvxYGf2+RQDNi0
         MTH144jj4hRk6sAroLkRJuhoLHVe9/j22f6tVywzJ3QTxNOmZCRmHvFBa21VomRLGrFl
         EYDvTc10XVtAGRQbHmsJDG6M5srQUxm7fizhYcu1GoBXnvB9YqRFP+WmrtOwwVMO2Mmn
         WwOyav7g8V+N+dlgpfX63wDTJG4h7xdUTIL95BP3PfF+qQFnVDG6q3lsd+pwttysDWHo
         gM2g==
X-Gm-Message-State: APjAAAX0Kd3jPf7Zk5tpWEawwNrvnGTiYQC9uCbwALMgc0/HgFlK7i/H
        Bv5R+Ok5CEP8j+Huf88t2O1taQ==
X-Google-Smtp-Source: APXvYqwXd6PES+m6U0qYX3W5eqwpAP4ETGleW9x3CN4Ko02h7XpIW9CP+aqFM6d6plqqgwrB+0MgxQ==
X-Received: by 2002:aa7:956a:: with SMTP id x10mr18500783pfq.220.1570831680868;
        Fri, 11 Oct 2019 15:08:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p66sm10301368pfg.127.2019.10.11.15.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 15:07:59 -0700 (PDT)
Date:   Fri, 11 Oct 2019 15:07:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Joe Perches <joe@perches.com>, linux-sctp@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Pavel Machek <pavel@ucw.cz>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Shawn Landden <shawn@git.icu>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH 0/4] treewide: Add 'fallthrough' pseudo-keyword
Message-ID: <201910111506.45AE850D5@keescook>
References: <cover.1570292505.git.joe@perches.com>
 <CAHk-=whOF8heTGz5tfzYUBp_UQQzSWNJ_50M7-ECXkfFRDQWFA@mail.gmail.com>
 <CANiq72kDNT6iPxYYNzY_eb3ddWNUEzgg48pOenEBrJXynxsvoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72kDNT6iPxYYNzY_eb3ddWNUEzgg48pOenEBrJXynxsvoA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 08:01:42PM +0200, Miguel Ojeda wrote:
> Hi Linus,
> 
> On Fri, Oct 11, 2019 at 6:30 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Sat, Oct 5, 2019 at 9:46 AM Joe Perches <joe@perches.com> wrote:
> > >
> > > Add 'fallthrough' pseudo-keyword to enable the removal of comments
> > > like '/* fallthrough */'.
> >
> > I applied patches 1-3 to my tree just to make it easier for people to
> > start doing this. Maybe some people want to do the conversion on their
> > own subsystem rather than with a global script, but even if not, this
> > looks better as a "prepare for the future" series and I feel that if
> > we're doing the "fallthrough" thing eventually, the sooner we do the
> > prepwork the better.
> >
> > I'm a tiny bit worried that the actual conversion is just going to
> > cause lots of pain for the stable people, but I'll not worry about it
> > _too_ much. If the stable people decide that it's too painful for them
> > to deal with the comment vs keyword model, they may want to backport
> > these three patches too.
> 
> I was waiting for a v2 series to pick it up given we had some pending changes...

Hmpf, looks like it's in torvalds/master now. Miguel, most of the changes
were related to the commit log, IIRC, so that ship has sailed. :( Can the
stuff in Documentation/ be improved with a follow-up patch, perhaps?

-- 
Kees Cook
