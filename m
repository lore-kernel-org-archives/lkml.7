Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE61C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 06:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3297021726
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 06:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NDysXy6M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfE0GV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 02:21:56 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:46939 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfE0GVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 02:21:54 -0400
Received: by mail-vs1-f68.google.com with SMTP id x8so9855322vsx.13
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2019 23:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YxJhbGCQeRIczqHCGhPIuHhpBpASyG3xpi/UjbzUnfo=;
        b=NDysXy6M9PCmJgS0IeywzxchLf6sY+7dg8ySoS/e/SL3T5KU2od4fBZz/WBReeMKgh
         nqvav4L/pw9U2lc22xl8FfLUb2tYWnLfcqSswbGS+dsl850aaH3v+ibBaUtjvyAhfn2I
         hJ842lR0yQjII3AFJtH0xFEhK/uMWS19Iwwn2tJI+GpLXhewvXsGO3bGMMJrgeE4EA07
         rk4HnB3CBXkfCd4LQK8Jxd0V92ZgxEFJLBxdCF3hyBClHDPbHB6t1oH/+bCnsk7fKsYS
         02vIBmAagz1uQM7zfBfdsJGX0huLwNiCwkdUj50fi8viH3V/ey5iuW+7X19APnKG/ylF
         thig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YxJhbGCQeRIczqHCGhPIuHhpBpASyG3xpi/UjbzUnfo=;
        b=UhJNLsBj9ve4R2kD88YDMt+haxoesB1A18T2GaEBa8KF+J8WLrNxI49QLoJYzi74IQ
         58Q/U07hOwKRpyMN8giyi5rf3TVZEs8hBaPfP38X7vnVNSCCPSsuWNnsVuK7s+ArDc1Q
         jyDGKjEGJNAZKGKNR2zzIoMGwNeg2Wl8dDPOcm11Z/2/YqmYBH2zoL6EIZwCQB1gDpqN
         zt4sIpTJ+Z3jk/8+NG+xSuxbDcfEJG/o0f+b0PVgvvKD5NYJWFsRmi24u0p3lmwecBGn
         Q/XZfSxEnPIgfKkZQulzw0RRPe/d2+2C+F9bKIZ36j2bNexpZRuqD+cKBB0U/gUcy1E0
         kAnQ==
X-Gm-Message-State: APjAAAUHI8Y4Bqjplx7SjB/42zarC6xz2Bi1eRXT5BYn3MYkh18ppRjn
        kVYieuk58H1Qh4oD4SoFkiRipOObztwFTrNz0sM=
X-Google-Smtp-Source: APXvYqx4jqvstv3s86u3H1TOhXAG3iKtpXfUSFrgj79X2sBTuZskLWBOtLjfjwJ4bP8nFFfBhkujuQt1lfgpW6Sn+t0=
X-Received: by 2002:a05:6102:1050:: with SMTP id h16mr33145472vsq.132.1558938113452;
 Sun, 26 May 2019 23:21:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190524171536.GA20883@embeddedor>
In-Reply-To: <20190524171536.GA20883@embeddedor>
From:   Ben Skeggs <skeggsb@gmail.com>
Date:   Mon, 27 May 2019 16:21:42 +1000
Message-ID: <CACAvsv53mxOyQCyxxAoTkxocMTPedPb5F2orYAM8K_JcPuYGtw@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH] drm/nouveau/mmu: use struct_size() helper
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 May 2019 at 03:35, Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> Make use of the struct_size() helper instead of an open-coded version
> in order to avoid any potential type mistakes, in particular in the
> context in which this code is being used.
>
> So, replace the following form:
>
> sizeof(*kind) + sizeof(*kind->data) * mmu->kind_nr;
>
> with:
>
> struct_size(kind, data, mmu->kind_nr)
>
> This code was detected with the help of Coccinelle.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Thanks!

> ---
>  drivers/gpu/drm/nouveau/nvif/mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nvif/mmu.c b/drivers/gpu/drm/nouveau/nvif/mmu.c
> index ae08a1ca8044..5641bda2046d 100644
> --- a/drivers/gpu/drm/nouveau/nvif/mmu.c
> +++ b/drivers/gpu/drm/nouveau/nvif/mmu.c
> @@ -110,7 +110,7 @@ nvif_mmu_init(struct nvif_object *parent, s32 oclass, struct nvif_mmu *mmu)
>
>         if (mmu->kind_nr) {
>                 struct nvif_mmu_kind_v0 *kind;
> -               u32 argc = sizeof(*kind) + sizeof(*kind->data) * mmu->kind_nr;
> +               size_t argc = struct_size(kind, data, mmu->kind_nr);
>
>                 if (ret = -ENOMEM, !(kind = kmalloc(argc, GFP_KERNEL)))
>                         goto done;
> --
> 2.21.0
>
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau
