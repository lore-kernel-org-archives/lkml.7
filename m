Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D260C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26A492147A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560443027;
	bh=JUTwg6JYVMcanXtm5O5FyNtXQi+NRAjPJmKWbUZPEa0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F0cFy2k1EDlBj1PryyTFR16edcZxTlMVbTI5ybJlD7RKFeFKV6l5DiwL0AhW7ddKf
	 T+Ie473gBNQFhtq0Ir0PND5QRlMJ8QbQdU0UhKKPKoY4Cf2BAL5ytuG3NIwQYWYCOD
	 CMYm2FfGV99k4Sd3tBy/c5IGDryBjGv5W/D+yazU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391235AbfFMQXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:23:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:54974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731011AbfFMIhg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:37:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E9CC2064A;
        Thu, 13 Jun 2019 08:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560415054;
        bh=JUTwg6JYVMcanXtm5O5FyNtXQi+NRAjPJmKWbUZPEa0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WAqL5yGaOPZp4ECIXPbiO/qhy9EPBa/9JGPqjeA1H5k03KyXpy0b7g2T3kMyVnkcO
         w5fpOjowoJnuvEomB0nPBurAEBxcYvr0OPzhxqmc/iM+XD2GPowSyDBhgWCcFVYAOO
         eAQFwq9POwPglB70uRjIggZaJINUGB74Lv/tPvCs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kirill Smelkov <kirr@nexedi.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Jakob Unterwurzacher <jakobunt@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 43/81] fuse: retrieve: cap requested size to negotiated max_write
Date:   Thu, 13 Jun 2019 10:33:26 +0200
Message-Id: <20190613075652.485457686@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190613075649.074682929@linuxfoundation.org>
References: <20190613075649.074682929@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 7640682e67b33cab8628729afec8ca92b851394f ]

FUSE filesystem server and kernel client negotiate during initialization
phase, what should be the maximum write size the client will ever issue.
Correspondingly the filesystem server then queues sys_read calls to read
requests with buffer capacity large enough to carry request header + that
max_write bytes. A filesystem server is free to set its max_write in
anywhere in the range between [1*page, fc->max_pages*page]. In particular
go-fuse[2] sets max_write by default as 64K, wheres default fc->max_pages
corresponds to 128K. Libfuse also allows users to configure max_write, but
by default presets it to possible maximum.

If max_write is < fc->max_pages*page, and in NOTIFY_RETRIEVE handler we
allow to retrieve more than max_write bytes, corresponding prepared
NOTIFY_REPLY will be thrown away by fuse_dev_do_read, because the
filesystem server, in full correspondence with server/client contract, will
be only queuing sys_read with ~max_write buffer capacity, and
fuse_dev_do_read throws away requests that cannot fit into server request
buffer. In turn the filesystem server could get stuck waiting indefinitely
for NOTIFY_REPLY since NOTIFY_RETRIEVE handler returned OK which is
understood by clients as that NOTIFY_REPLY was queued and will be sent
back.

Cap requested size to negotiate max_write to avoid the problem.  This
aligns with the way NOTIFY_RETRIEVE handler works, which already
unconditionally caps requested retrieve size to fuse_conn->max_pages.  This
way it should not hurt NOTIFY_RETRIEVE semantic if we return less data than
was originally requested.

Please see [1] for context where the problem of stuck filesystem was hit
for real, how the situation was traced and for more involving patch that
did not make it into the tree.

[1] https://marc.info/?l=linux-fsdevel&m=155057023600853&w=2
[2] https://github.com/hanwen/go-fuse

Signed-off-by: Kirill Smelkov <kirr@nexedi.com>
Cc: Han-Wen Nienhuys <hanwen@google.com>
Cc: Jakob Unterwurzacher <jakobunt@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/dev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1678,7 +1678,7 @@ static int fuse_retrieve(struct fuse_con
 	offset = outarg->offset & ~PAGE_MASK;
 	file_size = i_size_read(inode);
 
-	num = outarg->size;
+	num = min(outarg->size, fc->max_write);
 	if (outarg->offset > file_size)
 		num = 0;
 	else if (outarg->offset + num > file_size)


