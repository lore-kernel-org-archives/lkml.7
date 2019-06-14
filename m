Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC77C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8DA8208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbfFNMLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 08:11:42 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35025 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbfFNMLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 08:11:42 -0400
Received: by mail-ot1-f67.google.com with SMTP id j19so2431420otq.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 05:11:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wo132hdWCXIwgcpI+BIESFxrDjp3/snXhazBuY1tTH4=;
        b=DtSYyCiRg3C/aIh7Srq40+7/8aNzk3RVs4We7w3NMIo8V6rM5rizq3gsy/JE3g+QQy
         HEXYXjTElqzZZNpH+yZl7ON3VsHcRy/NTze1k8DSx8YXVIPYBltmmBtFZ9r5a3iioUaM
         vYsAp6rwjAKGHFaiNQa7F7lTbghWyeNXHyU4I8sAswsW/RepcLrnIPuIuwrz1MtiuKrj
         ABOiFjxNZV8bMxuCKNuJpemouNB+MTNkto+JbOSpP79nkpdfnhJjYr3fDFB9OyJK7wbX
         muUONOcTxu6tnVv0JQqi5O5yaSzrHeCdvvUPsHyYt2MrelZ1rZvc0pztBTciAMprZIOq
         /fow==
X-Gm-Message-State: APjAAAWLkvXDr13X9X/ClAvnmOtzzNPjKQJskTlxAnf62IwnU+Y8AuVw
        XEMCV0AaB4ARfW1xZHU0Nnk/UvF6TOWhC5sE8d0=
X-Google-Smtp-Source: APXvYqxAfLD66F7IClYkztopo8Tbd60ou3yrpfc0M8vDEfmErWhwSsEtxFcJg20RM+/aBedSdH0UTvhaCMxDy3Xea4c=
X-Received: by 2002:a05:6830:12c7:: with SMTP id a7mr1325643otq.284.1560514301184;
 Fri, 14 Jun 2019 05:11:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190114202652.15204-1-malat@debian.org> <20190117204047.1262-1-malat@debian.org>
In-Reply-To: <20190117204047.1262-1-malat@debian.org>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Fri, 14 Jun 2019 14:11:27 +0200
Message-ID: <CA+7wUswrBF6k0xv8tPzJbZHj0s0O+KfFBdToyX8UjHwDxQGMhw@mail.gmail.com>
Subject: Re: [PATCH v2] drm: radeon: add a missing break in evergreen_cs_handle_reg
To:     Alex Deucher <alexander.deucher@amd.com>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 9:40 PM Mathieu Malaterre <malat@debian.org> wrote:
>
> In commit dd220a00e8bd ("drm/radeon/kms: add support for streamout v7")
> case statements were added without a terminating break statement. This
> commit adds the missing break. This was discovered during a compilation
> with W=1.
>
> This commit removes the following warning:
>
>   drivers/gpu/drm/radeon/evergreen_cs.c:1301:11: warning: this statement may fall through [-Wimplicit-fallthrough=]
>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Fixes: dd220a00e8bd ("drm/radeon/kms: add support for streamout v7")
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
> v2: Add missing break statement, instead of marking it as fall through

Replaced by:

cc5034a5d293 drm/radeon/evergreen_cs: fix missing break in switch statement

>  drivers/gpu/drm/radeon/evergreen_cs.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/radeon/evergreen_cs.c b/drivers/gpu/drm/radeon/evergreen_cs.c
> index f471537c852f..1e14c6921454 100644
> --- a/drivers/gpu/drm/radeon/evergreen_cs.c
> +++ b/drivers/gpu/drm/radeon/evergreen_cs.c
> @@ -1299,6 +1299,7 @@ static int evergreen_cs_handle_reg(struct radeon_cs_parser *p, u32 reg, u32 idx)
>                         return -EINVAL;
>                 }
>                 ib[idx] += (u32)((reloc->gpu_offset >> 8) & 0xffffffff);
> +               break;
>         case CB_TARGET_MASK:
>                 track->cb_target_mask = radeon_get_ib_value(p, idx);
>                 track->cb_dirty = true;
> --
> 2.19.2
>
