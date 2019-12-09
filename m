Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE73EC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 20:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 981B72068E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 20:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXMaa1R4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfLIUfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 15:35:39 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40221 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfLIUfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 15:35:39 -0500
Received: by mail-lf1-f66.google.com with SMTP id y5so11810752lfy.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 12:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qOohvwX4XGjXVaQmYXwJYQbj/SKTeE55N+ODU5Zvd+U=;
        b=lXMaa1R4O5zqdvuM3yXaLSWVH7s+5PJJeEtKjJOpVXvwRVMQkKf6Wz9GdjvUhXtdI9
         QjE69/mknRmToGk3tSVuNIXuNtWAO7l6xfkWc1i5dAQl8M4H8yQbqXWmJ/VvMaEuicot
         ORH1+l1V4SMPBOWl7M/wcFYfqE6AsIa5hmRmq1cXd4t66eP0r+lmBdwt6LFsWtRQ1H0+
         GS9CZ4vsuLIzQWSG+h0yR2k7ar4QVnf1AYkN/0syrHYIKPMCbhwSX9zYfCUk5KDP+xcg
         TA253yoID0ZGkTXTu8NLMvt+VzjEE9IVFY17y2Co2LpEXbGx4bvQX617/dquvkCrNDGd
         Ptgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qOohvwX4XGjXVaQmYXwJYQbj/SKTeE55N+ODU5Zvd+U=;
        b=dVhcmir5H61Fjeew8Qxf5mCifu8kJuFtJ9dDFk2/WbSPjX+8HepfBCRsjZtDVHe/gc
         KmzonUTF8Lo6rNqFU4dHZrTPtQnMd/acBAw8ky7ksRNfV8ffL880miUeOVwsT9iVl+GK
         N3oaoDwjQk7moXOMqlgciy9vOvs/LYwZd3B8C3mgJnz+zy5ML6J7ctYgvfnZNn+gn2Df
         +fQ1plDR6tRB0aIXbKJQ6D4tpqvWUIgdZ0Yuwxr3lAzYNW+w3TXDdvjHb9Gftg08GlYP
         hckInIdLTXZPGdBdgBHv1mJL/+i1K+Ioo732OkNNXcW5O2NexhWqO9VbYeFowxl0nQlS
         HlcQ==
X-Gm-Message-State: APjAAAXkV+FXToxCRnU2I7wKVU1lATJwAFeNnIH025yUboGf0SqPUrdB
        fMyk88EHhJflzkyD1hUdeQR6bSsiXI4ylGgjHs8=
X-Google-Smtp-Source: APXvYqxFRlSSw7/x5rATb8AkrtViJDNVF4OyN9zZjRQ4ZWbEjSyU70WIlwWFpvdBjoAC40j4+Va02JNxRl8fjNBTDQM=
X-Received: by 2002:ac2:420e:: with SMTP id y14mr16933214lfh.145.1575923737015;
 Mon, 09 Dec 2019 12:35:37 -0800 (PST)
MIME-Version: 1.0
References: <20191209085747.16057-1-hslester96@gmail.com>
In-Reply-To: <20191209085747.16057-1-hslester96@gmail.com>
From:   Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date:   Mon, 9 Dec 2019 21:35:26 +0100
Message-ID: <CAMeQTsbHFjRpi1HrzsV36vkM5MmU_wi2fLiy+TSkgNCb3wdAwA@mail.gmail.com>
Subject: Re: [PATCH] drm/gma500: add a missed gma_power_end in error path
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 9, 2019 at 9:57 AM Chuhong Yuan <hslester96@gmail.com> wrote:
>
> oaktrail_lvds_mode_set() misses a gma_power_end() in an error path.
> Add the call to fix it.
>
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>

Hi Chuhong, thanks for the patch.

Applied to drm-misc-next

-Patrik

> ---
>  drivers/gpu/drm/gma500/oaktrail_lvds.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/gma500/oaktrail_lvds.c b/drivers/gpu/drm/gma500/oaktrail_lvds.c
> index 7390403ea1b7..582e09597500 100644
> --- a/drivers/gpu/drm/gma500/oaktrail_lvds.c
> +++ b/drivers/gpu/drm/gma500/oaktrail_lvds.c
> @@ -117,6 +117,7 @@ static void oaktrail_lvds_mode_set(struct drm_encoder *encoder,
>
>         if (!connector) {
>                 DRM_ERROR("Couldn't find connector when setting mode");
> +               gma_power_end(dev);
>                 return;
>         }
>
> --
> 2.24.0
>
