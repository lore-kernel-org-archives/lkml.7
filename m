Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27951C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E986B21873
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553259822;
	bh=f1YZTv2kLHkJgSOe2t1XnTEayP/3YCzILwazqfkGrXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eJNis9Vq/zCBoSKVG3K1s+Cs1kzopV7vFRPX0xpGyzjiOEoVf9tYHxmW7z39Iwlu7
	 tGKLpEyEehhO5SGUc/IE7eCcNZGV8MZVL7QKnu+vMSKQDHmkdmdJpXKPCF+A3VCcY6
	 qS0UIBzkQn8EYYB75Evc1Kt/36NpWl8iLxbJhB54=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731517AbfCVNDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:03:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:42254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730823AbfCVLkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:40:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA2D721934;
        Fri, 22 Mar 2019 11:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254819;
        bh=f1YZTv2kLHkJgSOe2t1XnTEayP/3YCzILwazqfkGrXE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WPtq83BuX3p6CL3a5z4tGduLQHX/UMjNaYOFSaVoU2xy6KC0LFWhTzHfBJlMAWsPk
         5RMC/uBq2QFoIUq4KlAcv1KGy9RukOcFOAGBUKkIDvKTfd6fg82dGguemVJxiSRmtk
         XzS2ejEnx0alL57fdnz+zcuiPIU8tAisJgXi0K2w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.9 005/118] iio: adc: exynos-adc: Fix NULL pointer exception on unbind
Date:   Fri, 22 Mar 2019 12:14:37 +0100
Message-Id: <20190322111216.354386138@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111215.873964544@linuxfoundation.org>
References: <20190322111215.873964544@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzk@kernel.org>

commit 2ea8bab4dd2a9014e723b28091831fa850b82d83 upstream.

Fix NULL pointer exception on device unbind when device tree does not
contain "has-touchscreen" property.  In such case the input device is
not registered so it should not be unregistered.

    $ echo "12d10000.adc" > /sys/bus/platform/drivers/exynos-adc/unbind

    Unable to handle kernel NULL pointer dereference at virtual address 00000474
    ...
    (input_unregister_device) from [<c0772060>] (exynos_adc_remove+0x20/0x80)
    (exynos_adc_remove) from [<c0587d5c>] (platform_drv_remove+0x20/0x40)
    (platform_drv_remove) from [<c05860f0>] (device_release_driver_internal+0xdc/0x1ac)
    (device_release_driver_internal) from [<c0583ecc>] (unbind_store+0x60/0xd4)
    (unbind_store) from [<c031b89c>] (kernfs_fop_write+0x100/0x1e0)
    (kernfs_fop_write) from [<c029709c>] (__vfs_write+0x2c/0x17c)
    (__vfs_write) from [<c0297374>] (vfs_write+0xa4/0x184)
    (vfs_write) from [<c0297594>] (ksys_write+0x4c/0xac)
    (ksys_write) from [<c0101000>] (ret_fast_syscall+0x0/0x28)

Fixes: 2bb8ad9b44c5 ("iio: exynos-adc: add experimental touchscreen support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/adc/exynos_adc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -916,7 +916,7 @@ static int exynos_adc_remove(struct plat
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct exynos_adc *info = iio_priv(indio_dev);
 
-	if (IS_REACHABLE(CONFIG_INPUT)) {
+	if (IS_REACHABLE(CONFIG_INPUT) && info->input) {
 		free_irq(info->tsirq, info);
 		input_unregister_device(info->input);
 	}


