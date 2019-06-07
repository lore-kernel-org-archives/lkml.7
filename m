Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A35C46476
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 07:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EF812089E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 07:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKOz5Ffr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbfFGHYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 03:24:40 -0400
Received: from mail-qk1-f171.google.com ([209.85.222.171]:36347 "EHLO
        mail-qk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727629AbfFGHYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 03:24:40 -0400
Received: by mail-qk1-f171.google.com with SMTP id g18so662557qkl.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 00:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=upxfiQQnJywJa1F/KiFsxdZWOGwi2RbI5YVXjOiY4iI=;
        b=mKOz5FfrHM2STpMbV4QElYph4nVwnRJVCxEm6ysQTQ7q7GyAM5l/dnj+hT5Qil4LVO
         cAU1tZlIgNsoasjiD3LfYJEgG9omser+FmBh22p4IcDF9NBMaKYDQyHQh3+/AL4vfGFh
         RWSXoCMCND0Tte5VXVA83RoypicC/KQA/2nSwGPAX/I7mjoerFPR3Pt9ocKj6hq0ryqq
         5tuYlVtZLIIpuhWF1RlaKk1OhSlWkqUjXNBV0bJza9kGgydkVQ6SKamnTqVB6QtqSzJa
         joxquyZYDbj+wrOca276vY1cOlM7ADAcoYx2IdVTlB7E53UO6T6ZWurWIAh39bk7o/Pe
         7ZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=upxfiQQnJywJa1F/KiFsxdZWOGwi2RbI5YVXjOiY4iI=;
        b=FV7b/0GKw+JQLBJVxFCf3EuK96PdrPd92nkv/ZOaDXdhbWsl6E2XonY6Q/CCTX4s7m
         sUCExZJqva6aNblO3aH+Siku6BOORM2RVhjoXDttoAco4LWRINPn8AhHxr0o53mhZqlf
         jZWXZ1qGqYNCTHstXDKczyJryTTLP7GnmR0QLHeuraoEhdp4L9lqe0ByCyEvFLBiIhKZ
         nu2HmRtjHkIgE1wOBOOdSz3u90YE94XqCuXzgQi84prerXRyybKg6OqUAbMIVC6Jtbu0
         EFj0ayM+OVl/65e3OD8PzFo4y9MUIGvxtt9KGpcOj77e9ImxRUimhkkJdUn9BBx99ZE+
         +rQg==
X-Gm-Message-State: APjAAAUZk4xapz2thS/Q/PWiw+Z5kf0FQTJlB1kCBq6TnOUtYczbNbGW
        thScwBZzOayTssAIc/72XCG6MSkbczCbl7QE/jM=
X-Google-Smtp-Source: APXvYqzXvVkJDxwxnFjgBUA6OkoDsgeKkRLbElndupZT23zuOYix0hv8pQL879VOyXDrpHllYR1kAqgZkiNzNE06JkE=
X-Received: by 2002:a37:6ac3:: with SMTP id f186mr26168126qkc.281.1559892279236;
 Fri, 07 Jun 2019 00:24:39 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 7 Jun 2019 17:24:28 +1000
Message-ID: <CAPM=9tx_2-ANvU3CsasrHkaJsyRV+NxP1AoM0ZSu8teht3FuEg@mail.gmail.com>
Subject: [git pull] drm fixes for v5.2-rc4 (v2)
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Linus,

A small bit more lively this week but not majorly so. I'm away in
Japan next week for family holiday, so I'll be pretty disconnected,
I've asked Daniel to do fixes for the week while I'm out.

I sent this out earlier, but I forgot the subject, and then Ben asked
about some nouveau firmware fixes. The nouveau firmware changes are a
bit large, but they address a big problem where a whole set of boards
don't load with the driver, and the new firmware fixes that, so I
think it's worth trying to land it now.

core:
- Allow fb changes in async commits (drivers as well)

udmabuf:
- Unmap scatterlist when unmapping udmabuf

nouveau:
- firmware loading fixes for secboot firmware on new GPU revision.

komeda:
- oops, dma mapping and warning fixes

arm-hdlcd:
- clock fixes,
- mode validation fix

i915:
- Add a missing Icelake workaround
- GVT - DMA map fault fix and enforcement fixes

amdgpu:
- DCE resume fix
- New raven variation updates

Dave.
