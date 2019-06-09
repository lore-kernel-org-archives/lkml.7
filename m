Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACC2C468BE
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 10:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 737A4212F5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 10:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="W2Lns3hn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbfFIKJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 06:09:06 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:55254 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728208AbfFIKJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 06:09:04 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id DB53D2E1290;
        Sun,  9 Jun 2019 13:09:00 +0300 (MSK)
Received: from smtpcorp1j.mail.yandex.net (smtpcorp1j.mail.yandex.net [2a02:6b8:0:1619::137])
        by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id HqcI3fm6pO-90dSh3UN;
        Sun, 09 Jun 2019 13:09:00 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1560074940; bh=HTswKNZVinWlaXTKPwYUewNcuthjMB5ThiabC8k2HqI=;
        h=In-Reply-To:Message-ID:References:Date:To:From:Subject:Cc;
        b=W2Lns3hnIOukrTVxWvIo0u6baEU21di7kha/doFaKrXcuN13asxGi1NnamvbmIL6R
         GG523ZkU7z70oZvqhg6+jHvA2776ywAPGJ7zEEGZCR2c+jbDorSPrGnQHtLbI3fTER
         zK40ISHd22/ieJqWF7T4KyXDg90PAatMcqztN+vk=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:3d25:9e27:4f75:a150])
        by smtpcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 1wLN9D4DDw-90emhqeg;
        Sun, 09 Jun 2019 13:09:00 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH v2 5/6] proc: use down_read_killable mmap_sem for
 /proc/pid/map_files
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Michal =?utf-8?q?Koutn=C3=BD?= <mkoutny@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Roman Gushchin <guro@fb.com>
Date:   Sun, 09 Jun 2019 13:09:00 +0300
Message-ID: <156007493995.3335.9595044802115356911.stgit@buzz>
In-Reply-To: <156007465229.3335.10259979070641486905.stgit@buzz>
References: <156007465229.3335.10259979070641486905.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not stuck forever if something wrong.
Killable lock allows to cleanup stuck tasks and simplifies investigation.

It seems ->d_revalidate() could return any error (except ECHILD) to
abort validation and pass error as result of lookup sequence.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Reviewed-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Cyrill Gorcunov <gorcunov@gmail.com>
Reviewed-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 fs/proc/base.c |   27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 9c8ca6cd3ce4..515ab29c2adf 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1962,9 +1962,12 @@ static int map_files_d_revalidate(struct dentry *dentry, unsigned int flags)
 		goto out;
 
 	if (!dname_to_vma_addr(dentry, &vm_start, &vm_end)) {
-		down_read(&mm->mmap_sem);
-		exact_vma_exists = !!find_exact_vma(mm, vm_start, vm_end);
-		up_read(&mm->mmap_sem);
+		status = down_read_killable(&mm->mmap_sem);
+		if (!status) {
+			exact_vma_exists = !!find_exact_vma(mm, vm_start,
+							    vm_end);
+			up_read(&mm->mmap_sem);
+		}
 	}
 
 	mmput(mm);
@@ -2010,8 +2013,11 @@ static int map_files_get_link(struct dentry *dentry, struct path *path)
 	if (rc)
 		goto out_mmput;
 
+	rc = down_read_killable(&mm->mmap_sem);
+	if (rc)
+		goto out_mmput;
+
 	rc = -ENOENT;
-	down_read(&mm->mmap_sem);
 	vma = find_exact_vma(mm, vm_start, vm_end);
 	if (vma && vma->vm_file) {
 		*path = vma->vm_file->f_path;
@@ -2107,7 +2113,10 @@ static struct dentry *proc_map_files_lookup(struct inode *dir,
 	if (!mm)
 		goto out_put_task;
 
-	down_read(&mm->mmap_sem);
+	result = ERR_PTR(-EINTR);
+	if (down_read_killable(&mm->mmap_sem))
+		goto out_put_mm;
+
 	vma = find_exact_vma(mm, vm_start, vm_end);
 	if (!vma)
 		goto out_no_vma;
@@ -2118,6 +2127,7 @@ static struct dentry *proc_map_files_lookup(struct inode *dir,
 
 out_no_vma:
 	up_read(&mm->mmap_sem);
+out_put_mm:
 	mmput(mm);
 out_put_task:
 	put_task_struct(task);
@@ -2160,7 +2170,12 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
 	mm = get_task_mm(task);
 	if (!mm)
 		goto out_put_task;
-	down_read(&mm->mmap_sem);
+
+	ret = down_read_killable(&mm->mmap_sem);
+	if (ret) {
+		mmput(mm);
+		goto out_put_task;
+	}
 
 	nr_files = 0;
 

