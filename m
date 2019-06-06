Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875F5C28D18
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 02:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EC9420684
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 02:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DFulL/R6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfFFCyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 22:54:49 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46783 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbfFFCys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 22:54:48 -0400
Received: by mail-pf1-f194.google.com with SMTP id y11so517796pfm.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 19:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7zLWmYl/+X2He6Ch7i6FSYueJhM5f4AH0Fhf/uNr4es=;
        b=DFulL/R680YF6KTZlZwzyLgEOuX5oX3pNweBw5PzqDFAKvuanRCLvVnv1F4/bjc41P
         vR49GnfeZgv+Tb1QEPvIQE78hQ6XwJmwCVAqlgvbyjTtgLAQxcpnBJGoD1uGTGvfi+B+
         hoWhgfkNA5d3TaZpi8f4qiYkFVgSnPPOF7DgdfkVQnzF5T3OS0vFERVdB5BqBhsJSBFl
         386Vn5XX4dObSbEDu/WSg3xU7D4NzGGyvaBIKdalcBl+p2Uj0BDKJYiVjditjL/FbShx
         Et1ReY0azsehYO8aUaH0bfRZViGiV7uD8AwDfBmu1CR5VHisjtQypVv/6cKMPdde6sC9
         fe0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7zLWmYl/+X2He6Ch7i6FSYueJhM5f4AH0Fhf/uNr4es=;
        b=iBuBfuMbr59GjU2eyCbYXl0JcMqS/tfdZE9/xvHc39a46kJgTWsF1auxp+mcLLFE+6
         IuSBGr5cQUFtMw8R2hpj0GvZy16msBKqlmiYCBE+NYCwuXNblkXoZB0rPffZ764aTQqN
         0KA1T3ro0OmhNg9iZsK3xMLTQ5SJ3WQr7uFtLmvM7+ceKXnoif9i9KhfYrqb85//KxMv
         IpUb8QJjEpDELmmhPigCkLlOmrMgDhWR9D5V52bKDnx+4En+wNT0Qeo11vuPA3YtYHUE
         qD4ERkyU1/cW2x6gBCkrUyJhW90OzroEGxV8QyM5ktzOuONFN3HfBOgS1E0/go5xfmmH
         ONcA==
X-Gm-Message-State: APjAAAUAR8z3hWIArqyweKHt3KgSb1eZqj41RzTLYXdpasyfy05rIp2o
        eLhgqMZcqL5ttmsahFVAZ7pITQ==
X-Google-Smtp-Source: APXvYqw35UCA++Fz18xwkZJJIBYs2VbmoRQHiXcRfYXAmhiE703auWDyDi7ZlVIM4qFsqAz3jyc86g==
X-Received: by 2002:a62:750c:: with SMTP id q12mr29747379pfc.59.1559789687470;
        Wed, 05 Jun 2019 19:54:47 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id p7sm232322pgb.92.2019.06.05.19.54.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 19:54:46 -0700 (PDT)
Date:   Thu, 6 Jun 2019 08:24:44 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Peter Oskolkov <posk@posk.io>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] sched/fair: Introduce fits_capacity()
Message-ID: <20190606025444.etxgxny6hosoa74z@vireshk-i7>
References: <b477ac75a2b163048bdaeb37f57b4c3f04f75a31.1559631700.git.viresh.kumar@linaro.org>
 <CAFTs51WUXwJbgsFCRbOwdUWnv55Mbt55-hmoMyETPGC5yMDSCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFTs51WUXwJbgsFCRbOwdUWnv55Mbt55-hmoMyETPGC5yMDSCQ@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-06-19, 08:59, Peter Oskolkov wrote:
> On Tue, Jun 4, 2019 at 12:02 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > The same formula to check utilization against capacity (after
> > considering capacity_margin) is already used at 5 different locations.
> >
> > This patch creates a new macro, fits_capacity(), which can be used from
> > all these locations without exposing the details of it and hence
> > simplify code.
> >
> > All the 5 code locations are updated as well to use it..
> >
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  kernel/sched/fair.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 7f8d477f90fe..db3a218b7928 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -102,6 +102,8 @@ int __weak arch_asym_cpu_priority(int cpu)
> >   * (default: ~20%)
> >   */
> >  static unsigned int capacity_margin                    = 1280;
> > +
> > +#define fits_capacity(cap, max)        ((cap) * capacity_margin < (max) * 1024)
> 
> Any reason to have this as a macro and not as an inline function?

I don't have any strong preference here, I used a macro as I didn't
feel that type-checking is really required on the parameters and
eventually this will get open coded anyway.

Though I would be fine to make it a routine if maintainers want it
that way.

Thanks Peter.

-- 
viresh
