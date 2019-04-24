Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E539EC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABE7F20685
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556130236;
	bh=eAGlBkk79v9MDPWXqiQslpoUSPe55yzzRHhdaCRHgY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xGUUs/0FqSuBtpH3DOXM0FVXngBIUV86AQkl8E/eidPSGIGeVCiHqpxNrpEBwLk76
	 fl5mtL2UhXX+hYAhAEXZyIOkHJk3U1xSa7WwgMUvwRc8Ovfj6mF51TCK9f+tDh3dfN
	 zYVOjrBjn2oGCx2z6HgJfIlqVvw+NJhmP5X3K9vU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387612AbfDXSXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:23:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:35964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbfDXSXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 14:23:43 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00B452084F;
        Wed, 24 Apr 2019 18:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556130222;
        bh=eAGlBkk79v9MDPWXqiQslpoUSPe55yzzRHhdaCRHgY8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hzU39dB7Mb5LEDH+772DD6EUygszTnBsN9f8tSJjAGAcT1QwipIS05D5HGhukhr8i
         Rdg3Sxn+2Cu/4oAM2MWKjs5PUEOcfEbP24J45neKeqS1Zk9TBXBH4tMjQPg8AkI+ns
         M3VeOOVeGlF45dmtoWQHX0xDI/qtgswNkxDgc9RU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Saurav Kashyap <skashyap@marvell.com>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.19 59/96] Revert "scsi: fcoe: clear FC_RP_STARTED flags when receiving a LOGO"
Date:   Wed, 24 Apr 2019 19:10:04 +0200
Message-Id: <20190424170923.725970584@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170919.829037226@linuxfoundation.org>
References: <20190424170919.829037226@linuxfoundation.org>
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
@@ -2153,7 +2153,6 @@ static void fc_rport_recv_logo_req(struc
 		FC_RPORT_DBG(rdata, "Received LOGO request while in state %s\n",
 			     fc_rport_state(rdata));
 
-		rdata->flags &= ~FC_RP_STARTED;
 		fc_rport_enter_delete(rdata, RPORT_EV_STOP);
 		mutex_unlock(&rdata->rp_mutex);
 		kref_put(&rdata->kref, fc_rport_destroy);


