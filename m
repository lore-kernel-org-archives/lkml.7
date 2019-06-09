Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B0CC28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDFC2207E0
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560100020;
	bh=4R8I0anYL8C+6celks3uMq5Egv2NRBLlrT7oH8hkW/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I+buoasEZR2BIwqAZO6YPXHzxgsiI4OAwMhNych8eSNhJvA8E7vJ9KN+EGW9/6dpV
	 fCiHRmhT4ivkzOt+B6/5ki1x2Lrr9yvBeImGudhf0d30qpsmxbLO1diyyEHzndgU3l
	 gpLwwDByg701/PzqWPJylUycUDIhgC0oEzJS4vFQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389117AbfFIRG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 13:06:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:46956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388593AbfFIRG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 13:06:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA44B204EC;
        Sun,  9 Jun 2019 17:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560100017;
        bh=4R8I0anYL8C+6celks3uMq5Egv2NRBLlrT7oH8hkW/Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2nRSwVZSrAzc16/7tWSq6m0VZsaQe0v0rt2ZWD1/liWSYDItMAT5LKsvgKKPN6Zx+
         8XXvA0BOc7RBTKxo8ixS0ENujEb6QimbkGrIsprgWW0RHqTfVE1CpMscDj4prMCufx
         kOw2RYqwH0NSVtCjvVYVLofLL3N/ezHozbLxT8ok=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.4 236/241] fuse: fallocate: fix return with locked inode
Date:   Sun,  9 Jun 2019 18:42:58 +0200
Message-Id: <20190609164155.580504874@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164147.729157653@linuxfoundation.org>
References: <20190609164147.729157653@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miklos Szeredi <mszeredi@redhat.com>

commit 35d6fcbb7c3e296a52136347346a698a35af3fda upstream.

Do the proper cleanup in case the size check fails.

Tested with xfstests:generic/228

Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: 0cbade024ba5 ("fuse: honor RLIMIT_FSIZE in fuse_file_fallocate")
Cc: Liu Bo <bo.liu@linux.alibaba.com>
Cc: <stable@vger.kernel.org> # v3.5
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/fuse/file.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2951,7 +2951,7 @@ static long fuse_file_fallocate(struct f
 	    offset + length > i_size_read(inode)) {
 		err = inode_newsize_ok(inode, offset + length);
 		if (err)
-			return err;
+			goto out;
 	}
 
 	if (!(mode & FALLOC_FL_KEEP_SIZE))


