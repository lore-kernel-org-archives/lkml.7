Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52AFC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC4512053B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbfJGPTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 11:19:25 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37892 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727589AbfJGPTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 11:19:23 -0400
Received: by mail-ed1-f67.google.com with SMTP id l21so12820429edr.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 08:19:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U9Eo+vECGc4wLCsE5vOdMoNqc4gaxJEFIE4DZGZkf+Y=;
        b=i3t2Rwi14BPKukxEa9NXsCOFD9VZ0RThq1+ujPyX6uthP4Z2qPXg5Km1jzmImiaJrp
         CyVjpdT2hTiIblsT8BZVcDqhgMkdaKBXZ79fQqQH27ogsXPNm4UKO6TQuNVXcVTwflGb
         8d7ceL18F4Gc3POTWb/+SX45jTwtBv9O+poqVZrioHougIcO4jXKkLHjn1M0awQm2BB9
         L6Er2DZMU32/5tJfx6EErlYJnJ4qjHmulBSkp8blzZRpg/Wv056CPNmbM1BpRVg9T2DS
         Sng3pOHvSP8yMfSmOBM6nbGQuxTGIKwPMSm5PrHrU9wQchXHfixgOX53cjwbMWPsUQwR
         dkwA==
X-Gm-Message-State: APjAAAXNQQpCBkrwqgTJzpFUS3lEaLUwQ8C3YP2zd8mpVHRDS0usxCNB
        Z0lsj1Wxo4HYVd6W5xOB2+sDFpPpG64=
X-Google-Smtp-Source: APXvYqyg++5IzHCVZR7IegwRt5I5aw2S1S62du19ICXUbMOoGS8n7uRdyP9MK0RqUJM7scmWawUHOg==
X-Received: by 2002:aa7:d692:: with SMTP id d18mr28903816edr.95.1570461560997;
        Mon, 07 Oct 2019 08:19:20 -0700 (PDT)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id qn27sm1935315ejb.84.2019.10.07.08.19.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2019 08:19:20 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id m18so12803075wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 08:19:20 -0700 (PDT)
X-Received: by 2002:a7b:c188:: with SMTP id y8mr22266962wmi.51.1570461559776;
 Mon, 07 Oct 2019 08:19:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190824175013.28840-1-samuel@sholland.org>
In-Reply-To: <20190824175013.28840-1-samuel@sholland.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 7 Oct 2019 23:19:06 +0800
X-Gmail-Original-Message-ID: <CAGb2v67nuMnN_o1Pvz2bEyUVeg5OMfJMVgih9-ZsgYFYDbffGw@mail.gmail.com>
Message-ID: <CAGb2v67nuMnN_o1Pvz2bEyUVeg5OMfJMVgih9-ZsgYFYDbffGw@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH] bus: sunxi-rsb: Make interrupt handling
 more robust
To:     Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Stephen Boyd <sboyd@chromium.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 25, 2019 at 1:50 AM Samuel Holland <samuel@sholland.org> wrote:
>
> The RSB controller has two registers for controlling interrupt inputs:
> RSB_INTE, which has bits for each possible interrupt, and the global
> interrupt enable bit in RSB_CTRL.
>
> Currently, we enable the bits in RSB_INTE before each transfer, but this
> is unnecessary because we never disable them. Move the initialization of
> RSB_INTE so it is done only once.
>
> We also set the global interrupt enable bit before each transfer. Unlike
> other bits in RSB_CTRL, this bit is cleared by writing a zero. Thus, we
> clear the bit in the post-timeout cleanup code, so note that in the
> comment.
>
> However, if we do receive an interrupt, we do not clear the bit. Nor do
> we clear interrupt statuses before starting a transfer. Thus, if some
> other driver uses the RSB bus while Linux is suspended (as both Trusted
> Firmware and SCP firmware do to control the PMIC), we receive spurious
> interrupts upon resume. This causes false completion of a transfer, and
> the next transfer starts prematurely, causing a LOAD_BSY condition. The
> end result is that some transfers at resume fail with -EBUSY.

If we are expecting the hardware to not be in the state we assume to be
or left it in, then maybe we should also keep setting the interrupt enable
bits on each transfer?

Surely we expect to have exclusive use of the controller most of the time.
If it's to handle suspend/resume, shouldn't we be adding power management
callbacks instead? That would reset the controller to a known state when
the system comes out of suspend, including clearing any pending interrupts.

Maxime, anything you want to add? (BTW, Maxime switched email addresses.)

ChenYu

> With this patch, all transfers reliably succeed during/after resume.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  drivers/bus/sunxi-rsb.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
> index be79d6c6a4e4..b8043b58568a 100644
> --- a/drivers/bus/sunxi-rsb.c
> +++ b/drivers/bus/sunxi-rsb.c
> @@ -274,7 +274,7 @@ static int _sunxi_rsb_run_xfer(struct sunxi_rsb *rsb)
>         reinit_completion(&rsb->complete);
>
>         writel(RSB_INTS_LOAD_BSY | RSB_INTS_TRANS_ERR | RSB_INTS_TRANS_OVER,
> -              rsb->regs + RSB_INTE);
> +              rsb->regs + RSB_INTS);
>         writel(RSB_CTRL_START_TRANS | RSB_CTRL_GLOBAL_INT_ENB,
>                rsb->regs + RSB_CTRL);
>
> @@ -282,7 +282,7 @@ static int _sunxi_rsb_run_xfer(struct sunxi_rsb *rsb)
>                                             msecs_to_jiffies(100))) {
>                 dev_dbg(rsb->dev, "RSB timeout\n");
>
> -               /* abort the transfer */
> +               /* abort the transfer and disable interrupts */
>                 writel(RSB_CTRL_ABORT_TRANS, rsb->regs + RSB_CTRL);
>
>                 /* clear any interrupt flags */
> @@ -480,6 +480,9 @@ static irqreturn_t sunxi_rsb_irq(int irq, void *dev_id)
>         status = readl(rsb->regs + RSB_INTS);
>         rsb->status = status;
>
> +       /* Disable any further interrupts */
> +       writel(0, rsb->regs + RSB_CTRL);
> +
>         /* Clear interrupts */
>         status &= (RSB_INTS_LOAD_BSY | RSB_INTS_TRANS_ERR |
>                    RSB_INTS_TRANS_OVER);
> @@ -718,6 +721,9 @@ static int sunxi_rsb_probe(struct platform_device *pdev)
>                 goto err_reset_assert;
>         }
>
> +       writel(RSB_INTS_LOAD_BSY | RSB_INTS_TRANS_ERR | RSB_INTS_TRANS_OVER,
> +              rsb->regs + RSB_INTE);
> +
>         /* initialize all devices on the bus into RSB mode */
>         ret = sunxi_rsb_init_device_mode(rsb);
>         if (ret)
> --
> 2.21.0
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> To view this discussion on the web, visit https://groups.google.com/d/msgid/linux-sunxi/20190824175013.28840-1-samuel%40sholland.org.
