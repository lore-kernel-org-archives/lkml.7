Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE05C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 01:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF9B42077B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 01:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZuh+aY4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbfKOBSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 20:18:30 -0500
Received: from mail-lf1-f47.google.com ([209.85.167.47]:42386 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbfKOBS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 20:18:29 -0500
Received: by mail-lf1-f47.google.com with SMTP id z12so6640701lfj.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 17:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=wJ6/omUTJkJcn0C2qSs53kpo0Py+xxf6r4lxyXHfgd4=;
        b=mZuh+aY4775QAzl8C1NUnjHXVLEakKuznAkRa4Q6zWEcMl1px6oQJteYfALdkSNM0I
         Cvp4xlEFnmLja2KzsFX1B5KnMLdCYWDAsymvcuCCrIgG83GHMUe1m3oJ+jfP+QQZdOi1
         ZWXr75jlhKH1zIKNLpgAOlYaOO53o8XXXjTRbR5XeuZ/C1fssNKQaU9256QJcBwOw2RW
         jKBZiUpz8oXgd6uLtFh4aHABk2XD3QVeNlo4TEOnlnpFRWiW9RjFXgtbO5K4NemNvDjw
         YFpfeo29F/IZhLTeN8+iclfzCfynXFi3578f2ybPwRRr6hsYigWLEcg/YFBcVyLEQrOV
         oLBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=wJ6/omUTJkJcn0C2qSs53kpo0Py+xxf6r4lxyXHfgd4=;
        b=kuJ5/a7rczRtrHEHP3eOwZ+INw/YaiQ8FDOahO6b62/xFDR6zF5IUNkQj0cwqFyH6P
         o2TbMwgiMcQw4k8KK11+gN4OZWbRnKl6jQdcmAHwIF3sNgPCVWHrFeNIrolTLCjn0x+A
         3Wp5JBGqO1I/Pg6usklkYsRm3hkdJHxmf3JLnrs2bDLGVu/tkQh9tw567LZiG51D/U1g
         aV+KX8oSs3O4AAy0+5SwCkM7/UGVKRx7AdBU+gL6V6zqE4KWsj/SteNxpW4RhmIZYkMD
         A5lC0UanWZgUbRIj2if34zuOux5U7jRLd8kdL9liCATYyeaCkWk+gE+oDRbb/SLjqUIO
         C1ag==
X-Gm-Message-State: APjAAAU5sULRNnHgMl0Gvd2z1LESi8iQidgw2Dtreni6R15gSDPFZZhJ
        VjzA9jjLr1BigZwF1y9WfQL1oIOpFISrVt/UL2tS76ub
X-Google-Smtp-Source: APXvYqwKxKRFoEkI95DiRbO+qNgpVmcEJlvMGbvy9N81Vkyy0QfuEiaR4yPHO6ViJKW93JlLhNPPwPdL9Crub+5WCgM=
X-Received: by 2002:a19:710d:: with SMTP id m13mr4053205lfc.160.1573780707495;
 Thu, 14 Nov 2019 17:18:27 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 15 Nov 2019 11:18:16 +1000
Message-ID: <CAPM=9twvcfHPb4nrAQnHaEWhQrbByR0CfGXbWo_479c3YR47uw@mail.gmail.com>
Subject: [git pull] drm fixes for 5.4-rc8
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

Assuming an rc8 might happen, anyways here is this weeks non-intel hw
vuln fixes pull. 3 drivers, all small fixes.

Thanks,
Dave.

drm-fixes-2019-11-15:
drm fixes for 5.4-rc8

i915:
- MOCS table fixes for EHL and TGL
- Update Display's rawclock on resume
- GVT's dmabuf reference drop fix

amdgpu:
- Fix a potential crash in firmware parsing

sun4i:
- One fix to the dotclock dividers range for sun4i
The following changes since commit 31f4f5b495a62c9a8b15b1c3581acd5efeb9af8c:

  Linux 5.4-rc7 (2019-11-10 16:17:15 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-11-15

for you to fetch changes up to 07ceccacfb27be0e151b876caeda3a556cef099c:

  Merge tag 'drm-fixes-5.4-2019-11-14' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes (2019-11-15
10:38:34 +1000)

----------------------------------------------------------------
drm fixes for 5.4-rc8

i915:
- MOCS table fixes for EHL and TGL
- Update Display's rawclock on resume
- GVT's dmabuf reference drop fix

amdgpu:
- Fix a potential crash in firmware parsing

sun4i:
- One fix to the dotclock dividers range for sun4i

----------------------------------------------------------------
Dave Airlie (3):
      Merge tag 'drm-intel-fixes-2019-11-13' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'drm-misc-fixes-2019-11-13' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-fixes-5.4-2019-11-14' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes

Jani Nikula (1):
      drm/i915: update rawclk also on resume

Matt Roper (2):
      Revert "drm/i915/ehl: Update MOCS table for EHL"
      drm/i915/tgl: MOCS table update

Pan Bian (1):
      drm/i915/gvt: fix dropping obj reference twice

Rodrigo Vivi (1):
      Merge tag 'gvt-fixes-2019-11-12' of
https://github.com/intel/gvt-linux into drm-intel-fixes

Xiaojie Yuan (1):
      drm/amdgpu: fix null pointer deref in firmware header printing

Yunhao Tian (1):
      drm/sun4i: tcon: Set min division of TCON0_DCLK to 1.

 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            | 38 +++++++++-------------
 drivers/gpu/drm/i915/display/intel_display_power.c |  3 ++
 drivers/gpu/drm/i915/gt/intel_mocs.c               | 10 +-----
 drivers/gpu/drm/i915/gvt/dmabuf.c                  |  4 +--
 drivers/gpu/drm/i915/i915_drv.c                    |  3 --
 drivers/gpu/drm/sun4i/sun4i_tcon.c                 |  2 +-
 6 files changed, 23 insertions(+), 37 deletions(-)
