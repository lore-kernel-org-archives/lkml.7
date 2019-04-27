Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A1FC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B748F20679
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329976;
	bh=SAK8AjKhssV3cKF8uOF9xbfuqTwdQ0pPCkmp1iUJC3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SN+jS/pHkC47Q1HtHcSuh4FP9bRDTbq8adakEfFYGMbyx+i0ZP3416epqwi4u4ODG
	 csmiM6LftlkpUy6qPEfzMZVNqgD3uITOosnrxKcwpYl27CiwOuWWWcvtekrtYRRnPc
	 rfYC575MzbpZRsx7MNmVprX7DVZr8Pf/JbCqEHZ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbfD0BkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:40:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:43870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727378AbfD0BkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:40:20 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 260EE20B7C;
        Sat, 27 Apr 2019 01:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329219;
        bh=SAK8AjKhssV3cKF8uOF9xbfuqTwdQ0pPCkmp1iUJC3c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wV6vPCNFWGMP+s8Nv9pJJHN51wE1cJjbKRscnKN6oRKpLsesFL87UAJBNkT6DVVEw
         rXk5apxfndDdyRqGZKRT4rPu9R2LENkp+aqTPeNzXKcFQ2fDQ7G+vpWCQCGrpblD9E
         aSEoiV3p4mTX55WrBw+cUojIG2vbgzwQPxaaiU9Y=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Takashi Iwai <tiwai@suse.de>, Imre Deak <imre.deak@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 63/79] ALSA: hda: Fix racy display power access
Date:   Fri, 26 Apr 2019 21:38:22 -0400
Message-Id: <20190427013838.6596-63-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427013838.6596-1-sashal@kernel.org>
References: <20190427013838.6596-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit d7a181da2dfa3190487c446042ba01e07d851c74 ]

snd_hdac_display_power() doesn't handle the concurrent calls carefully
enough, and it may lead to the doubly get_power or put_power calls,
when a runtime PM and an async work get called in racy way.

This patch addresses it by reusing the bus->lock mutex that has been
used for protecting the link state change in ext bus code, so that it
can protect against racy display state changes.  The initialization of
bus->lock was moved from snd_hdac_ext_bus_init() to
snd_hdac_bus_init() as well accordingly.

Testcase: igt/i915_pm_rpm/module-reload #glk-dsi
Reported-by: Chris Wilson <chris@chris-wilson.co.uk>
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Imre Deak <imre.deak@intel.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/hda/ext/hdac_ext_bus.c | 1 -
 sound/hda/hdac_bus.c         | 1 +
 sound/hda/hdac_component.c   | 6 +++++-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/hda/ext/hdac_ext_bus.c b/sound/hda/ext/hdac_ext_bus.c
index 9c37d9af3023..ec7715c6b0c0 100644
--- a/sound/hda/ext/hdac_ext_bus.c
+++ b/sound/hda/ext/hdac_ext_bus.c
@@ -107,7 +107,6 @@ int snd_hdac_ext_bus_init(struct hdac_bus *bus, struct device *dev,
 	INIT_LIST_HEAD(&bus->hlink_list);
 	bus->idx = idx++;
 
-	mutex_init(&bus->lock);
 	bus->cmd_dma_state = true;
 
 	return 0;
diff --git a/sound/hda/hdac_bus.c b/sound/hda/hdac_bus.c
index 012305177f68..ad8eee08013f 100644
--- a/sound/hda/hdac_bus.c
+++ b/sound/hda/hdac_bus.c
@@ -38,6 +38,7 @@ int snd_hdac_bus_init(struct hdac_bus *bus, struct device *dev,
 	INIT_WORK(&bus->unsol_work, snd_hdac_bus_process_unsol_events);
 	spin_lock_init(&bus->reg_lock);
 	mutex_init(&bus->cmd_mutex);
+	mutex_init(&bus->lock);
 	bus->irq = -1;
 	return 0;
 }
diff --git a/sound/hda/hdac_component.c b/sound/hda/hdac_component.c
index a6d37b9d6413..6b5caee61c6e 100644
--- a/sound/hda/hdac_component.c
+++ b/sound/hda/hdac_component.c
@@ -69,13 +69,15 @@ void snd_hdac_display_power(struct hdac_bus *bus, unsigned int idx, bool enable)
 
 	dev_dbg(bus->dev, "display power %s\n",
 		enable ? "enable" : "disable");
+
+	mutex_lock(&bus->lock);
 	if (enable)
 		set_bit(idx, &bus->display_power_status);
 	else
 		clear_bit(idx, &bus->display_power_status);
 
 	if (!acomp || !acomp->ops)
-		return;
+		goto unlock;
 
 	if (bus->display_power_status) {
 		if (!bus->display_power_active) {
@@ -92,6 +94,8 @@ void snd_hdac_display_power(struct hdac_bus *bus, unsigned int idx, bool enable)
 			bus->display_power_active = false;
 		}
 	}
+ unlock:
+	mutex_unlock(&bus->lock);
 }
 EXPORT_SYMBOL_GPL(snd_hdac_display_power);
 
-- 
2.19.1

