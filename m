Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D11CC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 03:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CDAA20868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 03:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfDPD4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 23:56:14 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34560 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726208AbfDPD4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 23:56:14 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A9AA11633A79D2CA0A49;
        Tue, 16 Apr 2019 11:56:11 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Tue, 16 Apr 2019 11:56:09 +0800
From:   Mao Wenan <maowenan@huawei.com>
To:     <boris.ostrovsky@oracle.com>, <jgross@suse.com>,
        <sstabellini@kernel.org>
CC:     <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH] xenbus: drop useless LIST_HEAD in xenbus_write_watch() and xenbus_file_write()
Date:   Tue, 16 Apr 2019 12:06:51 +0800
Message-ID: <20190416040651.186468-1-maowenan@huawei.com>
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

Drop LIST_HEAD where the variable it declares is never used.

The declarations were introduced with the file, but the declared
variables were not used.

Fixes: 1107ba885e469("xen: add xenfs to allow usermode <-> Xen interaction")
Signed-off-by: Mao Wenan <maowenan@huawei.com>
---
 drivers/xen/xenbus/xenbus_dev_frontend.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_dev_frontend.c b/drivers/xen/xenbus/xenbus_dev_frontend.c
index 0782ff3..faf452d 100644
--- a/drivers/xen/xenbus/xenbus_dev_frontend.c
+++ b/drivers/xen/xenbus/xenbus_dev_frontend.c
@@ -465,7 +465,6 @@ static int xenbus_write_watch(unsigned msg_type, struct xenbus_file_priv *u)
 	struct watch_adapter *watch;
 	char *path, *token;
 	int err, rc;
-	LIST_HEAD(staging_q);
 
 	path = u->u.buffer + sizeof(u->u.msg);
 	token = memchr(path, 0, u->u.msg.len);
@@ -523,7 +522,6 @@ static ssize_t xenbus_file_write(struct file *filp,
 	uint32_t msg_type;
 	int rc = len;
 	int ret;
-	LIST_HEAD(staging_q);
 
 	/*
 	 * We're expecting usermode to be writing properly formed
-- 
2.7.4

