Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82056C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 22:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5962D207FF
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 22:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbfIZWvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 18:51:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55756 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726084AbfIZWvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 18:51:55 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6FD5D30872C5;
        Thu, 26 Sep 2019 22:51:54 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-34.bss.redhat.com [10.20.1.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9F1DD600C1;
        Thu, 26 Sep 2019 22:51:49 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     amd-gfx@lists.freedesktop.org
Cc:     "Daniel Vetter" <daniel@ffwll.ch>,
        "Alex Deucher" <alexander.deucher@amd.com>,
        "Leo Li" <sunpeng.li@amd.com>, "David Airlie" <airlied@linux.ie>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David Francis" <david.francis@amd.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        "David (ChunMing) Zhou" <david1.zhou@amd.com>,
        "Jerry (Fangzhi) Zuo" <jerry.zuo@amd.com>,
        "Harry Wentland" <harry.wentland@amd.com>,
        "Thomas Lim" <thomas.lim@amd.com>, "Lyude Paul" <lyude@redhat.com>,
        "Mario Kleiner" <mario.kleiner.de@gmail.com>,
        "Nicholas Kazlauskas" <nicholas.kazlauskas@amd.com>,
        "Dingchen Zhang" <dingchen.zhang@amd.com>,
        "Brajeswar Ghosh" <brajeswar.linux@gmail.com>,
        "Sam Ravnborg" <sam@ravnborg.org>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        "Sean Paul" <sean@poorly.run>, "Maxime Ripard" <mripard@kernel.org>
Subject: [PATCH 0/6] drm/amdgpu: Fix incorrect encoder API usages
Date:   Thu, 26 Sep 2019 18:51:02 -0400
Message-Id: <20190926225122.31455-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Thu, 26 Sep 2019 22:51:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Noticed this while trying to respin my MST suspend/resume patch series.
It's not technically possible (at least until someone moves amdgpu
away from the deprecated drm_device->driver->{load,unload} hooks) for
amdgpu to properly register all of it's encoders before registering with
userspace. However, amdgpu also apparently adds and removes encoders
along with MST connectors - which is a much bigger issue as userspace
applications definitely do not expect this type of behavior.

So, let's fix it and add some WARNs() so new drivers don't accidentally
make this mistake in the future.

Lyude Paul (6):
  drm/amdgpu/dm/mst: Don't create MST topology managers for eDP ports
  drm/amdgpu/dm/mst: Remove unnecessary NULL check
  drm/amdgpu/dm/mst: Use ->atomic_best_encoder
  drm/amdgpu/dm/mst: Make MST encoders per-CRTC and fix encoder usage
  drm/amdgpu/dm/mst: Report possible_crtcs incorrectly, for now
  drm/encoder: WARN() when adding/removing encoders after device
    registration

 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h      |  3 ++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 15 ++++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  1 -
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 46 ++++++++++---------
 .../display/amdgpu_dm/amdgpu_dm_mst_types.h   |  3 ++
 drivers/gpu/drm/drm_encoder.c                 | 31 ++++++++++---
 6 files changed, 70 insertions(+), 29 deletions(-)

-- 
2.21.0

