Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDC2C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD372206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563510912;
	bh=CH3O2LPFoEMwAWzghnExfL2XH60fUknYpeXbotU+tPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=INv+DZ/8DtKnO23KRt0VVXbEu/PYVeZ7x6DqZxNcauXzeuuGy7lRzl+yzEOp0AEzx
	 e7qyMwJ9OgIgV0oQwaInmN4klUCFfbiNeKVmufzTFusyAb+e2dTlU5Q45iHMFxAQj7
	 WECZ/egQmSwl0tTxgoxFeIEa0WoNtft5AbiTQSZs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729549AbfGSEBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 00:01:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:33192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729435AbfGSEB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 00:01:27 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91B0B21852;
        Fri, 19 Jul 2019 04:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563508886;
        bh=CH3O2LPFoEMwAWzghnExfL2XH60fUknYpeXbotU+tPI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vF3iHJ8XAu869BlR4jRn/iu6KYViP56hR6tmSyI+ZYGYZmbC656AyOVCtW4Al/xW/
         sV8hM0j22Xej1i0/1VPdw80U6DClRPYBhmAdR5G1+mwvIdhrdLQ2P75ualQAYQXOSe
         VOWxCi6+1QcWG8+xfOED3kRbMd6Q+yok35E2KsN8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mikhail Skorzhinskii <mskorzhinskiy@solarflare.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>,
        Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.2 137/171] nvme-tcp: don't use sendpage for SLAB pages
Date:   Thu, 18 Jul 2019 23:56:08 -0400
Message-Id: <20190719035643.14300-137-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719035643.14300-1-sashal@kernel.org>
References: <20190719035643.14300-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikhail Skorzhinskii <mskorzhinskiy@solarflare.com>

[ Upstream commit 37c15219599f7a4baa73f6e3432afc69ba7cc530 ]

According to commit a10674bf2406 ("tcp: detecting the misuse of
.sendpage for Slab objects") and previous discussion, tcp_sendpage
should not be used for pages that is managed by SLAB, as SLAB is not
taking page reference counters into consideration.

Signed-off-by: Mikhail Skorzhinskii <mskorzhinskiy@solarflare.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/tcp.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 08a2501b9357..606b13d35d16 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -860,7 +860,14 @@ static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
 		else
 			flags |= MSG_MORE;
 
-		ret = kernel_sendpage(queue->sock, page, offset, len, flags);
+		/* can't zcopy slab pages */
+		if (unlikely(PageSlab(page))) {
+			ret = sock_no_sendpage(queue->sock, page, offset, len,
+					flags);
+		} else {
+			ret = kernel_sendpage(queue->sock, page, offset, len,
+					flags);
+		}
 		if (ret <= 0)
 			return ret;
 
-- 
2.20.1

