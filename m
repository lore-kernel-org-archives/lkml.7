Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB49AC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 772702196E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573497511;
	bh=V/BFtrfACRvAuMyvrEX6mCnc3UD+mqWzo5Lyq4xWR2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HGo1NPxVd/G0ufOLLsUC1zrPmCgsqftlfv1ax95v2Sr2JNs5wUPF7ngwIffI2zOLl
	 8PlV7UKZWYZ5oABfQ0McVPvEmeBEHynX5kRAImxUyNmhYclsieE6o2ul7xgp1+8y9I
	 Qfcdn23Wl9iqcOP9Pwb+2u3ug4x4KrFbpL5gID0s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbfKKSi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:38:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:57392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729007AbfKKSi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:38:27 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35D9B204FD;
        Mon, 11 Nov 2019 18:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573497506;
        bh=V/BFtrfACRvAuMyvrEX6mCnc3UD+mqWzo5Lyq4xWR2s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DLsfiytpB0Kr72BDtMVKMvCWagAQRuS9Hqu6UVs7Z7JrBNu5D9pkAlU8mOEDjo9GJ
         sXSh68qyUOn1a5ILtccndL5fk2d5j+kBqsWXduEiKPM1CsEptGTjteMK1+AKKdsaV6
         bvEdGAq8/lxrA0O5Soy6wCSlqHz21WMjP2Qe4w4g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Himanshu Madhani <hmadhani@marvell.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 077/105] scsi: qla2xxx: Initialized mailbox to prevent driver load failure
Date:   Mon, 11 Nov 2019 19:28:47 +0100
Message-Id: <20191111181446.334591904@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181421.390326245@linuxfoundation.org>
References: <20191111181421.390326245@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Himanshu Madhani <hmadhani@marvell.com>

[ Upstream commit c2ff2a36eff60efb5e123c940115216d6bf65684 ]

This patch fixes issue with Gen7 adapter in a blade environment where one
of the ports will not be detected by driver. Firmware expects mailbox 11 to
be set or cleared by driver for newer ISP.

Following message is seen in the log file:

[   18.810892] qla2xxx [0000:d8:00.0]-1820:1: **** Failed=102 mb[0]=4005 mb[1]=37 mb[2]=20 mb[3]=8
[   18.819596]  cmd=2 ****

[mkp: typos]

Link: https://lore.kernel.org/r/20191022193643.7076-2-hmadhani@marvell.com
Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_mbx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_mbx.c b/drivers/scsi/qla2xxx/qla_mbx.c
index 929ec087b8eb3..459481ce5872d 100644
--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -624,6 +624,7 @@ qla2x00_execute_fw(scsi_qla_host_t *vha, uint32_t risc_addr)
 		mcp->mb[2] = LSW(risc_addr);
 		mcp->mb[3] = 0;
 		mcp->mb[4] = 0;
+		mcp->mb[11] = 0;
 		ha->flags.using_lr_setting = 0;
 		if (IS_QLA25XX(ha) || IS_QLA81XX(ha) || IS_QLA83XX(ha) ||
 		    IS_QLA27XX(ha)) {
@@ -667,7 +668,7 @@ qla2x00_execute_fw(scsi_qla_host_t *vha, uint32_t risc_addr)
 		if (ha->flags.exchoffld_enabled)
 			mcp->mb[4] |= ENABLE_EXCHANGE_OFFLD;
 
-		mcp->out_mb |= MBX_4|MBX_3|MBX_2|MBX_1;
+		mcp->out_mb |= MBX_4 | MBX_3 | MBX_2 | MBX_1 | MBX_11;
 		mcp->in_mb |= MBX_3 | MBX_2 | MBX_1;
 	} else {
 		mcp->mb[1] = LSW(risc_addr);
-- 
2.20.1



