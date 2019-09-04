Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1A5C3A5A2
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 02:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEA25206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 02:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="bUpB5qhw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aHkwBUfd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbfIDCUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 22:20:49 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:47825 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727065AbfIDCUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 22:20:48 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id DD8344FF;
        Tue,  3 Sep 2019 22:20:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 03 Sep 2019 22:20:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=0OPawNPcXoaz6itJ9OLuJZ+eo+
        4zgp53fsik4iX6Y5A=; b=bUpB5qhwONHVcB/LkxyhBPPs4qTdJBZXSmbrFxSTcJ
        92TXrH1wYZdpRiyTtVwvkeN2/a2T6uKm6Ze5w/QS9G+sZqri/5lWjOnhzTwe2TCD
        TNE72RGJAKufDF0PB/X94IwTcae53qa+fM++DXwP+0bCzRbQw2aoSQ1GTO5EeRQb
        IeLdKmKacwvuNr/bVUaAUrPcyNAxk6FWd54Znxrm+mZZbJxJWPz4TTKlI0EnH8Fl
        txsXwYJehSrzOWHAsTK6dR6DdO8YXzO0NvCislhISfpF6GTlmBVrKmVZ0o6HvZ+T
        oV+LLOF7qWZ0FyowDQEJI/xc0wNJdG6Z9m7Tqz8JN4/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=0OPawNPcXoaz6itJ9
        OLuJZ+eo+4zgp53fsik4iX6Y5A=; b=aHkwBUfdVOz919lRbW3s0C/fAMdKFV0x+
        ZYP7AEM7cT3YuXCYRrLos9Y38ihlmfhzk4PlRWDLbXS0++rzTR+/K9+pUJM5koTy
        Kc2/CmKDDjap69Tnr+QbEJcA+cJne37Gzv/p0VLnrw7j71Z81wyFNoAsbISsfwwM
        92cNKXz+y1QSM6yS5e5/zZBllzINa8gp8kKPiIBIKHbKfX9SzVe+rjyUpEB8xCAO
        Gu/ciU3unWSKrQeBmoCiZWXUUXCtQJdMRxuOTsTrJ1mfVeT/PXQVudFjevT3QYJ8
        +CCeRrmGzKaMkg361tnyHnUc2xEphCHjdUtd3D9K/CSuuWgW0iq8g==
X-ME-Sender: <xms:fR9vXThOywdquuTHqB5WK9u6cRRLdroK8yAz90O8nChsB55IXSnF2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudejgedgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegrjhdr
    ihgurdgruheqnecuffhomhgrihhnpehoiihlrggsshdrohhrghenucfkphepvddtfedrhe
    ejrddvudehrddujeeknecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghj
    rdhiugdrrghunecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:fR9vXYYdpaVaMDvBDQYcEqe0CJQD0Tk-oF7coHtC6EAZDDGORCzPWg>
    <xmx:fR9vXfIr6kfZHrZqcDvsdkQDj8ZjCX2aZNgMKexQM0LMI_OxYZC5Fg>
    <xmx:fR9vXVvztQC8bxljLHw2O96MWiEZ_r-uqKEUJRicw_EPOPKUK6IELA>
    <xmx:fh9vXRVnebMtj_QQWeJhX8aiIv66Y3St9pbVADOY8yxyWnhEyXl0hQ>
Received: from localhost.localdomain (203-57-215-178.dyn.iinet.net.au [203.57.215.178])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4E4F2D6005B;
        Tue,  3 Sep 2019 22:20:42 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-mmc@vger.kernel.org
Cc:     Andrew Jeffery <andrew@aj.id.au>, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, joel@jms.id.au, openbmc@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH v3] mmc: sdhci-of-aspeed: Depend on CONFIG_OF_ADDRESS
Date:   Wed,  4 Sep 2019 11:51:20 +0930
Message-Id: <20190904022120.4174-1-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resolves the following build error reported by the 0-day bot:

    ERROR: "of_platform_device_create" [drivers/mmc/host/sdhci-of-aspeed.ko] undefined!

SPARC does not set CONFIG_OF_ADDRESS so the symbol is missing. Depend on
CONFIG_OF_ADDRESS to ensure the driver is only built for supported
configurations.

Fixes: 2d28dbe042f4 ("mmc: sdhci-of-aspeed: Add support for the ASPEED SD controller")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
v2 was a series of 4 patches, three of which were applied leaving this build
fix to be reworked. The v2 series can be found here:

https://patchwork.ozlabs.org/cover/1156457/

 drivers/mmc/host/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 0f8a230de2f3..3a52f5703286 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -157,7 +157,7 @@ config MMC_SDHCI_OF_ARASAN
 config MMC_SDHCI_OF_ASPEED
 	tristate "SDHCI OF support for the ASPEED SDHCI controller"
 	depends on MMC_SDHCI_PLTFM
-	depends on OF
+	depends on OF && OF_ADDRESS
 	help
 	  This selects the ASPEED Secure Digital Host Controller Interface.
 
-- 
2.20.1

