Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EDEC3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 18:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE6F5208C4
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 18:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sargun.me header.i=@sargun.me header.b="eYQYnmtT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfLZSCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 13:02:55 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:41204 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbfLZSCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 13:02:54 -0500
Received: by mail-il1-f195.google.com with SMTP id f10so20676563ils.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Dec 2019 10:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=95zWt2Z69IUHsLURwx9n6gzaWPPvYgMk/GcCPX29V/c=;
        b=eYQYnmtTVq7IAkoD6mWevnIm4ZAF0ODJg6TaWUapN+4jsEXr066HZiedbNvlQVSgxo
         k6I/mQ1woCg1NwlBKmVk328kcyssV0EhpUy+uG9LdtOM02C/JbMHeTjdSSpwM6nrARTN
         MlQHaHs1XR9871stmPtkLuWZ66yIu6wKJgu9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=95zWt2Z69IUHsLURwx9n6gzaWPPvYgMk/GcCPX29V/c=;
        b=tVgs5KNq/E3X3rbO9tx+hSnm/C/BFL1QpjYyl4mIY7WCcmdFq3MZbF+d5TI/Vn0uVL
         xHKYeQeDnzTpfV4RBT7QEg2WTYZBC7lmtdqgpqbPw4szsn5DLNI4mTtnaMvEnsFNr37L
         GM6MfTsKuTwogYV7vVbXCoB+SpT7miRP6Q69KfrCzDPzibd/epGfQ/x4w1JJCOV000eg
         i1D1DNJpslg5CpaxXf5uLrDCF0ap4FL+g1TJUdMihTqFW2aDNGeVdi4XG0C8ApjPAMrB
         oqp+dR7kJzDRSy1e7v8Hcit1R7TMUwJVwgh7laVG9MXeROfDj9SEKDJNg0XZ9vBdyNus
         LzjA==
X-Gm-Message-State: APjAAAXyw6Rj3gOWu+UQh28/u17oDiFXM6qg7zLC9imIUxiIiXWA7DHi
        z1znhDlM8Udbw3l3yC5Wd/+M1TiqlaHV8g==
X-Google-Smtp-Source: APXvYqwuPh0h8udaoUmMS8XY1wHMNfY0+1txaS/KPwC/sTG9xo4FvqM8qLvYSotQm+JfRptnjC6p3g==
X-Received: by 2002:a92:9c48:: with SMTP id h69mr35887985ili.222.1577383372217;
        Thu, 26 Dec 2019 10:02:52 -0800 (PST)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id l83sm12442170ild.34.2019.12.26.10.02.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Dec 2019 10:02:50 -0800 (PST)
Date:   Thu, 26 Dec 2019 18:02:47 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     tycho@tycho.ws, jannh@google.com, cyphar@cyphar.com,
        christian.brauner@ubuntu.com, oleg@redhat.com, luto@amacapital.net,
        viro@zeniv.linux.org.uk, gpascutto@mozilla.com,
        ealvarez@mozilla.com, fweimer@redhat.com, jld@mozilla.com,
        arnd@arndb.de
Subject: [PATCH v7 1/3] vfs, fdtable: Add get_task_file helper
Message-ID: <20191226180245.GA29398@ircssh-2.c.rugged-nimbus-611.internal>
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

This patch is based on Oleg Nesterov's (cf. [1]) patch from September
2018.

[1]: Link: https://lore.kernel.org/r/20180915160423.GA31461@redhat.com

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
Suggested-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/file.c            | 21 +++++++++++++++++++--
 include/linux/file.h |  2 ++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 2f4fcf985079..d3bdb1717d1e 100644
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
 
+static inline struct file *__fget(unsigned int fd, fmode_t mask, unsigned int refs)
+{
+	return __fget_files(current->files, fd, mask, refs);
+}
+
 struct file *fget_many(unsigned int fd, unsigned int refs)
 {
 	return __fget(fd, FMODE_PATH, refs);
@@ -746,6 +751,18 @@ struct file *fget_raw(unsigned int fd)
 }
 EXPORT_SYMBOL(fget_raw);
 
+struct file *fget_task(struct task_struct *task, unsigned int fd)
+{
+	struct file *file = NULL;
+
+	task_lock(task);
+	if (task->files)
+		file = __fget_files(task->files, fd, 0, 1);
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

