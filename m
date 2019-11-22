Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2DBC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C500220707
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574403280;
	bh=v2yq6QuBQJWjhwP+bGg0C5drFr5wc3WHgW3vI2tG9V8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Bn7q7e9zoam/KdVAGYZuyih+bhENDHl1+UFafMNFFfnxhdSX6+M3R1celBYZe735d
	 4VXrO4ETD4aSuJy3bN32TRWwZeYy8mqEjmOleVlbgQmUQi87OlEAqlopAy5SzQEETc
	 gupxThVmGqMMoJe6Od/eF92eN+CAgGBED2aOyBrg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729776AbfKVGOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:14:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:51920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729187AbfKVGOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 01:14:20 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE58A20707;
        Fri, 22 Nov 2019 06:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574403259;
        bh=v2yq6QuBQJWjhwP+bGg0C5drFr5wc3WHgW3vI2tG9V8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i9G61iSVM2qLV2TX+OVljOYZomPg/5KVEbfGJZJQ2e8zbSqvS7tZl2kl8ilkjVBhr
         pXIi+CqI3bk+t65h/jR2rr/ESmARhHA4ptOo/dhb5NJg0yYzuvzmTma4P7utWrVgzV
         L1rPXhOslnOQkvE2puOOhidLaJZ1bvdHJaMO97Io=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-mtd@lists.infradead.org
Subject: [PATCH AUTOSEL 4.4 68/68] mtd: Remove a debug trace in mtdpart.c
Date:   Fri, 22 Nov 2019 01:13:01 -0500
Message-Id: <20191122061301.4947-67-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122061301.4947-1-sashal@kernel.org>
References: <20191122061301.4947-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boris Brezillon <bbrezillon@kernel.org>

[ Upstream commit bda2ab56356b9acdfab150f31c4bac9846253092 ]

Commit 2b6f0090a333 ("mtd: Check add_mtd_device() ret code") contained
a leftover of the debug session that led to this bug fix. Remove this
pr_info().

Fixes: 2b6f0090a333 ("mtd: Check add_mtd_device() ret code")
Signed-off-by: Boris Brezillon <bbrezillon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/mtdpart.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
index 9b48be05cd1af..59772510452a5 100644
--- a/drivers/mtd/mtdpart.c
+++ b/drivers/mtd/mtdpart.c
@@ -624,7 +624,6 @@ int mtd_add_partition(struct mtd_info *master, const char *name,
 	mutex_unlock(&mtd_partitions_mutex);
 
 	free_partition(new);
-	pr_info("%s:%i\n", __func__, __LINE__);
 
 	return ret;
 }
-- 
2.20.1

