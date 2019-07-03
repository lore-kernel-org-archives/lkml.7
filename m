Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6319C5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 02:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93F6E206E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 02:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562121160;
	bh=n0WMYfJB3u3567TZQwG6ImcIFEDatY3bPs5dKzrXQtE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ZlFqYj9XzX7M21ggC9AOHeOsVzP9BDdlyvG+8uEa0HTzzczC8IVKw+8Eb8ifx3b6n
	 O7sA/xNe1I+/3RsqUW16rdpbX980jCjf3lClL3413N1b35XauesZRGX9i5f4Lm9Bj4
	 Zy6dF7I5fVtXBg8oCj02dmqGORXh6563Oxedowbk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbfGCCcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 22:32:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:33634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726635AbfGCCci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 22:32:38 -0400
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC63E218A4
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2019 02:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562121157;
        bh=n0WMYfJB3u3567TZQwG6ImcIFEDatY3bPs5dKzrXQtE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=koLbxnZ9er+WL86MfO2lkZ3mDKDz03bBIFrb/W0InimUL6deA2SXBBstBinlAyhvU
         MvnF81cjoo51yAnQ964/Qdnavtv5ylyrc6RsCFoyNwSBZbZ98/oZI6pVUSmo9EuMvj
         g8SMJRsSXPDjLk6cIUCINxaWG+S54p3XhdaUPz8k=
Received: by mail-qt1-f174.google.com with SMTP id h21so843075qtn.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 19:32:37 -0700 (PDT)
X-Gm-Message-State: APjAAAUMkBZDB48BvOTQhuKvsM/M0ErnnJpz3tfVf+x3hRmN0I5x0kF5
        /NTdFZ3n6V0imxcmtR9UFM2leZFPOqJd498SGA==
X-Google-Smtp-Source: APXvYqwtxZUXfS7T+po7PKuI/nGgvaDQeMzeI/78z50apmU+KaoT+C/FfFoCmrqhKsZZjJCVTjCU8e23V11UBr5gq1Q=
X-Received: by 2002:aed:3f10:: with SMTP id p16mr28374282qtf.110.1562121156892;
 Tue, 02 Jul 2019 19:32:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190627155318.38053-1-steven.price@arm.com> <20190627155318.38053-3-steven.price@arm.com>
In-Reply-To: <20190627155318.38053-3-steven.price@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 2 Jul 2019 20:32:25 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+fmjqdcQgSJ69O33BJH7AUWvb_YcbJNur+wSpd5VMNOA@mail.gmail.com>
Message-ID: <CAL_Jsq+fmjqdcQgSJ69O33BJH7AUWvb_YcbJNur+wSpd5VMNOA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] drm/panfrost: Use drm_gem_map_offset()
To:     Steven Price <steven.price@arm.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
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

On Thu, Jun 27, 2019 at 9:53 AM Steven Price <steven.price@arm.com> wrote:
>
> panfrost_ioctl_mmap_bo() contains a reimplementation of
> drm_gem_map_offset() but with a bug - it allows mapping imported
> objects (without going through the exporter). Fix this by switching to
> use the newly renamed drm_gem_map_offset() function instead which has
> the bonus of simplifying the code.

While it may have been a bug, it worked (by some definition of
worked). Now mesa breaks on importing buffers which always get
mmapped. So we need to revert this, get import mmaps to work, or drop
mmapping of imports and backport that to 19.1. I don't think there
should be any need to mmap imports.

Rob
