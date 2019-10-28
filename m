Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02EA4CA9EC1
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 14:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE22D20659
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 14:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5HdV1xF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730312AbfJ1OGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 10:06:19 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38149 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390028AbfJ1OGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 10:06:19 -0400
Received: by mail-wr1-f67.google.com with SMTP id v9so10035927wrq.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 07:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rdC6V+W/0pKqgJwzkGX8wwGtenk6Ad4eyp94SQwYZN8=;
        b=R5HdV1xFRhfl7jlVF2ygGLA04qDiJw37QSOQZkF7MsnXM5HNM18K4iIPwjs+t3zEUg
         4c/cqHnL2KkIfbY826muE9b5MAoamhv4k7YEbjhAau9OnEU3xDZTMxabEHkjIePduZZj
         sHBbDma0c0O/cHzx7Pkwc7xNE/Zr1TEGxfqpKIGIczkz2oNIJFdkIPqtpyPp6jWbMRvc
         7VM7JHIzh42deYRq+7Pv2L01pohfPkZrcjftyBzrKZt7gOyBW1GQLkAWhHr/GC7Lwutg
         3unltK9XvVTaNIIAMyq0E9vR+o6Sz4RkgQcXuPwJQ98p9o/R0AB4H3e/T53SzUKd6b40
         8w2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rdC6V+W/0pKqgJwzkGX8wwGtenk6Ad4eyp94SQwYZN8=;
        b=Rf6OdCYC8s+gdcyEI/in26aVoLDEaTXSBX43V/eS55KCa0quDimbDOjsk0clg+D/TW
         cQnbStpnpMFZ1Se1Rv+CW/UhyrCPuLPlW/s/pE4WZ0OVk8k8K1agLvAfniFCIis149TY
         v6PWrcv5UfdpWxWw6HVPnajb2HtjA9fNnW94aA2XoIBBi5Mi0gzW2p9t+bIYRMjPQxRY
         OyZMzLHZ3aSc0SOuSdKc7GhdURNkHfa8VmCePWx/+LJWiIwfl2szXMcs+J+H5Epy8HcP
         FLoRU+dg6Smby025pKHk6jNqyYxOJYqzrMN6Wd58izhhzOBxVSrlPvZqo5pjz8HDcD46
         WHdg==
X-Gm-Message-State: APjAAAUMjiFYE9DYm0Hx/8zemUBemmejte+mdjfD+GOUqHFlUgIDip44
        XM9upP9tXpoRdUU5tkQUkjtWeTcvYtw4ZBJTtPc=
X-Google-Smtp-Source: APXvYqx93VfHYQta5r6YehJQFm4Zit5CjBpG85IfDnlOhBb4sBmoUGmL/PYIDYPF4ekeP2EWvHda9cyimGmob83AeLk=
X-Received: by 2002:adf:828c:: with SMTP id 12mr15047712wrc.40.1572271577123;
 Mon, 28 Oct 2019 07:06:17 -0700 (PDT)
MIME-Version: 1.0
References: <20191028133621.21400-1-yuehaibing@huawei.com>
In-Reply-To: <20191028133621.21400-1-yuehaibing@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 28 Oct 2019 10:06:05 -0400
Message-ID: <CADnq5_Ow+W_Syo6G3ZUXJeiLbc4YU=DL1FtznaTKm=RGj4tq1g@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amd/powerplay: Make two functions static
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Rex Zhu <rex.zhu@amd.com>, "Quan, Evan" <evan.quan@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 9:37 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fix sparse warnings:
>
> drivers/gpu/drm/amd/amdgpu/../powerplay/arcturus_ppt.c:2050:5:
>  warning: symbol 'arcturus_i2c_eeprom_control_init' was not declared. Should it be static?
> drivers/gpu/drm/amd/amdgpu/../powerplay/arcturus_ppt.c:2068:6:
>  warning: symbol 'arcturus_i2c_eeprom_control_fini' was not declared. Should it be static?
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.  Thanks.  Is there more to this series?  I don't see patches 1 or 2.

Alex

> ---
>  drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> index d48a49d..3099ac2 100644
> --- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> @@ -2047,7 +2047,7 @@ static const struct i2c_algorithm arcturus_i2c_eeprom_i2c_algo = {
>         .functionality = arcturus_i2c_eeprom_i2c_func,
>  };
>
> -int arcturus_i2c_eeprom_control_init(struct i2c_adapter *control)
> +static int arcturus_i2c_eeprom_control_init(struct i2c_adapter *control)
>  {
>         struct amdgpu_device *adev = to_amdgpu_device(control);
>         int res;
> @@ -2065,7 +2065,7 @@ int arcturus_i2c_eeprom_control_init(struct i2c_adapter *control)
>         return res;
>  }
>
> -void arcturus_i2c_eeprom_control_fini(struct i2c_adapter *control)
> +static void arcturus_i2c_eeprom_control_fini(struct i2c_adapter *control)
>  {
>         i2c_del_adapter(control);
>  }
> --
> 2.7.4
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
