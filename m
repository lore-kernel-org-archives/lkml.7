Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C90CC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4035D206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389097AbfDROve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 10:51:34 -0400
Received: from mga11.intel.com ([192.55.52.93]:49619 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733192AbfDROve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 10:51:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Apr 2019 07:51:34 -0700
X-IronPort-AV: E=Sophos;i="5.60,366,1549958400"; 
   d="scan'208";a="135450484"
Received: from jkrzyszt-desk.igk.intel.com ([172.22.244.18])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Apr 2019 07:51:31 -0700
From:   Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        michal.wajdeczko@intel.com, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        janusz.krzysztofik@linux.intel.com, janusz.krzysztofik@intel.com
Subject: [PATCH v2 0/1] Stop users from using the device on driver unbind
Date:   Thu, 18 Apr 2019 16:51:22 +0200
Message-Id: <20190418145123.11085-1-janusz.krzysztofik@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190405130235.7707-1-janusz.krzysztofik@linux.intel.com>
References: <20190405130235.7707-1-janusz.krzysztofik@linux.intel.com> <155445268803.8259.16095445514284244974@skylake-alporthouse-com> <20190415093225.GZ2665@phenom.ffwll.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use drm_dev_unplug() to have device resources protected from user access
by DRM layer as soon as the driver is going to be unbound.

Janusz Krzysztofik (1):
  drm/i915: Use drm_dev_unplug()

 drivers/gpu/drm/i915/i915_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Since this patch should be now safe for use if merged with current
drm-next or drm-tip branch which no longer suffer from incorrectly
resolved merge confilct that was breaking it, finally fixed by commit
bd53280ef042 ("drm/drv: Fix incorrect resolution of merge conflict"),
I'm resending it with Daniel's Reviewed-by: added.

Former patch 2/2 has been dropped as it is already in drm-intel-next as
commit 141f3767e7b8 ("drm/i915: Mark GEM wedged right after marking
device unplugged").  BTW, the wersion I sent was screwed up, not
reflecting Chris' intention precisely enough, but Chris was vigilant and
fixed it.  Sorry Chris.

Thanks,
Janusz
-- 
2.20.1

