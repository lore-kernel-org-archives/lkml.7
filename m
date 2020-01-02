Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53525C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23B5A22B48
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578003643;
	bh=gvAaG+d7XPXErCZz0EtzFyx+y9qm2zos3QZhL5yM2yY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k7skwpdYJk/o6wZJzyTVqql6o8EARl+/wj7pBom4NSvSU6rmzosU2osC0IO7ql2lN
	 oE0p7iHpg+kenFiB/sQXKyr7qfk92eKpNcYIz2eHBpAPQkLRbRa7OvI421Vpd0ZroU
	 RnbDqk6boBCdPNMwn5lVEJrFMe03y11o7W6+SnJ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbgABWUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:20:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:38554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbgABWUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:20:40 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 103312253D;
        Thu,  2 Jan 2020 22:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578003639;
        bh=gvAaG+d7XPXErCZz0EtzFyx+y9qm2zos3QZhL5yM2yY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lqJqLnmJL02z96cpdJc72/BdCJQg/f4sYd05IWWSEzEsP8hKiNxLv7NIVEO9ojC/g
         wYQS7BQl1a0jUOu6aSXcfwxGzU7ZIVa9J4QFTHr+skIEcazFHpyELDPMWwlcrxAA4T
         XX2F1j82pJHFHlW77hZ2x+qGgfliHFPxY/FkrFac=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <jsmart2021@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 026/114] scsi: lpfc: Fix duplicate unreg_rpi error in port offline flow
Date:   Thu,  2 Jan 2020 23:06:38 +0100
Message-Id: <20200102220031.755670668@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220029.183913184@linuxfoundation.org>
References: <20200102220029.183913184@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Smart <jsmart2021@gmail.com>

[ Upstream commit 7cfd5639d99bec0d27af089d0c8c114330e43a72 ]

If the driver receives a login that is later then LOGO'd by the remote port
(aka ndlp), the driver, upon the completion of the LOGO ACC transmission,
will logout the node and unregister the rpi that is being used for the
node.  As part of the unreg, the node's rpi value is replaced by the
LPFC_RPI_ALLOC_ERROR value.  If the port is subsequently offlined, the
offline walks the nodes and ensures they are logged out, which possibly
entails unreg'ing their rpi values.  This path does not validate the node's
rpi value, thus doesn't detect that it has been unreg'd already.  The
replaced rpi value is then used when accessing the rpi bitmask array which
tracks active rpi values.  As the LPFC_RPI_ALLOC_ERROR value is not a valid
index for the bitmask, it may fault the system.

Revise the rpi release code to detect when the rpi value is the replaced
RPI_ALLOC_ERROR value and ignore further release steps.

Link: https://lore.kernel.org/r/20191105005708.7399-2-jsmart2021@gmail.com
Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc_sli.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index bd555f886d27..a801917d3c19 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -17867,6 +17867,13 @@ lpfc_sli4_alloc_rpi(struct lpfc_hba *phba)
 static void
 __lpfc_sli4_free_rpi(struct lpfc_hba *phba, int rpi)
 {
+	/*
+	 * if the rpi value indicates a prior unreg has already
+	 * been done, skip the unreg.
+	 */
+	if (rpi == LPFC_RPI_ALLOC_ERROR)
+		return;
+
 	if (test_and_clear_bit(rpi, phba->sli4_hba.rpi_bmask)) {
 		phba->sli4_hba.rpi_count--;
 		phba->sli4_hba.max_cfg_param.rpi_used--;
-- 
2.20.1



