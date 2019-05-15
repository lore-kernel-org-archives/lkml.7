Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7989FC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4293120657
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557922326;
	bh=aK1j+ztpyv7vMhEEePNUn/E/rZXm/tqeKprs5SZhO24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E5roHTnwe/60E9pyc1FntCPZliMJgUOtFxq0QDbLmpDzCcYXy5Yv9CJvLoy7wNBWB
	 mJoRvUxayGPzq5yKPu+MYrPxwm8nOAo7HVKmcn1hrRFJwixWt3MoczhWiPFXpdbL+r
	 qVyBEt9wkxJzxLphAVC8kwuKx6wQ2HD1Hup82pso=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbfEOLGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:06:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:36670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727920AbfEOLGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:06:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D134B216FD;
        Wed, 15 May 2019 11:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557918368;
        bh=aK1j+ztpyv7vMhEEePNUn/E/rZXm/tqeKprs5SZhO24=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XzrWmgB2m0eFwRyueXEAUTA5rsMEmt2tUivHMz/uHdh8HdEf4FNAH7iPI5+t++rH+
         wMNwrDkdNPFM+G/229H7qtPjByw8mLq82N8arOtsoyMWqRX7tgimCExVnbvRPBcUOy
         53OhDA3Rv+9+y9bw5AiCbjN+Rdh+i8bElDKc9Ifg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Manish Rangankar <mrangankar@marvell.com>,
        Mukesh Ojha <mojha@codeaurora.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: [PATCH 4.4 103/266] scsi: qla4xxx: fix a potential NULL pointer dereference
Date:   Wed, 15 May 2019 12:53:30 +0200
Message-Id: <20190515090725.936652691@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090722.696531131@linuxfoundation.org>
References: <20190515090722.696531131@linuxfoundation.org>
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



