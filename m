Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5140C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7ADC2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfDLNuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 09:50:05 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34852 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbfDLNuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 09:50:04 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id EA2202813B7;
        Fri, 12 Apr 2019 14:50:00 +0100 (BST)
Date:   Fri, 12 Apr 2019 15:49:57 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Helen Koike <helen.koike@collabora.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        dnicoara@chromium.org, daniels@collabora.com,
        alexandros.frantzis@collabora.com, daniel.vetter@ffwll.ch,
        linux-kernel@vger.kernel.org, tomasz Figa <tfiga@chromium.org>,
        tina.zhang@intel.com, Sean Paul <seanpaul@google.com>,
        kernel@collabora.com, nicholas.kazlauskas@amd.com,
        =?UTF-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@google.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Sean Paul <sean@poorly.run>, Sandy Huang <hjc@rock-chips.com>,
        linux-doc@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Harry Wentland <harry.wentland@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Anthony Koo <Anthony.Koo@amd.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        linux-rockchip@lists.infradead.org,
        Ville =?UTF-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Rob Clark <robdclark@gmail.com>,
        Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>,
        Eric Anholt <eric@anholt.net>, Leo Li <sunpeng.li@amd.com>,
        linux-arm-msm@vger.kernel.org,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        linux-arm-kernel@lists.infradead.org,
        David Francis <David.Francis@amd.com>,
        Mikita Lipski <mikita.lipski@amd.com>,
        amd-gfx@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        freedreno@lists.freedesktop.org,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v3 2/4] drm/atomic: rename async_{update,check} to
 amend_{update,check}
Message-ID: <20190412154957.558e49f8@collabora.com>
In-Reply-To: <20190412125827.5877-3-helen.koike@collabora.com>
References: <20190412125827.5877-1-helen.koike@collabora.com>
        <20190412125827.5877-3-helen.koike@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Helen,

On Fri, 12 Apr 2019 09:58:25 -0300
Helen Koike <helen.koike@collabora.com> wrote:

> Asynchronous update is the ability change the hw state at any time, not
> only during vblank.
> 
> Amend mode is the ability to perform 1000 commits to be applied as soon
> as possible without waiting for 1000 vblanks.
> 
> async updates can be seen as amend, but the opposite is not true.
> 
> &drm_plane_helper_funcs.atomic_async_{update,check}() was being used by
> drivers to implement amend and not async. So rename them to amend.
> 
> Also improve docs explaining the difference.
> 
> If asynchronous is required, normal page flip can be performed using
> DRM_MODE_PAGE_FLIP_ASYNC flag.
> 
> Signed-off-by: Helen Koike <helen.koike@collabora.com>
> 
> ---
> Hello,
> 
> I would like to officially clarify what async update means by adding it
> in the docs.
> Please correct me if I am wrong, but the current async_{update,check}
> callbacks are being used to do amend (the legacy cursor behavior), i.e.
> to allow 1000 updates without waiting for 1000 vblanks.

Right now, the semantic of async update is driver dependent. Some
drivers will amend the last commit touching that plane (amend semantic),
others will update the plane buffer immediately which might cause
tearing (async semantic).

> 
> So I would like to clarify this in the docs and rename the current
> callbacks to reflect this behaviour.

I'm all for this clarification, but I don't think renaming the async
hooks is a good idea, since some drivers will not do real 'amend'. So,
you're changing the name, but it's still confusing :-).

How about adding new hooks (and/or flags) for the AMEND case, and
keeping the async path untouched. We can then let drivers that
currently implement async as amend implement the amend hooks instead.
Once you've done that, you can hook that up to the legacy cursor update
path so that it first tries one then the other and finally falls back
to a sync update if none of ASYNC/AMEND is possible.

> 
> I also see that for real async updates, the flag
> DRM_MODE_PAGE_FLIP_ASYNC can be used in a normal sync update (it is
> already being used by some drivers actually, in the atomic path, not only
> in the legacy page flip, at least is what I understood from
> amdgpu_dm_atomic_commit_tail() implementation).

Yes, right now, async does not necessarily imply non-block, but
Daniel seemed to think that most users want non-block when they do an
async page flip, so maybe it should be clarified too.

Regards,

Boris
