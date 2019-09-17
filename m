Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DF8C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 23:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B798C21852
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 23:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oENeR7WK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbfIQXi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 19:38:57 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39611 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728935AbfIQXi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 19:38:57 -0400
Received: by mail-pg1-f193.google.com with SMTP id u17so2846821pgi.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 16:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oVjdyjUX5iUZV3EtbJ0Ly179kIdOhporKbz0h2OirUM=;
        b=oENeR7WKl+2EticX0D08/4P/PhQrja2oLlF0Di2xjmpxTM1ZJhMZu75Kn9Y9rerVbw
         eWNcbgnbY0Q5+rdYHarsJQCbpHM56jgcEbfMdzjXkEOw4rkqoQXuXM8Qbso5WkNGIlQR
         pew2O8g2W4+/U5JrgTd+Hlxv8x0DBP2T+pGaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oVjdyjUX5iUZV3EtbJ0Ly179kIdOhporKbz0h2OirUM=;
        b=hurmjl44Lj2X7FjxQJo3+CfoNqAT+KePDMP1EzDB6be6pXZtnlER2YMN2gx3hv2kjf
         tdDCZejZyuJ3MIYVX/4ICzjZ2yRBYru66521gz2iSNydXt5yEe50wCTLcNKwPnFxBiI8
         FRbuXI5EXob6v+zH9cSmAt54EcYETB9Mi9CehPnOVA12XA96cnXtVnCLhDUUkOrTwQAO
         UYoLpRXmJqwB2RpqbGaikrzt3Yyu2BnTJ/v+gQp3+7ICNAFy9e2+1bKbaU+br9row876
         D/5SlBNRtzfHla7+QhwdYrVVFTdS7tyEEe9RIUJc5Z0s5QxvmYQELjyttJt8e0bDP3/C
         9TSA==
X-Gm-Message-State: APjAAAWwmBpKgh7vkIYb1tN9Og5mVB0Qk9r4s/e8C0+3jSUXcpcaxGNO
        2vpnsGy6kDRtofgjSGpfDtGKCA==
X-Google-Smtp-Source: APXvYqw6wRJ+vq5eAjZ+pqjPxtUeQ+3izi0cIvK15fga5L4ApFaMmgP7F/m1Adv3tDvwvrLnGySoqA==
X-Received: by 2002:a62:7d8c:: with SMTP id y134mr986146pfc.257.1568763536265;
        Tue, 17 Sep 2019 16:38:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e184sm7449696pfa.87.2019.09.17.16.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 16:38:55 -0700 (PDT)
Date:   Tue, 17 Sep 2019 16:38:54 -0700
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
Subject: Re: treewide replacement of fallthrough comments with "fallthrough"
 macro (was Re: [RFC PATCH] compiler_attributes.h: Add 'fallthrough' pseudo
 keyword for switch/case use)
Message-ID: <201909171638.A05CD47@keescook>
References: <e0dd3af448e38e342c1ac6e7c0c802696eb77fd6.1564549413.git.joe@perches.com>
 <1d2830aadbe9d8151728a7df5b88528fc72a0095.1564549413.git.joe@perches.com>
 <20190731171429.GA24222@amd>
 <ccc7fa72d0f83ddd62067092b105bd801479004b.camel@perches.com>
 <765E740C-4259-4835-A58D-432006628BAC@zytor.com>
 <20190731184832.GZ31381@hirez.programming.kicks-ass.net>
 <201907311301.EC1D84F@keescook>
 <201908151049.809B9AFBA9@keescook>
 <201909161516.A68C8239A@keescook>
 <45dd0d8dffa6718d8cbcd24720e9e39dddb08134.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45dd0d8dffa6718d8cbcd24720e9e39dddb08134.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 03:26:32PM -0700, Joe Perches wrote:
> On Mon, 2019-09-16 at 15:19 -0700, Kees Cook wrote:
> > On Thu, Aug 15, 2019 at 11:15:53AM -0700, Kees Cook wrote:
> > > With that out of the way, yes, let's do a mass conversion. As mentioned
> > > before, I think "fallthrough;" should be used here (to match "break;").
> > > Let's fork the C language. :)
> > 
> > FWIW, last week I asked Linus at the maintainer's summit which he
> > preferred ("__fallthrough" or "fallthrough") and he said "fallthrough".
> 
> Nice.  I think that's better style/taste.
> 
> > Joe, if you've still got the series ready, do you want to send it for
> > this merge window before -rc1 gets cut?
> 
> The first bits that add fallthrough and converts the one existing
> use of fallthrough as a label can be sent now.  I'll do that in
> a few days as I'm not able to do that right now.

Okay, sounds good.

> Sending any actual comment conversion patches before -rc1 might
> require changes in already queued up and tested patches
> 
> I do think a scripted conversion by major subsystem/directory
> might be a better mechanism than individual patches, especially
> if applied directly before releasing what will be -rc1.

Yeah, as long as we've got the infrastructure in place, the scripted
conversion can land whenever is easiest.

Thanks!

-- 
Kees Cook
