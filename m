Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D73C10F0C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBAE5206DD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554371808;
	bh=IuIdQ/rECfQxaPyl0GMbwCAiuWx3Mt4MebipYz9p0gI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0fMrByDyFT6btBBFfYaaU5/CkCLJ5CMkJP4HVqCpwPh/TaKCkk4UMR2gZspOubmTH
	 9QCW/HFccwZzBqr3+uQeX/HaXYftGfiZc+deKE7KZ9dzNo2UuATNScRA5S8XiBGVL/
	 2Fcz71r1Tt/jp+dghfpnnHZXk1xGnQ1gDIMcbksY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbfDDIuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:50:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:51556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728556AbfDDIuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:50:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 231592147C;
        Thu,  4 Apr 2019 08:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554367824;
        bh=IuIdQ/rECfQxaPyl0GMbwCAiuWx3Mt4MebipYz9p0gI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GA7xJ+hXodtyVnMgiccq/yOJv0bh0qhFaak0oj3M+SvD0GfMRCHov+I64wlv56E4Z
         YItY35+KI+kaVz9upQzJQMfynpGtk5KhCl5Crw6Exi/5f3CsqHkcwlX1Q0quDohDB2
         h0qINmKHr4KyEjhRGJRpYBGLHAHnHVDt1FoA/yV8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yao Liu <yotta.liu@ucloud.cn>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 26/91] cifs: Fix NULL pointer dereference of devname
Date:   Thu,  4 Apr 2019 10:47:10 +0200
Message-Id: <20190404084536.973601195@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084535.450029272@linuxfoundation.org>
References: <20190404084535.450029272@linuxfoundation.org>
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

[ Upstream commit 68e2672f8fbd1e04982b8d2798dd318bf2515dd2 ]

There is a NULL pointer dereference of devname in strspn()

The oops looks something like:

  CIFS: Attempting to mount (null)
  BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
  ...
  RIP: 0010:strspn+0x0/0x50
  ...
  Call Trace:
   ? cifs_parse_mount_options+0x222/0x1710 [cifs]
   ? cifs_get_volume_info+0x2f/0x80 [cifs]
   cifs_setup_volume_info+0x20/0x190 [cifs]
   cifs_get_volume_info+0x50/0x80 [cifs]
   cifs_smb3_do_mount+0x59/0x630 [cifs]
   ? ida_alloc_range+0x34b/0x3d0
   cifs_do_mount+0x11/0x20 [cifs]
   mount_fs+0x52/0x170
   vfs_kern_mount+0x6b/0x170
   do_mount+0x216/0xdc0
   ksys_mount+0x83/0xd0
   __x64_sys_mount+0x25/0x30
   do_syscall_64+0x65/0x220
   entry_SYSCALL_64_after_hwframe+0x49/0xbe

Fix this by adding a NULL check on devname in cifs_parse_devname()

Signed-off-by: Yao Liu <yotta.liu@ucloud.cn>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/connect.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 33e65b71c49a..f291ed0c155d 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -1201,6 +1201,11 @@ cifs_parse_devname(const char *devname, struct smb_vol *vol)
 	const char *delims = "/\\";
 	size_t len;
 
+	if (unlikely(!devname || !*devname)) {
+		cifs_dbg(VFS, "Device name not specified.\n");
+		return -EINVAL;
+	}
+
 	/* make sure we have a valid UNC double delimiter prefix */
 	len = strspn(devname, delims);
 	if (len != 2)
-- 
2.19.1



