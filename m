Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63EEC3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80C31208E4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567620564;
	bh=eUxf5px/y/J3zPOxR6HS7sIp8nKji4J2U42kiNPMmoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1df4RUilawa7Vx8x35RAjZgH47SttKA8KHbDlxvP/Y+b5u0Z+V/n+4/UJ76y58XEq
	 jVkV59jwiKUsrvBFJ/3UO1rr+qZYoUoz7lqeAAnrx0ELae2vfYFIEqNZxD7qM++aSo
	 atI+8oQf4f1lSXWJNhWujnqJU8v4pIneaJQmJ6MM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389370AbfIDSJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:09:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:52520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389131AbfIDSJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:09:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8426208E4;
        Wed,  4 Sep 2019 18:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567620558;
        bh=eUxf5px/y/J3zPOxR6HS7sIp8nKji4J2U42kiNPMmoQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X0ocKevPXfR/ycc6ef8ZYDheljQ1pKw2KQ2FxtiSYp6khO/n3GJlGJRacgymC6XFt
         JwQCJkw7/tXjAnsoi2s4V9piGUNYJF3qg37o0oBbbIwFmh6HrO9ENIpIBluAoZ10FK
         NYweqt+1f6PVGc7sZvmjlpGZyTRPeAz8rvklDFCM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <maxg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 010/143] nvmet-loop: Flush nvme_delete_wq when removing the port
Date:   Wed,  4 Sep 2019 19:52:33 +0200
Message-Id: <20190904175314.524009703@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175314.206239922@linuxfoundation.org>
References: <20190904175314.206239922@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 86b9a63e595ff03f9d0a7b92b6acc231fecefc29 ]

After calling nvme_loop_delete_ctrl(), the controllers will not
yet be deleted because nvme_delete_ctrl() only schedules work
to do the delete.

This means a race can occur if a port is removed but there
are still active controllers trying to access that memory.

To fix this, flush the nvme_delete_wq before returning from
nvme_loop_remove_port() so that any controllers that might
be in the process of being deleted won't access a freed port.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
Reviewed-by : Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/loop.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 9e211ad6bdd3d..da9cd07461fbb 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -654,6 +654,14 @@ static void nvme_loop_remove_port(struct nvmet_port *port)
 	mutex_lock(&nvme_loop_ports_mutex);
 	list_del_init(&port->entry);
 	mutex_unlock(&nvme_loop_ports_mutex);
+
+	/*
+	 * Ensure any ctrls that are in the process of being
+	 * deleted are in fact deleted before we return
+	 * and free the port. This is to prevent active
+	 * ctrls from using a port after it's freed.
+	 */
+	flush_workqueue(nvme_delete_wq);
 }
 
 static const struct nvmet_fabrics_ops nvme_loop_ops = {
-- 
2.20.1



