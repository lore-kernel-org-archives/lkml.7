Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717C6C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4127C20896
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555963049;
	bh=30slvisgQtlwVkehq4wPXja1qk+sOWNEJDeZKNFCpas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=suRJgPmbNYOt68mzcuBdrEIEp8WbkPOhUtDbcM6Zo4S/Htop+k0KOq4nljB8cPEW8
	 0LbAEFfiScUWz+wNz05vT8l0gjni29Q4DDoj0nRRhWkz5vbHrNM0h7D7GW/eentjpm
	 M7I8AEYk5sGRB6l5cORpDltiyaHyzxgeJu3yiGKo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731701AbfDVT51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:57:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:52056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730590AbfDVTsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:48:39 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E34C2190C;
        Mon, 22 Apr 2019 19:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962518;
        bh=30slvisgQtlwVkehq4wPXja1qk+sOWNEJDeZKNFCpas=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IlEejUZ5lxbruv4a7obF/fCzHfJB4uc3rCz0q+0pz92ZbRO4PD72CTTJqjM6/l2Kh
         dHUy8ASxtAErIApNBevpx8OrQw4aE2IIU/Wi2kwT1d2x3T+OQIL2TLutL4mu/5vItw
         1pFICP8HiwHTuC5/CL8Voo/jEwcjtf0bC7H7YCpE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Steffen Maier <maier@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 37/43] scsi: zfcp: reduce flood of fcrscn1 trace records on multi-element RSCN
Date:   Mon, 22 Apr 2019 15:47:21 -0400
Message-Id: <20190422194727.12495-37-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194727.12495-1-sashal@kernel.org>
References: <20190422194727.12495-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steffen Maier <maier@linux.ibm.com>

[ Upstream commit c8206579175c34a2546de8a74262456278a7795a ]

If an incoming ELS of type RSCN contains more than one element, zfcp
suboptimally causes repeated erp trigger NOP trace records for each
previously failed port. These could be ports that went away.  It loops over
each RSCN element, and for each of those in an inner loop over all
zfcp_ports.

The trigger to recover failed ports should be just the reception of some
RSCN, no matter how many elements it has. So we can loop over failed ports
separately, and only then loop over each RSCN element to handle the
non-failed ports.

The call chain was:

  zfcp_fc_incoming_rscn
    for (i = 1; i < no_entries; i++)
      _zfcp_fc_incoming_rscn
        list_for_each_entry(port, &adapter->port_list, list)
          if (masked port->d_id match) zfcp_fc_test_link
          if (!port->d_id) zfcp_erp_port_reopen "fcrscn1"   <===

In order the reduce the "flooding" of the REC trace area in such cases, we
factor out handling the failed ports to be outside of the entries loop:

  zfcp_fc_incoming_rscn
    if (no_entries > 1)                                     <===
      list_for_each_entry(port, &adapter->port_list, list)  <===
        if (!port->d_id) zfcp_erp_port_reopen "fcrscn1"     <===
    for (i = 1; i < no_entries; i++)
      _zfcp_fc_incoming_rscn
        list_for_each_entry(port, &adapter->port_list, list)
          if (masked port->d_id match) zfcp_fc_test_link

Abbreviated example trace records before this code change:

Tag            : fcrscn1
WWPN           : 0x500507630310d327
ERP want       : 0x02
ERP need       : 0x02

Tag            : fcrscn1
WWPN           : 0x500507630310d327
ERP want       : 0x02
ERP need       : 0x00                 NOP => superfluous trace record

The last trace entry repeats if there are more than 2 RSCN elements.

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Reviewed-by: Jens Remus <jremus@linux.ibm.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/s390/scsi/zfcp_fc.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_fc.c b/drivers/s390/scsi/zfcp_fc.c
index ca218c82321f..0c5fd722a72d 100644
--- a/drivers/s390/scsi/zfcp_fc.c
+++ b/drivers/s390/scsi/zfcp_fc.c
@@ -240,10 +240,6 @@ static void _zfcp_fc_incoming_rscn(struct zfcp_fsf_req *fsf_req, u32 range,
 	list_for_each_entry(port, &adapter->port_list, list) {
 		if ((port->d_id & range) == (ntoh24(page->rscn_fid) & range))
 			zfcp_fc_test_link(port);
-		if (!port->d_id)
-			zfcp_erp_port_reopen(port,
-					     ZFCP_STATUS_COMMON_ERP_FAILED,
-					     "fcrscn1");
 	}
 	read_unlock_irqrestore(&adapter->port_list_lock, flags);
 }
@@ -251,6 +247,7 @@ static void _zfcp_fc_incoming_rscn(struct zfcp_fsf_req *fsf_req, u32 range,
 static void zfcp_fc_incoming_rscn(struct zfcp_fsf_req *fsf_req)
 {
 	struct fsf_status_read_buffer *status_buffer = (void *)fsf_req->data;
+	struct zfcp_adapter *adapter = fsf_req->adapter;
 	struct fc_els_rscn *head;
 	struct fc_els_rscn_page *page;
 	u16 i;
@@ -264,6 +261,22 @@ static void zfcp_fc_incoming_rscn(struct zfcp_fsf_req *fsf_req)
 	no_entries = be16_to_cpu(head->rscn_plen) /
 		sizeof(struct fc_els_rscn_page);
 
+	if (no_entries > 1) {
+		/* handle failed ports */
+		unsigned long flags;
+		struct zfcp_port *port;
+
+		read_lock_irqsave(&adapter->port_list_lock, flags);
+		list_for_each_entry(port, &adapter->port_list, list) {
+			if (port->d_id)
+				continue;
+			zfcp_erp_port_reopen(port,
+					     ZFCP_STATUS_COMMON_ERP_FAILED,
+					     "fcrscn1");
+		}
+		read_unlock_irqrestore(&adapter->port_list_lock, flags);
+	}
+
 	for (i = 1; i < no_entries; i++) {
 		/* skip head and start with 1st element */
 		page++;
-- 
2.19.1

