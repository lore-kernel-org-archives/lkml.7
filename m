Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892E7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 557F721929
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254191;
	bh=kcn9Cg2sdaMpNfr0NWEn+vTtfXkoDWU6CtDVACnJfQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sB/AUx/9l9gEsDgYAC9Me+O3zwDWwQpwdK0s0jV35K0hKY1bCpk/5c5f9jC7tYlCK
	 HVZdF3JIo6RIFdhS4qNC08RhJsJaB66Vbu+bWa1xnbtcAaWZdnVW2EyJe4hXrk3ZjT
	 JevFXGB2PMSgHjvGVA0WSsEAZkvhh63LgLGGJKu4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729864AbfCVL3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:29:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:57698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729064AbfCVL3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:29:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D1572183E;
        Fri, 22 Mar 2019 11:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254188;
        bh=kcn9Cg2sdaMpNfr0NWEn+vTtfXkoDWU6CtDVACnJfQk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kXYW3FYHQPu6Gqu43TeUp2+5cAxTdqDND/LYRPqoH4JnUI4Ho+thCAPSvNi1VWAMI
         QUpFKTFIyjAw3E2DArZihOzXtXuC9fmS8TVYBglP15MmsokTAVfVS3XyoGUAAuMx3i
         QOna8e0ZRdHzeWTpyEkr1b6r7E1VVVNKL1DweeOQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Varun Prakash <varun@chelsio.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 043/230] scsi: csiostor: fix NULL pointer dereference in csio_vport_set_state()
Date:   Fri, 22 Mar 2019 12:13:01 +0100
Message-Id: <20190322111239.736090026@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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



