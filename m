Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17859C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCC0E2133D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139100;
	bh=B6282QcvcZgLwAWL24ai6IIP92adM8eO1TB6SGv3vO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q5gxXlvZDDbgZLm8uclD5J4lftedhQTlINoXv1AurJ8uaB9ydWoFuQaAVBS1c/bJr
	 po468+jTnNGSxQGLe/MK9VJxfd1pBHMZ8GyiN36UDTrZozl4QS9vAgs65pEk4/oaL8
	 eCeFJSuH4beyWQRVLC3LnGd90mhRy2JqgoG+1AjM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731101AbfDARST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:18:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:45334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731331AbfDARSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:18:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39C47206C0;
        Mon,  1 Apr 2019 17:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139096;
        bh=B6282QcvcZgLwAWL24ai6IIP92adM8eO1TB6SGv3vO0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oVJJGK2GkpTS6BCipdG4qRk2Q5ASKDtayadv8OigKGMaoxb43ekTxOFDYfNpYqFyK
         sOSDxhrfnw1ZYYxpeEi7PH7UQOoAW53cJgIqwET6BGNIC4zM53ZbF24s22PoWBIrIZ
         NmPGqVc+TkW9OxMeRMhe0Nk1tAvOb3/IomAMhoTU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steffen Maier <maier@linux.ibm.com>,
        Jens Remus <jremus@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.19 075/134] scsi: zfcp: fix rport unblock if deleted SCSI devices on Scsi_Host
Date:   Mon,  1 Apr 2019 19:01:51 +0200
Message-Id: <20190401170051.410419425@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170044.243719205@linuxfoundation.org>
References: <20190401170044.243719205@linuxfoundation.org>
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

From: Steffen Maier <maier@linux.ibm.com>

commit fe67888fc007a76b81e37da23ce5bd8fb95890b0 upstream.

An already deleted SCSI device can exist on the Scsi_Host and remain there
because something still holds a reference.  A new SCSI device with the same
H:C:T:L and FCP device, target port WWPN, and FCP LUN can be created.  When
we try to unblock an rport, we still find the deleted SCSI device and
return early because the zfcp_scsi_dev of that SCSI device is not
ZFCP_STATUS_COMMON_UNBLOCKED. Hence we miss to unblock the rport, even if
the new proper SCSI device would be in good state.

Therefore, skip deleted SCSI devices when iterating the sdevs of the shost.
[cf. __scsi_device_lookup{_by_target}() or scsi_device_get()]

The following abbreviated trace sequence can indicate such problem:

Area           : REC
Tag            : ersfs_3
LUN            : 0x4045400300000000
WWPN           : 0x50050763031bd327
LUN status     : 0x40000000     not ZFCP_STATUS_COMMON_UNBLOCKED
Ready count    : n		not incremented yet
Running count  : 0x00000000
ERP want       : 0x01
ERP need       : 0xc1		ZFCP_ERP_ACTION_NONE

Area           : REC
Tag            : ersfs_3
LUN            : 0x4045400300000000
WWPN           : 0x50050763031bd327
LUN status     : 0x41000000
Ready count    : n+1
Running count  : 0x00000000
ERP want       : 0x01
ERP need       : 0x01

...

Area           : REC
Level          : 4		only with increased trace level
Tag            : ertru_l
LUN            : 0x4045400300000000
WWPN           : 0x50050763031bd327
LUN status     : 0x40000000
Request ID     : 0x0000000000000000
ERP status     : 0x01800000
ERP step       : 0x1000
ERP action     : 0x01
ERP count      : 0x00

NOT followed by a trace record with tag "scpaddy"
for WWPN 0x50050763031bd327.

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
Fixes: 6f2ce1c6af37 ("scsi: zfcp: fix rport unblock race with LUN recovery")
Cc: <stable@vger.kernel.org> #2.6.32+
Reviewed-by: Jens Remus <jremus@linux.ibm.com>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/s390/scsi/zfcp_erp.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/s390/scsi/zfcp_erp.c
+++ b/drivers/s390/scsi/zfcp_erp.c
@@ -1297,6 +1297,9 @@ static void zfcp_erp_try_rport_unblock(s
 		struct zfcp_scsi_dev *zsdev = sdev_to_zfcp(sdev);
 		int lun_status;
 
+		if (sdev->sdev_state == SDEV_DEL ||
+		    sdev->sdev_state == SDEV_CANCEL)
+			continue;
 		if (zsdev->port != port)
 			continue;
 		/* LUN under port of interest */


