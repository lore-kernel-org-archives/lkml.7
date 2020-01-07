Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC96C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCF07208C4
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578431376;
	bh=LwV0b4UswDgokCni8DGt5dsVUmNU5hsvCheqmsG4bJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iRoOwC3X6ECcxTZcPvPPIx/kk8/GU+yFGgR3jRNwnWK9eMzCRoRVB2SLxjTcbemkb
	 2Bacjzra71clej1u68c9dGJQ4Wzo4Ntl+0jv5q1N+QopgBjqrKQ22JvhNssra8Tir9
	 YnSeMA4TmO4LmlxmloKuAkzejTCceLv8+Aj8TGuk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729847AbgAGVJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:09:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:34958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729829AbgAGVJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:09:29 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C37DE2072A;
        Tue,  7 Jan 2020 21:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578431369;
        bh=LwV0b4UswDgokCni8DGt5dsVUmNU5hsvCheqmsG4bJI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k05EkfmCXjHwbL7J+nn9Ae6KD3qEuRBTNBtQxAnrp0tVada7QpEntxO+/7tndfcNI
         LSeOzR63v4+e7rRcyTKcbvzMH6/o4fp3ScXHK9zkRb5cIF+t6xkHSw0VY/JRSt545d
         x3QX01IQVM4GWRCuXBROGtpLb/32YlnXg5fnFdkA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Quinn Tran <qutran@marvell.com>,
        Himanshu Madhani <hmadhani@marvel.com>,
        Hannes Reinecke <hare@suse.de>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Roman Bolshakov <r.bolshakov@yadro.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 07/74] scsi: qla2xxx: Dont call qlt_async_event twice
Date:   Tue,  7 Jan 2020 21:54:32 +0100
Message-Id: <20200107205140.483302224@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205135.369001641@linuxfoundation.org>
References: <20200107205135.369001641@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Bolshakov <r.bolshakov@yadro.com>

[ Upstream commit 2c2f4bed9b6299e6430a65a29b5d27b8763fdf25 ]

MBA_PORT_UPDATE generates duplicate log lines in target mode because
qlt_async_event is called twice. Drop the calls within the case as the
function will be called right after the switch statement.

Cc: Quinn Tran <qutran@marvell.com>
Link: https://lore.kernel.org/r/20191125165702.1013-8-r.bolshakov@yadro.com
Acked-by: Himanshu Madhani <hmadhani@marvel.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Tested-by: Hannes Reinecke <hare@suse.de>
Acked-by: Himanshu Madhani <hmadhani@marvell.com>
Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_isr.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index ebca1a470e9b..7f2da56274bd 100644
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -1046,8 +1046,6 @@ qla2x00_async_event(scsi_qla_host_t *vha, struct rsp_que *rsp, uint16_t *mb)
 			ql_dbg(ql_dbg_async, vha, 0x5011,
 			    "Asynchronous PORT UPDATE ignored %04x/%04x/%04x.\n",
 			    mb[1], mb[2], mb[3]);
-
-			qlt_async_event(mb[0], vha, mb);
 			break;
 		}
 
@@ -1065,8 +1063,6 @@ qla2x00_async_event(scsi_qla_host_t *vha, struct rsp_que *rsp, uint16_t *mb)
 		set_bit(LOOP_RESYNC_NEEDED, &vha->dpc_flags);
 		set_bit(LOCAL_LOOP_UPDATE, &vha->dpc_flags);
 		set_bit(VP_CONFIG_OK, &vha->vp_flags);
-
-		qlt_async_event(mb[0], vha, mb);
 		break;
 
 	case MBA_RSCN_UPDATE:		/* State Change Registration */
-- 
2.20.1



