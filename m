Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE3CC606C7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3E3F217D6
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390728AbfGHTV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 15:21:57 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:47070 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731498AbfGHTV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 15:21:56 -0400
Received: by mail-vs1-f66.google.com with SMTP id r3so8976431vsr.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 12:21:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wuYR4ctP+Z0e4Snpj6oEKGwghzEqHesmniJR9+rfaQ0=;
        b=Ku1Vy6alZeml11f0c+7TEC4aohRoNZh9/nnrDospkRZ/DxDWvutgr5ffim+/wRo3pN
         gFooHTd9TgkFQZAyNu8332yNzLrOXGySkueupxi1m9iWh1mdCgfzTIzdSyv/xUf4NLZW
         0xSh25Yx1SLxIG7bJhxbX4pQAtK9Uk+mQLHbCo3jpaBgsxr9a1VxNcO4G7ynRMIH4PSC
         bNxHGvRoKmBZDMLgF2qUxWnNQfS4ZoOWfWzpAK6k8tj+4kKb7rL3o0fE+XF6q+09rtYw
         P5PpcrgrfKfF2JtGc/Hvc9Vru12Wr1zb+mJO/ek4Pwp4R7pJ2KBJHNx7cghDaAWmGnDL
         K4bg==
X-Gm-Message-State: APjAAAXYMZoAYOh4GI5JhXFZ0YADu7dKh13Pa+tFCuyAnvInA/38uPdz
        T+vbxMFkImZQcO/b2d1f67WqErloVz7d4fgfveE=
X-Google-Smtp-Source: APXvYqy9qC6Fb7uF9IrQ45+NaximQGRL39baY/ctKT5H2+0Utwwj/pwjDL1ih0f7URaOyS7d1hIYqXdCkPAS5SbTJZg=
X-Received: by 2002:a67:dd0d:: with SMTP id y13mr3159460vsj.210.1562613715328;
 Mon, 08 Jul 2019 12:21:55 -0700 (PDT)
MIME-Version: 1.0
References: <1562609151-7283-1-git-send-email-cai@lca.pw>
In-Reply-To: <1562609151-7283-1-git-send-email-cai@lca.pw>
From:   Ilia Mirkin <imirkin@alum.mit.edu>
Date:   Mon, 8 Jul 2019 15:21:44 -0400
Message-ID: <CAKb7UvhoW2F5LSf4B=vJhLykPCme_ixwbUBup_sBXjoQa72Fzw@mail.gmail.com>
Subject: Re: [PATCH v2] gpu/drm_memory: fix a few warnings
To:     Qian Cai <cai@lca.pw>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, joe@perches.com,
        linux-spdx@archiver.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 8, 2019 at 2:06 PM Qian Cai <cai@lca.pw> wrote:
>
> The opening comment mark "/**" is reserved for kernel-doc comments, so
> it will generate a warning with "make W=1".
>
> drivers/gpu/drm/drm_memory.c:2: warning: Cannot understand  * \file
> drm_memory.c
>
> Also, silence a checkpatch warning by adding a license identfiter where
> it indicates the MIT license further down in the source file.
>
> WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
>
> It becomes redundant to add both an SPDX identifier and have a
> description of the license in the comment block at the top, so remove
> the later.
>
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>
> v2: remove the redundant description of the license.
>
>  drivers/gpu/drm/drm_memory.c | 22 ++--------------------
>  1 file changed, 2 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_memory.c b/drivers/gpu/drm/drm_memory.c
> index 132fef8ff1b6..86a11fc8e954 100644
> --- a/drivers/gpu/drm/drm_memory.c
> +++ b/drivers/gpu/drm/drm_memory.c
> @@ -1,4 +1,5 @@
> -/**
> +// SPDX-License-Identifier: MIT
> +/*
>   * \file drm_memory.c
>   * Memory management wrappers for DRM
>   *
> @@ -12,25 +13,6 @@
>   * Copyright 1999 Precision Insight, Inc., Cedar Park, Texas.
>   * Copyright 2000 VA Linux Systems, Inc., Sunnyvale, California.
>   * All Rights Reserved.
> - *
> - * Permission is hereby granted, free of charge, to any person obtaining a
> - * copy of this software and associated documentation files (the "Software"),
> - * to deal in the Software without restriction, including without limitation
> - * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> - * and/or sell copies of the Software, and to permit persons to whom the
> - * Software is furnished to do so, subject to the following conditions:
> - *
> - * The above copyright notice and this permission notice (including the next
> - * paragraph) shall be included in all copies or substantial portions of the
> - * Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> - * VA LINUX SYSTEMS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM, DAMAGES OR

This talks about VA Linux Systems and/or its suppliers, while the MIT
licence talks about authors or copyright holders.

Are such transformations OK to just do?

  -ilia

> - * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> - * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> - * OTHER DEALINGS IN THE SOFTWARE.
>   */
>
>  #include <linux/highmem.h>
> --
> 1.8.3.1
>
