Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9B1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D02A2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553712094;
	bh=M8BwuojB0quDlV38YY1jenayg8hOXZcfwvK7yLTmiGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nqADzU/DYTqO5Pn1Zk3M6C3cVQBh1WfzATfga7t/cVfSRInxO0VA+8LLsSFosBsve
	 XK7goZ0kMXitqQii0+MEAjV+ZONuii2zQ1DXwJmeJYVfCO2ymY/PN7EuD1V2eh/2or
	 /IZXuPmfhXa9gXa4/2l/vmzTK5EiVySJfHLcM8nM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391667AbfC0Sld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:41:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:40480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403852AbfC0SWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:22:22 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3ED62070B;
        Wed, 27 Mar 2019 18:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710941;
        bh=M8BwuojB0quDlV38YY1jenayg8hOXZcfwvK7yLTmiGw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mGK5C4cY7zl9J+vP5BWPLsDoEMo8VogVTyjmb+AoodNe5EYK9TWT7XFsLrv9DfylI
         tu3iqyFy+1qkdFvxBxp9/sTiJh8Yf3UJnF6fkw+cuy9xzfRzsQZ0exwrgMiIbS9eUl
         od8A4HFe1Kt0G7KYFsneV+QjCDXcRAPV8MXTEmIw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Raju Rangoju <rajur@chelsio.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>, linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 56/87] iw_cxgb4: fix srqidx leak during connection abort
Date:   Wed, 27 Mar 2019 14:20:09 -0400
Message-Id: <20190327182040.17444-56-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327182040.17444-1-sashal@kernel.org>
References: <20190327182040.17444-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Raju Rangoju <rajur@chelsio.com>

[ Upstream commit f368ff188ae4b3ef6f740a15999ea0373261b619 ]

When an application aborts the connection by moving QP from RTS to ERROR,
then iw_cxgb4's modify_rc_qp() RTS->ERROR logic sets the
*srqidxp to 0 via t4_set_wq_in_error(&qhp->wq, 0), and aborts the
connection by calling c4iw_ep_disconnect().

c4iw_ep_disconnect() does the following:
 1. sends up a close_complete_upcall(ep, -ECONNRESET) to libcxgb4.
 2. sends abort request CPL to hw.

But, since the close_complete_upcall() is sent before sending the
ABORT_REQ to hw, libcxgb4 would fail to release the srqidx if the
connection holds one. Because, the srqidx is passed up to libcxgb4 only
after corresponding ABORT_RPL is processed by kernel in abort_rpl().

This patch handle the corner-case by moving the call to
close_complete_upcall() from c4iw_ep_disconnect() to abort_rpl().  So that
libcxgb4 is notified about the -ECONNRESET only after abort_rpl(), and
libcxgb4 can relinquish the srqidx properly.

Signed-off-by: Raju Rangoju <rajur@chelsio.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/cxgb4/cm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4/cm.c
index dd18b74cd01d..a2322b2dbd82 100644
--- a/drivers/infiniband/hw/cxgb4/cm.c
+++ b/drivers/infiniband/hw/cxgb4/cm.c
@@ -1872,8 +1872,10 @@ static int abort_rpl(struct c4iw_dev *dev, struct sk_buff *skb)
 	}
 	mutex_unlock(&ep->com.mutex);
 
-	if (release)
+	if (release) {
+		close_complete_upcall(ep, -ECONNRESET);
 		release_ep_resources(ep);
+	}
 	c4iw_put_ep(&ep->com);
 	return 0;
 }
@@ -3567,7 +3569,6 @@ int c4iw_ep_disconnect(struct c4iw_ep *ep, int abrupt, gfp_t gfp)
 	if (close) {
 		if (abrupt) {
 			set_bit(EP_DISC_ABORT, &ep->com.history);
-			close_complete_upcall(ep, -ECONNRESET);
 			ret = send_abort(ep);
 		} else {
 			set_bit(EP_DISC_CLOSE, &ep->com.history);
-- 
2.19.1

