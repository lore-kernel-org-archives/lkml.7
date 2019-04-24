Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5D5C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A03A21903
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126030;
	bh=aQYTFsvPVpQVWYScdYBqAysuh7QRrMjeiCWXk4nGDzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y3kq6SACzPaG3VWGLsz6a8GZt7e0TkNQJrjjpiKo28YMm+V+9UxqqzA+TUm/EPlMi
	 ysuj2WJB+2eJg0/BOdeyghTaXBaCtj1sgRpnPhYBFC9DPhsKPahE3EvfZDWkGEel1m
	 ueeB/Yf8oPYwbDAKPw8Cl/92BRgQoqLE17KmRVcc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387943AbfDXRNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:13:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:37804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387924AbfDXRNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:13:43 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96B4C21908;
        Wed, 24 Apr 2019 17:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126023;
        bh=aQYTFsvPVpQVWYScdYBqAysuh7QRrMjeiCWXk4nGDzw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cVMN+FztG4H22T0cpgu8aNdIZgahDVZjd9wPngEOPaAFiiBOwwko1iz5a2B93Jn/d
         lUG7qL46I66wttD1OcpcYAO6/TqF2r4bnl04qacZW5h+e9euewWwb/YN4GAhd4opz1
         goJYxDHWIq1L8Sh8itfzP9/u27jwF9J9/ywHa5aE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 065/104] IB/mlx4: Fix race condition between catas error reset and aliasguid flows
Date:   Wed, 24 Apr 2019 19:09:22 +0200
Message-Id: <20190424170904.663532641@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170839.996641496@linuxfoundation.org>
References: <20190424170839.996641496@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 587443e7773e150ae29e643ee8f41a1eed226565 ]

Code review revealed a race condition which could allow the catas error
flow to interrupt the alias guid query post mechanism at random points.
Thiis is fixed by doing cancel_delayed_work_sync() instead of
cancel_delayed_work() during the alias guid mechanism destroy flow.

Fixes: a0c64a17aba8 ("mlx4: Add alias_guid mechanism")
Signed-off-by: Jack Morgenstein <jackm@dev.mellanox.co.il>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mlx4/alias_GUID.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx4/alias_GUID.c b/drivers/infiniband/hw/mlx4/alias_GUID.c
index 0eb141c41416..fb60229bf191 100644
--- a/drivers/infiniband/hw/mlx4/alias_GUID.c
+++ b/drivers/infiniband/hw/mlx4/alias_GUID.c
@@ -579,8 +579,8 @@ void mlx4_ib_destroy_alias_guid_service(struct mlx4_ib_dev *dev)
 	unsigned long flags;
 
 	for (i = 0 ; i < dev->num_ports; i++) {
-		cancel_delayed_work(&dev->sriov.alias_guid.ports_guid[i].alias_guid_work);
 		det = &sriov->alias_guid.ports_guid[i];
+		cancel_delayed_work_sync(&det->alias_guid_work);
 		spin_lock_irqsave(&sriov->alias_guid.ag_work_lock, flags);
 		while (!list_empty(&det->cb_list)) {
 			cb_ctx = list_entry(det->cb_list.next,
-- 
2.19.1



