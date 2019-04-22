Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171DFC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0473204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555962765;
	bh=N2cnvf67uS5PXlRQ8txYdu15tfi9sVnAWQp6DaW8HzM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t2q1OE3n7nXRQejMdRdCLv11SBGEuHLgv1nWury4981/WeKyobeesVI2+xa2f3wcI
	 jwpp2hzhOkuGeIWN3DdoHPnO6K9XlNvcE7fyy8txIpFmUa6TZ3Ju/Mn43NNFnX4eEi
	 LTuTalowT3kzIQXKW8EDongIO68wANr9fJNsnWXs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731343AbfDVTwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:52:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:54110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730207AbfDVTuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:50:12 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DAED218D3;
        Mon, 22 Apr 2019 19:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962612;
        bh=N2cnvf67uS5PXlRQ8txYdu15tfi9sVnAWQp6DaW8HzM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U2Z9Gz80Td0+2PzJ8+5+4V2UZhL/6zpbvxJpVx5mv3gA16BmzFi5oxZSyglk04yjZ
         pk/VW6i/1wudc8j8t99bmR+Wlhiu/FQ02aoFDYwZodTtnJ9A1qknsOPQ+BYhjkW+EZ
         tR7UxvE56WBXj3M1aLQHpQOE5IjCnj9Ou0i3aGY0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 15/21] scsi: qla4xxx: fix a potential NULL pointer dereference
Date:   Mon, 22 Apr 2019 15:49:35 -0400
Message-Id: <20190422194941.13433-15-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194941.13433-1-sashal@kernel.org>
References: <20190422194941.13433-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kangjie Lu <kjlu@umn.edu>

[ Upstream commit fba1bdd2a9a93f3e2181ec1936a3c2f6b37e7ed6 ]

In case iscsi_lookup_endpoint fails, the fix returns -EINVAL to avoid NULL
pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Acked-by: Manish Rangankar <mrangankar@marvell.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/scsi/qla4xxx/ql4_os.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
index f9f899ec9427..c158967b59d7 100644
--- a/drivers/scsi/qla4xxx/ql4_os.c
+++ b/drivers/scsi/qla4xxx/ql4_os.c
@@ -3207,6 +3207,8 @@ static int qla4xxx_conn_bind(struct iscsi_cls_session *cls_session,
 	if (iscsi_conn_bind(cls_session, cls_conn, is_leading))
 		return -EINVAL;
 	ep = iscsi_lookup_endpoint(transport_fd);
+	if (!ep)
+		return -EINVAL;
 	conn = cls_conn->dd_data;
 	qla_conn = conn->dd_data;
 	qla_conn->qla_ep = ep->dd_data;
-- 
2.19.1

