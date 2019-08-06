Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E31CC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56305214C6
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVmlFjkW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732875AbfHFOKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 10:10:41 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35548 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728259AbfHFOKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 10:10:40 -0400
Received: by mail-wm1-f68.google.com with SMTP id l2so76577518wmg.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 07:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cARuDPvllFn1lWUM9aELb0vIdKd2MGWlXsw/sP4g2S0=;
        b=lVmlFjkWa5PZBY76E9+D+WKr0leENjWuTmvkyl7GSqREHpHwKPxJ+BGSsDpp06DwFc
         X3l0XKa6cnKN7eHCORXzaczS4KqhWAN3LU8uTKSuJm8e+n8FjnYs9jOpMyfmxI+HMSa4
         QZDYyc3MkJSTMsVBCDlYB7jk6nLO6ixJHUn2QpEoeV2p3fXb/UWwMJA/v8ZcsFe7YLO8
         kLpyu4TUIXlE1mI7RX2Zd+UPoDt+pG5UnzoH1tnbefHgudRQKsxn9aWnCeLfA9yLIWvV
         yk664BqZ6ZuLTyeRpjd5nHQs365INAPIdr2ZKDFwy0Sy7ZDzmEvflevNFlPO4DJHcH4d
         xasg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cARuDPvllFn1lWUM9aELb0vIdKd2MGWlXsw/sP4g2S0=;
        b=ON/RqJJkmOVh/haFo68QQ1PGPMlg2lOdRniRxPVr/APxruK9XpGrbhkE7ExKLnV6ej
         h+WRvrMeMrxvbOGv1oaESgEASrO3Y7cf9z5N1xdopZs5drp/Yel/PFAwJqgzkW9m+kDk
         hMIk2XDLm34CqAlRx+Dk2reNgkt/DVy/Ivhb3KdeBN75zhP0Anl8FYRbdRR4zoTOSxd8
         QZDe0bjQ6pJkLC0m5+uMczvXqfwnFBs6qyPuwPgkiNVRbpuARb/Uz8iSRTV5+qtT+NLg
         a6hNX+cEtXW9HPykg35ofjAniE2rS8R5HgO097SMbF9mgQZwPH+iNlPVMMbE8xtGIoTc
         JUAw==
X-Gm-Message-State: APjAAAVJloroMxqJbO/qVntwQ43gZfLR6OqfCl2LAdR+4Rl0Z62kvGPX
        BwCGKou0oGL9k1maRC6G9PdW/8B6EUxEOGYXzMQ=
X-Google-Smtp-Source: APXvYqwMEPB4UjTcplXgUvnLsC7BrhZCQUuZrPENBgkdggX2EZaIxt+4UShPR6rDLuSDrzBQ6dvA+NtmFBD+leSooPA=
X-Received: by 2002:a1c:9e90:: with SMTP id h138mr5312157wme.67.1565100637820;
 Tue, 06 Aug 2019 07:10:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190804203713.13724-1-natechancellor@gmail.com> <MN2PR12MB3344B936DC2DBD85443C6AC7E4DA0@MN2PR12MB3344.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB3344B936DC2DBD85443C6AC7E4DA0@MN2PR12MB3344.namprd12.prod.outlook.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 6 Aug 2019 10:10:25 -0400
