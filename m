Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48123C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EF8B2082E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576519701;
	bh=XbOkqfHcYzoxB/Wg8L63PoBiqIPSJL8OG1qVl1X2uFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tbsmO7jni72C1iMZR5jU7VKa/qWsZIWAJWjCWJVa/jJnzFMhLQj5Nn/V3MAQQr0L2
	 j06PU2t8uXX7CbW7Wh+SoMV5MrVmqcRDAwgQdSuAej44k83ZLEViG9nC9V5Y0ukWLN
	 SzxflSUJOIzRwTE6FD0aCpv7QJYFEgrqhtP4Afxg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730260AbfLPSIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:08:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:49716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730250AbfLPSIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:08:16 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3E86206E0;
        Mon, 16 Dec 2019 18:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519696;
        bh=XbOkqfHcYzoxB/Wg8L63PoBiqIPSJL8OG1qVl1X2uFg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VQSQhg5sfw+K5uulEVHKk3JEmRTGZ/MOHfMBy5V/4WqSFeDtDSZBIjbTo44owTq6G
         /uv0KPd7gXf9Qr3fVYedayLp3K52zD8AME2OIqYVPK99o0Ty+OdK5qkI6jjAta1C9F
         j9sGpWgKSDopZkNvL5VxHZ8H46I+dtlSVHb/v/Qk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Ewan D. Milne" <emilne@redhat.com>,
        Arun Easi <aeasi@marvell.com>,
        Himanshu Madhani <hmadhani@marvell.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 5.3 006/180] scsi: qla2xxx: Fix memory leak when sending I/O fails
Date:   Mon, 16 Dec 2019 18:47:26 +0100
Message-Id: <20191216174807.180209096@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174806.018988360@linuxfoundation.org>
References: <20191216174806.018988360@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arun Easi <aeasi@marvell.com>

commit 2f856d4e8c23f5ad5221f8da4a2f22d090627f19 upstream.

On heavy loads, a memory leak of the srb_t structure is observed.  This
would make the qla2xxx_srbs cache gobble up memory.

Fixes: 219d27d7147e0 ("scsi: qla2xxx: Fix race conditions in the code for aborting SCSI commands")
Cc: stable@vger.kernel.org # 5.2
Link: https://lore.kernel.org/r/20191105150657.8092-7-hmadhani@marvell.com
Reviewed-by: Ewan D. Milne <emilne@redhat.com>
Signed-off-by: Arun Easi <aeasi@marvell.com>
Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_os.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -947,6 +947,8 @@ qla2xxx_queuecommand(struct Scsi_Host *h
 
 qc24_host_busy_free_sp:
 	sp->free(sp);
+	CMD_SP(cmd) = NULL;
+	qla2x00_rel_sp(sp);
 
 qc24_host_busy:
 	return SCSI_MLQUEUE_HOST_BUSY;
@@ -1036,6 +1038,8 @@ qla2xxx_mqueuecommand(struct Scsi_Host *
 
 qc24_host_busy_free_sp:
 	sp->free(sp);
+	CMD_SP(cmd) = NULL;
+	qla2xxx_rel_qpair_sp(sp->qpair, sp);
 
 qc24_host_busy:
 	return SCSI_MLQUEUE_HOST_BUSY;


