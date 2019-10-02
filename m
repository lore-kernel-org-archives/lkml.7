Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CEAC35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 03:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90C9120842
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 03:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sGL6YU+1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729856AbfJBDr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 23:47:27 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43986 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfJBDr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 23:47:27 -0400
Received: by mail-io1-f67.google.com with SMTP id v2so53587519iob.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 20:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cyeOZzVtoo6+9g711Hcrl1g5tnj28lsz4tiO7hKPybE=;
        b=sGL6YU+1jnkvMv+85Lf98Ulcb+2b9iHenuZqnXzDwfohRGjD9n96KXrQ1EBAeuz/s2
         AHaiGV7ns6iMMLx928JpvscKe+uJ3L+Zpn0Omc49RqA9dY+DEJaFNvBW8o2d/BneLt6m
         mx/6vl96yzWVTRzc6gKsGFUYC8yNJ23Z3/VjhsaQE0P0C8Z0Dvb/RIzGXV0IRwDM0X77
         Odxpg93wpS5Fd61KgMX/6EK25PhESU6dX6OML2CGzlWlolY87PBN6xXUJsmoLTBubi9f
         NjKMNr/qfateh8bm22YxwLCHkBsXQ9d2XNCnOb47cEhJUIh1q2LW3FXzyuKjrbt9VoSr
         /0Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cyeOZzVtoo6+9g711Hcrl1g5tnj28lsz4tiO7hKPybE=;
        b=mz6ezlmT+H8fzaF+iBB+ux3h+SmO2IRpQ/bntAQdYu412WzGc81ulR0+XBcXieE6RG
         s54t6m6kQZhoZwy6gQjnoN+4VQZL5c28RaCGFmp6OXW4P0dlVF8LI+BBtd0+8zM2uTCQ
         FU/dr7qhqAkU05pPa1NZkHOjUaDVK/qyKp6qyRKHjCLEyt6jraH+Ks/9r5xKM0X3PPuI
         059W8naIqCMr8+sBbfiKBvz3S2ca9BajPasT49DMN0LoFKBuOmaRzhPgo+p227hmsCon
         Wj3+mGrTUfAQKtYAmW6B9AnRcHOqkI609/PHhjnUQzAtda7xXWv/mHUipU0S4q2U3Itn
         5NFw==
X-Gm-Message-State: APjAAAWwVmsKv0zG/5pQYwX1ePEko52hLZTYLDcAugISAc11NaETv5c3
        WErAX/OLi2d8/U7+dCE+0nie9boVuwua8Qt2jqY=
X-Google-Smtp-Source: APXvYqzVJLS7QSZLNssPNnhtiqbO5mN10F/U01KvPEB02IU1gpzezTH2MFjW1uWo7euX85UzeoxYIN/8vEOwlsg4I3k=
X-Received: by 2002:a92:8702:: with SMTP id m2mr1795060ild.294.1569988046094;
 Tue, 01 Oct 2019 20:47:26 -0700 (PDT)
MIME-Version: 1.0
References: <88fc639a-32ed-b6c6-f930-552083d5887d@amd.com> <20190930212644.9372-1-navid.emamdoost@gmail.com>
 <3a00a4c9-af4c-3505-1bef-b119435da5d7@amd.com>
In-Reply-To: <3a00a4c9-af4c-3505-1bef-b119435da5d7@amd.com>
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Date:   Tue, 1 Oct 2019 22:47:15 -0500
Message-ID: <CAEkB2EQzE2A-9QzqU9nVmj8xZE-6+Gqs-fCtP57KsBKj_5Do-A@mail.gmail.com>
Subject: Re: [PATCH v3] drm/amdgpu: fix multiple memory leaks in acp_hw_init
To:     "Koenig, Christian" <Christian.Koenig@amd.com>
Cc:     "emamd001@umn.edu" <emamd001@umn.edu>,
        "smccaman@umn.edu" <smccaman@umn.edu>,
        "kjlu@umn.edu" <kjlu@umn.edu>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>, Rex Zhu <Rex.Zhu@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 1, 2019 at 7:19 AM Koenig, Christian
