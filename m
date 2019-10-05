Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD9CC47404
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 06:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57560222BE
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 06:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8GyDvLS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfJEGtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 02:49:03 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:40659 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfJEGtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 02:49:03 -0400
Received: by mail-ua1-f65.google.com with SMTP id i13so2697673uaq.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 23:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6aeDVeBVNFr/uMZ/uptXRcPQ7WzhEwoxIXaOAlc1rC8=;
        b=A8GyDvLSv2x+M4DOuJ2wSiy0Ufq8PbA7ssUb8tigvccQfPi2CvwiTo0srd8Jl+jSji
         xf0t3Wyh8p8aVMtw3gu8G9HxF+fexV3aZy0sIuD6amPs5aC+dzV+k+7UWvfpPfgRV/S4
         PcEWSEj+tDWMBNZBFNMaxd/Sx9IjxWAW8ZxEW6nkq2RfYk79hquvdQMnWfy631xTPG/H
         ymxVV5MOTxbwuw1WCEelslHYmMkbWjTAvUoxxECXBmx2aA9Kw2s0oXkkxMr2dc3yr1TG
         5TFyNe8X5R3o0bd8Sjjm81GJoLopbux5+dSDpLudHfTooliWNW3Nx6tnf4/u/gL3JNyJ
         ec7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6aeDVeBVNFr/uMZ/uptXRcPQ7WzhEwoxIXaOAlc1rC8=;
        b=IQQsIj61m30HvDF+/TgMWvY541KMU4sa4/nA4QD3l7gHy+35t4aeuwX1ER+3J3BIR0
         Srnl1cBGTCNilvlJDUSZ6Oxhob/c7o9O1PXXZRnprFVkRmEmjTaV1fnrzrCyqJk15Pef
         1HhwezuK1vI7Dkyp1sRInAj1wp5qfCfrn9TupsZtQ0igbvg64a7vpUgswnlWhDBmcbKM
         H4kbLqbUgnqk0n+k9aNk/oPGTJOyu922tjPV+V/Sk0EdpLWavVijS3PhBj/g2v+o6FAb
         XyA10WvnUCJOogI5CH1J1eZftTp/HbIkfciLf9su6WdMNF/3+q9uGjaYsm8BgrCclgyh
         t5jA==
X-Gm-Message-State: APjAAAUMZJNjVAX8inmJEweriR/VlwYiaf59/lt4utJUWahJqqC8hgFb
        7F/biwr2aAHuCuJNI++EU7ndE+b+WoUfvF+AlYM=
X-Google-Smtp-Source: APXvYqyyjdJ3ttESjO2FINu/CL51n4mItWMoNJf1ajbTADsFKCUw8LFYN87QcwixCUyqNZN2KZ6TIFs9GGh/mKpnn6s=
X-Received: by 2002:ab0:6812:: with SMTP id z18mr8171080uar.43.1570258140412;
 Fri, 04 Oct 2019 23:49:00 -0700 (PDT)
MIME-Version: 1.0
References: <20191003152228.28955-1-ttayar@habana.ai>
In-Reply-To: <20191003152228.28955-1-ttayar@habana.ai>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Sat, 5 Oct 2019 09:48:34 +0300
Message-ID: <CAFCwf13mDiJzLeP8UWfh88ZshCPzkdCPaVxxM-Ur9TbWogN8ew@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] habanalabs: Mark queue as expecting to CB handle
 or address
To:     Tomer Tayar <ttayar@habana.ai>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 3, 2019 at 6:22 PM Tomer Tayar <ttayar@habana.ai> wrote:
>
> Jobs on some queues must be provided with a handle to a driver command
> buffer object, while for other queues, jobs must be provided with an
> address to a command buffer.
> Currently the distinction is done based on the queue type, which is less
> flexible if the same type of queue behaves differently on different
> types of ASIC.
> This patch adds a new queue property for this target, which is
> configured per queue type per ASIC type.
>
> Signed-off-by: Tomer Tayar <ttayar@habana.ai>
> ---
>  drivers/misc/habanalabs/command_submission.c | 4 +++-
>  drivers/misc/habanalabs/goya/goya.c          | 3 +++
>  drivers/misc/habanalabs/habanalabs.h         | 3 +++
>  3 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/misc/habanalabs/command_submission.c b/drivers/misc/habanalabs/command_submission.c
> index a9ac045dcfde..f44205540520 100644
> --- a/drivers/misc/habanalabs/command_submission.c
> +++ b/drivers/misc/habanalabs/command_submission.c
> @@ -414,7 +414,9 @@ static struct hl_cb *validate_queue_index(struct hl_device *hdev,
>                         "Queue index %d is restricted for the kernel driver\n",
>                         chunk->queue_index);
>                 return NULL;
> -       } else if (hw_queue_prop->type == QUEUE_TYPE_INT) {
> +       }
> +
> +       if (!hw_queue_prop->requires_kernel_cb) {
>                 *ext_queue = false;
>                 return (struct hl_cb *) (uintptr_t) chunk->cb_handle;
>         }
> diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
> index 09caef7642fd..71693fcffb16 100644
> --- a/drivers/misc/habanalabs/goya/goya.c
> +++ b/drivers/misc/habanalabs/goya/goya.c
> @@ -337,17 +337,20 @@ void goya_get_fixed_properties(struct hl_device *hdev)
>         for (i = 0 ; i < NUMBER_OF_EXT_HW_QUEUES ; i++) {
>                 prop->hw_queues_props[i].type = QUEUE_TYPE_EXT;
>                 prop->hw_queues_props[i].driver_only = 0;
> +               prop->hw_queues_props[i].requires_kernel_cb = 1;
>         }
>
>         for (; i < NUMBER_OF_EXT_HW_QUEUES + NUMBER_OF_CPU_HW_QUEUES ; i++) {
>                 prop->hw_queues_props[i].type = QUEUE_TYPE_CPU;
>                 prop->hw_queues_props[i].driver_only = 1;
> +               prop->hw_queues_props[i].requires_kernel_cb = 0;
>         }
>
>         for (; i < NUMBER_OF_EXT_HW_QUEUES + NUMBER_OF_CPU_HW_QUEUES +
>                         NUMBER_OF_INT_HW_QUEUES; i++) {
>                 prop->hw_queues_props[i].type = QUEUE_TYPE_INT;
>                 prop->hw_queues_props[i].driver_only = 0;
> +               prop->hw_queues_props[i].requires_kernel_cb = 0;
>         }
>
>         for (; i < HL_MAX_QUEUES; i++)
> diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
> index c3d24ffad9fa..f47f4b22cb6b 100644
> --- a/drivers/misc/habanalabs/habanalabs.h
> +++ b/drivers/misc/habanalabs/habanalabs.h
> @@ -98,10 +98,13 @@ enum hl_queue_type {
>   * @type: queue type.
>   * @driver_only: true if only the driver is allowed to send a job to this queue,
>   *               false otherwise.
> + * @requires_kernel_cb: true if a CB handle must be provided for jobs on this
> + *                      queue, false otherwise (a CB address must be provided).
>   */
>  struct hw_queue_properties {
>         enum hl_queue_type      type;
>         u8                      driver_only;
> +       u8                      requires_kernel_cb;
>  };
>
>  /**
> --
> 2.17.1
>

Patches 1-4 are:
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>

However, I'm only applying patches 1 & 2 to -next, because 3 & 4
mostly add code which is not relevant to GOYA, without much changing
existing code, as opposed to patches 1&2.

Oded
