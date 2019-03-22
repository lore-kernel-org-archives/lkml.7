Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5EEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D92542192D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256348;
	bh=LCMkBdBp1MBXtm8yaKRuSdMJZxpdgxQVNsb2d/CFItI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mx/Z/8QKyxfVFO+2Hi/jF6MFhhAa7XvtQ2wQDUYlWx0AWZUvunkstPYDTBPLsCAjQ
	 1AooSf/swXV/84KydkI0d8oNEi9d9qzeMneabbTMDYDw3cn4N/iGCHQKodbGeBiIlc
	 KLyrQ6pYPcfQnwR4fA3FgOo86eqG8yA5J+m7ZTWU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388734AbfCVMFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:05:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:43114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388210AbfCVMEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:04:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A3892195D;
        Fri, 22 Mar 2019 12:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256282;
        bh=LCMkBdBp1MBXtm8yaKRuSdMJZxpdgxQVNsb2d/CFItI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qbMGgTP8/ggADtV17JUzpgRrMWfjmGIwe1SvJPjqxOS2LAjfM8DFXezF5GOg8nJIU
         TZ7accBDHWNjJ2l1n2baLidAngeGL7meu4cCnfzM3m36AnWiTFzORSKKt4yNjlQwaH
         CLxZFC6tklFQupxARhh5LBfEzmtF0Y9q3UsWntxM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Himanshu Madhani <hmadhani@marvell.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.19 162/280] scsi: qla2xxx: Fix LUN discovery if loop id is not assigned yet by firmware
Date:   Fri, 22 Mar 2019 12:15:15 +0100
Message-Id: <20190322111322.701075819@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Himanshu Madhani <hmadhani@marvell.com>

commit ec322937a7f152d68755dc8316523bf6f831b48f upstream.

This patch fixes LUN discovery when loop ID is not yet assigned by the
firmware during driver load/sg_reset operations. Driver will now search for
new loop id before retrying login.

Fixes: 48acad099074 ("scsi: qla2xxx: Fix N2N link re-connect")
Cc: stable@vger.kernel.org #4.19
Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_init.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -643,11 +643,14 @@ static void qla24xx_handle_gnl_done_even
 				break;
 			case DSC_LS_PORT_UNAVAIL:
 			default:
-				if (fcport->loop_id != FC_NO_LOOP_ID)
-					qla2x00_clear_loop_id(fcport);
-
-				fcport->loop_id = loop_id;
-				fcport->fw_login_state = DSC_LS_PORT_UNAVAIL;
+				if (fcport->loop_id == FC_NO_LOOP_ID) {
+					qla2x00_find_new_loop_id(vha, fcport);
+					fcport->fw_login_state =
+					    DSC_LS_PORT_UNAVAIL;
+				}
+				ql_dbg(ql_dbg_disc, vha, 0x20e5,
+				    "%s %d %8phC\n", __func__, __LINE__,
+				    fcport->port_name);
 				qla24xx_fcport_handle_login(vha, fcport);
 				break;
 			}


