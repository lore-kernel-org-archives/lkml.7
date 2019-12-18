Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F61FC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F017D2176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHrQ37zd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfLRUL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 15:11:58 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50687 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfLRUL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 15:11:57 -0500
Received: by mail-wm1-f65.google.com with SMTP id a5so3172022wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 12:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=asjBFAc442UzOKCO94ECHDPGR6UOLGBjJoWcETKLgww=;
        b=RHrQ37zd7pZ1Ol32SljckI6ty3rBZXzVoS1TBltTsFzON8fQ63O6OfA994LtZYp9lN
         17stnxMuVRXa3G3uCuKKMgMR4Od4+bP0vNpmuPs+KvsGj9IZj0DxhDxoCwnp7dtqiQyj
         iehJp4M0U5p4wmmKswfZpSiL+y1fYHiDC0qpEGDniHjSU/88k+yN5Ph/b4pqg4PKHsAd
         vpu+8IqIS8WI5Y+viJpkkybZqHyuFzLRt/8XBefG0psrXlqvPQCxXLSAI6UHzxOrsbEE
         aatzZP3Hzh6vkUJqw+rAK0/zqGAqwF5Vq8gHApc7Jt+22YfIckGkOb/xNpw67CwIw0KN
         vKPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=asjBFAc442UzOKCO94ECHDPGR6UOLGBjJoWcETKLgww=;
        b=kprtPRo+eouOTqLexOwyHj1MfrJnoxHMWPtfix8GamctQK5yuRb3hCFyu2TCheOc0K
         vUTvSeASeVA9vm1mTrssSUUi31togGprA/KyTEx7xqUWH+AfifweUv973Pli9rAvGE5n
         ebX3f+Prk0Ahyps5pP+gRC0tNLMe9uD5H3A1la1cTH4c+yE8bsZNVNq/+T58lC/bByGO
         Krqz4QIJW3rfK/2f3MxMXAJdM8cpUaX/pIyddUyIXbuE9KciFI9n+xr4qfKoe4/0sIYh
         Gnm215cXomGwWpfrLSnfYTxVny/rL57J4zCEod7+REupVHClDC373bfK3nY0wRl3ypCk
         N9NA==
X-Gm-Message-State: APjAAAVzzyexC5olVeKt8VksZ8fU9AR5IRblGc9CDooUO6X3ezzg1O9I
        r1fBJQIicuLNQaht7goI4FPeh+EUh+PGAI0yXzM=
X-Google-Smtp-Source: APXvYqyDcj+8JBYZx+iJu5kmpX47FYUUmcFFn7vpG8sArbbMcs6yo1LPH1elohOVN5VqTG3bb/D1fywuF7VaeZuHui4=
X-Received: by 2002:a1c:f30e:: with SMTP id q14mr5330685wmq.65.1576699915830;
 Wed, 18 Dec 2019 12:11:55 -0800 (PST)
MIME-Version: 1.0
References: <1576641008-14880-1-git-send-email-zhangpan26@huawei.com>
In-Reply-To: <1576641008-14880-1-git-send-email-zhangpan26@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 18 Dec 2019 15:11:43 -0500
Message-ID: <CADnq5_Ozj+PjFGO9V9O3bajujNBcuBiL+vJYbV7dHUhZhNhdGw@mail.gmail.com>
Subject: Re: [PATCH 3/3] gpu: drm: dead code elimination
To:     Pan Zhang <zhangpan26@huawei.com>
Cc:     hushiyuan@huawei.com,
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

On Wed, Dec 18, 2019 at 3:14 AM Pan Zhang <zhangpan26@huawei.com> wrote:
>
> this set adds support for removal of gpu drm dead code.
>
> patch3 is similar with patch 1:
> `num` is a data of u8 type and ATOM_MAX_HW_I2C_READ == 255,
>
> so there is a impossible condition '(num > 255) => (0-255 > 255)'.
>
> Signed-off-by: Pan Zhang <zhangpan26@huawei.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/radeon/atombios_i2c.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/atombios_i2c.c b/drivers/gpu/drm/radeon/atombios_i2c.c
> index a570ce4..ab4d210 100644
> --- a/drivers/gpu/drm/radeon/atombios_i2c.c
> +++ b/drivers/gpu/drm/radeon/atombios_i2c.c
> @@ -68,11 +68,6 @@ static int radeon_process_i2c_ch(struct radeon_i2c_chan *chan,
>                         memcpy(&out, &buf[1], num);
>                 args.lpI2CDataOut = cpu_to_le16(out);
>         } else {
> -               if (num > ATOM_MAX_HW_I2C_READ) {
> -                       DRM_ERROR("hw i2c: tried to read too many bytes (%d vs 255)\n", num);
> -                       r = -EINVAL;
> -                       goto done;
> -               }
>                 args.ucRegIndex = 0;
>                 args.lpI2CDataOut = 0;
>         }
> --
> 2.7.4
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
