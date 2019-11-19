Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF7CC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D83482084D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574142317;
	bh=aIW5SCsQ78E/60clbtfozDFpW3dYpOdNi2zy8NoYgFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Qis89pXJjTGVyxdh/+uVpBpLp6G41xvW0Z1VL9VD7WEZnVEHt9iixnlwJP7PosMEh
	 h+jb/LDxzD0zWKD9ixDi7ZtOoJDp0B50c3OJJ2FkGriGsDQzNJJMd5GztvBH90cY2U
	 LsSakj/hThnMo08vGoxR8HycDx8QD17d7cVR4k1Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730946AbfKSFpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:45:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:40912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730935AbfKSFpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:45:15 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A4452071B;
        Tue, 19 Nov 2019 05:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142314;
        bh=aIW5SCsQ78E/60clbtfozDFpW3dYpOdNi2zy8NoYgFY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VQA8ab4tzAAIIx37Hb/D0nqXpb7fOrBWO8uymMdydxDCg+4pbn/0QO0LwB7JMNHmJ
         RPXrDHUhFxxEMEcizLsuS0JpGTSUQ8Wqsuanl1A2dYPPmwso7osWxft4NJFBCnnX3z
         1h6E0AtadLdDJHP5kTMXBrZFogVSLF9HgmCY+shY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Finn Thain <fthain@telegraphics.com.au>,
        Michael Schmitz <schmitzmic@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.14 004/239] scsi: core: Handle drivers which set sg_tablesize to zero
Date:   Tue, 19 Nov 2019 06:16:44 +0100
Message-Id: <20191119051257.618992876@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051255.850204959@linuxfoundation.org>
References: <20191119051255.850204959@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Schmitz <schmitzmic@gmail.com>

commit 9393c8de628cf0968d81a17cc11841e42191e041 upstream.

In scsi_mq_setup_tags(), cmd_size is calculated based on zero size for the
scatter-gather list in case the low level driver uses SG_NONE in its host
template.

cmd_size is passed on to the block layer for calculation of the request
size, and we've seen NULL pointer dereference errors from the block layer
in drivers where SG_NONE is used and a mq IO scheduler is active,
apparently as a consequence of this (see commit 68ab2d76e4be ("scsi:
cxlflash: Set sg_tablesize to 1 instead of SG_NONE"), and a recent patch by
Finn Thain converting the three m68k NFR5380 drivers to avoid setting
SG_NONE).

Try to avoid these errors by accounting for at least one sg list entry when
calculating cmd_size, regardless of whether the low level driver set a zero
sg_tablesize.

Tested on 030 m68k with the atari_scsi driver - setting sg_tablesize to
SG_NONE no longer results in a crash when loading this driver.

CC: Finn Thain <fthain@telegraphics.com.au>
Link: https://lore.kernel.org/r/1572922150-4358-1-git-send-email-schmitzmic@gmail.com
Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 drivers/scsi/scsi_lib.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2277,7 +2277,8 @@ int scsi_mq_setup_tags(struct Scsi_Host
 {
 	unsigned int cmd_size, sgl_size;
 
-	sgl_size = scsi_mq_sgl_size(shost);
+	sgl_size = max_t(unsigned int, sizeof(struct scatterlist),
+			scsi_mq_sgl_size(shost));
 	cmd_size = sizeof(struct scsi_cmnd) + shost->hostt->cmd_size + sgl_size;
 	if (scsi_host_get_prot(shost))
 		cmd_size += sizeof(struct scsi_data_buffer) + sgl_size;


