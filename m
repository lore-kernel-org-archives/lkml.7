Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41941C3A5A2
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 00:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1363621897
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 00:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pYFQLhMo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbfIDA6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 20:58:34 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39689 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbfIDA6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 20:58:33 -0400
Received: by mail-ed1-f66.google.com with SMTP id u6so14786960edq.6;
        Tue, 03 Sep 2019 17:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=96k3Ap6WgO1ubCZcnQYSOq5Fr6vkCvjWMlxPWHE7mDg=;
        b=pYFQLhMoijP7Erg+oZF4nfoYi8XoHLvkNJI/nc6PcR14Pzz+yx+gC7xAtPj8RZ3Di/
         dufXhWzuZSq0mtmDnLFLUvgPJZ3ALLyCn4ZcCQdUOnlSZHeAsM31Q1U0Goq6T5Cnd6m7
         IIjVcoKNfKwRsIcFk7vK5Zdwv/fsZhg+tEsPdEwgsfeuaxRMaFBkEh0/GH56rs5rH8pl
         YMWR43dWvgeUGtr0trLgmmiX2mc26aC1DWMSe3mR6N117vE67+AJSupANu2Z4RuwyMKu
         Kzr/OZNWq+vw9Nzotn6+aRvZucNWPsZlaNJP4QyNm6/00GAPn9DJTNK67NOXD4daPWfZ
         DoWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=96k3Ap6WgO1ubCZcnQYSOq5Fr6vkCvjWMlxPWHE7mDg=;
        b=NwlLNkW402MTzcZQLDEFTA0RhjevHXmt8LtpcfAA1uoa5LG18/BMTmhyQtJSMdQIu0
         GfCnBt4iYBnVCF/EjurgwO11JkYtczaET2QHCLMRut4uwdLXABnBvBVndrUXh9sTIZ0b
         kLNWI6gMhHSL+V4MmSXIVmIPvFexhZOTVp31cT9PdeZL1Fw5SKiMf3A9k0idBev4D582
         5MZiaI7XMbgOsMKrWHcT1VUuT8XbEgnbX38bmE47u9tBUNqzVxOy7L+LwS9+FQAkLO6l
         ebqP+i2/iikRQrb3jZAOZ6cUNfSg7PxVbkXW2x+RyTgJqqnZZfROA+a2ZPzJpwmswunU
         PTow==
X-Gm-Message-State: APjAAAVg9CEhRpi/ns8HCWC2Uyc5IKZ2EsGm1XkElJOhZfPLrgVse7/h
        pDU3ehGIwRRVLrkg92RVhzTUMXT8+Ge8NXvOFW4=
X-Google-Smtp-Source: APXvYqxL7/6g4WdVoKygQkrH4jcXN6BTdspG9dGdMAlhilwJAGcSn0H2CM3jOBlSmOT2Dm8VejWdD185ViqKxfc4VSg=
X-Received: by 2002:a50:ad5b:: with SMTP id z27mr25396902edc.252.1567558711317;
 Tue, 03 Sep 2019 17:58:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190830022542.8571-1-benchuanggli@gmail.com> <CAHp75Vfx4FukybSjQjiNNQpHUNQrUsvwOen4ibqxOONKTJNxww@mail.gmail.com>
