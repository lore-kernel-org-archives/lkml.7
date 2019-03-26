Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24512C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E33F92070B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582456;
	bh=yMjqikRml/K9Wm1OJ7Q/qAmCb/h/vqRPHEw+LizVNtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uc3ZCYEapc6ay+CID3ppty5Gn+HmIqpLhSePia+k1qNAJidok6xnJ2PiVWp1Jdphq
	 sBXrM/opdJp59aaYR46WyuKV5sUDG2JJrc3T5ICez7BkcFgkdjqETH92yxaSw75Lxj
	 C/wCa2UN2uceOMs6i8Vub8XW+YXa/AdJ0JfTTXfU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732662AbfCZGky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:40:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:57408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732632AbfCZGkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:40:47 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FEC92070B;
        Tue, 26 Mar 2019 06:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582447;
        bh=yMjqikRml/K9Wm1OJ7Q/qAmCb/h/vqRPHEw+LizVNtM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j95Z8oQ6tPZlck3qmiEOhDGC0D7gDAicx2MxuOCAnngURfk6tq4wHrM2mECA4j+ch
         CnV79zJV4ioNO3Gfl3a4Ly2Xz3akDqsKPGvJm4UsDbMC49tRRzjwra+GwjCPAL7Ead
         H3FojGAuzb978gypYT9YRja6vjVjlqdI0ZACp4ow=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+f3ce716af730c8f96637@syzkaller.appspotmail.com,
        Myungho Jung <mhjungk@gmail.com>,
        Parav Pandit <parav@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 5.0 42/52] RDMA/cma: Rollback source IP address if failing to acquire device
Date:   Tue, 26 Mar 2019 15:30:29 +0900
Message-Id: <20190326042703.214495584@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042700.963224437@linuxfoundation.org>
References: <20190326042700.963224437@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Myungho Jung <mhjungk@gmail.com>

commit 5fc01fb846bce8fa6d5f95e2625b8ce0f8e86810 upstream.

If cma_acquire_dev_by_src_ip() returns error in addr_handler(), the
device state changes back to RDMA_CM_ADDR_BOUND but the resolved source
IP address is still left. After that, if rdma_destroy_id() is called
after rdma_listen(), the device is freed without removed from
listen_any_list in cma_cancel_operation(). Revert to the previous IP
address if acquiring device fails.

Reported-by: syzbot+f3ce716af730c8f96637@syzkaller.appspotmail.com
Signed-off-by: Myungho Jung <mhjungk@gmail.com>
Reviewed-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/core/cma.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -2966,13 +2966,22 @@ static void addr_handler(int status, str
 {
 	struct rdma_id_private *id_priv = context;
 	struct rdma_cm_event event = {};
+	struct sockaddr *addr;
+	struct sockaddr_storage old_addr;
 
 	mutex_lock(&id_priv->handler_mutex);
 	if (!cma_comp_exch(id_priv, RDMA_CM_ADDR_QUERY,
 			   RDMA_CM_ADDR_RESOLVED))
 		goto out;
 
-	memcpy(cma_src_addr(id_priv), src_addr, rdma_addr_size(src_addr));
+	/*
+	 * Store the previous src address, so that if we fail to acquire
+	 * matching rdma device, old address can be restored back, which helps
+	 * to cancel the cma listen operation correctly.
+	 */
+	addr = cma_src_addr(id_priv);
+	memcpy(&old_addr, addr, rdma_addr_size(addr));
+	memcpy(addr, src_addr, rdma_addr_size(src_addr));
 	if (!status && !id_priv->cma_dev) {
 		status = cma_acquire_dev_by_src_ip(id_priv);
 		if (status)
@@ -2983,6 +2992,8 @@ static void addr_handler(int status, str
 	}
 
 	if (status) {
+		memcpy(addr, &old_addr,
+		       rdma_addr_size((struct sockaddr *)&old_addr));
 		if (!cma_comp_exch(id_priv, RDMA_CM_ADDR_RESOLVED,
 				   RDMA_CM_ADDR_BOUND))
 			goto out;


