Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C688BC48BE3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AD6B214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561053701;
	bh=AFn5wCoQqPg66QmVhEFeukUE3xE1xCkBNypIGfPx8FE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2q5HW8PjQqN5LcpxNYzVt4DNM2TANPwjAUd7xkmC/RtXaiXhPMO9WzX39PdQBUAad
	 b0XLrd3sj62dKYa9GAd4/xTOuSOl+jgWqY1MVfjnhqwR5g6c8pvpOM9rYoN2I0XM7s
	 D1AU0T/0RNZUkmBrsslrXSBTOvp66qAE/iwwQJIQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfFTSBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:01:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:51398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727272AbfFTSBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:01:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FE65214AF;
        Thu, 20 Jun 2019 18:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561053696;
        bh=AFn5wCoQqPg66QmVhEFeukUE3xE1xCkBNypIGfPx8FE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U98VEMrF6B6sxNsbzlpOkgE8DTHwY2pv9DMxTWYo9sDLwNIil964BTZcuIE1KF1l2
         zViIyBVA//2cE657xdRj6hMVr7YfQ5SfTYByeA2NGxbLlPWneiGC9WZoOujmik45Ze
         etSXp3Uy8LUXqKEJGOIXe5QUsl3rjG7i0emnWVko=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Varun Prakash <varun@chelsio.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 80/84] scsi: libcxgbi: add a check for NULL pointer in cxgbi_check_route()
Date:   Thu, 20 Jun 2019 19:57:17 +0200
Message-Id: <20190620174349.020609384@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174337.538228162@linuxfoundation.org>
References: <20190620174337.538228162@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit cc555759117e8349088e0c5d19f2f2a500bafdbd ]

ip_dev_find() can return NULL so add a check for NULL pointer.

Signed-off-by: Varun Prakash <varun@chelsio.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/cxgbi/libcxgbi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/scsi/cxgbi/libcxgbi.c b/drivers/scsi/cxgbi/libcxgbi.c
index f3bb7af4e984..5eaf14c15590 100644
--- a/drivers/scsi/cxgbi/libcxgbi.c
+++ b/drivers/scsi/cxgbi/libcxgbi.c
@@ -634,6 +634,10 @@ static struct cxgbi_sock *cxgbi_check_route(struct sockaddr *dst_addr)
 
 	if (ndev->flags & IFF_LOOPBACK) {
 		ndev = ip_dev_find(&init_net, daddr->sin_addr.s_addr);
+		if (!ndev) {
+			err = -ENETUNREACH;
+			goto rel_neigh;
+		}
 		mtu = ndev->mtu;
 		pr_info("rt dev %s, loopback -> %s, mtu %u.\n",
 			n->dev->name, ndev->name, mtu);
-- 
2.20.1



