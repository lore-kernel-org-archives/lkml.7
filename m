Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897C2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58A5A2083D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257144;
	bh=UXakowKrTeZMLJqm00+uhnEhlC/foeKn5H4qCals45E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AAjE40SKF/EnHLtYSLvlG4dj6plZcfYIIAUnsJq/woOfUtNLEeH9IvAqWq6Qu6WzO
	 Bb/BGEWOTsHFGPJOO7uqZGIx5TUnXI9cNGqKzAIu2kTcVVT64dXF0K1wbItOcfinpG
	 MO+CyvOfuxG2eTy3ss+in1mOdGi1Qngl5I2anZHA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390576AbfCVMTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:19:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:57852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389985AbfCVMSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:18:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A1432083D;
        Fri, 22 Mar 2019 12:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257132;
        bh=UXakowKrTeZMLJqm00+uhnEhlC/foeKn5H4qCals45E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NcHruGKPmRYZfUQ1QMiTU1BXnq7JY3QLwo5ouw2MZ1gkct7+DDu6DV0j1LUprB8HI
         uJJvPlP0vc3OXf7aK8A1uG4Y4ocrkMnzh/ZG2OYfgbNRmvlbW0lYe5ymHzG9i2poMr
         LD//ja3JKp8G/gKiXnjU7u1KoETXMmyq433YsWiY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 5.0 142/238] clk: samsung: exynos5: Fix kfree() of const memory on setting driver_override
Date:   Fri, 22 Mar 2019 12:16:01 +0100
Message-Id: <20190322111306.774157247@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzk@kernel.org>

commit 785c9f411eb2d9a6076d3511c631587d5e676bf3 upstream.

Platform driver driver_override field should not be initialized from
const memory because the core later kfree() it.  If driver_override is
manually set later through sysfs, kfree() of old value leads to:

    $ echo "new_value" > /sys/bus/platform/drivers/.../driver_override

    kernel BUG at ../mm/slub.c:3960!
    Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
    ...
    (kfree) from [<c058e8c0>] (platform_set_driver_override+0x84/0xac)
    (platform_set_driver_override) from [<c058e908>] (driver_override_store+0x20/0x34)
    (driver_override_store) from [<c031f778>] (kernfs_fop_write+0x100/0x1dc)
    (kernfs_fop_write) from [<c0296de8>] (__vfs_write+0x2c/0x17c)
    (__vfs_write) from [<c02970c4>] (vfs_write+0xa4/0x188)
    (vfs_write) from [<c02972e8>] (ksys_write+0x4c/0xac)
    (ksys_write) from [<c0101000>] (ret_fast_syscall+0x0/0x28)

The clk-exynos5-subcmu driver uses override only for the purpose of
creating meaningful names for children devices (matching names of power
domains, e.g. DISP, MFC).  The driver_override was not developed for
this purpose so just switch to default names of devices to fix the
issue.

Fixes: b06a532bf1fa ("clk: samsung: Add Exynos5 sub-CMU clock driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/samsung/clk-exynos5-subcmu.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/clk/samsung/clk-exynos5-subcmu.c
+++ b/drivers/clk/samsung/clk-exynos5-subcmu.c
@@ -138,12 +138,11 @@ static int __init exynos5_clk_register_s
 	struct platform_device *pdev;
 	int ret;
 
-	pdev = platform_device_alloc(info->pd_name, -1);
+	pdev = platform_device_alloc("exynos5-subcmu", PLATFORM_DEVID_AUTO);
 	if (!pdev)
 		return -ENOMEM;
 
 	pdev->dev.parent = parent;
-	pdev->driver_override = "exynos5-subcmu";
 	platform_set_drvdata(pdev, (void *)info);
 	of_genpd_add_device(&genpdspec, &pdev->dev);
 	ret = platform_device_add(pdev);


