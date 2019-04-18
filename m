Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FE9C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 03:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F01732083D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 03:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUlEM0gs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387948AbfDRDlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 23:41:06 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38367 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732325AbfDRDlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 23:41:06 -0400
Received: by mail-qt1-f196.google.com with SMTP id d13so755990qth.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 20:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=bJHd5xOWM/Xmac4cmLiBif1cn6eV5HV8X6iQxVqT918=;
        b=AUlEM0gsR9eHfrrvdyZe2IXe3G6xqzVPkr3cOyhQeZsC3Ogf6LRgFoB98aPXK5JrMM
         py3Gvtp+Gdp2IBm6MMgZqVT/eMAhAMiOh3A3w+kTWn7/PmlL1xmVb65zXXhmdNJUAAJQ
         rnCyE4TmXj2Lu2S5cB9zTGxPPTKkq0FQ4yaSTxgVZ1eepqIjZ/dYR0dKdJPNr2dWnnWn
         8tPtnjajhiqnjmON+BgPkvWd5CQ2+ccK7FZ7HuQb0eUR98RpQroN5jMsKlIcw00ku7Yk
         cjXEri6clkiVgbPkPY9DAOHjtQEgUojpxLo5oPsLrU3NkW2t08xEyy1uW2iGbcilV83w
         frLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=bJHd5xOWM/Xmac4cmLiBif1cn6eV5HV8X6iQxVqT918=;
        b=F/IkDAe6nrzryDkcxccb9TQcxiRX8mis7J54lkTYt0tYcPuV2DQNkgQlXzoIJU95nw
         ArmntVyuVbb7xJ4qQBiyHgPpn6aiGj39tAF/l/IRObHGv+P9+OkUXDthJjViwNeQFP9z
         qYl97cs+ee+S9gqZVWxALx5GT9Vh6+rOPLLFjmnm53up/9jFZRrb7lNWVGvRuLIiWp0B
         kgbe0h8d2gDr3S0uc++oHRQ/sZhL2iPewcs3ujk5wWmyZr3tln5zA0ZhYydoBEUmg5jD
         ltVsRAwTZUEkqersJ/0sVolQQdDGIUV7gNZGAAj7DWK4st7PtstLzXE6BnveNXOe5Hfz
         VLUA==
X-Gm-Message-State: APjAAAUIHONwqounxts2ZoXxhomarbOns8buRwoOBOLuntHQF3R+noYt
        As9A1mmorvqr/C5mP168mdHMgL0/AEqHWF7BlFj1s4q4Ngg=
X-Google-Smtp-Source: APXvYqyEAYCOvZT9unCh+/gluSWyQ3yP320ZQtoFhCYmOoXST8tn8tW4A35sE/YJ1hdQx8VrMlWxTRuTEVB+4cj5ouo=
X-Received: by 2002:a0c:91cc:: with SMTP id r12mr71627943qvr.35.1555558864974;
 Wed, 17 Apr 2019 20:41:04 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Thu, 18 Apr 2019 13:40:53 +1000
Message-ID: <CAPM=9twvtLWe=Z8uMHG47H7NSSYQWEpD+yvs-Dt-FMzcZMZpCg@mail.gmail.com>
Subject: [git pull] drm fixes for 5.1-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Since Easter is looming for me, I'm just pushing whatever is in my
tree, I'll see what else turns up and maybe I'll send another pull
early next week if there is anything.

tegra:
- stream id programming fix
- avoid divide by 0 for bad hdmi audio setup code

ttm:
- Hugepages fix
- refcount imbalance in error path fix

amdgpu:
- GPU VM fixes for Vega/RV
- DC AUX fix for active DP-DVI dongles
- DC fix for multihead regression.

Dave.

drm-fixes-2019-04-18:
drm tegra, amdgpu fixes
The following changes since commit dc4060a5dc2557e6b5aa813bf5b73677299d62d2=
:

  Linux 5.1-rc5 (2019-04-14 15:17:41 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-04-18

for you to fetch changes up to 00fd14ff3017f64a9a03a08291e4be0d87bedc17:

  Merge branch 'drm-fixes-5.1' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes (2019-04-18
06:56:35 +1000)

----------------------------------------------------------------
drm tegra, amdgpu fixes

----------------------------------------------------------------
Alex Deucher (1):
      drm/amdgpu/gmc9: fix VM_L2_CNTL3 programming

Arnd Bergmann (1):
      gpu: host1x: Program stream ID to bypass without SMMU

Christian K=C3=B6nig (3):
      drm/ttm: fix out-of-bounds read in ttm_put_pages() v2
      drm/ttm: fix start page for huge page check in ttm_put_pages()
      drm/ttm: fix incrementing the page pointer for huge pages

Dave Airlie (2):
      Merge tag 'drm/tegra/for-5.1-rc6' of
git://anongit.freedesktop.org/tegra/linux into drm-fixes
      Merge branch 'drm-fixes-5.1' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes

David Francis (1):
      drm/amd/display: If one stream full updates, full update all planes

Lin Yi (1):
      drm/ttm: fix dma_fence refcount imbalance on error path

Martin Leung (1):
      drm/amd/display: extending AUX SW Timeout

Thierry Reding (1):
      drm/tegra: hdmi: Setup audio only if configured

wentalou (1):
      drm/amdgpu: shadow in shadow_list without tbo.mem.start cause
page fault in sriov TDR

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   |  1 +
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c      |  1 +
 drivers/gpu/drm/amd/display/dc/core/dc.c     | 19 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h          |  3 +++
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c |  9 ++++++---
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.h |  6 +++---
 drivers/gpu/drm/tegra/hdmi.c                 | 12 +++++++++---
 drivers/gpu/drm/ttm/ttm_bo.c                 |  4 +++-
 drivers/gpu/drm/ttm/ttm_page_alloc.c         | 13 +++++++------
 drivers/gpu/host1x/hw/channel_hw.c           |  8 ++++++--
 10 files changed, 58 insertions(+), 18 deletions(-)
