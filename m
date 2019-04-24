Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75CAC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96D53218FD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556116582;
	bh=c2SzM4ouugjjRHit0TX3VSCrw2FWnHJtGKYLg3TbwQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZScsug69PNBcMI91J1iDPxtY3K9RLDDvMRKVLTy/Tzrw3bq52dwzbTJM48SlaQ3bB
	 gnTk8zPbemOk0vNNZhVemh0C6PmGE9gKmnsPxyK04ItN0o45VopLjU2cQ9VKPlLgbL
	 2C++0lFhbbVvb1HBSBxSAqvxgHd+MdlZjhGtRGdg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731563AbfDXOgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:36:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:39926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731034AbfDXOgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:36:12 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F060218FD;
        Wed, 24 Apr 2019 14:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556116572;
        bh=c2SzM4ouugjjRHit0TX3VSCrw2FWnHJtGKYLg3TbwQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mlpPTil+Hh/iGdCJIRZUHVePHSAf83laWbhQiUu7qldnhMTelnIrr9ZVk6wVBXqm1
         yx+dKWywPsdrWO/fG9pp+qhjjyaNvVZavjUW3nSWJy9ZYcJ8KerHh0wAL/RatPqKca
         I++UMXApNLL+nH48I6ykVEEzsdx1VtQ0V7DhRNfw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     John Pittman <jpittman@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 57/66] null_blk: prevent crash from bad home_node value
Date:   Wed, 24 Apr 2019 10:33:31 -0400
Message-Id: <20190424143341.27665-57-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424143341.27665-1-sashal@kernel.org>
References: <20190424143341.27665-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Pittman <jpittman@redhat.com>

[ Upstream commit 7ff684a683d777c4956fce93e60accbab2bd7696 ]

At module load, if the selected home_node value is greater than
the available numa nodes, the system will crash in
__alloc_pages_nodemask() due to a bad paging request.  Prevent this
user error crash by detecting the bad value, logging an error, and
setting g_home_node back to the default of NUMA_NO_NODE.

Signed-off-by: John Pittman <jpittman@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/block/null_blk_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 62c9654b9ce8..fd7a9be54595 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1749,6 +1749,11 @@ static int __init null_init(void)
 		return -EINVAL;
 	}
 
+	if (g_home_node != NUMA_NO_NODE && g_home_node >= nr_online_nodes) {
+		pr_err("null_blk: invalid home_node value\n");
+		g_home_node = NUMA_NO_NODE;
+	}
+
 	if (g_queue_mode == NULL_Q_RQ) {
 		pr_err("null_blk: legacy IO path no longer available\n");
 		return -EINVAL;
-- 
2.19.1

