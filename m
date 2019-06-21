Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C254DC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 04:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92187206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 04:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXDw4OQ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbfFUEVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 00:21:07 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:37605 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfFUEVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 00:21:07 -0400
Received: by mail-lj1-f170.google.com with SMTP id 131so4721849ljf.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 21:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=3hLICzMUqwSU+OuwUK2lvcj8snry9XL6jJKc3niheNE=;
        b=KXDw4OQ8tZ6i7Z7qB6RH9z7Elino7fMcSrDl6q2EYTg+21NAIKx4IsOdhp6ChFj+vB
         VBZlnQTccnMVG9Tu2V7q6P6CBzDeJ/XsfLePFM4jIAwdB81p7URZCr7LzoMWGDfylYUA
         qc0eBIJgoSkdVbyzAOpVyw7qUCzNXwsrRKL4zM4VKfUVzBn2rc/CRDnYTHluvJ9Cacmc
         pQzPs73pJncFnNcmfLeCDLsRCdNG9gRKGZU6D4wt9MCg/L1tkOOnrU8Dw8Ey27ATuzpE
         5+4rg8F34fUE+YuBhAxYc7+unyXu411UbnD4ZmW9OL4PBC/RrPIHBU0KHf1dihQr6Nlj
         nl0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=3hLICzMUqwSU+OuwUK2lvcj8snry9XL6jJKc3niheNE=;
        b=AefUIbSUGxlbcOqFWjWdZapesE79FytAbXbPKw3dRdrK7M9Y0SnYfYcnKVZHVY//jS
         p1RhVMfi4ZPRsd1hfmMPrZqwkCpuqjeMH5Xsgp40/n4w7yX4McJ++U4PyEc51Igu+7GU
         8jynEU4JObXw5io8IwE7xs7jdWHKlRgrV+lRuKxd+MdfAaLQmf4SJ8AHI3vHaKge4KqG
         yY0sXgdxKh2al6snsym5kuRyGQiwu4pLFw45WQw1To8YYQSz1T94+A4GZ4fa7BysEmTe
         ZxTzb5/ZhCGSuEToPxz1pcIa2eI2FVrabbC75SIhCD35o7KYzmOn8Fya/PundI4j83r5
         fGYw==
X-Gm-Message-State: APjAAAUFRzrZK6wzq9fwvk2tcisqEx6PPxMWvPK3flHDOPtxSylZ9dpt
        Akh8sFzXwAHc/ojMGiOkR+VaWQWN0AbxnOM5u2s=
X-Google-Smtp-Source: APXvYqys/YbEVpfpHmSaZKwcjzvR7/Ux+CyWp/DyK9GAWi34XZVCfVdBD0jTd5Q3hCI4mxQoDeT8yzlRkTOaKAkXg20=
X-Received: by 2002:a2e:5b94:: with SMTP id m20mr62267355lje.7.1561090864887;
 Thu, 20 Jun 2019 21:21:04 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 21 Jun 2019 14:20:53 +1000
Message-ID: <CAPM=9tyM7BRfAwruJ4QsY_gMCGVHxS=ag7cNA1H304zcnAFK+A@mail.gmail.com>
Subject: [git pull] drm fixes for 5.2-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Linus,

Just catching up on the week since back from holidays, everything
seems quite sane.

Dave.

core:
- copy_to_user fix for really legacy codepaths.

vmwgfx:
- two dma fixes
- one virt hw interaction fix

i915:
- modesetting fix
- gvt fix

panfrost:
- BO unmapping fix

imx:
- image converter fixes


drm-fixes-2019-06-21:
drm vmwgfx, panfrost, i915, imx fixes
The following changes since commit 9e0babf2c06c73cda2c0cd37a1653d823adb40ec=
:

  Linux 5.2-rc5 (2019-06-16 08:49:45 -1000)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-06-21

for you to fetch changes up to 5eab9cf87b6c261f4e2f6c7623171cc2f5ea1a9c:

  Merge tag 'imx-drm-fixes-2019-06-20' of
git://git.pengutronix.de/git/pza/linux into drm-fixes (2019-06-21
11:44:24 +1000)

----------------------------------------------------------------
drm vmwgfx, panfrost, i915, imx fixes

----------------------------------------------------------------
Boris Brezillon (1):
      drm/panfrost: Make sure a BO is only unmapped when appropriate

Dan Carpenter (1):
      drm: return -EFAULT if copy_to_user() fails

Dave Airlie (4):
      Merge branch 'vmwgfx-fixes-5.2' of
git://people.freedesktop.org/~thomash/linux into drm-fixes
      Merge tag 'drm-misc-fixes-2019-06-19' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-intel-fixes-2019-06-20' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'imx-drm-fixes-2019-06-20' of
git://git.pengutronix.de/git/pza/linux into drm-fixes

Jani Nikula (1):
      Merge tag 'gvt-fixes-2019-06-19' of
https://github.com/intel/gvt-linux into drm-intel-fixes

Qian Cai (1):
      drm/vmwgfx: fix a warning due to missing dma_parms

Steve Longerbeam (3):
      gpu: ipu-v3: image-convert: Fix input bytesperline width/height align
      gpu: ipu-v3: image-convert: Fix input bytesperline for packed formats
      gpu: ipu-v3: image-convert: Fix image downsize coefficients

Thomas Hellstrom (2):
      drm/vmwgfx: Use the backdoor port if the HB port is not available
      drm/vmwgfx: Honor the sg list segment size limitation

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915: Don't clobber M/N values during fastset check

Weinan Li (1):
      drm/i915/gvt: ignore unexpected pvinfo write

 drivers/gpu/drm/drm_bufs.c                 |   5 +-
 drivers/gpu/drm/drm_ioc32.c                |   5 +-
 drivers/gpu/drm/i915/gvt/handlers.c        |  15 +--
 drivers/gpu/drm/i915/intel_display.c       |  38 ++++++--
 drivers/gpu/drm/panfrost/panfrost_gem.c    |   3 +-
 drivers/gpu/drm/panfrost/panfrost_gem.h    |   1 +
 drivers/gpu/drm/panfrost/panfrost_mmu.c    |   8 ++
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c        |   3 +
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c        | 146 +++++++++++++++++++++++--=
----
 drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c |  10 +-
 drivers/gpu/ipu-v3/ipu-image-convert.c     |  40 +++++---
 11 files changed, 209 insertions(+), 65 deletions(-)
