Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F15C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 293E520675
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J69ncogA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730012AbfDYVdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 17:33:08 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:38126 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbfDYVdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 17:33:08 -0400
Received: by mail-vs1-f65.google.com with SMTP id s2so758439vsi.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 14:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U01nqPAZCX/oH66gDds3hxiIdIZOHSWpwWqAJ0DDR3s=;
        b=J69ncogArYKLv2j9VwUUeWGPPKUAF//c7+OBM7Q9oXXStXpPwLOtFkEqQZPhRPBf+1
         oXN3lK59/CnkIl7SFq3n/AAY8s3mXAAHwSEWFG1VcK+X/MOU44hL4gZlt551sTNQS00M
         8RSBW3W7nxSIZOReIKVRL/u3hLnNc5lJEVLx6nsQGf6CFckHFtPLk6PWZPXKrsOlnYSN
         0audhEDCt7ktY1s95BJCkcxNPDg9+pEy2LQ2gGplffvff5U1+nrpVqVKtsnLdUdISqKW
         9ZjKENBTTWj2lZAinZykm7EW53+py4pM9CFnLeHlGWalJi0rS7oo/CdazPhS1Fi4NarH
         Nz0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U01nqPAZCX/oH66gDds3hxiIdIZOHSWpwWqAJ0DDR3s=;
        b=hj9yXfr+MyiwOt9FUEoQWH6pSrBdK55T21zCL5p9m4/21ful1soFrcwYdEFRzQlHe5
         S7Rd7YGrlbrvWtUEfqIgDRYbvGRRMNQcylO9OWIjIUD6dLTOytLxCqIyv2oY7L9Bzsot
         fmrp6YJ4hTvTqrV0tn6nLv8U6miY4nm3tkG2OlCif3icPcrHLCApi1aDubEtJI+pJxwk
         rSNiI5N4bRAyZnHctJACSj7+x1pO3BFjCzuWQ5o8jafOd9GLPXf3crxJLObM1XUWYm2U
         wB/cyWCv6/WnVuSa6F7mE784Rmm2O4pDnMxGMDHZTx0j8+qCUUipCWyOW0Pr+VMB5csp
         3epQ==
X-Gm-Message-State: APjAAAWP+XitMgCRuX2u6JOG861/zZzq0xe68p+wD6/uL0WgE4PsllUs
        2N6TTcd6E6MJecpdU8h4sr8NNYFsVGx4vchaw83hTw==
X-Google-Smtp-Source: APXvYqxjix90NtybU2vbW19hzHyh2eWwXVX+6rZWCUn4kkSrm9jpMo9bIidi0r6av8J55qKGuvHJ+1KF9l/YNWZKBto=
X-Received: by 2002:a67:cb12:: with SMTP id b18mr6007921vsl.191.1556227986922;
 Thu, 25 Apr 2019 14:33:06 -0700 (PDT)
MIME-Version: 1.0
References: <1551802205-32188-1-git-send-email-ludovic.Barre@st.com>
 <1551802205-32188-2-git-send-email-ludovic.Barre@st.com> <CAPDyKFoZuQ+hshZpj-qjchKf7enW4ChPd=r_QhK2xtuJcSvqxQ@mail.gmail.com>
 <fd57fd63-093e-dd23-5ca4-6bd4f99ecda9@st.com> <CAPDyKFrmTX6w1ZgwBkEmieCQ5swUQx_O864mHofhNsz3LFC32A@mail.gmail.com>
 <30eae958-fd66-96a2-52a2-661c0646a302@st.com>
