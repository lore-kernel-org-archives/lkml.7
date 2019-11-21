Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B20DC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 18:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3301A2067D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 18:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRlV/A1K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfKUSgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 13:36:14 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35810 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfKUSgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 13:36:13 -0500
Received: by mail-wr1-f67.google.com with SMTP id s5so5718486wrw.2;
        Thu, 21 Nov 2019 10:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RyP+qGIUmMn5Rn4nl7SNznhru/ZMeAhUvNe8YatkcLM=;
        b=VRlV/A1K4OZsTJcRAi8KhIOUVK/GwYoaZLIN3+UWtkv3K7BKcGbhQxk/k89/ZbyjwW
         a2HXn80y0CWVHWh+Jc8XhAyTcvkWk13deJaz2Q8h4+O3+81t+D17Ww9J0485El97S8lb
         /y7O1vM77o7uQZMXYyp41sej6+CsV1ZRNaPsirdsnk3nmHTenWy3XoHqg94tyNvrGi8W
         HSzyD5qcZJVO0oWWDa96Lu1emr8Pfs9dezvL0407w0AThUJXQ75RuWEgIA9YKUubaMjM
         /DQdn0eG+2traHwJT3qj4sJ9Qh5rx/lPbX1hUZhVEpoiC09tZ8MisAW0GkaXyT5Tlol5
         6D8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RyP+qGIUmMn5Rn4nl7SNznhru/ZMeAhUvNe8YatkcLM=;
        b=Kqa2rTZ6NZEASFMCusLGYz9JowlskHqNqmseOL8Lo1jgwhYfpSKc7bl5la7tMxRrPF
         eBcejg9ntDJ/mHrs/MbnjoGNGFQ0WMUShmKxs/9yFmVlkh2uS+ybATMISRTnIKqaCOkq
         N1vTCO/f/MJ/lyOqvBImWavVe/D8TXnpDMjThwaCfMG07ui9y0JNF6IDzsFWf0dvhY6Q
         5YkMWx1YRSyBStvQFa17aLsoVaWIpcRL7du8ngXjidUyulF2FkbJdBdbVXVsTUvv+roA
         pLP3KnWLjkorb8af6rIaWkcF1EhpdpzwtzFxVUyob+C94SYTu/OF4DZ7sMJ3UMJ/fAJy
         ny0Q==
X-Gm-Message-State: APjAAAX3qslC8zh0RH6+J0r6mUEqUzsPzHOf327BwFfLF7zFdBuoRQfn
        obyLZ7oh27DlJghr5gBr8qhBu5QVRMqDUwuj+hY=
X-Google-Smtp-Source: APXvYqx+/J7uJEB8/qOWY/tARDfUO9c/oBPdqEv7il+2N7tPOYF+oblOZ/aVb6uvLbT/QMn6oxlgyycRMwXkAVeGBBQ=
X-Received: by 2002:a5d:4a8f:: with SMTP id o15mr3870466wrq.50.1574361371508;
 Thu, 21 Nov 2019 10:36:11 -0800 (PST)
MIME-Version: 1.0
References: <20191121165401.405845-1-colin.king@canonical.com>
In-Reply-To: <20191121165401.405845-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 21 Nov 2019 13:35:59 -0500
Message-ID: <CADnq5_OGNUUvixju5qJf7Q_iYu--LAD3LWhXB4pkQFpjS5HpMQ@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amdgpu: remove redundant assignment to pointer write_frame
To:     Colin King <colin.king@canonical.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  thanks!

Alex

On Thu, Nov 21, 2019 at 11:54 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The pointer write_frame is being initialized with a value that is
> never read and it is being updated later with a new value. The
> initialization is redundant and can be removed.
>
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 2a8a08aa6eaf..c02f9ffe5c6b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -1728,7 +1728,7 @@ int psp_ring_cmd_submit(struct psp_context *psp,
>                         int index)
>  {
>         unsigned int psp_write_ptr_reg = 0;
> -       struct psp_gfx_rb_frame *write_frame = psp->km_ring.ring_mem;
> +       struct psp_gfx_rb_frame *write_frame;
>         struct psp_ring *ring = &psp->km_ring;
>         struct psp_gfx_rb_frame *ring_buffer_start = ring->ring_mem;
>         struct psp_gfx_rb_frame *ring_buffer_end = ring_buffer_start +
> --
> 2.24.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
