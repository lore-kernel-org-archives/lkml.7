Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B479C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 21:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0577A2075D
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 21:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZCiuXFe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730563AbfI3VcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 17:32:03 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35066 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbfI3VcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 17:32:03 -0400
Received: by mail-io1-f65.google.com with SMTP id q10so42386084iop.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 14:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w11mGwXAGqSILDThqsqkwSrlbLeSz5QPbtHcgogaejo=;
        b=RZCiuXFesadeX9FL8sHaWkzlZ7rJdatezLvrAW3j8IXocXNwZNcvwbc9gbkFv7m00J
         yTs613PwBpXWB+EmspKI4MmgPD8FBe3nWCCPkQvXyIai51+rFRgxjSpOb4ZQXFXbAa1r
         agIuKthIg+b0uobf/MtFfUioYrMfzhHHJooi4jgBmjjYM9lxhA3WrFrgyp/nLCE9uqqV
         0iioVO7IKFmCNkMIBz5nxHMuGGyfzpcO34EXgoRupNQpmWcNE8sUsTwOCObICiRPDX6N
         l/L0VxTTmRmjY28pVhvL8NsStSqPs96JUudPS2t4SFBOLtjqI2d4+SKRtkFW4DKmIZmf
         Fcyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w11mGwXAGqSILDThqsqkwSrlbLeSz5QPbtHcgogaejo=;
        b=Y3qIOF4eyWx2uf7JrUq6f6pjt13MRUpmG67ApYeLyE52ldgcZ21Y2VnLwMFYRg3Uft
         P0FqTndxZXu0KznkHWjM3K2Z8xEkLZo2iCjJQINPE/94EvQbVeMajupBRLIhUbP627+8
         wVnz8oR/cbUVP33YGeD4mLwQkUwtpYgre4WojQ9B0Rnv696bGCrB5SzKbTflyhqskLzS
         xOiidG+qGnJplvpnJI99BfFe643Ot1zDO+HFNcrXep9qCuDQ4MFhoH5oM2TZo2GQhc8M
         Fqnhb5+LqTx5Ni/C5Ny6R5MPLTIOpyyMknlbR8q3/I6jmqmTLRkYmn3mnG5nXO8pfkoI
         xSJA==
X-Gm-Message-State: APjAAAVFEVi5EbQbQXXKPIE4RlmYGRbQU9xkrlX5BEFHIb0r8SMHjFIl
        lt59KGee6FTBWBNEPccOu7AjrRtitRfofOxY4mY=
X-Google-Smtp-Source: APXvYqxO56M3+g2NqwZT4JBLOZ9EjcM/IWK+zeqrzDyjaGItXiwH7jlRd5Jd3Gi4fjetcDWqMUgpWWwYj92aLRLyxcI=
X-Received: by 2002:a92:c90b:: with SMTP id t11mr23674682ilp.227.1569879122078;
 Mon, 30 Sep 2019 14:32:02 -0700 (PDT)
MIME-Version: 1.0
References: <7bab24ff-ded7-9f76-ba25-efd07cdd30dd@amd.com> <20190918190529.17298-1-navid.emamdoost@gmail.com>
 <88fc639a-32ed-b6c6-f930-552083d5887d@amd.com>
In-Reply-To: <88fc639a-32ed-b6c6-f930-552083d5887d@amd.com>
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Date:   Mon, 30 Sep 2019 16:31:51 -0500
Message-ID: <CAEkB2EREjd9BbOeMmk9VWg+UB4ujieMz13Pj7hoAPpE2PGh3hQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: fix multiple memory leaks
To:     "Koenig, Christian" <Christian.Koenig@amd.com>
Cc:     "emamd001@umn.edu" <emamd001@umn.edu>,
        "smccaman@umn.edu" <smccaman@umn.edu>,
        "kjlu@umn.edu" <kjlu@umn.edu>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Rex Zhu <Rex.Zhu@amd.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 3:03 AM Koenig, Christian
<Christian.Koenig@amd.com> wrote:
>
> Am 18.09.19 um 21:05 schrieb Navid Emamdoost:
> > In acp_hw_init there are some allocations that needs to be released in
> > case of failure:
> >
> > 1- adev->acp.acp_genpd should be released if any allocation attemp for
> > adev->acp.acp_cell, adev->acp.acp_res or i2s_pdata fails.
> > 2- all of those allocations should be released if pm_genpd_add_device
> > fails.
> >
> > v2: moved the released into goto error handlings
> >
> > Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c | 30 +++++++++++++++++--------
> >   1 file changed, 21 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> > index eba42c752bca..c0db75b71859 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> > @@ -184,7 +184,7 @@ static struct device *get_mfd_cell_dev(const char *device_name, int r)
> >    */
> >   static int acp_hw_init(void *handle)
> >   {
> > -     int r, i;
> > +     int r, i, ret;
> >       uint64_t acp_base;
> >       u32 val = 0;
> >       u32 count = 0;
> > @@ -231,20 +231,21 @@ static int acp_hw_init(void *handle)
> >       adev->acp.acp_cell = kcalloc(ACP_DEVS, sizeof(struct mfd_cell),
> >                                                       GFP_KERNEL);
> >
> > -     if (adev->acp.acp_cell == NULL)
> > -             return -ENOMEM;
> > +     if (adev->acp.acp_cell == NULL) {
> > +             ret = -ENOMEM;
> > +             goto out1;
> > +     }
> >
> >       adev->acp.acp_res = kcalloc(5, sizeof(struct resource), GFP_KERNEL);
> >       if (adev->acp.acp_res == NULL) {
> > -             kfree(adev->acp.acp_cell);
> > -             return -ENOMEM;
> > +             ret = -ENOMEM;
> > +             goto out2;
> >       }
> >
> >       i2s_pdata = kcalloc(3, sizeof(struct i2s_platform_data), GFP_KERNEL);
> >       if (i2s_pdata == NULL) {
> > -             kfree(adev->acp.acp_res);
> > -             kfree(adev->acp.acp_cell);
> > -             return -ENOMEM;
> > +             ret = -ENOMEM;
> > +             goto out3;
> >       }
> >
> >       switch (adev->asic_type) {
> > @@ -348,7 +349,8 @@ static int acp_hw_init(void *handle)
> >               r = pm_genpd_add_device(&adev->acp.acp_genpd->gpd, dev);
> >               if (r) {
> >                       dev_err(dev, "Failed to add dev to genpd\n");
> > -                     return r;
> > +                     ret = r;
> > +                     goto out4;
> >               }
> >       }
> >
> > @@ -393,6 +395,16 @@ static int acp_hw_init(void *handle)
> >       val &= ~ACP_SOFT_RESET__SoftResetAud_MASK;
> >       cgs_write_register(adev->acp.cgs_device, mmACP_SOFT_RESET, val);
> >       return 0;
> > +
> > +out4:
> > +     kfree(i2s_pdata);
> > +out3:
> > +     kfree(adev->acp.acp_res);
> > +out2:
> > +     kfree(adev->acp.acp_cell);
> > +out1:
> > +     kfree(adev->acp.acp_genpd);
>
> kfree on a NULL pointer is harmless, so a single error label should be
> sufficient.
>
I fixed this by just using failure label.

> Christian.
>
> > +     return ret;
> >   }
> >
> >   /**
>

In addition to previous cases, I covered 3 more error handling cases
that seemed need to goto failure. One where mfd_add_hotplug_devices
fails and the other two cases where time out values expire.


-- 
Navid.
