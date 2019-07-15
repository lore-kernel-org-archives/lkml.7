Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960EEC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 16:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CDE82081C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 16:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NYNAvMcR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731306AbfGOQbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 12:31:53 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:33193 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731069AbfGOQbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 12:31:52 -0400
Received: by mail-vs1-f66.google.com with SMTP id m8so11850388vsj.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 09:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l9coYjSe3XSNr091GZSS9724rWMOjYgkm8g/YPUGrBk=;
        b=NYNAvMcRho+50ikquItIbaA8xyQqZTsW5KuU71/3Q+SoqDVsAy0+FM2d2PDcePt7/n
         11RZxGJC6mTRC4h6FGCGzw5ghhxx3RwnG0GjedgAFNGGoDc3a9QiHq+8ObcMmIqDsmmR
         J3Vsoi/0eyXbw2JYkw6d/qyG0Pcpoe3itkm/WnnZNuH1KiiwADvf3ntPy/+VrYE6PIw6
         uIF81NM9pWUyOV4tcN7jlhU8hIQWnXcFmd8zg9BnmqlN0/rWPA8H02F6iWBLylvyWZNz
         XJSLk/1VCaTu2yjDkpvSOUpRVRh2m0Rv0bmcg2VHCyu5QVYHl7BD6bBxYfh/jlUUzWJe
         HABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l9coYjSe3XSNr091GZSS9724rWMOjYgkm8g/YPUGrBk=;
        b=VcW2VxlUfMWk7ytZg2PH/o5f1jHS9IB4SyGJcvra5/JxmmnSVzztr68l3YHjozpPuV
         1vfDjOGIeTCYwO4bBaLuVeANGD/WnZsfn3xjj6O387abwBOyO+Wb0mRgzEG/VBOOIlIT
         EDSttjIwSAA9TjqzVqZhRVeQtlxpqgwjNuZbWqrixpdZqpiVWF4OHcdj4lOoIH3sTxBc
         R9KUTXGQ9qHRTEVnmG0cJrFqVoA0MPWOrhmenQ6+tFZnpnSkFlS3ROm/wbMjmSTel9ZZ
         2ZlvOMqOZ8l8jeK/xSa2n2TLSUSugqmdvNiwjMP77SOZkftuTOUO10LShqDp1KKlWoJo
         ZnEQ==
X-Gm-Message-State: APjAAAW2zY0sSfBRDVrfKyml3KC6XfeFXsApdIRBEDP7lT6Ye7JcuC7H
        L+9rDFtd6NMaRq6bNQgC756Z/MedAVdL31orzgK45g==
X-Google-Smtp-Source: APXvYqyUVL5RPnQWYVDvWMTPG8b/y4kpVO36hdyZcWBMkgiuUbpz8JwBx7OzH4gYy2hAxp1kCITo99T3NjrGPMBeorE=
X-Received: by 2002:a67:7a90:: with SMTP id v138mr16907417vsc.200.1563208311475;
 Mon, 15 Jul 2019 09:31:51 -0700 (PDT)
MIME-Version: 1.0
References: <1559577325-19266-1-git-send-email-ludovic.Barre@st.com> <1559577325-19266-2-git-send-email-ludovic.Barre@st.com>
In-Reply-To: <1559577325-19266-2-git-send-email-ludovic.Barre@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 15 Jul 2019 18:31:15 +0200
Message-ID: <CAPDyKFpJPbpTnfA2cynFURyxFY_YCm7MRXw3m2nQyU+z=ZWsFA@mail.gmail.com>
Subject: Re: [PATCH V3 1/3] mmc: mmci: fix read status for busy detect
To:     Ludovic Barre <ludovic.Barre@st.com>
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

On Mon, 3 Jun 2019 at 17:55, Ludovic Barre <ludovic.Barre@st.com> wrote:
>
> From: Ludovic Barre <ludovic.barre@st.com>
>
> "busy_detect_flag" is used to read & clear busy value of mmci status.
> "busy_detect_mask" is used to manage busy irq of mmci mask.
> So to read mmci status the busy_detect_flag must be take account.
> if the variant does not support busy detect feature the flag is null
> and there is no impact.

By reading the changelog, it doesn't tell me the purpose of this
change. When going forward, please work harder on your changelogs.

Make sure to answer the questions, *why* is this change needed,
*what/how* does the change do.

>
> Not need to re-read the status register in mmci_cmd_irq, the
> status parameter can be used.
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  drivers/mmc/host/mmci.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 356833a..5b5cc45 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -1240,7 +1240,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
>                  */
>                 if (!host->busy_status &&
>                     !(status & (MCI_CMDCRCFAIL|MCI_CMDTIMEOUT)) &&
> -                   (readl(base + MMCISTATUS) & host->variant->busy_detect_flag)) {
> +                   (status & host->variant->busy_detect_flag)) {

I suggested you to do this change through some of my earlier comments,
however I think it should be made as a stand alone change.

Anyway, when looking at the details in your series, I decided to try
to help out a bit, so I have prepared a couple of related patches for
cleaning up and clarifying the busy detection code/comments in mmci. I
have incorporated the above change, so let me post them asap.

>
>                         /* Clear the busy start IRQ */
>                         writel(host->variant->busy_detect_mask,
> @@ -1517,7 +1517,8 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
>                  * to make sure that both start and end interrupts are always
>                  * cleared one after the other.
>                  */
> -               status &= readl(host->base + MMCIMASK0);
> +               status &= readl(host->base + MMCIMASK0) |
> +                       host->variant->busy_detect_flag;

As I told earlier in the review, this looks wrong to me.

It means that you will add the bit for the ->busy_detect_flag to the
status field we have just read from the MMCISTATUS register. That
means the busy status may be set when it shouldn't.

>                 if (host->variant->busy_detect)
>                         writel(status & ~host->variant->busy_detect_mask,
>                                host->base + MMCICLEAR);
> --
> 2.7.4
>

By looking at the other changes in the series, I assume @subject patch
is intended to prepare for the other changes on top. But it's not
really clear.

Anyway, in that regards, the below is my observations of what seems to
be important part, when supporting busy detection for the stm32 sdmmc
variant (except the timeout things in patch2, which I intend to
comment separately on).

I figured, these are the involved register bits/masks:

MMCISTATUS:
MCI_STM32_BUSYD0 BIT(20)
MCI_STM32_BUSYD0END BIT(21)

MMCIMASK0:
MCI_STM32_BUSYD0ENDMASK BIT(21)

For the legacy ST variant, there is only one register bit in
MMCISTATUS that is used for indicating busy (MCI_ST_CARDBUSY BIT(24)).
There is no dedicated busy-end bit for the busy-end IRQ, which I
believe is the reason to why the current code also is bit messy.

It seems like the stm32 sdmmc variant have a separate status bit for
the busy-end IRQ, correct?

If I understand correctly by looking at patch3, you don't use the
dedicated busy-end status bit (MCI_STM32_BUSYD0END), right? Then why
not?

Thoughts?

Kind regards
Uffe
