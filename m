Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0E9C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 10:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37A7621D81
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 10:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbfJCKOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 06:14:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:44172 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726119AbfJCKOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 06:14:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E28D4AD63;
        Thu,  3 Oct 2019 10:14:35 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     Michal Suchanek <msuchanek@suse.de>, Vinod Koul <vkoul@kernel.org>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v2 1/2] soundwire: depend on ACPI
Date:   Thu,  3 Oct 2019 12:13:54 +0200
Message-Id: <bd685232ea511251eeb9554172f1524eabf9a46e.1570097621.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191002081717.GA4015@kitsune.suse.cz>
References: <20191002081717.GA4015@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device cannot be probed on !ACPI and gives this warning:

drivers/soundwire/slave.c:16:12: warning: ‘sdw_slave_add’ defined but
not used [-Wunused-function]
 static int sdw_slave_add(struct sdw_bus *bus,
            ^~~~~~~~~~~~~

Cc: stable@vger.kernel.org
Fixes: 7c3cd189b86d ("soundwire: Add Master registration")
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 drivers/soundwire/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soundwire/Kconfig b/drivers/soundwire/Kconfig
index f518273cfbe3..c73bfbaa2659 100644
--- a/drivers/soundwire/Kconfig
+++ b/drivers/soundwire/Kconfig
@@ -5,6 +5,7 @@
 
 menuconfig SOUNDWIRE
 	tristate "SoundWire support"
+	depends on ACPI
 	help
 	  SoundWire is a 2-Pin interface with data and clock line ratified
 	  by the MIPI Alliance. SoundWire is used for transporting data
-- 
2.23.0

