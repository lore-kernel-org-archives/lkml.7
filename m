Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7672C606CF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 12:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5CD92064B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 12:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfGJMgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 08:36:43 -0400
Received: from mga09.intel.com ([134.134.136.24]:22835 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbfGJMgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 08:36:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 05:36:42 -0700
X-IronPort-AV: E=Sophos;i="5.63,474,1557212400"; 
   d="scan'208";a="170906898"
Received: from jkrzyszt-desk.igk.intel.com ([172.22.244.18])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 05:36:39 -0700
From:   Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Micha=C5=82=20Wajdeczko?= <michal.wajdeczko@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Subject: [RFC PATCH 0/6] Rename functions to match their entry points
Date:   Wed, 10 Jul 2019 14:36:25 +0200
Message-Id: <20190710123631.26575-1-janusz.krzysztofik@linux.intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Need for this was identified while working on split of driver unbind
path into _remove() and _release() parts.  Consistency in function
naming has been recognized as helpful when trying to work out which
phase the code is in.

What I'm still not sure about is desired depth of that modification -
how deep should we go down with renaming to not override meaningfull
function names.  Please advise if you think still more deep renaming
makes sense.

Thanks,
Janusz

Janusz Krzysztofik (6):
  drm/i915: Rename "_load"/"_unload" to match PCI entry points
  drm/i915: Replace "_load" with "_probe" consequently
  drm/i915: Propagate "_release" function name suffix down
  drm/i915: Propagate "_remove" function name suffix down
  drm/i915: Propagate "_probe" function name suffix down
  drm/i915: Rename "inject_load_failure" module parameter

 drivers/gpu/drm/i915/display/intel_bios.c     |   4 +-
 drivers/gpu/drm/i915/display/intel_bios.h     |   2 +-
 .../gpu/drm/i915/display/intel_connector.c    |   2 +-
 drivers/gpu/drm/i915/display/intel_display.c  |   2 +-
 .../drm/i915/display/intel_display_power.c    |   6 +-
 .../drm/i915/display/intel_display_power.h    |   2 +-
 drivers/gpu/drm/i915/gt/intel_engine_cs.c     |   2 +-
 drivers/gpu/drm/i915/i915_drv.c               | 111 +++++++++---------
 drivers/gpu/drm/i915/i915_drv.h               |  20 ++--
 drivers/gpu/drm/i915/i915_gem.c               |  12 +-
 drivers/gpu/drm/i915/i915_gem_gtt.c           |   4 +-
 drivers/gpu/drm/i915/i915_gem_gtt.h           |   2 +-
 drivers/gpu/drm/i915/i915_params.c            |   2 +-
 drivers/gpu/drm/i915/i915_params.h            |   2 +-
 drivers/gpu/drm/i915/i915_pci.c               |   6 +-
 drivers/gpu/drm/i915/intel_gvt.c              |   7 +-
 drivers/gpu/drm/i915/intel_gvt.h              |   4 +-
 drivers/gpu/drm/i915/intel_runtime_pm.c       |   2 +-
 drivers/gpu/drm/i915/intel_runtime_pm.h       |   2 +-
 drivers/gpu/drm/i915/intel_uncore.c           |   2 +-
 drivers/gpu/drm/i915/intel_wopcm.c            |   2 +-
 21 files changed, 100 insertions(+), 98 deletions(-)

-- 
2.21.0