In-Reply-To: <30eae958-fd66-96a2-52a2-661c0646a302@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 25 Apr 2019 23:32:30 +0200
Message-ID: <CAPDyKFr_SNVrnZy74bOa_f46yb8CcEozvFu=wdhSz9=Zme=XAw@mail.gmail.com>
Subject: Re: [PATCH 1/4] mmc: mmci: avoid fake busy polling
To:     Ludovic BARRE <ludovic.barre@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Apr 2019 at 16:09, Ludovic BARRE <ludovic.barre@st.com> wrote:
>
>
> On 4/25/19 12:08 PM, Ulf Hansson wrote:
> > On Thu, 25 Apr 2019 at 11:22, Ludovic BARRE <ludovic.barre@st.com> wrote:
> >>
> >> hi Ulf
> >>
> >> On 4/23/19 3:39 PM, Ulf Hansson wrote:
> >>> On Tue, 5 Mar 2019 at 17:10, Ludovic Barre <ludovic.Barre@st.com> wrote:
> >>>>
> >>>> From: Ludovic Barre <ludovic.barre@st.com>
> >>>>
> >>>> The busy status bit could occurred even if no busy response is
> >>>> expected (example cmd11). On sdmmc variant, the busy_detect_flag
> >>>> reflects inverted value of d0 state, it's sampled at the end of a
> >>>> CMD response and a second time 2 clk cycles after the CMD response.
> >>>> To avoid a fake busy, the busy status could be checked and polled
> >>>> only if the command has RSP_BUSY flag.
> >>>
> >>> I would appreciate a better explanation of what this patch really changes.
> >>>
> >>> The above is giving some background to the behavior of sdmmc variant,
> >>> but at this point that variant doesn't even have the
> >>> ->variant->busy_detect flag set.
> >>>
> >>
> >> Yes, I will try to explain more and focus on common behavior.
> >>
> >>>>
> >>>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> >>>> ---
> >>>>    drivers/mmc/host/mmci.c | 19 +++++++++++++------
> >>>>    1 file changed, 13 insertions(+), 6 deletions(-)
> >>>>
> >>>> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> >>>> index 387ff14..4901b73 100644
> >>>> --- a/drivers/mmc/host/mmci.c
> >>>> +++ b/drivers/mmc/host/mmci.c
> >>>> @@ -1220,12 +1220,13 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
> >>>>                unsigned int status)
> >>>>    {
> >>>>           void __iomem *base = host->base;
> >>>> -       bool sbc;
> >>>> +       bool sbc, busy_resp;
> >>>>
> >>>>           if (!cmd)
> >>>>                   return;
> >>>>
> >>>>           sbc = (cmd == host->mrq->sbc);
> >>>> +       busy_resp = !!(cmd->flags & MMC_RSP_BUSY);
> >>>>
> >>>>           /*
> >>>>            * We need to be one of these interrupts to be considered worth
> >>>> @@ -1239,8 +1240,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
> >>>>           /*
> >>>>            * ST Micro variant: handle busy detection.
> >>>>            */
> >>>> -       if (host->variant->busy_detect) {
> >>>> -               bool busy_resp = !!(cmd->flags & MMC_RSP_BUSY);
> >>>> +       if (busy_resp && host->variant->busy_detect) {
> >>>>
> >>>>                   /* We are busy with a command, return */
> >>>>                   if (host->busy_status &&
> >>>> @@ -1253,7 +1253,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
> >>>>                    * that the special busy status bit is still set before
> >>>>                    * proceeding.
> >>>>                    */
> >>>> -               if (!host->busy_status && busy_resp &&
> >>>> +               if (!host->busy_status &&
> >>>>                       !(status & (MCI_CMDCRCFAIL|MCI_CMDTIMEOUT)) &&
> >>>>                       (readl(base + MMCISTATUS) & host->variant->busy_detect_flag)) {
> >>>
> >>> All the changes above makes perfect sense to me, but looks more like a
> >>> cleanup of the code, rather than actually changing the behavior.
> >>
> >> yes, few changing (this just avoid to enter in
> >> "if (host->variant->busy_detect)") at each time.
> >> I could move this part in cleanup patch (before this patch)
> >
> > Sounds good to me!
> >
> >>
> >>>
> >>>>
> >>>> @@ -1508,6 +1508,7 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
> >>>>    {
> >>>>           struct mmci_host *host = dev_id;
> >>>>           u32 status;
> >>>> +       bool busy_resp;
> >>>>           int ret = 0;
> >>>>
> >>>>           spin_lock(&host->lock);
> >>>> @@ -1550,9 +1551,15 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
> >>>>                   }
> >>>>
> >>>>                   /*
> >>>> -                * Don't poll for busy completion in irq context.
> >>>> +                * Don't poll for:
> >>>> +                * -busy completion in irq context.
> >>>> +                * -no busy response expected.
> >>>>                    */
> >>>> -               if (host->variant->busy_detect && host->busy_status)
> >>>> +               busy_resp = host->cmd ?
> >>>> +                       !!(host->cmd->flags & MMC_RSP_BUSY) : false;
> >>>
> >>> This doesn't make sense to me, but I may be missing something.
> >>>
> >>> host->busy_status is being updated by mmci_cmd_irq() and only when
> >>> MMC_RSP_BUSY is set for the command in flight. In other words,
> >>> checking for MMC_RSP_BUSY here as well is redundant. No?
> >>
> >> In mmci_irq the "do while" loops until the status is totally cleared.
> >>
> >> Today (for variant with busy_detect option), the status busy_detect_flag
> >> is excluded only while busy_status period (command with MMC_RSP_BUSY and
> >> while busy line is low => "busy_status=1")
> >>
> >> On SDMMC variant I noticed that busy_detect_flag status could be enabled
> >> even if the command is not MMC_RSP_BUSY, for example sdmmc variant stay
> >> in loop while cmd11 voltage switch.
> >
> > Right, I see.
> >
> >>
> >> So I wish extend host->variant->busy_detect_flag exclusion for all
> >> commands which is not a MMC_RSP_BUSY. I suppose that other variants
> >> could have the same behavior, and else there is no impact, normally.
> >
> > I am guessing this is because the variant->busy_dpsm_flag has been set
> > in the datactrl register, which is needed for mmci_card_busy().
> >
> > That said, I am kind of wondering if we ever should need repeat the
> > while loop if 'status' contains the bit for
> > host->variant->busy_detect_flag. I mean we have already called
> > mmci_cmd_irq() to handle it.
> >
> > So, couldn't we just always do:
> >
> > if (host->variant->busy_detect_flag)
> >      status &= ~host->variant->busy_detect_flag;
> >
> > No?
>
> yes that make sense, I launched tests on sdmmc and it's ok.
> I think, that we could take on this solution.

Great!

>
> If it's ok for you, I resend a series with all modifications.

Yes, please do. I haven't reviewed the rest of the series yet, but it
may be better to do that when the next version is ready.

In either case, I should have some time to run some tests of the next
version, if you manage to send it within a couple of days or so.

[...]

Kind regards
Uffe
