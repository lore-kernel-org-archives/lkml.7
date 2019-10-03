Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85044C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 10:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6222621D71
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 10:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729065AbfJCKOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 06:14:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:44174 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728356AbfJCKOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 06:14:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E2359ABC4;
        Thu,  3 Oct 2019 10:14:35 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     Michal Suchanek <msuchanek@suse.de>, Vinod Koul <vkoul@kernel.org>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v2 2/2] soundwire: depend on ACPI || OF
Date:   Thu,  3 Oct 2019 12:13:55 +0200
Message-Id: <0b89b4ea16a93f523105c81a2f718b0cd7ec66f2.1570097621.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191002081717.GA4015@kitsune.suse.cz>
References: <20191002081717.GA4015@kitsune.suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now devicetree is supported for probing soundwire as well.

On platforms built with !ACPI !OF (ie s390x) the device still cannot be
probed and gives a build warning.

Cc: stable@vger.kernel.org
Fixes: a2e484585ad3 ("soundwire: core: add device tree support for slave devices")
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 drivers/soundwire/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soundwire/Kconfig b/drivers/soundwire/Kconfig
index c73bfbaa2659..c8c80df090d1 100644
--- a/drivers/soundwire/Kconfig
+++ b/drivers/soundwire/Kconfig
@@ -5,7 +5,7 @@
 
 menuconfig SOUNDWIRE
 	tristate "SoundWire support"
-	depends on ACPI
+	depends on ACPI || OF
 	help
 	  SoundWire is a 2-Pin interface with data and clock line ratified
 	  by the MIPI Alliance. SoundWire is used for transporting data
-- 
2.23.0

