Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AC0C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB1752063F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139664;
	bh=DGP/tI4HlW8oxP54t/O7Jm/PBmgCrFoWHM+FrOMatn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aAfg5qVhOWtOryEaOrwVztFrYtrfk3wWg9/Xx6XW72LiuapRvH7RYzdltwAAqctwL
	 wUkIs7LRCh75lXzzPZYaq5iuBWEe7KtlFSxABRJqQ6Pkt2hloktIT0BbAUvclUTFcY
	 T9nyfLqRp6ufKRD4x1aFsFgwpB/r6O5miGDZifyg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732696AbfDAR1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:27:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:33028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732687AbfDAR1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:27:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 529372063F;
        Mon,  1 Apr 2019 17:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139658;
        bh=DGP/tI4HlW8oxP54t/O7Jm/PBmgCrFoWHM+FrOMatn4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QWWMc9wq0ph/jiJAL+FPJbouyYLQlm7gFyTDVbeW7TbWXTvrFkskt0pT66sQlN+Cz
         JXTvMTAshQxkmJxhgjixIbmLDZ+L5PvVYSzFNBKf40MXxXe68U11KWP+E9MONgUoU9
         ClWlKgTPzNAk4Y5hkl6nsfIOHNak8LPoNrsBpPWY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steffen Maier <maier@linux.ibm.com>,
        Jens Remus <jremus@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.9 31/56] scsi: zfcp: fix scsi_eh host reset with port_forced ERP for non-NPIV FCP devices
Date:   Mon,  1 Apr 2019 19:02:47 +0200
Message-Id: <20190401170105.637062745@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170103.398401360@linuxfoundation.org>
References: <20190401170103.398401360@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steffen Maier <maier@linux.ibm.com>

commit 242ec1455151267fe35a0834aa9038e4c4670884 upstream.

Suppose more than one non-NPIV FCP device is active on the same channel.
Send I/O to storage and have some of the pending I/O run into a SCSI
command timeout, e.g. due to bit errors on the fibre. Now the error
situation stops. However, we saw FCP requests continue to timeout in the
channel. The abort will be successful, but the subsequent TUR fails.
Scsi_eh starts. The LUN reset fails. The target reset fails.  The host
reset only did an FCP device recovery. However, for non-NPIV FCP devices,
this does not close and reopen ports on the SAN-side if other non-NPIV FCP
device(s) share the same open ports.

In order to resolve the continuing FCP request timeouts, we need to
explicitly close and reopen ports on the SAN-side.

This was missing since the beginning of zfcp in v2.6.0 history commit
ea127f975424 ("[PATCH] s390 (7/7): zfcp host adapter.").

Note: The FSF requests for forced port reopen could run into FSF request
timeouts due to other reasons. This would trigger an internal FCP device
recovery. Pending forced port reopen recoveries would get dismissed. So
some ports might not get fully reopened during this host reset handler.
However, subsequent I/O would trigger the above described escalation and
eventually all ports would be forced reopen to resolve any continuing FCP
request timeouts due to earlier bit errors.

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: <stable@vger.kernel.org> #3.0+
Reviewed-by: Jens Remus <jremus@linux.ibm.com>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/s390/scsi/zfcp_erp.c  |   14 ++++++++++++++
 drivers/s390/scsi/zfcp_ext.h  |    2 ++
 drivers/s390/scsi/zfcp_scsi.c |    4 ++++
 3 files changed, 20 insertions(+)

--- a/drivers/s390/scsi/zfcp_erp.c
+++ b/drivers/s390/scsi/zfcp_erp.c
@@ -652,6 +652,20 @@ static void zfcp_erp_strategy_memwait(st
 	add_timer(&erp_action->timer);
 }
 
+void zfcp_erp_port_forced_reopen_all(struct zfcp_adapter *adapter,
+				     int clear, char *dbftag)
+{
+	unsigned long flags;
+	struct zfcp_port *port;
+
+	write_lock_irqsave(&adapter->erp_lock, flags);
+	read_lock(&adapter->port_list_lock);
+	list_for_each_entry(port, &adapter->port_list, list)
+		_zfcp_erp_port_forced_reopen(port, clear, dbftag);
+	read_unlock(&adapter->port_list_lock);
+	write_unlock_irqrestore(&adapter->erp_lock, flags);
+}
+
 static void _zfcp_erp_port_reopen_all(struct zfcp_adapter *adapter,
 				      int clear, char *id)
 {
--- a/drivers/s390/scsi/zfcp_ext.h
+++ b/drivers/s390/scsi/zfcp_ext.h
@@ -68,6 +68,8 @@ extern void zfcp_erp_clear_port_status(s
 extern int  zfcp_erp_port_reopen(struct zfcp_port *, int, char *);
 extern void zfcp_erp_port_shutdown(struct zfcp_port *, int, char *);
 extern void zfcp_erp_port_forced_reopen(struct zfcp_port *, int, char *);
+extern void zfcp_erp_port_forced_reopen_all(struct zfcp_adapter *adapter,
+					    int clear, char *dbftag);
 extern void zfcp_erp_set_lun_status(struct scsi_device *, u32);
 extern void zfcp_erp_clear_lun_status(struct scsi_device *, u32);
 extern void zfcp_erp_lun_reopen(struct scsi_device *, int, char *);
--- a/drivers/s390/scsi/zfcp_scsi.c
+++ b/drivers/s390/scsi/zfcp_scsi.c
@@ -326,6 +326,10 @@ static int zfcp_scsi_eh_host_reset_handl
 	struct zfcp_adapter *adapter = zfcp_sdev->port->adapter;
 	int ret = SUCCESS, fc_ret;
 
+	if (!(adapter->connection_features & FSF_FEATURE_NPIV_MODE)) {
+		zfcp_erp_port_forced_reopen_all(adapter, 0, "schrh_p");
+		zfcp_erp_wait(adapter);
+	}
 	zfcp_erp_adapter_reopen(adapter, 0, "schrh_1");
 	zfcp_erp_wait(adapter);
 	fc_ret = fc_block_scsi_eh(scpnt);


