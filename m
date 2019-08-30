Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5BDC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 18:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 806EA23429
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 18:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbfH3SwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 14:52:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:40818 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727914AbfH3SwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 14:52:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 51E92AC84;
        Fri, 30 Aug 2019 18:52:19 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     Michal Suchanek <msuchanek@suse.de>, Vinod Koul <vkoul@kernel.org>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] soundwire: slave: Fix unused function warning on !ACPI
Date:   Fri, 30 Aug 2019 20:52:12 +0200
Message-Id: <20190830185212.25144-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following warning on !ACPI systems:

drivers/soundwire/slave.c:16:12: warning: ‘sdw_slave_add’ defined but
not used [-Wunused-function]
 static int sdw_slave_add(struct sdw_bus *bus,
            ^~~~~~~~~~~~~

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 drivers/soundwire/slave.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
index f39a5815e25d..34c7e65831d1 100644
--- a/drivers/soundwire/slave.c
+++ b/drivers/soundwire/slave.c
@@ -6,6 +6,7 @@
 #include <linux/soundwire/sdw_type.h>
 #include "bus.h"
 
+#if IS_ENABLED(CONFIG_ACPI)
 static void sdw_slave_release(struct device *dev)
 {
 	struct sdw_slave *slave = dev_to_sdw_dev(dev);
@@ -60,7 +61,6 @@ static int sdw_slave_add(struct sdw_bus *bus,
 	return ret;
 }
 
-#if IS_ENABLED(CONFIG_ACPI)
 /*
  * sdw_acpi_find_slaves() - Find Slave devices in Master ACPI node
  * @bus: SDW bus instance
-- 
2.22.0

