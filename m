Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 137AFC3A5AB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 398E4218AC
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389562AbfIEMyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 08:54:51 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52392 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730864AbfIEMyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 08:54:49 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3957387A09CF12788B44;
        Thu,  5 Sep 2019 20:54:43 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Thu, 5 Sep 2019 20:54:36 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <davem@davemloft.net>, <mareklindner@neomailbox.ch>,
        <mchehab@kernel.org>, <leon@kernel.org>
CC:     <dledford@redhat.com>, <sakari.ailus@linux.intel.com>,
        <a@unstable.cc>, <sw@simonwunderlich.de>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <zhongjiang@huawei.com>
Subject: [PATCH 2/3] media: v4l2: Use FIELD_SIZEOF directly
Date:   Thu, 5 Sep 2019 20:51:35 +0800
Message-ID: <1567687896-19996-3-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1567687896-19996-1-git-send-email-zhongjiang@huawei.com>
References: <1567687896-19996-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's more clear  to use FIELD_SIZEOF instead of its implementation.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/media/v4l2-core/v4l2-ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 51b9127..eebea91 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -2637,7 +2637,7 @@ struct v4l2_ioctl_info {
 /* Zero struct from after the field to the end */
 #define INFO_FL_CLEAR(v4l2_struct, field)			\
 	((offsetof(struct v4l2_struct, field) +			\
-	  sizeof(((struct v4l2_struct *)0)->field)) << 16)
+	  FIELD_SIZEOF(struct v4l2_struct, field)) << 16)
 #define INFO_FL_CLEAR_MASK	(_IOC_SIZEMASK << 16)
 
 #define DEFINE_V4L_STUB_FUNC(_vidioc)				\
-- 
1.7.12.4

