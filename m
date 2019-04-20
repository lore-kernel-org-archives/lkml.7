Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B45C282E2
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 08:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9103521479
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 08:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oB/54gkH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfDTIkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 04:40:43 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46442 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbfDTIkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 04:40:42 -0400
Received: by mail-io1-f68.google.com with SMTP id p23so5993106iol.13;
        Sat, 20 Apr 2019 01:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9+6dI8bBr5EeS01R3XrlVG0WXReduip9VKJvNOCigX8=;
        b=oB/54gkHzFqwNJbbheAcUbsymK8yFduJNw7HLVjuPtiv3AO+dVR+kBLarSdV2bS5vM
         TiHU6IrswBSZ6eqxzC2XfRgG6LoTzqxduxzhIxBQBf60/FKFD4y7cIIalwwz7FCBVg//
         DI4uUPmvcrF06dk6eZDGIxVoQvCE1aDfL+3Tb/WPxo3ktureghIy+CsWzMapL4RM77VF
         egMRc/Glyn5jnVXkrafAELTGQN8nInuyZk2pGhfrlFGYO2SZ1VH1TxbmuwMpVIx02YXb
         txthkm5APXQ2IlztE6zNzyzjpv6Rrntk9JqYhEemTmuypUwPvitA9c/BLaPbhQ6qE31j
         wCmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9+6dI8bBr5EeS01R3XrlVG0WXReduip9VKJvNOCigX8=;
        b=MiSPd4KQJlIaei/Fw0AEY19fXsIjOKj5DmQEt7yhs26hkTmzG0pozpGvokCtvRK2S8
         au0NThFLWvEWo7q7zZuK4zILVPfUFsyfAr1eLoT5I2RW9Gvtwz0wdf7psemc9yv9bNS2
         XNvA0ghayuZAPufvAqyXTo3oexWwPtX2R0gRf3WyUivhX3rGPAjriahDHM9dbXS4rRCn
         aQ5cCg/QztMUQCubGPPy/3raD1Nz5sFlXVR0GBnja5yJTo+KAvojZybmgTYOCc37h182
         9zQdniOUt5Grm6H2TodkwlBFUGLLYKEw7pEvYSBoMKnA5WnwWNjlYhMwqQxA4vegeCo5
         VOjg==
X-Gm-Message-State: APjAAAXxJB440exJWrZT7oqtxUVfIc6zpuwq/uUQVlmUIQmeHCzDJGPj
        zB2h+2Hj88HtlhoziGXrjnI4NHRZuqvLNNlB5No=
X-Google-Smtp-Source: APXvYqy9NGHwXKkP8Jqenizk2w/9fPRVYHgsX9gdwqUGQb1x5tlb9nrm5tOeBw84N98Hzt7h3xwsTnJGhBf8lp2D/bM=
X-Received: by 2002:a6b:6405:: with SMTP id t5mr4561098iog.190.1555749642090;
 Sat, 20 Apr 2019 01:40:42 -0700 (PDT)
MIME-Version: 1.0
References: <1555662781-22570-1-git-send-email-peter.griffin@linaro.org> <1555662781-22570-7-git-send-email-peter.griffin@linaro.org>
In-Reply-To: <1555662781-22570-7-git-send-email-peter.griffin@linaro.org>
From:   Qiang Yu <yuq825@gmail.com>
Date:   Sat, 20 Apr 2019 16:40:30 +0800
Message-ID: <CAKGbVbtkE5K0CgyMjdOBoLRCzqQ-EDbbH67N9SbeWr1wTB_OHg@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] drm/lima: handle shared irq case for lima_pp_bcast_irq_handler
To:     Peter Griffin <peter.griffin@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, robh+dt@kernel.org,
        mark.rutland@arm.com, p.zabel@pengutronix.de, xuwei5@hisilicon.com,
        Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        lima@lists.freedesktop.org, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pushed to drm-misc-next.

Thanks,
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
