Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91289C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C020214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552411591;
	bh=2eEkeFv3Ijkx82mAt4FetS16ZxTvUki2475efXUyd+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aqs1ow53K1lJFzSIn+NTB7P3iIL4tBed/xZ5mpllmrcvslw5zzQhwowr/Vyk4uZPT
	 jBdtZ9SfLSEkNjEtO7HsnpIJbcVbz2pXgAD9CsBLXzcBcp+kN3Uf2Ee5uyc+je2lhe
	 V+nj3JWjV/A6Z1d4lFKtBfO46n8l4w3NMmDnUMX0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbfCLR0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:26:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:34032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728824AbfCLRRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:17:43 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3155621873;
        Tue, 12 Mar 2019 17:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552411063;
        bh=2eEkeFv3Ijkx82mAt4FetS16ZxTvUki2475efXUyd+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AZ1V/OPTnUO54LEEE4JO7GiOezHu556+VRIVYbJPPGEV2WfJlpT674I9sVCP/PlV3
         hf1uOgBwvSN0l6ziWnw9TYlgGouTa96yBSpdd+LejkxncZKYw8eVmzpMs2ge65/zei
         HOBM6fMvVI6UTiC7TdD5VyK1Gt+cah58lUhOPUNY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yao Liu <yotta.liu@ucloud.cn>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 52/96] nfs: Fix NULL pointer dereference of dev_name
Date:   Tue, 12 Mar 2019 10:10:10 -0700
Message-Id: <20190312171038.464069407@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312171034.530434962@linuxfoundation.org>
References: <20190312171034.530434962@linuxfoundation.org>
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
index 35aef192a13f..659ad12e33ba 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1904,6 +1904,11 @@ static int nfs_parse_devname(const char *dev_name,
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



