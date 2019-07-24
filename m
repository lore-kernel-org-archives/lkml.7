Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5361C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7F6C22ADF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563997108;
	bh=8iN32L0qeQLNuko7HXQRfU7FMBzjxPBpOQu7uEFmhLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nnNlt7HXa1abyvLCyQIhrV5Ly6e1ZHCN45cFz1RT3TgGFRcbWJfkMD9NCu+3FzCyk
	 xGIti9LwyNF2N/uv+xiIAvwxA7BodTA+TXMrvw4HmZiO9s3aR8Z33ftR7rFpwh/9oa
	 tquKBv0w6eJ7du5KqP6daBPjOXUqnj0gI8BPMSCE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389629AbfGXTiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:38:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:38926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388838AbfGXTiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:38:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5320420665;
        Wed, 24 Jul 2019 19:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563997099;
        bh=8iN32L0qeQLNuko7HXQRfU7FMBzjxPBpOQu7uEFmhLg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e5iksZy8a1Zh6mK2BqG2hrA9RrdwH2RJ/om4+oe24Dhcb8JLnDNOkUTHZwvXTFzGp
         hk4Jav0goMELKbJBuTIPBn5CxYPEAyzmyRrefijoHBlGpIWNybXnKT9LU7QX/27fhO
         3dXCiSi7HH2TCHOaQujFbuaPXYrCi8Jz7+ZKqBQw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Luis Henriques <lhenriques@suse.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 5.2 320/413] ceph: fix end offset in truncate_inode_pages_range call
Date:   Wed, 24 Jul 2019 21:20:11 +0200
Message-Id: <20190724191758.783806568@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191735.096702571@linuxfoundation.org>
References: <20190724191735.096702571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luis Henriques <lhenriques@suse.com>

commit d31d07b97a5e76f41e00eb81dcca740e84aa7782 upstream.

Commit e450f4d1a5d6 ("ceph: pass inclusive lend parameter to
filemap_write_and_wait_range()") fixed the end offset parameter used to
call filemap_write_and_wait_range and invalidate_inode_pages2_range.
Unfortunately it missed truncate_inode_pages_range, introducing a
regression that is easily detected by xfstest generic/130.

The problem is that when doing direct IO it is possible that an extra page
is truncated from the page cache when the end offset is page aligned.
This can cause data loss if that page hasn't been sync'ed to the OSDs.

While there, change code to use PAGE_ALIGN macro instead.

Cc: stable@vger.kernel.org
Fixes: e450f4d1a5d6 ("ceph: pass inclusive lend parameter to filemap_write_and_wait_range()")
Signed-off-by: Luis Henriques <lhenriques@suse.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ceph/file.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1007,7 +1007,7 @@ ceph_direct_read_write(struct kiocb *ioc
 			 * may block.
 			 */
 			truncate_inode_pages_range(inode->i_mapping, pos,
-					(pos+len) | (PAGE_SIZE - 1));
+						   PAGE_ALIGN(pos + len) - 1);
 
 			req->r_mtime = mtime;
 		}


