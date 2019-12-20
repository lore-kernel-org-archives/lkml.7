Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104D2C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB16121D7E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576852620;
	bh=7CbyhLown2+ZTssUCg+XJlvPODqqCNyO77ZM0dVKEqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GyKrYrCpcZIL7WVvsVYrEOMpEcyjc1TuK15DTlyZSfzFj/f5ZZV/AASQk0A1Uq8Kx
	 95vbJfjCiRNjtTPOz4jfqCqGRPUkxN61rYQmznwDk6NmQb/m1Vg5wOkPxdNtRkpjze
	 Jt5lN382yhI92DiEMGnyDoCc7u63z7FMAydD+Ecs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbfLTOen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 09:34:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:38676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728085AbfLTOeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 09:34:37 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E974524684;
        Fri, 20 Dec 2019 14:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576852476;
        bh=7CbyhLown2+ZTssUCg+XJlvPODqqCNyO77ZM0dVKEqI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x4/vMA3r+N+BLB9kBK7BDrwU2XYFoQ7YDGclvJPj7NXObyqaWCUT5Fwh8PUWNMCO1
         o//ufyOO19fRFBrRRwoGtXMKixvGW/IpcANXkj1EjzYaOUqq+T54c+6lK4rSjCpKEz
         Xm3yV1jqPTNaUt1JshAcQMOnR/hq0Qo00BOEQWeY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Himanshu Madhani <hmadhani@marvell.com>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Keith Busch <kbusch@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 02/34] nvme-fc: fix double-free scenarios on hw queues
Date:   Fri, 20 Dec 2019 09:34:01 -0500
Message-Id: <20191220143433.9922-2-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191220143433.9922-1-sashal@kernel.org>
References: <20191220143433.9922-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Smart <jsmart2021@gmail.com>

[ Upstream commit c869e494ef8b5846d9ba91f1e922c23cd444f0c1 ]

If an error occurs on one of the ios used for creating an
association, the creating routine has error paths that are
invoked by the command failure and the error paths will free
up the controller resources created to that point.

But... the io was ultimately determined by an asynchronous
completion routine that detected the error and which
unconditionally invokes the error_recovery path which calls
delete_association. Delete association deletes all outstanding
io then tears down the controller resources. So the
create_association thread can be running in parallel with
the error_recovery thread. What was seen was the LLDD received
a call to delete a queue, causing the LLDD to do a free of a
resource, then the transport called the delete queue again
causing the driver to repeat the free call. The second free
routine corrupted the allocator. The transport shouldn't be
making the duplicate call, and the delete queue is just one
of the resources being freed.

To fix, it is realized that the create_association path is
completely serialized with one command at a time. So the
failed io completion will always be seen by the create_association
path and as of the failure, there are no ios to terminate and there
is no reason to be manipulating queue freeze states, etc.
The serialized condition stays true until the controller is
transitioned to the LIVE state. Thus the fix is to change the
error recovery path to check the controller state and only
invoke the teardown path if not already in the CONNECTING state.

Reviewed-by: Himanshu Madhani <hmadhani@marvell.com>
Reviewed-by: Ewan D. Milne <emilne@redhat.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/fc.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index d567035571bf2..1875f6b8a907b 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2894,10 +2894,22 @@ nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status)
 static void
 __nvme_fc_terminate_io(struct nvme_fc_ctrl *ctrl)
 {
-	nvme_stop_keep_alive(&ctrl->ctrl);
+	/*
+	 * if state is connecting - the error occurred as part of a
+	 * reconnect attempt. The create_association error paths will
+	 * clean up any outstanding io.
+	 *
+	 * if it's a different state - ensure all pending io is
+	 * terminated. Given this can delay while waiting for the
+	 * aborted io to return, we recheck adapter state below
+	 * before changing state.
+	 */
+	if (ctrl->ctrl.state != NVME_CTRL_CONNECTING) {
+		nvme_stop_keep_alive(&ctrl->ctrl);
 
-	/* will block will waiting for io to terminate */
-	nvme_fc_delete_association(ctrl);
+		/* will block will waiting for io to terminate */
+		nvme_fc_delete_association(ctrl);
+	}
 
 	if (ctrl->ctrl.state != NVME_CTRL_CONNECTING &&
 	    !nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING))
-- 
2.20.1

