Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C27C5B57D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 04:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A12C021852
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 04:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4l+hfbL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfGEE7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 00:59:40 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51]:43914 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfGEE7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 00:59:40 -0400
Received: by mail-lf1-f51.google.com with SMTP id j29so5433363lfk.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 21:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=kKf/+SrtXuZZ9BhooOYGoS/tkob02qSoqQSjmjgeu98=;
        b=S4l+hfbLeIpJ1ZZMHN15qYhVl2CqwkBojbe8Rz6FlDiVrFffTH0bI4GbaXyoZe6qF5
         7LMXRc/ucfLr4+DUB0wEwkneL6N6fYfXnOpsyhZJJD4TsBpouYM5yv1rvc9Gfuw5Db3I
         hiv9kyR92w1p85rl+Cledmw8hsWp4CpArSFEq73iPn2k1rbec0SpXRueVNUXAq1aAfti
         BwLn58S4OSfgtFxIj78BXEiHyn4sv31BOZ2cTKYQtUSDQuDSMLvuhiP7p+4ZYI1M5DTi
         ZLz/EnF+USEG2WrISmzP58cRrYLMLf5feP55vsOrA9pickknTm30rSB5fFk8ym+nNlQo
         SVhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=kKf/+SrtXuZZ9BhooOYGoS/tkob02qSoqQSjmjgeu98=;
        b=k+vOoRnEzsiH3GiQ5Tais1mrOok8F7JDF8bMtopJ61zmX6QxGedyCfzJzExKpAlBJj
         Gp8zxirBtAhTTKtgrMoUC7G1gP+ZGHh21Ii1bskg0A4aX8E5WqKRetwMOBOnov+jlQu3
         fRa1Haz70pAPrSuOLnXxU1ZNQ+Pj8EO9a5h95e66x8cgww2+l7nrdX3CC9udnKWkLl6a
         6gDbcnZGhbfFuIxsnsxWXc7+5cqprXZYeODOFdep4JSvRb6fuAXr7OZFA57Do1xld4RM
         4Ul7/gbLwxZ4/tFupL0EqZDYXSGYyWCOg+pvm9vIy8ReR9ZHSN05+75drfI7gkv9tLwj
         xaMQ==
X-Gm-Message-State: APjAAAW8PbnzXnfvEORgD2FP4TFfFY8d167TiL55LxGa6DOhqK99HWVf
        pLatZGnp4sUDVQJR5cXblIz2TbJHvkuITt1qagQ0e8Ze
X-Google-Smtp-Source: APXvYqz5fiFXI3zWEe/3cZzmAteuJXHL2m75Do/6/UKk1uV6im/nizlmjnViJ9yPEO+wH43YmDcev+Ou3p3SIaDL04E=
X-Received: by 2002:a19:a87:: with SMTP id 129mr920952lfk.98.1562302777990;
 Thu, 04 Jul 2019 21:59:37 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 5 Jul 2019 14:59:26 +1000
Message-ID: <CAPM=9tz2nw3eu-5HXdA9iaMck34pOL=ZZimrVBStK9WUYKsNAQ@mail.gmail.com>
Subject: [git pull] drm fixes for 5.2 final
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I skipped last week because there wasn't much worth doing, this week
got a few more fixes in.

amdgpu:
- default register value change
- runpm regression fix
- fan control fix

i915:
- fix Ironlake regression

panfrost:
- fix a double free

virtio:
- fix a locking bug

imx:
- crtc disable fixes.

Thanks,
Dave.

drm-fixes-2019-07-05-1:
drm imx, i915, amdgpu, panfrost, virtio, etnaviv fixes
The following changes since commit 4b972a01a7da614b4796475f933094751a295a2f:

  Linux 5.2-rc6 (2019-06-22 16:01:36 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-07-05-1

for you to fetch changes up to a0b2cf792ac9db7bb73e599e516adfb9dca8e60b:

  Merge tag 'imx-drm-fixes-2019-07-04' of
git://git.pengutronix.de/git/pza/linux into drm-fixes (2019-07-05
14:51:03 +1000)

----------------------------------------------------------------
drm imx, i915, amdgpu, panfrost, virtio, etnaviv fixes

----------------------------------------------------------------
Alex Deucher (1):
      drm/amdgpu/gfx9: use reset default for PA_SC_FIFO_SIZE

Boris Brezillon (1):
      drm/panfrost: Fix a double-free error

Chris Wilson (1):
      drm/i915/ringbuffer: EMIT_INVALIDATE *before* switch context

Dave Airlie (5):
      Merge tag 'drm-misc-fixes-2019-06-26' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-fixes-5.2-2019-07-02' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes
      Merge tag 'drm-misc-fixes-2019-07-03' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge branch 'etnaviv/fixes' of
https://git.pengutronix.de/git/lst/linux into drm-fixes
      Merge tag 'imx-drm-fixes-2019-07-04' of
git://git.pengutronix.de/git/pza/linux into drm-fixes

Evan Quan (1):
      drm/amd/powerplay: use hardware fan control if no powerplay fan table

Gerd Hoffmann (1):
      drm/virtio: move drm_connector_update_edid_property() call

Lucas Stach (1):
      drm/etnaviv: add missing failure path to destroy suballoc

Lyude Paul (1):
      drm/amdgpu: Don't skip display settings in hwmgr_resume()

Robert Beckett (2):
      drm/imx: notify drm core before sending event during crtc disable
      drm/imx: only send event on crtc disable if kept disabled

 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c                 | 19 -------------------
 drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c           |  2 +-
 .../drm/amd/powerplay/hwmgr/process_pptables_v1_0.c   |  4 +++-
 drivers/gpu/drm/amd/powerplay/inc/hwmgr.h             |  1 +
 .../gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c   |  4 ++++
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c                 |  7 +++++--
 drivers/gpu/drm/i915/intel_ringbuffer.c               |  6 +++---
 drivers/gpu/drm/imx/ipuv3-crtc.c                      |  6 +++---
 drivers/gpu/drm/panfrost/panfrost_drv.c               |  2 +-
 drivers/gpu/drm/virtio/virtgpu_vq.c                   |  2 +-
 10 files changed, 22 insertions(+), 31 deletions(-)
