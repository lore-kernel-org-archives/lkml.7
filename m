Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DBCC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 01:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E4E62070B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 01:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IABV5+rC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfECBBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 21:01:20 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41873 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbfECBBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 21:01:20 -0400
Received: by mail-qt1-f195.google.com with SMTP id c13so4942950qtn.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 18:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=kSq919h6o1UVm1JZ8MlwKXlLHm8tsVrO94W57bvWp2c=;
        b=IABV5+rCWIW/Eqn5YRBe4mVOi4tsH7WTUfyZKB1wApRm0XHxzQwVhSXab+RdYsM1cS
         /f2u46ytLnwJ23XW1QgUTKxKAi6W2h1e2Ye/k/wKt9bBi1LPcQ0CzcOEwC132j9NA7/C
         wvMe6V3X/7RHzBon8R1VTPYjD45nxI6yqcBIcVsK/QlvXh5f8sdP4zcxC/nKhjUfovox
         DXu/QsP1cjLDr1o2I7rFI+K6HTwhGMjQO0Oi8fPhQpz6tsjKw47Y9V/xDfnhNm+xYdcx
         Fm2RkwEGKJeJ+BoMaXA2rcskbgNf/g9aMyaKWMm+B0IWPIHfx4Flib+99MMPuPWpCbg5
         whjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=kSq919h6o1UVm1JZ8MlwKXlLHm8tsVrO94W57bvWp2c=;
        b=epfzkd8gbi4ll2HCJEWqabOdekxbobm+FrLsoTah6/fv1d+LTqhEq2UkvZS/tn9c4q
         fp2Vm9lGA2ZmQYOiGQhtSQXNnvDYbrdrTYgbsZLLUDcrtAs+upF9XNXt0sfhYODLfXbQ
         pXu8VwE3bG8Qe8qwTafU3EMdF5QM/EQQp1FCxkimoxUCQaFFsvK0wblb7n+QhWM5TgIx
         xdf73SWyuS2TX4agICRaHGSv7FvJaAL8FQdmlTZt0Mul5LiZLYhjS/WvbIgBg5sD5/je
         ibZE4/KU1LcOOE4ercR6H/uFNp3HEXBGr/QIjKcXr6MbqekQdqG+FlSG0T2mbcTIyhUo
         xY2g==
X-Gm-Message-State: APjAAAVSiIc8G1G0VEMojYuoFvePGh25Zcbci/OtaOEA3Pa3nvRO03jO
        tdFjQs7KclgBvaweCR47wBl0vSn//hjm9afMziI=
X-Google-Smtp-Source: APXvYqzqwXBZzn7P/M+8oVZTQObkWlxaQtklrl2kNkDc5uCEVpqFRMYB6KzRrQ3YDHduezYJsr+W+TApCM448vZNbE8=
X-Received: by 2002:ac8:641:: with SMTP id e1mr6100662qth.76.1556845279093;
 Thu, 02 May 2019 18:01:19 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 3 May 2019 11:01:07 +1000
Message-ID: <CAPM=9twjCLCi0rVHeaK1CtyD=13PSFxdDTDK4LvV-w89Wr6DvA@mail.gmail.com>
Subject: [git pull] drm fixes for final
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

Just a single qxl revert for rc8/final.

Dave.
drm-fixes-2019-05-03:
drm one qxl revert
The following changes since commit 37624b58542fb9f2d9a70e6ea006ef8a5f66c30b:

  Linux 5.1-rc7 (2019-04-28 17:04:13 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-05-03

for you to fetch changes up to 1daa0449d287a109b93c4516914eddeff4baff65:

  Merge tag 'drm-misc-fixes-2019-05-02' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes (2019-05-03
09:36:31 +1000)

----------------------------------------------------------------
drm one qxl revert

----------------------------------------------------------------
Dave Airlie (1):
      Merge tag 'drm-misc-fixes-2019-05-02' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes

Gerd Hoffmann (1):
      Revert "drm/qxl: drop prime import/export callbacks"

 drivers/gpu/drm/qxl/qxl_drv.c   |  4 ++++
 drivers/gpu/drm/qxl/qxl_prime.c | 12 ++++++++++++
 2 files changed, 16 insertions(+)
