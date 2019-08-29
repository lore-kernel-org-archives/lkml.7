Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F707C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 03:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 615A422CED
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 03:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gP8dYidy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbfH2DN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 23:13:26 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:53013 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfH2DN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 23:13:26 -0400
Received: by mail-wm1-f44.google.com with SMTP id t17so2082965wmi.2;
        Wed, 28 Aug 2019 20:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zezlNocF3MTF6BR+07qgHXs9JkH6PuU5IAluxDhYuf0=;
        b=gP8dYidy6sTxKhqbX6Hag7AsPbUqaqbdPyR8nBQ+dJK7hwcey8ONy8Lk/O9Fwn9VmO
         NAnVvt+itRbHfo+G5AYGxhWLXvvzydIuxHFH6gH2xfSilIc4jg/78NjqzP5tV8OenADc
         pcMxxt0oUxwwxeguxQBCbHvqnmoxwd0IHuM8v1lyn2YHoEaJADJwOSxw1K+N+7SuHJhR
         IHMD5qf/Vq1NGRQ6M0F69iDpzFRo/B9RvT8edUJHiN4Jl/4pGovfJDy2zbGWxvEDF5Zp
         xzhe4BK8IfifWBadWvz25GKKShj1k6hZsxS7q+T98BTIwsViVCSP8u6cUwX4JYpNWo3E
         Vj3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zezlNocF3MTF6BR+07qgHXs9JkH6PuU5IAluxDhYuf0=;
        b=Bl7/93QfemEDtR10FTJZERlhLdMWK7e+qfPBO0oBuwcCjK+KSD62B29E7lV1TGk3Lv
         Wnosn7HBnpN0YtBCG0OJNX/zdpGpWzLG8mD33bdhqm/GRzrIURZujWbaIE5diE9hFJFF
         0jbjvVHBFcfFDjhr1Qk7S7y4hdf4zHwCHXTg/SJ0nicRZ5Pg8ECGMuGalv00NfhjEiUL
         F81ASKPpFvH1GfmqZatW1wDjl54TMrBEQtB4ZdPRyn8DLNqQLg0NOQI4gN4xEk5oZB/d
         DPZMxHEUKROinX1A15cerq3tw4sMtBQrO0NGlmZKGzTzMX0Kp2VvBAdOC9zJk+ut7TYz
         u4Qw==
X-Gm-Message-State: APjAAAXTuusieXCjnDLAZVYGV7E63H/bPMCDmmbg7WRwV6Glg4Y9zl3A
        glp+VNQbD/iamvpae0gbzB0JNDcu1UYGY+NcgChC7Q==
X-Google-Smtp-Source: APXvYqy1Wk4FCFLjZuvmFsT8usAlkbYWe3LC2XmffZ9uj5OxcZ059EYoAXO1ngbUz2qX1LH6CpuYTtOdR4mGQzVV0Ko=
X-Received: by 2002:a05:600c:352:: with SMTP id u18mr8316756wmd.141.1567048403406;
 Wed, 28 Aug 2019 20:13:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190829005156.26354-1-colin.king@canonical.com>
In-Reply-To: <20190829005156.26354-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 28 Aug 2019 23:13:11 -0400
Message-ID: <CADnq5_MrZuX4AXTv=w+7U4=Nw_6ugzErHBxXY3hhvY4-3jxGvQ@mail.gmail.com>
Subject: Re: [PATCH][drm-next] drm/amdgpu: fix spelling mistake "jumpimng" -> "jumping"
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

Applied.  Thanks!

Alex

On Wed, Aug 28, 2019 at 8:52 PM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in a DRM_DEBUG_DRIVER debug message.
> Fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index 86110e6095cc..8a32b5c93778 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -257,7 +257,7 @@ static uint32_t __correct_eeprom_dest_address(uint32_t curr_address)
>          * https://www.st.com/resource/en/datasheet/m24m02-dr.pdf sec. 5.1.2
>          */
>         if ((curr_address & EEPROM_ADDR_MSB_MASK) != (next_address & EEPROM_ADDR_MSB_MASK)) {
> -               DRM_DEBUG_DRIVER("Reached end of EEPROM memory page, jumpimng to next: %lx",
> +               DRM_DEBUG_DRIVER("Reached end of EEPROM memory page, jumping to next: %lx",
>                                 (next_address & EEPROM_ADDR_MSB_MASK));
>
>                 return  (next_address & EEPROM_ADDR_MSB_MASK);
> --
> 2.20.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
