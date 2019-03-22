Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324ABC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F041C21A4A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256273;
	bh=75LcOqD5FzkA5yiD5y/jYnOWf1B9Iu8ZuoAyGYoX4No=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZrxGHCj7J8Ie7Y9sH+tHQPzML/MzJwtzTDDhnGsiUrXkJna9yWjZHs3ZV10g9v/Sa
	 Cvue+nHtSl1xS76SNTQ5xwfAQ30fKgzWhR3cQdDyU3V1P/J4OWw4s4a0gTZ1ONpFn6
	 gm/M/jl1U8EnlEVkNqO4lIEZxgz9wY4ALBU+lc18=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388682AbfCVMEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:04:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:42922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388316AbfCVME3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:04:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAB6621939;
        Fri, 22 Mar 2019 12:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256268;
        bh=75LcOqD5FzkA5yiD5y/jYnOWf1B9Iu8ZuoAyGYoX4No=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pHdBZq0yV1pajHNX9A6/gI395t0BYyqpn3TorpzlLoAGdGU8mww3U942dL2QklF47
         jglCXBvqa96Mz3TMWgRd5ZJ209C9NQqpQm0hjKG9dPFluFklKeWubNzok/O/FKGKa5
         Yoch7NTDbZPWgg8Ly9XCQfYVBKF0d97CBL2UguH0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Felipe Franciosi <felipe@nutanix.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.19 158/280] scsi: virtio_scsi: dont send sc payload with tmfs
Date:   Fri, 22 Mar 2019 12:15:11 +0100
Message-Id: <20190322111321.867627517@linuxfoundation.org>
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

Cc: stable@vger.kernel.org
Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/virtio_scsi.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -621,7 +621,6 @@ static int virtscsi_device_reset(struct
 		return FAILED;
 
 	memset(cmd, 0, sizeof(*cmd));
-	cmd->sc = sc;
 	cmd->req.tmf = (struct virtio_scsi_ctrl_tmf_req){
 		.type = VIRTIO_SCSI_T_TMF,
 		.subtype = cpu_to_virtio32(vscsi->vdev,
@@ -680,7 +679,6 @@ static int virtscsi_abort(struct scsi_cm
 		return FAILED;
 
 	memset(cmd, 0, sizeof(*cmd));
-	cmd->sc = sc;
 	cmd->req.tmf = (struct virtio_scsi_ctrl_tmf_req){
 		.type = VIRTIO_SCSI_T_TMF,
 		.subtype = VIRTIO_SCSI_T_TMF_ABORT_TASK,


