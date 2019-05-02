Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9747BC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 661B2208C4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556810685;
	bh=iyutgjCnqeEGMv7+w36WlERhI2JO6mPMmmxKpcNWrkY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QWQcqz9G0FOhBV0/As8yq8aLlMR8/y9o5A+tWE3h/ovOsViHrEewZlSjy9+pBaF/e
	 ZCVSqUE5lqrKJ70nHm6uUO7caB2jTXGXXKDC1kgd33oLq4XIQ0qj8Juw95dDUGsLHW
	 1jH0GGuW6jPJnBU8jdgYYrmP3XtJAz6dZDp6XRAw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbfEBPYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:24:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:40616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727359AbfEBPYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:24:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C1BF208C4;
        Thu,  2 May 2019 15:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556810680;
        bh=iyutgjCnqeEGMv7+w36WlERhI2JO6mPMmmxKpcNWrkY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uyuESeWOIW6yGNuDEVordRuZVu798HHnKb7ofWLvJp4Bj1fuzU2nrV8c21luA4SyY
         lK+SqRtZHqeMZEOwpN1D5N1l+v7ddpOkBlyQySRrk/SaUeczlvgI1a230tKzDLh5yG
         OemVewfdT7OOvFM2d6u9iYT0sgAR1sJyQ29t/U/4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Manish Rangankar <mrangankar@marvell.com>,
        Mukesh Ojha <mojha@codeaurora.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: [PATCH 4.14 39/49] scsi: qla4xxx: fix a potential NULL pointer dereference
Date:   Thu,  2 May 2019 17:21:16 +0200
Message-Id: <20190502143328.907283623@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190502143323.397051088@linuxfoundation.org>
References: <20190502143323.397051088@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 22dc70a2138e..630b7404843d 100644
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



