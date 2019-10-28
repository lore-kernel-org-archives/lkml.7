Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E5DCA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 09:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C34F320717
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 09:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmWK048t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387867AbfJ1JPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 05:15:43 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34642 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727664AbfJ1JPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 05:15:43 -0400
Received: by mail-qk1-f193.google.com with SMTP id c25so1573884qkk.1;
        Mon, 28 Oct 2019 02:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OT9vPn7ycGD7jBjGQjG9ZHBs+GjEiewGN8zg5+tO7oY=;
        b=lmWK048tWPiLv2pOVdnF9PqCQUVr4N5gJNqTaqBojtv+qbIOpKBtZZTTJFEeYMcAmd
         dwl7iI66sosJV6h5tmEmdVyIKvIEQ01QFD4om9+g/x8aL3V5+OjhqBoza6KfaYYYHoqo
         /Hd+CnQs2s09wwBkm+QK8mfpVbw89LE2MtT0YZoyftLIuJC6K4yLgpq6/M66aBg9/9Lo
         qt1QjIhvUng/xxUPzsT+b3FnIfxKIUAN3JyfoMeDddX79n0WZBNAwiolZ509Okk7UyLz
         WeXpXgStdF198MTF2pI21AUtcIKQCZMrIdpVQQWc8JYBg7fq1IZq8nExtF1VlDpBtX8y
         ngzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OT9vPn7ycGD7jBjGQjG9ZHBs+GjEiewGN8zg5+tO7oY=;
        b=I9e2Xniq6Jh1CZg+giWPa4TiFiEexi8yoWBzsBTK9P1DGVZDUhAW/HtvsiZiUsesPr
         Ig76sIuVLcwNbjmhAhtcn9QQ8RSb+hp36Xju9Roniqh3KsZyZFbiBWjUgNGktgQd32C0
         utencHxEiXyFz0i6b0OxHmFo+aUykxEmTh2OTh1f+wpxT/lrISMqsamLXLLw7BAmBqt6
         PXAP4T9/qvmy+ZjalAJqzdAgNghOg4A4pr/83KNkTPm+KIU5F4YjgoVy4kVK4P/YL4TX
         trZCNMvf5nj8iJtl9AUDdvLcyyRGlAKUVe64pPOdrKeTSR+INjU/VJ6k7/m0Fha4daKf
         hDEw==
X-Gm-Message-State: APjAAAVX5lmTkgb860wubmWAWRzoGgfWRR+BtHPRz7JOV3whu5k/gFqa
        x5pomIGsailffKS9hg8So3tPPnTXPdX7ICZRpSk=
X-Google-Smtp-Source: APXvYqyKCAJKhdOJh+PbCAnM3MbXA1qxBjY4PetCB75UbrWI078RRPEm92FmplgeX5uxV0Dy0CGCuPMH7iIARo5ZXWI=
X-Received: by 2002:a37:ab04:: with SMTP id u4mr15165699qke.114.1572254142067;
 Mon, 28 Oct 2019 02:15:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1571722391.git.baolin.wang@linaro.org> <487c2e45810c6dc6485638474136e375cb567807.1571722391.git.baolin.wang@linaro.org>
 <50696230-75f4-3de4-7424-c33d531ee159@intel.com> <CAMz4kuJAwV7f=pjUqs1nO3+L5NbcwCQrCi-HGUPPXgp7rWUs=g@mail.gmail.com>
 <CAMz4kuKfqMoM3WdaG8o0JHpXeUZHYpLt4P15BsOriU2h2OV--A@mail.gmail.com> <60aabcc6-9def-1472-0e1f-3fec391ef1cd@intel.com>
In-Reply-To: <60aabcc6-9def-1472-0e1f-3fec391ef1cd@intel.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Mon, 28 Oct 2019 17:15:30 +0800
Message-ID: <CADBw62qf4qM7c-3YWEpo-8o9qw6RD2_G7qqqBDZZC4Ht37SNnA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] mmc: host: sdhci: Add request_done ops for struct sdhci_ops
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Baolin Wang <baolin.wang@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, asutoshd@codeaurora.org,
        Orson Zhai <orsonzhai@gmail.com>,
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

On Mon, Oct 28, 2019 at 5:11 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 28/10/19 10:38 AM, Baolin Wang wrote:
> > On Mon, 28 Oct 2019 at 16:27, Baolin Wang <baolin.wang@linaro.org> wrote:
> >>
> >> Hi Adrian,
> >>
> >> On Mon, 28 Oct 2019 at 16:20, Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>>
> >>> On 22/10/19 8:58 AM, Baolin Wang wrote:
> >>>> Add request_done ops for struct sdhci_ops as a preparation in case some
> >>>> host controllers have different method to complete one request, such as
> >>>> supporting request completion of MMC software queue.
> >>>>
> >>>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> >>>> ---
> >>>>  drivers/mmc/host/sdhci.c |   12 ++++++++++--
> >>>>  drivers/mmc/host/sdhci.h |    2 ++
> >>>>  2 files changed, 12 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> >>>> index b056400..850241f 100644
> >>>> --- a/drivers/mmc/host/sdhci.c
> >>>> +++ b/drivers/mmc/host/sdhci.c
> >>>> @@ -2729,7 +2729,10 @@ static bool sdhci_request_done(struct sdhci_host *host)
> >>>>
> >>>>       spin_unlock_irqrestore(&host->lock, flags);
> >>>>
> >>>> -     mmc_request_done(host->mmc, mrq);
> >>>> +     if (host->ops->request_done)
> >>>> +             host->ops->request_done(host, mrq);
> >>>
> >>> For hsq, couldn't this result in sdhci_request() being called interrupt
> >>> context here.
> >>
> >> Right, now it did not support.
> >>
> >>>
> >>> To prevent that you would need to add a condition to sdhci_defer_done() so
> >>> it always defers when using hsq.
> >>
> >> Yes, but now the condition can be matched in sdhci_defer_done()  when
> >> using hsq. So no need to worry that the sdhci_request() will be called
> >> in interrupt
> >> context in this patch set. Thanks.
> >>
> >
> > Wait, sorry, I realized some drivers may not select the
> > SDHCI_REQ_USE_DMA flag in sdhci_defer_done()  when using hsq. OK, So
> > how about below changes?
> >
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index 850241f..6c7a396 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -3035,7 +3035,7 @@ static inline bool sdhci_defer_done(struct
> > sdhci_host *host,
> >  {
> >         struct mmc_data *data = mrq->data;
> >
> > -       return host->pending_reset ||
> > +       return IS_ENABLED(CONFIG_MMC_HSQ) || host->pending_reset ||
>
> Just because it is configured does not mean it is used.  How about adding a
> variable host->always_defer_done and set it in sdhci_sprd_probe().

Sure, sounds reasonable to me. Thanks.
