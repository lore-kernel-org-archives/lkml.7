Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA11C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 19:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51AA42087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 19:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552420235;
	bh=hs9bRLXqReSzhTXr9kqhNrGpKPdKfboNJT2q2BM/Yuo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ybLJMx+n4d0J70QMMzUlgtWc3pMxcrl6ixZZW6tWqkwKzN2Es1neC8HGsjdUrac9Q
	 m1v17Tw/WizzUgNLsN1Agep3JkwyK3KDd33HK4QjjXUVu68LWcwZDnCLzlybDWEbm8
	 /g1serUfFiWLCuj1zDD+SK89ZRYBQBwEWJ4kxQbA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfCLTud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 15:50:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:44788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726372AbfCLTud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 15:50:33 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 441AE214D8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 19:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552420232;
        bh=hs9bRLXqReSzhTXr9kqhNrGpKPdKfboNJT2q2BM/Yuo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=K+DjJu8Qv2NoxQDlen2szRqLORAmrfoaGikOdgrlj3t2Sdtu9v9bMsvFQvOnO7DGF
         lKUSgnM9yJu0Wc225sA+OoF2cbWdpLiW5BV3WdceoiEEe86S4YznQfV2xqGzVYxl/9
         tXYky15fLpGHVG6asAY9ml99QQVxGOFC0T6eQcJA=
Received: by mail-qt1-f172.google.com with SMTP id b3so4063958qtj.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 12:50:32 -0700 (PDT)
X-Gm-Message-State: APjAAAWG9QH7Oon7VM/tdJbazTyN4R+LxOKZnkzMLttg8TNoKlK1zuNX
        zTzAQfHI6XMYDuyojv3zf8spgQ14Bj8Y7goxsQ==
X-Google-Smtp-Source: APXvYqyvzMsr0xmCT2mXivHVRGUENsPFd8aekDlxBi2bvM8jIDWYVJYNN6SRLsh9AYdxvCYtzlR8+Rb9nRlCanQZXY0=
X-Received: by 2002:a0c:ecc5:: with SMTP id o5mr32042626qvq.106.1552420231482;
 Tue, 12 Mar 2019 12:50:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190308161716.2466-1-eric@anholt.net> <20190308161716.2466-2-eric@anholt.net>
 <CAL_JsqL-16kyPiWSC=pEC+JLeeJaDBJahnXqOW3Wni5CJcACsQ@mail.gmail.com> <8736nsm1tm.fsf@anholt.net>
In-Reply-To: <8736nsm1tm.fsf@anholt.net>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 12 Mar 2019 14:50:20 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+rV+yR1xUrpXmGsXuPCwZ2w_D69p-u5L9E0e3mJi7zaQ@mail.gmail.com>
Message-ID: <CAL_Jsq+rV+yR1xUrpXmGsXuPCwZ2w_D69p-u5L9E0e3mJi7zaQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm: Add helpers for locking an array of BO reservations.
To:     Eric Anholt <eric@anholt.net>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        david.emett@broadcom.com, thomas.spurden@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 12:37 PM Eric Anholt <eric@anholt.net> wrote:
>
> Rob Herring <robh@kernel.org> writes:
>
> > On Fri, Mar 8, 2019 at 10:17 AM Eric Anholt <eric@anholt.net> wrote:
> >>
> >> Now that we have the reservation object in the GEM object, it's easy
> >> to provide a helper for this common case.  Noticed while reviewing
> >> panfrost and lima drivers.  This particular version came out of v3d,
> >> which in turn was a copy from vc4.
> >>
> >> Signed-off-by: Eric Anholt <eric@anholt.net>
> >> ---
> >>  drivers/gpu/drm/drm_gem.c | 76 +++++++++++++++++++++++++++++++++++++++
> >>  include/drm/drm_gem.h     |  4 +++
> >>  2 files changed, 80 insertions(+)
> >
> > Sweet! I was about to go write this same patch. You are changing the
> > license from GPL to MIT copying the v3d version, but I guess you have
> > rights to do that.
> >
> > FWIW,
> >
> > Acked-by: Rob Herring <robh@kernel.org>
>
> Was this just for this one patch, or the series?  I don't think I can
> merge without a consumer.

Sure, it can be for patches 1-3. Patch 4 is dependent on me sending
out the shmem helpers again.

Rob
