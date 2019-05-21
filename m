Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36018C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F081821743
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558452281;
	bh=UMWfqlN2YiVoKAZO91st6BVGhLPMGLbKOwMtKk9gVW0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=n5f0Wj0bGei5fjRFQVFtJA9qOikRqzbO78xrj4KFMl5nER4GdRdY3sk1n38iohwg1
	 SfqnyX78r0UeV8T6PmkpZ6uTyah0AuxZyxh6YYPBcnMoVwoNPRsixI7AHfjm7CyK36
	 hiiTh6lHoT3vzfnrAvD9sBoN8laprF21AsXFoonw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbfEUPYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 11:24:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:38444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727044AbfEUPYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 11:24:40 -0400
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F43E217D7
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 15:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558452279;
        bh=UMWfqlN2YiVoKAZO91st6BVGhLPMGLbKOwMtKk9gVW0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lkIWUKNOOqae+PNKcqlj5A7XfX+R5WtRBHLluCTEAfb09PyNhuQ/Cv83PXE5KaJq5
         lI/oLB59Z0OhiAI/Rj8Shsq/bETKDQKAKG71M50xbXDrAO9bWX30Zd+2m90x/NOfbb
         xffA37pE2DH3yAKZOsUa+sYMxAN+OTrH/gxttSk8=
Received: by mail-qt1-f174.google.com with SMTP id i26so20898360qtr.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 08:24:39 -0700 (PDT)
X-Gm-Message-State: APjAAAX2I6IMw5/kmgMhzGYxliyz8YYRto1YxwQ6f4QCucI9oF9aM/sD
        TVcQg0m2O/hM5x/hL86KL/vf/9KrzJD0eXGpmg==
X-Google-Smtp-Source: APXvYqx7ecHrwSaLHLxRfIlKwMp8vokNKf7qL+p2ez/pqvv0/4ymV0sti7tGH0UYRigUbO5fscKqTyvWWtiJIezz0a4=
X-Received: by 2002:ac8:2d48:: with SMTP id o8mr69172161qta.136.1558452278328;
 Tue, 21 May 2019 08:24:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190520092306.27633-1-steven.price@arm.com> <20190520092306.27633-3-steven.price@arm.com>
In-Reply-To: <20190520092306.27633-3-steven.price@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 21 May 2019 10:24:27 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLzefOvopTCuyBsNhJDGbFV3JdVce0x398vMaGy3-+fVw@mail.gmail.com>
Message-ID: <CAL_JsqLzefOvopTCuyBsNhJDGbFV3JdVce0x398vMaGy3-+fVw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] drm/panfrost: Use drm_gem_shmem_map_offset()
To:     Steven Price <steven.price@arm.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        David Airlie <airlied@linux.ie>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 4:23 AM Steven Price <steven.price@arm.com> wrote:
>

You forgot to update the subject. I can fixup when applying, but I'd
like an ack from Chris on patch 1.

> panfrost_ioctl_mmap_bo() contains a reimplementation of
> drm_gem_map_offset() but with a bug - it allows mapping imported objects
> (without going through the exporter). Fix this by switching to use the
> newly renamed drm_gem_map_offset() function instead which has the bonus
> of simplifying the code.
>
> CC: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> Signed-off-by: Steven Price <steven.price@arm.com>
> Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
