Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E615FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B149C20830
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256620;
	bh=09aIOyI70gQXR+jr8TFYqBMl+INShINlyyinLzz1tDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JsLBwITWjlyrYcX7s7i+aOoaTF6GGdpWncC6MKQ4IPg4ajbjqJqvMzNsfMvAqAXVn
	 7lvakTsl+dTfclUS3MreDKwVyAb3AdGZmYnx+uPibQiTJ4b4BlCuP5xRqorSnYJ+OW
	 BsdvkCU8Ys9Q8BiRiPbQNcuhmG+3mQ+tDSd+vtQQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389412AbfCVMKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:10:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:48664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388767AbfCVMKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:10:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B28292083D;
        Fri, 22 Mar 2019 12:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256613;
        bh=09aIOyI70gQXR+jr8TFYqBMl+INShINlyyinLzz1tDQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yCUwKT9Iq08mYeQEkTZrf6FGLOnSl2DHsV4JwRk2PK7lEBOYhr0NegM7OxON6A96c
         sl0SvosL8jPxsQbGdhyU6NQaUj+Nycf1+lBbINAwNfbuivWm/NwYjMeC/cyzeyFb80
         kXUyeuF9UH7jmLDz1+KLD6Lhi+oYmT3sgCn7FQ0Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 4.19 242/280] NFS: Dont recoalesce on error in nfs_pageio_complete_mirror()
Date:   Fri, 22 Mar 2019 12:16:35 +0100
Message-Id: <20190322111339.650436523@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trond Myklebust <trond.myklebust@hammerspace.com>

commit 8127d82705998568b52ac724e28e00941538083d upstream.

If the I/O completion failed with a fatal error, then we should just
exit nfs_pageio_complete_mirror() rather than try to recoalesce.

Fixes: a7d42ddb3099 ("nfs: add mirroring support to pgio layer")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: stable@vger.kernel.org # v4.0+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfs/pagelist.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -1214,7 +1214,7 @@ static void nfs_pageio_complete_mirror(s
 		desc->pg_mirror_idx = mirror_idx;
 	for (;;) {
 		nfs_pageio_doio(desc);
-		if (!mirror->pg_recoalesce)
+		if (desc->pg_error < 0 || !mirror->pg_recoalesce)
 			break;
 		if (!nfs_do_recoalesce(desc))
 			break;


