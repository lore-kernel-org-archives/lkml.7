Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2C1CA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 13:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E75B920867
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 13:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572096787;
	bh=uV4JoVeDz4JFp0Ys7mmFR9mjnD6/HF9lsWxZg24i01Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eR/cJSKOCx0UVFFPm9WHxaCH2x5j4TYRI4gJvrwStn+Gev2Uk6TUsz/btgjF7qUvf
	 H/Zvs4v8Tl1jlyqk5fWQCLUPbw4uPokjaX2xWSJ9SDhUpMsRnqA+LkS+Owg8ZZG4k6
	 a8KsVqzEi54uDnjgqC59CuC7R4ObFOh3+ycDiofk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbfJZNdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 09:33:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:39890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727244AbfJZNSN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 09:18:13 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DA6D222C4;
        Sat, 26 Oct 2019 13:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572095893;
        bh=uV4JoVeDz4JFp0Ys7mmFR9mjnD6/HF9lsWxZg24i01Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yuSxwXNApaTDQf/aaOK015jxfJZHHZ4JhaDqwf7ZK83tEA/gusYzFqo0fEIPZ3YLL
         Tz5I/jC5GhJ/NGv07mIoON8+GNgZmCZER4u+3Z4bhk73T22vApUlUwLhJWuoPSSqk3
         JwPKqVZTNgGyb6h5ev8t0pFQopsGORUPkb7AlwsE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Max Gurtovoy <maxg@mellanox.com>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.3 75/99] nvme-tcp: fix possible leakage during error flow
Date:   Sat, 26 Oct 2019 09:15:36 -0400
Message-Id: <20191026131600.2507-75-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191026131600.2507-1-sashal@kernel.org>
References: <20191026131600.2507-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Gurtovoy <maxg@mellanox.com>

[ Upstream commit 28a4cac48c7e897a0b4e7d79a53a8e4fe40337ae ]

During nvme_tcp_setup_cmd_pdu error flow, one must call nvme_cleanup_cmd
since it's symmetric to nvme_setup_cmd.

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/tcp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 606b13d35d16f..988a426169036 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2093,6 +2093,7 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
 
 	ret = nvme_tcp_map_data(queue, rq);
 	if (unlikely(ret)) {
+		nvme_cleanup_cmd(rq);
 		dev_err(queue->ctrl->ctrl.device,
 			"Failed to map data (%d)\n", ret);
 		return ret;
-- 
2.20.1

