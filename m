Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1260FC32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF32120862
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570121517;
	bh=ZSr+ymMHWbVbOK74oW3ZFZxpB4i/n3GUFDbjMk3BF4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NjK52p3nOTYDtKL25CqawVk8Q7FXS01CxcT/kYGERiCa+bZBZ6RY5d2cR6DE8eawQ
	 FFDEW15bKiqhFGHYdodzocyYpPuXbjy3dnymO3qbEmhnarq3/HjRb9RJ6PjrVf/Di+
	 s00pPKGxmrSze2pFdpSgjpk7ZwgxSh7kZwQENycM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406137AbfJCQv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:51:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:39406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406119AbfJCQvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:51:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B1942070B;
        Thu,  3 Oct 2019 16:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570121512;
        bh=ZSr+ymMHWbVbOK74oW3ZFZxpB4i/n3GUFDbjMk3BF4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lHs4O/YtM9njrA465XslMQku3rx7I4Zgk05cGR7PWHCZG4SBcolmgo7HEua6Bxo3G
         mTNDeb2G4JA2xWioipay09CLFaJfIEez9c81dJupzMyMDtY9Xkk4nFPfk0pZ36uzt/
         JjmqfJ79rluKlXAN5tvXLdsqAttH4e8AAPNGKBSg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Averin <vvs@virtuozzo.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 5.3 258/344] fuse: fix missing unlock_page in fuse_writepage()
Date:   Thu,  3 Oct 2019 17:53:43 +0200
Message-Id: <20191003154605.940029185@linuxfoundation.org>
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

From: Vasily Averin <vvs@virtuozzo.com>

commit d5880c7a8620290a6c90ced7a0e8bd0ad9419601 upstream.

unlock_page() was missing in case of an already in-flight write against the
same page.

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Fixes: ff17be086477 ("fuse: writepage: skip already in flight")
Cc: <stable@vger.kernel.org> # v3.13
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/fuse/file.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1767,6 +1767,7 @@ static int fuse_writepage(struct page *p
 		WARN_ON(wbc->sync_mode == WB_SYNC_ALL);
 
 		redirty_page_for_writepage(wbc, page);
+		unlock_page(page);
 		return 0;
 	}
 


