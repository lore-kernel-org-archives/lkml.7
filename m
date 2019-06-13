Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB157C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90AE220665
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLu12g1w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404241AbfFMQyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:54:40 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45895 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730046AbfFMCfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 22:35:40 -0400
Received: by mail-wr1-f68.google.com with SMTP id f9so18920446wre.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 19:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=we9sh7P+rBLFyIttjf4foHa+0vXHWpg6iX0TxKiCCM8=;
        b=kLu12g1wHuVKOsOjxGBZ6/v3jo91LVLr+nrtgEydtGzmDqbPSqolPf6gsyNNXDJP8U
         IeA3G4WvSI4xUbrcoEg/uTcEICs2FfMb0D1D3yJJ195lPHSnj9e2xz/BE8BDc4kCZzu/
         aEcpmbU+bxqwql9FEoOkIXyNRNWC5+vBGLrZN3ygNDwi9QZ+QMc++vne4eyBsbI8fnyA
         hmS3OW6BF0M4fGV71nnepzFLpYg3q4ZkCZWU9xtiMkIApLVr+d08Sntld0D8YPEgras1
         xZbiwmgO6gj+UnDuXrajSADkJWRPpo7Yt2juXW91b1Htt6NiB72sm2oZRnUIUNuIRMbn
         AoPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=we9sh7P+rBLFyIttjf4foHa+0vXHWpg6iX0TxKiCCM8=;
        b=j01Pr/m4SGy+pzNzY7kYjyJD6xc4CBzPK9yo2r8WU7AiMeiKca2PvpztC4lqO5ZJjW
         fnKnRMWJO18u8/0ycZ69h4OUVj7sdc2hZTZrvERUYeyaoJVHkFV/tYlR4pyCsGNGMwos
         iwrT8rIlOu/0OcVktrnw/42CTkiHxLCKN4Te8cYbsikpwDPAHQwvlH3JJ7bdV1tLV6dB
         w0biaaA43t91Jlt+Q7WvkMbZ6lnPwrnHu4yN5C7mUWEL3ajNAeWzzYMz3ob0LBF+4z1o
         OuQCTI4Y6FjcOsVvfSVePKLn+tKfRck7fl6nulqLLe8B+Rsn+NWFTKhwEZZDFkVaGpAW
         Glmw==
X-Gm-Message-State: APjAAAXpn9bJsW3Ax0JfvXDIKg0P+QMwA3ah/00p/Cw5Ea65OlIxMRQF
        QbvVZ6VMoJte5KuXhChXImVjHQAarHrwdz9+9vY=
X-Google-Smtp-Source: APXvYqyOqcdP9Kv4ZKhMjHXfzyr/AAP5oi+GWxEfBRGeT4Z6j06FZuVkW7kC+wTYqDB2JxxCglMYK31I0LVL4sFV3gA=
X-Received: by 2002:adf:f041:: with SMTP id t1mr12583636wro.74.1560393338674;
 Wed, 12 Jun 2019 19:35:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190613023208.GA29690@hari-Inspiron-1545>
In-Reply-To: <20190613023208.GA29690@hari-Inspiron-1545>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 12 Jun 2019 22:35:26 -0400
Message-ID: <CADnq5_PU_jvOskC-=+oRQdvYXZvu_n26ogoWTxLRxnW+ke4wDw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix compilation error
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Tony Cheng <tony.cheng@amd.com>,
        Anthony Koo <Anthony.Koo@amd.com>,
        Charlene Liu <charlene.liu@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Yongqiang Sun <yongqiang.sun@amd.com>,
        Gloria Li <geling.li@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 10:34 PM Hariprasad Kelam
<hariprasad.kelam@gmail.com> wrote:
>
> this patch fixes below compilation error
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c: In
> function =E2=80=98dcn10_apply_ctx_for_surface=E2=80=99:
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:2378:=
3:
> error: implicit declaration of function =E2=80=98udelay=E2=80=99
> [-Werror=3Dimplicit-function-declaration]
>    udelay(underflow_check_delay_us);
>
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>

What branch is this patch based on?

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/=
drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> index d2352949..1ac9a4f 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> @@ -23,6 +23,7 @@
>   *
>   */
>
> +#include <linux/delay.h>
>  #include "dm_services.h"
>  #include "core_types.h"
>  #include "resource.h"
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
