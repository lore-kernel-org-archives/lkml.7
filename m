Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07EEC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72410227BF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576782724;
	bh=NEpL2CzNtWa8pl2T6jNiFSD8t5+OTKp74Cn9n98fZfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Krzq8s1qbrlaamX0PyYp57FG8mbMApeCqAFVR7pXHnkZqATAHxyd3iIqmymuGczBk
	 pygsYo4V0S3naBxQiFUH0dX56z5EoFdu6w6P8U2lu3jXwna7ILW2b82ebBmWpOA2u4
	 o98pwBxT/PMOCdUjUD7u7rtZiFv0x9pqtgJJ/QqQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbfLSTMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 14:12:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:55100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727384AbfLSSh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:37:27 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 908C820716;
        Thu, 19 Dec 2019 18:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576780647;
        bh=NEpL2CzNtWa8pl2T6jNiFSD8t5+OTKp74Cn9n98fZfI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Crz+OkuJno1y/BXpP1vu6s5b3lU5Q+0Y/+em1H8v5y+3cDkFNb+SyNlG1ZmEOKp/7
         UYTfp8OUq80tWp5WqkRyrNqWPnKuAmLj5FShc9cdLjbih9aBgWmC0a1qSu2sWo0H+x
         /EU14kSuuw1XT0sUQASb6y8Qd7HFbyEwoKHaEqkM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Shilovsky <pshilov@microsoft.com>,
        Aurelien Aptel <aaptel@suse.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 4.4 058/162] CIFS: Fix NULL-pointer dereference in smb2_push_mandatory_locks
Date:   Thu, 19 Dec 2019 19:32:46 +0100
Message-Id: <20191219183211.406082600@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183150.477687052@linuxfoundation.org>
References: <20191219183150.477687052@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Shilovsky <pshilov@microsoft.com>

commit 6f582b273ec23332074d970a7fb25bef835df71f upstream.

Currently when the client creates a cifsFileInfo structure for
a newly opened file, it allocates a list of byte-range locks
with a pointer to the new cfile and attaches this list to the
inode's lock list. The latter happens before initializing all
other fields, e.g. cfile->tlink. Thus a partially initialized
cifsFileInfo structure becomes available to other threads that
walk through the inode's lock list. One example of such a thread
may be an oplock break worker thread that tries to push all
cached byte-range locks. This causes NULL-pointer dereference
in smb2_push_mandatory_locks() when accessing cfile->tlink:

[598428.945633] BUG: kernel NULL pointer dereference, address: 0000000000000038
...
[598428.945749] Workqueue: cifsoplockd cifs_oplock_break [cifs]
[598428.945793] RIP: 0010:smb2_push_mandatory_locks+0xd6/0x5a0 [cifs]
...
[598428.945834] Call Trace:
[598428.945870]  ? cifs_revalidate_mapping+0x45/0x90 [cifs]
[598428.945901]  cifs_oplock_break+0x13d/0x450 [cifs]
[598428.945909]  process_one_work+0x1db/0x380
[598428.945914]  worker_thread+0x4d/0x400
[598428.945921]  kthread+0x104/0x140
[598428.945925]  ? process_one_work+0x380/0x380
[598428.945931]  ? kthread_park+0x80/0x80
[598428.945937]  ret_from_fork+0x35/0x40

Fix this by reordering initialization steps of the cifsFileInfo
structure: initialize all the fields first and then add the new
byte-range lock list to the inode's lock list.

Cc: Stable <stable@vger.kernel.org>
Signed-off-by: Pavel Shilovsky <pshilov@microsoft.com>
Reviewed-by: Aurelien Aptel <aaptel@suse.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/file.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -312,9 +312,6 @@ cifs_new_fileinfo(struct cifs_fid *fid,
 	INIT_LIST_HEAD(&fdlocks->locks);
 	fdlocks->cfile = cfile;
 	cfile->llist = fdlocks;
-	cifs_down_write(&cinode->lock_sem);
-	list_add(&fdlocks->llist, &cinode->llist);
-	up_write(&cinode->lock_sem);
 
 	cfile->count = 1;
 	cfile->pid = current->tgid;
@@ -338,6 +335,10 @@ cifs_new_fileinfo(struct cifs_fid *fid,
 		oplock = 0;
 	}
 
+	cifs_down_write(&cinode->lock_sem);
+	list_add(&fdlocks->llist, &cinode->llist);
+	up_write(&cinode->lock_sem);
+
 	spin_lock(&tcon->open_file_lock);
 	if (fid->pending_open->oplock != CIFS_OPLOCK_NO_CHANGE && oplock)
 		oplock = fid->pending_open->oplock;


