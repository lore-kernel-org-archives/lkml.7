Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393C5C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B1E020C01
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGltPae4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732846AbfHFOEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 10:04:45 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46605 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728102AbfHFOEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 10:04:44 -0400
Received: by mail-wr1-f68.google.com with SMTP id z1so88037615wru.13
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 07:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VmcJWVEpEPtuq51rQa3PysAqXBTFaGDudgNwWewCnB0=;
        b=SGltPae4XNh4Q+UGWFbguwHk7b6jQ96uA1pyBjf+QImbi5hjWu6foT2yyu4Ef8S8VZ
         WVQ/5cNOi1rMbGhKWXrTeVLUKI/CtBgs7M84SRhAkqoLujGnITkbj/6saLmBHMuyXgah
         1uxOPOVV+919HPTggX95bSKrIeFfCrmDszvuFRqP8jK181DQVJjKWOOI/1hD0kXJr4lG
         +7kraMbIBnVIQ+BP31bPjafkdXRA+DVhas327iLAgmFsq8Jj+8I8K0bUnDl8w8MsCIAe
         j0ZTVdQotWW9cFsZ4JUpO8uV3/Rg9576/5I1tlswQdQN30IqIy6JATvtdpkoS8zwvtAf
         +U6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VmcJWVEpEPtuq51rQa3PysAqXBTFaGDudgNwWewCnB0=;
        b=UYlpE3k5oS3yF+thw9b+sMdeCn6L6IygzU/aqNUUN0PycLDt4+QNI6Uy27Z/0gvSRm
         lNLhq/RFYjBsnJ/AH1kdXw1chWLrivKr59yik9ngGWlVRZzGbNFOdkdQaGYHmv3Cmoc1
         jlgtLwqTHDC3IRQtIpE5dhymILc9cib5irOgQCoBPwOGf7zGQ7b0hxvAChOa79U7aAfT
         UZwY6vQtXXakQ4pCPLDRLgrELg6Zr8i50InbH18PxqvMq/zJHFewRKMPgAx2Um00oVHy
         ifHHfOhJlKQDOHULtMcqysNRszc9LOweoh3+6e2O3vmy7ptIs0w8a9AKFEsquGXwQhZI
         rDDg==
X-Gm-Message-State: APjAAAWFCVUSrd8M/JrhxWxBbf0NjEizpnIivwbEq1IXxvq3x6WGfcQD
        pZZYPTJ9EEuCJZQtNmoxeVBjkVfbI0y73a2AGlk=
X-Google-Smtp-Source: APXvYqwfnictYRbYBmrF7TNe8rBMjnPDB347HH4iMDw6RFdkqryAQ2ApRjvZ92eEZ3nb/TN2z3s0Dy+pdTvnPR/MnNQ=
X-Received: by 2002:a5d:6ccd:: with SMTP id c13mr5328135wrc.4.1565100282994;
 Tue, 06 Aug 2019 07:04:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190805173257.GA4917@hari-Inspiron-1545>
In-Reply-To: <20190805173257.GA4917@hari-Inspiron-1545>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 6 Aug 2019 10:04:31 -0400
Message-ID: <CADnq5_OL1+bJUGh44AY48DP=G=xTtdrf+kO2233qjJzudWhw_Q@mail.gmail.com>
Subject: Re: [PATCH] gpu: drm: amd: display: dc: dcn20: Remove redudant condition
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nikola Cornij <nikola.cornij@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 5, 2019 at 3:01 PM Hariprasad Kelam
<hariprasad.kelam@gmail.com> wrote:
>
> Remove redudant codition "dsc_cfg->dc_dsc_cfg.num_slices_v".
>
> fixes coverity defect 1451853
>
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c
> index e870caa..42133bd 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c
> @@ -302,7 +302,7 @@ static bool dsc_prepare_config(struct display_stream_compressor *dsc, const stru
>                     dsc_cfg->dc_dsc_cfg.linebuf_depth == 0)));
>         ASSERT(96 <= dsc_cfg->dc_dsc_cfg.bits_per_pixel && dsc_cfg->dc_dsc_cfg.bits_per_pixel <= 0x3ff); // 6.0 <= bits_per_pixel <= 63.9375
>
> -       if (!dsc_cfg->dc_dsc_cfg.num_slices_v || !dsc_cfg->dc_dsc_cfg.num_slices_v ||
> +       if (!dsc_cfg->dc_dsc_cfg.num_slices_v ||

Harry, can you or Nick check if this should be something else?  maybe
a copy paste typo.

Alex

>                 !(dsc_cfg->dc_dsc_cfg.version_minor == 1 || dsc_cfg->dc_dsc_cfg.version_minor == 2) ||
>                 !dsc_cfg->pic_width || !dsc_cfg->pic_height ||
>                 !((dsc_cfg->dc_dsc_cfg.version_minor == 1 && // v1.1 line buffer depth range:
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
