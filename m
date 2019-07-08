Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF3DC606C1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 16:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4330E216F4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 16:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdAHOfp2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390822AbfGHQBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 12:01:30 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55453 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728609AbfGHQB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 12:01:29 -0400
Received: by mail-wm1-f67.google.com with SMTP id a15so37473wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 09:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DYWg9eN+m+wldCSHeIV4qzWDTAdhKCvmjMFIfFa5h/4=;
        b=NdAHOfp2BPDWDs0WtzIKNU0sBWcsos0V2dOeOXhRHiHvx/GiIpr+TSD57bmtMgPL7V
         /c0I02zdt3o9Z/zE7rkyCixZUVABFGKYKhRxhuHiwwa93comrLHjqMK64r8Y7d7MCmAY
         If3OdYujEgZI8vXmrHa81Qh2G0HtA1IXelTQniP2SMWkBYHxaFnrpL3tDkh//rcstX2s
         3sZtEXFcQK1Pf3Hew3vqnAqYEmww5iw92rsb09yrkOFYrjl1piJ4AdrKVWyF//MK6QNe
         Vylqg3seyyk6a60m5otWXefRogseTfGvKBT1QXXYaH0SEsaczg4glVe3u+i0Zqg22bfy
         HznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DYWg9eN+m+wldCSHeIV4qzWDTAdhKCvmjMFIfFa5h/4=;
        b=Ao2IRSNx1e/sBa597aTNnOuE4RkN6Z3AM6nvAGSdSwHTRv8Jh1rflpP7l0tAtTVCzR
         rJh/ubnZ9m7n+fl6qorlpGb9vml0oOcKr2Cn2dFrMrH7Zd1SwCxKM+y5KbnQtmvOSKgj
         W8VlAkGlXqHCsG5Mt7DwDOfjbu6dudnoQkoh8Q2kS+c02WAKPx7/NCsvoh6iijK/ytLs
         6ctp4z1CvOjMr9+Stogl0OCLxEs0B2VcB03gMSeMG/MxYVw/W4s8tTp63xxAcLe4uEIK
         pcJuPb40m+jO26qAVqzfDH54bC6wZSVOMyVoXni7lyivRV3N01GMI1N4ileI3WyfLov+
         aJvA==
X-Gm-Message-State: APjAAAUYW2PEcGUpTE5zd9EQjkHfJ6iZ3Xw/JQ4l5MG/tm/aKgJkMG2k
        VddBglFvXi/T+5Xqbgvzw0grxUQmcH5d+mnvRso=
X-Google-Smtp-Source: APXvYqwKMWD9C6jvF+OOCj1yu/fb/XO5ZPKTe7eCqQnlKKzJMMvTIcf1awrT4RxJhwYDe8ro3c7vV54SVyzExdTVc+0=
X-Received: by 2002:a05:600c:20d:: with SMTP id 13mr17417241wmi.141.1562601687213;
 Mon, 08 Jul 2019 09:01:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190708135329.694852-1-arnd@arndb.de>
In-Reply-To: <20190708135329.694852-1-arnd@arndb.de>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 8 Jul 2019 12:01:15 -0400
Message-ID: <CADnq5_P1MC9t5szFNF2TeDDZH6gH+nXrZsMfr785uJKBBmz8nw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: dcn20: include linux/delay.h
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Joshua Aberback <joshua.aberback@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Wenjing Liu <Wenjing.Liu@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Tony Cheng <Tony.Cheng@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 8, 2019 at 9:53 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Without this header, we get a compiler error in some configurations:
>
> .../dc/dcn20/dcn20_hwseq.c: In function 'dcn20_hwss_wait_for_blank_complete':
> .../dc/dcn20/dcn20_hwseq.c:1493:3: error: implicit declaration of function 'udelay' [-Werror=implicit-function-declaration]
>
> Note: the use of udelay itself may be problematic, as can occupy
> the CPU for 200ms in a busy-loop here.
>
> Fixes: 7ed4e6352c16 ("drm/amd/display: Add DCN2 HW Sequencer and Resource")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
> index 4b0d8b9f61da..6925d25d2457 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
> @@ -22,6 +22,7 @@
>   * Authors: AMD
>   *
>   */
> +#include <linux/delay.h>
>
>  #include "dm_services.h"
>  #include "dm_helpers.h"
> --
> 2.20.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
