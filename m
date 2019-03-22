Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7EEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F1F021A4A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256967;
	bh=bdv9IgJWQ/NGIYgxLd0DZ9x4UTMTYAq4koQJm1+isTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cBAnbCNKHmjYY1i3D0aHhJzXLc98YHyRfsp/k3XM0k8/yRexAsogcSRyDud4btYI7
	 GdBRntAMPDwaF60eGK+PQBEEiUrwIzhwv/6tJCdp0IlcIMnMTLajxnOjBmTqUmsfpt
	 a0msOAgHp/HIlJL7wZ2a/WMd3e3URq1yFcsOq8U4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390157AbfCVMQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:16:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:54660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389602AbfCVMQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:16:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEEFA2082C;
        Fri, 22 Mar 2019 12:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256963;
        bh=bdv9IgJWQ/NGIYgxLd0DZ9x4UTMTYAq4koQJm1+isTg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QbFWDEz2HJRLFqp+sHQ2KG3Wup5LUQLffPHOM4jk6GI4qaSDh5g7xLeYU+2X2G9Gv
         7kXmKCJCgXfsGnCiXxN+hF7GfQh6Cpw2Bk1cNFJLRKm5S+OxPO3NVZBwrzmZ1KMGsk
         vpDQhG2nO0ZdKfxvZOgbAn8fsUG1oz58oI5fpEZE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Nadav Amit <namit@vmware.com>
Subject: [PATCH 5.0 059/238] vmw_balloon: release lock on error in vmballoon_reset()
Date:   Fri, 22 Mar 2019 12:14:38 +0100
Message-Id: <20190322111302.024400994@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>

commit d04071a5d6413b65f17f7bd6e2bdb22e22e4ace7 upstream.

We added some locking to this function but forgot to drop the lock on
these two error paths.  This bug would lead to an immediate deadlock.

Fixes: c7b3690fb152 ("vmw_balloon: stats rework")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: stable@vger.kernel.org
Reviewed-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/misc/vmw_balloon.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -1287,7 +1287,7 @@ static void vmballoon_reset(struct vmbal
 	vmballoon_pop(b);
 
 	if (vmballoon_send_start(b, VMW_BALLOON_CAPABILITIES))
-		return;
+		goto unlock;
 
 	if ((b->capabilities & VMW_BALLOON_BATCHED_CMDS) != 0) {
 		if (vmballoon_init_batching(b)) {
@@ -1298,7 +1298,7 @@ static void vmballoon_reset(struct vmbal
 			 * The guest will retry in one second.
 			 */
 			vmballoon_send_start(b, 0);
-			return;
+			goto unlock;
 		}
 	} else if ((b->capabilities & VMW_BALLOON_BASIC_CMDS) != 0) {
 		vmballoon_deinit_batching(b);
@@ -1314,6 +1314,7 @@ static void vmballoon_reset(struct vmbal
 	if (vmballoon_send_guest_id(b))
 		pr_err("failed to send guest ID to the host\n");
 
+unlock:
 	up_write(&b->conf_sem);
 }
 


