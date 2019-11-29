Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A133C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 01:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A3A21721
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 01:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tiNUa5Xt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfK2BP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 20:15:29 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34798 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbfK2BP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 20:15:29 -0500
Received: by mail-lj1-f193.google.com with SMTP id m6so22775117ljc.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 17:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=EemkNi883zJPt7h/gyNoyZFf9oLM/4mt9vmGL/It73s=;
        b=tiNUa5XtB2SIzEwmplH6KPJJiIei2e15M1HJHi+3IPrvHsgO1RQHADp3MZJmu2b8Oe
         4AUD/ATeMHmk/JWuPoRObTzrHpmU5Swx0ZECdyFi51S27wmUIV+3XOkKkkG4f8z/iX3o
         76bvroDHtBPx3TUpyFP90P7vghQ8sOryKmt0jyHMaABp4HXUjzcc7WPCggIAAza6Xr7j
         HWfypEU+kUAiQaloVJPGSBdZaIl4Pwv/oTx74zno3rNqlCws2/RfiLjhzRESFTJEfH2X
         BAfQi82BI0jvMY1qp13mU387d7F5MMEcCROC3QxXLIuvUyQYq8U+zerQQAwHPKsSYID2
         421g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=EemkNi883zJPt7h/gyNoyZFf9oLM/4mt9vmGL/It73s=;
        b=gl9PyFPlwpvMiGhvqtQrSo2YtXrLu7dkRgajzJRA6rZfFD1AsEYgepVS/outshTjCX
         I6ADBc0k98EUXNX9k9icvVpgVZgybSxYi9nnp3KkMvg4t/GjkHbOFb4p+Mw/gaCgxf0e
         5/pCmZOrkgjecxpR8G/bMDPrf/NGVlb3+xYM5ZbpHBsrkbffIePW0/RLmR4Hn3zz4xkn
         kzMGv56qPeYUxBMaLHKuozYyN2AcVYZG7CDJHluSuhwH5LQorVPmV93y8UvEDptSJ1zN
         sJdd2p/Qqu2MrpksKvU/ni6dxepcQR535Wiad8I9OD1zVF6NvaTi8wGA+EzcBHxtsNoM
         mpXw==
X-Gm-Message-State: APjAAAWusuNqdYTeglgx8hqxjVgP7eVLD1EzZ/OqzLJhGE262ZVcvazV
        ng9cDxEOrXeGdJJg+7f/nd7vk6d3x+8vGkcebq0=
X-Google-Smtp-Source: APXvYqwfldAK803EO8Yg5VM0hw5GCQBnrWVL4vWf/uQ5kZ+gZPnwSRd0m2LcxtTcsOdIZxmOdnKPcDBcqR/za92EeU8=
X-Received: by 2002:a2e:858c:: with SMTP id b12mr35578776lji.189.1574990124731;
 Thu, 28 Nov 2019 17:15:24 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 29 Nov 2019 11:15:13 +1000
Message-ID: <CAPM=9txVpjxR1UAOPpXn-ZqMamAUdzfq_HOEav99A0A0sfFBUw@mail.gmail.com>
Subject: [git pull] mm + drm vmwgfx coherent
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas@shipmail.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is just a separated pull for the mm pagewalking + drm/vmwgfx work
Thomas did and you were involved in, I've left it separate in case you
don't feel as comfortable with it as the other stuff.

It has mm acks/r-b in the right places from what I can see.

Dave.

drm-vmwgfx-coherent-2019-11-29:
mm + drm coherent memory support for vmwgfx
The following changes since commit acc61b8929365e63a3e8c8c8913177795aa45594:

  Merge tag 'drm-next-5.5-2019-11-22' of
git://people.freedesktop.org/~agd5f/linux into drm-next (2019-11-26
08:40:23 +1000)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-vmwgfx-coherent-2019-11-29

for you to fetch changes up to 0a6cad5df541108cfd3fbd79eef48eb824c89bdc:

  Merge branch 'vmwgfx-coherent' of
git://people.freedesktop.org/~thomash/linux into drm-next (2019-11-28
14:33:01 +1000)

----------------------------------------------------------------
mm + drm coherent memory support for vmwgfx

----------------------------------------------------------------
Dave Airlie (1):
      Merge branch 'vmwgfx-coherent' of
git://people.freedesktop.org/~thomash/linux into drm-next

Thomas Hellstrom (10):
      drm/ttm: Remove explicit typecasts of vm_private_data
      drm/ttm: Convert vm callbacks to helpers
      mm: Remove BUG_ON mmap_sem not held from xxx_trans_huge_lock()
      mm: pagewalk: Take the pagetable lock in walk_pte_range()
      mm: Add a walk_page_mapping() function to the pagewalk code
      mm: Add write-protect and clean utilities for address space ranges
      drm/vmwgfx: Implement an infrastructure for write-coherent resources
      drm/vmwgfx: Use an RBtree instead of linked list for MOB resources
      drm/vmwgfx: Implement an infrastructure for read-coherent resources
      drm/vmwgfx: Add surface dirty-tracking callbacks

 drivers/gpu/drm/ttm/ttm_bo_vm.c                    | 174 +++++---
 drivers/gpu/drm/vmwgfx/Kconfig                     |   1 +
 drivers/gpu/drm/vmwgfx/Makefile                    |   2 +-
 .../drm/vmwgfx/device_include/svga3d_surfacedefs.h | 233 +++++++++-
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c                 |  10 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                |  44 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c            |   1 -
 drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c         | 488 +++++++++++++++++++++
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c           | 193 +++++++-
 drivers/gpu/drm/vmwgfx/vmwgfx_resource_priv.h      |  13 +
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c            | 395 ++++++++++++++++-
 drivers/gpu/drm/vmwgfx/vmwgfx_ttm_glue.c           |  15 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_validation.c         |  74 +++-
 drivers/gpu/drm/vmwgfx/vmwgfx_validation.h         |  16 +-
 include/drm/ttm/ttm_bo_api.h                       |  14 +
 include/linux/huge_mm.h                            |   2 -
 include/linux/mm.h                                 |  13 +-
 include/linux/pagewalk.h                           |   9 +
 include/uapi/drm/vmwgfx_drm.h                      |   4 +-
 mm/Kconfig                                         |   3 +
 mm/Makefile                                        |   1 +
 mm/mapping_dirty_helpers.c                         | 315 +++++++++++++
 mm/pagewalk.c                                      |  99 ++++-
 23 files changed, 1996 insertions(+), 123 deletions(-)
 create mode 100644 drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c
 create mode 100644 mm/mapping_dirty_helpers.c
