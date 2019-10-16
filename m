Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E4BFA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54F89207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571263613;
	bh=UlGrKMgXgRaTB19PpiO2d5UObMhWdYR3TmQmAa+QV6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=epoZ5/TS4U4I1yeFN4C5Ak3OB13GJqj+HqDz/q/gApWmuj519XzQTiDwk6mzWCvid
	 cR2C9RSJ3tsZGUfOS7d//cfLUQzbjZsIfueNKSjAx+S3qAQARk6dDHaNRKz411n/0I
	 z+7GR2OGtelY4poKycC12PowMDGG79de7dcrYfhE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406715AbfJPV6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 17:58:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:50178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438009AbfJPV53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:57:29 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 720DD21D7F;
        Wed, 16 Oct 2019 21:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571263048;
        bh=UlGrKMgXgRaTB19PpiO2d5UObMhWdYR3TmQmAa+QV6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M3NE6y4UTI0vR8aFjSA39lgx5oFApQ+pe2b6jNde/Ltrmng899uHinJ0ZxeEQ7MCv
         tEtGMWm4IsdVdyvczNCOcFyfLJJRmZoJj6ljQboidRwS0eR1PzOEMPH3ywLhLvRXd7
         NbsqcnnHErYGwXpqsu0zL3YqyrhkFodrX8w6w5v8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Shilovsky <pshilov@microsoft.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 4.19 53/81] CIFS: Gracefully handle QueryInfo errors during open
Date:   Wed, 16 Oct 2019 14:51:04 -0700
Message-Id: <20191016214841.532817992@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214805.727399379@linuxfoundation.org>
References: <20191016214805.727399379@linuxfoundation.org>
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


