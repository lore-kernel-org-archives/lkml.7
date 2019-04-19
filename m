Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B795FC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8290D2063F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZjE9Kg2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbfDSSsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:48:09 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:40158 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfDSSsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:48:08 -0400
Received: by mail-it1-f194.google.com with SMTP id k64so9516660itb.5;
        Fri, 19 Apr 2019 11:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3VtbXpBkynDywEgAG1pSAnPivqQwuTNLhPiFpKxRqYo=;
        b=bZjE9Kg2sjwo2LPZ7p9dgu7RaE9HHc0SwDSO+6t6yKkv74kmrtTuh5liXcTFaO2DPa
         57qY9OieAqtHSyvBn5xjA8LmqEFkR8YTPWNHk+29sLaU22xnvkXY09M3wYJ2Jq5zJkdI
         96Jm7TCAEayGT7Vt7QxofqDpGhdxFmIw4icBKpxH0VM+FR8kbDHAlsYs0Zst0B4UvNyq
         rKMB5dODlBmgAZ/BDr9QZObiE7aeBIF0skFyCZj7zdfp5Yo/eCjohb5bOTu5ftSTHdvs
         TKsWyTS7w1V0VFPaAk7uSogTT3Y7rY4xFLN3qEn4h4bJ7zQw3vErCesUVqh+vK2fcUnd
         X3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3VtbXpBkynDywEgAG1pSAnPivqQwuTNLhPiFpKxRqYo=;
        b=LvHKO0gHP5VSyHsyB2nnWWoiWmEdM8fOZHCJIvnJhwVS7R1hPeLEs1/tviG4CRnMpj
         VJGreMlz2e78sZx16W3UArb7NeV8JMmqZdhaBp4aDQpAAckc+dB16F9hOw/kvSJJJNKd
         dNs2zYSqfQ+/1QQLcJgWUXgc7s9CtpdMfRcD18gKzhQR7LiGt0S7RFlTiShvrPKfQBuI
         deK5YmEFVSN+8kM0c+OVZjPUhqdAxKguopi6erhFLfLkA3SlCFWfVvQtJf2f+41+27ty
         DIT2NyDyTuuooz2neKk58kmjyREWni5On2hKUOktQGRoNebqymV1jUGwyLSPViT1NTj8
         aNdw==
X-Gm-Message-State: APjAAAUE2pSmbYHKMckNqF2ztBNPMc4Y+/ZRqSSkQ6rcOP5j22xWWQi5
        Q4ZxT7nuzr8W4/UNxZygsFMJ0XwmKF4P2/PBBzjOuA==
X-Google-Smtp-Source: APXvYqyGgOxvfY1V7inVWRV8wmTfsi2vHc8z5VlEi24dMU/7rUSRHrcCWHylhzCRah4Pv3tWdHxXnNrxdJ8D/6oWHvw=
X-Received: by 2002:a05:660c:20e:: with SMTP id y14mr2064672itj.17.1555668877927;
 Fri, 19 Apr 2019 03:14:37 -0700 (PDT)
MIME-Version: 1.0
References: <1555662781-22570-1-git-send-email-peter.griffin@linaro.org> <1555662781-22570-7-git-send-email-peter.griffin@linaro.org>
In-Reply-To: <1555662781-22570-7-git-send-email-peter.griffin@linaro.org>
From:   Qiang Yu <yuq825@gmail.com>
Date:   Fri, 19 Apr 2019 18:14:26 +0800
Message-ID: <CAKGbVbsueZLySqsyPLJLG2mMPH6q=3_ivCU3ma1-EgwtJuuOCg@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] drm/lima: handle shared irq case for lima_pp_bcast_irq_handler
To:     Peter Griffin <peter.griffin@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        john.stultz@linaro.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, robh+dt@kernel.org,
        mark.rutland@arm.com, p.zabel@pengutronix.de, xuwei5@hisilicon.com,
        mturquette@baylibre.com, sboyd@kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        lima@lists.freedesktop.org, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good for me, patch is:
Reviewed-by: Qiang Yu <yuq825@gmail.com>

I'll push this patch to drm-misc-next.

Regards,
Qiang


On Fri, Apr 19, 2019 at 4:35 PM Peter Griffin <peter.griffin@linaro.org> wrote:
>
> On Hikey board all lima ip blocks are shared with one irq.
> This patch avoids a NULL ptr deref crash on this platform
> on startup. Tested with Weston and kmscube.
>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Qiang Yu <yuq825@gmail.com>
> ---
>  drivers/gpu/drm/lima/lima_pp.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/lima/lima_pp.c b/drivers/gpu/drm/lima/lima_pp.c
> index d29721e..8fef224 100644
> --- a/drivers/gpu/drm/lima/lima_pp.c
> +++ b/drivers/gpu/drm/lima/lima_pp.c
> @@ -64,7 +64,13 @@ static irqreturn_t lima_pp_bcast_irq_handler(int irq, void *data)
>         struct lima_ip *pp_bcast = data;
>         struct lima_device *dev = pp_bcast->dev;
>         struct lima_sched_pipe *pipe = dev->pipe + lima_pipe_pp;
> -       struct drm_lima_m450_pp_frame *frame = pipe->current_task->frame;
> +       struct drm_lima_m450_pp_frame *frame;
> +
> +       /* for shared irq case */
> +       if (!pipe->current_task)
> +               return IRQ_NONE;
> +
> +       frame = pipe->current_task->frame;
>
>         for (i = 0; i < frame->num_pp; i++) {
>                 struct lima_ip *ip = pipe->processor[i];
> --
> 2.7.4
>
