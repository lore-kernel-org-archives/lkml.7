Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE25C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C1C821916
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254219;
	bh=Yt1FTaJdZnZJujHy8hZOiJmfm081DRQkx2AYG7WbUIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b2FvhdLjNCRY7WZ+CFSFThDfz4RBWHWhbJbiAzbZEK5XkkCGP6ElBiqkRHABHLFgv
	 v/P6SWcZR92f/P8D4ieN+ULmrOk0i0fEH2iSlhos5rA/mfNO65vIG3o5gcj51VllrC
	 0CC8z1/6lafU4ATsNI6tJV5IhWMDbRSJQiCed+Ss=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbfCVLaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:30:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:58194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729661AbfCVLaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:30:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DE0620449;
        Fri, 22 Mar 2019 11:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254214;
        bh=Yt1FTaJdZnZJujHy8hZOiJmfm081DRQkx2AYG7WbUIU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CYFuyu/2dOcXXr/4G1w9sDbuUGWB/1FG9YH8wbFSefDqQMa3KH1KxkDt7uT36sxfI
         WLagvuDK/28PuQjolVInYPqEeCGIUpBHZvD1pfmBDQRgIwjQEZbry7PBRB+KA+oVdf
         tR3C6eC5zDCUlRtCyYUwRGVrOm7NeBP4baGg6b34=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andreas Gruenbacher <agruenba@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4.4 059/230] sockfs: getxattr: Fail with -EOPNOTSUPP for invalid attribute names
Date:   Fri, 22 Mar 2019 12:13:17 +0100
Message-Id: <20190322111240.821173335@linuxfoundation.org>
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

From: Andreas Gruenbacher <agruenba@redhat.com>

commit 971df15bd54ad46e907046ff33750a137b2f0096 upstream.

The standard return value for unsupported attribute names is
-EOPNOTSUPP, as opposed to undefined but supported attributes
(-ENODATA).

Also, fail for attribute names like "system.sockprotonameXXX" and
simplify the code a bit.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
[removes a build warning on 4.4.y - gregkh]
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/socket.c |   24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

--- a/net/socket.c
+++ b/net/socket.c
@@ -470,27 +470,15 @@ static struct socket *sockfd_lookup_ligh
 static ssize_t sockfs_getxattr(struct dentry *dentry,
 			       const char *name, void *value, size_t size)
 {
-	const char *proto_name;
-	size_t proto_size;
-	int error;
-
-	error = -ENODATA;
-	if (!strncmp(name, XATTR_NAME_SOCKPROTONAME, XATTR_NAME_SOCKPROTONAME_LEN)) {
-		proto_name = dentry->d_name.name;
-		proto_size = strlen(proto_name);
-
+	if (!strcmp(name, XATTR_NAME_SOCKPROTONAME)) {
 		if (value) {
-			error = -ERANGE;
-			if (proto_size + 1 > size)
-				goto out;
-
-			strncpy(value, proto_name, proto_size + 1);
+			if (dentry->d_name.len + 1 > size)
+				return -ERANGE;
+			memcpy(value, dentry->d_name.name, dentry->d_name.len + 1);
 		}
-		error = proto_size + 1;
+		return dentry->d_name.len + 1;
 	}
-
-out:
-	return error;
+	return -EOPNOTSUPP;
 }
 
 static ssize_t sockfs_listxattr(struct dentry *dentry, char *buffer,


