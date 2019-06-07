Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C8CC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1D782133D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559923036;
	bh=HdXLLbnf8rw5OHKudvKLv+NAnayS1t8PN8VRj+p2nVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xnelilqvtDYn2E3mX7QIiCrackrGpOzQTOkxBtBIcTIEL2ZN53WtFMczW+sbZzWf+
	 X4cg7PyIASNTGJ3YPJDA4uilVp6j68GKbStKxWyVrGbHHsldwOxHhW7WqoFZoaV3Df
	 NZ8TAZ8nZBvJcn1ixg7D6WnUgRWUH0lkIbdnVR98=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730133AbfFGPoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 11:44:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:55396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730979AbfFGPoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 11:44:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6797221479;
        Fri,  7 Jun 2019 15:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559922242;
        bh=HdXLLbnf8rw5OHKudvKLv+NAnayS1t8PN8VRj+p2nVY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kGWGz0+zG8jdUqSaV2KXkAJKkcy2kfbH55ECRodsqTEATa5h9Fw/MSSWJUA7ll/LN
         ELT7LMCWjN8IUmRZvc1o0K1vyAxoAH9dgeTD9V//BZa1gf0+5LpDstUDcU1VY/Q0V/
         QE7tJHz3aolgFD+wluXC8n5HvzFRcYjla1gcNDik=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steffen Maier <maier@linux.ibm.com>,
        Jens Remus <jremus@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.19 18/73] scsi: zfcp: fix missing zfcp_port reference put on -EBUSY from port_remove
Date:   Fri,  7 Jun 2019 17:39:05 +0200
Message-Id: <20190607153850.958139599@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607153848.669070800@linuxfoundation.org>
References: <20190607153848.669070800@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steffen Maier <maier@linux.ibm.com>

commit d27e5e07f9c49bf2a6a4ef254ce531c1b4fb5a38 upstream.

With this early return due to zfcp_unit child(ren), we don't use the
zfcp_port reference from the earlier zfcp_get_port_by_wwpn() anymore and
need to put it.

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
Fixes: d99b601b6338 ("[SCSI] zfcp: restore refcount check on port_remove")
Cc: <stable@vger.kernel.org> #3.7+
Reviewed-by: Jens Remus <jremus@linux.ibm.com>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/s390/scsi/zfcp_sysfs.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/s390/scsi/zfcp_sysfs.c
+++ b/drivers/s390/scsi/zfcp_sysfs.c
@@ -261,6 +261,7 @@ static ssize_t zfcp_sysfs_port_remove_st
 	if (atomic_read(&port->units) > 0) {
 		retval = -EBUSY;
 		mutex_unlock(&zfcp_sysfs_port_units_mutex);
+		put_device(&port->dev); /* undo zfcp_get_port_by_wwpn() */
 		goto out;
 	}
 	/* port is about to be removed, so no more unit_add */


