Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE02C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 07:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55367208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 07:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QEqsjUQx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfE1Hi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 03:38:58 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:36966 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbfE1Hi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 03:38:58 -0400
Received: by mail-vs1-f66.google.com with SMTP id o5so8676970vsq.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 00:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Rea+wuJqsAsZvKGqLsNVAuQOTVdLiOD2inoKT/rosU=;
        b=QEqsjUQxfxIhOPOHjKu54hetaIBkiSj21UWGDLtvfhYUGqV7WUGvWLnWJqJ0mUOtcY
         05Mgy/xS1ixWou+t65wUFx4DDuFVHj24XmopjYE00yfMvZI9aJpVe9qrF0PdwcvGepd/
         o/CnoSzES5llhIhqxxakqm9VTOvCxVzHVymQXD59svnT+Y8ZsuPAby57+KWj6tXMMZXT
         SxPk59O1ybnu3dwnjDFtCUeHt5jmCkTg+hcVZsDOH77Lxt/3isrBBKj15SwgVwRpwxp8
         d6SN7TlULfyAZpZD8Q4dyQX8XGKo9Irf4VBxRCSnPunf0Y8ADB1c5wt6GAuOMAg5DxUd
         Ey9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Rea+wuJqsAsZvKGqLsNVAuQOTVdLiOD2inoKT/rosU=;
        b=MnwRC3C7FpDF7wpYSLt0JBEtownl3PAycAuhZ8Xv6v3URHPppnEtc/pz3qhT0DS9oG
         iXTSkTcCqZcTB1rnFNSn2iwHyVr/rJYvz54FP9j5csdgSAWEzqWaaXuN8Blz0hGA0scV
         NW/Qx6riUW0oJXcggeQfS9juaTTU/l5xHNDvxYBTPwenIuGRq9TMRK/IIPjQi8YXo6zE
         J7qMboepMc0JFKRle2T6H0aeqJEp1mztOomGCmwN+IYq6yUMyWnWvlkYUn5nfME3PikV
         e2yil1yFjrdZrTjQBJ/0+z9rbNbFqAN4V9tivbHabhQicxik7Jlq13E3MNLxSa+Y5H7Y
         QgTw==
X-Gm-Message-State: APjAAAUn3eU+va4GjJ3CIIUDqgMAzyy18GMQifDcPgzCGKMS1C0z59SU
        0GzOe2rQndl4p2jir7m0WtghcP+jNfyZU57PriDLzA==
X-Google-Smtp-Source: APXvYqzMDtSDrLkYVAhEOK0x0KhLhgG+SpDNY8pQdGkXg4driUR9AlwITGCYyvKuEROBxKPnq2pEREWu1EAwwaDo284=
X-Received: by 2002:a67:f99a:: with SMTP id b26mr29071597vsq.200.1559029136934;
 Tue, 28 May 2019 00:38:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190501175457.195855-1-rrangel@chromium.org>
In-Reply-To: <20190501175457.195855-1-rrangel@chromium.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 28 May 2019 09:38:20 +0200
Message-ID: <CAPDyKFpL1nHt1E1zgS-iDZf_KDWk2CN32Lvr+5Nmo8CtB2VCWg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] mmc: sdhci: Manually check card status after reset
To:     Raul E Rangel <rrangel@chromium.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Daniel Kurtz <djkurtz@chromium.org>,
        hongjiefang <hongjiefang@asrmicro.com>,
        Jennifer Dahm <jennifer.dahm@ni.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Kyle Roeschley <kyle.roeschley@ni.com>,
        Avri Altman <avri.altman@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 May 2019 at 19:55, Raul E Rangel <rrangel@chromium.org> wrote:
>
> There is a race condition between resetting the SDHCI controller and
> disconnecting the card.
>
> For example:
> 0) Card is connected and transferring data
> 1) mmc_sd_reset is called to reset the controller due to a data error

I assume you refer to mmc_sd_hw_reset()? In that case, I think you
have interpreted the purpose of mmc_sd_hw_reset() slightly wrong. It's
responsibility is to reset the SD-card and not the host/controller.

Whether there some additional "reset" of the controller needed, that
is assumed by the core, to be managed via the ->set_ios() callback for
the host.

