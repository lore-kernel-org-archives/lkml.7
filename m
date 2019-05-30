Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C2CC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 09:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D20582547F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 09:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfE3JZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 05:25:05 -0400
Received: from mga07.intel.com ([134.134.136.100]:12824 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbfE3JZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 05:25:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 May 2019 02:25:03 -0700
Received: from jkrzyszt-desk.igk.intel.com ([172.22.244.18])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 May 2019 02:25:01 -0700
From:   Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Michal Wajdeczko <michal.wajdeczko@intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Subject: [RFC PATCH 0/1] drm/i915: Split off pci_driver.remove() tail to drm_driver.release()
Date:   Thu, 30 May 2019 11:24:25 +0200
Message-Id: <20190530092426.23880-1-janusz.krzysztofik@linux.intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I do realize more work needs to be done to get a clean hotunplug
solution, however I need your comments to make sure that I'm going in
the right direction.

So far I have no good idea how to resolve pm_runtime_get_sync()
failures on outstanding device file close after successfull driver
unbind.

Thanks,
Janusz


Janusz Krzysztofik (1):
  drm/i915: Split off pci_driver.remove() tail to drm_driver.release()

 drivers/gpu/drm/i915/i915_drv.c | 17 +++++++++++++----
 drivers/gpu/drm/i915/i915_drv.h |  1 +
 drivers/gpu/drm/i915/i915_gem.c | 10 +++++++++-
 3 files changed, 23 insertions(+), 5 deletions(-)

-- 
2.21.0

