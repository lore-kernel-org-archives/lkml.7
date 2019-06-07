Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58965C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27BC52146F
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559922109;
	bh=2E2IjA34qSo/fKNY3X8CRxHV6+s/N0e7D8LRd3pIZC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2tJh/7EUOUmUrRKo8hIQznb9wvauY+JwXyd6G2BSbXplmdfJIlQ3ySc2E5aI+JZoh
	 1MFa/XxIXeppTUjI7BfF2DHxdKM8en4nSMd3R9zj9pPfgT3FR+E9RjE832ACOM1mpd
	 ddzyNh8SqTysa5edudbMFHGbcPiG7sQsGMcJ3MPE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730402AbfFGPls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 11:41:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:51890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730382AbfFGPlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 11:41:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1028212F5;
        Fri,  7 Jun 2019 15:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559922106;
        bh=2E2IjA34qSo/fKNY3X8CRxHV6+s/N0e7D8LRd3pIZC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UIHZjz0IrbjNmoIlsXRZsxBJcF0sdSaFZavkl58DKrFaOX8s+NgNovjBKAhAJbf/R
         7TnYod80sps76sJGnViYN2jDnaZfBAJb/5bXpwQ41IuPCuX5MGRGPlMGP2WBIe+Rtn
         jQYA/XXMul5RZ+1SfqJLJTrWTwwHG3UTzJzViW2g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steffen Maier <maier@linux.ibm.com>,
        Jens Remus <jremus@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.14 37/69] scsi: zfcp: fix missing zfcp_port reference put on -EBUSY from port_remove
Date:   Fri,  7 Jun 2019 17:39:18 +0200
Message-Id: <20190607153852.950114634@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607153848.271562617@linuxfoundation.org>
References: <20190607153848.271562617@linuxfoundation.org>
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
@@ -264,6 +264,7 @@ static ssize_t zfcp_sysfs_port_remove_st
 	if (atomic_read(&port->units) > 0) {
 		retval = -EBUSY;
 		mutex_unlock(&zfcp_sysfs_port_units_mutex);
+		put_device(&port->dev); /* undo zfcp_get_port_by_wwpn() */
 		goto out;
 	}
 	/* port is about to be removed, so no more unit_add */


