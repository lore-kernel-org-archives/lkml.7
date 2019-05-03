Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E89AC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 13:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 729D9208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 13:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u2AxRFeL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbfECN3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 09:29:46 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:46268 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727839AbfECN3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 09:29:43 -0400
Received: by mail-vs1-f67.google.com with SMTP id e2so3559392vsc.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 06:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ySSjssdV67Ao4ms1qOCNRs0zIQnTIX+IwqYCxfayb1o=;
        b=u2AxRFeLy3TE9A2i8vlTTUO+paUcCjvUQAoaC08Y0cLWM8KCDz/GHODo4lfqtMSsQo
         Q6jgEdhTvjrSPEPIGRfh8JBQzniYUJLPobFD3IEmN5ukmB825QApB9KPP8acvgOLebZU
         cEoQ1dc3I4YXb7kiKOAhuT+13SoVKJKQwf9L/xsppclCnPSo/aHzeBLisFxY0OMYBQqa
         D/0kITb+rnWJknqE1iM9nvd5B9+erqQFilXj+jO4wWN8dbWybDbnNejmTprDDl6RR5It
         JPDAZyLAKzRDLlYrwYGJ2Eg/QnzoGmEBhDBly8vxpwy4vxQGvCeX5q+NJmgNb7ihlmcZ
         Kvkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ySSjssdV67Ao4ms1qOCNRs0zIQnTIX+IwqYCxfayb1o=;
        b=QrEpXpau2zXu6p2Zijr8U6VLsnfEjW5Clstm6gRQy6YG87CbupfuZDcq9acP3e9W+2
         j8WW4fH6VanJlK62R26ZJmIWYqEgUxG22RZztSM8t+cheEQpfq5rE195ghxeqBYLEFJE
         BQBfa1nPkM9UjIrwjE+axgqyM6mYex70/UVG/T0D0fis9o7bcyWO3D8AsF+DKZZZY0nR
         p8yjP9R+7zDXR7dk4GeUXfq3JXXTKn8yaa5/NkaH3rXOFLhz4Q7nuxS9GgvxH3w6Fv5I
         ASBtNNOqZPWOp5rP9vElcR9qr6l9+FJTAeAAMgrDthEoxGgH4xss1KFyxRwE7HXt39m6
         YxSw==
X-Gm-Message-State: APjAAAW+HX57gPsRJMuU3WRLxbH2M0AiU+XME5dtf1mLjanxYmjzdybv
        zHnBoPXaAB3IDl3lCECBYlOHTp1vQQNOYxXV0zgWgg==
X-Google-Smtp-Source: APXvYqwyjpABuH9f98eNJbyAbPNwSBt3Qx70IKfgzlw7H+E4YVYFPp/1syMGrQTb8nNgBwCmF0kdNHrHaZRae4aYALc=
X-Received: by 2002:a67:cb12:: with SMTP id b18mr5348678vsl.191.1556890182098;
 Fri, 03 May 2019 06:29:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190429173239.51305-1-rrangel@chromium.org>
In-Reply-To: <20190429173239.51305-1-rrangel@chromium.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 3 May 2019 15:29:06 +0200
Message-ID: <CAPDyKFraD8BmnscX8Lu2SQ53AetFFsf5SLKydmut4EwORj0ATQ@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: core: Verify SD bus width
To:     Raul E Rangel <rrangel@chromium.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Daniel Kurtz <djkurtz@chromium.org>, zwisler@chromium.org,
        Avri Altman <avri.altman@wdc.com>,
        hongjiefang <hongjiefang@asrmicro.com>,
        Jennifer Dahm <jennifer.dahm@ni.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Kyle Roeschley <kyle.roeschley@ni.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Apr 2019 at 19:32, Raul E Rangel <rrangel@chromium.org> wrote:
>
> The SD Physical Layer Spec says the following: Since the SD Memory Card
> shall support at least the two bus modes 1-bit or 4-bit width, then any SD
> Card shall set at least bits 0 and 2 (SD_BUS_WIDTH="0101").
>
> This change verifies the card has specified a bus width.
>
> AMD SDHC Device 7806 can get into a bad state after a card disconnect
> where anything transferred via the DATA lines will always result in a
> zero filled buffer. Currently the driver will continue without error if
> the HC is in this condition. A block device will be created, but reading
> from it will result in a zero buffer. This makes it seem like the SD
> device has been erased, when in actuality the data is never getting
> copied from the DATA lines to the data buffer.
>
> SCR is the first command in the SD initialization sequence that uses the
> DATA lines. By checking that the response was invalid, we can abort
> mounting the card.
>
> Acked-by: Avri Altman <avri.altman@wdc.com>
> Reviewed-by: Avri Altman <avri.altman@wdc.com>

No need for both ack/review tags, the latter is superior so keeping only that.
>
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>

Applied for next, thanks!

Let's how the testing turns out, we may consider sending a backport to
stable later on.

Kind regards
Uffe


> ---
> Here is the testing I did:
>
> Good Trace: https://paste.fedoraproject.org/paste/oVEI5b0IzHD23Yo7CDZgEg
> [   30.103686] mmc0: new high speed SDHC card at address 0001
> [   30.105262] mmcblk0: mmc0:0001 00000 7.41 GiB
> [   30.108258]  mmcblk0: p1
> [   31.947250] mmc0: card 0001 removed
>
> Bad Trace (before patch): https://paste.fedoraproject.org/paste/jBWfpFBM8gdEmGOzxij~hw
>
> Bad Trace (after patch): https://paste.fedoraproject.org/paste/8gB8MLYOKEUZEgHXmQ0W1Q
> [   33.810760] mmc0: invalid bus width
> [   33.810782] mmc0: error -22 whilst initialising SD card
> [   34.068818] mmc0: invalid bus width
> [   34.068839] mmc0: error -22 whilst initialising SD card
> [   34.329521] mmc0: invalid bus width
> [   34.329543] mmc0: error -22 whilst initialising SD card
> [   34.592061] mmc0: invalid bus width
> [   34.592084] mmc0: error -22 whilst initialising SD card
>
> In the traces you can see sd_scr is different
>
> Changes in v3:
> - Rebased on mmc/next
>
> Changes in v2:
> - Made the bus width check stricter. It now requires the value to match
>   the spec.
>
>  drivers/mmc/core/sd.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 265e1aeeb9d8..d3d32f9a2cb1 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -221,6 +221,14 @@ static int mmc_decode_scr(struct mmc_card *card)
>
>         if (scr->sda_spec3)
>                 scr->cmds = UNSTUFF_BITS(resp, 32, 2);
> +
> +       /* SD Spec says: any SD Card shall set at least bits 0 and 2 */
> +       if (!(scr->bus_widths & SD_SCR_BUS_WIDTH_1) ||
> +           !(scr->bus_widths & SD_SCR_BUS_WIDTH_4)) {
> +               pr_err("%s: invalid bus width\n", mmc_hostname(card->host));
> +               return -EINVAL;
> +       }
> +
>         return 0;
>  }
>
> --
> 2.21.0.593.g511ec345e18-goog
>
