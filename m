Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024B4C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 13:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE47A21855
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 13:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729994AbfDENCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 09:02:49 -0400
Received: from mga02.intel.com ([134.134.136.20]:8642 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbfDENCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 09:02:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Apr 2019 06:02:48 -0700
X-IronPort-AV: E=Sophos;i="5.60,312,1549958400"; 
   d="scan'208";a="148330325"
Received: from jkrzyszt-desk.igk.intel.com ([172.22.244.18])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Apr 2019 06:02:45 -0700
From:   Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        michal.wajdeczko@intel.com, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Subject: [PATCH 0/2] Stop users from using the device on driver unbind
Date:   Fri,  5 Apr 2019 15:02:33 +0200
Message-Id: <20190405130235.7707-1-janusz.krzysztofik@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use drm_dev_unplug() to have device resources protected from user access
by DRM layer as soon as the driver is going to be unbound.  Also, cancel
all pending work so associated resources can be quickly released.

Janusz Krzysztofik (2):
  drm/i915: Use drm_dev_unplug()
  drm/i915: Mark GEM wedged right after marking device unplugged

 drivers/gpu/drm/i915/i915_drv.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

I'm resending these two patches together in series to make the robot
happy about the second one.  Also, I've added the Suggested-by: clause
to credit actual Chris' contribution.

Thanks,
Janusz
-- 
2.20.1

