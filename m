Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3D8C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 09:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F42920818
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 09:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbfGQJUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 05:20:08 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:2512 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfGQJUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 05:20:07 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.11]) by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee55d2ee76c0f4-8639c; Wed, 17 Jul 2019 17:16:30 +0800 (CST)
X-RM-TRANSID: 2ee55d2ee76c0f4-8639c
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.105.0.243])
        by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee65d2ee76dcd3-a1b74;
        Wed, 17 Jul 2019 17:16:29 +0800 (CST)
X-RM-TRANSID: 2ee65d2ee76dcd3-a1b74
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     alexander.shishkin@linux.intel.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] stm class: Fix a double free of stm_source_device
Date:   Wed, 17 Jul 2019 17:16:28 +0800
Message-Id: <1563354988-23826-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

put_device will call stm_source_device_release to free
stm_source_device, so remove the kfree.

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 drivers/hwtracing/stm/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
index e55b902..181e7ff 100644
--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -1276,7 +1276,6 @@ int stm_source_register_device(struct device *parent,
 
 err:
 	put_device(&src->dev);
-	kfree(src);
 
 	return err;
 }
-- 
1.9.1



