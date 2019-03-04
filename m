Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ACC7C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 009FA21473
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688603;
	bh=LhQbXAlQE1zve/fm15sBd6/AzGR316Nb0JZ40Rc5XfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jqaDil1RfSFteB1+0IAtl6ghFNc/T0ipBNyZDxfT0Z1DG8wlOOFVIVoWJwSPsFTEt
	 MEsro0VV+zXzLUgUa1nKqKIKPKQAdDrKoJF+Jeqe/58qw3OV+qBtME7SspwNDiuuNz
	 OMLpTb4lgt7eOBihcanDTojbCM0cnQXXyT5SM7yE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbfCDIgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:36:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:46264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727875AbfCDIgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:36:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED2E0208E4;
        Mon,  4 Mar 2019 08:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688594;
        bh=LhQbXAlQE1zve/fm15sBd6/AzGR316Nb0JZ40Rc5XfE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XTDUIN211gzMzoV1rrTSAGJ77SOgBLtVCAMUt9x7pmgyq9LmA1V7DRhXGqKgtnMcz
         VaNuepb7syjXWLlYecs6Gy3/f6/XUfjyCOPOrJJjUSj30XP4d0ZbR9Tk+rQQNm+GCv
         VyJQ3jiLT3V/pIcxGuC+RbL/6ZyMhiljC9ekFLWQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Varun Prakash <varun@chelsio.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 48/88] scsi: csiostor: fix NULL pointer dereference in csio_vport_set_state()
Date:   Mon,  4 Mar 2019 09:22:31 +0100
Message-Id: <20190304081632.457005165@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081630.610632175@linuxfoundation.org>
References: <20190304081630.610632175@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
index 8a004036e3d72..9bd2bd8dc2be2 100644
--- a/drivers/scsi/csiostor/csio_attr.c
+++ b/drivers/scsi/csiostor/csio_attr.c
@@ -594,12 +594,12 @@ csio_vport_create(struct fc_vport *fc_vport, bool disable)
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



