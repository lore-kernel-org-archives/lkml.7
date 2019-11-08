Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715CDC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4860F21D7F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/7Q83+Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfKHQdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 11:33:31 -0500
Received: from mail-wm1-f48.google.com ([209.85.128.48]:52816 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfKHQda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 11:33:30 -0500
Received: by mail-wm1-f48.google.com with SMTP id c17so6813961wmk.2;
        Fri, 08 Nov 2019 08:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d12YzuQ4OOUJW5jPNwfT02SFHHJndjYuWq6ftUtWsrs=;
        b=h/7Q83+Y+UWeONi2+mS2jpHkFnqQbs0EGaw6F+I5lOb1idZNWlNQJcHE8VRqK+919v
         MJtnB2E5oqbrnqJseQ5n9vZCCaUb49lpaDtPF69tYDZHijCkW6Dd9PF/mEgCW/qop6oN
         nEnmBsv25XYLCW90WcfFX2H8QGXcPEcbMG/PeyiBvCpV1DGKagiOruvQ9Q6RvgEV9M7j
         EN8bHyLricAhahgyrOV/h6q4byTLh5jzYO8H7k55Di9zdlmE8EQNyFettwfOXZfHFm69
         iDJpqa7iv1utUeG562OARQrbJLwRWcjOoblSjv1EE68R3Cbz2cA6pUdvo49sAIyY0FOs
         IS1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d12YzuQ4OOUJW5jPNwfT02SFHHJndjYuWq6ftUtWsrs=;
        b=SPSWlj50OmbVAVUZKJNcCrbL/8x/l6FLINzXItBL9QH8O/QE/s11VcgSmYoLgaRxLX
         iD3hB2bue1jVuX5nnkrs8BDT8aQ5Y2oCsDXquhmoi4WEHGj9W83uwmwLGAOUXlwQweLo
         j6lCSSshmakKnLpbpIsrmDy86cH3InEwDfaCqR2svyCm524rXEaV5W/5eNvpduxRfwFS
         YxYSRKHuZ1s5gGHj7bOqxDcMsp/cOqV4NLmON8jjU/DUT1KxIOXSzHPpboYkzLVPXx5F
         Xo+2anAn9Z8D4+UaFEgbp73KY1mxp4cxR0PaWvL6MKcJPpBEUH+GVxBJxYu2vXaA/Nk/
         Dang==
X-Gm-Message-State: APjAAAXG0xlNR6+tpAEbPJWxr8e5nMkRzr553zUZNaCF7knZhykp9bDw
        I7U5VaK2Gf21uxrRUl+bxAkL71zTA5fhyp3Do1Y=
X-Google-Smtp-Source: APXvYqwDzBxaGdrNz3PUj2ft/eTIeajp+L0S1d7eD+nlwoY1n6dyrDrLCFcmllMwSL/eFK2mKhAx8g+ub81oS65uLUQ=
X-Received: by 2002:a7b:c408:: with SMTP id k8mr9513409wmi.67.1573230808946;
 Fri, 08 Nov 2019 08:33:28 -0800 (PST)
MIME-Version: 1.0
References: <20191108143814.118856-1-colin.king@canonical.com> <7155ecfc-1aff-002d-9cc6-e097525e7cb6@amd.com>
In-Reply-To: <7155ecfc-1aff-002d-9cc6-e097525e7cb6@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 8 Nov 2019 11:33:16 -0500
Message-ID: <CADnq5_OgwugkJAkHvcdMsKGvdL_jYxS5g8L-697cWQwh-Wy-mg@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amd/display: fix dereference of pointer
 aconnector when it is null
To:     Mikita Lipski <mlipski@amd.com>
Cc:     Colin King <colin.king@canonical.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Lyude Paul <lyude@redhat.com>,
        "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>,
        "Lipski, Mikita" <Mikita.Lipski@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  thanks!

Alex

On Fri, Nov 8, 2019 at 9:42 AM Mikita Lipski <mlipski@amd.com> wrote:
>
> Thanks!
>
> Reviewed-by: Mikita Lipski <mikita.lipski@amd.com>
>
> On 08.11.2019 9:38, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > Currently pointer aconnector is being dereferenced by the call to
> > to_dm_connector_state before it is being null checked, this could
> > lead to a null pointer dereference.  Fix this by checking that
> > aconnector is null before dereferencing it.
> >
> > Addresses-Coverity: ("Dereference before null check")
> > Fixes: 5133c6241d9c ("drm/amd/display: Add MST atomic routines")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 5 ++---
> >   1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> > index e3cda6984d28..72e677796a48 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> > @@ -193,12 +193,11 @@ bool dm_helpers_dp_mst_write_payload_allocation_table(
> >        * that blocks before commit guaranteeing that the state
> >        * is not gonna be swapped while still in use in commit tail */
> >
> > -     dm_conn_state = to_dm_connector_state(aconnector->base.state);
> > -
> > -
> >       if (!aconnector || !aconnector->mst_port)
> >               return false;
> >
> > +     dm_conn_state = to_dm_connector_state(aconnector->base.state);
> > +
> >       mst_mgr = &aconnector->mst_port->mst_mgr;
> >
> >       if (!mst_mgr->mst_state)
> >
>
> --
> Thanks,
> Mikita Lipski
> mikita.lipski@amd.com
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
