Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27539C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E81592086A
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564739412;
	bh=rbdUCINXBgKYCp87cPrQVrS8D6nIsmFue30DS1f2waI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V1CeuJ2kOIAjgiYTnuR6AbFlxLzNvca08IJTFLlVr7nz+VwqRWgJx2HfNhalP0lJV
	 xPoL73AOJPQwy4VDzWDGXIMXaliQ6/2pEXTYoOgmf/sPC875Rakfqkdu2P50MV/M8b
	 KBFiS8bija8P/hfo0QEovrDjxIxQD/Sv0oCbUdTM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405540AbfHBJuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 05:50:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:49908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390950AbfHBJp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 05:45:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C52E217D4;
        Fri,  2 Aug 2019 09:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564739157;
        bh=rbdUCINXBgKYCp87cPrQVrS8D6nIsmFue30DS1f2waI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a013YNKoj98w4rIC/qEhvHKy8yIxb1uFIVogAXkH1ZyQPGkALz+GCbj+07Fu3sffQ
         B18RsWnHTmRkEqFhytaIciPnvwY9lZp3umYmHdI+b+SL9DalqXYIpVkGWGwIJ5iTG9
         64Ksv/I316IC6FsPZ4IHb8wNeDgEVvG1Leul+KVs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Tyler Hicks <tyhicks@canonical.com>
Subject: [PATCH 4.9 120/223] eCryptfs: fix a couple type promotion bugs
Date:   Fri,  2 Aug 2019 11:35:45 +0200
Message-Id: <20190802092246.963008457@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190802092238.692035242@linuxfoundation.org>
References: <20190802092238.692035242@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

commit 0bdf8a8245fdea6f075a5fede833a5fcf1b3466c upstream.

ECRYPTFS_SIZE_AND_MARKER_BYTES is type size_t, so if "rc" is negative
that gets type promoted to a high positive value and treated as success.

Fixes: 778aeb42a708 ("eCryptfs: Cleanup and optimize ecryptfs_lookup_interpose()")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
[tyhicks: Use "if/else if" rather than "if/if"]
Cc: stable@vger.kernel.org
Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ecryptfs/crypto.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -1034,8 +1034,10 @@ int ecryptfs_read_and_validate_header_re
 
 	rc = ecryptfs_read_lower(file_size, 0, ECRYPTFS_SIZE_AND_MARKER_BYTES,
 				 inode);
-	if (rc < ECRYPTFS_SIZE_AND_MARKER_BYTES)
-		return rc >= 0 ? -EINVAL : rc;
+	if (rc < 0)
+		return rc;
+	else if (rc < ECRYPTFS_SIZE_AND_MARKER_BYTES)
+		return -EINVAL;
 	rc = ecryptfs_validate_marker(marker);
 	if (!rc)
 		ecryptfs_i_size_init(file_size, inode);
@@ -1397,8 +1399,10 @@ int ecryptfs_read_and_validate_xattr_reg
 				     ecryptfs_inode_to_lower(inode),
 				     ECRYPTFS_XATTR_NAME, file_size,
 				     ECRYPTFS_SIZE_AND_MARKER_BYTES);
-	if (rc < ECRYPTFS_SIZE_AND_MARKER_BYTES)
-		return rc >= 0 ? -EINVAL : rc;
+	if (rc < 0)
+		return rc;
+	else if (rc < ECRYPTFS_SIZE_AND_MARKER_BYTES)
+		return -EINVAL;
 	rc = ecryptfs_validate_marker(marker);
 	if (!rc)
 		ecryptfs_i_size_init(file_size, inode);


