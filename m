Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FC4C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 12:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B88252067B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 12:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tH6aQ2nC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404603AbfIIMLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 08:11:52 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:47049 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729261AbfIIMLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 08:11:51 -0400
Received: by mail-lf1-f65.google.com with SMTP id t8so10252279lfc.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 05:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4+Nuw6Os0WLSEwpWKFno+g2UOwdVDp3JMqLLE2u1BHk=;
        b=tH6aQ2nCdR/kKTtxRLZKY+JRdhLrLO74UFRvlfGrvL8AkXDCDPwknAk5qQz+eQ1QhE
         dCDh1WPrLquvWJ0ExxXX8CNkZhuS1rFh1Z9/Qi/amQ2zDPqAwSO4dfnLLjPWo1fK5kBr
         QjdNHIIKnToUPqYpE5SiK+EGQufqoGAlRuqXKwsLoCZbCqCdsInBbhHZtHnYyTiQ2F5H
         uXdRx3YnlOmhMCpbB92K/TxQNaEtTK2WXlZttrEurxyVbPTGJBFH0zUS7Optzle3xGQp
         hXfxPnkbB2DEr1NhbfnRGqKBBsO8ib/QPLDa7ljGhrmGsvAF4kSAhBuIIzVwuuwkQcor
         +jOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4+Nuw6Os0WLSEwpWKFno+g2UOwdVDp3JMqLLE2u1BHk=;
        b=PPs98yqygrx5SSGeCwGzPMTA3YE7YQMGveRoBynJ/7WfrqlQZkIy3cH9c52hl0I13E
         6BE7HGSLQvUhmIGQnWeDv+wB7GAtFR5qcJxQndxYvkGw3gdvn/R25JQUJHllNwQRwGVw
         4AbrFS/e8w4uq/9YSeh1Y2lEGsmqaVtCMWFNAJENZLgCNOpduPrGSlrgIeGdWoX3v0Rr
         pvnSpN0t22yDTW0IfFZlubMpPTXoLygYMiH2bDhKSo9OApVUtimgPgv4bOhZfZ/djdRw
         9l7wFCol9hwEJ+LLkfx87bZpOPxArz4esE7k86Cp6jJbUC1iUTnU6cpBDd+yi4K3725J
         AUzQ==
X-Gm-Message-State: APjAAAWm64u5fIt69+W2ZyGy7gDgxBYMzjMMFVG7+UMSZc6GwgyWeIjC
        PNpD5nnbpJnrsfAjxX2bJEOYYQDbfVNDtRih03jHgg==
X-Google-Smtp-Source: APXvYqwM8k/Y/CHwm/ldUlNUtOmUxd9VtM7uinfVYStfifFNnaCh+8zzZibX128c7cTTZIWzolBcQRI2Q+w1aYAxP2U=
X-Received: by 2002:ac2:5bde:: with SMTP id u30mr15632980lfn.59.1568031107874;
 Mon, 09 Sep 2019 05:11:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1567740135.git.baolin.wang@linaro.org> <fc8a0fe513d244375013546c3c03967510feea4a.1567740135.git.baolin.wang@linaro.org>
 <5594efd0-6076-bbb5-5aec-a6b3a21dd7ca@intel.com>
In-Reply-To: <5594efd0-6076-bbb5-5aec-a6b3a21dd7ca@intel.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Mon, 9 Sep 2019 20:11:35 +0800
Message-ID: <CAMz4kuJp38Y20XHpF5vm0bwFK3MQK8bqJNtgwgqeXu_FcdpikQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] mmc: host: sdhci: Add virtual command queue support
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, riteshh@codeaurora.org,
        asutoshd@codeaurora.org, Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Mon, 9 Sep 2019 at 20:04, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 6/09/19 6:52 AM, Baolin Wang wrote:
> > Add cqhci_virt_finalize_request() to help to complete a request
> > from virtual command queue.
> >
> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > ---
> >  drivers/mmc/host/sdhci.c |    7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index 4e9ebc8..fb5983e 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -32,6 +32,7 @@
> >  #include <linux/mmc/slot-gpio.h>
> >
> >  #include "sdhci.h"
> > +#include "cqhci.h"
> >
> >  #define DRIVER_NAME "sdhci"
> >
> > @@ -2710,7 +2711,8 @@ static bool sdhci_request_done(struct sdhci_host *host)
> >
> >       spin_unlock_irqrestore(&host->lock, flags);
> >
> > -     mmc_request_done(host->mmc, mrq);
> > +     if (!cqhci_virt_finalize_request(host->mmc, mrq))
> > +             mmc_request_done(host->mmc, mrq);
>
> Please add a sdhci_ops callback for request->done then:
>
>         if (host->ops->request_done)
>                 host->ops->request_done(host, mrq);
>         else
>                 mmc_request_done(host->mmc, mrq);

Sure, will do.

>
> >
> >       return false;
> >  }
> > @@ -3133,7 +3135,8 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
> >
> >       /* Process mrqs ready for immediate completion */
> >       for (i = 0; i < SDHCI_MAX_MRQS; i++) {
> > -             if (mrqs_done[i])
> > +             if (mrqs_done[i] &&
> > +                 !cqhci_virt_finalize_request(host->mmc, mrqs_done[i]))
>
> sdhci does not support calling mmc->ops->request in interrupt context.
> So probably, you should avoid immediate completion.

Yes, I missed this, will remove. Thanks.

-- 
Baolin Wang
Best Regards
