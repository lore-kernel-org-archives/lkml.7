Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFE5C28CC0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 01:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0203A26091
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 01:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIzFM01G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfEaBM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 21:12:58 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]:37089 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfEaBM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 21:12:57 -0400
Received: by mail-qt1-f170.google.com with SMTP id y57so9475756qtk.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 18:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=N7Ld0oTeLa6tjc6aAUtX11UdWIlu7aDW1RqOfC98wMU=;
        b=iIzFM01G7oNvtLnXJ4NQTVQOEiTm84RMPDHBl9Ck5VjJNGHGlDDSDIhThogOHNTRQM
         wNgBEcAg/RhkKODP6JFl5nwNfAX+KkiRNZ616KsPOaJe65opufMMHCbVSt1YXviTw9Ka
         UQrMiF308s6L66y72Fl8zk+QbpVQQJ1MuSCirUg86y7daFM6lBYhU4hF0GjoS8ArLMJP
         REUyfejU4i+hU5CvXwf5Nm6Hs2G1isEMpCaB/e6BInyF67nIVXMexAejsMW+EL4eLxRF
         LnDIzAVH/oqomX1fG58Q6YoJOFejF80iMvfSqgHhn87YJg8ul4PEwlwVs5LWR02AswkN
         vSdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=N7Ld0oTeLa6tjc6aAUtX11UdWIlu7aDW1RqOfC98wMU=;
        b=JILSkZJeIGRnV/Nb1XmekNzcdgH1phCDw+HjnC1BbiwUyWK5aKyGMF6+ZwuudNdHET
         pogP5orZmikbKD0xqQeZgxHPTLJCvUTO79kcYCCxmv4oLcHFEKvEniB5y4yTxDe/HB6p
         mk9NEC0g0r2ZzS27bNubraQj/tKyk0jgxGv1aUDxyaYwIorzF3wg2/GY9vPAagnJZ32d
         R5prIbwRFOBssWnxdxCX/Wm0c6+5uIYfxm+DsEe6xpl9+G+nTaP/E6Ly6o9g7BRSD186
         3APiSM2Q54i3NKLhkjX/rL6ZZ3lY9XMGb2kwIDiZFXw7WTebZQ51KMKk6u93Jk+oa5Ui
         UnbA==
X-Gm-Message-State: APjAAAUKayBJUYkzb5QfffUmhgRNzep/GMFWb1yubIddMOKOMV0973j6
        6EFeVsz0shQxcgaWOn8nhoB/bTAqEdKP8m9L/O7oHUoSSmw=
X-Google-Smtp-Source: APXvYqyT4Gu/IscOyDRCD+y3J0nNV+vi1s9deC8Ea5jxYqX7ny9Fh9taIHkBJ0ZeUx4Qv8PPuuNS4qTV8cEt3cb6B4o=
X-Received: by 2002:a0c:d973:: with SMTP id t48mr6328257qvj.83.1559265176588;
 Thu, 30 May 2019 18:12:56 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 31 May 2019 11:12:45 +1000
Message-ID: <CAPM=9twUWVimrFu+Lbu4SHZw8szeHD=FGD8GVyf5tmd6p8w7=Q@mail.gmail.com>
Subject: [git pull] drm fixes for 5.2-rc3
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

Nothing too crazy, pretty quiet, maybe too quiet.

amdgpu:
- a fixed version of the raven firmware fix we previously reverted,
- stolen memory fix

imx:
- regression fix

qxl:
- remove a bad warning.

etnaviv:
- VM locking fix.

Dave.

drm-fixes-2019-05-31:
drm etnaviv, imx, amdgpu fixes
The following changes since commit cd6c84d8f0cdc911df435bb075ba22ce3c605b07:

  Linux 5.2-rc2 (2019-05-26 16:49:19 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-05-31

for you to fetch changes up to 2a3e0b716296a504d9e65fea7acb379c86fe4283:

  Merge tag 'imx-drm-fixes-2019-05-29' of
git://git.pengutronix.de/git/pza/linux into drm-fixes (2019-05-31
09:15:25 +1000)

----------------------------------------------------------------
drm etnaviv, imx, amdgpu fixes

----------------------------------------------------------------
Dave Airlie (4):
      Merge branch 'etnaviv/fixes' of
https://git.pengutronix.de/git/lst/linux into drm-fixes
      Merge tag 'drm-misc-fixes-2019-05-29' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge branch 'drm-fixes-5.2' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes
      Merge tag 'imx-drm-fixes-2019-05-29' of
git://git.pengutronix.de/git/pza/linux into drm-fixes

Flora Cui (1):
      drm/amdgpu: reserve stollen vram for raven series

Gerd Hoffmann (1):
      drm/qxl: drop WARN_ONCE()

Harry Wentland (1):
      drm/amd/display: Don't load DMCU for Raven 1 (v2)

Lucas Stach (1):
      drm/etnaviv: lock MMU while dumping core

Philipp Zabel (1):
      drm/imx: ipuv3-plane: fix atomic update status query for non-plus i.MX6Q

 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c             |  3 +--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 ++++++++++--
 drivers/gpu/drm/etnaviv/etnaviv_dump.c            |  5 +++++
 drivers/gpu/drm/imx/ipuv3-plane.c                 | 13 ++++++++-----
 drivers/gpu/drm/imx/ipuv3-plane.h                 |  1 -
 drivers/gpu/drm/qxl/qxl_prime.c                   |  1 -
 6 files changed, 24 insertions(+), 11 deletions(-)
