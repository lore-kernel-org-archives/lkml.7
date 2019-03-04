Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B10C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C230521019
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551687792;
	bh=afWTkKlvY+yXLZUy2FdQff3MbsVGrYdX20qUCnOBCcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hlRRm0TVmQN1xynZo/XK/p2FOBenZrvZhSY41QGwdEzd3B1RjTwZHcNn8FQpaubAQ
	 xNautwkc+jbEiAZqTbDdvmw6mAkp/hFxxuA4X7zcPrDib9xEDpCoahmD607adZv41g
	 drR5/TUW1jDnKxyaCdwtNxnQrLc7VRAYGePgxuJ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfCDIXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:23:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:38522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726128AbfCDIXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:23:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D54EF20823;
        Mon,  4 Mar 2019 08:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551687789;
        bh=afWTkKlvY+yXLZUy2FdQff3MbsVGrYdX20qUCnOBCcg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c3zKMp+CIgkA3adsQu3cOCKp/gtoXeTOIe6P6EIuLsqjO6+kZ/F9MPUtMGDRwUGBx
         Fqs28cLzZUe9v/1HxrUN4tCWAzxJ13DvbwOWNAxzhQNVhWAVcxZYPZY7nRGuxZ+f8N
         RRTSUhC07nC8beLHmIfmrbmiIssAssJu+a/tOTGk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Varun Prakash <varun@chelsio.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 20/32] scsi: csiostor: fix NULL pointer dereference in csio_vport_set_state()
Date:   Mon,  4 Mar 2019 09:22:08 +0100
Message-Id: <20190304081603.741616267@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081602.307094059@linuxfoundation.org>
References: <20190304081602.307094059@linuxfoundation.org>
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

[ Upstream commit fe35a40e675473eb65f2f5462b82770f324b5689 ]

Assign fc_vport to ln->fc_vport before calling csio_fcoe_alloc_vnp() to
avoid a NULL pointer dereference in csio_vport_set_state().

ln->fc_vport is dereferenced in csio_vport_set_state().

Signed-off-by: Varun Prakash <varun@chelsio.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/csiostor/csio_attr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/csiostor/csio_attr.c b/drivers/scsi/csiostor/csio_attr.c
index 2d1c4ebd40f91..6587f20cff1a1 100644
--- a/drivers/scsi/csiostor/csio_attr.c
+++ b/drivers/scsi/csiostor/csio_attr.c
@@ -582,12 +582,12 @@ csio_vport_create(struct fc_vport *fc_vport, bool disable)
 	}
 
 	fc_vport_set_state(fc_vport, FC_VPORT_INITIALIZING);
+	ln->fc_vport = fc_vport;
 
 	if (csio_fcoe_alloc_vnp(hw, ln))
 		goto error;
 
 	*(struct csio_lnode **)fc_vport->dd_data = ln;
-	ln->fc_vport = fc_vport;
 	if (!fc_vport->node_name)
 		fc_vport->node_name = wwn_to_u64(csio_ln_wwnn(ln));
 	if (!fc_vport->port_name)
-- 
2.19.1



