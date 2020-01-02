Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6977BC3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E9F320848
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578005374;
	bh=lJQC4/Con0Ugxzstlc8xq8amDaSrx9aFFStPvk0jE1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wM0C8Oo6izZTOI1kblvL1b9+5TU23BTZTGnWtth8zT3nRUNPpDdnDa8ajkFQtxdtI
	 2xR6rPB8n3W4gxTb2xobxLPKeyHUEs6Y768niEuFHmgqm5xFAzGkmgrwCQWkg5AeV3
	 KAcF7a1AqLWpCakFK5zz2V587h882CPxT4uQgpSo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730896AbgABWtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:49:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:54416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729545AbgABW0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:26:45 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9225320863;
        Thu,  2 Jan 2020 22:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578004005;
        bh=lJQC4/Con0Ugxzstlc8xq8amDaSrx9aFFStPvk0jE1s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=su5u8NS2OKip20vXxZ+X+3srh1yzdTIZb8ukx5OnNgSw6Oc7ZHJoc7mm1tdD376Xj
         X3AJJIGo6+L3Hovb4N5q/i7vF1ER7zN4k8GZ0VJJYKdZ6ZjwqHO6OBzlNv085XLX/6
         weTkKpbT0yVlLmRZGSt9/Kt4AwuFE70/YhXiFKBY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Daniel Colascione <dancol@google.com>,
        Jann Horn <jannh@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Nick Kralevich <nnk@google.com>,
        Nosh Minwalla <nosh@google.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Tim Murray <timmurray@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 54/91] userfaultfd: require CAP_SYS_PTRACE for UFFD_FEATURE_EVENT_FORK
Date:   Thu,  2 Jan 2020 23:07:36 +0100
Message-Id: <20200102220438.300825166@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220356.856162165@linuxfoundation.org>
References: <20200102220356.856162165@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

[ Upstream commit 3c1c24d91ffd536de0a64688a9df7f49e58fadbc ]

A while ago Andy noticed
(http://lkml.kernel.org/r/CALCETrWY+5ynDct7eU_nDUqx=okQvjm=Y5wJvA4ahBja=CQXGw@mail.gmail.com)
that UFFD_FEATURE_EVENT_FORK used by an unprivileged user may have
security implications.

As the first step of the solution the following patch limits the availably
of UFFD_FEATURE_EVENT_FORK only for those having CAP_SYS_PTRACE.

The usage of CAP_SYS_PTRACE ensures compatibility with CRIU.

Yet, if there are other users of non-cooperative userfaultfd that run
without CAP_SYS_PTRACE, they would be broken :(

Current implementation of UFFD_FEATURE_EVENT_FORK modifies the file
descriptor table from the read() implementation of uffd, which may have
security implications for unprivileged use of the userfaultfd.

Limit availability of UFFD_FEATURE_EVENT_FORK only for callers that have
CAP_SYS_PTRACE.

Link: http://lkml.kernel.org/r/1572967777-8812-2-git-send-email-rppt@linux.ibm.com
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Reviewed-by: Andrea Arcangeli <aarcange@redhat.com>
Cc: Daniel Colascione <dancol@google.com>
Cc: Jann Horn <jannh@google.com>
Cc: Lokesh Gidra <lokeshgidra@google.com>
Cc: Nick Kralevich <nnk@google.com>
Cc: Nosh Minwalla <nosh@google.com>
Cc: Pavel Emelyanov <ovzxemul@gmail.com>
Cc: Tim Murray <timmurray@google.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/userfaultfd.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index a609d480606d..e2b2196fd942 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1807,13 +1807,12 @@ static int userfaultfd_api(struct userfaultfd_ctx *ctx,
 	if (copy_from_user(&uffdio_api, buf, sizeof(uffdio_api)))
 		goto out;
 	features = uffdio_api.features;
-	if (uffdio_api.api != UFFD_API || (features & ~UFFD_API_FEATURES)) {
-		memset(&uffdio_api, 0, sizeof(uffdio_api));
-		if (copy_to_user(buf, &uffdio_api, sizeof(uffdio_api)))
-			goto out;
-		ret = -EINVAL;
-		goto out;
-	}
+	ret = -EINVAL;
+	if (uffdio_api.api != UFFD_API || (features & ~UFFD_API_FEATURES))
+		goto err_out;
+	ret = -EPERM;
+	if ((features & UFFD_FEATURE_EVENT_FORK) && !capable(CAP_SYS_PTRACE))
+		goto err_out;
 	/* report all available features and ioctls to userland */
 	uffdio_api.features = UFFD_API_FEATURES;
 	uffdio_api.ioctls = UFFD_API_IOCTLS;
@@ -1826,6 +1825,11 @@ static int userfaultfd_api(struct userfaultfd_ctx *ctx,
 	ret = 0;
 out:
 	return ret;
+err_out:
+	memset(&uffdio_api, 0, sizeof(uffdio_api));
+	if (copy_to_user(buf, &uffdio_api, sizeof(uffdio_api)))
+		ret = -EFAULT;
+	goto out;
 }
 
 static long userfaultfd_ioctl(struct file *file, unsigned cmd,
-- 
2.20.1



