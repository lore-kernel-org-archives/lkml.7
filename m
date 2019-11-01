Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCC8CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 19:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99390217D9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 19:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LWzaFQtV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbfKAToS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 15:44:18 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:32900 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbfKAToR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 15:44:17 -0400
Received: by mail-io1-f68.google.com with SMTP id n17so12131882ioa.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 12:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=axzshPELM7/h/f56rh7I6+q9RKvy3Fkbh152ongAIZo=;
        b=LWzaFQtV8lpRJL4zRxgdrqJXFvoWyXicqfLJbq4fqq9D4a5jegOQkkt6TItBaijwyF
         UiSLZdvb4KbyvXkIug/VziNjxWrWpxIfOe1cq+3vyMhbfZwv5tRFafD7MKI1RQ/dZGCR
         h6K9PPGKZwLD955fa25U/L1m2f7Kf1k1h3pUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=axzshPELM7/h/f56rh7I6+q9RKvy3Fkbh152ongAIZo=;
        b=FFLbkaENujIlnN4bUyJfDKVFa7vapvB3b/5/ScNjSNIoPFCxvqIhOw6mC88rLvhTVb
         rN3npmyp8TT04VkbOrQ/2Lrif/NmVLiduWKmoiSYnNpZAoAblzHBA87lfs8zAfesBi0G
         yanTXJSPIdYkkYVJN4nAnpml23dVY0uQVgKUcD606b/EnI6eBXKjzYOcRvr6vLMx/KF4
         QGIbHRJo7sSXZYDDn9pYUUAE6c5Iggf8j+Nbj2hZRhEcXzHCLKztXDt1yFOJEzM2Th2Q
         m1sVWe+6fO38Ui1AFCRaSbhnQb7nPdSWSgv/aCHdheCwh2u+wKxeAK3vDQ9AZV+rkFmI
         fBcQ==
X-Gm-Message-State: APjAAAXf7XCESqxpzBHvXg4zuQgcJX/UJtC2sX0NiRrPWlCaFPiXjKsL
        iL7iYe5rA1iOsLZugPD+VitdPWUrA8G4nDFe91CrIw==
X-Google-Smtp-Source: APXvYqwn8/+qOnCQ0SanGF+GlIb02HFEC57QcBSoEAxDl2XuN/Lo8hASlLzc7oaZ3XOazsRShxybaTd0EtPsyM+YbY0=
X-Received: by 2002:a5d:9053:: with SMTP id v19mr11719168ioq.244.1572637455610;
 Fri, 01 Nov 2019 12:44:15 -0700 (PDT)
MIME-Version: 1.0
References: <20191101180713.5470-1-robdclark@gmail.com> <20191101180713.5470-2-robdclark@gmail.com>
 <ec3c1d7b-231a-862f-ce12-8ac4c9616ca5@linux.intel.com>
In-Reply-To: <ec3c1d7b-231a-862f-ce12-8ac4c9616ca5@linux.intel.com>
From:   Rob Clark <robdclark@chromium.org>
Date:   Fri, 1 Nov 2019 12:44:04 -0700
Message-ID: <CAJs_Fx6ErP9ap=veqJSrN-coKm_VV78wxqYLj_QF+-Gutk5AZA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/atomic: clear new_state pointers at hw_done
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc:     Rob Clark <robdclark@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sean Paul <seanpaul@chromium.org>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 1, 2019 at 11:33 AM Maarten Lankhorst
<maarten.lankhorst@linux.intel.com> wrote:
>
> Op 01-11-2019 om 19:07 schreef Rob Clark:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > The new state should not be accessed after this point.  Clear the
> > pointers to make that explicit.
> >
> > This makes the error corrected in the previous patch more obvious.
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
>
> Would be nice if you could cc intel-gfx@lists.freedesktop.org next time, so I know our CI infrastructure is happy;
>
> It wouldn't surprise me if it catches 1 or 2 abuses in i915.
>
> Otherwise Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>
> Perhaps you could mail this to version to intel-gfx-trybot@lists.freedesktop.org using git-send-email so we at least get i915 results?

ok, I sent both patches to trybot, hopefully it tries them together,
as this patch without the self-refresh fix will definitely fall over

BR,
-R
