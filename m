Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCB0C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 19:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2735216F4
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 19:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HisDqRQ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732313AbfGVTp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 15:45:56 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38813 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729117AbfGVTp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 15:45:56 -0400
Received: by mail-wr1-f66.google.com with SMTP id g17so40656594wrr.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 12:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mfiBWJ6PUSyYeyNIn03p58I6uVjr4C4bhbLtUD/MF24=;
        b=HisDqRQ8k1WjU/x3HIxhOIEQ/GgP8RpDhBgwIc4s8Oe6o93ovR6m9/9CLIV+1e0QdW
         siJ13CO2R7iog19lIb0a1mRoaN/UAPIO477hxU4ldqAs5Ps8VZB1B15vfBVkuh4kchiI
         C2gfGJOLhK92tpsMa3qQT5cFTScaFZmSe5xTQCC7XXjwuGLQ8joydRhcGcm/rvl6GcjK
         5XLDlsW2uwaX5A2MO1y5Mn+1NqD4cNqW+lWP4weAR3yGAPCb1bxqdKoL+mHUwjP33rad
         XlEfN0KhVzezqCnwNTpyLTprCSWx6zZu0et0/K2oMSzEZTQOiSXkEWzw5Oc/KUGBxJ4B
         6vYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mfiBWJ6PUSyYeyNIn03p58I6uVjr4C4bhbLtUD/MF24=;
        b=ls0yL03rcp3a+LRZSVqtUJ94SYiInb7w0SOEmI87rGqD5Tly2hZsntF+HQgI4tOr8i
         CGsg05OQhOHR4t+iMzBLU8hkSOdpTNnNqGTy2j+7+BUeShBu3fUgRWtq/OMk/fmlOv4k
         fJdZsnLT0TcVJoAff4XDHvWJ+46bmNztmY+nnAElDuDuvHxNvdHaE+1XlLNXsu7x/bSv
         gxEzpkHAxP6rTH8vLWGL+ZbmoyRudHFWw7eANV0gq9faFLsRosIkNtK5R5Yfn9auoLrc
         LgO4238v6EFedf92NYYQz/F8lrrkSkej4Qtk6ShPsXi9B23qj7ihHGv691ajQuut9UHs
         Ng6g==
X-Gm-Message-State: APjAAAWi8RprdrbMiOrgoODW7I+NrutoFbbFvLJt2fFS1A6rOi/B51nk
        OlthG9ABlrl2MiravdLPns0scxtX0r9Fo0IGxdE=
X-Google-Smtp-Source: APXvYqwp8BppJPcCRhriZEJumGwE1sekMMaeeLUrBRhupTfg+HZOHh6ga8vSkcu3/oGVZmLUWryumMuE+gfVQhm+pCc=
X-Received: by 2002:adf:f94a:: with SMTP id q10mr53387147wrr.341.1563824754148;
 Mon, 22 Jul 2019 12:45:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190721214935.GA910@embeddedor> <CADnq5_OTmx==m+1fJbf1PxPhPM0H0O8GRjq4eWeX6sw889YPrA@mail.gmail.com>
 <181c1bc9-4cf9-057f-a6e6-e6d62ddbc347@embeddedor.com>
In-Reply-To: <181c1bc9-4cf9-057f-a6e6-e6d62ddbc347@embeddedor.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 22 Jul 2019 15:45:42 -0400
Message-ID: <CADnq5_NRDy1jpa2MGefo7KbUB2vejuLwpnJh=vsqyp56yY31Sg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Fix missing break in switch statement
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Philip Cox <Philip.Cox@amd.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kees Cook <keescook@chromium.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 3:19 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
>
>
> On 7/22/19 2:10 PM, Alex Deucher wrote:
> > On Sun, Jul 21, 2019 at 6:12 PM Gustavo A. R. Silva
> > <gustavo@embeddedor.com> wrote:
> >>
> >> Add missing break statement in order to prevent the code from falling
> >> through to case CHIP_NAVI10.
> >>
> >> This bug was found thanks to the ongoing efforts to enable
> >> -Wimplicit-fallthrough.
> >>
> >> Fixes: 14328aa58ce5 ("drm/amdkfd: Add navi10 support to amdkfd. (v3)")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> >
> > Applied.  Thanks!
> >
>
> By the way, Alex, I'm planning to add these fixes to my tree. I want
> to send a pull-request to Linus for v5.3-rc2 this afternoon. We want
> to have the -Wimplicit-fallthrough option globally enabled in v5.3,
> and these are some of the last fall-through warnings remaining in
> the kernel.
>
> Can I have your Ack or Signed-off-by for all these drm patches?

I didn't realize you were sending these yourself. I was going to
include them in my upcoming -fixes pull.  Feel free to add my RB to
all three.

Alex
