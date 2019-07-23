Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F07C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 03:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8630C21738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 03:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUadnbS6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730369AbfGWDVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 23:21:43 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46452 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfGWDVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 23:21:42 -0400
Received: by mail-wr1-f66.google.com with SMTP id z1so41419813wru.13;
        Mon, 22 Jul 2019 20:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y3d4DOmXlkymFoiXcebxZGUUkG35ygxN6FhpdOM4tcw=;
        b=GUadnbS60UOnLG7QbjHT0gTNgfshYyzFlvGI+lhUahrLLSH2l5POvnsSdlEQ42JpwN
         1wJr6Kk/J+WwAD6LSd1XbRKWUuEtgUjVevS6iGNH7QLjWm/pgYk13cUro5uDYPTPSyHg
         wFGEY7Hivl2kXRNYGYBdw5vcX6v/uvjlQ2+BzFYcF0eru51EW4Tm9dvWh6uPcudW1Uil
         SscEvWFZfBrkGId/hyUdl2emwc9AWgyZym5DvY1Yft+J7RxouyqXdKs2dvQKiGVloq60
         hagxibZYjGeUpnUqUGknCmO78qUplO+4xt8pcfFgRgTbAs73oQsiaJN6EFgr72opYBJy
         FyPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y3d4DOmXlkymFoiXcebxZGUUkG35ygxN6FhpdOM4tcw=;
        b=YLoFS8x3PydKHVr5H7hh4hOeJ8xzpFsAaBP/XXRNlitYweYQwk6tgQyD9QgjQ3kSbH
         VHP/Rlrr/y9PEkU6ot1HRN6D80GUJKrJ7l+Ax0hUaMSCGYEa1L/SgPMUTe98JWXVDRqD
         BGNoURcTy3w4VQe9Vc5BZUBBNTvr35dPk9nwPq+KhLB19/BHPcrOtiXFcGZmxYuJgm/2
         WbcJTOhiPlgFfE+Yz5nYDyVc7wyNs5+V8hFKZWNyQ/22n6t05/A+sEm/DZpJg0sHQJeO
         Ah+rmh/XSbNpqJHUvoFM1nAYHj+capaa199mifeXvD+W0pGaSFT8NTFodPF/ehn86CyZ
         POYA==
X-Gm-Message-State: APjAAAW76A9HWCSbPwoEDPhlCZbgRgW/+ATj4PwfHQjUmGBGW2zOappB
        rUw3oDBNXoFDoEXkapDCdPhlCaR3oe9p2555Sqs=
X-Google-Smtp-Source: APXvYqygKMZPmLXYU5aPZEoLbXkTYJG3b0I8FeQ90WNmNse6STW6wf+JbojI31z1cW+S7M7hHXUaMKVx4y6UoXENauw=
X-Received: by 2002:a5d:6389:: with SMTP id p9mr50035409wru.297.1563852099949;
 Mon, 22 Jul 2019 20:21:39 -0700 (PDT)
MIME-Version: 1.0
References: <89c3ef495c367d58ca3abe99a1f82c48f8c08705.1563274904.git.baolin.wang@linaro.org>
 <CAPDyKFq1y6xVfA=b1ybWvA1+e9h9aSteHAHjBbXvXGVJx95FQA@mail.gmail.com> <CAMz4kuKraOb_o0LFWnqkS7m0Xd3QGrw1P+md0YBNbbbp1967OA@mail.gmail.com>
