Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3827C3A5A2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 22:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BD2E21744
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 22:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHYHBGLM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393807AbfHVWIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 18:08:31 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39611 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393796AbfHVWI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 18:08:29 -0400
Received: by mail-wr1-f66.google.com with SMTP id t16so6807928wra.6;
        Thu, 22 Aug 2019 15:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dem7TnAwfqo5ysrzcm87CJHrNC80Qsa6DjP3QIVxJys=;
        b=XHYHBGLM/FkMa0//M/KVwjYyU9A+TYQ3NW+3LUV+5gZ+XdfH0Z2f9eCk4aqFl9bYk6
         FhN1tjqa0G0jTI8K6nPjNrRtQwk6mFruS6eWE0WoPfn9aegLsCdFXm28jknOTVsbo92x
         5nsgqDvPF/rpQZacdqbJ6T9JGXrNAzKtk0O6UF5gnK/hgByqPDVCD0o/R3It9yI11EKW
         7q6iZf14fHIia7Y/MvPvBZFgR65fAYyqBFmLdIwh0Ah0Y+pwMvccin+BnXrIj9Fu1UpT
         g5GxyOzBJqUkD4X4ktqF7GKFi2tYlNZz/JA8z/6cID2vY8pLFt+WZr0yUxxC+swFE6eP
         /JGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dem7TnAwfqo5ysrzcm87CJHrNC80Qsa6DjP3QIVxJys=;
        b=bsvj+WDafuI1jqeAm3ZSn3wtRq2NZEZ+jt6+KKSrgKpwvNM+toWZMLxT8SFlqA7Jxc
         Zpax72B7Z0bPoVWBez6k25PCU1xfK2Fmb07R9I3jTUdWZrxR9aNbdGTuPEC+b/BqkAfY
         2zqdidarZicWkzZTAkxL9bOkRM5jRRGWWNJ0uMnuWeWQHSAdVxEZUkfpiYA/hhalg9B1
         x4EHhuljQbj0+rX7g0pGGvF10+iZtQhzfXXUkg2sKtmpMmaBW0O1xzR3jEyClFnLa3BX
         ZmZYOrKsLKQWMS9JQoNDtGUvwozHHX0kgNsgw2+8YQL+SFbJBzBEd5R/5vNc6sIAYqvU
         Euyw==
X-Gm-Message-State: APjAAAXR28+Z5TcrnR9zd3T4N279TUmmOBs7XuD496rgjKoYIGl/U6Nf
        LoRFaguUtgKHaNLq1KtG6FDP0y988v134PeTtH4TqMq1nmg=
X-Google-Smtp-Source: APXvYqw8/Dhgei/EZmELsdhrZcdwh6G4cL775tii9Vb1sm5woLMXFQgtuZbGYeI2PCeAFrvuJMcKvMje/Qv9HYhbC9U=
X-Received: by 2002:a5d:4ecb:: with SMTP id s11mr1027310wrv.323.1566511707385;
 Thu, 22 Aug 2019 15:08:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190823080604.5164f8c4@canb.auug.org.au>
In-Reply-To: <20190823080604.5164f8c4@canb.auug.org.au>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 22 Aug 2019 18:08:15 -0400
Message-ID: <CADnq5_NNdsZ-UWuPQX=4o7c6Tq2mmo8de=fUGfR4gemhyNohMA@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the drm-fixes tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kevin Wang <kevin1.wang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 6:06 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the drm-fixes tree, today's linux-next build (KCONFIG_NAME)
> produced this warning:
>
> drivers/gpu/drm/amd/amdgpu/../powerplay/smu_v11_0.c: In function 'smu_v11_0_setup_pptable':
> drivers/gpu/drm/amd/amdgpu/../powerplay/smu_v11_0.c:368:40: warning: 'size' may be used uninitialized in this function [-Wmaybe-uninitialized]
>    smu->smu_table.power_play_table_size = size;
>    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
>
> Introduced by commit
>
>   00430144ff73 ("drm/amd/powerplay: fix variable type errors in smu_v11_0_setup_pptable")
>
> Looks like a false positive.

Silenced here:
https://patchwork.freedesktop.org/patch/325728/

Alex

>
> --
> Cheers,
> Stephen Rothwell
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
