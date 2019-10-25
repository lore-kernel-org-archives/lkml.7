Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686C5CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 19:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3952321D82
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 19:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5H+fdyP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfJYTdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 15:33:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34556 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfJYTdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 15:33:03 -0400
Received: by mail-wr1-f67.google.com with SMTP id t16so3635202wrr.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 12:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uj3oNCbFUUZSg5SH9RcrKbOYwaJ+AMwyoVWq4ZKhw90=;
        b=K5H+fdyPluzKTE2fCyVVhR5WeN36L/uxO6n26MyMEw4EOTRng/4EWSJIsg0msXuwT9
         mnnz5ptJvlXfKj96Gb4XbDUBuAnq1gZNbU2cVsl24SmNuhZA9NEkkIK8yPWFcH9vILpV
         8shfJNID/vovLSsRmuNK03xRjZFmh/Rcs47OOlVQphRQCVXwv72SxyN2j4HbLD5kLzSo
         KtRcYoMbf5kZvNXLLJ0LpyMI4P3OhslEbCEdkpetTizJ3qDUeDoT++4V3q5BS7s73chq
         qkkskcT3cpcy5yTB/gqPFMToWX+FDW6EEQuqPLKZiaVHvJFw1Wy3zrUryemOEULbC8AU
         P2cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uj3oNCbFUUZSg5SH9RcrKbOYwaJ+AMwyoVWq4ZKhw90=;
        b=hFTDm6cqc2Jh0S+LyWNqpuFWqykmn9lbJMFfVb1j5pdlIw0pGp/2pvZarS4GU7DLTR
         /e+yKsqxoDSJ7o4jNQckRVOpI+UyMRbaebzVBlk9g8afb7MMlfopX+mkFnzRzWJxu/AW
         cXOTnvNpb7fvcViPSOFKzHJpxKUVr87bpyOuxoL5KlUBZ3vHxv22YEkR81DuHibaWLlP
         P3KoAcIDNjHPf39cgPZkjtfHi8MzYI+Bqw4YGLcRKAmxy8akjpoqUvY2al2tBJgwOUtD
         XVCq+AFc9YfOmdQnkE3X3xJtYpmpOOrGQ6SUzJeXRYM6MdIy4ZO4rPTkdtFt5qYivsiQ
         q78Q==
X-Gm-Message-State: APjAAAXwyMT8ZjWmIqySs9082L49SMjhCfZ/UMY6JJPs62NK3Bb59nru
        vnLO1toZEtNHhXq+zRNSbLbAFZYVl1imV+RFvyw=
X-Google-Smtp-Source: APXvYqyUNFhWEMvoMA8/aBmDOC8snwwEw3OnSJeXlmzAFKk6Aos8tJHIcV249WkqXX7cImJTsrdmhR2RpqHP0fc68gs=
X-Received: by 2002:adf:ed02:: with SMTP id a2mr4395705wro.11.1572031981013;
 Fri, 25 Oct 2019 12:33:01 -0700 (PDT)
MIME-Version: 1.0
References: <1571819543-15676-1-git-send-email-zhong.shiqi@zte.com.cn> <fa46cad1-8845-78b7-eb6a-45942813020b@amd.com>
In-Reply-To: <fa46cad1-8845-78b7-eb6a-45942813020b@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 25 Oct 2019 15:32:48 -0400
Message-ID: <CADnq5_Nv9j5vDX5-Jkhy3TTiej7FcKBBOC8QQk59NQ=SsO-3pg@mail.gmail.com>
Subject: Re: [PATCH] dc.c:use kzalloc without test
To:     Harry Wentland <hwentlan@amd.com>
Cc:     zhongshiqi <zhong.shiqi@zte.com.cn>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Lei, Jun" <Jun.Lei@amd.com>, "Koo, Anthony" <Anthony.Koo@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        "David.Francis@amd.com" <David.Francis@amd.com>,
        "Liu, Wenjing" <Wenjing.Liu@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "cheng.shengyu@zte.com.cn" <cheng.shengyu@zte.com.cn>,
        "wang.yi59@zte.com.cn" <wang.yi59@zte.com.cn>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Aidan.Wood@amd.com" <Aidan.Wood@amd.com>,
        "xue.zhihong@zte.com.cn" <xue.zhihong@zte.com.cn>,
        "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>,
        "Park, Chris" <Chris.Park@amd.com>,
        "Yang, Eric" <Eric.Yang2@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Laktyushkin, Dmytro" <Dmytro.Laktyushkin@amd.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  thanks!

Alex

On Wed, Oct 23, 2019 at 9:35 AM Harry Wentland <hwentlan@amd.com> wrote:
>
> On 2019-10-23 4:32 a.m., zhongshiqi wrote:
> > dc.c:583:null check is needed after using kzalloc function
> >
> > Signed-off-by: zhongshiqi <zhong.shiqi@zte.com.cn>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> > ---
> >  drivers/gpu/drm/amd/display/dc/core/dc.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> > index 5d1aded..4b8819c 100644
> > --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> > +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> > @@ -580,6 +580,10 @@ static bool construct(struct dc *dc,
> >  #ifdef CONFIG_DRM_AMD_DC_DCN2_0
> >       // Allocate memory for the vm_helper
> >       dc->vm_helper = kzalloc(sizeof(struct vm_helper), GFP_KERNEL);
> > +     if (!dc->vm_helper) {
> > +             dm_error("%s: failed to create dc->vm_helper\n", __func__);
> > +             goto fail;
> > +     }
> >
> >  #endif
> >       memcpy(&dc->bb_overrides, &init_params->bb_overrides, sizeof(dc->bb_overrides));
> >
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
