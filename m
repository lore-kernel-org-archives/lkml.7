Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D88C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 14:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA220207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 14:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o4VyjfsQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbfI0OGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 10:06:10 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36229 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727140AbfI0OGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 10:06:09 -0400
Received: by mail-wm1-f67.google.com with SMTP id m18so6316559wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 07:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xi3+ATvXzmXB/Dt4LOoB4YHPPwUJEINFuh3xzYVNUyg=;
        b=o4VyjfsQmpqzylyql6Fe4TZspDv9dduX8LILxcgo8JecSuLAxMDyXcQlMEJbkxKyR3
         cXGOvJ9f6avucRDBIchg/Kf8o22pmQlaYY2yVrAMOsUBTCjK0FX7O/utMefJ+0H1Jvov
         rfG9JBsp6oXwc/JLRWjT624+YylY3OlLAZO7snD1iVR2efeXRSX47qp8ENgM7dbTW6fK
         P5X5lPG+v5LPpAhwOFmF0P/X1bE72vJRTyfROT+W+FvlNBzNEKjwsIW8pCKAxQrRt8kY
         XN6raMwVzVYL8kxyQ1xMr6kp/iSOQWaFXrXzZYAPohe51uGEBGGDECEN2cjNQVLwnEgr
         wDSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xi3+ATvXzmXB/Dt4LOoB4YHPPwUJEINFuh3xzYVNUyg=;
        b=spsu9egJ/j3WAB3uxeZqZ9batMaBiQ0mpKccqSTC4BVzV5VDbdWxNOLAAiv2R5ZGnM
         mYgNQY356iqq/uWEW0BgHnU/rmkvKXbtzXkPjhrMGEqVs3vWfsIrOhnjDoFSKajWqRsD
         ij7sZ0nQtffgFEgGdtgMHmSx0miDeyax/tsrvwUXE4fTozupdYg8L4L+zBROm3t+c1s9
         U4sJWIRWWc4hkMRvSdD3hOZNKanLGb0wRhACexc7ngoTx+WeAFFSq2iUq0aJnBC1/ok+
         FYw1kV97wzxuGwK7rhbe16xI2HZDMwIstUmL2pt1E2qpXK5kcFHxtf2ywCLMn+OAUhM1
         V+OA==
X-Gm-Message-State: APjAAAXkvSO7rX6CjeeO7wP9PFEmX/JocKnQBPXZyqk1ZWKaE+DGWCCZ
        ILtmR6mrsQvmL0gwbDylX/SFqZXS+54XZFh2CPA=
X-Google-Smtp-Source: APXvYqy724GfC1LKMOovLwoRie2uhk3qAkotzUOMibqrwjt0y8/YsOOfu071krqomAn81ggZE+uK8mj6MX9cFijwB24=
X-Received: by 2002:a1c:7d92:: with SMTP id y140mr7325631wmc.141.1569593166157;
 Fri, 27 Sep 2019 07:06:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190926225122.31455-1-lyude@redhat.com> <20190926225122.31455-3-lyude@redhat.com>
In-Reply-To: <20190926225122.31455-3-lyude@redhat.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 27 Sep 2019 10:05:54 -0400
Message-ID: <CADnq5_MR_WZHOMa0JQWpm9fZgpsCWFpmO1B5Rph_OVhje6kokg@mail.gmail.com>
Subject: Re: [PATCH 2/6] drm/amdgpu/dm/mst: Remove unnecessary NULL check
To:     Lyude Paul <lyude@redhat.com>
Cc:     amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Thomas Lim <Thomas.Lim@amd.com>, Leo Li <sunpeng.li@amd.com>,
        David Francis <David.Francis@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        David Airlie <airlied@linux.ie>,
        "Jerry (Fangzhi) Zuo" <Jerry.Zuo@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 6:52 PM Lyude Paul <lyude@redhat.com> wrote:
>
> kfree() checks this automatically.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

And applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index 185bf0e2bda2..a398ddd1f306 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -144,10 +144,8 @@ dm_dp_mst_connector_destroy(struct drm_connector *connector)
>         struct amdgpu_dm_connector *amdgpu_dm_connector = to_amdgpu_dm_connector(connector);
>         struct amdgpu_encoder *amdgpu_encoder = amdgpu_dm_connector->mst_encoder;
>
> -       if (amdgpu_dm_connector->edid) {
> -               kfree(amdgpu_dm_connector->edid);
> -               amdgpu_dm_connector->edid = NULL;
> -       }
> +       kfree(amdgpu_dm_connector->edid);
> +       amdgpu_dm_connector->edid = NULL;
>
>         drm_encoder_cleanup(&amdgpu_encoder->base);
>         kfree(amdgpu_encoder);
> --
> 2.21.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
