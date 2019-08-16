Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BCEC3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 04:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDEE8206C2
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 04:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1cPBKH2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbfHPEWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 00:22:10 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]:34538 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfHPEWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 00:22:10 -0400
Received: by mail-lj1-f174.google.com with SMTP id x18so4148875ljh.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 21:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=idW84Lt4wQrZ+T6IktWRZghuJXQuOYw1V00dQ6+sPDY=;
        b=U1cPBKH2eroajZ/Rc9Gv7dAvg+LwRrqHqwMod0qeBi+X1I95MN8gDPAmhzC+Op3UY/
         2C+ZPAVee2tDe9IOPPjPDGRu3A9YfXLq0SL5iDh7CH/+axxLDk4oPCliPZr12s5a/L3I
         PTEy8hXSut8dXgwi2hIU3sHJRLxCSteqBVrGWnc0iDC9RAS8UF4J0x2xssZqnWfNmHOW
         KyWXgkFJzorxMwhO0k/Ahm8cPHXcraiAr+u4FnePdyVPXPzjZMvusWL9J2WYcvrPPymR
         aPmx9YuC4gKBgW7y4ZQPL0FwblWvY+3L5ZrPF6TwfFaBTAMzlhL7IQhNk3S+CwgQb6Az
         MnTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=idW84Lt4wQrZ+T6IktWRZghuJXQuOYw1V00dQ6+sPDY=;
        b=l9qD9DKUQ7DBXgLutHObv1lDxDvDOSRIswrOwGiW/jzVXccjT9cNTh5igUTwWiW9ha
         aAE6TxepMkEDnWzdD5IJ4JbvN7cIkuNOLGWi0KlT/RsonnLpQH4nhL1OE5c4Jx3VnEZb
         IaBqs1ABIxTsBuNr5d2UliQdNfhYACELeMUtPVbFZk/5JfMK/bIdOHBPGBY/ZBgz7T9j
         UBqDEqXKL5qxJNur84LgbCpXhXN2AAqFvzn1tZsz96G+l8/DyubuDjHpEIc+xOw4eWtb
         BPREu2CVNMX0blUjQnh2WF+he7Z6zbiTJQqQ5btHKZZ4eJ5TedYYh5B+n0mDgDOYI+kh
         i7yQ==
X-Gm-Message-State: APjAAAU77BbzeTL/EwusqYe4OrIqvh03sDOK9qOt0gvK10sGL6qjlm62
        +AHQUSCBkzKtlxNq/d/shYIzpgFDPdp4jkCIXzk=
X-Google-Smtp-Source: APXvYqyDqwbU6cnzYDXq7vqgdm22zPpOJCbB9e2lxfaUyzwy+oREAXrRGsDmd97RB7vxX79EZ6D80xLc8XWlTirrSoE=
X-Received: by 2002:a2e:6342:: with SMTP id x63mr4308964ljb.95.1565929327525;
 Thu, 15 Aug 2019 21:22:07 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 16 Aug 2019 14:21:56 +1000
Message-ID: <CAPM=9tx2Kkbyor2-EnK31VE1eARbq6zCyNgqj39tyLqd8uUWKA@mail.gmail.com>
Subject: [git pull] drm fixes for 5.3-rc5
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

Nothing too crazy this week, one amdgpu fix to use vmalloc for a
struct that grew in size, and another MST fix for nouveau, and some
other misc fixes.

Regards,
Dave.

drm-fixes-2019-08-16:
drm fixes for 5.3-rc5

i915:
- single GVT use after free fix

scheduler:
- entity destruction race fix

amdgpu:
- struct allocation fix
- gfx9 soft recovery fix

nouveau:
- followup MST fix

ast:
- vga register race fix.
The following changes since commit d45331b00ddb179e291766617259261c112db872=
:

  Linux 5.3-rc4 (2019-08-11 13:26:41 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-08-16

for you to fetch changes up to a85abd5d45adba75535b7fc6d9f78329a693b7a9:

  Merge tag 'drm-intel-fixes-2019-08-15' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes (2019-08-16
12:41:52 +1000)

----------------------------------------------------------------
drm fixes for 5.3-rc5

i915:
- single GVT use after free fix

scheduler:
- entity destruction race fix

amdgpu:
- struct allocation fix
- gfx9 soft recovery fix

nouveau:
- followup MST fix

ast:
- vga register race fix.

----------------------------------------------------------------
Alex Deucher (1):
      drm/amd/display: use kvmalloc for dc_state (v2)

Christian K=C3=B6nig (1):
      drm/scheduler: use job count instead of peek

Dan Carpenter (1):
      drm/i915: Use after free in error path in intel_vgpu_create_workload(=
)

Dave Airlie (2):
      Merge tag 'drm-fixes-5.3-2019-08-14' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes
      Merge tag 'drm-intel-fixes-2019-08-15' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes

Jani Nikula (1):
      Merge tag 'gvt-fixes-2019-08-13' of
https://github.com/intel/gvt-linux into drm-intel-fixes

Lyude Paul (1):
      drm/nouveau: Only recalculate PBN/VCPI on mode/connector changes

Pierre-Eric Pelloux-Prayer (1):
      drm/amdgpu: fix gfx9 soft recovery

Y.C. Chen (1):
      drm/ast: Fixed reboot test may cause system hanged

 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    |  2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c | 11 ++++++-----
 drivers/gpu/drm/ast/ast_main.c           |  5 ++++-
 drivers/gpu/drm/ast/ast_mode.c           |  2 +-
 drivers/gpu/drm/ast/ast_post.c           |  2 +-
 drivers/gpu/drm/i915/gvt/scheduler.c     |  4 ++--
 drivers/gpu/drm/nouveau/dispnv50/disp.c  | 22 +++++++++++++---------
 drivers/gpu/drm/scheduler/sched_entity.c |  4 ++--
 8 files changed, 30 insertions(+), 22 deletions(-)
