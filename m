Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CC8C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 13:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7860A21783
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 13:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEVpU1Up"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfJBNlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 09:41:35 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40466 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfJBNlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 09:41:35 -0400
Received: by mail-wr1-f67.google.com with SMTP id l3so19714892wru.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 06:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zDudtJN8svNKdK3GLnCJ/Dk7Mp6Jv88jvEndY5m6DX8=;
        b=iEVpU1UpkYCdUvTGHys/gPjNX7+WHTs0ltbAc+zJbBRPv9soYFWc3I79bl9lB3fEnk
         4Rks8z6bxtDHULcl59TcjJq1PclVanM1TCKl4W1JkOTy9Rv3GLS5wgJm9wwfpA+ZYy47
         RNYfUmua0M4CtjD+T+kNwpnMWSngXkdjgUdZBOGZkfDQeZ0t4QcqfpsVV3vdNGf/AmOW
         pL6jxRA932ketvd+VdpdE5clDkiJ+9HJx1t1WKaPeu9BCqNeVdqeqrjbcr90jE0854m0
         CFfEC47TI4AV+zWZYFgnsOofDVAMGj8gU2YIRk2aUwB0rZlaQsr8QuauqgiB8eD3bQFl
         OC8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zDudtJN8svNKdK3GLnCJ/Dk7Mp6Jv88jvEndY5m6DX8=;
        b=UvxAfEIv35ZouBNeZlWBoMm1AI9Z+q5PV0WLzVfNxDrlHfZ4gi0ncn8/cCaJN/yFDA
         zdXIQOdBfX72DwBArypMgEk9xK8/p33LYsT59uJrFyiB7r4Pb4YTSi9hP0GZVgRKWh9i
         0L1E5xvU9SnYye9+1bVOImgFcDW1Atf0vou3XOcRfxs0Z16h48qTunS1ysE8lgbnFjKb
         Hg51/tbZpvoT+ANL51ruQpd7CUOYI8p23HeB/KMEo7tDje6Gd0w1WbMKeHxrrE23Hgta
         wvj0Ok0FYOyU8h0q1BxItQ4tOnE9/f3o86p2v2/bSzQSYXlMzBbcJ63ujfWclq/ZtbMN
         hltQ==
X-Gm-Message-State: APjAAAWLDWXdK0m2flCRMI0Sfu3cG5gaAplwpgmd4AFRvXYF/ux0KH7U
        ynxtGBXmZYURUYv3j+/74Ea/gUvOK+V4CUgSWIk=
X-Google-Smtp-Source: APXvYqyTzHKnhMINri0Sgy7y05i7A68sCvl+xV41UB3nMWhoY8A6EENNu6528Ze98rtgID+3CHQIkIn5jrZTpgOcn6A=
X-Received: by 2002:adf:e9c5:: with SMTP id l5mr2803702wrn.40.1570023692609;
 Wed, 02 Oct 2019 06:41:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190930200902.inmjn264l6pxcdsq@outlook.office365.com>
In-Reply-To: <20190930200902.inmjn264l6pxcdsq@outlook.office365.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 2 Oct 2019 09:41:21 -0400
Message-ID: <CADnq5_MapuHn=yNSkYf6yUzatXps2sMJPNLJ-wUad5jqg+GuQw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Initialize variable before use
To:     "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>
Cc:     "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 4:09 PM Siqueira, Rodrigo
<Rodrigo.Siqueira@amd.com> wrote:
>
> The 'debug_data' variable gets printed in debug statements without a
> prior initialization in the function
> hubbub1_verify_allow_pstate_change_high, as reported when building with
> gcc 9.1.0:
>
> warning: =E2=80=98debug_data=E2=80=99 may be used uninitialized in this f=
unction [-Wmaybe-uninitialized]
>   290 |  printk##once(KERN_##level "[" DRM_NAME "] " fmt, ##__VA_ARGS__)
>       |  ^~~~~~
> dc/dcn10/dcn10_hubbub.c:134:15: note: =E2=80=98debug_data=E2=80=99 was de=
clared here
>   134 |  unsigned int debug_data;
>
> Note that initialize debug_data with 0, in this case, is safe because we
> have a loop in a few lines below that will initialize this variable with
> the proper value.
>
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c b/driver=
s/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c
> index a780057e2dbc..b6967a7e6c7b 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c
> @@ -133,7 +133,7 @@ bool hubbub1_verify_allow_pstate_change_high(
>         static unsigned int max_sampled_pstate_wait_us; /* data collectio=
n */
>         static bool forced_pstate_allow; /* help with revert wa */
>
> -       unsigned int debug_data;
> +       unsigned int debug_data =3D 0;
>         unsigned int i;
>
>         if (forced_pstate_allow) {
> --
> 2.23.0
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
