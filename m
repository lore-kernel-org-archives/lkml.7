Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C109C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F103120850
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255827;
	bh=mF2fcWxnn0QVhDtIqpu18AFUlPH6aM8pssI1pD9IDFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B6BhJpats389VOJ2cYxZWa/Jl52vYUibguYiID7TuvZ33bM+nk2EPQKiYgZvapLIw
	 ZpWr/VySuiC69T671J3SxWnEv9rjwilZN+7CCtRtM3IS9v9GSK7webixq+vygWFD2j
	 cz95kEt+VTmcuclI+eJu0W1c+/8wG4dU1odGcGB4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387610AbfCVL5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:57:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:33468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387595AbfCVL46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:56:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 048F320850;
        Fri, 22 Mar 2019 11:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255817;
        bh=mF2fcWxnn0QVhDtIqpu18AFUlPH6aM8pssI1pD9IDFo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B8MElkHtA5JcGuWsCPjyqRdaiJxEu8CGivT61lSzvwafnu5CfNM/r19avSOHWHkEI
         kUOyv9taSQ3WzR892QowTTo32+gVrF+wSxmC/1y8xJBlqfGZvsEtigQ2WaaHHi2wJq
         YmLRs/m9YbFqB2etL1JFMi3m139VQLBst9PrbhXE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.19 007/280] iio: adc: exynos-adc: Fix NULL pointer exception on unbind
Date:   Fri, 22 Mar 2019 12:12:40 +0100
Message-Id: <20190322111306.745176116@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -915,7 +915,7 @@ static int exynos_adc_remove(struct plat
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct exynos_adc *info = iio_priv(indio_dev);
 
-	if (IS_REACHABLE(CONFIG_INPUT)) {
+	if (IS_REACHABLE(CONFIG_INPUT) && info->input) {
 		free_irq(info->tsirq, info);
 		input_unregister_device(info->input);
 	}