Message-ID: <CADnq5_OWUn3Y2RA68pT-Sw1yRKSY0Eqtz=TAoPOXZ5V-KY5EWA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: Zero initialize some variables
To:     "Quan, Evan" <Evan.Quan@amd.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Sun, Aug 4, 2019 at 9:21 PM Quan, Evan <Evan.Quan@amd.com> wrote:
>
> Thanks Nathan. The patch is reviewed-by: Evan Quan <evan.quan@amd.com>
>
> > -----Original Message-----
> > From: Nathan Chancellor <natechancellor@gmail.com>
> > Sent: Monday, August 05, 2019 4:37 AM
> > To: Quan, Evan <Evan.Quan@amd.com>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Koenig, Christian
> > <Christian.Koenig@amd.com>; Zhou, David(ChunMing)
> > <David1.Zhou@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; linux-
> > kernel@vger.kernel.org; clang-built-linux@googlegroups.com; Nathan
> > Chancellor <natechancellor@gmail.com>
> > Subject: [PATCH] drm/amd/powerplay: Zero initialize some variables
> >
> > Clang warns (only Navi warning shown but Arcturus warns as well):
> >
> > drivers/gpu/drm/amd/amdgpu/../powerplay/navi10_ppt.c:1534:4: warning:
> > variable 'asic_default_power_limit' is used uninitialized whenever '?:'
> > condition is false [-Wsometimes-uninitialized]
> >                         smu_read_smc_arg(smu, &asic_default_power_limit);
> >                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/gpu/drm/amd/amdgpu/../powerplay/inc/amdgpu_smu.h:588:3:
> > note:
> > expanded from macro 'smu_read_smc_arg'
> >         ((smu)->funcs->read_smc_arg? (smu)->funcs->read_smc_arg((smu),
> > (arg)) : 0)
> >          ^~~~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/gpu/drm/amd/amdgpu/../powerplay/navi10_ppt.c:1550:30: note:
> > uninitialized use occurs here
> >                 smu->default_power_limit = asic_default_power_limit;
> >                                            ^~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/gpu/drm/amd/amdgpu/../powerplay/navi10_ppt.c:1534:4: note:
> > remove the '?:' if its condition is always true
> >                         smu_read_smc_arg(smu, &asic_default_power_limit);
> >                         ^
> > drivers/gpu/drm/amd/amdgpu/../powerplay/inc/amdgpu_smu.h:588:3:
> > note:
> > expanded from macro 'smu_read_smc_arg'
> >         ((smu)->funcs->read_smc_arg? (smu)->funcs->read_smc_arg((smu),
> > (arg)) : 0)
> >          ^
> > drivers/gpu/drm/amd/amdgpu/../powerplay/navi10_ppt.c:1517:35: note:
> > initialize the variable 'asic_default_power_limit' to silence this warning
> >         uint32_t asic_default_power_limit;
> >                                          ^
> >                                           = 0
> > 1 warning generated.
> >
> > As the code is currently written, if read_smc_arg were ever NULL, arg would
> > fail to be initialized but the code would continue executing as normal
> > because the return value would just be zero.
> >
> > There are a few different possible solutions to resolve this class of warnings
> > which have appeared in these drivers before:
> >
> > 1. Assume the function pointer will never be NULL and eliminate the
> >    wrapper macros.
> >
> > 2. Have the wrapper macros initialize arg when the function pointer is
> >    NULL.
> >
> > 3. Have the wrapper macros return an error code instead of 0 when the
> >    function pointer is NULL so that the callsites can properly bail out
> >    before arg can be used.
> >
> > 4. Initialize arg at the top of its function.
> >
> > Number four is the path of least resistance right now as every other change
> > will be driver wide so do that here. I only make the comment now as food for
> > thought.
> >
> > Fixes: b4af964e75c4 ("drm/amd/powerplay: make power limit retrieval as
> > asic specific")
> > Link: https://github.com/ClangBuiltLinux/linux/issues/627
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 2 +-
> >  drivers/gpu/drm/amd/powerplay/navi10_ppt.c   | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> > b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> > index 215f7173fca8..b92eded7374f 100644
> > --- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> > +++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> > @@ -1326,7 +1326,7 @@ static int arcturus_get_power_limit(struct
> > smu_context *smu,
> >                                    bool asic_default)
> >  {
> >       PPTable_t *pptable = smu->smu_table.driver_pptable;
> > -     uint32_t asic_default_power_limit;
> > +     uint32_t asic_default_power_limit = 0;
> >       int ret = 0;
> >       int power_src;
> >
> > diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> > b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> > index 106352a4fb82..d844bc8411aa 100644
> > --- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> > +++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> > @@ -1514,7 +1514,7 @@ static int navi10_get_power_limit(struct
> > smu_context *smu,
> >                                    bool asic_default)
> >  {
> >       PPTable_t *pptable = smu->smu_table.driver_pptable;
> > -     uint32_t asic_default_power_limit;
> > +     uint32_t asic_default_power_limit = 0;
> >       int ret = 0;
> >       int power_src;
> >
> > --
> > 2.23.0.rc1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
