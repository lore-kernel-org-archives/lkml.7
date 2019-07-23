Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DB3C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 03:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9654721911
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 03:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wd/XVqFB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732365AbfGWDFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 23:05:38 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38009 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfGWDFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 23:05:37 -0400
Received: by mail-oi1-f196.google.com with SMTP id v186so31196012oie.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 20:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6z23ihiLa0fqOtrIntj5/XpQ6+8uIAMB4pCR65GZk7I=;
        b=wd/XVqFBZQ9/Qq6IEXQdUYgKeLYB1zy4zG7Q9ijPL8LcKG1qSoZawPTzbjWzZOp3vd
         AEIzUKaWCaNTImgCXWT94Hl5gVQZsbXQSx2yJWeg9zoTgo0kadqM2VxvrgemS7ghOjV6
         IywrSncmS0WlVy6eRLWSXQuCeTd6935TrECAGBnTgmSU8CLjdR+hYTbINNg/jWtfQiT8
         cdKY6UEFHJHpM/X5vpgxvWZp2hixaLmIZcZTOSXIaXTyLeOOB6PPbZVWWzN+C5DgmVM/
         /gA+7OzRqzT7rkLSSrTdmF36koiWTIYLg/cftPJutMtkZRrn0vqxmSliyshgK5EvQH6Y
         hcgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6z23ihiLa0fqOtrIntj5/XpQ6+8uIAMB4pCR65GZk7I=;
        b=N6C2Xo1J/fc1x8gYfRJPL/9Uh+Tb24uxOdNgb9RQ6gIxCjp5kk1FebUWCEP7SgYw3u
         KkXPa11kdcs+/VzXyRpGRwGQOz3q4PN0hlYpvmG3AUiuvn8AGQfWpyniNsv1i7KMqN5K
         UEfs+rq1IRzcu2aPM3CRs2uHJYutemrf/7QAmmW8d+ar2IXd9/q5O/oHtgqE4h5gzclK
         qFmB95yQLO9dqI7y4cGZ0WpSdeDpSxYqtLBZbpvWc5RpX19QOFR9flTCi9Y8h8kd+eYT
         crwAfsoX3TJseJ1AGRdjJH6YGI+nBNj+GgUOPjfwWwLN3w1YvrX2e0g4brk7qeKva2Tj
         Oxsg==
X-Gm-Message-State: APjAAAXjYraLJguq4Ap9p348Os5rEi+V6Mn0cr6zvyigM2w0qBxRvvYQ
        L4ySJsUjytFskQL0YjB2MYDIiQM8+Z5qeg0mQ9dgbQ==
X-Google-Smtp-Source: APXvYqww+xoxfeT7kmslr9nl3L4GnIvOsf2Lq/6zAIyCWWt3SskCzSv1T5QEEwhUaVJJB+EI3ZjeZO/fmuL++WUhSlw=
X-Received: by 2002:aca:4c16:: with SMTP id z22mr617585oia.57.1563851136490;
 Mon, 22 Jul 2019 20:05:36 -0700 (PDT)
MIME-Version: 1.0
References: <89c3ef495c367d58ca3abe99a1f82c48f8c08705.1563274904.git.baolin.wang@linaro.org>
 <CAPDyKFq1y6xVfA=b1ybWvA1+e9h9aSteHAHjBbXvXGVJx95FQA@mail.gmail.com>
In-Reply-To: <CAPDyKFq1y6xVfA=b1ybWvA1+e9h9aSteHAHjBbXvXGVJx95FQA@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 23 Jul 2019 11:05:23 +0800
Message-ID: <CAMz4kuKraOb_o0LFWnqkS7m0Xd3QGrw1P+md0YBNbbbp1967OA@mail.gmail.com>
Subject: Re: [PATCH v4] mmc: host: sdhci-sprd: Fix the incorrect soft reset
 operation when runtime resuming
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulf,

On Mon, 22 Jul 2019 at 19:54, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Wed, 17 Jul 2019 at 04:29, Baolin Wang <baolin.wang@linaro.org> wrote:
> >
> > In sdhci_runtime_resume_host() function, we will always do software reset
> > for all, which will cause Spreadtrum host controller work abnormally after
> > resuming.
>
> What does "software reset for all" means?

