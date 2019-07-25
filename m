Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746A4C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 11:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B00422BEF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 11:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D/zlcNVe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391807AbfGYLWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 07:22:12 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:39940 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389393AbfGYLWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 07:22:11 -0400
Received: by mail-vs1-f68.google.com with SMTP id a186so31835176vsd.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 04:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HKrk3y0QeaP0ld/ogrOdHNc6Qi9XpWQuxL/dAck3igE=;
        b=D/zlcNVedwaNZNCjLnAWZ6dVl6BLpvYJFlye+5a58o2w+Z92Xz8kK3l3i4kQz4DhPe
         WZYPITbCD/+wD6EuzLMaWRz+ldsCTIe385Jgm8iwdnBN4+pdJXZ9c52HfcgPUo4v26th
         AiQPqRBtOMRZZ9hmnJk2FVDZpKJbBk6miDsUV3Hn77G1I5T8bRAKj+DqD5otnPYbSCR7
         KqhyQmb4Rn4SKOBzwY8y3aWb1byjCOPxVQWyx8ZCp1omClQ+wRfsSjFGTqKhj1DPnuPI
         vPn1EErG5t6NvhKUvzPYASgg54UQq+1FUscb3+Gmcj+9rc+PJE6coW6GcQcfZkij6A+G
         /uXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HKrk3y0QeaP0ld/ogrOdHNc6Qi9XpWQuxL/dAck3igE=;
        b=apCo8goUZ7RK3Ch4jtDO0oBuXpvuH4++P2f80YhASk6JfdPOVAv8k25yPFki0L5olT
         eNhQAOlXkPwPX1ruNk+gib76z7mf19AoHEcaaO+BFwMyaRfbDMFExy3ACy0CaXb3saFz
         9rPxcKto3hRFrzZax+mduJhNT6p8Pd3Tz3VHRyOO7ApqMgVHdt3/9k8XAkhrLx0JoplP
         rseSyduVR3Mdre+nsDQz9wgmJUcDbJWhwaMoDcfYQKEi2xBaq1Agka277bTDluIInJDr
         TKBTI35b+lu3bqsg2Inw7eak4qkNxQHRTk5SLZqX8lIqVSoGJ8lrWOXpD2EFiSwjdEtk
         C+jg==
X-Gm-Message-State: APjAAAWMhSJlfpflI3AUdyaPndWfqD2MyZKDYAjz3X9ErpiHO1NMXB8H
        M3OD0sm++/FIZBopYFd3s7yg16jS4fejqsu/qiKuBQ==
X-Google-Smtp-Source: APXvYqwibtyGDBoo9/P+TcSYJKIFwY/uEBJ5cSroAiD7izcfhHWx7NBwqT+2ALjKOntyQGanm5sWvz/HHBFv74TYb20=
X-Received: by 2002:a67:e454:: with SMTP id n20mr56963553vsm.34.1564053730747;
 Thu, 25 Jul 2019 04:22:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190717023951.5064-1-ben.chuang@genesyslogic.com.tw>
 <CAPDyKFqgTnudMumvrCJqi8FDfNNUU5AedP3hV=hwO1roG336Hw@mail.gmail.com> <20190725111504.GA8647@people.danlj.org>
In-Reply-To: <20190725111504.GA8647@people.danlj.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 25 Jul 2019 13:21:34 +0200
Message-ID: <CAPDyKFqfHFvosvwpxq--OAF4n86ETktkTva35QMqcndBuwT8Dg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: sdhci: Add PLL Enable support to internal clock setup
To:     "Michael K. Johnson" <johnsonm@danlj.org>
Cc:     Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jul 2019 at 13:15, Michael K. Johnson <johnsonm@danlj.org> wrote:
>
> (Working around Ben's SMTP server noise, responding on his behalf...)
>
> On Wed, Jul 24, 2019 at 09:19:30AM +0200, Ulf Hansson wrote:
> > This looks like it could be changed to an usleep_range(), perhaps an
> > additional change on top?
> ...
> > Ditto.
>
> In both cases yes, changed.
>
> > > +       mdelay(1);
> >
> > This is new, maybe add a comment and change to usleep_range().
>
> Entirely removed.
>
> New patch attached for any further review, I can re-send the patchset
> properly without the notice for merge when you're happy with it.

I need an ack from Adrian, but it's probably best to resend anyway.

Kind regards
Uffe

>
>
> The GL9750 and GL9755 chipsets, and possibly others, require PLL Enable
> setup as part of the internal clock setup as described in 3.2.1 Internal
> Clock Setup Sequence of SD Host Controller Simplified Specification
> Version 4.20.  This changes the timeouts to the new specification of
> 150ms for each step and is documented as safe for "prior versions which
> do not support PLL Enable."
>
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Co-developed-by: Michael K Johnson <johnsonm@danlj.org>
> Signed-off-by: Michael K Johnson <johnsonm@danlj.org>
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 59acf8e3331e..14957578bf2e 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1636,8 +1636,8 @@ void sdhci_enable_clk(struct sdhci_host *host, u16 clk)
>         clk |= SDHCI_CLOCK_INT_EN;
>         sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
>
> -       /* Wait max 20 ms */
> -       timeout = ktime_add_ms(ktime_get(), 20);
> +       /* Wait max 150 ms */
> +       timeout = ktime_add_ms(ktime_get(), 150);
>         while (1) {
>                 bool timedout = ktime_after(ktime_get(), timeout);
>
> @@ -1650,7 +1650,28 @@ void sdhci_enable_clk(struct sdhci_host *host, u16 clk)
>                         sdhci_dumpregs(host);
>                         return;
>                 }
> -               udelay(10);
> +               usleep_range(10,15);
> +       }
> +
> +       clk |= SDHCI_CLOCK_PLL_EN;
> +       clk &= ~SDHCI_CLOCK_INT_STABLE;
> +       sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +
> +       /* Wait max 150 ms */
> +       timeout = ktime_add_ms(ktime_get(), 150);
> +       while (1) {
> +               bool timedout = ktime_after(ktime_get(), timeout);
> +
> +               clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +               if (clk & SDHCI_CLOCK_INT_STABLE)
> +                       break;
> +               if (timedout) {
> +                       pr_err("%s: PLL clock never stabilised.\n",
> +                              mmc_hostname(host->mmc));
> +                       sdhci_dumpregs(host);
> +                       return;
> +               }
> +               usleep_range(10,15);
>         }
>
>         clk |= SDHCI_CLOCK_CARD_EN;
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 199712e7adbb..72601a4d2e95 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -114,6 +114,7 @@
>  #define  SDHCI_DIV_HI_MASK     0x300
>  #define  SDHCI_PROG_CLOCK_MODE 0x0020
>  #define  SDHCI_CLOCK_CARD_EN   0x0004
> +#define  SDHCI_CLOCK_PLL_EN    0x0008
>  #define  SDHCI_CLOCK_INT_STABLE        0x0002
>  #define  SDHCI_CLOCK_INT_EN    0x0001
>
