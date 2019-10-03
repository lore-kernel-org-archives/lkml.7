Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F25C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EA8C2054F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570121670;
	bh=Tek2S5ozdBKs5F5n9CWzI7W0uvZebdyiHH8VgKUx6vE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n7/jUT0Xt/qIAgAVNWAYd/8dwJLiRvWStRszlpkvE4hBnKf/92/1QuV+4TrRqEjAK
	 9x0RQzUwaRXIxj5FwDEMVAb3+I2/7GNOxc5F0x0UWnvQsefCfmjJIjDit3el7ZfsPq
	 Z6hFVdp04P8uDf4HvpT9RNsEMEZg+6hkiF+mv57M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406463AbfJCQy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:54:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:41544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406415AbfJCQxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:53:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 080FE20862;
        Thu,  3 Oct 2019 16:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570121609;
        bh=Tek2S5ozdBKs5F5n9CWzI7W0uvZebdyiHH8VgKUx6vE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Oc2QdUuNHHtExiv1wQzV0esZxyfMV7sQHg9EDiPEcqGHGp/rHVq8BBgwvCHSWJWYP
         G3bj7NRg/XAoqVXuvfb8VAA82uTIFrVr5Dp4OC+jJyaOdALNBbI1KKw+9g78H+2WKC
         M3+OBt07/4pKrHigeU1dUz8z/gdpufVcyh5QWqHw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pavel Shilovsky <pshilov@microsoft.com>,
        Steve French <stfrench@microsoft.com>,
        Aurelien Aptel <aaptel@suse.com>
Subject: [PATCH 5.3 305/344] smb3: fix unmount hang in open_shroot
Date:   Thu,  3 Oct 2019 17:54:30 +0200
Message-Id: <20191003154609.431149924@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154540.062170222@linuxfoundation.org>
References: <20191003154540.062170222@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steve French <stfrench@microsoft.com>

commit 96d9f7ed00b86104bf03adeffc8980897e9694ab upstream.

An earlier patch "CIFS: fix deadlock in cached root handling"
did not completely address the deadlock in open_shroot. This
patch addresses the deadlock.

In testing the recent patch:
  smb3: improve handling of share deleted (and share recreated)
we were able to reproduce the open_shroot deadlock to one
of the target servers in unmount in a delete share scenario.

Fixes: 7e5a70ad88b1e ("CIFS: fix deadlock in cached root handling")

This is version 2 of this patch. An earlier version of this
patch "smb3: fix unmount hang in open_shroot" had a problem
found by Dan.

Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

Suggested-by: Pavel Shilovsky <pshilov@microsoft.com>
Reviewed-by: Pavel Shilovsky <pshilov@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
CC: Aurelien Aptel <aaptel@suse.com>
CC: Stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/smb2ops.c |   21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -656,6 +656,15 @@ int open_shroot(unsigned int xid, struct
 		return 0;
 	}
 
+	/*
+	 * We do not hold the lock for the open because in case
+	 * SMB2_open needs to reconnect, it will end up calling
+	 * cifs_mark_open_files_invalid() which takes the lock again
+	 * thus causing a deadlock
+	 */
+
+	mutex_unlock(&tcon->crfid.fid_mutex);
+
 	if (smb3_encryption_required(tcon))
 		flags |= CIFS_TRANSFORM_REQ;
 
@@ -677,7 +686,7 @@ int open_shroot(unsigned int xid, struct
 
 	rc = SMB2_open_init(tcon, &rqst[0], &oplock, &oparms, &utf16_path);
 	if (rc)
-		goto oshr_exit;
+		goto oshr_free;
 	smb2_set_next_command(tcon, &rqst[0]);
 
 	memset(&qi_iov, 0, sizeof(qi_iov));
@@ -690,18 +699,10 @@ int open_shroot(unsigned int xid, struct
 				  sizeof(struct smb2_file_all_info) +
 				  PATH_MAX * 2, 0, NULL);
 	if (rc)
-		goto oshr_exit;
+		goto oshr_free;
 
 	smb2_set_related(&rqst[1]);
 
-	/*
-	 * We do not hold the lock for the open because in case
-	 * SMB2_open needs to reconnect, it will end up calling
-	 * cifs_mark_open_files_invalid() which takes the lock again
-	 * thus causing a deadlock
-	 */
-
-	mutex_unlock(&tcon->crfid.fid_mutex);
 	rc = compound_send_recv(xid, ses, flags, 2, rqst,
 				resp_buftype, rsp_iov);
 	mutex_lock(&tcon->crfid.fid_mutex);


