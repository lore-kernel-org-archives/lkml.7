Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B42C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E0C221655
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564428777;
	bh=mlkORtITjZxHISIqZaxJ4GJmJwbK0kDZ++DsPoE+vRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sthfQxm9i4OFHfU3LX6NYy+FWZOGmkPg64XxCCt9DYAf+jA2mqyn/Xos+0lm/D5E7
	 V3G7GxxF7+Comvkz0yoqKCbztEmlMInaUzy5yv549V25uosZ0gpZIfVohk4/5QeooM
	 ySv99i5wYILx1w6v5j4KXbVKTj+n2YX9FM4uaRGc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730291AbfG2Tc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:32:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:46634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729378AbfG2Tcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:32:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDE0C21655;
        Mon, 29 Jul 2019 19:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564428772;
        bh=mlkORtITjZxHISIqZaxJ4GJmJwbK0kDZ++DsPoE+vRI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MPH+yUZYzXCwyeMWjL2OqGxrdIxhdN/KB82Hww3ZmfMzLNt69Oitln5Gek+1JIMj7
         UKAEYLT/MV4Q7KBDbbFiIiCCeJr6dRhI7aeCyuUjAgtrPz3jwysN4cflN/SSlZ+T+d
         mxBho6p/7APGdwxwvVCiF0d0f1aGJls3XPYKY+x8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 180/293] lib/strscpy: Shut up KASAN false-positives in strscpy()
Date:   Mon, 29 Jul 2019 21:21:11 +0200
Message-Id: <20190729190838.294287303@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190820.321094988@linuxfoundation.org>
References: <20190729190820.321094988@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 1a3241ff10d038ecd096d03380327f2a0b5840a6 ]

strscpy() performs the word-at-a-time optimistic reads.  So it may may
access the memory past the end of the object, which is perfectly fine
since strscpy() doesn't use that (past-the-end) data and makes sure the
optimistic read won't cross a page boundary.

Use new read_word_at_a_time() to shut up the KASAN.

Note that this potentially could hide some bugs.  In example bellow,
stscpy() will copy more than we should (1-3 extra uninitialized bytes):

        char dst[8];
        char *src;

        src = kmalloc(5, GFP_KERNEL);
        memset(src, 0xff, 5);
        strscpy(dst, src, 8);

Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/string.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/string.c b/lib/string.c
index 1530643edf00..33befc6ba3fa 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -203,7 +203,7 @@ ssize_t strscpy(char *dest, const char *src, size_t count)
 	while (max >= sizeof(unsigned long)) {
 		unsigned long c, data;
 
-		c = *(unsigned long *)(src+res);
+		c = read_word_at_a_time(src+res);
 		if (has_zero(c, &data, &constants)) {
 			data = prep_zero_mask(c, data, &constants);
 			data = create_zero_mask(data);
-- 
2.20.1



