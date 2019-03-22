Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94519C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63AC62082C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254720;
	bh=4L5dq1uD9iaN0XB/fWf/AgQLv56NgpwTyKXmpsSi0W8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R+pgjo9+oiYk5/Iy81XKq6xpp6/2dW4Zyj8uYW43JBO8voAsToyVv6K4rWL63+iBU
	 1qeG9CFUubiYHupjwOHpm9EeAFDc+tEUFB266bfWv2pdig9sWYcFXWe04oH7XaKCqV
	 5mFcB1L9yXERH86xJJ++XELFUgtfMbrkjh71E4S8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731004AbfCVLij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:38:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:40142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730993AbfCVLig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:38:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B7D2218B0;
        Fri, 22 Mar 2019 11:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254715;
        bh=4L5dq1uD9iaN0XB/fWf/AgQLv56NgpwTyKXmpsSi0W8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZM1b2ohgB/xe/BRh2ed8F51eNFZhISXM8cuhDsvXEugAiMMaQtSUJ3AjbGldgsK8F
         r5T6e1rpq49XrrPQjISHpNGUB2ak3N/pvAA97+P53nbrzsVjZSo7MIG198b6tPes/6
         EiepL+ECHwcOKBR+tfMoNEPG9CApDGhKnHqXyfAo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 4.4 220/230] NFS: Fix an I/O request leakage in nfs_do_recoalesce
Date:   Fri, 22 Mar 2019 12:15:58 +0100
Message-Id: <20190322111252.339230786@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1107,7 +1107,6 @@ static int nfs_do_recoalesce(struct nfs_
 			struct nfs_page *req;
 
 			req = list_first_entry(&head, struct nfs_page, wb_list);
-			nfs_list_remove_request(req);
 			if (__nfs_pageio_add_request(desc, req))
 				continue;
 			if (desc->pg_error < 0) {


