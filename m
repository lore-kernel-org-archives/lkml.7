Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCB4C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A75C20708
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574403239;
	bh=2FKCwtfQ/zR6VWzJaxtMgHi64PjCKJ4x79baPcmlda4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yfKla5gWdBntCuMX71yJcJGwnxNjN+hIy1X9+lhjYf5TzqIYOsRHUnS/tj4VdvHoY
	 vAwrQrLn2adkoxtONMW5rA5ktv7PAkQM4N1aXTlxrSLffOj6UT5dJHmGRFqgJ86oV/
	 rCh+3fqiT+iyeWXDwe50JDUlPFdUEAuvd0a4ZYE0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbfKVGN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:13:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:51036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728156AbfKVGNl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 01:13:41 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2015920708;
        Fri, 22 Nov 2019 06:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574403221;
        bh=2FKCwtfQ/zR6VWzJaxtMgHi64PjCKJ4x79baPcmlda4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GOtnlqnscfEYvv+RJpeukhgxpHnppSpxddaZuIYAVoFNKtLHn6l/5jkJz5KeuI62B
         EW1HE3tdFTj9iMlo9Xr8PAWouuVQkiKG8Z7Oj6ZhoGy81bWGNJd15rARKRU1G9OWCj
         zkIcp08X/SBFmJdc0c8ecfsC5cezKA3TTt89tAUk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Sergey Gorenko <sergeygo@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Laurence Oberman <loberman@redhat.com>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <sashal@kernel.org>, linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 35/68] RDMA/srp: Propagate ib_post_send() failures to the SCSI mid-layer
Date:   Fri, 22 Nov 2019 01:12:28 -0500
Message-Id: <20191122061301.4947-34-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122061301.4947-1-sashal@kernel.org>
References: <20191122061301.4947-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bart Van Assche <bvanassche@acm.org>

[ Upstream commit 2ee00f6a98c36f7e4ba07cc33f24cc5a69060cc9 ]

This patch avoids that the SCSI mid-layer keeps retrying forever if
ib_post_send() fails. This was discovered while testing immediate
data support and passing a too large num_sge value to ib_post_send().

Cc: Sergey Gorenko <sergeygo@mellanox.com>
Cc: Max Gurtovoy <maxg@mellanox.com>
Cc: Laurence Oberman <loberman@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/ulp/srp/ib_srp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index 3dbc3ed263c21..3b4188efc2835 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -2135,6 +2135,7 @@ static int srp_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *scmnd)
 
 	if (srp_post_send(ch, iu, len)) {
 		shost_printk(KERN_ERR, target->scsi_host, PFX "Send failed\n");
+		scmnd->result = DID_ERROR << 16;
 		goto err_unmap;
 	}
 
-- 
2.20.1

