Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199D7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 10:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8A972075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 10:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nexedi.com header.i=kirr@nexedi.com header.b="Aq5pOywE";
	dkim=pass (1024-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="lI4DLtiz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732922AbfC0KaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 06:30:17 -0400
Received: from mail128-16.atl41.mandrillapp.com ([198.2.128.16]:24730 "EHLO
        mail128-16.atl41.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727328AbfC0KaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 06:30:17 -0400
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Mar 2019 06:30:16 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=5CmMhAf2ZqyrN+ETYX+NFf1/omfg9P9nGlFxAhjhWIM=;
 b=Aq5pOywEGKvR6EPAg2gLQv2h0Py1QDE5gKiZo6bFMbB93BgRio2hMQZGbA2BN/lnc5K/CvjpufY2
   Y0XCKjQH0HPzVs2LLKEiYnEQt4r9uldfiTinURpKRdUWkIpa4Ll1/Ade8tA8nz+EpO8jnC9JAp/I
   NmadWnoKuUKJNmgCHpE=
Received: from pmta01.mandrill.prod.atl01.rsglab.com (127.0.0.1) by mail128-16.atl41.mandrillapp.com id hjd8bg1mqukr for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 10:15:15 +0000 (envelope-from <bounce-md_31050260.5c9b4d33.v1-2848fb7c92a24ed1a7a21cb5bf3746a3@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1553681715; h=From : 
 Subject : To : Cc : Message-Id : In-Reply-To : References : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=5CmMhAf2ZqyrN+ETYX+NFf1/omfg9P9nGlFxAhjhWIM=; 
 b=lI4DLtizPnph4Fol58asV2VgF5uCRTCBlnkKV3XJKiPimJbs+eaCsVdyiZireVckDyrJ4T
 QzbKOXtnyRPN725YYkgayhfyS/brYqIPsnCNlya3QlrQsXdN5fBJKnBBQCAyO/xGvy7TCstJ
 dvHHP9lVJ+2Za0xHYEkpPEucZtwoA=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: [RESEND4, PATCH 2/2] fuse: require /dev/fuse reads to have enough buffer capacity as negotiated
Received: from [87.98.221.171] by mandrillapp.com id 2848fb7c92a24ed1a7a21cb5bf3746a3; Wed, 27 Mar 2019 10:15:15 +0000
X-Mailer: git-send-email 2.21.0.392.gf8f6787159
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Miklos Szeredi <mszeredi@redhat.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Jakob Unterwurzacher <jakobunt@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <fuse-devel@lists.sourceforge.net>,
        Kirill Smelkov <kirr@nexedi.com>
Message-Id: <d74b17b9d33c3dcc7a1f2fa2914fb3c4e7cda127.1553680185.git.kirr@nexedi.com>
In-Reply-To: <cover.1553680185.git.kirr@nexedi.com>
References: <cover.1553680185.git.kirr@nexedi.com>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.2848fb7c92a24ed1a7a21cb5bf3746a3
X-Mandrill-User: md_31050260
Date:   Wed, 27 Mar 2019 10:15:15 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A FUSE filesystem server queues /dev/fuse sys_read calls to get
filesystem requests to handle. It does not know in advance what would be
that request as it can be anything that client issues - LOOKUP, READ,
WRITE, ... Many requests are short and retrieve data from the
filesystem. However WRITE and NOTIFY_REPLY write data into filesystem.

Before getting into operation phase, FUSE filesystem server and kernel
client negotiate what should be the maximum write size the client will
ever issue. After negotiation the contract in between server/client is
that the filesystem server then should queue /dev/fuse sys_read calls with
enough buffer capacity to receive any client request - WRITE in
particular, while FUSE client should not, in particular, send WRITE
requests with > negotiated max_write payload. FUSE client in kernel and
libfuse historically reserve 4K for request header. This way the
contract is that filesystem server should queue sys_reads with
4K+max_write buffer.

If the filesystem server does not follow this contract, what can happen
is that fuse_dev_do_read will see that request size is > buffer size,
and then it will return EIO to client who issued the request but won't
indicate in any way that there is a problem to filesystem server.
This can be hard to diagnose because for some requests, e.g. for
NOTIFY_REPLY which mimics WRITE, there is no client thread that is
waiting for request completion and that EIO goes nowhere, while on
filesystem server side things look like the kernel is not replying back
after successful NOTIFY_RETRIEVE request made by the server.

-> We can make the problem easy to diagnose if we indicate via error
return to filesystem server when it is violating the contract.
This should not practically cause problems because if a filesystem
server is using shorter buffer, writes to it were already very likely to
cause EIO, and if the filesystem is read-only it should be too following
8K minimum buffer size (= either FUSE_MIN_READ_BUFFER, see 1d3d752b47,
or = 4K + min(max_write)=4k cared to be so by process_init_reply).

Please see [1] for context where the problem of stuck filesystem was hit
for real (because kernel client was incorrectly sending more than
max_write data with NOTIFY_REPLY; see also previous patch), how the
situation was traced and for more involving patch that did not make it
into the tree.

[1] https://marc.info/?l=linux-fsdevel&m=155057023600853&w=2

Signed-off-by: Kirill Smelkov <kirr@nexedi.com>
Cc: Han-Wen Nienhuys <hanwen@google.com>
Cc: Jakob Unterwurzacher <jakobunt@gmail.com>
---
 fs/fuse/dev.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 38e94bc43053..8fdfbafed037 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1317,6 +1317,16 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
 	unsigned reqsize;
 	unsigned int hash;
 
+	/*
+	 * Require sane minimum read buffer - that has capacity for fixed part
+	 * of any request header + negotated max_write room for data. If the
+	 * requirement is not satisfied return EINVAL to the filesystem server
+	 * to indicate that it is not following FUSE server/client contract.
+	 * Don't dequeue / abort any request.
+	 */
+	if (nbytes < (fc->conn_init ? 4096 + fc->max_write : FUSE_MIN_READ_BUFFER))
+		return -EINVAL;
+
  restart:
 	spin_lock(&fiq->waitq.lock);
 	err = -EAGAIN;
-- 
2.21.0.392.gf8f6787159
