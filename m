Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2409C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 13:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D66E206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 13:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfDMNec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 09:34:32 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6183 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726992AbfDMNec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 09:34:32 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B43AAD86240EBE1313B7;
        Sat, 13 Apr 2019 21:34:21 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Sat, 13 Apr 2019 21:34:13 +0800
From:   Mao Wenan <maowenan@huawei.com>
To:     <jikos@kernel.org>, <benjamin.tissoires@redhat.com>,
        <maowenan@huawei.com>
CC:     <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] HID: fix compiling error in u2fzero_probe()
Date:   Sat, 13 Apr 2019 21:44:59 +0800
Message-ID: <20190413134459.76045-1-maowenan@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is one compiling error in u2fzero_probe()->u2fzero_init_hwrng(),
this is because HW_RANDOM is not set.

drivers/hid/hid-u2fzero.o: In function `u2fzero_probe':
hid-u2fzero.c:(.text+0xc70): undefined reference to `devm_hwrng_register'

Fixes: 42337b9d4d958("HID: add driver for U2F Zero built-in LED and RNG")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Mao Wenan <maowenan@huawei.com>
---
 drivers/hid/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 4dc1035..76d8206 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -1017,6 +1017,7 @@ config HID_U2FZERO
 	tristate "U2F Zero LED and RNG support"
 	depends on USB_HID
 	depends on LEDS_CLASS
+	depends on HW_RANDOM
 	help
 	  Support for the LED of the U2F Zero device.
 
-- 
2.7.4

