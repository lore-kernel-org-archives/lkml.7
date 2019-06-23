Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C5CC43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 02:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A395120673
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 02:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qCkQmVpC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfFWCma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 22:42:30 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38802 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbfFWCma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 22:42:30 -0400
Received: by mail-io1-f66.google.com with SMTP id j6so404687ioa.5
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2019 19:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cnFWOK8KBDczr/rYP2uNrysQXAIVz65G0LlKrMiXR+0=;
        b=qCkQmVpCurrWTAf7i+jAZr5wtWQfHkzFiDFJ01k89OP/MlzDfcOugjeIWZ19eudvjH
         YdPHpVFpWDIiWbu1tHy7nMZNv91uXhFrr9mg5UmO5O4W3yByuAKEnC38/9THElsSNgKt
         SnsyQHQgQZfzR750GKruPbZJPOUSxiconLsixDkNppIxP+phuVhF0H4dRPHvlkcOLhGj
         +ZNfqXKpLE3NE2znt6rZ6xcEyXTjfhrHHIU5CAkkchh0Q0J/wzcO6cgPnI/E+REKZ3QO
         wOuR8v6R/V4zxmVeoNuuIES1MhCNrVxhLqmOKSxdsJKIQLo0BoTWhAQjsj+BQMCeSV9M
         tEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cnFWOK8KBDczr/rYP2uNrysQXAIVz65G0LlKrMiXR+0=;
        b=c6GPKuF0aUhT33S5d1L8Ol2usdgWhZpeo3Wl9lHMO4wtnMN/2TH1TFw/fNQ9lpdtky
         bJLHSdLCcQAevHyO7fuv9U/SgKt31txVL9nYEMMPrjg2BCeIreiltmY6k/BYNSnOAUDH
         /GfTUrDg/Ytp5t4kFfR43E8uPOuGpf54jLaknkzEwoznan4UZoNV3XedGYEkxgqLmec1
         cRbJUMkI28vuTDJ70u7vJjwJUZdhllqeO4x2k2sLtpGGF3FPKNQl83K9hUXET32RlGGD
         dd/6RMI3PYjm4Ma2DZrg+y4fXmp7b40VdLjp4f0Aj7GV3c0B3hSMPsTfu4lEpG6JU+X8
         kKxA==
X-Gm-Message-State: APjAAAUlN7vPxqZY8w5uwnUt7gtbyvrkcBHeJrqnSUf+aMcoXQzOC5Cs
        l4gnAvbIfOqX/0oeO2a46r8S13krVKpr7HoyRO8=
X-Google-Smtp-Source: APXvYqy2GZpCglXvbYLgZBHVnuts2GjGG9FMnMJEDZrcmFcTX1F6EYSPadbyZ5TUSlKLzCW5J9JwFaiL6/m4AyZ2Gg4=
X-Received: by 2002:a02:ce92:: with SMTP id y18mr34222866jaq.40.1561257749692;
 Sat, 22 Jun 2019 19:42:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190621162117.22533-1-krzk@kernel.org>
In-Reply-To: <20190621162117.22533-1-krzk@kernel.org>
From:   Qiang Yu <yuq825@gmail.com>
Date:   Sun, 23 Jun 2019 10:42:18 +0800
Message-ID: <CAKGbVbviu4i=KAA1cE5X0_du-FnaCzf5ekbmOCv9g8MWuai6vA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] drm/lima: Mark 64-bit number as ULL to silence
 Smatch warning
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        lima@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks. This patch series are:
Reviewed-by: Qiang Yu <yuq825@gmail.com>

I'll apply them to drm-misc-next.

Regards,
Qiang

On Sat, Jun 22, 2019 at 12:21 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Mark long numbers with ULL to silence the Smatch warning:
>
>     drivers/gpu/drm/lima/lima_device.c:314:32: warning: constant 0x100000000 is so big it is long long
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Qiang Yu <yuq825@gmail.com>
>
> ---
>
> Changes since v1:
> 1. Add reviewed-by tag
> ---
>  drivers/gpu/drm/lima/lima_vm.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/lima/lima_vm.h b/drivers/gpu/drm/lima/lima_vm.h
> index caee2f8a29b4..e0bdedcf14dd 100644
> --- a/drivers/gpu/drm/lima/lima_vm.h
> +++ b/drivers/gpu/drm/lima/lima_vm.h
> @@ -15,9 +15,9 @@
>  #define LIMA_VM_NUM_PT_PER_BT (1 << LIMA_VM_NUM_PT_PER_BT_SHIFT)
>  #define LIMA_VM_NUM_BT (LIMA_PAGE_ENT_NUM >> LIMA_VM_NUM_PT_PER_BT_SHIFT)
>
> -#define LIMA_VA_RESERVE_START  0xFFF00000
> +#define LIMA_VA_RESERVE_START  0x0FFF00000ULL
>  #define LIMA_VA_RESERVE_DLBU   LIMA_VA_RESERVE_START
> -#define LIMA_VA_RESERVE_END    0x100000000
> +#define LIMA_VA_RESERVE_END    0x100000000ULL
>
>  struct lima_device;
>
> --
> 2.17.1
>
