Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865EEC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 05:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FCC6218AE
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 05:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1f7larh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732436AbfCAFkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 00:40:14 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39326 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfCAFkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 00:40:14 -0500
Received: by mail-qk1-f196.google.com with SMTP id x6so13622148qki.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 21:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=k1NNunolA0qo2TSBmDwyHpkw3ip/KQ/lkFOJ1VmeEZ8=;
        b=e1f7larh8gjJ++8IawAFBwzgcylrm4ERfm9QR56v84a96QRZaAMto1jR6cpqeTBwIF
         MAp47nrA5b5MNoJruoElrTkX0nVKKUJwsM7KSaQ3NFU8H3P5sVQDBkjBOG+twUWge4ZN
         G6zj72WHeX3FDi5p8rhg+4/Lui/r1GfKSDLzMvwguTpJkFCw/bBcpSNTFP9jEffysWyY
         fRqhxskx6HqmvkKNoPMMJkhi4PLZZmSq7ItThTNiLpErzYnslrw/NUNey5bz9eI8syRB
         UEhP/B1Re/JV5FdFd9T0y84zf+KHUGaV/0rBjRTx9AIq56s+UptVGznhJ4lanHrXEcHz
         R9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=k1NNunolA0qo2TSBmDwyHpkw3ip/KQ/lkFOJ1VmeEZ8=;
        b=ozN3qOnYMNyHq/TO3TiA+VT2d1HPgH9lzfj2T2USPg+aieX22sbYyQADa36iqo3IOq
         OyTLhJVPMBc8ienbj5y5db627bZal87QWXLGQCXn5C5IR3qECLiXh6GlgvxyJ6dkZHsN
         iZINFe9LExcgjNN5SDfXZzQhe/b/x7eSU8/e4gimEM7Zg4n0lhrTUpEoTWKHn3y3pQLi
         NU1qmyyVyjBhOC24qdHFbKu6Lo90NUNJoUj/4EpKZpsfE086PhfVM3EjXYTnR4oKtXLy
         G8PCisuQbSxCMKuw4W9InFkPLl32xoGdX5+ZNzyVjRVI9NeKPYvzKg9nxQglPxznF1Dk
         gEKw==
X-Gm-Message-State: APjAAAWlUKiQQhHEmG99z/waIn1AjtFeRw0PDdUj00WoYWiYofts5V5f
        Dw4CxeFsFF9Le/ud5LILaqmCMSq22SIB5bwRYwY=
X-Google-Smtp-Source: APXvYqxbg1WAREkuFtFEV++tmLUdkteF1JSbMeG+TLx9bfTpGXtENWfqFBZOpjeDicZnKPVQr0c8uU1YI9z0HK9IPho=
X-Received: by 2002:a37:664d:: with SMTP id a74mr2497754qkc.285.1551418813454;
 Thu, 28 Feb 2019 21:40:13 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 1 Mar 2019 15:40:01 +1000
Message-ID: <CAPM=9twK9Yqer+wJE6tH0rAjSzXayTJyqQoP75RwDk5a3XNH3g@mail.gmail.com>
Subject: [git pull] drm fixes for 5.0 final
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

Three final fixes, one for a feature that is new in this kernel, one
bochs fix for qemu riscv and one atomic modesetting fix.

I've left a few of the other late fixes until next as I didn't want to
throw in anything that wasn't really necessary.

Dave.

drm-fixes-2019-03-01:
drm amdgfx, bochs and one core fix
The following changes since commit 5908e6b738e3357af42c10e1183753c70a0117a9:

  Linux 5.0-rc8 (2019-02-24 16:46:45 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-03-01

for you to fetch changes up to 17fb465f16027ea22225b282295f5b8af19992e0:

  drm/bochs: Fix the ID mismatch error (2019-02-28 14:05:33 +1000)

----------------------------------------------------------------
drm amdgfx, bochs and one core fix

----------------------------------------------------------------
Alistair Francis (1):
      drm/bochs: Fix the ID mismatch error

Dave Airlie (1):
      Merge branch 'drm-fixes-5.0' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes

Mario Kleiner (1):
      drm/amd/display: Use vrr friendly pageflip throttling in DC.

Nicholas Kazlauskas (1):
      drm: Block fb changes for async plane updates

 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h          |  1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 27 +++++++++++++++++++----
 drivers/gpu/drm/bochs/bochs_drv.c                 |  4 ++++
 drivers/gpu/drm/drm_atomic_helper.c               |  9 ++++++++
 4 files changed, 37 insertions(+), 4 deletions(-)
