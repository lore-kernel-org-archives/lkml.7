Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31BFC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 22:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B351B206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 22:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZXuhxfC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfKKWju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 17:39:50 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50324 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbfKKWju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 17:39:50 -0500
Received: by mail-wm1-f67.google.com with SMTP id l17so1041714wmh.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 14:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kLZzRK49xDavb9wz9Sf4AjD14pe2l4fvkbkWyRvqJ9M=;
        b=VZXuhxfCsYqJHeAAZWi8U4wsj49O2BkOkmkDNoQod5eOhXrb0FI6MPWtiONK3lEHIC
         g6EgrDgHM4QqZWIG1URCW42d7CaCrN/dTtkea5oO3HRXepParhfR+8mTgj+SUhB5SlsD
         cpUat5dlYyBH/Nn5g/Jhc22m++/wA4M0LInFkqytUm3CoUi0Yxcsy45ybiRGJWBRMI2t
         y60LN80clF+fH2hFqNLvnYKd2jd6Iwf86ZmKY+VHhQj8GS5qU6SlVR+0qDEyggoLishn
         4N2jfW8fYOulcywjy1p69/IHUErRea8Vc3YugI4Qi0mE6fktdQjMW3MYugVNHmzgmM+M
         JVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kLZzRK49xDavb9wz9Sf4AjD14pe2l4fvkbkWyRvqJ9M=;
        b=BXCHVVfRD1mpfo6Q2bU+Ktn5w9DaKuYwrCA/GLDJJZftHPdxUr/t/fU8Z1jpFDu3/9
         Ce0kIl2qFXG5y3HF1gNMjMgil7r3+BIwQnKTo2qzh1yH/Pf13FAnUcdG7puWL+XS40en
         UqzrqAnMF342Fhz2eFhnE2I53IeqsJ9cwBGR5hE/15L/VSs0D2FuSnV/2ffcMxKpqZ4n
         I28FNCLWS88gLctMdp2rwJzFOUtrIbwi/ekQYJNmLUrwFtzT5IZgSfSZgsX+nOdkPT2j
         qwAatEj4mSXA0x+RQzwAi60ts+jLUhcitrk/5P6jbLsads+rJxGx6KeEbHhsXpfIGg4e
         fcpg==
X-Gm-Message-State: APjAAAUbn43wOneo6FRGrcd+xF5GcZM/n6sk8/KyuOIypG7mf9MqY/b8
        /QhGWCJ4tQ/hqCAbOL9D1KKGq5vt6BPSbllKrh4=
X-Google-Smtp-Source: APXvYqz+tmuJK+8UMO293AmQSmsTISo+DNCWj9/FOQWAl3qhe7Xq8Jc6y5Cy2acisbs754yH/eX41FMkrx0gHYnlKHc=
X-Received: by 2002:a1c:41c2:: with SMTP id o185mr1037425wma.34.1573511988047;
 Mon, 11 Nov 2019 14:39:48 -0800 (PST)
MIME-Version: 1.0
References: <20191111172543.GA31748@embeddedor> <b5b41653-3536-b0f0-2f49-2c010370ec99@amd.com>
 <cf7d4cfe-be29-39d8-8a5e-bac217475597@embeddedor.com>
In-Reply-To: <cf7d4cfe-be29-39d8-8a5e-bac217475597@embeddedor.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 11 Nov 2019 17:39:34 -0500
Message-ID: <CADnq5_NmfCaQ=6to+ng81=qV0mp7Vo-ugKPTF__5JMAmjP13Kw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix unsigned variable compared to less
 than zero
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Mikita Lipski <mlipski@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mikita Lipski <mikita.lipski@amd.com>,
        Lyude Paul <lyude@redhat.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Mon, Nov 11, 2019 at 2:44 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
>
>
> On 11/11/19 11:46, Mikita Lipski wrote:
> >
> > Thanks for catching it!
> >
>
> Glad to help out. :)
>
> > Reviewed-by: Mikita Lipski <mikita.lipski@amd.com>
> >
>
> Thanks
> --
> Gustavo
>
> >
> > On 11.11.2019 12:25, Gustavo A. R. Silva wrote:
> >> Currenly, the error check below on variable*vcpi_slots*  is always
> >> false because it is a uint64_t type variable, hence, the values
> >> this variable can hold are never less than zero:
> >>
> >> drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:
> >> 4870         if (dm_new_connector_state->vcpi_slots < 0) {
> >> 4871                 DRM_DEBUG_ATOMIC("failed finding vcpi slots: %d\n", (int)dm_new_connector_stat     e->vcpi_slots);
> >> 4872                 return dm_new_connector_state->vcpi_slots;
> >> 4873         }
> >>
> >> Fix this by making*vcpi_slots*  of int type
> >>
> >> Addresses-Coverity: 1487838 ("Unsigned compared against 0")
> >> Fixes: b4c578f08378 ("drm/amd/display: Add MST atomic routines")
> >> Signed-off-by: Gustavo A. R. Silva<gustavo@embeddedor.com>
> >> ---
> >>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> >> index 6db07e9e33ab..a8fc90a927d6 100644
> >> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> >> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> >> @@ -403,7 +403,7 @@ struct dm_connector_state {
> >>       bool underscan_enable;
> >>       bool freesync_capable;
> >>       uint8_t abm_level;
> >> -    uint64_t vcpi_slots;
> >> +    int vcpi_slots;
> >>       uint64_t pbn;
> >>   };
> >>   -- 2.23.0
> >
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
