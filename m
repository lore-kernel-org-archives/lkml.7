Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799A1ECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45579207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571263951;
	bh=UlGrKMgXgRaTB19PpiO2d5UObMhWdYR3TmQmAa+QV6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P7/XvrX/OYQxkRZXw2XWWY/6+tuZkeDCTSOYIztOfzytJ/ebQ5WUzANsKWbiO7OvQ
	 UT670DUJp1T+uox2/mSoT1ON9xBBMImiOMfAiKZWTse0uGyzze+G2zeT0GIN3LGi2Y
	 LgN5bHFVB4IxFJ1QCuCanBRd68WQwHbVVuVgr2AA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439253AbfJPWMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 18:12:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:47786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406613AbfJPV4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:56:17 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DABFF21925;
        Wed, 16 Oct 2019 21:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571262977;
        bh=UlGrKMgXgRaTB19PpiO2d5UObMhWdYR3TmQmAa+QV6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cwycZzVUMtW2QF7K8Kcg1yFoZislhG3nGQlYp1D0CkYHXaO4bmiasbCavMpsK7Zxk
         GV1WTMSNuM+zejZS1YUISFL6t8D25Jppw5O16b2QWIfAMc5xwotxbw/gyOCMaWiRUH
         aKODznVCOFyuEZ/6bfDUhioMJQIvb5XhzXnkvLhE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Shilovsky <pshilov@microsoft.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 4.14 46/65] CIFS: Gracefully handle QueryInfo errors during open
Date:   Wed, 16 Oct 2019 14:51:00 -0700
Message-Id: <20191016214834.485897161@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214756.457746573@linuxfoundation.org>
References: <20191016214756.457746573@linuxfoundation.org>
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


