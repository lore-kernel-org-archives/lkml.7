Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB86C4CEC5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 15:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDCC520693
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 15:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llucwq1a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733117AbfILP4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 11:56:42 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:42083 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729688AbfILP4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 11:56:41 -0400
Received: by mail-lf1-f49.google.com with SMTP id c195so4904842lfg.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 08:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=08NQ2RyLnhScyge49udAnnrLLM+WIZvYIMmDFFtTPF4=;
        b=llucwq1amaRqYmqpFKvH5vR/oR4tM9ntXg/yn6CI5DfH8hMKPwkAP8p50FRw8+niiG
         NMRl1l3BcdGp5NqydR/ENBgMF/QK1wUqkyjI3b/WLzb9sbUgus01Z1cv0vPv+coSOpuK
         TwW0tRNRzC5OsPmYW5rIslCKQT/zKn572wAR7fIsYHx/d9qdpETKoqWb4wfRCVuvoNob
         mftAHTue1EZDOFW8xRMeZotpP+MPqKmvjd0EmdVe6V1HwM/o8d3wCyDqp6qRkus5HwHq
         ByyTJvjCl1Z9DyUb48yPKYgPCjsRuPpFYxs5pCe/2BUMoe2YGP3GQiaeCR9Fw5rcm+M6
         uVow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=08NQ2RyLnhScyge49udAnnrLLM+WIZvYIMmDFFtTPF4=;
        b=GO85d2/bOzATSqRlTsmqpa8ZJhOmdmXofUhSqcswvhA7kBGTz99AiE4GBnmgcgYlmr
         RMBYWv2zWVnizF7+AkzNAy/DQa6T4piTLSOqZ1vZWuuPmjb/dJAT4RXn3IzW9H3bNI49
         Zk5c2bI9tpuNLuJygleVfDxzvv8NMzUoEhKRieXbBWwqBT+IBRVyd4jHxZ6QK3JURH/f
         pfHvaXLPjmj3bkQHHaxiQION6dkSxFWvMnYuPHAfrxOBDaMAQdbS3tZ5CWngZ8s7B03W
         o5kV8m4oxb8UKfI0LGS+pSifjJFOK7gi2IqlUBvOwQuzLFriqpKXnrFEDzMiSjbWZC9C
         Evzg==
X-Gm-Message-State: APjAAAVCTls56TuWlySy/Lx0uaxFAaZ1/gDXMCNOUzbcjh/SSPSwqS/1
        d2VEyhS0QRtM4gtm34V1xf9KRJSjttgYWJOaRgs=
X-Google-Smtp-Source: APXvYqx27FI3Hoesal65btLW4S8NYw6nUV5E4OjFCymMd4GVVjcRSi/tYbb7qvph3V7Zn2MbUOsfPM8lYmTayEHVhHk=
X-Received: by 2002:ac2:530e:: with SMTP id c14mr1549411lfh.165.1568303799145;
 Thu, 12 Sep 2019 08:56:39 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 13 Sep 2019 01:56:28 +1000
Message-ID: <CAPM=9tws0GHMQd0Byunw3XJXq2vqsbbkoR-rqOxfL3f+Rptscw@mail.gmail.com>
Subject: drm fixes for 5.3-rc9
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Linus,

From the maintainer summit, just some last minute fixes for final,
details in the tag.

Dave.

drm-fixes-2019-09-13:
drm fixes for 5.3-rc9

lima:
- fix gem_wait ioctl

core:
- constify modes list

i915:
- DP MST high color depth regression
- GPU hangs on vulkan compute workloads
The following changes since commit f74c2bb98776e2de508f4d607cd519873065118e=
:

  Linux 5.3-rc8 (2019-09-08 13:33:15 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-09-13

for you to fetch changes up to e6bb711600db23eef2fa0c16a2d361e17b45bb28:

  Merge tag 'drm-misc-fixes-2019-09-12' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes (2019-09-12
23:14:35 +1000)

----------------------------------------------------------------
drm fixes for 5.3-rc8

lima:
- fix gem_wait ioctl

core:
- constify modes list

i915:
- DP MST high color depth regression
- GPU hangs on vulkan compute workloads

----------------------------------------------------------------
Chris Wilson (1):
      drm/i915: Restore relaxed padding (OCL_OOB_SUPPRES_ENABLE) for skl+

Dave Airlie (2):
      Merge tag 'drm-intel-fixes-2019-09-11' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'drm-misc-fixes-2019-09-12' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes

Maxime Ripard (1):
      drm/modes: Make the whitelist more const

Vasily Khoruzhick (1):
      drm/lima: fix lima_gem_wait() return value

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915: Limit MST to <=3D 8bpc once again

 drivers/gpu/drm/drm_modes.c                 |  2 +-
 drivers/gpu/drm/i915/display/intel_dp_mst.c | 10 +++++++++-
 drivers/gpu/drm/i915/gt/intel_workarounds.c |  5 -----
 drivers/gpu/drm/lima/lima_gem.c             |  2 +-
 4 files changed, 11 insertions(+), 8 deletions(-)
