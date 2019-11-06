Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8827C5DF64
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 12:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 941FD20869
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 12:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QpM1stPs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731454AbfKFMRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 07:17:47 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34365 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730501AbfKFMRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 07:17:47 -0500
Received: by mail-lf1-f67.google.com with SMTP id f5so17892023lfp.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 04:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pyaNKtEJ2dhdRbX0XGG2IskdfPoKWgFFcpf2S2Y9JTA=;
        b=QpM1stPsxibreOYhSOYUvFH3b58z/8EkMAfLRJIfpyMKCIlh9GtTXfpiruDZlg8eht
         r2JBScHEAOT2u0L9HZ+5bAYM9jptDj61F9/f6V+0yodOwA58RwzbAbAwKKBkZeB8FyYu
         Agf48Vn+n4ExxJBgcjkDJjwCA94IHRIGaT549OBxaDMCxvilIbJHMJuUPqsEaI+RjiWT
         IeRQp0/t5wvonASnw0GmcIyzxvHahqQRYLNqbNgmErk89iUHiA7j1+BsDWN1HY+/qcTj
         isnsKQqi2JOPJX1VmctAkMgJLB3Cqudx0+Jsq1dQwKR6QqaUSlyDCnMjsi+27R8riVkZ
         E0UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pyaNKtEJ2dhdRbX0XGG2IskdfPoKWgFFcpf2S2Y9JTA=;
        b=mYnrbH41enXftdT5LHBQn/1LEYtw5Q/CdX8Kq/KgPY3m0HlmzzdtixJAaBKUgIC+D3
         BBmOsm1Xj+nMk4yS+3S4gvrT+hgUevpgOJxxktsLprPg2qPkhREESp3cqxDYRXh9U/dc
         jANYT6Sow4bazXOR5y2RKx8vh88OS/9LYF1Tad/m3WiyA+LhJXMYXx0Nj2mL6RgYxT0W
         izR3kp8dx/S1eOvXhhPmbQeH9I5UChXy1I7GXmEVmknPsSI9QZaoKVpZ4q536+MoQoGz
         qj9OepYzGQdbSRSDssF6o5vKDfaBnk1B/hFmZEWiai8yoryBfYWFo0KQsXV/SpMSNtQS
         zmFw==
X-Gm-Message-State: APjAAAXIsO6LU8EM6H0r976a6rSZFJ6jgBWhkXUrCYCuQaDxTuMOvcys
        yXQaKSXkg7NEYU++kXH6jq2hFGY3YQVeWhqJDLpZQw==
X-Google-Smtp-Source: APXvYqx+lORr/vSCqzfbkFGbeK30H8ZblAIlW+SCvvXD14BAbMOWSorLfroow+ULiuR/LwyISg5vX0un2676lvzS7PU=
X-Received: by 2002:a19:a40c:: with SMTP id q12mr11951247lfc.65.1573042664331;
 Wed, 06 Nov 2019 04:17:44 -0800 (PST)
MIME-Version: 1.0
References: <cover.1572326519.git.baolin.wang@linaro.org> <19910a2f34b9be81f64637a5a5fc8d07bd5f4885.1572326519.git.baolin.wang@linaro.org>
 <a9f42792-3432-48f2-c5c4-8b03c32995dd@intel.com> <CAMz4kuK=wV1qtO4tOCcqibzKAFD-_p8+OzGOjdkvajVymJ5EgA@mail.gmail.com>
 <2ed0bcd1-fa74-d095-97ee-7d0c46a4fdbb@intel.com>
In-Reply-To: <2ed0bcd1-fa74-d095-97ee-7d0c46a4fdbb@intel.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Wed, 6 Nov 2019 20:17:33 +0800
Message-ID: <CAMz4kuJe64hdVGBTCvZW3t4_JGnTBRF=NhYDookrzNPiXacq_w@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] mmc: host: sdhci: Add a variable to defer to
 complete data requests if needed
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

