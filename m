Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DA3C48BDB
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 19:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C590120651
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 19:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbfGGTjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 15:39:12 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:57776 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727633AbfGGTiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 15:38:14 -0400
Received: from 94.197.121.43.threembb.co.uk ([94.197.121.43] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hkCzC-0006iz-20; Sun, 07 Jul 2019 20:38:10 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hkCz8-0005en-1a; Sun, 07 Jul 2019 20:38:06 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        "Felipe Franciosi" <felipe@nutanix.com>
Date:   Sun, 07 Jul 2019 17:54:17 +0100
Message-ID: <lsq.1562518457.151317294@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 105/129] scsi: virtio_scsi: don't send sc payload
 with tmfs
In-Reply-To: <lsq.1562518456.876074874@decadent.org.uk>
X-SA-Exim-Connect-IP: 94.197.121.43
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.70-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Felipe Franciosi <felipe@nutanix.com>

commit 3722e6a52174d7c3a00e6f5efd006ca093f346c1 upstream.

The virtio scsi spec defines struct virtio_scsi_ctrl_tmf as a set of
device-readable records and a single device-writable response entry:

    struct virtio_scsi_ctrl_tmf
    {
        // Device-readable part
        le32 type;
        le32 subtype;
        u8 lun[8];
        le64 id;
        // Device-writable part
        u8 response;
    }

The above should be organised as two descriptor entries (or potentially
more if using VIRTIO_F_ANY_LAYOUT), but without any extra data after "le64
id" or after "u8 response".

The Linux driver doesn't respect that, with virtscsi_abort() and
virtscsi_device_reset() setting cmd->sc before calling virtscsi_tmf().  It
results in the original scsi command payload (or writable buffers) added to
the tmf.

This fixes the problem by leaving cmd->sc zeroed out, which makes
virtscsi_kick_cmd() add the tmf to the control vq without any payload.

Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/scsi/virtio_scsi.c | 2 --
 1 file changed, 2 deletions(-)

--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -631,7 +631,6 @@ static int virtscsi_device_reset(struct
 		return FAILED;
 
 	memset(cmd, 0, sizeof(*cmd));
-	cmd->sc = sc;
 	cmd->req.tmf = (struct virtio_scsi_ctrl_tmf_req){
 		.type = VIRTIO_SCSI_T_TMF,
 		.subtype = VIRTIO_SCSI_T_TMF_LOGICAL_UNIT_RESET,
@@ -654,7 +653,6 @@ static int virtscsi_abort(struct scsi_cm
 		return FAILED;
 
 	memset(cmd, 0, sizeof(*cmd));
-	cmd->sc = sc;
 	cmd->req.tmf = (struct virtio_scsi_ctrl_tmf_req){
 		.type = VIRTIO_SCSI_T_TMF,
 		.subtype = VIRTIO_SCSI_T_TMF_ABORT_TASK,

