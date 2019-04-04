Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D83C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 21:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A5AC217D4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 21:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eON2GINW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730169AbfDDV7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 17:59:39 -0400
Received: from mail-ot1-f74.google.com ([209.85.210.74]:49241 "EHLO
        mail-ot1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727441AbfDDV7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 17:59:38 -0400
Received: by mail-ot1-f74.google.com with SMTP id s22so1960861otk.16
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 14:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=cBolVqzParWVJebBO2LdYlFNh26KYuHSNaIvvdeXOcE=;
        b=eON2GINWQSZgtLy1IAKrvbYubf6AerkWuh0P1Ege2Ox6h/d4iSEXoNjDWa3F6wUW4u
         5Esch1vDe6X+kyA8ZNIJuf41EAcejGe3leFkFM9mGOj/fh3WmITOyhFxG9nH4xVBBVey
         CqseBQoYqfURUU+T4oNr1vuSwrMblEau/mzjgDzhXwlg7qowbhuWqWd8XYOZs9nwzaMc
         IggqCu3x0qDxnJhhDQjb0jBtTZpfpfZ2w3tqYxz0Tc5zqUmYHXpMtSj75TPq1qmyxUD9
         9qkCQaurSbbKzT9OWinRGDlj92yMBjtLeURczSxP5ZSivs7coWiQKpEPqMtmBftKalAT
         ZNmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=cBolVqzParWVJebBO2LdYlFNh26KYuHSNaIvvdeXOcE=;
        b=GSuJH3vD4/HzbLlif41qVsUv1TXU7xnOVzcwuhpxLPYJISOLveQ7u0QMYlV0kZNuvZ
         RTFX/A7Tmx06IfbMGc0V4KwKRcADI6vocCueFV91dqaVC7Gur8YNrfh9B61hHMAeNoZc
         uqIoe6YpE1luGdKMC6xzkgYhG6ob1RjknWoddBJYdVj9MCNod1DX/G8Du/XZrUkQn0Z+
         S3a/3vPiCBXPCEh75MB1gyqXTk5FrcNRytz8kkrQwEzja6El8zWS+w7ltwjD241v2Ab/
         HPGj2zcHDrr/lZaB7xhG0JVJDju8Rf0N2aD/aDMuQFjXOSERZN9QayV4a/7G9T69Zv9W
         DFew==
X-Gm-Message-State: APjAAAU3/gyg5Dk8WpBQOu4jByvB6qgBOuqQWwl8HLaORk0p3zZspw5m
        4JIhBrggup0G4ez1FzCs0I8+PgGTfg==
X-Google-Smtp-Source: APXvYqxJh59jbWUxRlkYEwNWLYmfFN2Hr6sOjYwwG4h8b+ms6CmiWxe9IoMarGb8KiI/HXheN2mCdQqoaA==
X-Received: by 2002:a9d:4f03:: with SMTP id d3mr819731otl.1.1554415177491;
 Thu, 04 Apr 2019 14:59:37 -0700 (PDT)
Date:   Thu,  4 Apr 2019 23:59:25 +0200
Message-Id: <20190404215925.253531-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH] tracing: Fix buffer_ref pipe ops
From:   Jann Horn <jannh@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, jannh@google.com
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes multiple issues in buffer_pipe_buf_ops:

 - The ->steal() handler must not return zero unless the pipe buffer has
   the only reference to the page. But generic_pipe_buf_steal() assumes
   that every reference to the pipe is tracked by the page's refcount,
   which isn't true for these buffers - buffer_pipe_buf_get(), which
   duplicates a buffer, doesn't touch the page's refcount.
   Fix it by using generic_pipe_buf_nosteal(), which refuses every
   attempted theft. It should be easy to actually support ->steal, but the
   only current users of pipe_buf_steal() are the virtio console and FUSE,
   and they also only use it as an optimization. So it's probably not worth
   the effort.
 - The ->get() and ->release() handlers can be invoked concurrently on pipe
   buffers backed by the same struct buffer_ref. Make them safe against
   concurrency by using refcount_t.
 - The pointers stored in ->private were only zeroed out when the last
   reference to the buffer_ref was dropped. As far as I know, this
   shouldn't be necessary anyway, but if we do it, let's always do it.

