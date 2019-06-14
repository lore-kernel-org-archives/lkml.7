Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D09EC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2244F21721
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560519996;
	bh=5B3ZAjA7gOsgPJfhSPrsXHeb6ZPgy7neIaABFDQJVWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OrgugESi8+6n9NrP/sIYusZbn06bD2/z3Xzs20vSMWZKW/bAkkg6J+Gnn+ERJ1yhj
	 XFd3zy1pAS5kDqmy2TziqqRfbaU+Z9VrZOIZBFRH2eMaSVpm5kdOmw8UArYBr6kpfg
	 A9n54YlibTUBE0QvGqGW4mw0dMCXWlEo/MGwE/Ug=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbfFNNqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 09:46:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:41998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728467AbfFNNqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 09:46:31 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99FE821744;
        Fri, 14 Jun 2019 13:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560519990;
        bh=5B3ZAjA7gOsgPJfhSPrsXHeb6ZPgy7neIaABFDQJVWI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PEF60wV5RZE/wH/xodj6n79XiNZOV5arIxxiyGabEGOSpHi7CGGBaeIBKrnYVi9go
         ZUZe+lb3cDwJZm3yYaGbkRaY3TYbd1Mq28nFlZp7HXDYhB+ymmZtLtyd2zQaduN50p
         3vbdiTjDT+zB/lUtHyCI6t2XinzwhhvGPMXRcMko=
From:   Jeff Layton <jlayton@kernel.org>
To:     linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org
Cc:     akpm@linux-foundation.org, idryomov@gmail.com, zyan@redhat.com,
        sage@redhat.com, agruenba@redhat.com
Subject: [PATCH 3/3] ceph: return -ERANGE if virtual xattr value didn't fit in buffer
Date:   Fri, 14 Jun 2019 09:46:25 -0400
Message-Id: <20190614134625.6870-4-jlayton@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190614134625.6870-1-jlayton@kernel.org>
References: <20190614134625.6870-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The getxattr manpage states that we should return ERANGE if the
destination buffer size is too small to hold the value.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/xattr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index a1cd9613be98..e3246c27f2da 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -805,8 +805,11 @@ ssize_t __ceph_getxattr(struct inode *inode, const char *name, void *value,
 		if (err)
 			return err;
 		err = -ENODATA;
-		if (!(vxattr->exists_cb && !vxattr->exists_cb(ci)))
+		if (!(vxattr->exists_cb && !vxattr->exists_cb(ci))) {
 			err = vxattr->getxattr_cb(ci, value, size);
+			if (size && size < err)
+				err = -ERANGE;
+		}
 		return err;
 	}
 
-- 
2.21.0

