Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E29C2BD09
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 07:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E16802071E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 07:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sargun.me header.i=@sargun.me header.b="XlxvMoil"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbfLIHGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 02:06:17 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:44250 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbfLIHGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 02:06:15 -0500
Received: by mail-il1-f194.google.com with SMTP id z12so11771718iln.11
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 23:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=8Hi0NAqaq4yKaz2cZXCzyXUQt+Qgg5vxTIhLWeRkvII=;
        b=XlxvMoil8iFkye99hWCb3hagvwkUuuTyC5CcVqEfiGimGwgOT5I2XfhVXg5JvBoO3M
         BTX5Ty6OR6ldJ8hLR6bTFqOExX+whlZdxpH6ewqzXig+QMhRL3F6eAB1f4vwf+BTfaFP
         dDAi2d7HGAKK0pOOsdA+XGCWfiBcw5+GzGPYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=8Hi0NAqaq4yKaz2cZXCzyXUQt+Qgg5vxTIhLWeRkvII=;
        b=HwwSe+m3GMz687C3+EqMVF5q71uM5E5zQDKQP3EtQM0FNLeoW5EsyyMVFoZJ/saAzl
         wEmXcFaCU0RBSJ5wagX5Frqgm5EY+YNpgsrla+kNu7vQWo5HQtM+QKY4+tOwLUBEguVP
         OtuxQPwmMLsHkV7jIILEpzXbpnEdVT/LqIslA46068rvxc44sGUAAhWw7eW30aWM7faV
         jj/057cqxRGtzAIZA8h9aOPd1KVF/rpq3a+23g+GPOew9kS6oCHlHtCP6HM9Dpy77wpz
         QaIZ4hNXFadnU/vkf/pRyXH93CzRYhAbR2KWZKzEjJqRliXu8ZDpqY1Jur3jkUKFm0rl
         JVcA==
X-Gm-Message-State: APjAAAVKCTfR7XtDuXgqsL+px4lsYRlKkdQeJD2iM1SSZ1yksPOV+17D
        vGzHu5MPY/jO8zmUW3/74LTRqCazwjry/A==
X-Google-Smtp-Source: APXvYqyOqXX1bhUMR582tDO+WsTTun/QGCfWJIczZ0NFlZLLlmYhs1rETYjTNDkO85Yx7I6fCcmqhQ==
X-Received: by 2002:a92:b00f:: with SMTP id x15mr25026596ilh.248.1575875174527;
        Sun, 08 Dec 2019 23:06:14 -0800 (PST)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id v10sm163147iot.12.2019.12.08.23.06.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Dec 2019 23:06:13 -0800 (PST)
Date:   Mon, 9 Dec 2019 07:06:12 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     tycho@tycho.ws, jannh@google.com, cyphar@cyphar.com,
        christian.brauner@ubuntu.com, oleg@redhat.com, luto@amacapital.net,
        viro@zeniv.linux.org.uk
Subject: [PATCH v2 1/4] vfs, fdtable: Add get_task_file helper
Message-ID: <20191209070609.GA32438@ircssh-2.c.rugged-nimbus-611.internal>
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
 fs/file.c               | 19 +++++++++++++++++++
 include/linux/fdtable.h | 10 ++++++++++
 2 files changed, 29 insertions(+)

diff --git a/fs/file.c b/fs/file.c
index 3da91a112bab..98601a503a0f 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1015,3 +1015,22 @@ int iterate_fd(struct files_struct *files, unsigned n,
 	return res;
 }
 EXPORT_SYMBOL(iterate_fd);
+
+struct file *get_task_file(struct task_struct *task, unsigned int fd)
+{
+	struct file *file = NULL;
+
+	task_lock(task);
+	rcu_read_lock();
+
+	if (task->files) {
+		file = fcheck_files(task->files, fd);
+		if (file && !get_file_rcu(file))
+			file = NULL;
+	}
+
+	rcu_read_unlock();
+	task_unlock(task);
+
+	return file;
+}
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index f07c55ea0c22..eacb1a56df44 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -115,6 +115,16 @@ int iterate_fd(struct files_struct *, unsigned,
 		int (*)(const void *, struct file *, unsigned),
 		const void *);
 
+/*
+ * get_task_file - get a reference to a file from another task
+ * @task: the task to get the file descriptor from
+ * @fd: the file descriptor number to fetch
+ *
+ * returns NULL on failure, or pointer to the file on success, with a reference
+ * It requires that the task is pinned prior to calling it.
+ */
+struct file *get_task_file(struct task_struct *task, unsigned int fd);
+
 extern int __alloc_fd(struct files_struct *files,
 		      unsigned start, unsigned end, unsigned flags);
 extern void __fd_install(struct files_struct *files,
-- 
2.20.1

