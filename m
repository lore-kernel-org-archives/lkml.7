Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1690C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 20:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C5C7206A5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 20:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DARbWgGW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389762AbfIMUq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 16:46:26 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53175 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388865AbfIMUq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 16:46:26 -0400
Received: by mail-wm1-f66.google.com with SMTP id x2so4035434wmj.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 13:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1naGLqCqgdtfdyuJUQJQeSWIGpqB3wRyICj2L5yhDlc=;
        b=DARbWgGWgYQsaat8eaGaRkAn/auPVWPlTFGGxHsdk9t4WWY+AZ0cL14vZzlkIH4v29
         Q6mn9AGKuPxQMk8JYsya8ud38ltOoYUPhYgm+98lsX/QWLdosseJhlPlZfqsUEMI4uAv
         2131Q/0e0lgx3k4zMHZYMQxNDBAiS6tpwEhfvVJzbJL15PJ38bZWEuLIpaWQV7XhrNdp
         EwBYystF5m8ailktdEQDsymMn84PyXe/WvYqol+/QoxXoNM92sht6DCntyd+uBkCiTG4
         UPBSQx+amuvMgVZYGP2XAce1UmtkCBGC+q0kDzbMkbI0JgcYtLHeTrJUYxQD06zuOsCp
         mbEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1naGLqCqgdtfdyuJUQJQeSWIGpqB3wRyICj2L5yhDlc=;
        b=C5lnx+CbcioyFG2yz7o1DhuHzTx6BBlW8o9NWXB5elWDhJ8aBriSR90G1cBy9CW+S+
         VaUcGuVyD6XMENJ23zIBlMMRE8k1FAk1H3izUGPetvOzkdsD3L3z2SgY2VqBpOZpfRoZ
         /6vaE2KHCiwBqnLuEh+22YDMwGCErEFM0+lx18WwHu9SmK0ifP8DAP4nGeefg+Yg6N+j
         wGzKmj6fDenqID9fZFV4esUZd8fW9RY2qFdp3t8t77pFrZDGzZWsBKS/JO6Ia1/8jOuI
         CCs9yDPUkkGoMp2vGDBwSEaQSTT/s9AvIYc6J4o2x8D7xrRDNM455qLSCSEY/RwbJc/q
         MTXg==
X-Gm-Message-State: APjAAAUw5RBEa/bRhMv1kwBlyv8noll7do+5oPStgQsQE/IsDfyDKkyP
        lTbETcP8SEDgtupYvXD1fx/TfbAd2v8tc6cSyq4=
X-Google-Smtp-Source: APXvYqwPDJV3BeybpjpeUW/+FQgCUxp6vErxBChp+BRvrIIWuAY5KAYz2RaPlyIzXkNf0e5VQyrmt2juX/xx6GLlflY=
X-Received: by 2002:a1c:ca0f:: with SMTP id a15mr4870663wmg.102.1568407583804;
 Fri, 13 Sep 2019 13:46:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190903204645.25487-1-lyude@redhat.com> <20190903204645.25487-25-lyude@redhat.com>
In-Reply-To: <20190903204645.25487-25-lyude@redhat.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 13 Sep 2019 16:46:12 -0400
Message-ID: <CADnq5_NNdGxtpF477Lu3nTMmHJ+EtYJ1bU2vEzaeQLfJjzQjmg@mail.gmail.com>
Subject: Re: [PATCH v2 24/27] drm/amdgpu/dm: Resume short HPD IRQs before
 resuming MST topology
To:     Lyude Paul <lyude@redhat.com>
Cc:     Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Leo Li <sunpeng.li@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        David Airlie <airlied@linux.ie>,
        Juston Li <juston.li@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Francis <David.Francis@amd.com>,
        Harry Wentland <hwentlan@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 3, 2019 at 4:49 PM Lyude Paul <lyude@redhat.com> wrote:
>
> Since we're going to be reprobing the entire topology state on resume
> now using sideband transactions, we need to ensure that we actually have
> short HPD irqs enabled before calling drm_dp_mst_topology_mgr_resume().
> So, do that.
>
> Cc: Juston Li <juston.li@intel.com>
> Cc: Imre Deak <imre.deak@intel.com>
> Cc: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
> Cc: Harry Wentland <hwentlan@amd.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 73630e2940d4..4d3c8bff77da 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1185,15 +1185,15 @@ static int dm_resume(void *handle)
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
> +       /* On resume we need to  rewrite the MSTM control bits to enamble=
 MST*/
> +       s3_handle_mst(ddev, false);
> +
>         /* Do detection*/
>         drm_connector_list_iter_begin(ddev, &iter);
>         drm_for_each_connector_iter(connector, &iter) {
> --
> 2.21.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
