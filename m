Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C8EC433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C91F20693
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567947271;
	bh=MdRVR9b2Eiptz3wXw0NrdS9XJAi0ujd7KHcsxe618mg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=agKC5q6UUZEmq1KI5r3RIUsoKyoLGzLz1ggWbg229Y7VMZRFYIq6rM0oWMQWqbM/+
	 v2cFMn4fkVrjgu33DHlNl/+RBNoFbaFpIojLmnfOZ5CEns3cq+By+FqA7yxx40zGlP
	 egoqH9Yw1PP325JV6XsjSkfi9xtbcY7a5D8WyWLE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387808AbfIHMya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 08:54:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:44424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729188AbfIHMwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 08:52:17 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D36821D7E;
        Sun,  8 Sep 2019 12:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567947136;
        bh=MdRVR9b2Eiptz3wXw0NrdS9XJAi0ujd7KHcsxe618mg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VD5IPBCR+hjyykKOJ725cqs6XADTuHIskCzgav+AohePh+nDTo7FQRRnx65wjcIyb
         1EJZ16TlhUOIOUBKTkxUiqzDvfYkFa+jvMbz6QyeKu1AWi79qQF7tUJ8Fh4N7BYzKH
         3kyfw47lrGwR2rCle0L6/SJDVhPtwvW7JDFp3Txs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenwen Wang <wenwen@cs.uga.edu>,
        Leon Romanovsky <leonro@mellanox.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 75/94] infiniband: hfi1: fix a memory leak bug
Date:   Sun,  8 Sep 2019 13:42:11 +0100
Message-Id: <20190908121152.579359427@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190908121150.420989666@linuxfoundation.org>
References: <20190908121150.420989666@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit b08afa064c320e5d85cdc27228426b696c4c8dae ]

In fault_opcodes_read(), 'data' is not deallocated if debugfs_file_get()
fails, leading to a memory leak. To fix this bug, introduce the 'free_data'
label to free 'data' before returning the error.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
Acked-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Link: https://lore.kernel.org/r/1566156571-4335-1-git-send-email-wenwen@cs.uga.edu
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hfi1/fault.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/fault.c b/drivers/infiniband/hw/hfi1/fault.c
index 93613e5def9b7..814324d172950 100644
--- a/drivers/infiniband/hw/hfi1/fault.c
+++ b/drivers/infiniband/hw/hfi1/fault.c
@@ -214,7 +214,7 @@ static ssize_t fault_opcodes_read(struct file *file, char __user *buf,
 		return -ENOMEM;
 	ret = debugfs_file_get(file->f_path.dentry);
 	if (unlikely(ret))
-		return ret;
+		goto free_data;
 	bit = find_first_bit(fault->opcodes, bitsize);
 	while (bit < bitsize) {
 		zero = find_next_zero_bit(fault->opcodes, bitsize, bit);
@@ -232,6 +232,7 @@ static ssize_t fault_opcodes_read(struct file *file, char __user *buf,
 	data[size - 1] = '\n';
 	data[size] = '\0';
 	ret = simple_read_from_buffer(buf, len, pos, data, size);
+free_data:
 	kfree(data);
 	return ret;
 }
-- 
2.20.1



