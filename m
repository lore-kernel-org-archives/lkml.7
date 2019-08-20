Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC37C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 12:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA35A22CF7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 12:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730025AbfHTMih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 08:38:37 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:47074 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729383AbfHTMih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 08:38:37 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C1A3D5E0898FACBBEEA4;
        Tue, 20 Aug 2019 20:38:34 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Tue, 20 Aug 2019 20:38:33 +0800
From:   Yunsheng Lin <linyunsheng@huawei.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>
CC:     <kvm@vger.kernel.org>, <virtualization@lists.linux-foundation.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] vhost: Remove unnecessary variable
Date:   Tue, 20 Aug 2019 20:36:32 +0800
Message-ID: <1566304592-233922-1-git-send-email-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is unnecessary to use ret variable to return the error
code, just return the error code directly.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 drivers/vhost/vhost.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 0536f85..1ac9de2 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -203,7 +203,6 @@ EXPORT_SYMBOL_GPL(vhost_poll_init);
 int vhost_poll_start(struct vhost_poll *poll, struct file *file)
 {
 	__poll_t mask;
-	int ret = 0;
 
 	if (poll->wqh)
 		return 0;
@@ -213,10 +212,10 @@ int vhost_poll_start(struct vhost_poll *poll, struct file *file)
 		vhost_poll_wakeup(&poll->wait, 0, 0, poll_to_key(mask));
 	if (mask & EPOLLERR) {
 		vhost_poll_stop(poll);
-		ret = -EINVAL;
+		return -EINVAL;
 	}
 
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(vhost_poll_start);
 
-- 
2.8.1

