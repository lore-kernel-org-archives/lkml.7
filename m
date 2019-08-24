Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=3.0 tests=DATE_IN_PAST_96_XX,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F3FC41514
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 17:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A44522CF8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 17:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oIGNA7ze"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbfH1Rgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 13:36:51 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41801 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbfH1Rgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 13:36:35 -0400
Received: by mail-pg1-f195.google.com with SMTP id x15so96160pgg.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 10:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=H81+yOfZIX+C0OkVOiTOPB8MS8Z/VXRjW2hNsAZ0BmE=;
        b=oIGNA7zeFP/zFnPe/cIum5wdjPrHvoMLsfeTliBiOVxQYlyCXaPqnO3SHVa89WISFB
         80JplJgciW454D9Z5TpezYCuRwcCCHqoHVN2S8lFPm9/skVtCQGYrHlFREHLOshNCxWz
         iyelp2X12cknm0AIsjcusjnLaLUZp55DKAKHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H81+yOfZIX+C0OkVOiTOPB8MS8Z/VXRjW2hNsAZ0BmE=;
        b=YemyCwOr7iE2h8qVBRKkpVgCuYJn4imcHBlzX+7+lQ2KN9MAMgTtOuQMRLn6XQG150
         WAKC6IXi1t+7WrQAeBDJbeTOcbdE8jC6SKDoaLVDm2I6lAXHR4Xrn8ql65qCGITQtnff
         Rj6z43YfbcHuzwBLwpqvNYA5Z+LbOLnZwdBlMju+yd5vWULIimX2NKekgHqIyaP72VSD
         4pVh/NiejBN8D+gmUsrGBxQ3uH3e7ySjR9o2iCdifJmCA4Vq3NdjgweaVTapIBVgLkPV
         DzE4/r9gaIZ6m9HlXxh0Da2WVcNJEJJKs5wMpJm/pkRzqz10HhrCOCWHlIrQDmxD7qrC
         xcXg==
X-Gm-Message-State: APjAAAWvSse8ep8Q4tzU5wsNi5ojGUDGXnUKT07gDS0TzorspB9BH7mw
        dn7NYPMKKHke4vMWs+Fod9YS9w==
X-Google-Smtp-Source: APXvYqwfqL1fQunyEe0XwF9IhDZjen+nYUd1RNXPbNXfQoln/hNXyPNFYH0ug0RuWImFxCqV0CT8eA==
X-Received: by 2002:a63:7e1d:: with SMTP id z29mr4479374pgc.346.1567013794108;
        Wed, 28 Aug 2019 10:36:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k25sm3212318pgt.53.2019.08.28.10.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 10:36:29 -0700 (PDT)
Date:   Sat, 24 Aug 2019 10:17:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Drew Davenport <ddavenport@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, Feng Tang <feng.tang@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        YueHaibing <yuehaibing@huawei.com>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] bug: Move WARN_ON() "cut here" into exception handler
Message-ID: <201908241016.9DCD43AF1@keescook>
References: <20190819234111.9019-1-keescook@chromium.org>
 <20190819234111.9019-8-keescook@chromium.org>
 <20190820100638.GK2332@hirez.programming.kicks-ass.net>
 <06ba33fd-27cc-3816-1cdf-70616b1782dd@c-s.fr>
 <20190820211429.7030b6f6@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820211429.7030b6f6@oasis.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 09:14:29PM -0400, Steven Rostedt wrote:
> On Tue, 20 Aug 2019 12:58:49 +0200
> Christophe Leroy <christophe.leroy@c-s.fr> wrote:
> 
> > >> index 1077366f496b..6c22e8a6f9de 100644
> > >> --- a/lib/bug.c
> > >> +++ b/lib/bug.c
> > >> @@ -181,6 +181,15 @@ enum bug_trap_type report_bug(unsigned long bugaddr, struct pt_regs *regs)
> > >>   		}
> > >>   	}
> > >>   
> > >> +	/*
> > >> +	 * BUG() and WARN_ON() families don't print a custom debug message
> > >> +	 * before triggering the exception handler, so we must add the
> > >> +	 * "cut here" line now. WARN() issues its own "cut here" before the
> > >> +	 * extra debugging message it writes before triggering the handler.
> > >> +	 */
> > >> +	if ((bug->flags & BUGFLAG_PRINTK) == 0)
> > >> +		printk(KERN_DEFAULT CUT_HERE);  
> > > 
> > > I'm not loving that BUGFLAG_PRINTK name, BUGFLAG_CUT_HERE makes more
> > > sense to me.
> > >   
> > 
> > Actually it would be BUGFLAG_NO_CUT_HERE then, otherwise all arches not 
> > using the generic macros will have to add the flag to get the "cut here" 
> > line.
> >
> 
> Perhaps they all should be audited to see if they don't have the same
> problem?

As far as I could tell, all the other combinations end up either using
the slow path bug helpers or the common exception handler.
warn-with-a-fmt-string is the only case that does the "early cut here".

-- 
Kees Cook
