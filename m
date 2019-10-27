Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E93CA9EBC
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4122E214E0
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572211144;
	bh=dlmTroG9Z6e2QxL9z2QYYH/+HCwazBgRl60ITiwDM9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WfxaITgzUnv/2elIj4Hh+EJK3AkUkPMeh5PtgerUqaGgsqa1HYLT3c8SeKtOq4FMr
	 Um4BOqSM+HEVGqD6Qzf1vpyp/o3wSMZXb2/1BeeL7+I9KnYzWCmkv3UyX5T3tBiFB1
	 Qqw2y40kANWzLqtIz+dmBZEm5F/v7zPkQuf/INVI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731387AbfJ0VTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:19:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:39230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731364AbfJ0VSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:18:55 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85E00205C9;
        Sun, 27 Oct 2019 21:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572211135;
        bh=dlmTroG9Z6e2QxL9z2QYYH/+HCwazBgRl60ITiwDM9c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D3dJN8kSUU3zyHSetOOvWC24s7M+I1IWz41zZQLTot7/aLE9W80p2L33M9OZtfNuW
         rDoQLrhnI+B4xk5OfT6ZHTQsL0mHFBKyCAKgTsAPHIT96xulzZVFtEWa1krma+/YU3
         tJURk2L2eluekfD8oRpzREokHqvryf30tgYVW/Pw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Quinn Tran <qutran@marvell.com>,
        Himanshu Madhani <hmadhani@marvell.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 009/197] scsi: qla2xxx: Fix unbound sleep in fcport delete path.
Date:   Sun, 27 Oct 2019 21:58:47 +0100
Message-Id: <20191027203352.185589994@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203351.684916567@linuxfoundation.org>
References: <20191027203351.684916567@linuxfoundation.org>
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
index 459c28aa3b94a..f77baf107024f 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -1021,6 +1021,7 @@ void qlt_free_session_done(struct work_struct *work)
 
 	if (logout_started) {
 		bool traced = false;
+		u16 cnt = 0;
 
 		while (!READ_ONCE(sess->logout_completed)) {
 			if (!traced) {
@@ -1030,6 +1031,9 @@ void qlt_free_session_done(struct work_struct *work)
 				traced = true;
 			}
 			msleep(100);
+			cnt++;
+			if (cnt > 200)
+				break;
 		}
 
 		ql_dbg(ql_dbg_disc, vha, 0xf087,
-- 
2.20.1



