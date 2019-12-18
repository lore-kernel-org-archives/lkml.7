Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABD4C2D0D1
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 23:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E400021582
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 23:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sargun.me header.i=@sargun.me header.b="xT1nyXIQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfLRXxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 18:53:33 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:46645 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbfLRXxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 18:53:31 -0500
Received: by mail-il1-f195.google.com with SMTP id t17so3212645ilm.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 15:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=CX/EMM8AnWfaI4rNz03pFAf5OWqiTpv8JaYTV9Mz/lc=;
        b=xT1nyXIQt4g7KeMROF00XdFlDcMJlPPSB0k5I3q3zaze+uv9zHWUzpmF+Objzre2bE
         vj6o+i17XYxtdKTLbME0YHvc9u+93nCtPJgQvPOZ+HLlV8cTOfn1j4COrnt5tSc+hgVm
         YiVFjIW1ovFnH0ZdJLDUwO3b6oyVDhCnjPrSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=CX/EMM8AnWfaI4rNz03pFAf5OWqiTpv8JaYTV9Mz/lc=;
        b=InLjoLXW8KFB9yzCR3zC1RIIFGcZ4IJednrEa/Q7zS9eIZh1K+w1v0T80DKjNP+v5C
         13dOIUzgVVk7uQnricGbrHmbVrFqOEj+B387M0vKAP49ZUPhZPjUtmqyTVUv4urZbPvw
         fjhVT4aMBYopEZ3t9wX84xDSaHNKZQPF2g9nXtRIn8lPlUgWV+vtspXmGlZEBWCOnkuV
         3O6Y1frUsg6DmhvtBDdiQh0Ct9u0jlwOVzRleGq46VQmcON/JRQSfccB9+/NxYgYEY5Y
         3DSBRxO4iB/c45aQO4W+8kmgAd2T5rlil2YB1q4z6eq9h4YxskX2jCV6Ynot6c04Gq+M
         ZebA==
X-Gm-Message-State: APjAAAWF7wfYvSgzeTTZJeWiyrJmFFiXtuj6C8RRwCjoFoacOmnmBvrG
        m3IplJZ9Onh+5/+GiFJYQGP3/0UKsvT8fQ==
X-Google-Smtp-Source: APXvYqyDAcI9Qp/Mf2NvtcZBmoftpN5CG8w3ekpYEYJZnQufCnCSCNtzHl+YOdbrHP7vL+XPt9RsIw==
X-Received: by 2002:a92:8307:: with SMTP id f7mr4208307ild.183.1576713210234;
        Wed, 18 Dec 2019 15:53:30 -0800 (PST)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id h6sm789370iom.43.2019.12.18.15.53.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Dec 2019 15:53:30 -0800 (PST)
Date:   Wed, 18 Dec 2019 23:53:28 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     tycho@tycho.ws, jannh@google.com, cyphar@cyphar.com,
        christian.brauner@ubuntu.com, oleg@redhat.com, luto@amacapital.net,
        viro@zeniv.linux.org.uk, gpascutto@mozilla.com,
        ealvarez@mozilla.com, fweimer@redhat.com, jld@mozilla.com,
        arnd@arndb.de
Subject: [PATCH v4 1/5] vfs, fdtable: Add get_task_file helper
Message-ID: <20191218235326.GA17265@ircssh-2.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This introduces a function which can be used to fetch a file, given an
arbitrary task. As long as the user holds a reference (refcnt) to the
task_struct it is safe to call, and will either return NULL on failure,
or a pointer to the file, with a refcnt.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 fs/file.c            | 22 ++++++++++++++++++++--
 include/linux/file.h |  2 ++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 2f4fcf985079..0ceeb046f4f3 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -706,9 +706,9 @@ void do_close_on_exec(struct files_struct *files)
 	spin_unlock(&files->file_lock);
 }
 
-static struct file *__fget(unsigned int fd, fmode_t mask, unsigned int refs)
+static struct file *__fget_files(struct files_struct *files, unsigned int fd,
+				 fmode_t mask, unsigned int refs)
 {
-	struct files_struct *files = current->files;
 	struct file *file;
 
 	rcu_read_lock();
@@ -729,6 +729,11 @@ static struct file *__fget(unsigned int fd, fmode_t mask, unsigned int refs)
 	return file;
 }
 
+static struct file *__fget(unsigned int fd, fmode_t mask, unsigned int refs)
+{
+	return __fget_files(current->files, fd, mask, refs);
+}
+
 struct file *fget_many(unsigned int fd, unsigned int refs)
 {
 	return __fget(fd, FMODE_PATH, refs);
@@ -746,6 +751,19 @@ struct file *fget_raw(unsigned int fd)
 }
 EXPORT_SYMBOL(fget_raw);
 
+struct file *fget_task(struct task_struct *task, unsigned int fd)
+{
+	struct file *file = NULL;
+
+	task_lock(task);
+	if (task->files)
+		file = __fget_files(task->files, fd, 0, 1);
+
+	task_unlock(task);
+
+	return file;
+}
+
 /*
  * Lightweight file lookup - no refcnt increment if fd table isn't shared.
  *
diff --git a/include/linux/file.h b/include/linux/file.h
index 3fcddff56bc4..c6c7b24ea9f7 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -16,6 +16,7 @@ extern void fput(struct file *);
 extern void fput_many(struct file *, unsigned int);
 
 struct file_operations;
+struct task_struct;
 struct vfsmount;
 struct dentry;
 struct inode;
@@ -47,6 +48,7 @@ static inline void fdput(struct fd fd)
 extern struct file *fget(unsigned int fd);
 extern struct file *fget_many(unsigned int fd, unsigned int refs);
 extern struct file *fget_raw(unsigned int fd);
+extern struct file *fget_task(struct task_struct *task, unsigned int fd);
 extern unsigned long __fdget(unsigned int fd);
 extern unsigned long __fdget_raw(unsigned int fd);
 extern unsigned long __fdget_pos(unsigned int fd);
-- 
2.20.1

