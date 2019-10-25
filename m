Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F74CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 04:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BB4920867
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 04:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388011AbfJYEfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 00:35:30 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5178 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727103AbfJYEfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 00:35:30 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 11C5A2DF14389737C171;
        Fri, 25 Oct 2019 12:35:26 +0800 (CST)
Received: from huawei.com (10.175.104.225) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Fri, 25 Oct 2019
 12:35:15 +0800
From:   Hewenliang <hewenliang4@huawei.com>
To:     <valentina.manea.m@gmail.com>, <shuah@kernel.org>,
        <gregkh@linuxfoundation.org>, <allison@lohutok.net>,
        <swinslow@gmail.com>, <tglx@linutronix.de>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <linfeilong@huawei.com>, <hewenliang4@huawei.com>
Subject: [PATCH] usbip: tools: fix fd leakage in the function of read_attr_usbip_status
Date:   Fri, 25 Oct 2019 00:35:15 -0400
Message-ID: <20191025043515.20053-1-hewenliang4@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should close the fd before the return of read_attr_usbip_status.

Fixes: 3391ba0e279 ("usbip: tools: Extract generic code to be shared with vudc backend")
Signed-off-by: Hewenliang <hewenliang4@huawei.com>
---
 tools/usb/usbip/libsrc/usbip_host_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/usb/usbip/libsrc/usbip_host_common.c b/tools/usb/usbip/libsrc/usbip_host_common.c
index 2813aa821c82..d1d8ba2a4a40 100644
--- a/tools/usb/usbip/libsrc/usbip_host_common.c
+++ b/tools/usb/usbip/libsrc/usbip_host_common.c
@@ -57,7 +57,7 @@ static int32_t read_attr_usbip_status(struct usbip_usb_device *udev)
 	}
 
 	value = atoi(status);
-
+	close(fd);
 	return value;
 }
 
-- 
2.19.1

