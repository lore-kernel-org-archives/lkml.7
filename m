Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66622CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 08:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43E282067B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 08:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfJUIsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 04:48:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47724 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726819AbfJUIsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 04:48:41 -0400
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 86E70335DC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 08:48:41 +0000 (UTC)
Received: by mail-qt1-f198.google.com with SMTP id f15so13390802qth.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 01:48:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IRqmfLWgWgklrhuIT0YEqcb3zcO5An3swDX6Xn5ZmWQ=;
        b=oNceSHtfmKFKKHgLTqbis6rnRXC6gPvNA3U84zQU8mSqqn2HtHw+9zLYIIK2a+nm2n
         MJSoR5+/bIMhcLmnmCzLzayVpmT+qvUSu9oRdrqPkN2ZNdNjcqLSRm5ARDnU8cwLZ/AE
         47+W4sss7SNOchL4pqZNqSNnxMjVS532Q1ICEt1RvEQpb5JAzpNoUWtbC7Y29Dk7T8VP
         prij8XclIsz/3dUkA8XTI65cWmg58mc63zSvjmWPFWygqcgODOviiSK0cKU7ldfYUc/A
         Ye9UQnfBErDbByUYDQGqc7MmchCCu53LQX1/NlBqXnPIPBFMzCx83teYWtT19hDhkhAG
         OM3w==
X-Gm-Message-State: APjAAAWSQDgHdutmAmO01mtGLLAo6lG3k7HlkbgXiEZ2fP0J4RNnRA1f
        98ShOr7y7q3w0ga0ZgrfbHnX72tWU06cyNU8e+Ji0MiRsBaRwp1q48OjVJt/VJB6xr6qSOX5kYO
        4K+OPZRgnQ+2k6MQm+NMcQpHfij162qcevcSjEb3q
X-Received: by 2002:a05:620a:718:: with SMTP id 24mr21040852qkc.157.1571647720596;
        Mon, 21 Oct 2019 01:48:40 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyMSJL3T6FDafLXsYkKHSRUn9ds4wEGZrqyrQwy1ZdVD37ycdGAVZNZ8hFxO2cMo4t/PkEIVrqxmsVkDYGB08g=
X-Received: by 2002:a05:620a:718:: with SMTP id 24mr21040840qkc.157.1571647720291;
 Mon, 21 Oct 2019 01:48:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190814213118.28473-1-kherbst@redhat.com> <2215840.qs0dBhReda@kreacher>
 <CACO55ttC-o9bKU7nHNcfjm2YnffiupQ7UHUt7BYL3fu+yEyTbw@mail.gmail.com>
 <5228680.jBuKzensJx@kreacher> <CAJ=jquZLU2=yxayGCs=XGghxdMMre6qAWRY0Q4VErjBGqeWdjQ@mail.gmail.com>
 <CAJZ5v0hogSM3OgfJ0GFn7+BYwxR05Hb5ZMLo=NiB2wmpu=qeug@mail.gmail.com>
In-Reply-To: <CAJZ5v0hogSM3OgfJ0GFn7+BYwxR05Hb5ZMLo=NiB2wmpu=qeug@mail.gmail.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Mon, 21 Oct 2019 10:48:29 +0200
Message-ID: <CACO55tvAyE1t2Bm8J=Yb_Gi5PDAgof=mRsJAKHFxOvEZpV-qGg@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH 1/7] Revert "ACPI / OSI: Add OEM _OSI string to
 enable dGPU direct output"
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Alex Hung <alex.hung@canonical.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dave Airlie <airlied@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Dave Airlie <airlied@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fyi: I decided to go for a different workaround to fix the runpm
issues observed with nvidia gpus with nouveau in the "pci: prevent
putting nvidia GPUs into lower device states on certain intel bridges"
thread

that's on the pci and pm mailing list. Maybe it makes sense to wait
for that to land before actually removing the ACPI workarounds here?
The workaround I had in this series didn't seem to be reliable enough,
so I ditched that approached.

On Mon, Oct 21, 2019 at 10:14 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Oct 21, 2019 at 4:14 AM Alex Hung <alex.hung@canonical.com> wrote:
> >
> > We have done some tests on three of Intel + nVidia configuration
> > systems with OEM _OSI strings removed - while some bugs are still
> > observed, ex. one out of three has suspend/resume issues, no system
> > crashes were observed - the biggest issue that worries us.
> >
> > The positive results give us confident to ack the removal of the OEM
> > _OSI strings. While our tests were not able to cover all possible I+N
> > systems, we are sure we can fix issues along the way. If there aren't
> > systems that cannot be fixed without these OEM _OSI strings, these
> > strings should probably enable with DMI quirks (possible future
> > patches) so they won't affect others.
> >
> > Acked-by: Alex Hung <alex.hung@canonical.com>
>
> OK, thanks!
>
> I can queue this up or if it's better to route it through the DRM
> tree, please do that (and let me know).
