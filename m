Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E7E4CA9EAE
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 02:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A235205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 02:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfJ3CB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 22:01:57 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54430 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726025AbfJ3CB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 22:01:56 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 76DF0634D4CC540C04D3;
        Wed, 30 Oct 2019 10:01:55 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Wed, 30 Oct 2019 10:01:44 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
        <alexander.deucher@amd.com>
CC:     <christian.koenig@amd.com>, <David1.Zhou@amd.com>,
        <airlied@linux.ie>, <daniel@ffwll.ch>, <zhongjiang@huawei.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/amd/display: remove redundant null pointer check before kfree
Date:   Wed, 30 Oct 2019 09:57:53 +0800
Message-ID: <1572400673-42535-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kfree has taken null pointer into account. hence it is safe to remove
the unnecessary check.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c b/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c
index cf6ef38..6f730b5 100644
--- a/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c
+++ b/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c
@@ -174,9 +174,7 @@ static bool hdmi_14_process_transaction(
 			link->ctx,
 			link,
 			&i2c_command);
-
-	if (buff)
-		kfree(buff);
+	kfree(buff);
 
 	return result;
 }
-- 
1.7.12.4

