Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECEFC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45CFB20657
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MKmOnc6r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbfCFRD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 12:03:56 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45028 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbfCFRD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 12:03:56 -0500
Received: by mail-pg1-f196.google.com with SMTP id j3so8879281pgm.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 09:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YiE0C9rB0X9qdq2q/pQyvDknkZ/AT2mZbxMfrOYFXCI=;
        b=MKmOnc6rYJUSFYO7qFwf/sP1JYQzN7eaG26KStS36t+V9KpAIZ7+y1hd26trMQhbqb
         yyPdAunP6hd2IWTyRFE7iC60nxZMd8RhbgIimFDq/vYpUn52u4GFUYXJ5Fu9vVEgDdMi
         z3uhSv0Uj2m1+ZJ4zAXPITXyWRjS+uNYejebmPFqEoD17xco1e3hAHO8Q/MZRcrOXHhA
         L0iwP+UblVtBw2SuSDsZG4gqEtp9+tfXWX3ziUCy4USEUYrYW4ta3rrxs+Ih5NOtLXbb
         anN3FBjFpcqwlaSby+hhKwuI+6E9L+5cIuqznoqlWUtRy6C42V50M1h+akDdoYuOrtRV
         Vqag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YiE0C9rB0X9qdq2q/pQyvDknkZ/AT2mZbxMfrOYFXCI=;
        b=Sfpaa5/In1PigxrCqgzATgJgsqWZ06vLzRZ5+SLNOSkzCfHlUhQ2BEOzl3P4HIVG7k
         RqtGLLPd7fe3TnTQhRPSbNFdsw6OnAlZCMMZUlobOyb+GX5NNIQ2NxIfPngNMzzB25gb
         RO/RIow1mpV+BOm6KCy5Lk33eF0jXWpiMua1wsiDJBBcm1Ssi/OuBFD9N/UlktGoz1JC
         UBXZvQ1eUx9TGdxLy5zkDbaqGpgDT2ibwbypbHz8sWPj211aK8/w8IbCjag4fvjN7M3a
         YDfa31ks1eWrvRNh561bzPmvmQ8BXg5tKMuL2e564TOsXXkoohoxVFoivFWTJM2vQCiS
         9KFQ==
X-Gm-Message-State: APjAAAXl6h/CXpwg1lbLKC5F65sI8DFsOGYSlbBkw0NSfUmcF5FwBxb1
        su/INGK88ngZQOpGRpnduSgQDw==
X-Google-Smtp-Source: APXvYqwY8B+nEmufUu/9ta0m8tXf7tQPgYwAVFD4PkSVT+7zhbtpS3AbjeUXGFm8S4pG+MawBPwPwQ==
X-Received: by 2002:a63:ea48:: with SMTP id l8mr6972853pgk.431.1551891834056;
        Wed, 06 Mar 2019 09:03:54 -0800 (PST)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id p2sm3038555pgs.7.2019.03.06.09.03.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 09:03:53 -0800 (PST)
Date:   Wed, 6 Mar 2019 09:03:51 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Chris Ball <chris@printf.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Russell King <linux@arm.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 1/3] mmc: mmci: Support any block sizes for ux500v2
 and qcom variant
Message-ID: <20190306170351.GB3522@tuxbook-pro>
References: <1408683219-7939-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1408683272-7984-1-git-send-email-srinivas.kandagatla@linaro.org>
 <CACRpkdZtUJim0d0iC26d-Z8xBckdCX7uwh_v4PhJSKkHEcmmrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdZtUJim0d0iC26d-Z8xBckdCX7uwh_v4PhJSKkHEcmmrw@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 05 Mar 14:25 PST 2019, Linus Walleij wrote:

> Sorry for top-posting, patch included for context.
> 
> I saw today that Brian has the Nexus 5 working with Broadcom/Cypress
> 4339 over SDIO on the MMCI.
> 
> Brian are you managing to use the WLAN without this patch or is this
> something you stacked up to make it work? (If you want context I
> can forward the rest of the conversation where we discuss how to
> fix it properly.)
> 

Brian's Nexus 5 is on 8974 where the MMCI block has become the sdhci-msm
block, so while being a superset (afaict) of the old MMCI block we use
the sdhci driver instead.

> I discussed this patch several times with Ulf and I think Niklas looked
> at it too, but we never got around to fix it up properly.
> 

This is still needed for at least 8064 to have working sdio wifi (and
perhaps your 8060?).

Regards,
Bjorn

> Yours,
> Linus Walleij
> 
> 
> On Fri, Aug 22, 2014 at 6:54 AM Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org> wrote:
> 
> > From: Ulf Hansson <ulf.hansson@linaro.org>
> >
> > For the ux500v2 variant of the PL18x block, any block sizes are
> > supported. This will make it possible to decrease data overhead
> > for SDIO transfers.
> >
> > This patch is based on Ulf Hansson patch
> > http://www.spinics.net/lists/linux-mmc/msg12160.html
> >
> > Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> >         enabled this support on qcom variant.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> >  drivers/mmc/host/mmci.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> > index c11cb05..533ad2b 100644
> > --- a/drivers/mmc/host/mmci.c
> > +++ b/drivers/mmc/host/mmci.c
> > @@ -77,6 +77,7 @@ static unsigned int fmax = 515633;
> >   * @qcom_fifo: enables qcom specific fifo pio read logic.
> >   * @reversed_irq_handling: handle data irq before cmd irq.
> >   * @qcom_dml: enables qcom specific dma glue for dma transfers.
> > + * @any_blksize: true if block any sizes are supported
> >   */
> >  struct variant_data {
> >         unsigned int            clkreg;
> > @@ -102,6 +103,7 @@ struct variant_data {
> >         bool                    qcom_fifo;
> >         bool                    reversed_irq_handling;
> >         bool                    qcom_dml;
> > +       bool                    any_blksize;
> >  };
> >
> >  static struct variant_data variant_arm = {
> > @@ -194,6 +196,7 @@ static struct variant_data variant_ux500v2 = {
> >         .pwrreg_clkgate         = true,
> >         .busy_detect            = true,
> >         .pwrreg_nopower         = true,
> > +       .any_blksize            = true,
> >  };
> >
> >  static struct variant_data variant_qcom = {
> > @@ -212,6 +215,7 @@ static struct variant_data variant_qcom = {
> >         .explicit_mclk_control  = true,
> >         .qcom_fifo              = true,
> >         .qcom_dml               = true,
> > +       .any_blksize            = true,
> >  };
> >
> >  static int mmci_card_busy(struct mmc_host *mmc)
> > @@ -239,10 +243,11 @@ static int mmci_card_busy(struct mmc_host *mmc)
> >  static int mmci_validate_data(struct mmci_host *host,
> >                               struct mmc_data *data)
> >  {
> > +       struct variant_data *variant = host->variant;
> > +
> >         if (!data)
> >                 return 0;
> > -
> > -       if (!is_power_of_2(data->blksz)) {
> > +       if (!is_power_of_2(data->blksz) && !variant->any_blksize) {
> >                 dev_err(mmc_dev(host->mmc),
> >                         "unsupported block size (%d bytes)\n", data->blksz);
> >                 return -EINVAL;
> > @@ -796,7 +801,6 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
> >         writel(host->size, base + MMCIDATALENGTH);
> >
> >         blksz_bits = ffs(data->blksz) - 1;
> > -       BUG_ON(1 << blksz_bits != data->blksz);
> >
> >         if (variant->blksz_datactrl16)
> >                 datactrl = MCI_DPSM_ENABLE | (data->blksz << 16);
> > --
> > 1.9.1
> >