The SD host controller specification defines 3 types software reset:
software reset for data line, software reset for command line and
software reset for all.
Software reset for all means this reset affects the entire Host
controller except for the card detection circuit.

>
> >
> > Thus for Spreadtrum platform that will not power down the SD/eMMC card during
> > runtime suspend, we should not do software reset for all.
>
> Normally, sdhci hosts that enters runtime suspend doesn't power off
> the card (there are some exceptions like PCI variants).

Yes, same as our controller.

>
> So, what's so special here and how does the reset come into play? I
> don't see sdhci doing a reset in sdhci_runtime_suspend|resume_host()
> and nor doesn the callback from the sdhci-sprd.c variant doing it.

In sdhci_runtime_resume_host(), it will issue sdhci_init(host, 0) to
issue software reset for all.

>
> > To fix this
> > issue, adding a specific reset operation that adds one condition to validate
> > the power mode to decide if we can do software reset for all or just reset
> > command and data lines.
> >
> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > ---
> > Changess from v3:
> >  - Use ios.power_mode to validate if the card is power down or not.
> >
> > Changes from v2:
> >  - Simplify the sdhci_sprd_reset() by issuing sdhci_reset().
> >
> > Changes from v1:
> >  - Add a specific reset operation instead of changing the core to avoid
> >  affecting other hardware.
> > ---
> >  drivers/mmc/host/sdhci-sprd.c |   19 ++++++++++++++++++-
> >  1 file changed, 18 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> > index 603a5d9..94f9726 100644
> > --- a/drivers/mmc/host/sdhci-sprd.c
> > +++ b/drivers/mmc/host/sdhci-sprd.c
> > @@ -373,6 +373,23 @@ static unsigned int sdhci_sprd_get_max_timeout_count(struct sdhci_host *host)
> >         return 1 << 31;
> >  }
> >
> > +static void sdhci_sprd_reset(struct sdhci_host *host, u8 mask)
> > +{
> > +       struct mmc_host *mmc = host->mmc;
> > +
> > +       /*
> > +        * When try to reset controller after runtime suspend, we should not
> > +        * reset for all if the SD/eMMC card is not power down, just reset
> > +        * command and data lines instead. Otherwise will meet some strange
> > +        * behaviors for Spreadtrum host controller.
> > +        */
> > +       if (host->runtime_suspended && (mask & SDHCI_RESET_ALL) &&
> > +           mmc->ios.power_mode == MMC_POWER_ON)
> > +               mask = SDHCI_RESET_CMD | SDHCI_RESET_DATA;
>
> Can sdhci_sprd_reset() be called when the host is runtime suspended?

When host tries to runtime resume in sdhci_runtime_resume_host(), it
will call reset operation to do software reset.

> That sounds like a bug to me, no?

Since our controller will meet some strange behaviors if we do
software reset for all in sdhci_runtime_resume_host(), and try to
avoid changing the core logic of sdhci_runtime_resume_host() used by
other hardware controllers, thus I introduced a specific reset ops and
added some condition to make sure we just do software reset command
and data lines from runtime suspend state.

>
> > +
> > +       sdhci_reset(host, mask);
> > +}
> > +
> >  static struct sdhci_ops sdhci_sprd_ops = {
> >         .read_l = sdhci_sprd_readl,
> >         .write_l = sdhci_sprd_writel,
> > @@ -381,7 +398,7 @@ static unsigned int sdhci_sprd_get_max_timeout_count(struct sdhci_host *host)
> >         .get_max_clock = sdhci_sprd_get_max_clock,
> >         .get_min_clock = sdhci_sprd_get_min_clock,
> >         .set_bus_width = sdhci_set_bus_width,
> > -       .reset = sdhci_reset,
> > +       .reset = sdhci_sprd_reset,
> >         .set_uhs_signaling = sdhci_sprd_set_uhs_signaling,
> >         .hw_reset = sdhci_sprd_hw_reset,
> >         .get_max_timeout_count = sdhci_sprd_get_max_timeout_count,
> > --
> > 1.7.9.5
> >
>
> Kind regards
> Uffe



-- 
Baolin Wang
Best Regards
