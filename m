Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E736BC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF5E921851
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558638981;
	bh=Ix5/FeW61euHB0eP6dvSiXYWjlbhF0GfmGarIiU1x9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Vo1NzB2ax8cot++PHXGIO6NEwt+8ro97nFIKZo0xLHRDKst5mv/HUPQlYGtEEHRg8
	 eO7ZaYois5+39uFi98zh7LPL2eWEtikQSLOA+P+0AKtsHqIhs2zfSWAfptzqs1G4Xn
	 Z4A74hYMl2cVFFkLSns+0LRV6PrvA2Q+xrjo5gyQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389171AbfEWTQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:16:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:50836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388746AbfEWTQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:16:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6C0E21872;
        Thu, 23 May 2019 19:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558638973;
        bh=Ix5/FeW61euHB0eP6dvSiXYWjlbhF0GfmGarIiU1x9w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xBS/gjYNlpkO9yfYaXw/TPKLy39hG6pwU4u2qn4smuI6EQF/kOidIBVdYm+SAwHBs
         apGGMyNXLRC9zSb7zIjaKKe/ghANCgPIFibogIGtUAmMLCVCiujh0zueTf8xK7v5MI
         qIJmXl/EK+Oi8QhIQmvi9V8jMFbwKbfjrVeXre7M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christoph Probst <kernel@probst.it>,
        Pavel Shilovsky <pshilov@microsoft.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 4.19 032/114] cifs: fix strcat buffer overflow and reduce raciness in smb21_set_oplock_level()
Date:   Thu, 23 May 2019 21:05:31 +0200
Message-Id: <20190523181734.714698055@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181731.372074275@linuxfoundation.org>
References: <20190523181731.372074275@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Probst <kernel@probst.it>

commit 6a54b2e002c9d00b398d35724c79f9fe0d9b38fb upstream.

Change strcat to strncpy in the "None" case to fix a buffer overflow
when cinode->oplock is reset to 0 by another thread accessing the same
cinode. It is never valid to append "None" to any other message.

Consolidate multiple writes to cinode->oplock to reduce raciness.

Signed-off-by: Christoph Probst <kernel@probst.it>
Reviewed-by: Pavel Shilovsky <pshilov@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
CC: Stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/smb2ops.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -2348,26 +2348,28 @@ smb21_set_oplock_level(struct cifsInodeI
 		       unsigned int epoch, bool *purge_cache)
 {
 	char message[5] = {0};
+	unsigned int new_oplock = 0;
 
 	oplock &= 0xFF;
 	if (oplock == SMB2_OPLOCK_LEVEL_NOCHANGE)
 		return;
 
-	cinode->oplock = 0;
 	if (oplock & SMB2_LEASE_READ_CACHING_HE) {
-		cinode->oplock |= CIFS_CACHE_READ_FLG;
+		new_oplock |= CIFS_CACHE_READ_FLG;
 		strcat(message, "R");
 	}
 	if (oplock & SMB2_LEASE_HANDLE_CACHING_HE) {
-		cinode->oplock |= CIFS_CACHE_HANDLE_FLG;
+		new_oplock |= CIFS_CACHE_HANDLE_FLG;
 		strcat(message, "H");
 	}
 	if (oplock & SMB2_LEASE_WRITE_CACHING_HE) {
-		cinode->oplock |= CIFS_CACHE_WRITE_FLG;
+		new_oplock |= CIFS_CACHE_WRITE_FLG;
 		strcat(message, "W");
 	}
-	if (!cinode->oplock)
-		strcat(message, "None");
+	if (!new_oplock)
+		strncpy(message, "None", sizeof(message));
+
+	cinode->oplock = new_oplock;
 	cifs_dbg(FYI, "%s Lease granted on inode %p\n", message,
 		 &cinode->vfs_inode);
 }


