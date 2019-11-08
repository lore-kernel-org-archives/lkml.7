Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5805FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABA1A21848
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pABRQS8I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731787AbfKHL1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:27:15 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34504 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730690AbfKHL1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:27:15 -0500
Received: by mail-lj1-f194.google.com with SMTP id 139so5834523ljf.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 03:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G6JiAIssBOVEi2xc5+XvlkE+IwHQEpAFSY9OyXbjbm0=;
        b=pABRQS8Ifv7HSJlZkf+BV3CXrc+JD059RcyVYWDf2ZKVtyzTkdbg+/ldmIr3E5qVju
         blc+Kh9MYGQ2qX9Y6vdEsovWO/vZZT9tabO4mYAC+/CjNV2GEZO9ModtNXGA+wjnyhaR
         2FaDpy4Nada5Ebmt33Y1zUM/e9b3mQUCOr+jqlMGnW7Ob1x864IR5LG7+KLVzOTYmvmW
         ey1YCrYWGWUgcjnBsA4mtrdvElarsgKk/U7RpSfAJDhNO7HITb8F/T/XjCQUnSIsMEWs
         unE3YBS/S/B4M4AbYVzlp6DC/Xhm3FZ4+fmZ9rmwP+epeXceDvt9kKAbFwrmXgkVatMI
         IcNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G6JiAIssBOVEi2xc5+XvlkE+IwHQEpAFSY9OyXbjbm0=;
        b=adiHPPVhXlFTij6VLl7F7Te6UBxy//D6kcB+hCYTic58oYtrjFa9bLggZP/ByQNBfe
         khxN0krfsS5B6bV3iFA/JK6GQJ4Hl182r+yAk3uGD/PeZ4hPkC0YN6bKWWMLrII8Zqhe
         xJRUcE0rYdPj+pCEYEgvxHRsVjvns09ailu27mm6sKyDJcts+ZrNbGl4cRI1DrmoT8Or
         YqGo26RG4ugU/BFkyRoKY0MIDGZR5IME4/JOFG6GRSYcx+GOw/BUkEV6sUUwOWgMZfGm
         yJErOkJw8ZRkrbufXmgpT1HgkuptJ6WHBUaKbaPn0401CkZiq6aZBMUND6yAfjUPuo8/
         nQJA==
X-Gm-Message-State: APjAAAUFDJ67oHEJH+clInzqvQHP9zYKrvr3ZUlw3xi1n4Q0OH/pE8Ii
        YQGKTUdz9mbTlzmJ4YJ01rKEDTNHedgQzFP9W/iPKg==
X-Google-Smtp-Source: APXvYqyYZXM623Eo2BJ6ZYR5PkkZw7K96pCoJuYr4fvai4kTlGG1EG/G/RPh1v5brnbpA6ZqXG7mKACgjJFvbjccsMo=
X-Received: by 2002:a2e:8809:: with SMTP id x9mr6440155ljh.82.1573212433300;
 Fri, 08 Nov 2019 03:27:13 -0800 (PST)
MIME-Version: 1.0
References: <cover.1572326519.git.baolin.wang@linaro.org> <19910a2f34b9be81f64637a5a5fc8d07bd5f4885.1572326519.git.baolin.wang@linaro.org>
 <a9f42792-3432-48f2-c5c4-8b03c32995dd@intel.com> <CAMz4kuK=wV1qtO4tOCcqibzKAFD-_p8+OzGOjdkvajVymJ5EgA@mail.gmail.com>
 <2ed0bcd1-fa74-d095-97ee-7d0c46a4fdbb@intel.com> <CAMz4kuJe64hdVGBTCvZW3t4_JGnTBRF=NhYDookrzNPiXacq_w@mail.gmail.com>
 <CAMz4ku+KVWw-M4AaPJ=Yn8xeLNaD2W4+gVqEN_P0QRwne3wwzA@mail.gmail.com> <0c70b5cf-4453-b21b-5622-f97ff069cf1b@intel.com>
In-Reply-To: <0c70b5cf-4453-b21b-5622-f97ff069cf1b@intel.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Fri, 8 Nov 2019 19:27:01 +0800
Message-ID: <CAMz4kuLT_3Hun_=ZiwRsqOcwxNoSasgFTfj7_1naBtVneSiJpg@mail.gmail.com>
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

On Fri, 8 Nov 2019 at 19:24, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 8/11/19 1:08 PM, Baolin Wang wrote:
> > On 06/11/2019, Baolin Wang <baolin.wang@linaro.org> wrote:
> >> On Wed, 6 Nov 2019 at 20:02, Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>>
> >>> To move ahead in the meantime without a new host API, just defer always
> >
> > Before new version, I want to make things clear in case I
> > misunderstood your points, so you mean I should set always_defer_done
> > = true for our Spreadtrum host driver in this patch? Or just like
> > below patch? Thanks.
> >
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index 850241f..4bef066 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -3035,7 +3035,7 @@ static inline bool sdhci_defer_done(struct
> > sdhci_host *host,
> >  {
> >         struct mmc_data *data = mrq->data;
> >
> > -       return host->pending_reset ||
> > +       return host->pending_reset || host->always_defer_done ||
> >                ((host->flags & SDHCI_REQ_USE_DMA) && data &&
> >                 data->host_cookie == COOKIE_MAPPED);
> >  }
> > diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> > index d89cdb9..a73ce89 100644
> > --- a/drivers/mmc/host/sdhci.h
> > +++ b/drivers/mmc/host/sdhci.h
> > @@ -533,6 +533,7 @@ struct sdhci_host {
> >         bool pending_reset;     /* Cmd/data reset is pending */
> >         bool irq_wake_enabled;  /* IRQ wakeup is enabled */
> >         bool v4_mode;           /* Host Version 4 Enable */
> > +       bool always_defer_done; /* Always defer to complete requests */
> >
> >         struct mmc_request *mrqs_done[SDHCI_MAX_MRQS];  /* Requests done */
> >         struct mmc_command *cmd;        /* Current command */
> >
>
> Yes

Got it. Thanks for your confirming.

-- 
Baolin Wang
Best Regards
