Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0506EC606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3504216E3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562599165;
	bh=aiHFcutqADxsW0lhptmbCIUr07Pjksms/jkxR8W7sak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VhluMm9LaaIOzMSn3dumEHOaVz2jQ8efFRq/lRiLJrSswY9/F1hZgQanXIsxkyash
	 8WJzScLq9ou/GGUbnublaK1xjI+/dqtBim3rWlATEBXd9b3b72SAc36EdyIKLos60T
	 VcjnKpfkv1s+xiU1xmBEhu16No37f6ycFogjhO/w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733237AbfGHPTY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:19:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:43670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733214AbfGHPTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:19:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D2602166E;
        Mon,  8 Jul 2019 15:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562599162;
        bh=aiHFcutqADxsW0lhptmbCIUr07Pjksms/jkxR8W7sak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TcHz7w5A09ExJ4PgoyA2Lme5CNLWKF3IzJE5MmX1xQ3vLe4v7ftkOHd++IaMxI1O8
         QgB7/2Ul2DKz5VHayKiXsx/cYMYmCbBjwbROxXpE0wvJVQ0siaL4cg0jJE8dqsjb/5
         J5rQvR7X0WeVfxNO78j2IEV3P1/Y3W8vSloeBdcc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jaesoo Lee <jalee@purestorage.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 025/102] nvme: Fix u32 overflow in the number of namespace list calculation
Date:   Mon,  8 Jul 2019 17:12:18 +0200
Message-Id: <20190708150527.554182272@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150525.973820964@linuxfoundation.org>
References: <20190708150525.973820964@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit c8e8c77b3bdbade6e26e8e76595f141ede12b692 ]

The Number of Namespaces (nn) field in the identify controller data structure is
defined as u32 and the maximum allowed value in NVMe specification is
0xFFFFFFFEUL. This change fixes the possible overflow of the DIV_ROUND_UP()
operation used in nvme_scan_ns_list() by casting the nn to u64.

Signed-off-by: Jaesoo Lee <jalee@purestorage.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 979c6ecc6446..8705bfe7bb73 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1765,7 +1765,8 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl, unsigned nn)
 {
 	struct nvme_ns *ns;
 	__le32 *ns_list;
-	unsigned i, j, nsid, prev = 0, num_lists = DIV_ROUND_UP(nn, 1024);
+	unsigned i, j, nsid, prev = 0;
+	unsigned num_lists = DIV_ROUND_UP_ULL((u64)nn, 1024);
 	int ret = 0;
 
 	ns_list = kzalloc(0x1000, GFP_KERNEL);
-- 
2.20.1



