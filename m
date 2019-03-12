Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C319C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6568F21734
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552412917;
	bh=FMH7wI9VRhclJGSs2kOZjIXfi553yztuqNvKuCDYOP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ai5RY6XJn6yKrkE+xMo2M4+eicLYwauor/WzDhFG5Jqq8811i+xjMA6R5PZTLFe0i
	 Km7GNLCQSYFxfp2ATlkpxsgE+F4/amm+7lLJS1y6kRmYTelAGByzKgf6iAxPnapuNt
	 T2uolontmVVqvY1c6PYHPxRiJ/bnzOfpF1uJft4w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbfCLRsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:48:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:54582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728579AbfCLRPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:15:00 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B85CA21741;
        Tue, 12 Mar 2019 17:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410899;
        bh=FMH7wI9VRhclJGSs2kOZjIXfi553yztuqNvKuCDYOP0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pxXlh2dCyDNWGJDb48W+bSgSY7HmTl7JcdgR7YxdbFfFVBg5WmhHOkUxIijVgCj3V
         bnhcq3sdFG/W1Rx/ttVhBL30L27YRIqeCm7JopgSCf+nyOCidN+u1ypC+6MQY4RCoZ
         0us+cpVDIgXwIfj40zrNQSD4ScJVzolmoX3SCf44=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ross Lagerwall <ross.lagerwall@citrix.com>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 112/149] Revert "scsi: libfc: Add WARN_ON() when deleting rports"
Date:   Tue, 12 Mar 2019 10:08:50 -0700
Message-Id: <20190312170358.868418630@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170349.421581206@linuxfoundation.org>
References: <20190312170349.421581206@linuxfoundation.org>
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

[ Upstream commit d8f6382a7d026989029e2e50c515df954488459b ]

This reverts commit bbc0f8bd88abefb0f27998f40a073634a3a2db89.

It added a warning whose intent was to check whether the rport was still
linked into the peer list. It doesn't work as intended and gives false
positive warnings for two reasons:

1) If the rport is never linked into the peer list it will not be
considered empty since the list_head is never initialized.

2) If the rport is deleted from the peer list using list_del_rcu(), then
the list_head is in an undefined state and it is not considered empty.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/libfc/fc_rport.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/libfc/fc_rport.c b/drivers/scsi/libfc/fc_rport.c
index 372387a450df..1797e47fab38 100644
--- a/drivers/scsi/libfc/fc_rport.c
+++ b/drivers/scsi/libfc/fc_rport.c
@@ -184,7 +184,6 @@ void fc_rport_destroy(struct kref *kref)
 	struct fc_rport_priv *rdata;
 
 	rdata = container_of(kref, struct fc_rport_priv, kref);
-	WARN_ON(!list_empty(&rdata->peers));
 	kfree_rcu(rdata, rcu);
 }
 EXPORT_SYMBOL(fc_rport_destroy);
-- 
2.19.1