On Wed, 6 Nov 2019 at 20:02, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 6/11/19 12:48 PM, Baolin Wang wrote:
> > On Wed, 6 Nov 2019 at 18:10, Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>
> >> On 29/10/19 7:43 AM, Baolin Wang wrote:
> >>> When using the host software queue, it will trigger the next request in
> >>> irq handler without a context switch. But the sdhci_request() can not be
> >>> called in interrupt context when using host software queue for some host
> >>> drivers, due to the get_cd() ops can be sleepable.
> >>>
> >>> But for some host drivers, such as Spreadtrum host driver, the card is
> >>> nonremovable, so the get_cd() ops is not sleepable, which means we can
> >>> complete the data request and trigger the next request in irq handler
> >>> to remove the context switch for the Spreadtrum host driver.
> >>>
> >>> Thus we still need introduce a variable in struct sdhci_host to indicate
> >>> that we will always to defer to complete data requests if the sdhci_request()
> >>> can not be called in interrupt context for some host drivers, when using
> >>> the host software queue.
> >>>
> >>> Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
> >>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> >>> ---
> >>>  drivers/mmc/host/sdhci.c |    2 +-
> >>>  drivers/mmc/host/sdhci.h |    1 +
> >>>  2 files changed, 2 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> >>> index 850241f..9cf2130 100644
> >>> --- a/drivers/mmc/host/sdhci.c
> >>> +++ b/drivers/mmc/host/sdhci.c
> >>> @@ -3035,7 +3035,7 @@ static inline bool sdhci_defer_done(struct sdhci_host *host,
> >>>  {
> >>>       struct mmc_data *data = mrq->data;
> >>>
> >>> -     return host->pending_reset ||
> >>> +     return host->pending_reset || (host->always_defer_done && data) ||
>
> To move ahead in the meantime without a new host API, just defer always i.e.

OK.

And I'll wait for a while to see if Ulf will post some comments for
this patch set before new version. Thanks.

>
> +     return host->pending_reset || host->always_defer_done ||
>
> >>
> >> I didn't realize you still wanted to call the request function in interrupt
> >> context.  In my view that needs a new host API
> >> i.e. int (*request_atomic)(struct mmc_host *mmc, struct mmc_request *mrq)
> >
> > Actually there are no documentation said that the
> > mmc_host_ops->request() is a sleepable API, so I introduce a
> > host->always_defer_done flag to decide if the request can be called in
> > interrupt context or not, since for some host drivers, the request()
> > implementation can be called in interrupt context.
> >
> > Yes, I agree a new host API is more reasonable, if you do not like the
> > current approach, I can add new patches to introduce the new
> > request_atomic() API. But can I create another separate patch set to
> > do this? since in this patch set, the Spreadtrum host driver's
> > request() implementation can be called in interrupt context. Or you
> > still want these changes introducing new request_atomic() can be done
> > in this patch set? Thanks.
> >
> >>
> >>>              ((host->flags & SDHCI_REQ_USE_DMA) && data &&
> >>>               data->host_cookie == COOKIE_MAPPED);
> >>>  }
> >>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> >>> index d89cdb9..38fbd18 100644
> >>> --- a/drivers/mmc/host/sdhci.h
> >>> +++ b/drivers/mmc/host/sdhci.h
> >>> @@ -533,6 +533,7 @@ struct sdhci_host {
> >>>       bool pending_reset;     /* Cmd/data reset is pending */
> >>>       bool irq_wake_enabled;  /* IRQ wakeup is enabled */
> >>>       bool v4_mode;           /* Host Version 4 Enable */
> >>> +     bool always_defer_done; /* Always defer to complete data requests */
> >>>
> >>>       struct mmc_request *mrqs_done[SDHCI_MAX_MRQS];  /* Requests done */
> >>>       struct mmc_command *cmd;        /* Current command */
> >>>
> >>
> >
> >
>


-- 
Baolin Wang
Best Regards
