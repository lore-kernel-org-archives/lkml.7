Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775CAC3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 03:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 496EA20828
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 03:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567137503;
	bh=SHM0DKHptupZMeKI8tm9dZMKVQgJ5avoNgQfzWUcMZQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Dr0j7LZv+gdrAxu/BHAF0Mqs5TpBODDe1wBT3Pum8AmzWN+vXvE/a+iEfpTNUkigA
	 Wcmtp/01RQL+504ptQT4nfCj7tkIAwk54StNF8mWX3KdBX1rVaSrqdwkdzE79pcwXK
	 AnzE+oKWhkD/IR0gBC38zb6x8FzajQ0A5TcErlOE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbfH3D6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 23:58:22 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42848 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728188AbfH3D6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 23:58:19 -0400
Received: by mail-wr1-f66.google.com with SMTP id b16so5452430wrq.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 20:58:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U2YaSC8htOogtAiuH3jBHv8w0nOA/yz+9vWbbSSDAyE=;
        b=gbt8SgME57II7HvM5157UQKk6DP+mARVtSJon99aKdG89rLwo1Iozlweg+1BCIqt2/
         vCmdt1LEf67ivHfIlj9j1VoM1SNqyYA61aqpNAwMLnVxJT19ub8FIPJGFIUY6QMGmkwY
         tDzdjS3DsB5ixz3FSir76x+ZAR9RiA+5ViYYuEQu1rnpEnOu4A+ehTGchU/FZEYl/sVT
         aIUMb5tFm/a/txBSpj/UWGZ0URocHLWDkgUxnt+1TcE09Sy57eKSeCAE1/VyC1IIxvGs
         LLYE+Nc9I4kK55h42dZyv0MuO3w+pcBSyvVliIv4pEUKMMyK+k2WBu/ROfTk9NLpiGcO
         iBsQ==
X-Gm-Message-State: APjAAAXepACW0MKRNj2lJWOdEiMCq+wCpLK9nTlFUFIsAvnm87Kac5It
        3OGGd22v2dTWrgOpc1aaj9nqcTWjdCvDeEmpiOU=
X-Google-Smtp-Source: APXvYqzC+DoqDgf5IDWkK1sZ6dEho3io0fbRiyOerOUdA7IYhEipziUqUJI3dzg7UtsiBGjHbnKqEnY3ILf5dUqlFfo=
X-Received: by 2002:adf:e5c4:: with SMTP id a4mr16452387wrn.87.1567137497299;
 Thu, 29 Aug 2019 20:58:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190827231555.121411-1-namhyung@kernel.org> <20190828124949.GA14025@kernel.org>
In-Reply-To: <20190828124949.GA14025@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 30 Aug 2019 12:58:06 +0900
Message-ID: <CAM9d7cgKBH_s44n0n5fOqCuuEGktRrFMW27Jae=ViaT20SESAw@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf top: Decay all events in the evlist
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Wed, Aug 28, 2019 at 9:49 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, Aug 28, 2019 at 08:15:54AM +0900, Namhyung Kim escreveu:
> > Currently perf top only decays entries in a selected evsel.  I don't
> > know whether it's intended (maybe due to performance reason?) but
> > anyway it might show incorrect output when event group is used since
> > users will see leader event is decayed but others are not.
> >
> > This patch moves the decay code into evlist__resort_hists() so that
> > stdio and tui code shared the logic.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/builtin-top.c | 38 +++++++++++++-------------------------
> >  1 file changed, 13 insertions(+), 25 deletions(-)
> >
> > diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> > index 5970723cd55a..9d3059d2029d 100644
> > --- a/tools/perf/builtin-top.c
> > +++ b/tools/perf/builtin-top.c
> > @@ -264,13 +264,23 @@ static void perf_top__show_details(struct perf_top *top)
> >       pthread_mutex_unlock(&notes->lock);
> >  }
> >
> > -static void evlist__resort_hists(struct evlist *evlist)
> > +static void evlist__resort_hists(struct perf_top *t)
>
> Since this now operates on the perf_top struct, I'll rename it to
> perf_top__resort_hists(), ok? No need to send an updated patch.

Right.  Thanks for doing this!

Namhyung
