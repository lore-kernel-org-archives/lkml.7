Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4D5C32767
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 05:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40F9720848
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 05:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKX6pJ2c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgAFFyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 00:54:25 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39378 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgAFFyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 00:54:24 -0500
Received: by mail-ot1-f68.google.com with SMTP id 77so70139634oty.6
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jan 2020 21:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Or4qTlqg9VDODG4Ko2IcI+b95Qw2tKuXxb4Y7CVepDI=;
        b=KKX6pJ2c6RNAFkNkr0zvEM2UHGsCocIf2P9hj6fSIJq5Gke9JYMkSkidsBn5ZHPujZ
         SRdJVlcPsrD1TJX2ExrKW1dS9pIzTRxD/5rrunO9yoGMXm4Hi32Ihkf7sTU6HikhQFun
         ikXXSGmb7KZa36txfUFteWHFMn35J1QsL68fCPMeVI8o4UHGjlVD9xzZ/umbkvWrzCzZ
         oPr3gSHg+aUD4kuZrM45R8zLSOyu7TvQWcxh2Csj65CYT/ttETiQRRGnYksGCg9fNqKq
         Nb2EKrJNs7DC2S7odcMrlKyvcQw8bPw25QRKft9Z/5dRYSKRpMEDIG4KudPZTxCRXPIl
         JGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Or4qTlqg9VDODG4Ko2IcI+b95Qw2tKuXxb4Y7CVepDI=;
        b=Mb3VMYHrTQs5UeAjF0RVmldtr1stHWc2V1ldDBxo0AHbW4Yx0qq1uCA6qMX/VO+rQX
         Ru8Chb91WWfpynABmVeZUmjB1w7TA2XXpHmW71VvxxwpDYTBoEF2QBBqt2Ayee3r90Dm
         8trMts/GMp2zFmHfkLxN7Idwi9uHg6m93hyoLaw7ToBxPE1bVillWXWK0tzI75wxuDRr
         BdehsommxbHVX8KWW9c7KCz61o92E1ke1oISF7z5JM838Q6nNmDF4WE7GYzMk73PzuTB
         07oSEWmqDea/Wn6XaKMixxN2uTMEJsKWuW4cRi7gscdh/2w0LrMIRL8QidN+agkG+Zi9
         aqaQ==
X-Gm-Message-State: APjAAAXl//SbC8RX76dzp70jesv70Q3WQ9XegoGz3T52ZxndIVhlf0nz
        8JX0iNoOEOdaRv1Kq7ncxeNgiXXsvYmeatbG9Ix+JiGroME=
X-Google-Smtp-Source: APXvYqxIurl6rq2KX1FNZDoF5pnF+o7mca/0KupKLjCXDznP+OZwHqjppwyZQwjoiX2iuZUk4u2W9DLRbnMaRXPkiK0=
X-Received: by 2002:a05:6830:155a:: with SMTP id l26mr116956036otp.339.1578290063898;
 Sun, 05 Jan 2020 21:54:23 -0800 (PST)
