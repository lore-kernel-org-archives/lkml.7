Return-Path: <SRS0=7h0X=2M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEF7C2D0C0
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 12:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 612F62067C
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 12:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JEARhVaw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfLVMfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 07:35:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30897 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726189AbfLVMfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 07:35:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577018107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=NK/+oH5PS+9JogKOeHE773KhmgeeUExyinl8Dzq73ME=;
        b=JEARhVawUeg3A1rV+xCvT4sj0fJoNH2kW8x0roqyUhgEJ03HG6uDC79JVYPi/wOG7Hr03w
        Pl9cevHtXXvgWKKAqasZrlaJGR+KHGQ1JVoHVcb+15xEHZ6t/dmCP/zptR1VjDvoilAP45
        lUd+8e1QNOiGMIopK+nZyqLNDQaJvt0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-110-hfmQO_ZBMzm7W1Z2L0kHSA-1; Sun, 22 Dec 2019 07:35:00 -0500
X-MC-Unique: hfmQO_ZBMzm7W1Z2L0kHSA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B6B88100550E;
        Sun, 22 Dec 2019 12:34:59 +0000 (UTC)
Received: from dustball.brq.redhat.com (unknown [10.43.17.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1B46663F8A;
        Sun, 22 Dec 2019 12:34:57 +0000 (UTC)
From:   Jan Stancek <jstancek@redhat.com>
To:     torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, rasibley@redhat.com, jstancek@redhat.com
Subject: [PATCH] pipe: fix empty pipe check in pipe_write()
Date:   Sun, 22 Dec 2019 13:33:24 +0100
Message-Id: <65b22cd4e8bb142c5b7b86bc33fb08de6f318089.1577017472.git.jstancek@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LTP pipeio_1 test is hanging with v5.5-rc2-385-gb8e382a185eb,
with read side observing empty pipe and sleeping and write
side running out of space and then sleeping as well. In this
scenario there are 5 writers and 1 reader.

Problem is that after pipe_write() reacquires pipe lock, it
re-checks for empty pipe with potentially stale 'head' and
doesn't wake up read side anymore. pipe->tail can advance
beyond 'head', because there are multiple writers.

Use pipe->head for empty pipe check after reacquiring lock
to observe current state.

Testing: With patch, LTP pipeio_1 ran successfully in loop for 1 hour.
         Without patch it hanged within a minute.

Fixes: 1b6b26ae7053 ("pipe: fix and clarify pipe write wakeup logic")
Reported-by: Rachel Sibley <rasibley@redhat.com>
Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 fs/pipe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 04d004ee2e8c..57502c3c0fba 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -581,7 +581,7 @@ static inline bool pipe_writable(const struct pipe_inode_info *pipe)
 		}
 		wait_event_interruptible(pipe->wait, pipe_writable(pipe));
 		__pipe_lock(pipe);
-		was_empty = pipe_empty(head, pipe->tail);
+		was_empty = pipe_empty(pipe->head, pipe->tail);
 	}
 out:
 	__pipe_unlock(pipe);
-- 
1.8.3.1

