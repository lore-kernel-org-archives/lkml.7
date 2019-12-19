Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AB2C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 16:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E0012146E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 16:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcVH6Uqy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfLSQy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 11:54:28 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34079 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbfLSQy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 11:54:27 -0500
Received: by mail-pg1-f195.google.com with SMTP id r11so3445576pgf.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 08:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pgse3VcFr8kbmxFx26/0trFu8f96kP0bvCPhSwUFaxA=;
        b=lcVH6Uqy5pdJt2S4YjCtblqt+eqjCGR+qZ03tMvb8rP35cCJx/p2lHfIeSpKGOy85B
         vmUE25gp4CDyb0n0ZJYTs9fJD2wUopxmDP6yL5OOKvSosFZfb7zXovCNEGfZWYY0za52
         am/QLG1hPxbXpXEJhlEJot+nn1KFD6B23BZRPr+xFvXYemmMUbM0WVIjB6BXbWw3St2I
         iiT5jRUiy2AYw48p15ROFSRYf9jmP7BcWGJ+webwZ5gcn/RCZBlRzoNYzb8sgSI+qZBa
         xUH//d+z1RCS0zQ4mOzyW6zUc4ainPbWHkhJb7mVXmC8KQ01nHQEPjuD9KnlXSbxnbyA
         FoaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pgse3VcFr8kbmxFx26/0trFu8f96kP0bvCPhSwUFaxA=;
        b=o6yDRkv0xmdn/cc+GxLPNePq/F0/UjLQTC5wxDikReIb0JusbOoeeHF9Xo+qHZIkl7
         2okK3rY4b8nvhLbXnQUbwM/nOcsj0iJgRKR2pz01CaOxG0z8Y+SAioJmI/1Ebo53j0IR
         bR8ma7v4o418i4EBVxcSVPsRoFw5P17WKzBUrxMlgNnKqaUGySDN5+u2sJxEFy4RYkn4
         jLtYKcyRc08zWXkYFpBCuf7BBPKlKtJKC/ouGcwIDAk8IhBJdh9d1cL8aBSvCMNlSYCD
         znIsBJyQBHCFIxRoFtJd0xogZef/VVFd4roc6YtJKFYWB8eIMCnZuWcSwYcgjoFpHfa5
         DY4A==
X-Gm-Message-State: APjAAAUwASXFMnZwIF09v2EuL9+gbPb7LVrd6ytMSHj8cJcnUFcfC1EJ
        Ac4o7TRhVJH3PkJIEy8Zaq48m0AK
X-Google-Smtp-Source: APXvYqwz2RY/h1rjwouSm33H1PNjkg0ogh7NYTnb7U+U2knYJN4x4N7ImSmORDjncFaYOuArEYtH6g==
X-Received: by 2002:aa7:982d:: with SMTP id q13mr9518399pfl.152.1576774467124;
        Thu, 19 Dec 2019 08:54:27 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id u5sm8507048pfm.115.2019.12.19.08.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 08:54:26 -0800 (PST)
From:   "'Arnaldo Carvalho de Melo'" <arnaldo.melo@gmail.com>
X-Google-Original-From: 'Arnaldo Carvalho de Melo' <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B42F640CB9; Thu, 19 Dec 2019 13:54:24 -0300 (-03)
Date:   Thu, 19 Dec 2019 13:54:24 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     "fujita.yuya@fujitsu.com" <fujita.yuya@fujitsu.com>,
        'Peter Zijlstra' <peterz@infradead.org>,
        'Ingo Molnar' <mingo@redhat.com>,
        'Jiri Olsa' <jolsa@kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf tools: Fix variable name's inconsistency in
 hists__for_each macro
Message-ID: <20191219165424.GA13699@kernel.org>
References: <OSAPR01MB1588E1C47AC22043175DE1B2E8520@OSAPR01MB1588.jpnprd01.prod.outlook.com>
 <20191219085106.GA8141@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219085106.GA8141@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Dec 19, 2019 at 09:51:06AM +0100, Jiri Olsa escreveu:
> On Thu, Dec 19, 2019 at 08:08:32AM +0000, fujita.yuya@fujitsu.com wrote:
> > From: Yuya Fujita <fujita.yuya@fujitsu.com>
> > 
> > Variable names are inconsistent in hists__for_each macro.
> > Due to this inconsistency, the macro replaces its second argument with "fmt" 
> > regardless of its original name.
> > So far it works because only "fmt" is passed to the second argument.
> 
> hum, I think it works because all the instances that use these macros
> have 'fmt' variable passed in

Exactly, that is what he said :-)

Nice catch!
 
> > However, this behavior is not expected and should be fixed.
> > 
> > Fixes: f0786af536bb ("perf hists: Introduce hists__for_each_format macro")
> > Fixes: aa6f50af822a ("perf hists: Introduce hists__for_each_sort_list macro")
> 
> nice ;-)
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Applied.
 
> thanks,
> jirka
> 
> > Signed-off-by: Yuya Fujita <fujita.yuya@fujitsu.com>
> > ---
> >  tools/perf/util/hist.h |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
> > index 4528690..0aa63ae 100644
> > --- a/tools/perf/util/hist.h
> > +++ b/tools/perf/util/hist.h
> > @@ -339,10 +339,10 @@ static inline void perf_hpp__prepend_sort_field(struct perf_hpp_fmt *format)
> >  	list_for_each_entry_safe(format, tmp, &(_list)->sorts, sort_list)
> >  
> >  #define hists__for_each_format(hists, format) \
> > -	perf_hpp_list__for_each_format((hists)->hpp_list, fmt)
> > +	perf_hpp_list__for_each_format((hists)->hpp_list, format)
> >  
> >  #define hists__for_each_sort_list(hists, format) \
> > -	perf_hpp_list__for_each_sort_list((hists)->hpp_list, fmt)
> > +	perf_hpp_list__for_each_sort_list((hists)->hpp_list, format)
> >  
> >  extern struct perf_hpp_fmt perf_hpp__format[];
> >  
> > -- 
> > 1.7.1
> > 

-- 

- Arnaldo
