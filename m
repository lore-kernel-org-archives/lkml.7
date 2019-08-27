Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FD7C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B559120828
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566892644;
	bh=LTa3tZMT1QUFsCBlez5QP3OhTvVIfcoJeWsBe+YjZis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i0Lb8jlsm97uQlZUHbn4gm9m2W2BVrtg8xyjS3GRT6Q3X9TRwWUsyFRenPfR+vMli
	 Nb3n9bqy01y9DNa/ygqjPHjKebOqdn4vW+rrIYJTqu5ZOSwYkrN+ekzoAfe5acLBpA
	 xx7jpcYFeDHv8v/CNs0xfJtLl4aWahGiRLk/THfY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730796AbfH0H5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 03:57:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:49524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729971AbfH0H5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 03:57:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FFBC206BF;
        Tue, 27 Aug 2019 07:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566892638;
        bh=LTa3tZMT1QUFsCBlez5QP3OhTvVIfcoJeWsBe+YjZis=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o0jPqbr2/0ieBloThJS0MqVuGlBUJXPx9glP9m/mqq9YqgZbmiHuU0S9Zx+5NnWFb
         yipwoPr8V78rxfxV/BkaOY0WAeGlbWIcKrZOXKRzTTnwcyAz4GEDmB2EDpgv2NwSAQ
         a0vPQew4yRDxgWTO3l4PE/y7bgC6GMsg7bzmwEfA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Erqi Chen <chenerqi@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 4.19 63/98] ceph: clear page dirty before invalidate page
Date:   Tue, 27 Aug 2019 09:50:42 +0200
Message-Id: <20190827072721.603745088@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190827072718.142728620@linuxfoundation.org>
References: <20190827072718.142728620@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Erqi Chen <chenerqi@gmail.com>

commit c95f1c5f436badb9bb87e9b30fd573f6b3d59423 upstream.

clear_page_dirty_for_io(page) before mapping->a_ops->invalidatepage().
invalidatepage() clears page's private flag, if dirty flag is not
cleared, the page may cause BUG_ON failure in ceph_set_page_dirty().

Cc: stable@vger.kernel.org
Link: https://tracker.ceph.com/issues/40862
Signed-off-by: Erqi Chen <chenerqi@gmail.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ceph/addr.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -913,8 +913,9 @@ get_more_pages:
 			if (page_offset(page) >= ceph_wbc.i_size) {
 				dout("%p page eof %llu\n",
 				     page, ceph_wbc.i_size);
-				if (ceph_wbc.size_stable ||
-				    page_offset(page) >= i_size_read(inode))
+				if ((ceph_wbc.size_stable ||
+				    page_offset(page) >= i_size_read(inode)) &&
+				    clear_page_dirty_for_io(page))
 					mapping->a_ops->invalidatepage(page,
 								0, PAGE_SIZE);
 				unlock_page(page);


