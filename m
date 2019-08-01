Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63F0C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 14:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A484D20838
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 14:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrbMWQFC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731848AbfHAOOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 10:14:09 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:46300 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731665AbfHAOOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 10:14:09 -0400
Received: by mail-vk1-f193.google.com with SMTP id b64so14612293vke.13
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 07:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KYYwECup+fF9qp+rfwpWlPQqwe1co2+YMnT+E8jGyP0=;
        b=mrbMWQFCA7ngezQ2lWfc7FsgOQG0hjP2nr0N9Pc+5y+ZR+GLm4EWPIUcbx50KNWVb9
         Q1YoCxQHgrCt0HnibYnOcVCOgWECWvE4EXjBLqbfd3B7xV+Otd2Unk5oJardDz7QnjTr
         SoUBY5d1CmTSOur4PzjzcXO7xvltXPwy7C3dwEIHkh9GwZtH4KhLnNP57UWIt3UWU+1V
         cC+hEtZIILUpfBtcaQJQPL5XszdES/nYVopS3EmKuoiRO3Bd32uoa4s5XMSk5yd5EdLY
         /kfiq4hDnHIdW9DerzSQZhFc6z+TShtK2wXFdUQ5QuYfcDYTghfkQfA9bpBeOJ5ScF3j
         fIsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KYYwECup+fF9qp+rfwpWlPQqwe1co2+YMnT+E8jGyP0=;
        b=N018zOxkJqZVRzQumfjjxjdQJsLnhfadoGNfb0SY3n2yEfbiosSS37Nu3AXvNbybAL
         oW6/QoGItSXtfNBJ3iEd7DZCfpLmDQX/a7GwFVbb9lvKvYSyC0cRkWNvbF6oCb8HG50H
         zlx1sPaaLAvtKvJsZagMUBluF0egJHsV1Yb2E4+imOz7TdXRWpwhmLQYUJCnMJKI9rJZ
         DPF28MErMMGLeetCgc/v31HEV2BmuUnQ41FaTqzRcTNQOf5dVfIausG7+KAHMaY0i85F
         6FTuci1S94HDxbbLLgBbpIgE5HomS5SmmTlFLVsEYhQEkV4QTR2+LVFGxgadOHjIYuLJ
         48Ng==
X-Gm-Message-State: APjAAAVudoeoG6h6jDmdLwV1buf//lnUHdiZfuHzhKC+TkGNK80c5UAS
        pMtihnU4YdTsBdZIIsp49x/X73+R4hoCta9fouJU0g==
X-Google-Smtp-Source: APXvYqzn/EmS2UydZCPf4GmENl6D4/hrXDpwpD/+bpDbqfztRBUd8+cz2nYHyRaEUbadsesCkm/pvdUdC16liYbVT/4=
X-Received: by 2002:a1f:2e56:: with SMTP id u83mr10776741vku.68.1564668847891;
 Thu, 01 Aug 2019 07:14:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190801135721.13211-1-ttayar@habana.ai>
In-Reply-To: <20190801135721.13211-1-ttayar@habana.ai>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Thu, 1 Aug 2019 17:13:41 +0300
Message-ID: <CAFCwf12jg7mS5wB05pfawOPrNC4rXXuSc=yJub5eWQBeHTTOQA@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: Avoid double free in error flow
To:     Tomer Tayar <ttayar@habana.ai>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 1, 2019 at 4:57 PM Tomer Tayar <ttayar@habana.ai> wrote:
>
> In case kernel context init fails during device initialization, both
> hl_ctx_put() and kfree() are called, ending with a double free of the
> kernel context.
> Calling kfree() is needed only when a failure happens between the
> allocation of the kernel context and its initialization, so move it to
> there and remove it from the error flow.
>
> Signed-off-by: Tomer Tayar <ttayar@habana.ai>
> ---
>  drivers/misc/habanalabs/device.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
> index 0c4894dd9c02..7a8f9d0b71b5 100644
> --- a/drivers/misc/habanalabs/device.c
> +++ b/drivers/misc/habanalabs/device.c
> @@ -970,7 +970,8 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
>         rc = hl_ctx_init(hdev, hdev->kernel_ctx, true);
>         if (rc) {
>                 dev_err(hdev->dev, "failed to initialize kernel context\n");
> -               goto free_ctx;
> +               kfree(hdev->kernel_ctx);
> +               goto mmu_fini;
>         }
>
>         rc = hl_cb_pool_init(hdev);
> @@ -1053,8 +1054,6 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
>         if (hl_ctx_put(hdev->kernel_ctx) != 1)
>                 dev_err(hdev->dev,
>                         "kernel ctx is still alive on initialization failure\n");
> -free_ctx:
> -       kfree(hdev->kernel_ctx);
>  mmu_fini:
>         hl_mmu_fini(hdev);
>  eq_fini:
> --
> 2.17.1
>

This patch is:
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Applied to -fixed
Oded
