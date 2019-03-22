Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA05C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6377F2075E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553259544;
	bh=osM7iU4rVX6vtNBJXFMD9Sufd6dLhia/J2Fr21alZdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uFX2qq1pP6xSKHH+eJmi96dfEnF9rw2yl5We6voaKFzZYckzHpiVemsxtPmttrjoq
	 CN1Pr10ellPMPSguZNZOKMwuStiEHmAxHpQTCNXAqSj4GacTqws2wclJ3Si9f7T87J
	 EtSjBu8YWcL6zCuVm+/S/Cqa+3Cdzq7NxpV6KAqc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731867AbfCVLps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:45:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:48844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731974AbfCVLpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:45:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5EED2082C;
        Fri, 22 Mar 2019 11:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255143;
        bh=osM7iU4rVX6vtNBJXFMD9Sufd6dLhia/J2Fr21alZdI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tgs5wGkW/QSRpBf1yYpHRC45+wquThgO300EsI9//BUV1yUb2XZnapuMj6HYOCyPe
         Rq0izxblBFuX4qBzVy0ta140kdUion8aQm8y2wv0WhaEa4tpWldxMRpJGDO1zy6fC/
         9ptuRM+Az6k1Sf2m4Gr6PDJQTZo1e4QSXKn8HTUM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 4.9 102/118] NFS: Fix an I/O request leakage in nfs_do_recoalesce
Date:   Fri, 22 Mar 2019 12:16:14 +0100
Message-Id: <20190322111223.571231680@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111215.873964544@linuxfoundation.org>
References: <20190322111215.873964544@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1079,7 +1079,6 @@ static int nfs_do_recoalesce(struct nfs_
 			struct nfs_page *req;
 
 			req = list_first_entry(&head, struct nfs_page, wb_list);
-			nfs_list_remove_request(req);
 			if (__nfs_pageio_add_request(desc, req))
 				continue;
 			if (desc->pg_error < 0) {


