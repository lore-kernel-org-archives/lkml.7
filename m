Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5F3C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A75F2173E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfFDIe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 04:34:26 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40682 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfFDIe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 04:34:26 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 843A228527C;
        Tue,  4 Jun 2019 09:34:24 +0100 (BST)
Date:   Tue, 4 Jun 2019 10:34:22 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Helen Koike <helen.koike@collabora.com>
Cc:     dri-devel@lists.freedesktop.org, nicholas.kazlauskas@amd.com,
        andrey.grodzovsky@amd.com, daniel.vetter@ffwll.ch,
        linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Sean Paul <seanpaul@google.com>, kernel@collabora.com,
        harry.wentland@amd.com,
        =?UTF-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@google.com>,
        Sandy Huang <hjc@rock-chips.com>,
        linux-rockchip@lists.infradead.org,
        Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v4 1/5] drm/rockchip: fix fb references in async update
Message-ID: <20190604103422.63a61f46@collabora.com>
In-Reply-To: <aecadca2-f67b-5d9d-550e-f90cbca5fd3f@collabora.com>
References: <20190603165610.24614-1-helen.koike@collabora.com>
        <20190603165610.24614-2-helen.koike@collabora.com>
        <aecadca2-f67b-5d9d-550e-f90cbca5fd3f@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jun 2019 17:13:34 -0300
Helen Koike <helen.koike@collabora.com> wrote:

> On 6/3/19 1:56 PM, Helen Koike wrote:
> > In the case of async update, modifications are done in place, i.e. in the
> > current plane state, so the new_state is prepared and the new_state is
> > cleaned up (instead of the old_state, unlike what happens in a
> > normal sync update).
> > To cleanup the old_fb properly, it needs to be placed in the new_state
> > in the end of async_update, so cleanup call will unreference the old_fb
> > correctly.
> > 
> > Also, the previous code had a:
> > 
> > 	plane_state = plane->funcs->atomic_duplicate_state(plane);
> > 	...
> > 	swap(plane_state, plane->state);
> > 
> > 	if (plane->state->fb && plane->state->fb != new_state->fb) {
> > 	...
> > 	}
> > 
> > Which was wrong, as the fb were just assigned to be equal, so this if
> > statement nevers evaluates to true.
> > 
> > Another details is that the function drm_crtc_vblank_get() can only be
> > called when vop->is_enabled is true, otherwise it has no effect and
> > trows a WARN_ON().
> > 
> > Calling drm_atomic_set_fb_for_plane() (which get a referent of the new
> > fb and pus the old fb) is not required, as it is taken care by
> > drm_mode_cursor_universal() when calling
> > drm_atomic_helper_update_plane().
> > 
> > Signed-off-by: Helen Koike <helen.koike@collabora.com>  
> 
> Cc: <stable@vger.kernel.org> # v4.20+
> Fixes: 15609559a834 ("drm/rockchip: update cursors asynchronously
> through atomic.")

One comment for next time you have to add such tags after the fact:
please try to keep lines unwrapped, otherwise patchwork only gets what's
on the first line.
