Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2003DCA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB952064A
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572210342;
	bh=VTE3iNMsGVPx5aIFWaap7QbAngR+xbH2tN1CHoJh/kE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Az/Z4RJhIspvvz1DfckCmYi1QsGB/c+oV+2wcukVzZCi+AxoJ7tRZdQIJcuTbAge7
	 oaqGeKi43oBinwDHNKYQ+uUKrpE3MzC58DeICDPkg6EDV6kcMjUDw3VLsH9X4V8H4m
	 LQg/Y6SQs+cbydurlMBudn66eileapvIfws9v6Wc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbfJ0VFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:05:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:51480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727511AbfJ0VFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:05:38 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20F06208C0;
        Sun, 27 Oct 2019 21:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572210337;
        bh=VTE3iNMsGVPx5aIFWaap7QbAngR+xbH2tN1CHoJh/kE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LkJdXVecpL55Mgo9lUuILKUBxZF/31gUC4l/haqzUoiTrdEZWg+CLvVfh5ifDFYw7
         gMtEpl+J/qJNTjjBxwOxYRdbpbfgRfGyapakRIT1pSgoBxpfACMwwABevjefAeFc+8
         o2NJTMbE+rb6Qt2rnciUeP3z7OnmXADt+E2Sr//k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Quinn Tran <qutran@marvell.com>,
        Himanshu Madhani <hmadhani@marvell.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 03/49] scsi: qla2xxx: Fix unbound sleep in fcport delete path.
Date:   Sun, 27 Oct 2019 22:00:41 +0100
Message-Id: <20191027203121.970264406@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203119.468466356@linuxfoundation.org>
References: <20191027203119.468466356@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quinn Tran <qutran@marvell.com>

[ Upstream commit c3b6a1d397420a0fdd97af2f06abfb78adc370df ]

There are instances, though rare, where a LOGO request cannot be sent out
and the thread in free session done can wait indefinitely. Fix this by
putting an upper bound to sleep.

Link: https://lore.kernel.org/r/20190912180918.6436-3-hmadhani@marvell.com
Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_target.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index 11f45cb998927..d13e91e164258 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -572,6 +572,7 @@ static void qlt_free_session_done(struct work_struct *work)
 
 	if (logout_started) {
 		bool traced = false;
+		u16 cnt = 0;
 
 		while (!ACCESS_ONCE(sess->logout_completed)) {
 			if (!traced) {
@@ -581,6 +582,9 @@ static void qlt_free_session_done(struct work_struct *work)
 				traced = true;
 			}
 			msleep(100);
+			cnt++;
+			if (cnt > 200)
+				break;
 		}
 
 		ql_dbg(ql_dbg_tgt_mgt, vha, 0xf087,
-- 
2.20.1



