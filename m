Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED497C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B91C22173B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573497291;
	bh=FEoAUQmdVsjexuDgVhGqVl+xGVNFwzVQlo4Jed45Uyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Fzi10DW3ig3/pzptUYDb+yC9VUpu1KmzNepTlA2dBBbIrl2yk/mCtJAWV/zhcywdN
	 ys2BcS3Zfo0UlBh+2oA8eXj85RTPmyvQEH+0Hg7hGM0mHRyM+L1xxJPo1p8G36wiEP
	 YzwTC91Qf7tbEk3nNjX/tE59n9EYx18OObaACAbY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbfKKSet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:34:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:52508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728407AbfKKSer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:34:47 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 481242173B;
        Mon, 11 Nov 2019 18:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573497286;
        bh=FEoAUQmdVsjexuDgVhGqVl+xGVNFwzVQlo4Jed45Uyw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S9Sxl4t9V45SDnPKeYQkOqGe/oIDL+5eNgzLUeGg+y81NyWRYmHueQrw3gLqfk2+P
         ZH/hVk/mU2zphkBRGs31Ka0sgiFtTd4wUzi6gGf7vMGVKENlnpREx7TBi7yOuQ0533
         PU8bF+COL4JYdwn6LdpdoFGqXZ8vfjo/AS3qKMZI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Himanshu Madhani <hmadhani@marvell.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 53/65] scsi: qla2xxx: stop timer in shutdown path
Date:   Mon, 11 Nov 2019 19:28:53 +0100
Message-Id: <20191111181352.133190505@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181331.917659011@linuxfoundation.org>
References: <20191111181331.917659011@linuxfoundation.org>
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
index c813c9b75a10b..3bae56b202f87 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -3077,6 +3077,10 @@ qla2x00_shutdown(struct pci_dev *pdev)
 	/* Stop currently executing firmware. */
 	qla2x00_try_to_stop_firmware(vha);
 
+	/* Disable timer */
+	if (vha->timer_active)
+		qla2x00_stop_timer(vha);
+
 	/* Turn adapter off line */
 	vha->flags.online = 0;
 
-- 
2.20.1



