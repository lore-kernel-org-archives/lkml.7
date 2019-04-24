Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED755C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B362B2190A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126202;
	bh=JYTsC0X+dz9DGNZNiAH/1wZX2PyBKd/GE1SlGGXBYUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JNxIr3BzsQH2TfvymAf9hiSzTpIDzimKn3c4fnkHcOg4v4udCSY+oFE5j6gU73dY4
	 LhUXDusL54RCL835FOQ5dQJTR49NKLX7Vsqze18LWGNrcwGQtXzig2sE9IG1HvMKaK
	 FVkBSeKAojPn+u00+SePl2ALqBvZ96zRw6x6zLIA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388473AbfDXRQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:16:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:41254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388441AbfDXRQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:16:38 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39D6C21905;
        Wed, 24 Apr 2019 17:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126197;
        bh=JYTsC0X+dz9DGNZNiAH/1wZX2PyBKd/GE1SlGGXBYUY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=joojgkLVJpDB7INlogRirfd7Mezjn/rcesxFbhFYvU7uaeUjsXRLrFP/EH7njLLOY
         /qYcCVVuJNLansPR2lcAzs2rlWVHBCzxppT0NFxhE7/Go2/yZLAYF3oKhlrAo9MoNl
         9u3GZCQJrrAC0IOfwfM+H2le6ffYpeopRNUCNjls=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yao Liu <yotta.liu@ucloud.cn>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 025/168] cifs: Fix NULL pointer dereference of devname
Date:   Wed, 24 Apr 2019 19:07:49 +0200
Message-Id: <20190424170925.153843364@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170923.452349382@linuxfoundation.org>
References: <20190424170923.452349382@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index eacf57c24ca9..9cb72fd40eff 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -1255,6 +1255,11 @@ cifs_parse_devname(const char *devname, struct smb_vol *vol)
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



