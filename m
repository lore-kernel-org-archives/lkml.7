Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DD8C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1295A20685
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556130218;
	bh=FrklKEVBZ+ZP3e5fXTyO/1cuZSyl0eRhhyq9EH2QShM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1nUiw74miDgpB6YDpTbWe7JEMX+9N8R2pnwUcbTEfcGD0n5wCHQede6+3MtuH8S1U
	 XFIk6Sz3q1G+Ngc40rc08KQn/2TtOOZjMkGPdPwrB0LeCMaKx2yDtAHx/RAJ5xSldi
	 8SrxcCBSPKcG+9LuyT657xOXOwKbkUl2gws6qjGA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387517AbfDXSXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:23:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:35696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbfDXSXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 14:23:32 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0B7920685;
        Wed, 24 Apr 2019 18:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556130212;
        bh=FrklKEVBZ+ZP3e5fXTyO/1cuZSyl0eRhhyq9EH2QShM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1KhCR6Fkytcu+wNjUGsq0OO1btyk+fLf59Ny7w/FhyOMiWC1jv1BplQnrn3hauUV+
         JNtJ5QMwsfbZS0UPAw6rU1sP7TDdfXL7xJcEoppGlkFFH0414Px5PPmfuUMW0KlKLG
         SV/BDpVcDdJyZ+20ZkLBiR1gm0qDdhtr5JE/IrMQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Saurav Kashyap <skashyap@marvell.com>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.9 28/44] Revert "scsi: fcoe: clear FC_RP_STARTED flags when receiving a LOGO"
Date:   Wed, 24 Apr 2019 19:10:06 +0200
Message-Id: <20190424170858.176844686@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170839.924291114@linuxfoundation.org>
References: <20190424170839.924291114@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Saurav Kashyap <skashyap@marvell.com>

commit 0228034d8e5915b98c33db35a98f5e909e848ae9 upstream.

This patch clears FC_RP_STARTED flag during logoff, because of this
re-login(flogi) didn't happen to the switch.

This reverts commit 1550ec458e0cf1a40a170ab1f4c46e3f52860f65.

Fixes: 1550ec458e0c ("scsi: fcoe: clear FC_RP_STARTED flags when receiving a LOGO")
Cc: <stable@vger.kernel.org> # v4.18+
Signed-off-by: Saurav Kashyap <skashyap@marvell.com>
Reviewed-by: Hannes Reinecke <hare@#suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/libfc/fc_rport.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/scsi/libfc/fc_rport.c
+++ b/drivers/scsi/libfc/fc_rport.c
@@ -1935,7 +1935,6 @@ static void fc_rport_recv_logo_req(struc
 		FC_RPORT_DBG(rdata, "Received LOGO request while in state %s\n",
 			     fc_rport_state(rdata));
 
-		rdata->flags &= ~FC_RP_STARTED;
 		fc_rport_enter_delete(rdata, RPORT_EV_STOP);
 		mutex_unlock(&rdata->rp_mutex);
 		kref_put(&rdata->kref, rdata->local_port->tt.rport_destroy);


