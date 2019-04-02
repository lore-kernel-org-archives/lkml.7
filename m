Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A90C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9215920856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731567AbfDBNoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:44:54 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:43418 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731470AbfDBNkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:40:08 -0400
Received: from [167.98.27.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJe0-0002oJ-J5; Tue, 02 Apr 2019 14:40:04 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJdx-0004wl-JY; Tue, 02 Apr 2019 14:40:01 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Steve French" <stfrench@microsoft.com>,
        "Georgy A Bystrenin" <gkot@altlinux.org>,
        "Pavel Shilovsky" <pshilov@microsoft.com>
Date:   Tue, 02 Apr 2019 14:38:28 +0100
Message-ID: <lsq.1554212308.363964607@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 78/99] CIFS: Fix error mapping for SMB2_LOCK command
 which caused OFD lock problem
In-Reply-To: <lsq.1554212307.17110877@decadent.org.uk>
X-SA-Exim-Connect-IP: 167.98.27.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.65-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Georgy A Bystrenin <gkot@altlinux.org>

commit 9a596f5b39593414c0ec80f71b94a226286f084e upstream.

While resolving a bug with locks on samba shares found a strange behavior.
When a file locked by one node and we trying to lock it from another node
it fail with errno 5 (EIO) but in that case errno must be set to
(EACCES | EAGAIN).
This isn't happening when we try to lock file second time on same node.
In this case it returns EACCES as expected.
Also this issue not reproduces when we use SMB1 protocol (vers=1.0 in
mount options).

Further investigation showed that the mapping from status_to_posix_error
is different for SMB1 and SMB2+ implementations.
For SMB1 mapping is [NT_STATUS_LOCK_NOT_GRANTED to ERRlock]
(See fs/cifs/netmisc.c line 66)
but for SMB2+ mapping is [STATUS_LOCK_NOT_GRANTED to -EIO]
(see fs/cifs/smb2maperror.c line 383)

Quick changes in SMB2+ mapping from EIO to EACCES has fixed issue.

BUG: https://bugzilla.kernel.org/show_bug.cgi?id=201971

Signed-off-by: Georgy A Bystrenin <gkot@altlinux.org>
Reviewed-by: Pavel Shilovsky <pshilov@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/cifs/smb2maperror.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/cifs/smb2maperror.c
+++ b/fs/cifs/smb2maperror.c
@@ -377,8 +377,8 @@ static const struct status_to_posix_erro
 	{STATUS_NONEXISTENT_EA_ENTRY, -EIO, "STATUS_NONEXISTENT_EA_ENTRY"},
 	{STATUS_NO_EAS_ON_FILE, -ENODATA, "STATUS_NO_EAS_ON_FILE"},
 	{STATUS_EA_CORRUPT_ERROR, -EIO, "STATUS_EA_CORRUPT_ERROR"},
-	{STATUS_FILE_LOCK_CONFLICT, -EIO, "STATUS_FILE_LOCK_CONFLICT"},
-	{STATUS_LOCK_NOT_GRANTED, -EIO, "STATUS_LOCK_NOT_GRANTED"},
+	{STATUS_FILE_LOCK_CONFLICT, -EACCES, "STATUS_FILE_LOCK_CONFLICT"},
+	{STATUS_LOCK_NOT_GRANTED, -EACCES, "STATUS_LOCK_NOT_GRANTED"},
 	{STATUS_DELETE_PENDING, -ENOENT, "STATUS_DELETE_PENDING"},
 	{STATUS_CTL_FILE_NOT_SUPPORTED, -ENOSYS,
 	"STATUS_CTL_FILE_NOT_SUPPORTED"},

