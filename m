Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD402C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 07:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0B652075B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 07:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="spGmlapH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfKKH6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 02:58:11 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40048 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbfKKH6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 02:58:10 -0500
Received: by mail-lj1-f196.google.com with SMTP id q2so12706735ljg.7
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2019 23:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N+N5m8FTDI4LC8i+HnAMwL79Bhle6k8rUOunQ/muSsc=;
        b=spGmlapHE1+lGEZL84dffiInKqqQ5vRsE26C+U2Ca1WAyoW5MC4n11IwxZ/LEQ37iX
         ujtADjNeDMser9ZDTqS/BO1AQ091dOPhG5ZSR/cVNhuPEjcNTxAEJwz3zOoslNFPKj8+
         djCAx8dfx2/8Mh7Y3LfQnXxy72FTydxwgzi04u0h0id7yBPWxuIMWAW9wESgQ/jsEKEm
         GjAUwFvnuTrcahTuiYUpMpIssVIGbrVA6cUknLlpcTmiC0gSvV1o4QedFkG2Ns0ZM4VL
         q7UY5FtT1vy4CU+SGlf6aQ9PeAhQK2b4+SkMIpeT6Fzf1kjr0Ts+CVhbB4XqhMpGqfuG
         sOaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N+N5m8FTDI4LC8i+HnAMwL79Bhle6k8rUOunQ/muSsc=;
        b=UqqXckavPFxOXTE2cOKRvN5Vf8Nj1/ZpJDw98gPE48/3+lkSBf1d++I9FHQu8EcYBu
         g2B/o1QIMYPZ8ul2O8CkRZiXO+cK21j6boOAXgkHEKDFkb97wXaBTmMsTSkletI9bkvI
         Gt3teUjepqILemaSGN5WdPdJiMwIQ/PHl3FuXkqie/UD5q66uIiP2/eBoclofgjbND9R
         BlCaRGoEuz80Fv8CBlb6yOntxtb6SR1sbRL2v9mLLN/fixgqLWG3Epg6QFzyHya8cANK
         bkrS+sCko6UXTO3cn9FCuqujFcbw0tkRJmlyaups6jaS3SQuq81U0U9RJvpsJWaSN/WN
         kSwA==
X-Gm-Message-State: APjAAAWxRPw0Z0VYKtF5fs1LuACDYlKa7dCKeqyAxpaaqfUwkGnfXwtD
        7h/zMsTlqv268sH1B6LIt20be1omDQcWFFPRawgqNA==
X-Google-Smtp-Source: APXvYqwiYeqMPmrYbnCKFvpE/W6RPaIQmQ+CidWHLC3r5XWS0ydnr9KVNBj+ajw38MgeOY5U+SZy6SJ2PAWkBsMnsc4=
X-Received: by 2002:a2e:864f:: with SMTP id i15mr3167166ljj.29.1573459088663;
 Sun, 10 Nov 2019 23:58:08 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573456283.git.baolin.wang@linaro.org> <119d3285ab610967b43f7c822dfdc0ebb8d521cb.1573456284.git.baolin.wang@linaro.org>
 <d4ff481f-1ed9-bd24-db9b-61e0479de12f@intel.com>
In-Reply-To: <d4ff481f-1ed9-bd24-db9b-61e0479de12f@intel.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Mon, 11 Nov 2019 15:57:56 +0800
Message-ID: <CAMz4ku+7AVSyZzj0xYRT-rXAc4b=jPF98ekFuHbKYqZcCZxD-g@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] mmc: host: sdhci: Add a variable to defer to
 complete requests if needed
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, asutoshd@codeaurora.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        baolin.wang7@gmail.com, linux-mmc <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Nov 2019 at 15:45, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 11/11/19 9:34 AM, Baolin Wang wrote:
> > When using the host software queue, it will trigger the next request in
> > irq handler without a context switch. But the sdhci_request() can not be
> > called in interrupt context when using host software queue for some host
> > drivers, due to the get_cd() ops can be sleepable.
> >
> > But for some host drivers, such as Spreadtrum host driver, the card is
> > nonremovable, so the get_cd() ops is not sleepable, which means we can
> > complete the data request and trigger the next request in irq handler
> > to remove the context switch for the Spreadtrum host driver.
> >
> > Thus we still need introduce a variable in struct sdhci_host to indicate
> > that we will always to defer to complete requests if the sdhci_request()
> > can not be called in interrupt context for some host drivers, when using
> > the host software queue.
>
> Sorry, I assumed you would set host->always_defer_done in = true for the
> Spreadtrum host driver in patch "mmc: host: sdhci-sprd: Add software queue
> support" and put this patch before it.

Ah, sorry, I misunderstood your point.
So you still expect the Spreadtrum host driver should defer to
complete requests firstly, then introducing a request_atomic API in
next patch set to let our Spreadtrum host driver can call
request_atomic() in the interrupt context. OK, will do in next
version. Thanks.

> > Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > ---
> >  drivers/mmc/host/sdhci.c |    2 +-
> >  drivers/mmc/host/sdhci.h |    1 +
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index 850241f..4bef066 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -3035,7 +3035,7 @@ static inline bool sdhci_defer_done(struct sdhci_host *host,
> >  {
> >       struct mmc_data *data = mrq->data;
> >
> > -     return host->pending_reset ||
> > +     return host->pending_reset || host->always_defer_done ||
> >              ((host->flags & SDHCI_REQ_USE_DMA) && data &&
> >               data->host_cookie == COOKIE_MAPPED);
> >  }
> > diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> > index d89cdb9..a73ce89 100644
> > --- a/drivers/mmc/host/sdhci.h
> > +++ b/drivers/mmc/host/sdhci.h
> > @@ -533,6 +533,7 @@ struct sdhci_host {
> >       bool pending_reset;     /* Cmd/data reset is pending */
> >       bool irq_wake_enabled;  /* IRQ wakeup is enabled */
> >       bool v4_mode;           /* Host Version 4 Enable */
> > +     bool always_defer_done; /* Always defer to complete requests */
> >
> >       struct mmc_request *mrqs_done[SDHCI_MAX_MRQS];  /* Requests done */
> >       struct mmc_command *cmd;        /* Current command */
> >
>


-- 
Baolin Wang
Best Regards