<Christian.Koenig@amd.com> wrote:
>
> Am 30.09.19 um 23:26 schrieb Navid Emamdoost:
> > In acp_hw_init there are some allocations that needs to be released in
> > case of failure:
> >
> > 1- adev->acp.acp_genpd should be released if any allocation attemp for
> > adev->acp.acp_cell, adev->acp.acp_res or i2s_pdata fails.
> > 2- all of those allocations should be released if
> > mfd_add_hotplug_devices or pm_genpd_add_device fail.
> > 3- Release is needed in case of time out values expire.
> >
> > Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> > ---
> > Changes in v2:
> >       -- moved the releases under goto
> >
> > Changes in v3:
> >       -- fixed multiple goto issue
> >       -- added goto for 3 other failure cases: one when
> > mfd_add_hotplug_devices fails, and two when time out values expires.
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c | 41 ++++++++++++++++---------
> >   1 file changed, 27 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> > index eba42c752bca..7809745ec0f1 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> > @@ -184,12 +184,12 @@ static struct device *get_mfd_cell_dev(const char *device_name, int r)
> >    */
> >   static int acp_hw_init(void *handle)
> >   {
> > -     int r, i;
> > +     int r, i, ret;
>
> Please don't add another "ret" variable, instead always use "r" here.
>
Done!

> Apart from that looks good to me,
> Christian.
>
> >       uint64_t acp_base;
> >       u32 val = 0;
> >       u32 count = 0;
> >       struct device *dev;
> > -     struct i2s_platform_data *i2s_pdata;
> > +     struct i2s_platform_data *i2s_pdata = NULL;
> >
> >       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> >
> > @@ -231,20 +231,21 @@ static int acp_hw_init(void *handle)
> >       adev->acp.acp_cell = kcalloc(ACP_DEVS, sizeof(struct mfd_cell),
> >                                                       GFP_KERNEL);
> >
> > -     if (adev->acp.acp_cell == NULL)
> > -             return -ENOMEM;
> > +     if (adev->acp.acp_cell == NULL) {
> > +             ret = -ENOMEM;
> > +             goto failure;
> > +     }
> >
> >       adev->acp.acp_res = kcalloc(5, sizeof(struct resource), GFP_KERNEL);
> >       if (adev->acp.acp_res == NULL) {
> > -             kfree(adev->acp.acp_cell);
> > -             return -ENOMEM;
> > +             ret = -ENOMEM;
> > +             goto failure;
> >       }
> >
> >       i2s_pdata = kcalloc(3, sizeof(struct i2s_platform_data), GFP_KERNEL);
> >       if (i2s_pdata == NULL) {
> > -             kfree(adev->acp.acp_res);
> > -             kfree(adev->acp.acp_cell);
> > -             return -ENOMEM;
> > +             ret = -ENOMEM;
> > +             goto failure;
> >       }
> >
> >       switch (adev->asic_type) {
> > @@ -340,15 +341,18 @@ static int acp_hw_init(void *handle)
> >
> >       r = mfd_add_hotplug_devices(adev->acp.parent, adev->acp.acp_cell,
> >                                                               ACP_DEVS);
> > -     if (r)
> > -             return r;
> > +     if (r) {
> > +             ret = r;
> > +             goto failure;
> > +     }
> >
> >       for (i = 0; i < ACP_DEVS ; i++) {
> >               dev = get_mfd_cell_dev(adev->acp.acp_cell[i].name, i);
> >               r = pm_genpd_add_device(&adev->acp.acp_genpd->gpd, dev);
> >               if (r) {
> >                       dev_err(dev, "Failed to add dev to genpd\n");
> > -                     return r;
> > +                     ret = r;
> > +                     goto failure;
> >               }
> >       }
> >
> > @@ -367,7 +371,8 @@ static int acp_hw_init(void *handle)
> >                       break;
> >               if (--count == 0) {
> >                       dev_err(&adev->pdev->dev, "Failed to reset ACP\n");
> > -                     return -ETIMEDOUT;
> > +                     ret = -ETIMEDOUT;
> > +                     goto failure;
> >               }
> >               udelay(100);
> >       }
> > @@ -384,7 +389,8 @@ static int acp_hw_init(void *handle)
> >                       break;
> >               if (--count == 0) {
> >                       dev_err(&adev->pdev->dev, "Failed to reset ACP\n");
> > -                     return -ETIMEDOUT;
> > +                     ret = -ETIMEDOUT;
> > +                     goto failure;
> >               }
> >               udelay(100);
> >       }
> > @@ -393,6 +399,13 @@ static int acp_hw_init(void *handle)
> >       val &= ~ACP_SOFT_RESET__SoftResetAud_MASK;
> >       cgs_write_register(adev->acp.cgs_device, mmACP_SOFT_RESET, val);
> >       return 0;
> > +
> > +failure:
> > +     kfree(i2s_pdata);
> > +     kfree(adev->acp.acp_res);
> > +     kfree(adev->acp.acp_cell);
> > +     kfree(adev->acp.acp_genpd);
> > +     return ret;
> >   }
> >
> >   /**
>


-- 
Navid.
