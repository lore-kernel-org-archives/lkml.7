Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98104C76186
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 03:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E5CF22BE8
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 03:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wW/5ijOd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389596AbfGYDFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 23:05:16 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44200 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389521AbfGYDFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 23:05:16 -0400
Received: by mail-ot1-f67.google.com with SMTP id b7so11632975otl.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 20:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7YqQWdWyLdx/7Jo8zbGSU76CfF5JW0ZptZZjg1FuwJs=;
        b=wW/5ijOdvgbK69+lG02EAXppP9uH7bwvhZHQ5gzuyQHKHsW5a2spaTygQvxjXV3Mp8
         KMvlcjj5MuUIQnP5wLx31EFx5b2TxSw1FbOn0ZARjR3ZNgOBIxfeJIR2ybRF7UxEyR43
         ka0LbmcHpxNW/ROu5k1F9mBghUv6m8IPDFtmO1V7O4achua2PX8gQkAoAsDcSxFGZJ7r
         A+29loLOK3nWWaY4+cBa/AKVaJIokh+jW7l9FLIEVwr29Uy459VGKjbaTIcZ/OKajLaz
         KhOFub1ohehhmPJqILdAZ5jQsfxJBdXXTZb20ejHFYOPDk3AwowpNdOPN95dQ3L80ipQ
         zkCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7YqQWdWyLdx/7Jo8zbGSU76CfF5JW0ZptZZjg1FuwJs=;
        b=VqCvzTH5ML6CP3a/FLF/0S5P3cs4aHFl0NKnmEoIoqBirMz3LDCDgVAeHIgKF+pOoY
         WLU0kb4Up4O7iDWkSNKVDcNrzn7snxt5yC5HY4EyHB2TVWOqfR7PIgjAh2724u8bA7HL
         GtCKjTivEXrHJ+HkgebyU1DwLY8JcfXq0jGVcsYWzo9K56Bh1eq8wVH3n84foJATjqaA
         V4r+/vp4JPFX6O69yP4qW8Og69TyjLao56AzK+yYssUSLxyOJ6t+9s1TQlWXGWurufni
         0Si2bcbiEIBgGJXtKN2PipdjytvYC+5tUO38cGlxrYWoLzqe8gJxDvPDThWowYD2XdgP
         iN/g==
X-Gm-Message-State: APjAAAWRYntNXdUpXcxyFacKqrQ6/mSNSPFF93B5ptRcw93yBj93bx3t
        /fsP6Q5mchZme8utPqOjde9k7yqqIAvoC5izDaZoNg==
X-Google-Smtp-Source: APXvYqxc34rNjekcX3zQgo0OG5siFWlbIIrcSj53rbVexbw17Bh7DwhBq9OMLItBdGDjhtJzo9lIIuhIyzBXMTOmjU4=
X-Received: by 2002:a9d:529:: with SMTP id 38mr63434037otw.145.1564023915173;
 Wed, 24 Jul 2019 20:05:15 -0700 (PDT)
MIME-Version: 1.0
References: <89c3ef495c367d58ca3abe99a1f82c48f8c08705.1563274904.git.baolin.wang@linaro.org>
 <CAPDyKFq1y6xVfA=b1ybWvA1+e9h9aSteHAHjBbXvXGVJx95FQA@mail.gmail.com>
 <CAMz4kuKraOb_o0LFWnqkS7m0Xd3QGrw1P+md0YBNbbbp1967OA@mail.gmail.com>
 <CAPDyKFpy5JeGZ2w1KJN0ECB6jPG=UTZXbPRjMQQs8+NdK4rxuQ@mail.gmail.com>
 <CAMz4ku+ZTtnJdonZVAPVuvAiGCmCESvM8SbYKjwpNUgE4bO3gA@mail.gmail.com> <d9e90c5f-1939-b07a-ba85-8b61e3df10c6@intel.com>
In-Reply-To: <d9e90c5f-1939-b07a-ba85-8b61e3df10c6@intel.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Thu, 25 Jul 2019 11:05:03 +0800
Message-ID: <CAMz4kuJvUHWwrLOxb=HjULzktue6Awg3VvEGhpJ4Y9t-_xLoKw@mail.gmail.com>
Subject: Re: [PATCH v4] mmc: host: sdhci-sprd: Fix the incorrect soft reset
 operation when runtime resuming
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
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

