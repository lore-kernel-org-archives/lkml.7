Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F36C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BCF624682
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576781587;
	bh=6do8LPNwnSdk/SBo9CUNRHbKZZltgMohbw9SXzUd2FA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0CLsa5qobE9LQtqi3+umrDizCL7Gr7g3WAB7CqYLtaq0uyQkbGxPk8WUJ4TIX+JGP
	 R4QedMTw70gOrruJgxsSyDtUVp5JEKuzqXzx9oXiyeSCcyPntJDSQJemiiiddp4Tti
	 IMwmvzR3hjxcF/EMe+xqkK2PENJpSRTIZDEV2NhI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730324AbfLSSxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:53:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:47910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728387AbfLSSxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:53:04 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16159222C2;
        Thu, 19 Dec 2019 18:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576781583;
        bh=6do8LPNwnSdk/SBo9CUNRHbKZZltgMohbw9SXzUd2FA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QjGaHBaI/EcMnMhwazOZ5jgMyOKj0zSrZou4+LLWiQJwVhWD5JoPNF2Gr73ZJ9tKT
         g8tYdJBIbINIbvwM2t52UYMVgFO8wu9n2iMCI0qTbAg7ys7fWOY0CtpLHf6Icjez8P
         H3nselxG8cRooXXK67i0TPlGLz/9IryN6IwpZBiI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Quinn Tran <qutran@marvell.com>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Hannes Reinecke <hare@suse.de>,
        Roman Bolshakov <r.bolshakov@yadro.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.19 45/47] scsi: qla2xxx: Change discovery state before PLOGI
Date:   Thu, 19 Dec 2019 19:34:59 +0100
Message-Id: <20191219182955.693851906@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219182857.659088743@linuxfoundation.org>
References: <20191219182857.659088743@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Bolshakov <r.bolshakov@yadro.com>

commit 58e39a2ce4be08162c0368030cdc405f7fd849aa upstream.

When a port sends PLOGI, discovery state should be changed to login
pending, otherwise RELOGIN_NEEDED bit is set in
qla24xx_handle_plogi_done_event(). RELOGIN_NEEDED triggers another PLOGI,
and it never goes out of the loop until login timer expires.

Fixes: 8777e4314d397 ("scsi: qla2xxx: Migrate NVME N2N handling into state machine")
Fixes: 8b5292bcfcacf ("scsi: qla2xxx: Fix Relogin to prevent modifying scan_state flag")
Cc: Quinn Tran <qutran@marvell.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20191125165702.1013-6-r.bolshakov@yadro.com
Acked-by: Himanshu Madhani <hmadhani@marvell.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Tested-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_init.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -966,6 +966,7 @@ int qla24xx_post_gnl_work(struct scsi_ql
 
 	e->u.fcport.fcport = fcport;
 	fcport->flags |= FCF_ASYNC_ACTIVE;
+	fcport->disc_state = DSC_LOGIN_PEND;
 	return qla2x00_post_work(vha, e);
 }
 


