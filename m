Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A80CA9EC7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 23:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69308217D9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 23:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=vanguardiasur-com-ar.20150623.gappssmtp.com header.i=@vanguardiasur-com-ar.20150623.gappssmtp.com header.b="MHuXqE7o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfKBXJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 19:09:55 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:43820 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbfKBXJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 19:09:55 -0400
Received: by mail-vs1-f66.google.com with SMTP id b16so2541198vso.10
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2019 16:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8eOjimCXAMVT0g+dVB3v4ZC+luS1RZJawQJvhl1t+Ek=;
        b=MHuXqE7o5cqkl6VxmJtHSJsU4FakufGmfDpiMSNAGerCiLDyBOKLSdG+v2cMRv+KhT
         41o7ecOxklXcU1p5dlihH7KrPCdQlAnNBh6RgfuqkYCa59WvD54I7jWEgtAYzgVQPeE1
         YAyuvJ8niSIqGXt3WMtyOip0Oix4JNdY/aDPEvrcP3iq1FA5kdZTZT3xrV9npRhK83IT
         EYWLO1ioFTrUvr0wK+laIQQmkjLX/9R1GY9QnmfH2Zn7YP4x/8GSmh3agY1fe5bFHjwM
         cynHL4GW1CyWTA3tBEpwU8g3X0PLGQgJxNGqdwfe3gExYvrRBPlh1stILp8vh0O4UCFi
         KL8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8eOjimCXAMVT0g+dVB3v4ZC+luS1RZJawQJvhl1t+Ek=;
        b=InMPcUoK0ZtsE/AYWvLKef6+b16+mky9f9DMN2p0h8+Xtn5HHvEDiZu+HE0cAzKlmO
         8nEUqW6zc0SATwVl2CMRHbF3B/u6+evr/H0cXLCNNEpwODke34+P1dFqxx3FRKeOlNeX
         bggc7Om4zPH5tMZlfsNND1PJ5fP3G8QcabR5fIgf8CKRLxjSuEJtGS4kY3SoSFWTNkkY
         GWB/fs49YBPNRyPMBC0UTpuoH+jvryvrkvcHIna5BKkKGjdSq1fAmSZn0LvEInPCxfud
         S6N+J6EOAdHrfWQk4Al+dsyAXRBzrxnLGsL70vxA9nh1DDSFliLnAOTCDrf2/Sd9Ojes
         MdWA==
X-Gm-Message-State: APjAAAUZiIyA72xOqORGnJxcFCDXxhXbg1eH1j2nLR9UyW8LSi3jMCQ5
        D8RSBIqwstaD7AluG47cyh4FVyh86qS2/8VDxZmscg==
X-Google-Smtp-Source: APXvYqwIKAmXBjKlfcpj4wpfj8gl/gweJdHLuSLoH5/i0/TFEUqSHyMJeiarfrsQeQ+b5DbVOp4sYPo7Z2BA8XU2wq0=
X-Received: by 2002:a05:6102:531:: with SMTP id m17mr9432988vsa.105.1572736193990;
 Sat, 02 Nov 2019 16:09:53 -0700 (PDT)
MIME-Version: 1.0
References: <HE1PR06MB401108289F09802C261374F8AC610@HE1PR06MB4011.eurprd06.prod.outlook.com>
 <20191029012430.24566-1-jonas@kwiboo.se> <HE1PR06MB40116FEF3EBE4706E426A5FFAC610@HE1PR06MB4011.eurprd06.prod.outlook.com>
In-Reply-To: <HE1PR06MB40116FEF3EBE4706E426A5FFAC610@HE1PR06MB4011.eurprd06.prod.outlook.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Sun, 3 Nov 2019 00:09:42 +0100
Message-ID: <CAAEAJfCjUe=V8Sqj2Yqy-Su7iE=ptFDz40vg92bYqUS8XrE73w@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] media: hantro: Fix motion vectors usage condition
To:     Jonas Karlman <jonas@kwiboo.se>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Francois Buergisser <fbuergisser@chromium.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Oct 2019 at 02:25, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> From: Francois Buergisser <fbuergisser@chromium.org>
>
> The setting of the motion vectors usage and the setting of motion
> vectors address are currently done under different conditions.
>
> When decoding pre-recorded videos, this results of leaving the motion
> vectors address unset, resulting in faulty memory accesses. Fix it
> by using the same condition everywhere, which matches the profiles
> that support motion vectors.
>
> Fixes: dea0a82f3d22 ("media: hantro: Add support for H264 decoding on G1")
> Signed-off-by: Francois Buergisser <fbuergisser@chromium.org>
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  drivers/staging/media/hantro/hantro_g1_h264_dec.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/media/hantro/hantro_g1_h264_dec.c b/drivers/staging/media/hantro/hantro_g1_h264_dec.c
> index 29130946dea4..a1cb18680200 100644
> --- a/drivers/staging/media/hantro/hantro_g1_h264_dec.c
> +++ b/drivers/staging/media/hantro/hantro_g1_h264_dec.c
> @@ -35,7 +35,7 @@ static void set_params(struct hantro_ctx *ctx)
>         if (sps->flags & V4L2_H264_SPS_FLAG_MB_ADAPTIVE_FRAME_FIELD)
>                 reg |= G1_REG_DEC_CTRL0_SEQ_MBAFF_E;
>         reg |= G1_REG_DEC_CTRL0_PICORD_COUNT_E;
> -       if (dec_param->nal_ref_idc)
> +       if (sps->profile_idc > 66 && dec_param->nal_ref_idc)
>                 reg |= G1_REG_DEC_CTRL0_WRITE_MVS_E;
>
>         if (!(sps->flags & V4L2_H264_SPS_FLAG_FRAME_MBS_ONLY) &&
> @@ -245,7 +245,7 @@ static void set_buffers(struct hantro_ctx *ctx)
>         vdpu_write_relaxed(vpu, dst_dma, G1_REG_ADDR_DST);
>
>         /* Higher profiles require DMV buffer appended to reference frames. */
> -       if (ctrls->sps->profile_idc > 66) {
> +       if (ctrls->sps->profile_idc > 66 && ctrls->decode->nal_ref_idc) {

How about a one-line function (purposely not a macro,
to have type-checking) ? I think this should emphasize the fact that
the condition
needs to be the same.

Thanks,
Ezequiel

>                 size_t pic_size = ctx->h264_dec.pic_size;
>                 size_t mv_offset = round_up(pic_size, 8);
>
> --
> 2.17.1
>
