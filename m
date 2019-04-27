Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A531EC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74D10208C2
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbfD0P0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:26:39 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34922 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727937AbfD0P0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:26:35 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP3B-0000zO-I3; Sat, 27 Apr 2019 16:15:37 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2i-0004R6-8x; Sat, 27 Apr 2019 16:15:08 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Miklos Szeredi" <mszeredi@redhat.com>,
        "Jann Horn" <jannh@google.com>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.28395121@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 044/202] fuse: call pipe_buf_release() under pipe lock
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jann Horn <jannh@google.com>

commit 9509941e9c534920ccc4771ae70bd6cbbe79df1c upstream.

Some of the pipe_buf_release() handlers seem to assume that the pipe is
locked - in particular, anon_pipe_buf_release() accesses pipe->tmp_page
without taking any extra locks. From a glance through the callers of
pipe_buf_release(), it looks like FUSE is the only one that calls
pipe_buf_release() without having the pipe locked.

This bug should only lead to a memory leak, nothing terrible.

Fixes: dd3bb14f44a6 ("fuse: support splice() writing to fuse device")
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/fuse/dev.c | 2 ++
 1 file changed, 2 insertions(+)

--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1978,10 +1978,12 @@ static ssize_t fuse_dev_splice_write(str
 
 	ret = fuse_dev_do_write(fc, &cs, len);
 
+	pipe_lock(pipe);
 	for (idx = 0; idx < nbuf; idx++) {
 		struct pipe_buffer *buf = &bufs[idx];
 		buf->ops->release(pipe, buf);
 	}
+	pipe_unlock(pipe);
 out:
 	kfree(bufs);
 	return ret;

