Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A4DC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 18:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6362217D9
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 18:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZCgeDszD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbfI0STQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 14:19:16 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39039 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfI0STP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 14:19:15 -0400
Received: by mail-wm1-f65.google.com with SMTP id v17so6507437wml.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 11:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fA3AyFMETBkkXBMPLk4PEoT5pvbGmGcoWcfzer8Dpbc=;
        b=ZCgeDszDVj753elaOe+KWDWkEmrdRe7T8yV8JfyXUydLncuDesAt0ZOJQARb/Uvhp4
         FLU0sSyG3DwUIub9WjxnbNNXWxHBGV+ikhlPKosoZHz2TIHLHBwcXbF5sJxkYcjb/VGb
         qttKU1daTr9IxM/8FoMSHnmeI4zd+/1alWg/HJ6CwNZbUri52v/CPb7kKY7EEhnPbdDV
         78qtDAdHtdiBdPOexbUK2itMu7u0K52AfLYTo5kf0y6kVxTo9QyB4tPHntKSsGk+Rpwa
         s7mKDQ1IIFGH9NoE47TnbfXL2V9qV2qQx9WxoFM/yolTXt7cas/wuBArvtYpf6NoSyTh
         qfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fA3AyFMETBkkXBMPLk4PEoT5pvbGmGcoWcfzer8Dpbc=;
        b=kQ23EgOv4uy/1P+dqO2M+xd4YTYtvlM54DuYEKNISoPcFsMUG+ROfdJs4C/JMxak7b
         Vueou0MoOJL4H6dZbgPTQ9UF9V7s/bVihqbFMWgy++s2Ji0hhtPIRxLWzPxT9yKdK01y
         U8WR1+EfBP1HxnpAfMeRihWon2FyyY0c8VYsv5PnaWVurcRGmKr2S71Mt9D9/fjvLmjQ
         X9ZZtCOb57RK+b7RUOF02NDtXJOiPHUvDm83AC85LsyRfv8SgGEUWjeqNylEEPFljcJZ
         ghHJNcuWkDrOmdWKZ1ke/Dh6GTVvYMm8NgiURPA+NU0QPQB71Uv0wG504XNf+1LnFFla
         xr0w==
X-Gm-Message-State: APjAAAVgCLDZniCaFdrvUpbrGig7L5IYv3bRm3jQazYHTLK3JY87JE2r
        F5pW5WnpvKthnyYaZ/DovciiX0xY6CqJA02Xw70+qv1d
X-Google-Smtp-Source: APXvYqzvIontBSJjr5BL4fVM0hJ1HtGC2SPpdNGFAWfGbTHRgFyZ9bG6l1I9NU1H98PJUTSkVkJLbuHhtCfMH0o7Tnc=
X-Received: by 2002:a05:600c:2308:: with SMTP id 8mr8649051wmo.67.1569608353487;
 Fri, 27 Sep 2019 11:19:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190926225122.31455-1-lyude@redhat.com> <20190926225122.31455-2-lyude@redhat.com>
 <2a1d5221-b801-44f9-c966-1163b8d67b3f@amd.com>
In-Reply-To: <2a1d5221-b801-44f9-c966-1163b8d67b3f@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 27 Sep 2019 14:18:59 -0400
Message-ID: <CADnq5_PF_aAcCADP1g3+4UFmWM7TVPmSsnaw1GaFqVzBodVE3A@mail.gmail.com>
Subject: Re: [PATCH 1/6] drm/amdgpu/dm/mst: Don't create MST topology managers
 for eDP ports
To:     Harry Wentland <hwentlan@amd.com>
Cc:     Lyude Paul <lyude@redhat.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        Thomas Lim <Thomas.Lim@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Francis, David" <David.Francis@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        "Zuo, Jerry" <Jerry.Zuo@amd.com>, Daniel Vetter <daniel@ffwll.ch>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 1:48 PM Harry Wentland <hwentlan@amd.com> wrote:
>
> On 2019-09-26 6:51 p.m., Lyude Paul wrote:
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>

Applied.  Thanks!

Alex

> Harry
>
> > ---
> >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> > index 5ec14efd4d8c..185bf0e2bda2 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> > @@ -417,6 +417,10 @@ void amdgpu_dm_initialize_dp_connector(struct amdgpu_display_manager *dm,
> >       drm_dp_aux_register(&aconnector->dm_dp_aux.aux);
> >       drm_dp_cec_register_connector(&aconnector->dm_dp_aux.aux,
> >                                     &aconnector->base);
> > +
> > +     if (aconnector->base.connector_type == DRM_MODE_CONNECTOR_eDP)
> > +             return;
> > +
> >       aconnector->mst_mgr.cbs = &dm_mst_cbs;
> >       drm_dp_mst_topology_mgr_init(
> >               &aconnector->mst_mgr,
> >
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