> 2) sdhci_set_ios calls sdhci_do_reset
> 3) SOFT_RESET_ALL is toggled which clears the IRQs the controller has
> configured.
> 4) Wait for SOFT_RESET_ALL to clear
> 5) CD logic notices card is gone and CARD_PRESENT goes low, but since the
>    IRQs are not configured a CARD_REMOVED interrupt is never raised.
> 6) IRQs are enabled again
> 7) mmc layer never notices the device is disconnected. The SDHCI layer
>    will keep returning -ENOMEDIUM. This results in a card that is always
>    present and not functional.

This sounds like host specific problems, which most likely should be
fixed in host driver, solely. Unless I am missing something, of
course.

>
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> ---
> You can see an example of the following two patches here:
> https://privatebin.net/?b0f5953716d34ca6#C699bCBQ99NdvspfDW7CMucT8CJG4DgL+yUNPyepDCo=
> Line 8213: EILSEQ
> Line 8235: SDHC is hard reset
> Line 8240: Controller completes reset and card is no longer present
> Line 8379: mmc_sd_reset notices card is missing and issues a card_event
>            and schedules a detect change.
> Line 8402: Don't init the card since it's already gone.
> Line 8717: Marks card as removed
> Line 8820: mmc_sd_remove removes the block device
>
> I am running into a kernel panic. A task gets stuck for more than 120
> seconds. I keep seeing blkdev_close in the stack trace, so maybe I'm not
> calling something correctly?
>
> Here is the panic: https://privatebin.net/?8ec48c1547d19975#dq/h189w5jmTlbMKKAwZjUr4bhm7Q2AgvGdRqc5BxAc=
>
> I sometimes see the following:
> [  547.943974] udevd[144]: seq 2350 '/devices/pci0000:00/0000:00:14.7/mmc_host/mmc0/mmc0:0001/block/mmcblk0/mmcblk0p1' is taking a long time
>
> I was getting the kernel panic on a 4.14 kernel: https://chromium.googlesource.com/chromiumos/third_party/kernel/+/f3dc032faf4d074f20ada437e2d081a28ac699da/drivers/mmc/host
> So I'm guessing I'm missing an upstream fix.
>
> Do the patches look correct or am I doing something that would cause a
> kernel panic?
>
> I have a DUT setup with a GPIO I can use to toggle the CD pin. I ran a
> test where I connect and then randomly, between 0s - 1s disconnect the
> card. This got over 20k iterations before the panic. Though when I do it
> manually and stop for 2 minutes the panic happens.
>
> Any help would be appreciated.
>
> Thanks,
> Raul
>
>
>  drivers/mmc/core/sd.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 265e1aeeb9d8..9206c4297d66 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -1242,7 +1242,27 @@ static int mmc_sd_runtime_resume(struct mmc_host *host)
>
>  static int mmc_sd_hw_reset(struct mmc_host *host)
>  {
> +       int present;
>         mmc_power_cycle(host, host->card->ocr);
> +
> +       present = host->ops->get_cd(host);
> +
> +       /* The card status could have changed while resetting. */
> +       if ((mmc_card_removed(host->card) && present) ||
> +           (!mmc_card_removed(host->card) && !present)) {
> +               pr_info("%s: card status changed during reset\n",
> +                      mmc_hostname(host));
> +               host->ops->card_event(host);
> +               mmc_detect_change(host, 0);
> +       }
> +
> +       /* Don't perform unnecessary transactions if the card is missing. */
> +       if (!present) {
> +               pr_info("%s: card was removed during reset\n",
> +                       mmc_hostname(host));
> +               return -ENOMEDIUM;
> +       }
> +

When doing a  mmc_hw_reset() (which ends up calling mmc_sd_hw_reset()
in case of SD cards), we are making a final attempt to make the card
functional again, via a power cycle and a re-init of it.

In this path, we don't care whether the card is removed, as that
should have been detected already when the block layer calls
mmc_detect_card_removed().

>         return mmc_sd_init_card(host, host->card->ocr, host->card);
>  }
>
> --
> 2.21.0.593.g511ec345e18-goog
>

Kind regards
Uffe
