Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B4DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1733A20693
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yNlj6e4n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfC1Qdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:33:44 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45544 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfC1Qdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:33:44 -0400
Received: by mail-lf1-f66.google.com with SMTP id 5so14463915lft.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 09:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kaxp5yeazhHfuGWff2vbINwXt+0fwtosVq2fU6zD+6w=;
        b=yNlj6e4nQ+qAoq4H106ZWuqzXdXJLzJfkB3m/lkA6Zp6hvS+U/8UtcAsPGXsux+65G
         raOE04feExHp3go6hXrXVSX21Stghp6/JfXNfG2nuNEnx/KkCkfHy8qpibtdNAh2XXmo
         n+1j8ld1q4aLz8zKnMVIDXMlJxpYbBVgWk1Th0c/TPZET5WtkANe8xayxx39uy1kKRw/
         Ai+mp9MuB6sCLaz75QkGgFNNs27+Eh8gJFzVobxWMLAe8D9ygbdJ61phTNkUw0No/IQl
         oCTW/Mah2e+ANrLUqdxQVYGG4mcrk96RcjBxDkFZ+wprDHK+ZKpCeV0vh0CHD4XXM0Ss
         KkjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kaxp5yeazhHfuGWff2vbINwXt+0fwtosVq2fU6zD+6w=;
        b=DNYu0q9aqQJY6SfR5BZK1XXlbYwFNsZHQbHmBGRkWmavPZ24S8AquyQ3pBXh/vu0T0
         BMojPbWChwTrsCjfUdkUrREbb1boppU0044xXzSsXbHkDTBvvdPGB3t+zAoaO6EevFSv
         HC86IaC622LWrrWZozzyqxNMTaLnz8L9tq80GBZ0FnEjNy9IL4gEO47DD9+9Bpl2D7oq
         7PfCM1qM7dEh1Uws4rlZQWVd7ujxTuHBugdOwJxjL8C+/+RSYkvI1rh9RwxrNPZ2T7pd
         7tQrL2dNyAoURelkBbbcZ/Hnoh3qpDZNHXdbuezOVET6S68Fj9SLh7sVvpXmeZEqeYwq
         P90w==
X-Gm-Message-State: APjAAAUSEhq+i9KlMvvo58K31BBWpDGD36TlI28YBdoGPFvoongD36Rn
        YrzWHGtYjNWEJ/GrwC/ZYRLjnpTfnKT8Ea1bx8QjAw==
X-Google-Smtp-Source: APXvYqynGPUyJvnMjbHAReeqkT23qxbyTcVLqV1bbnte60QGGCnSKKLHBE/CShNy1LEOcpfggIfr6LdS9fnb0LSqzUU=
X-Received: by 2002:a19:5789:: with SMTP id l131mr22014998lfb.8.1553790822464;
 Thu, 28 Mar 2019 09:33:42 -0700 (PDT)
MIME-Version: 1.0
References: <1553288173-10845-1-git-send-email-arbab@linux.ibm.com> <1553288173-10845-3-git-send-email-arbab@linux.ibm.com>
In-Reply-To: <1553288173-10845-3-git-send-email-arbab@linux.ibm.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 28 Mar 2019 17:33:31 +0100
Message-ID: <CACRpkdb0i1foVhKcNiKJzrA8DYjheb8yQ1RQ3_VGniZrMiUvqQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/fb-helper: Do not scale depth down to 0
To:     Reza Arbab <arbab@linux.ibm.com>
Cc:     Dave Airlie <airlied@redhat.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Robert Tarasov <tutankhamen@chromium.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        wzabolot@elektron.elka.pw.edu.pl, Pavel Machek <pavel@ucw.cz>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 9:56 PM Reza Arbab <arbab@linux.ibm.com> wrote:

> If the scaling loop in drm_fb_helper_single_fb_probe() only finds
> supported depths greater than what it's looking for, it will set
> sizes.surface_depth = 0. This broke my udl device:
>
> [drm] test CRTC 0 primary plane
> udl 3-9.1:1.0: drm_fb_helper_single_fb_probe: test CRTC 0 format 0, depth=24
> udl 3-9.1:1.0: drm_fb_helper_single_fb_probe: 24 > 16, skipping
> udl 3-9.1:1.0: drm_fb_helper_single_fb_probe: test CRTC 0 format 1, depth=32
> udl 3-9.1:1.0: drm_fb_helper_single_fb_probe: 32 > 16, skipping
> [drm] requested bpp 16, scaled depth down to 0
>
> Instead of setting zero depth, print that scaling was not possible and
> do nothing.
>
> Fixes: f4bd542bcaee ("drm/fb-helper: Scale back depth to supported maximum")
> Signed-off-by: Reza Arbab <arbab@linux.ibm.com>

This makes perfect sense, but Dave Airlie already sent a similar
patch some two weeks ago, I wonder what happened with it?
Subject "avoid setting 0 depth".

Yours,
Linus Walleij