MIME-Version: 1.0
References: <20200105151115.15860-1-ttayar@habana.ai>
In-Reply-To: <20200105151115.15860-1-ttayar@habana.ai>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Mon, 6 Jan 2020 07:54:17 +0200
Message-ID: <CAFCwf1088UjP2RFxAkkmqNC_JgrffD1LLqZqus217-BXhZXwQA@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: Avoid running restore chunks if no execute chunks
To:     Tomer Tayar <ttayar@habana.ai>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 5, 2020 at 5:11 PM Tomer Tayar <ttayar@habana.ai> wrote:
>
> CS with no chunks for execute phase is invalid, so its
> context_switch/restore phase should not be run.
> Hence, move the check of the execute chunks number to the beginning of
> hl_cs_ioctl().
>
> Signed-off-by: Tomer Tayar <ttayar@habana.ai>
> ---
>  drivers/misc/habanalabs/command_submission.c | 41 ++++++++++----------
>  1 file changed, 21 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/misc/habanalabs/command_submission.c b/drivers/misc/habanalabs/command_submission.c
> index 7cb6910378bf..73ef0f9d758a 100644
> --- a/drivers/misc/habanalabs/command_submission.c
> +++ b/drivers/misc/habanalabs/command_submission.c
> @@ -657,8 +657,8 @@ int hl_cs_ioctl(struct hl_fpriv *hpriv, void *data)
>         struct hl_device *hdev = hpriv->hdev;
>         union hl_cs_args *args = data;
>         struct hl_ctx *ctx = hpriv->ctx;
> -       void __user *chunks;
> -       u32 num_chunks;
> +       void __user *chunks_execute, *chunks_restore;
> +       u32 num_chunks_execute, num_chunks_restore;
>         u64 cs_seq = ULONG_MAX;
>         int rc, do_ctx_switch;
>         bool need_soft_reset = false;
> @@ -671,13 +671,25 @@ int hl_cs_ioctl(struct hl_fpriv *hpriv, void *data)
>                 goto out;
>         }
>
> +       chunks_execute = (void __user *) (uintptr_t) args->in.chunks_execute;
> +       num_chunks_execute = args->in.num_chunks_execute;
> +
> +       if (!num_chunks_execute) {
> +               dev_err(hdev->dev,
> +                       "Got execute CS with 0 chunks, context %d\n",
> +                       ctx->asid);
> +               rc = -EINVAL;
> +               goto out;
> +       }
> +
>         do_ctx_switch = atomic_cmpxchg(&ctx->thread_ctx_switch_token, 1, 0);
>
>         if (do_ctx_switch || (args->in.cs_flags & HL_CS_FLAGS_FORCE_RESTORE)) {
>                 long ret;
>
> -               chunks = (void __user *)(uintptr_t)args->in.chunks_restore;
> -               num_chunks = args->in.num_chunks_restore;
> +               chunks_restore =
> +                       (void __user *) (uintptr_t) args->in.chunks_restore;
> +               num_chunks_restore = args->in.num_chunks_restore;
>
>                 mutex_lock(&hpriv->restore_phase_mutex);
>
> @@ -705,13 +717,13 @@ int hl_cs_ioctl(struct hl_fpriv *hpriv, void *data)
>
>                 hdev->asic_funcs->restore_phase_topology(hdev);
>
> -               if (num_chunks == 0) {
> +               if (!num_chunks_restore) {
>                         dev_dbg(hdev->dev,
>                         "Need to run restore phase but restore CS is empty\n");
>                         rc = 0;
>                 } else {
> -                       rc = _hl_cs_ioctl(hpriv, chunks, num_chunks,
> -                                               &cs_seq);
> +                       rc = _hl_cs_ioctl(hpriv, chunks_restore,
> +                                               num_chunks_restore, &cs_seq);
>                 }
>
>                 mutex_unlock(&hpriv->restore_phase_mutex);
> @@ -724,7 +736,7 @@ int hl_cs_ioctl(struct hl_fpriv *hpriv, void *data)
>                 }
>
>                 /* Need to wait for restore completion before execution phase */
> -               if (num_chunks > 0) {
> +               if (num_chunks_restore) {
>                         ret = _hl_cs_wait_ioctl(hdev, ctx,
>                                         jiffies_to_usecs(hdev->timeout_jiffies),
>                                         cs_seq);
> @@ -752,18 +764,7 @@ int hl_cs_ioctl(struct hl_fpriv *hpriv, void *data)
>                 }
>         }
>
> -       chunks = (void __user *)(uintptr_t)args->in.chunks_execute;
> -       num_chunks = args->in.num_chunks_execute;
> -
> -       if (num_chunks == 0) {
> -               dev_err(hdev->dev,
> -                       "Got execute CS with 0 chunks, context %d\n",
> -                       ctx->asid);
> -               rc = -EINVAL;
> -               goto out;
> -       }
> -
> -       rc = _hl_cs_ioctl(hpriv, chunks, num_chunks, &cs_seq);
> +       rc = _hl_cs_ioctl(hpriv, chunks_execute, num_chunks_execute, &cs_seq);
>
>  out:
>         if (rc != -EAGAIN) {
> --
> 2.17.1
>

This patch is:
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Applied to -next
Thanks,
Oded