In-Reply-To: <CAMz4kuKraOb_o0LFWnqkS7m0Xd3QGrw1P+md0YBNbbbp1967OA@mail.gmail.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Tue, 23 Jul 2019 11:21:03 +0800
Message-ID: <CAAfSe-s=Lae-JV_ogAyd355U6X2q0Zr-fhHcMm1=y=So=UTpxw@mail.gmail.com>
Subject: Re: [PATCH v4] mmc: host: sdhci-sprd: Fix the incorrect soft reset
 operation when runtime resuming
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jul 2019 at 11:05, Baolin Wang <baolin.wang@linaro.org> wrote:
>
> Hi Ulf,
>
> On Mon, 22 Jul 2019 at 19:54, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Wed, 17 Jul 2019 at 04:29, Baolin Wang <baolin.wang@linaro.org> wrote:
> > >
> > > In sdhci_runtime_resume_host() function, we will always do software reset
> > > for all, which will cause Spreadtrum host controller work abnormally after
> > > resuming.
> >
> > What does "software reset for all" means?
>
> The SD host controller specification defines 3 types software reset:
> software reset for data line, software reset for command line and
> software reset for all.
> Software reset for all means this reset affects the entire Host
> controller except for the card detection circuit.
>
> >
> > >
> > > Thus for Spreadtrum platform that will not power down the SD/eMMC card during
> > > runtime suspend, we should not do software reset for all.
> >
> > Normally, sdhci hosts that enters runtime suspend doesn't power off
> > the card (there are some exceptions like PCI variants).
>
> Yes, same as our controller.
>
> >
> > So, what's so special here and how does the reset come into play? I
> > don't see sdhci doing a reset in sdhci_runtime_suspend|resume_host()
> > and nor doesn the callback from the sdhci-sprd.c variant doing it.
>
> In sdhci_runtime_resume_host(), it will issue sdhci_init(host, 0) to
> issue software reset for all.
>
> >
> > > To fix this
> > > issue, adding a specific reset operation that adds one condition to validate
> > > the power mode to decide if we can do software reset for all or just reset
> > > command and data lines.
> > >
> > > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > > ---
> > > Changess from v3:
> > >  - Use ios.power_mode to validate if the card is power down or not.
> > >
> > > Changes from v2:
> > >  - Simplify the sdhci_sprd_reset() by issuing sdhci_reset().
> > >
> > > Changes from v1:
> > >  - Add a specific reset operation instead of changing the core to avoid
> > >  affecting other hardware.
> > > ---
> > >  drivers/mmc/host/sdhci-sprd.c |   19 ++++++++++++++++++-
> > >  1 file changed, 18 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> > > index 603a5d9..94f9726 100644
> > > --- a/drivers/mmc/host/sdhci-sprd.c
> > > +++ b/drivers/mmc/host/sdhci-sprd.c
> > > @@ -373,6 +373,23 @@ static unsigned int sdhci_sprd_get_max_timeout_count(struct sdhci_host *host)
> > >         return 1 << 31;
> > >  }
> > >
> > > +static void sdhci_sprd_reset(struct sdhci_host *host, u8 mask)
> > > +{
> > > +       struct mmc_host *mmc = host->mmc;
> > > +
> > > +       /*
> > > +        * When try to reset controller after runtime suspend, we should not
> > > +        * reset for all if the SD/eMMC card is not power down, just reset
> > > +        * command and data lines instead. Otherwise will meet some strange
> > > +        * behaviors for Spreadtrum host controller.
> > > +        */
> > > +       if (host->runtime_suspended && (mask & SDHCI_RESET_ALL) &&
> > > +           mmc->ios.power_mode == MMC_POWER_ON)
> > > +               mask = SDHCI_RESET_CMD | SDHCI_RESET_DATA;
> >
> > Can sdhci_sprd_reset() be called when the host is runtime suspended?
>
> When host tries to runtime resume in sdhci_runtime_resume_host(), it
> will call reset operation to do software reset.
>
> > That sounds like a bug to me, no?
>
> Since our controller will meet some strange behaviors if we do
> software reset for all in sdhci_runtime_resume_host(), and try to
> avoid changing the core logic of sdhci_runtime_resume_host() used by
> other hardware controllers, thus I introduced a specific reset ops and
> added some condition to make sure we just do software reset command
> and data lines from runtime suspend state.

I can make a verification on sprd's SC9863A, but that would take a
little time, since I need to make sd card registered with sdhci-sprd.c
first :)

Thanks,
Chunyan
