Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4AB5C4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 02:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F9BE20859
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 02:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbfJICCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 22:02:06 -0400
Received: from shells.gnugeneration.com ([66.240.222.126]:37466 "EHLO
        shells.gnugeneration.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfJICCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 22:02:05 -0400
Received: by shells.gnugeneration.com (Postfix, from userid 1000)
        id 809B51A40559; Tue,  8 Oct 2019 19:02:05 -0700 (PDT)
Date:   Tue, 8 Oct 2019 19:02:05 -0700
From:   Vito Caputo <vcaputo@pengaru.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] seq_file: move seq_read() flushing into a function
Message-ID: <20191009020205.2ezkdwzisnhtoau4@shells.gnugeneration.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consolidate some duplicated bookkeeping from seq_read() into a
function.

Signed-off-by: Vito Caputo <vcaputo@pengaru.com>
---
 fs/seq_file.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/fs/seq_file.c b/fs/seq_file.c
index 1600034a929b..e5d2bccf5ac4 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -141,6 +141,25 @@ static int traverse(struct seq_file *m, loff_t offset)
 	return !m->buf ? -ENOMEM : -EAGAIN;
 }
 
+static int flush(struct seq_file *m, char __user **buf, size_t *size, size_t *copied)
+{
+	int err = 0;
+	size_t n;
+
+	if (!m->count)
+		return err;
+	n = min(m->count, *size);
+	err = copy_to_user(*buf, m->buf + m->from, n);
+	if (err)
+		return err;
+	m->count -= n;
+	m->from += n;
+	*size -= n;
+	*buf += n;
+	*copied += n;
+	return err;
+}
+
 /**
  *	seq_read -	->read() method for sequential files.
  *	@file: the file to read from
@@ -154,7 +173,6 @@ ssize_t seq_read(struct file *file, char __user *buf, size_t size, loff_t *ppos)
 {
 	struct seq_file *m = file->private_data;
 	size_t copied = 0;
-	size_t n;
 	void *p;
 	int err = 0;
 
@@ -207,15 +225,9 @@ ssize_t seq_read(struct file *file, char __user *buf, size_t size, loff_t *ppos)
 	}
 	/* if not empty - flush it first */
 	if (m->count) {
-		n = min(m->count, size);
-		err = copy_to_user(buf, m->buf + m->from, n);
+		err = flush(m, &buf, &size, &copied);
 		if (err)
 			goto Efault;
-		m->count -= n;
-		m->from += n;
-		size -= n;
-		buf += n;
-		copied += n;
 		if (!size)
 			goto Done;
 	}
@@ -273,13 +285,9 @@ ssize_t seq_read(struct file *file, char __user *buf, size_t size, loff_t *ppos)
 		}
 	}
 	m->op->stop(m, p);
-	n = min(m->count, size);
-	err = copy_to_user(buf, m->buf, n);
+	err = flush(m, &buf, &size, &copied);
 	if (err)
 		goto Efault;
-	copied += n;
-	m->count -= n;
-	m->from = n;
 Done:
 	if (!copied)
 		copied = err;
-- 
2.11.0

