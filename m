Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE17C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 803AD2171F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552412413;
	bh=7NNu/woGCCXrFgZFX/fnbaD7B5SoyUs6s8v2nSBGivg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V2USDJq83vzwNTieSGN1m5CP3NiVQ8K1TX+zS1y4rmhGLZUayR4xnDK4sVJAXuFQ9
	 az+ykNJP4dy/31G3tH3M3/vKCZVBxOEXmt9ky1qCjtepnTVC/b5iI46FyW5eCXX43K
	 8003QfVvjCzTLHbNEA0bwgNgWiPRfm53tzAnLLJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbfCLRkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:40:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:58100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727783AbfCLRQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:16:16 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C00B2186A;
        Tue, 12 Mar 2019 17:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410975;
        bh=7NNu/woGCCXrFgZFX/fnbaD7B5SoyUs6s8v2nSBGivg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S3xTa1A9DsbvtxWHiyHClHLuPsPRfoPgKOE95rOHYCabt1Na6/rIdIQ024YOcCZZy
         v2E7WRiN+RAE4eQ1O0YSUcswIZvDKbqtudkDE3Uus67xRQEkLZsAJsY3VUzWCmLyN/
         oDuIkbKBQ6qbZhZ9m2nLH/M7vI9du6Ptk4DpLsjI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yao Liu <yotta.liu@ucloud.cn>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 066/135] nfs: Fix NULL pointer dereference of dev_name
Date:   Tue, 12 Mar 2019 10:08:33 -0700
Message-Id: <20190312170347.393615065@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170341.127810985@linuxfoundation.org>
References: <20190312170341.127810985@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 80ff00172407e0aad4b10b94ef0816fc3e7813cb ]

There is a NULL pointer dereference of dev_name in nfs_parse_devname()

The oops looks something like:

  BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
  ...
  RIP: 0010:nfs_fs_mount+0x3b6/0xc20 [nfs]
  ...
  Call Trace:
   ? ida_alloc_range+0x34b/0x3d0
   ? nfs_clone_super+0x80/0x80 [nfs]
   ? nfs_free_parsed_mount_data+0x60/0x60 [nfs]
   mount_fs+0x52/0x170
   ? __init_waitqueue_head+0x3b/0x50
   vfs_kern_mount+0x6b/0x170
   do_mount+0x216/0xdc0
   ksys_mount+0x83/0xd0
   __x64_sys_mount+0x25/0x30
   do_syscall_64+0x65/0x220
   entry_SYSCALL_64_after_hwframe+0x49/0xbe

Fix this by adding a NULL check on dev_name

Signed-off-by: Yao Liu <yotta.liu@ucloud.cn>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/super.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 3c4aeb83e1c4..77d8d03344c8 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1901,6 +1901,11 @@ static int nfs_parse_devname(const char *dev_name,
 	size_t len;
 	char *end;
 
+	if (unlikely(!dev_name || !*dev_name)) {
+		dfprintk(MOUNT, "NFS: device name not specified\n");
+		return -EINVAL;
+	}
+
 	/* Is the host name protected with square brakcets? */
 	if (*dev_name == '[') {
 		end = strchr(++dev_name, ']');
-- 
2.19.1



