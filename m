Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC50CC10F14
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 18:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7A9021A4C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 18:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azaA/Cc2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbfJBSrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 14:47:25 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34989 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfJBSrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 14:47:24 -0400
Received: by mail-wm1-f68.google.com with SMTP id y21so28718wmi.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 11:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rl3HwNc1oPPqrMvALhFW3tFOkISeqhdk4UKaPBcY6s0=;
        b=azaA/Cc2WKbblHOERF1vzi7jLDwr6FIH836aAU4kxozXuaEVRWIrk2ayHEmJ6MP8iG
         7aXeTyQcvL6Gq6M2WGSQ/28uNNEuh5Sk+Wb8lDMJmtg0U19KU+TfSM06N54QFV2ytHLe
         6TT3WglYH2oMlHLNMc7jNg6rKJ1RPE2OwuMjUwULL45KaOhLj1AmJc94IldmDG/TcJjt
         pQ4D0y7Tc374OZ59vjD0p2XegEz5DAT3wo/h/xf07hKe86jRbIZWEu4h6FoQw2xYq16R
         aqpoMgBsr5nb1p67OTE9jmExlVs4fzMYAHkcKW6TThhd8akohCbf7npIwFg9mSvvsdm7
         dFWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rl3HwNc1oPPqrMvALhFW3tFOkISeqhdk4UKaPBcY6s0=;
        b=XHTd2+j/KLbIqCVdtW7CgoLlrwaVQJzCLM+GRX4Ofca2qD4Sff85Rr2D0HYoYsgnbY
         vnXGIiRVUtv93jEmI7OrYyXMXEzYYijDxujEFoF4mkS/0+Qke8BV5MjAg522pn7RiL+G
         X90JL1AEjZvYrNloL6c96nq3SCMHbrB7QYFZXIK2R2CbtibDRQVtSJdVibaalrAUY7Bb
         w7MDJmCmUg8zkwlM8b0Ce/QF/Qz6aVGYbDi8nOzP9HeHgLBzIhbDJDS8W7RglSjZ8tPb
         yL377lj25t1qU4RvXhOwyIhixxL45w4aFOr1ZGvQkVYVMN27O5YDz2NoppTOGIsmu8ID
         AXtg==
X-Gm-Message-State: APjAAAVcrLT8ANZzpq9taDHEFBaixK48MgXpYu1+VmwW6d0LSrOY9JtC
        VL+pCRZMDVhBI04In3QcHmAaQ0uL069sUfn4Jok=
X-Google-Smtp-Source: APXvYqyadvQZt/5r+wPSV1oq1Tc7kuGgYq0Qtbq3Xvtf/2EtBqF6rMDvmldFOj48UiW4aroqZt4JfknMTY9l3qmJeMM=
X-Received: by 2002:a1c:1a45:: with SMTP id a66mr3986539wma.102.1570042042540;
 Wed, 02 Oct 2019 11:47:22 -0700 (PDT)
MIME-Version: 1.0
References: <20191002120136.1777161-1-arnd@arndb.de>
In-Reply-To: <20191002120136.1777161-1-arnd@arndb.de>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 2 Oct 2019 14:47:10 -0400
Message-ID: <CADnq5_MLg=J5dmSGzx8jC=1--d2S3HJzWH3EHhyzT6da5a3wcA@mail.gmail.com>
Subject: Re: [PATCH 0/6] amdgpu build fixes
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 2, 2019 at 8:02 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Here are a couple of build fixes from my backlog in the randconfig
> tree. It would be good to get them all into linux-5.4.
>
>      Arnd
>
> Arnd Bergmann (6):
>   drm/amdgpu: make pmu support optional, again
>   drm/amdgpu: hide another #warning
>   drm/amdgpu: display_mode_vba_21: remove uint typedef
>   drm/amd/display: fix dcn21 Makefile for clang
>   [RESEND] drm/amd/display: hide an unused variable
>   [RESEND] drm/amdgpu: work around llvm bug #42576

I've applied 1-5 and I'll send them for 5.4.  There still seems to be
some debate about 6.

Thanks.

Alex

>
>  drivers/gpu/drm/amd/amdgpu/Makefile                 |  2 +-
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c              |  1 +
>  drivers/gpu/drm/amd/amdgpu/soc15.c                  |  2 --
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   |  2 ++
>  drivers/gpu/drm/amd/display/dc/dcn21/Makefile       | 12 +++++++++++-
>  .../amd/display/dc/dml/dcn21/display_mode_vba_21.c  | 13 +++++--------
>  6 files changed, 20 insertions(+), 12 deletions(-)
>
> --
> 2.20.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
