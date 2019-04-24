Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD70C10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 01:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31164218FC
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 01:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UoSCJsZX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbfDXBV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 21:21:57 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39111 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728977AbfDXBV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 21:21:56 -0400
Received: by mail-qt1-f196.google.com with SMTP id h16so8151416qtk.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 18:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=SikQRIPT4euFXr3nx9SiFnt9YLg1qKcKVh7K4Rp/eQg=;
        b=UoSCJsZXYi1H+Npsm8ZAckF+uLiMYDMQRQLwGPhwR+7LB5cO6yR+hc2uKyzpRUvoFB
         8C8q97sCGT+sXN8qdF+/9TAurRjnY1LfCCvbWDfxUKmwP1EIVW8TVBqGN6dui2aD+YSF
         VTM/d0+6CPy9V8eE8TtXeuVe7IC1ysaq/wZvCt/xFGz0Li9oIuCvUqKV0r83a1DsEARD
         GLZOcDb66BXTm8jlxIgLBTrGdyuVAey7ITMTxmGAxVRi9BGxh3W7d93961k7GAY6W4ui
         L8Ry5fHlfeudfRv/uVJdEPYuGUhEi+uJ2qLVesD6I88LpGNW6x6Puy5fDjJbBab5KsjM
         juHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=SikQRIPT4euFXr3nx9SiFnt9YLg1qKcKVh7K4Rp/eQg=;
        b=HK4VkmaZrzJQbQ6stOR6D3eq2JTsD7SFO/Fpfd8n8EguFDiECDEl1sA/+lqawoyxe8
         AUC7uVjq/b4XmDIMaop8noUgk0kJ/ThnBdP/BceLeRCLko6FOrsGXDRewDWVUtKMzXPv
         Bf96e9sRxX3QTX7vaAI9hLS7MKhoVb8D3ZREYO6BR2P5bDcCAL41j8ckSO1gL7Kb6KnA
         OcD6qbf+E79cIkqj3ynD0sdvxQaQuyftnBeoQnrr/qG9BrayMJ/6XD1LKitZjsStwFxC
         6LCwSwfXF18bEAfG51lthvK4XegVYd6abs8Dk+RkXwbYPvKmigBBybc8RcD0oDvrDG1b
         4i/A==
X-Gm-Message-State: APjAAAVN3Fi27zKuD3ZmxluUedE+m60BzGhAuoiQRtDQtJRBq9E3q/fz
        9lSBqXC7d7murDcqSoFMlElL4yNP4f7CjVqdM4U=
X-Google-Smtp-Source: APXvYqxuSJfSJLiQ2OB+Qw3aGE2czS++t9hFQj/JDkGgUzST7tzdXn3K+w27JCt3ip9dl5nicdSPTdxnv3tNuj84k98=
X-Received: by 2002:a0c:f951:: with SMTP id i17mr10496533qvo.64.1556068915387;
 Tue, 23 Apr 2019 18:21:55 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Wed, 24 Apr 2019 11:21:44 +1000
Message-ID: <CAPM=9tygHnQZXS+etRBwYM_sjuQHACtNEOnXyf+KM5CvryVQ7w@mail.gmail.com>
Subject: [git pull] drm fixes (regression special)
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Linus,

We interrupt your regularly scheduled drm fixes for a regression special.

The first is for a fix in i915 that had unexpected side effects
fallout in the userspace X.org modesetting driver where X would no
longer start. I got tired of the nitpicking and issued a large hammer
on it. The X.org driver is buggy, but blackscreen regressions are
worse.

The second was an oversight that myself and Gerd should have noticed
better, Gerd is trying to fix this properly, but the regression is too
large to leave, even if the original behaviour is bad in some cases,
it's clearly bad to break a bunch of working use cases.

I'll likely have a regular fixes pull later, but I really wanted to
highlight these.

Dave.

drm-fixes-2019-04-24:
drm regression fixes (i915 and virtio-gpu)
The following changes since commit 085b7755808aa11f78ab9377257e1dad2e6fa4bb:

  Linux 5.1-rc6 (2019-04-21 10:45:57 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-04-24

for you to fetch changes up to a0cecc23cfcbf2626497a8c8770856dd56b67917:

  Revert "drm/virtio: drop prime import/export callbacks" (2019-04-24
10:52:52 +1000)

----------------------------------------------------------------
drm regression fixes (i915 and virtio-gpu)

----------------------------------------------------------------
Dave Airlie (2):
      Revert "drm/i915/fbdev: Actually configure untiled displays"
      Revert "drm/virtio: drop prime import/export callbacks"

 drivers/gpu/drm/i915/intel_fbdev.c     | 12 +++++-------
 drivers/gpu/drm/virtio/virtgpu_drv.c   |  4 ++++
 drivers/gpu/drm/virtio/virtgpu_drv.h   |  4 ++++
 drivers/gpu/drm/virtio/virtgpu_prime.c | 12 ++++++++++++
 4 files changed, 25 insertions(+), 7 deletions(-)
