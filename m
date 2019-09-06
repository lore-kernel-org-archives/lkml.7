Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331AEC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 07:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B377218DE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 07:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQMP5Ag5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391822AbfIFHSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 03:18:49 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46]:42505 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbfIFHSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 03:18:48 -0400
Received: by mail-lf1-f46.google.com with SMTP id u13so4127943lfm.9
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 00:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=CMTMu4cP8lqBEnOq+3yeUECTCt8Q5F1tZFVsCniXU+k=;
        b=TQMP5Ag5MmlfO77ESC5/eimx3Un9coIWQbCLG9MB2wN1F4LG0lllG/BTlzullTR10e
         E2HZYXEfIEzrYg1I8gpfSCgKkTUW9n4mzps1lL9rMjkDYsEhIacgFsEMZaffZj3wAau7
         GCHYmytQyhIaf/ddDUDgJXpcHGDki6E0OtERzBDiirjZ/fGc9wjDkKU7VHnOlG0Vy+qN
         3mbpSq4yr6F4EUqCarBkPEWMQuahQd7AlXQq3UEg6B9v1hfEu5bZ8NzLB909HjklRMa0
         cCrUAidFW5OKY1gaUjX2BTjppnDXPfzIoRl8dI1OuxAcF//CzB6PFY1S9rUkZLFrDC92
         fc6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=CMTMu4cP8lqBEnOq+3yeUECTCt8Q5F1tZFVsCniXU+k=;
        b=Kl+dzALxu1Dexaqt6ZWNd+RncSTfPdjlsoAWatSOI5jyq/Gs/lqlL3WSFy7rruj8ve
         n8116Xu8d3o1ewJzti7OGnAEzPYiI4h9XusAnsrARKl/VN5GUN6rs/xKXjkvz622lHXq
         5S9+XDnXVkOq6tKfk5SySB2V7/u3JW7sNLfWmfbKsFNU8qObzYvOGyZ/jaJnqYKQJjAX
         S0KwKSxsqIRdwMYppsYIl2UuJis0C3dJBocjwL72eQjauTB7cnboPLaFGw/kM67hfOKU
         KjpnFhIMdGBbDE549h7kKXULDq64hzGr3uMVAG+hfyyquVKqlzAgBeHYpptcICLKnQnO
         U1lQ==
X-Gm-Message-State: APjAAAXTf6NfET7oMp8dUHdeRGHxqnZ2Zf6fXBK0sBPfz02zaknTInk3
        PWVH78k8goYEQJ5UEBVfdrV9g9e5qIVrSjqKSMcizm0FKCE=
X-Google-Smtp-Source: APXvYqxOUF1RH3914HcjSUiThBqloJ8m7nn7h3+HnW6H5vy8XViijHHhIEIAyUEaHmgEoBu+flzQ5ebd18lJgF9Mzi4=
X-Received: by 2002:a19:7715:: with SMTP id s21mr5045709lfc.98.1567754326284;
 Fri, 06 Sep 2019 00:18:46 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 6 Sep 2019 17:18:34 +1000
Message-ID: <CAPM=9twnS=MQzLZM6sJ5wCtS5reFqd7715DtceP-6+=h2JoKLg@mail.gmail.com>
Subject: [git pull] drm fixes for 5.3-rc8 (or final)
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

Live from my friend's couch in Barcelona. Latest round of drm fixes,
the command line parser regression fixes look a bit larger because
they come with selftests included for the bugs they fix. Otherwise a
single nouveau, single ingenic and single vmwgfx fix.

Dave.

drm-fixes-2019-09-06:
drm fixes for 5.3-rc8 (or final)

nouveau:
- add missing MODULE_FIRMWARE definitions

igenic:
- hardcode panel type DPI

vmwgfx:
- double free fix

core:
- command line mode parser fixes
The following changes since commit 089cf7f6ecb266b6a4164919a2e69bd2f938374a:

  Linux 5.3-rc7 (2019-09-02 09:57:40 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-09-06

for you to fetch changes up to 1e19ec6c3c417a0893fcfae7abfba623e781d876:

  Merge tag 'drm-misc-fixes-2019-09-05' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes (2019-09-06
16:27:46 +1000)

----------------------------------------------------------------
drm fixes for 5.3-rc8 (or final)

nouveau:
- add missing MODULE_FIRMWARE definitions

igenic:
- hardcode panel type DPI

vmwgfx:
- double free fix

core:
- command line mode parser fixes

----------------------------------------------------------------
Ben Skeggs (1):
      drm/nouveau/sec2/gp102: add missing MODULE_FIRMWAREs

Dan Carpenter (1):
      drm/vmwgfx: Fix double free in vmw_recv_msg()

Dave Airlie (3):
      Merge branch 'linux-5.3' of git://github.com/skeggsb/linux into drm-fixes
      Merge branch 'vmwgfx-fixes-5.3' of
git://people.freedesktop.org/~thomash/linux into drm-fixes
      Merge tag 'drm-misc-fixes-2019-09-05' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes

Laurent Pinchart (1):
      drm/ingenic: Hardcode panel type to DPI

Maxime Ripard (4):
      drm/modes: Add a switch to differentiate free standing options
      drm/modes: Fix the command line parser to take force options into account
      drm/modes: Introduce a whitelist for the named modes
      drm/selftests: modes: Add more unit tests for the cmdline parser

 drivers/gpu/drm/drm_modes.c                        |  54 ++++++++-
 drivers/gpu/drm/ingenic/ingenic-drm.c              |   5 +-
 .../gpu/drm/nouveau/nvkm/subdev/secboot/gp102.c    |  12 ++
 drivers/gpu/drm/selftests/drm_cmdline_selftests.h  |   7 ++
 .../gpu/drm/selftests/test-drm_cmdline_parser.c    | 130 +++++++++++++++++++++
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c                |   8 +-
 6 files changed, 202 insertions(+), 14 deletions(-)
