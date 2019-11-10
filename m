Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AFDBC17443
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 10:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0113620B7C
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 10:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="ufoWTRou"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfKJKB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 05:01:29 -0500
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:48004 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726054AbfKJKB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 05:01:28 -0500
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 746532E1459;
        Sun, 10 Nov 2019 13:01:25 +0300 (MSK)
Received: from sas2-2e05890d47f7.qloud-c.yandex.net (sas2-2e05890d47f7.qloud-c.yandex.net [2a02:6b8:c08:bd8e:0:640:2e05:890d])
        by mxbackcorp2j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id b3sPY8d0b7-1NIWcp3L;
        Sun, 10 Nov 2019 13:01:25 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1573380085; bh=JkrJKaQCoeMVMNpYM6A4ENaFoYgIY430dh7P5rPIWZg=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=ufoWTRoukGGjWaEF4BgMJjO32U2nf5kXJINGOTFlJn3moI9EIwG/xm1hHOJmT6AmB
         8ylmMrEbmZT2b9+c682iDw0RGMBSyHlTIDRVwb4B0J5CkSeIvKXC3srNHqfZ233f5r
         kzz2iCNsGzCfWCf1CGqhNOUykVFs2BnZP4j8jm9M=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:8554:53c0:3d75:2e8a])
        by sas2-2e05890d47f7.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id nt2r9pmPtT-1NUSDqjh;
        Sun, 10 Nov 2019 13:01:23 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH] fs/splice: ignore flag SPLICE_F_GIFT in syscall vmsplice
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Date:   Sun, 10 Nov 2019 13:01:23 +0300
Message-ID: <157338008330.5347.7117089871769008055.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generic support of flag SPLICE_F_MOVE in syscall splice was removed in
kernel 2.6.21 commit 485ddb4b9741 ("1/2 splice: dont steal").
Infrastructure stay intact and this feature may came back.
At least driver or filesystem could provide own implementation.

But stealing mapped pages from userspace never worked and is very
unlikely that will ever make sense due to unmapping overhead.
Also lru handling is broken if gifted anon page spliced into file.

Let's seal entry point for marking page as a gift in vmsplice.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Link: https://lore.kernel.org/lkml/CAHk-=wgPQutQ8d8kUCvAFi+hfNWgaNLiZPkbg-GXY2DCtD-Z5Q@mail.gmail.com/
---
 fs/splice.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 98412721f056..71dbdd78bfd1 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1288,9 +1288,6 @@ static long vmsplice_to_pipe(struct file *file, struct iov_iter *iter,
 	long ret = 0;
 	unsigned buf_flag = 0;
 
-	if (flags & SPLICE_F_GIFT)
-		buf_flag = PIPE_BUF_FLAG_GIFT;
-
 	pipe = get_pipe_info(file);
 	if (!pipe)
 		return -EBADF;

