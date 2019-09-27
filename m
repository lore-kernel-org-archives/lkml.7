Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AB1C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 13:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A1D22146E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 13:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnq+kjqs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbfI0N3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 09:29:37 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45488 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfI0N3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 09:29:36 -0400
Received: by mail-wr1-f67.google.com with SMTP id r5so2715420wrm.12
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 06:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3Yvc/nzaZmJBsmJXhAJkLnQVaJpozJnKbpg0eQa5Qo8=;
        b=fnq+kjqskJS0KuwpQa0gPSbJKen8LBIvM3oDdLqPi6RPoCGHCT/4RqBXsLqvzMLxoS
         9acZZJ6G+8oD5O7zL8pGtmAOO/thWwbIAHHIA1PSTgiQuUtw4VhzwGFWNAcISUb/+f10
         z2zbXo3IlThJroWUWgAHdqvC3gT82IO/4DizaAznpHNCaMNF5cZrz3UQkU8E4IOwA9i7
         gxvBmzu8rmUCUNn7GK5PcOy7nr2hD9mh/C+Sz+ofC+m/p3RTNTCRPkpwVyYIuKzz7xIV
         +s/Tb2DTk9C4GFk2KUXS+Xr6kVVyDebHGqud3w3nsOA4P5LREX/vCxPXmElY7vi9uX76
         x15w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3Yvc/nzaZmJBsmJXhAJkLnQVaJpozJnKbpg0eQa5Qo8=;
        b=c8bwucT7TU7IUycbArpCUO0ZotLQkEKVD5jEejBe9lnpAh8sDdIr5YkeGyZ761XV5d
         WbdVgTEjbdTp7Qw6H4fRcwffHmu8/nE8qKCWJ9gdUagJsX/IU9s/kQaMRfIH6/7He3o+
         ZrGAtdB88W/7XwJQkzpVah0JOn1S0nee1S7t5CJUjmO6srHaFetOoaMURmNTr291hEyX
         dtFGmDmbWRQid+wMHwODd+7rUsCGjBA3ragr/aOkLOFx9ituzHrHyVMOw/FjcETjhV9f
         U8zEs6hKeGEJqxShwfabvw32UGQfst8kEeDs7SQ33aEbZ79lfv8isTTQtfsmibNuacD6
         imhg==
X-Gm-Message-State: APjAAAV6WLsB9DeUncJW2toKoxhBV+7qvQfFXzNJCDjM+zqiRgqtvTlI
        44hqJ3uKCJUTmFLVb+iq557PRG0kUjA7v+u2YxU=
X-Google-Smtp-Source: APXvYqyd9x7rEK/DDeeWCHCfRX/0NNTZ/TC215iR0DBDc11VFkiBI++Nb2bl54FbIbjw+94zKIPa6bAwUkoUlmkJjy0=
X-Received: by 2002:a5d:4444:: with SMTP id x4mr2947156wrr.11.1569590974750;
 Fri, 27 Sep 2019 06:29:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190903204645.25487-25-lyude@redhat.com> <20190925215251.10030-1-lyude@redhat.com>
In-Reply-To: <20190925215251.10030-1-lyude@redhat.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 27 Sep 2019 09:29:22 -0400
Message-ID: <CADnq5_OhiBZ=S1d4o+4yn1YB9cNagxXLdFWZ-A8ZQeo-FdK9Aw@mail.gmail.com>
Subject: Re: [PATCH v4] drm/amdgpu/dm: Resume short HPD IRQs before resuming
 MST topology
To:     Lyude Paul <lyude@redhat.com>
Cc:     Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Mario Kleiner <mario.kleiner.de@gmail.com>,
        Leo Li <sunpeng.li@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Imre Deak <imre.deak@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        David Airlie <airlied@linux.ie>,
        Juston Li <juston.li@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Harry Wentland <harry.wentland@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Francis <David.Francis@amd.com>,
        Harry Wentland <hwentlan@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 5:53 PM Lyude Paul <lyude@redhat.com> wrote:
>
> Since we're going to be reprobing the entire topology state on resume
> now using sideband transactions, we need to ensure that we actually have
> short HPD irqs enabled before calling drm_dp_mst_topology_mgr_resume().
> So, do that.
>
> Changes since v4:
> * Fix typo in comments
>
> Cc: Juston Li <juston.li@intel.com>
> Cc: Imre Deak <imre.deak@intel.com>
> Cc: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
> Cc: Harry Wentland <hwentlan@amd.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 18927758a010..bce9a298bc45 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1186,15 +1186,15 @@ static int dm_resume(void *handle)
>         /* program HPD filter */
>         dc_resume(dm->dc);
>
> -       /* On resume we need to  rewrite the MSTM control bits to enamble=
 MST*/
> -       s3_handle_mst(ddev, false);
> -
>         /*
>          * early enable HPD Rx IRQ, should be done before set mode as sho=
rt
>          * pulse interrupts are used for MST
>          */
>         amdgpu_dm_irq_resume_early(adev);
>
> +       /* On resume we need to rewrite the MSTM control bits to enable M=
ST*/
> +       s3_handle_mst(ddev, false);
> +
>         /* Do detection*/
>         drm_connector_list_iter_begin(ddev, &iter);
>         drm_for_each_connector_iter(connector, &iter) {
> --
> 2.21.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
