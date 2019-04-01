Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01ADC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8100C2070B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139918;
	bh=V83P3xaaPhUFAHEJo4n9O8+YNL3ZqeM/j2l7jb08j9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iW2xzh1QZqCLBNcBLSuIxGyAS0bozmuPSbrZoeJxFQB77AHX3ldG5om1G0bBBS3yZ
	 GHiQ4CfYlykzVDsNTEeni6nFyHot154iZxp4kchiDegG232tywmjCDB3U8wPPTD3OD
	 5YSo8W7LNU7T8gULKpd3nNHJz1h4dgzKcUuEXSmw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387420AbfDARb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:31:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:39626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387413AbfDARby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:31:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A832420856;
        Mon,  1 Apr 2019 17:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139914;
        bh=V83P3xaaPhUFAHEJo4n9O8+YNL3ZqeM/j2l7jb08j9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HWrzSwS6HN0ugxglOR7uUG6vg85NpJtC/ulKEI6Q0jzE76tCCr3ZGqvNDKpHELNHP
         OyNM+wfpMNvm6F4GBD0avtIdVnsWWiHLbmsyFOS/aGcqOBmwd/bG6MIrA7FnUpqiIr
         Rnrx9XQbfDZebQ1OEfMBExPdihx1xEmCccZmJrqM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Stultz <john.stultz@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 052/131] Revert "mmc: block: dont use parameter prefix if built as module"
Date:   Mon,  1 Apr 2019 19:02:02 +0200
Message-Id: <20190401170056.654405226@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit a5ebb87db84392edfd3142c3a6a78431d820a789 ]

This reverts commit 829b6962f7e3cfc06f7c5c26269fd47ad48cf503.

Revert this change as it causes a sysfs path to change and therefore
introduces and ABI regression. More precisely Android's vold is not being
able to access /sys/module/mmcblk/parameters/perdev_minors any more, since
the path becomes changed to: "/sys/module/mmc_block/..."

Fixes: 829b6962f7e3 ("mmc: block: don't use parameter prefix if built as
module")
Reported-by: John Stultz <john.stultz@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/card/block.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index c15b879c3070..f600bdcaf5b4 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -47,13 +47,10 @@
 #include "queue.h"
 
 MODULE_ALIAS("mmc:block");
-
-#ifdef KERNEL
 #ifdef MODULE_PARAM_PREFIX
 #undef MODULE_PARAM_PREFIX
 #endif
 #define MODULE_PARAM_PREFIX "mmcblk."
-#endif
 
 #define INAND_CMD38_ARG_EXT_CSD  113
 #define INAND_CMD38_ARG_ERASE    0x00
-- 
2.19.1



