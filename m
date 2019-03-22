Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D84C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63D1F21917
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257289;
	bh=99fDLY2VefQQ0muZGqq+a+40JBF6nXswHyx8SPqL7p8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EUTCo1oi4N3OxJ7LVhpCVdlcZDVL2O5BAQwsD97jm55Zvm4vQ3r+iWK0JIGwFJKEN
	 4n3WcTXNp7w0mwdxaAaFulnSdFaMoi21f7lYxd4RoPldPMVMU1FcLyV5xd77Dq0y06
	 cMW7Iv7u4H5UD8SvWptWRb9nniKV/UxVBj9rU+AQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390874AbfCVMV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:21:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:60468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390846AbfCVMVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:21:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4EDB2054F;
        Fri, 22 Mar 2019 12:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257283;
        bh=99fDLY2VefQQ0muZGqq+a+40JBF6nXswHyx8SPqL7p8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wmFhRGQXLNJUd2aOuwi9n52o8nfFZbqmpzbeU9oJ8utd0IEPKFZPuxvOlefSUQwL3
         UC90n9MOG/RHaPRNgAq+XtmFmaxjjxt7NqCwMwbKTLrRxpXcfu8zoUP65rUMjMIBmp
         nB8/4rkmFvSPW5tZvQCBhnLEF5PTwcDk5FaRZmk0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 5.0 185/238] NFS: Fix an I/O request leakage in nfs_do_recoalesce
Date:   Fri, 22 Mar 2019 12:16:44 +0100
Message-Id: <20190322111309.171271476@linuxfoundation.org>
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

From: Trond Myklebust <trond.myklebust@hammerspace.com>

commit 4d91969ed4dbcefd0e78f77494f0cb8fada9048a upstream.

Whether we need to exit early, or just reprocess the list, we
must not lost track of the request which failed to get recoalesced.

Fixes: 03d5eb65b538 ("NFS: Fix a memory leak in nfs_do_recoalesce")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: stable@vger.kernel.org # v4.0+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfs/pagelist.c |    1 -
 1 file changed, 1 deletion(-)

--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -1092,7 +1092,6 @@ static int nfs_do_recoalesce(struct nfs_
 			struct nfs_page *req;
 
 			req = list_first_entry(&head, struct nfs_page, wb_list);
-			nfs_list_remove_request(req);
 			if (__nfs_pageio_add_request(desc, req))
 				continue;
 			if (desc->pg_error < 0) {


