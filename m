Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0B2C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 04:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9704E2084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 04:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfKKE4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 23:56:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:48606 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726768AbfKKE4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 23:56:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E3D15B18C;
        Mon, 11 Nov 2019 04:56:16 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Lee Jones <lee.jones@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH] base: soc: Export soc_device_to_device() helper
Date:   Mon, 11 Nov 2019 05:56:09 +0100
Message-Id: <20191111045609.7026-1-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191103013645.9856-3-afaerber@suse.de>
References: <20191103013645.9856-3-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use of soc_device_to_device() in driver modules causes a build failure.
Given that the helper is nicely documented in include/linux/sys_soc.h,
let's export it as GPL symbol.

struct soc_device is local to soc.c, so it can't be inlined into the
header or into driver code.

This still handles only the case that CONFIG_SOC_BUS is enabled.
Same as commit da65a1589dacc7ec44ea0557a14d70a39d991f32 ("base: soc:
Provide a dummy implementation of soc_device_match()") we'd need to
provide a dummy inline implementation to cope with COMPILE_TEST, too.

Reported-by: kbuild test robot <lkp@intel.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 drivers/base/soc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/soc.c b/drivers/base/soc.c
index 4af11a423475..72848587cd51 100644
--- a/drivers/base/soc.c
+++ b/drivers/base/soc.c
@@ -41,6 +41,7 @@ struct device *soc_device_to_device(struct soc_device *soc_dev)
 {
 	return &soc_dev->dev;
 }
+EXPORT_SYMBOL_GPL(soc_device_to_device);
 
 static umode_t soc_attribute_mode(struct kobject *kobj,
 				struct attribute *attr,
-- 
2.16.4

