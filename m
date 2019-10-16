Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF95ECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEC462067D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571264158;
	bh=UlGrKMgXgRaTB19PpiO2d5UObMhWdYR3TmQmAa+QV6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wgfd8B4SbYFYkG9+9UE5h4Nf/bLo2gRuuxrd4ZuhUv8+X3/6O9g/r5zabwuyJ2CZe
	 sBJiznTVi1BT47UWYrKqCqhaIWvT5pwCAxCxEV+6+m3vxhG+ytTsawO6rUOijmuTpR
	 gmyXdNB71afmR35yqZV14sGzSExkKAobVpVZuSSg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404328AbfJPWP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 18:15:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:45916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437764AbfJPVzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:55:19 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B50221925;
        Wed, 16 Oct 2019 21:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571262919;
        bh=UlGrKMgXgRaTB19PpiO2d5UObMhWdYR3TmQmAa+QV6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Iiny3qNw6RkHDUAA2bhOqyqfBYvRBSeLowPtTHCLzKwPQV8V0tEOdG3QMHsL0XZP9
         tDYEuxUe45oUeWBe4fnsvTQj6XaCjs/Mcj7QjU288oFA910qdScykjv55MPPrW6LmF
         YKskHLKby2v2w+yHLzuTHItA4C4ZwR8wbmiWJv1s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Shilovsky <pshilov@microsoft.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 4.9 79/92] CIFS: Gracefully handle QueryInfo errors during open
Date:   Wed, 16 Oct 2019 14:50:52 -0700
Message-Id: <20191016214846.622390456@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214759.600329427@linuxfoundation.org>
References: <20191016214759.600329427@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Shilovsky <piastryyy@gmail.com>

commit 30573a82fb179420b8aac30a3a3595aa96a93156 upstream.

Currently if the client identifies problems when processing
metadata returned in CREATE response, the open handle is being
leaked. This causes multiple problems like a file missing a lease
break by that client which causes high latencies to other clients
accessing the file. Another side-effect of this is that the file
can't be deleted.

Fix this by closing the file after the client hits an error after
the file was opened and the open descriptor wasn't returned to
the user space. Also convert -ESTALE to -EOPENSTALE to allow
the VFS to revalidate a dentry and retry the open.

Cc: <stable@vger.kernel.org>
Signed-off-by: Pavel Shilovsky <pshilov@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/file.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -252,6 +252,12 @@ cifs_nt_open(char *full_path, struct ino
 		rc = cifs_get_inode_info(&inode, full_path, buf, inode->i_sb,
 					 xid, fid);
 
+	if (rc) {
+		server->ops->close(xid, tcon, fid);
+		if (rc == -ESTALE)
+			rc = -EOPENSTALE;
+	}
+
 out:
 	kfree(buf);
 	return rc;


