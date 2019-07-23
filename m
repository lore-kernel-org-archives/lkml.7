Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17346C76190
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 03:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7A8A2229A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 03:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YhkuphGh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731371AbfGWDbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 23:31:14 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45572 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731320AbfGWDbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 23:31:13 -0400
Received: by mail-ot1-f67.google.com with SMTP id x21so4127761otq.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 20:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZuJsOMP1sWOzyNRASKm1FqxCyfBszTFRMXUcxGZKlTM=;
        b=YhkuphGhxPljuSFa78sx3nQhoK6Y5gGMfv3ar3Rbe9ZOT/1wCT4+pTRYS6yRMkxshj
         +gJmzWnBfUkaRf9LlPDIhag5hAvraMpoMVwTisQyHKSnU0GdET9s7/qSZ5/FXb04n6gw
         xo0AHA5Ln7X+f2s6w0dmuyQo1BJDUv/u9MBPp7LeNhR9xaWMg+/Nl7dNrfXdr9Ciqyu+
         MHE29CgWWIbCK2+lqVPANNs0GLoOBQmrw+uar5N4wW6Vd+PALXN1X0uSWkAii9PWrNPg
         Bn1yKxmcEmCFE3dQggDm0hAhVJyXuLp5K/43TfMKi0Vmtpfsrr3Liiu99maJm/iN5Q6A
         h9wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZuJsOMP1sWOzyNRASKm1FqxCyfBszTFRMXUcxGZKlTM=;
        b=cmzPf/9d20ZBTELI8WzQOkwCqr0Xzc86TMKryZ4sm/apRaIF/SNiD/37FtXmSuL0EJ
         9BUjNYwgQ3D6JFsozE+Lv5UcKdLcAd/ltaMkizm/nTN6vcNJtKdPeXCHpo0sqVQHW/P6
         DPZ7poYsCKzd8EVHuuCxplma8H2XMTVbIOAFOJSCEVXrcaYemLr/WG7p1iaN5JXH1dLj
         Kq9VLOQ+iMGOW4NzSdC+1X6/FmdU2tM18k8YlRW1nzgGs9TRNHrR+/8E/Qjg/6cn648v
         escryfYI9KLF8d7ZtMeoJzuYAafJ8I5fJDTtjOQNp3bi7GF23ubeJL6pVpMTPpZ+LFPC
         00ew==
X-Gm-Message-State: APjAAAWJrfyAIx2iXrHYeLwgDK/1s8eS4UzIUvUjVEms5LsCKaWZ95Kf
        eT5U4hgpbHL+ldR5v4m09dr9hSSXWjVUZyeEPVEQig==
X-Google-Smtp-Source: APXvYqzsAwVOYSW7/1SB7VSKWgabK9ejyGUFaHieaEx7LWJg+Q7uKdonWAt70NYTeBDXz22RgLCiyyE53Fv3qO0Zlhs=
X-Received: by 2002:a9d:7a8b:: with SMTP id l11mr20925635otn.247.1563852672027;
 Mon, 22 Jul 2019 20:31:12 -0700 (PDT)
MIME-Version: 1.0
References: <89c3ef495c367d58ca3abe99a1f82c48f8c08705.1563274904.git.baolin.wang@linaro.org>
 <CAPDyKFq1y6xVfA=b1ybWvA1+e9h9aSteHAHjBbXvXGVJx95FQA@mail.gmail.com>
 <CAMz4kuKraOb_o0LFWnqkS7m0Xd3QGrw1P+md0YBNbbbp1967OA@mail.gmail.com> <CAAfSe-s=Lae-JV_ogAyd355U6X2q0Zr-fhHcMm1=y=So=UTpxw@mail.gmail.com>
In-Reply-To: <CAAfSe-s=Lae-JV_ogAyd355U6X2q0Zr-fhHcMm1=y=So=UTpxw@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 23 Jul 2019 11:30:59 +0800
Message-ID: <CAMz4kuLz8UnREy=rMv0OH1tjOD3v=PYtVuM91HkcS=j7Lia=ZQ@mail.gmail.com>
Subject: Re: [PATCH v4] mmc: host: sdhci-sprd: Fix the incorrect soft reset
 operation when runtime resuming
To:     Chunyan Zhang <zhang.lyra@gmail.com>
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

