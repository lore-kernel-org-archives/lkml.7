Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37240C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0855B2192D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138517;
	bh=lNrv1STKj0RSHNKKD/VzvhY82ZwRYCBaCSXePyQ641Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YnxIM+/NMfSV4PRtJ0e3RbkR8g64t540ABz+9iPzOcI5fXraQcL1q6e8x9VDoGOVK
	 b3UTPd/d1wNmUuNYlElSAovCFoPa5u03liqUgIR44OEjMIhfBSXuhJljdsuEI6u5U/
	 7ldYuGyuur0VJTj7aJTlU84YRAuhPcu616kZB8l8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729657AbfDARIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:08:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:55124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728947AbfDARIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:08:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A4622192C;
        Mon,  1 Apr 2019 17:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138510;
        bh=lNrv1STKj0RSHNKKD/VzvhY82ZwRYCBaCSXePyQ641Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=symeqP7ewEYaCQmIa/5ac1Bl5GoMBbt8lMMC8RbbPer7w18SxssuAR2vQh5YrgFIz
         qtmJQzNRkYaP1aWhVsqPmVyCxWWMqRUnetNePEX8ub6R3atP17hIAeAiMbl1et6QYH
         PYkJpppHJZQzRKjSi17pdlHfHxZYYIAYAb/y7tyI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, NeilBrown <neilb@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 5.0 050/146] NFS: Fix nfs4_lock_state refcounting in nfs4_alloc_{lock,unlock}data()
Date:   Mon,  1 Apr 2019 19:01:02 +0200
Message-Id: <20190401170052.835539169@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
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

From: Catalin Marinas <catalin.marinas@arm.com>

commit 3028efe03be9c8c4cd7923f0f3c39b2871cc8a8f upstream.

Commit 7b587e1a5a6c ("NFS: use locks_copy_lock() to copy locks.")
changed the lock copying from memcpy() to the dedicated
locks_copy_lock() function. The latter correctly increments the
nfs4_lock_state.ls_count via nfs4_fl_copy_lock(), however, this refcount
has already been incremented in the nfs4_alloc_{lock,unlock}data().
Kmemleak subsequently reports an unreferenced nfs4_lock_state object as
below (arm64 platform):

unreferenced object 0xffff8000fce0b000 (size 256):
  comm "systemd-sysuser", pid 1608, jiffies 4294892825 (age 32.348s)
  hex dump (first 32 bytes):
    20 57 4c fb 00 80 ff ff 20 57 4c fb 00 80 ff ff   WL..... WL.....
    00 57 4c fb 00 80 ff ff 01 00 00 00 00 00 00 00  .WL.............
  backtrace:
    [<000000000d15010d>] kmem_cache_alloc+0x178/0x208
    [<00000000d7c1d264>] nfs4_set_lock_state+0x124/0x1f0
    [<000000009c867628>] nfs4_proc_lock+0x90/0x478
    [<000000001686bd74>] do_setlk+0x64/0xe8
    [<00000000e01500d4>] nfs_lock+0xe8/0x1f0
    [<000000004f387d8d>] vfs_lock_file+0x18/0x40
    [<00000000656ab79b>] do_lock_file_wait+0x68/0xf8
    [<00000000f17c4a4b>] fcntl_setlk+0x224/0x280
    [<0000000052a242c6>] do_fcntl+0x418/0x730
    [<000000004f47291a>] __arm64_sys_fcntl+0x84/0xd0
    [<00000000d6856e01>] el0_svc_common+0x80/0xf0
    [<000000009c4bd1df>] el0_svc_handler+0x2c/0x80
    [<00000000b1a0d479>] el0_svc+0x8/0xc
    [<0000000056c62a0f>] 0xffffffffffffffff

This patch removes the original refcount_inc(&lsp->ls_count) that was
paired with the memcpy() lock copying.

Fixes: 7b587e1a5a6c ("NFS: use locks_copy_lock() to copy locks.")
Cc: <stable@vger.kernel.org> # 5.0.x-
Cc: NeilBrown <neilb@suse.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfs/nfs4proc.c |    2 --
 1 file changed, 2 deletions(-)

--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -6306,7 +6306,6 @@ static struct nfs4_unlockdata *nfs4_allo
 	p->arg.seqid = seqid;
 	p->res.seqid = seqid;
 	p->lsp = lsp;
-	refcount_inc(&lsp->ls_count);
 	/* Ensure we don't close file until we're done freeing locks! */
 	p->ctx = get_nfs_open_context(ctx);
 	p->l_ctx = nfs_get_lock_context(ctx);
@@ -6531,7 +6530,6 @@ static struct nfs4_lockdata *nfs4_alloc_
 	p->res.lock_seqid = p->arg.lock_seqid;
 	p->lsp = lsp;
 	p->server = server;
-	refcount_inc(&lsp->ls_count);
 	p->ctx = get_nfs_open_context(ctx);
 	locks_init_lock(&p->fl);
 	locks_copy_lock(&p->fl, fl);