In-Reply-To: <CAHp75Vfx4FukybSjQjiNNQpHUNQrUsvwOen4ibqxOONKTJNxww@mail.gmail.com>
From:   Ben Chuang <benchuanggli@gmail.com>
Date:   Wed, 4 Sep 2019 08:58:19 +0800
Message-ID: <CACT4zj_+7r=0pO-c4H_QzEJzY=pSJn5pQkAK-5bM+vR6u8qS3Q@mail.gmail.com>
Subject: Re: [PATCH V7 5/5] mmc: host: sdhci-pci: Add Genesys Logic GL975x support
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Michael K. Johnson" <johnsonm@danlj.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 3, 2019 at 6:05 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Fri, Aug 30, 2019 at 5:28 AM Ben Chuang <benchuanggli@gmail.com> wrote:
> >
> > From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> >
> > Add support for the GL9750 and GL9755 chipsets.
> >
> > Enable v4 mode and wait 5ms after set 1.8V signal enable for GL9750/
> > GL9755. Fix the value of SDHCI_MAX_CURRENT register and use the vendor
> > tuning flow for GL9750.
> >
>
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>
> Usually last one for latest developer / submitter goes on.
>
> > Co-developed-by: Michael K Johnson <johnsonm@danlj.org>
> > Signed-off-by: Michael K Johnson <johnsonm@danlj.org>
>
>
> > +#define GLI_MAX_TUNING_LOOP 40
>
>
> > +static void gli_set_9750(struct sdhci_host *host)
> > +{
> > +       u32 driving_value = 0;
> > +       u32 pll_value = 0;
> > +       u32 sw_ctrl_value = 0;
> > +       u32 misc_value = 0;
> > +       u32 parameter_value = 0;
> > +       u32 control_value = 0;
>
> > +
>
> Redundant blank line.
>
> > +       u16 ctrl2 = 0;
>
> Do you need these all assignments above?
>
> > +       driving_value = sdhci_readl(host, SDHCI_GLI_9750_DRIVING);
> > +       pll_value = sdhci_readl(host, SDHCI_GLI_9750_PLL);
> > +       sw_ctrl_value = sdhci_readl(host, SDHCI_GLI_9750_SW_CTRL);
> > +       misc_value = sdhci_readl(host, SDHCI_GLI_9750_MISC);
> > +       parameter_value = sdhci_readl(host, SDHCI_GLI_9750_TUNING_PARAMETERS);
> > +       control_value = sdhci_readl(host, SDHCI_GLI_9750_TUNING_CONTROL);
>
>
>
> > +
> > +       udelay(1);
>
> This misses the answer to question why. Why this is needed and why
> timeout is this long?
>
> > +
> > +       gl9750_wt_off(host);
> > +}
>
> > +static int __sdhci_execute_tuning_9750(struct sdhci_host *host, u32 opcode)
> > +{
> > +       int i;
>
> > +       int rx_inv = 0;
>
> Duplicate assignment.
>
> > +
> > +       for (rx_inv = 0; rx_inv < 2; rx_inv++) {
>
> > +               if (rx_inv & 0x1)
> > +                       gli_set_9750_rx_inv(host, true);
> > +               else
> > +                       gli_set_9750_rx_inv(host, false);
>
> gli_set_...(host, !!rx_inv);
>
> > +
> > +               sdhci_start_tuning(host);
> > +
> > +               for (i = 0; i < GLI_MAX_TUNING_LOOP; i++) {
> > +                       u16 ctrl;
> > +
> > +                       sdhci_send_tuning(host, opcode);
> > +
> > +                       if (!host->tuning_done) {
>
> > +                               if (rx_inv == 1) {
>
> It's an invariant to the loop. So, you may do this check after outter loop.
>
> > +                                       pr_info("%s: Tuning timeout, falling back to fixed sampling clock\n",
> > +                                               mmc_hostname(host->mmc));
>
> > +                                       sdhci_abort_tuning(host, opcode);
>
> It will also de-duplicates this call.
>
> > +                                       return -ETIMEDOUT;
> > +                               }
> > +                               sdhci_abort_tuning(host, opcode);
> > +                               break;
> > +                       }
>
> > +               }
> > +       }
> > +
> > +       pr_info("%s: Tuning failed, falling back to fixed sampling clock\n",
> > +               mmc_hostname(host->mmc));
> > +       sdhci_reset_tuning(host);
> > +       return -EAGAIN;
> > +}
>
> > +static void sdhci_gli_voltage_switch(struct sdhci_host *host)
> > +{
>
> Any comment why?
>
> > +       usleep_range(5000, 5500);
> > +}
>
> > +static u32 sdhci_gl9750_readl(struct sdhci_host *host, int reg)
> > +{
> > +       u32 value;
> > +
> > +       value = readl(host->ioaddr + reg);
>
> > +       if (unlikely(reg == SDHCI_MAX_CURRENT)) {
> > +               if (!(value & 0xff))
> > +                       value |= 0xc8;
> > +       }
>
> if (a) {
>  if (b) {
>    ...
>  }
> }
>
> is the same as
>
> if (a && b) {
>  ...
> }
>
> > +       return value;
> > +}
>
> > +#define PCI_DEVICE_ID_GLI_9755         0x9755
> > +#define PCI_DEVICE_ID_GLI_9750         0x9750
>
> --
> With Best Regards,
> Andy Shevchenko

Hi, Andy,

Thank you for your comments to make the code better.
Waiting to see if Adrian has any other comments.

Best Regards,
Ben Chuang