On Wed, 24 Jul 2019 at 20:56, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 24/07/19 5:21 AM, Baolin Wang wrote:
> > On Tue, 23 Jul 2019 at 20:39, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >>
> >> On Tue, 23 Jul 2019 at 05:05, Baolin Wang <baolin.wang@linaro.org> wrote:
> >>>
> >>> Hi Ulf,
> >>>
> >>> On Mon, 22 Jul 2019 at 19:54, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >>>>
> >>>> On Wed, 17 Jul 2019 at 04:29, Baolin Wang <baolin.wang@linaro.org> wrote:
> >>>>>
> >>>>> In sdhci_runtime_resume_host() function, we will always do software reset
> >>>>> for all, which will cause Spreadtrum host controller work abnormally after
> >>>>> resuming.
> >>>>
> >>>> What does "software reset for all" means?
> >>>
> >>> The SD host controller specification defines 3 types software reset:
> >>> software reset for data line, software reset for command line and
> >>> software reset for all.
> >>> Software reset for all means this reset affects the entire Host
> >>> controller except for the card detection circuit.
> >>
> >> Thanks for clarifying, please update the changelog accordingly.
> >
> > Sure, sorry for confusing.
> >
> >>
> >>>
> >>>>
> >>>>>
> >>>>> Thus for Spreadtrum platform that will not power down the SD/eMMC card during
> >>>>> runtime suspend, we should not do software reset for all.
> >>>>
> >>>> Normally, sdhci hosts that enters runtime suspend doesn't power off
> >>>> the card (there are some exceptions like PCI variants).
> >>>
> >>> Yes, same as our controller.
> >>>
> >>>>
> >>>> So, what's so special here and how does the reset come into play? I
> >>>> don't see sdhci doing a reset in sdhci_runtime_suspend|resume_host()
> >>>> and nor doesn the callback from the sdhci-sprd.c variant doing it.
> >>>
> >>> In sdhci_runtime_resume_host(), it will issue sdhci_init(host, 0) to
> >>> issue software reset for all.
> >>
> >> Aha, I didn't read the code carefully enough. Apologize for the noise.
> >
> > No worries :)
> >
> >>>
> >>>>
> >>>>> To fix this
> >>>>> issue, adding a specific reset operation that adds one condition to validate
> >>>>> the power mode to decide if we can do software reset for all or just reset
> >>>>> command and data lines.
> >>>>>
> >>>>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> >>>>> ---
> >>>>> Changess from v3:
> >>>>>  - Use ios.power_mode to validate if the card is power down or not.
> >>>>>
> >>>>> Changes from v2:
> >>>>>  - Simplify the sdhci_sprd_reset() by issuing sdhci_reset().
> >>>>>
> >>>>> Changes from v1:
> >>>>>  - Add a specific reset operation instead of changing the core to avoid
> >>>>>  affecting other hardware.
> >>>>> ---
> >>>>>  drivers/mmc/host/sdhci-sprd.c |   19 ++++++++++++++++++-
> >>>>>  1 file changed, 18 insertions(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> >>>>> index 603a5d9..94f9726 100644
> >>>>> --- a/drivers/mmc/host/sdhci-sprd.c
> >>>>> +++ b/drivers/mmc/host/sdhci-sprd.c
> >>>>> @@ -373,6 +373,23 @@ static unsigned int sdhci_sprd_get_max_timeout_count(struct sdhci_host *host)
> >>>>>         return 1 << 31;
> >>>>>  }
> >>>>>
> >>>>> +static void sdhci_sprd_reset(struct sdhci_host *host, u8 mask)
> >>>>> +{
> >>>>> +       struct mmc_host *mmc = host->mmc;
> >>>>> +
> >>>>> +       /*
> >>>>> +        * When try to reset controller after runtime suspend, we should not
> >>>>> +        * reset for all if the SD/eMMC card is not power down, just reset
> >>>>> +        * command and data lines instead. Otherwise will meet some strange
> >>>>> +        * behaviors for Spreadtrum host controller.
> >>>>> +        */
> >>>>> +       if (host->runtime_suspended && (mask & SDHCI_RESET_ALL) &&
> >>>>> +           mmc->ios.power_mode == MMC_POWER_ON)
> >>>>> +               mask = SDHCI_RESET_CMD | SDHCI_RESET_DATA;
> >>>>
> >>>> Can sdhci_sprd_reset() be called when the host is runtime suspended?
> >>>
> >>> When host tries to runtime resume in sdhci_runtime_resume_host(), it
> >>> will call reset operation to do software reset.
> >>
> >> Right, I see that now, thanks for clarifying.
> >>
> >> However, there are still some weird things going on in
> >> sdhci_runtime_resume_host(). Like why is host->ops->enable_dma()
> >> called first, directly from sdhci_runtime_resume_host(), then again in
> >> sdhci_do_reset(), after host->ops->reset() has been called. Looks like
> >> the first call to ->enable_dma() doesn't make sense?
> >
> > I am mot sure, since our host did not supply enable_dma() operation.
> > This logic was used by some other hardware and worked well, I am not
> > sure if it can reveal some issues if we change the logic here.
> >
> > Adrian, could you help to explain why we put enable_dma() in front of
> > software reset?
>
> No reason I can see.  But if you add a parameter to avoid a full reset, then
> the ->enable_dma will be needed in that case.

OK. I'll keep it.

>
> >
> >>
> >>>
> >>>> That sounds like a bug to me, no?
> >>>
> >>> Since our controller will meet some strange behaviors if we do
> >>> software reset for all in sdhci_runtime_resume_host(), and try to
> >>> avoid changing the core logic of sdhci_runtime_resume_host() used by
> >>> other hardware controllers, thus I introduced a specific reset ops and
> >>> added some condition to make sure we just do software reset command
> >>> and data lines from runtime suspend state.
> >>
> >> I understand, but perhaps it would become more clear if
> >> sdhci_runtime_resume_host() is re-factored a bit. Maybe the caller can
> >> give it some new parameter to let it decide if a SDHCI_RESET_ALL shall
> >> be done or not.
> >
> > Yes, sounds reasonable, but need change other host drivers which
> > issued the sdhci_runtime_resume_host().
> >
> > Adrian, if you also agree with Ulf's suggestion, then I will post new
> > patches to add a parameter to decide the reset mode. Thanks.
>
> Sounds fine.

OK. Thanks for your input.

-- 
Baolin Wang
Best Regards
