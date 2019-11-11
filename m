Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C473C17441
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6657C222C6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573498632;
	bh=zKkKUDIZcW3GqAheMpN/zNXU40urnIbr86SVSSbIX2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jdFuXBAEjdlkEd0VAbYYH7mbIZ5HgJvFyg8CnG3Cygoo+4ZCIfAxjt4yL7JBwBtYL
	 ilcJPxM7/ExQtoSUT7IQxt1tUEphNCnVE+X8/KXD5Yn5W8+TpOgevKvTgs9CqW9epI
	 15SWYzv2ivDZij4aW0YzxkYMsPpiPLm76+Ww/QRM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729697AbfKKS46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:56:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:55658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730765AbfKKS4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:56:53 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 045A320659;
        Mon, 11 Nov 2019 18:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573498612;
        bh=zKkKUDIZcW3GqAheMpN/zNXU40urnIbr86SVSSbIX2Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MTxSJHvWxGVoew8oc/dSaWzaVO7C70xjFqZWZV4H83iFkVCAJJ4MeZB4s77YCsx9Y
         V+jb44Qvhop3/aEeum1iWBS7vrAsNBwskhr9NeSS1ukhuNRvuK/PfSijduAg9J+MwR
         lhpSj8QrwKeQn5uo052+PDowbHOfIZCWzyqdA8Dw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Himanshu Madhani <hmadhani@marvell.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 153/193] scsi: qla2xxx: stop timer in shutdown path
Date:   Mon, 11 Nov 2019 19:28:55 +0100
Message-Id: <20191111181512.422472304@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181459.850623879@linuxfoundation.org>
References: <20191111181459.850623879@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Piggin <npiggin@gmail.com>

[ Upstream commit d3566abb1a1e7772116e4d50fb6a58d19c9802e5 ]

In shutdown/reboot paths, the timer is not stopped:

  qla2x00_shutdown
  pci_device_shutdown
  device_shutdown
  kernel_restart_prepare
  kernel_restart
  sys_reboot

This causes lockups (on powerpc) when firmware config space access calls
are interrupted by smp_send_stop later in reboot.

Fixes: e30d1756480dc ("[SCSI] qla2xxx: Addition of shutdown callback handler.")
Link: https://lore.kernel.org/r/20191024063804.14538-1-npiggin@gmail.com
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Acked-by: Himanshu Madhani <hmadhani@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_os.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 04cf6986eb8e6..ac96771bb06df 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -3543,6 +3543,10 @@ qla2x00_shutdown(struct pci_dev *pdev)
 		qla2x00_try_to_stop_firmware(vha);
 	}
 
+	/* Disable timer */
+	if (vha->timer_active)
+		qla2x00_stop_timer(vha);
+
 	/* Turn adapter off line */
 	vha->flags.online = 0;
 
-- 
2.20.1



