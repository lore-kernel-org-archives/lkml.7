Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C55C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50531233FD
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566495201;
	bh=q4onTBR6zS2Y3N1AAVKfOzKAZCjaWZP3uQTJPBHi15M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1qIb41imQ3lne4T+xGMbbKg6KdhdCk9iOStufcjmS5sy8QaX57G2p1iIhu1Ykbppl
	 0xs4bIYf1h/wBLVgeHYgCe2rAhsm8v8AijfOxKTLcqy6oMDAbLlBFHAgEgOtorQ7fg
	 N8G0xoTcUyEH0LUSoVqGvgU3XzTKQbNIgT4kRIAQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404207AbfHVRdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:33:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:48860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404440AbfHVRZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:25:30 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62C64206DD;
        Thu, 22 Aug 2019 17:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566494729;
        bh=q4onTBR6zS2Y3N1AAVKfOzKAZCjaWZP3uQTJPBHi15M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pU2OAP3kCWu6IJ7jAsyhoNxaEkeG3/RgFYhem1A+jzzNppCcMZcWXD/8uoj+pro2J
         FS8iTtit83iEByNcowGebCbZed0eZCf+aQ3vHqa+UUJ2oxbh8kp5a8njV0FgBvf7i2
         bk5pVVRxKjp56VjrQRlU80NDvypKDWuIq/vRTwwA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, NeilBrown <neilb@suse.com>,
        Sergei Turchanov <turchanov@farpost.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Markus Elfring <Markus.Elfring@web.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.19 02/85] seq_file: fix problem when seeking mid-record
Date:   Thu, 22 Aug 2019 10:18:35 -0700
Message-Id: <20190822171731.107842321@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190822171731.012687054@linuxfoundation.org>
References: <20190822171731.012687054@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: NeilBrown <neilb@suse.com>

commit 6a2aeab59e97101b4001bac84388fc49a992f87e upstream.

If you use lseek or similar (e.g.  pread) to access a location in a
seq_file file that is within a record, rather than at a record boundary,
then the first read will return the remainder of the record, and the
second read will return the whole of that same record (instead of the
next record).  When seeking to a record boundary, the next record is
correctly returned.

This bug was introduced by a recent patch (identified below).  Before
that patch, seq_read() would increment m->index when the last of the
buffer was returned (m->count == 0).  After that patch, we rely on
->next to increment m->index after filling the buffer - but there was
one place where that didn't happen.

Link: https://lkml.kernel.org/lkml/877e7xl029.fsf@notabene.neil.brown.name/
Fixes: 1f4aace60b0e ("fs/seq_file.c: simplify seq_file iteration code and interface")
Signed-off-by: NeilBrown <neilb@suse.com>
Reported-by: Sergei Turchanov <turchanov@farpost.com>
Tested-by: Sergei Turchanov <turchanov@farpost.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Markus Elfring <Markus.Elfring@web.de>
Cc: <stable@vger.kernel.org>	[4.19+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/seq_file.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -119,6 +119,7 @@ static int traverse(struct seq_file *m,
 		}
 		if (seq_has_overflowed(m))
 			goto Eoverflow;
+		p = m->op->next(m, p, &m->index);
 		if (pos + m->count > offset) {
 			m->from = offset - pos;
 			m->count -= m->from;
@@ -126,7 +127,6 @@ static int traverse(struct seq_file *m,
 		}
 		pos += m->count;
 		m->count = 0;
-		p = m->op->next(m, p, &m->index);
 		if (pos == offset)
 			break;
 	}


