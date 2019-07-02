Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA763C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 10:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC97205ED
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 10:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="djXttW3Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfGBKAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 06:00:18 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46898 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbfGBKAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 06:00:17 -0400
Received: by mail-lf1-f68.google.com with SMTP id z15so10908130lfh.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 03:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0O2BVHsC6tn3BWMM9tvDjclVi0pfMs+XMpk03vAtRUs=;
        b=djXttW3QsZCQThfo7EDXycRWAFHyJQWfUcHO03mRTi6kje0WmEuHV3wwBOOfEnckRL
         NjQHvBwh6JgDXk8hNGlThESzIlicMO+9PVq3rgvyk3ZYPmeiDAwIn6ov8hPwvt/icPOV
         Jv5cglAhxV7EELHVk8ajfH2S8qCZ2bon61UUj5qHa1Oz9F5rJw9FNIG8nm8J1z3OGB1H
         qkl7WAEHzqqA5F1dkx4IENY3ROET/fJDIPlxPAaqmwizjsMFFWXQg1HKV73k/tJX0KU2
         esTWkqP5XGb/SzyaCBP3CyN5WbK91HgONmx4M5o5QxU43Q3qbDZ1ep7igKMi2QePBY3s
         nuZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0O2BVHsC6tn3BWMM9tvDjclVi0pfMs+XMpk03vAtRUs=;
        b=XGcnY0LH3dkmNgNhKX+mXi3BjYOGdQrtLCUHxS3lT1txxWnvMiVPwGhOaTcDabIWIl
         PoVCeFlrLIVsFR3an7OMO4OWXABFJRr0zrmHdyQbGcxxAtX5Fe1JdQ68aDw1XSH7Oit1
         G5YZ7C8AF9bTejObHIfIF0NzuTka+l2NeQmjZU1/X8e83beQLTaspodak2zLc24R/RGJ
         YzxU4b6+2MylqdUlvBvxiUvFtT+GFeHzqgxaD/krzbeJylcixdsPq/AasZWF7MoCLB/Q
         z8C0EuxfZc+RcgeiPpLfHAaGPbxLF/et98+o8JPVxTLSJZobCwJodaVl1dRfPygq5PsP
         dMGA==
X-Gm-Message-State: APjAAAWlgSxaVuyYxE6Xds3LS5+ah/8kYpsVVNNTB3IESOHIKa8/mY8e
        IanoHk7/XYmMztS1Yhjr0GQwjgounPnzIQqR7CGZTPcs
X-Google-Smtp-Source: APXvYqx683ucGtF7PnNTH6RhXPkD+qozULKGYRzSTJRixORBYdPb5/FigraQCtcj6iD6TGV0KToFdnCtny1YRhqiz30=
X-Received: by 2002:a19:c7ca:: with SMTP id x193mr208648lff.151.1562061615619;
 Tue, 02 Jul 2019 03:00:15 -0700 (PDT)
MIME-Version: 1.0
References: <1561996022-28829-1-git-send-email-vincent.guittot@linaro.org> <7111f9d1-62f2-504c-a7ba-958b1c659cc8@arm.com>
In-Reply-To: <7111f9d1-62f2-504c-a7ba-958b1c659cc8@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 2 Jul 2019 12:00:04 +0200
Message-ID: <CAKfTPtBGDZ5P91hwGdHADYpcbOPeniDLE7x3-U9dXDvFVMAi1w@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: fix imbalance due to CPU affinity
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jul 2019 at 11:34, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 01/07/2019 16:47, Vincent Guittot wrote:
> > The load_balance() has a dedicated mecanism to detect when an imbalance
> > is due to CPU affinity and must be handled at parent level. In this case,
> > the imbalance field of the parent's sched_group is set.
> >
> > The description of sg_imbalanced() gives a typical example of two groups
> > of 4 CPUs each and 4 tasks each with a cpumask covering 1 CPU of the first
> > group and 3 CPUs of the second group. Something like:
> >
> >       { 0 1 2 3 } { 4 5 6 7 }
> >               *     * * *
> >
> > But the load_balance fails to fix this UC on my octo cores system
> > made of 2 clusters of quad cores.
> >
> > Whereas the load_balance is able to detect that the imbalanced is due to
> > CPU affinity, it fails to fix it because the imbalance field is cleared
> > before letting parent level a chance to run. In fact, when the imbalance is
> > detected, the load_balance reruns without the CPU with pinned tasks. But
> > there is no other running tasks in the situation described above and
> > everything looks balanced this time so the imbalance field is immediately
> > cleared.
> >
> > The imbalance field should not be cleared if there is no other task to move
> > when the imbalance is detected.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>
> Does that want a
>
> Cc: stable@vger.kernel.org
> Fixes: afdeee0510db ("sched: Fix imbalance flag reset")

I was not sure that this has been introduced by this patch or
following changes. I haven't been able to test it on such old kernel
with my platform

>
> ?
>
