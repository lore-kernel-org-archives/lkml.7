Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8E4CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 19:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9540206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 19:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsRQtSYw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfJYTbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 15:31:16 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179]:34470 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfJYTbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 15:31:14 -0400
Received: by mail-lj1-f179.google.com with SMTP id 139so3821276ljf.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 12:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=lvFlsS5TAetH+Eayr5diNLg/TJmy49QuVl3DajZzA6Y=;
        b=dsRQtSYw/eltA2XHa3cHZVV2aj9px75LTI6GQOS4GtXoEbj7RgjGfq2SZaz1AK1pCd
         q+ue+WZLlZMtSSL6f0MRgyws23C1qOJQ8w+7CHy5rZs2xkkfJE3Wl35HvBF/Wy45URDQ
         hQeAdvn65AAr2TZvOH9se8c24P6K30ZHmOIVxtOX+DE3s45wn7VUZGBDNS2a5Wx/Vf8s
         JgNSNU47eQZTI0ESZmuw1nt5Naw1YroDEOV5HUABiXEztQO4OZ7ndw5m7WzFeSuV0k3Y
         pSQ2PXS6W3GSVJ9FJwW3qMoe57wpji0feKOWpM5lTT1aQ3dhKK1XcADvjxuJCFzCxtUY
         mMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=lvFlsS5TAetH+Eayr5diNLg/TJmy49QuVl3DajZzA6Y=;
        b=BgopkvScIaQ/eUoizoHRXeBE87e7Q/4ILJ+i9j4wWLFia+UWhxiuGcoG+FlyJf1CcU
         GXQFZV1BwJERy9adrNAOj2qudrmMQt8L7g7CBZTnvTUzK9TVAZlqZbNPPPXUzJATJ4qa
         p+Z+UPRH7qvyKPXsB08UFaJ6L4Uhd69Yt355uv/f+ddCTXh7AZCjPBFB/pibcmHmV+tP
         +Ymia8PIfnMSM/FCcp1/jQajPpKc49ll0XGqoozMn5RTqeZxwNceYnmgm58LQ3e/FCxz
         qCOOYu0P5F/7pdXvd2oqPnJKNlYRczRGBafQ+GGQyYosQKarr8xxpUzTGPW2XIFjzrQf
         E5iQ==
X-Gm-Message-State: APjAAAUimKBE9GRwrja2wBk5rR5Os9dfGpIKCxc17++f7+Gb2KtUou0y
        Th0XDlArj+zq78NuSQ4Ewm3AnuSsn3iiihG4Lsk=
X-Google-Smtp-Source: APXvYqyqqD3ACPca4rjEI84rjyrLDtaG0pwgRuDnX0vYmfm/K1da9nX/3D4bl432oXUfo3eSWfEPfrJPfXQ0UcAWq54=
X-Received: by 2002:a2e:9691:: with SMTP id q17mr3605856lji.223.1572031872763;
 Fri, 25 Oct 2019 12:31:12 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Sat, 26 Oct 2019 05:31:01 +1000
Message-ID: <CAPM=9twWc0UkE53E5JDV_SW4R-4YFxvDBD2n_Cx_vHr0vj0zqw@mail.gmail.com>
Subject: [git pull] drm fixes for 5.4-rc5
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

Hi Linus,

Quiet week this week, which I suspect means some people just didn't
get around to sending me fixes pulls in time. This has 2 komeda and a
bunch of amdgpu fixes in it.

Thanks,
Dave.

drm-fixes-2019-10-25:
drm fixes for v5.4-rc5

komeda:
- typo fixes
- flushing pipes fix

amdgpu:
- Fix suspend/resume issue related to multi-media engines
- Fix memory leak in user ptr code related to hmm conversion
- Fix possible VM faults when allocating page table memory
- Fix error handling in bo list ioctl
The following changes since commit 7d194c2100ad2a6dded545887d02754948ca5241=
:

  Linux 5.4-rc4 (2019-10-20 15:56:22 -0400)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-10-25

for you to fetch changes up to 2a3608409f46e0bae5b6b1a77ddf4c42116698da:

  Merge tag 'drm-fixes-5.4-2019-10-23' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes (2019-10-25
14:48:53 +1000)

----------------------------------------------------------------
drm fixes for v5.4-rc5

komeda:
- typo fixes
- flushing pipes fix

amdgpu:
- Fix suspend/resume issue related to multi-media engines
- Fix memory leak in user ptr code related to hmm conversion
- Fix possible VM faults when allocating page table memory
- Fix error handling in bo list ioctl

----------------------------------------------------------------
Alex Deucher (4):
      drm/amdgpu/uvd6: fix allocation size in enc ring test (v2)
      drm/amdgpu/uvd7: fix allocation size in enc ring test (v2)
      drm/amdgpu/vcn: fix allocation size in enc ring test
      drm/amdgpu/vce: fix allocation size in enc ring test

Christian K=C3=B6nig (2):
      drm/amdgpu: fix potential VM faults
      drm/amdgpu: fix error handling in amdgpu_bo_list_create

Dave Airlie (2):
      Merge tag 'drm-misc-fixes-2019-10-23' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-fixes-5.4-2019-10-23' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes

Mihail Atanassov (2):
      drm/komeda: Don't flush inactive pipes
      drm/komeda: Fix typos in komeda_splitter_validate

Philip Yang (1):
      drm/amdgpu: user pages array memory leak fix

 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c        |  7 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |  8 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c            | 20 +++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h            |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c            | 35 ++++++++++++++----=
----
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c              | 31 ++++++++++++------=
-
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c              | 33 +++++++++++++-----=
--
 drivers/gpu/drm/arm/display/komeda/komeda_kms.c    |  3 +-
 .../drm/arm/display/komeda/komeda_pipeline_state.c |  4 +--
 10 files changed, 96 insertions(+), 49 deletions(-)