Cc: stable@vger.kernel.org # v4.11
Signed-off-by: Jann Horn <jannh@google.com>
---
Completely untested (apart from compiling it). I don't really know
anything about how the tracing subsystem works.

 fs/splice.c               |  4 ++--
 include/linux/pipe_fs_i.h |  1 +
 kernel/trace/trace.c      | 28 ++++++++++++++--------------
 3 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 3ee7e82df48f..e75807380caa 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -330,8 +330,8 @@ const struct pipe_buf_operations default_pipe_buf_ops = {
 	.get = generic_pipe_buf_get,
 };
 
-static int generic_pipe_buf_nosteal(struct pipe_inode_info *pipe,
-				    struct pipe_buffer *buf)
+int generic_pipe_buf_nosteal(struct pipe_inode_info *pipe,
+			     struct pipe_buffer *buf)
 {
 	return 1;
 }
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index 787d224ff43e..a830e9a00eb9 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -174,6 +174,7 @@ void free_pipe_info(struct pipe_inode_info *);
 void generic_pipe_buf_get(struct pipe_inode_info *, struct pipe_buffer *);
 int generic_pipe_buf_confirm(struct pipe_inode_info *, struct pipe_buffer *);
 int generic_pipe_buf_steal(struct pipe_inode_info *, struct pipe_buffer *);
+int generic_pipe_buf_nosteal(struct pipe_inode_info *, struct pipe_buffer *);
 void generic_pipe_buf_release(struct pipe_inode_info *, struct pipe_buffer *);
 void pipe_buf_mark_unmergeable(struct pipe_buffer *buf);
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 21153e64bf1c..0cfa13a60086 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7025,19 +7025,23 @@ struct buffer_ref {
 	struct ring_buffer	*buffer;
 	void			*page;
 	int			cpu;
-	int			ref;
+	refcount_t		refcount;
 };
 
+static void buffer_ref_release(struct buffer_ref *ref)
+{
+	if (!refcount_dec_and_test(&ref->refcount))
+		return;
+	ring_buffer_free_read_page(ref->buffer, ref->cpu, ref->page);
+	kfree(ref);
+}
+
 static void buffer_pipe_buf_release(struct pipe_inode_info *pipe,
 				    struct pipe_buffer *buf)
 {
 	struct buffer_ref *ref = (struct buffer_ref *)buf->private;
 
-	if (--ref->ref)
-		return;
-
-	ring_buffer_free_read_page(ref->buffer, ref->cpu, ref->page);
-	kfree(ref);
+	buffer_ref_release(ref);
 	buf->private = 0;
 }
 
@@ -7046,14 +7050,14 @@ static void buffer_pipe_buf_get(struct pipe_inode_info *pipe,
 {
 	struct buffer_ref *ref = (struct buffer_ref *)buf->private;
 
-	ref->ref++;
+	refcount_inc(&ref->refcount);
 }
 
 /* Pipe buffer operations for a buffer. */
 static const struct pipe_buf_operations buffer_pipe_buf_ops = {
 	.confirm		= generic_pipe_buf_confirm,
 	.release		= buffer_pipe_buf_release,
-	.steal			= generic_pipe_buf_steal,
+	.steal			= generic_pipe_buf_nosteal,
 	.get			= buffer_pipe_buf_get,
 };
 
@@ -7066,11 +7070,7 @@ static void buffer_spd_release(struct splice_pipe_desc *spd, unsigned int i)
 	struct buffer_ref *ref =
 		(struct buffer_ref *)spd->partial[i].private;
 
-	if (--ref->ref)
-		return;
-
-	ring_buffer_free_read_page(ref->buffer, ref->cpu, ref->page);
-	kfree(ref);
+	buffer_ref_release(ref);
 	spd->partial[i].private = 0;
 }
 
@@ -7125,7 +7125,7 @@ tracing_buffers_splice_read(struct file *file, loff_t *ppos,
 			break;
 		}
 
-		ref->ref = 1;
+		refcount_set(&ref->refcount, 1);
 		ref->buffer = iter->trace_buffer->buffer;
 		ref->page = ring_buffer_alloc_read_page(ref->buffer, iter->cpu_file);
 		if (IS_ERR(ref->page)) {
-- 
2.21.0.392.gf8f6787159e-goog

