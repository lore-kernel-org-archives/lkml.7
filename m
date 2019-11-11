Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE6DC17441
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 17:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D65C2173B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 17:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oVKPNzZQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfKKR3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 12:29:09 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:44011 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfKKR3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 12:29:08 -0500
Received: by mail-wr1-f46.google.com with SMTP id n1so15502168wra.10;
        Mon, 11 Nov 2019 09:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WvahG5W8zWbUV9iqIm0KSrs4sqEMRwt53GgRh7CNpec=;
        b=oVKPNzZQoZ50rPMdCnJF0EIT92tbzpfWMmemCHN4JDQliBjPItaFwxO58zW1nWMHc0
         OWw7wfQdOZvtiro0hMaTKCfv6m18CWljs4kfOrmarRWWwoPlsPAtaubiHkb4XUh1BSK/
         w5lSdpoGfmOSHxb8zZzYF2rF0rfWuBY/zgXLuhR49CnMG1GWMSkUvIGRnOzi4KVUM1hm
         OGTz+cNWI8Q1jJBEgwe4PHqbt0wO0gFNWwYMfBDruCvYh5sSKJD1r38etLNHsGEorCFt
         sw4b7kZdE7tvTl1sKDZ11mT5BwzWc9HB6erR9SNuykOxLyjYFLOVtjjjA6Aq4yWjuwW6
         5MfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WvahG5W8zWbUV9iqIm0KSrs4sqEMRwt53GgRh7CNpec=;
        b=nsRZPSIlZuoQCEq33YcDw3g/3lla55EKAdiC3xPAJZ5/19FsrXzqGtLLw8vU4FSsYv
         AmNPB/HCDsAB6raTAtzXhGbi3XghpucqlR09Wud7V2LauH4pttuGga5laY+u7WzsK2PG
         j/j1kKJbGH52x93S+L9MLQv3enHK+Yqn4B2syo2NP449jS+hLNqHrfwKnnBTf+13maON
         1XHJOeAXXSYw8Tv6b3ev3nSsMQcmlp5Y0Z+LG05njdeGDrRikAWBomCCgvL78172pOQk
         hyM0Z6hv9o/ZhQVVkJX1VDb1gqj8QWzg6YxxMT3fGiV0NBjXYFaZp7U71cxCBO2bDUFe
         imEg==
X-Gm-Message-State: APjAAAU7clKV6U2oUIg/jWkhfaeA9ALGHyZu4G3ikO9zpMrNzoSnrcBI
        sHn9ceUK5xGAwQtM41pYwszZe6GTpS25KH/4Y7A=
X-Google-Smtp-Source: APXvYqy15wsyeIRkSnFOQeGZoWHHrPQpkNQoIHKatY4xSgX7gHUbvRLSH0of6Tp/VF9Yf/c+URN441n7EAy5ltGu/Yw=
X-Received: by 2002:a05:6000:18c:: with SMTP id p12mr21064238wrx.154.1573493346316;
 Mon, 11 Nov 2019 09:29:06 -0800 (PST)
MIME-Version: 1.0
References: <20191109194923.231655-1-colin.king@canonical.com> <633bbabf-56d4-ad4a-9d4e-9562e7122d17@amd.com>
In-Reply-To: <633bbabf-56d4-ad4a-9d4e-9562e7122d17@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 11 Nov 2019 12:28:53 -0500
Message-ID: <CADnq5_N+WdogHBKuQah92WS6ijFe8K6Ae3RxBdO5hyGMTMGsFg@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amd/display: fix spelling mistake "exeuction"
 -> "execution"
To:     "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Cc:     Colin King <colin.king@canonical.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
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

On Mon, Nov 11, 2019 at 8:37 AM Kazlauskas, Nicholas
<nicholas.kazlauskas@amd.com> wrote:
>
> On 2019-11-09 2:49 p.m., Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > There are spelling mistakes in a DC_ERROR message and a comment.
> > Fix these.
> >
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
>
> Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
>
> Thanks!
>
> Nicholas Kazlauskas
>
> > ---
> >   drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c    | 2 +-
> >   drivers/gpu/drm/amd/display/dmub/inc/dmub_srv.h | 2 +-
> >   2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
> > index 61cefe0a3790..b65b66025267 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
> > @@ -92,7 +92,7 @@ void dc_dmub_srv_cmd_execute(struct dc_dmub_srv *dc_dmub_srv)
> >
> >       status = dmub_srv_cmd_execute(dmub);
> >       if (status != DMUB_STATUS_OK)
> > -             DC_ERROR("Error starting DMUB exeuction: status=%d\n", status);
> > +             DC_ERROR("Error starting DMUB execution: status=%d\n", status);
> >   }
> >
> >   void dc_dmub_srv_wait_idle(struct dc_dmub_srv *dc_dmub_srv)
> > diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_srv.h
> > index aa8f0396616d..45e427d1952e 100644
> > --- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_srv.h
> > +++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_srv.h
> > @@ -416,7 +416,7 @@ enum dmub_status dmub_srv_cmd_queue(struct dmub_srv *dmub,
> >    * dmub_srv_cmd_execute() - Executes a queued sequence to the dmub
> >    * @dmub: the dmub service
> >    *
> > - * Begins exeuction of queued commands on the dmub.
> > + * Begins execution of queued commands on the dmub.
> >    *
> >    * Return:
> >    *   DMUB_STATUS_OK - success
> >
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
