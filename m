Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5ABEC282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9593520678
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578430931;
	bh=unLuJrYUMC8VjJJgbWqG0S69A83tXxMtHCMPO8y6DcM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m7RA0memcgBdAVbCGsVL3hzjOb+93l8FPOjO93XsGEs1ZdLc5kvnIrIF8neu53vYi
	 CNGDfvulnsgOsy+se7OsMRUb+lY9TqA247jT7gAUw5DrLPMbxULWmwnXBCwbYi5th1
	 MMA38OUPXDoITuh+MMv9+Q+wvFLLSMRawU3Yg9Zk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbgAGVCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:02:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:40866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728354AbgAGVCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:02:06 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CB75214D8;
        Tue,  7 Jan 2020 21:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578430925;
        bh=unLuJrYUMC8VjJJgbWqG0S69A83tXxMtHCMPO8y6DcM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CRUZWN9Gz+ucI4+v2s8/YKcC+BUxcjTg0shm6WyOwbNXoUp0tyChMWS2Lz5g0xsLB
         YoBkgxizBZoog5GzVXBL9ZIndp41e2MQtC9hPuZzR1UtX34OqaJsySOnha2ynWDUzP
         IAPoWdBGB6hs7MZEVrUJLVhhJA0+VxdHG8hGr0XY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Subject: [PATCH 5.4 152/191] watchdog: tqmx86_wdt: Fix build error
Date:   Tue,  7 Jan 2020 21:54:32 +0100
Message-Id: <20200107205341.102689315@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205332.984228665@linuxfoundation.org>
References: <20200107205332.984228665@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

commit 9a6c274ac1c4346f5384f2290caeb42dc674c471 upstream.

If TQMX86_WDT is y and WATCHDOG_CORE is m, building fails:

drivers/watchdog/tqmx86_wdt.o: In function `tqmx86_wdt_probe':
tqmx86_wdt.c:(.text+0x46e): undefined reference to `watchdog_init_timeout'
tqmx86_wdt.c:(.text+0x4e0): undefined reference to `devm_watchdog_register_device'

Select WATCHDOG_CORE to fix this.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: e3c21e088f89 ("watchdog: tqmx86: Add watchdog driver for the IO controller")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20191206124259.25880-1-yuehaibing@huawei.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/watchdog/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1444,6 +1444,7 @@ config SMSC37B787_WDT
 config TQMX86_WDT
 	tristate "TQ-Systems TQMX86 Watchdog Timer"
 	depends on X86
+	select WATCHDOG_CORE
 	help
 	This is the driver for the hardware watchdog timer in the TQMX86 IO
 	controller found on some of their ComExpress Modules.