On Tue, 23 Jul 2019 at 11:21, Chunyan Zhang <zhang.lyra@gmail.com> wrote:
>
> On Tue, 23 Jul 2019 at 11:05, Baolin Wang <baolin.wang@linaro.org> wrote:
> >
> > Hi Ulf,
> >
> > On Mon, 22 Jul 2019 at 19:54, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > On Wed, 17 Jul 2019 at 04:29, Baolin Wang <baolin.wang@linaro.org> wrote:
> > > >
> > > > In sdhci_runtime_resume_host() function, we will always do software reset
> > > > for all, which will cause Spreadtrum host controller work abnormally after
> > > > resuming.
> > >
> > > What does "software reset for all" means?
> >
> > The SD host controller specification defines 3 types software reset:
> > software reset for data line, software reset for command line and
> > software reset for all.
> > Software reset for all means this reset affects the entire Host
> > controller except for the card detection circuit.
> >
> > >
> > > >
> > > > Thus for Spreadtrum platform that will not power down the SD/eMMC card during
> > > > runtime suspend, we should not do software reset for all.
> > >
> > > Normally, sdhci hosts that enters runtime suspend doesn't power off
> > > the card (there are some exceptions like PCI variants).
> >
> > Yes, same as our controller.
> >
> > >
> > > So, what's so special here and how does the reset come into play? I
> > > don't see sdhci doing a reset in sdhci_runtime_suspend|resume_host()
> > > and nor doesn the callback from the sdhci-sprd.c variant doing it.
> >
> > In sdhci_runtime_resume_host(), it will issue sdhci_init(host, 0) to
> > issue software reset for all.
> >
> > >
> > > > To fix this
> > > > issue, adding a specific reset operation that adds one condition to validate
> > > > the power mode to decide if we can do software reset for all or just reset
> > > > command and data lines.
> > > >
> > > > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > > > ---
> > > > Changess from v3:
> > > >  - Use ios.power_mode to validate if the card is power down or not.
> > > >
> > > > Changes from v2:
> > > >  - Simplify the sdhci_sprd_reset() by issuing sdhci_reset().
> > > >
> > > > Changes from v1:
> > > >  - Add a specific reset operation instead of changing the core to avoid
> > > >  affecting other hardware.
> > > > ---
> > > >  drivers/mmc/host/sdhci-sprd.c |   19 ++++++++++++++++++-
> > > >  1 file changed, 18 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> > > > index 603a5d9..94f9726 100644
> > > > --- a/drivers/mmc/host/sdhci-sprd.c
> > > > +++ b/drivers/mmc/host/sdhci-sprd.c
> > > > @@ -373,6 +373,23 @@ static unsigned int sdhci_sprd_get_max_timeout_count(struct sdhci_host *host)
> > > >         return 1 << 31;
> > > >  }
> > > >
> > > > +static void sdhci_sprd_reset(struct sdhci_host *host, u8 mask)
> > > > +{
> > > > +       struct mmc_host *mmc = host->mmc;
> > > > +
> > > > +       /*
> > > > +        * When try to reset controller after runtime suspend, we should not
> > > > +        * reset for all if the SD/eMMC card is not power down, just reset
> > > > +        * command and data lines instead. Otherwise will meet some strange
> > > > +        * behaviors for Spreadtrum host controller.
> > > > +        */
> > > > +       if (host->runtime_suspended && (mask & SDHCI_RESET_ALL) &&
> > > > +           mmc->ios.power_mode == MMC_POWER_ON)
> > > > +               mask = SDHCI_RESET_CMD | SDHCI_RESET_DATA;
> > >
> > > Can sdhci_sprd_reset() be called when the host is runtime suspended?
> >
> > When host tries to runtime resume in sdhci_runtime_resume_host(), it
> > will call reset operation to do software reset.
> >
> > > That sounds like a bug to me, no?
> >
> > Since our controller will meet some strange behaviors if we do
> > software reset for all in sdhci_runtime_resume_host(), and try to
> > avoid changing the core logic of sdhci_runtime_resume_host() used by
> > other hardware controllers, thus I introduced a specific reset ops and
> > added some condition to make sure we just do software reset command
> > and data lines from runtime suspend state.
>
> I can make a verification on sprd's SC9863A, but that would take a
> little time, since I need to make sd card registered with sdhci-sprd.c
> first :)

Great, you can try it on your board. Thanks.

-- 
Baolin Wang
Best Regards
