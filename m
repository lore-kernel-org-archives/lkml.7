Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7870C742A7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 07:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A305320848
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 07:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfjFG3cG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbfGMHcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 03:32:15 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35158 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbfGMHcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 03:32:14 -0400
Received: by mail-wr1-f66.google.com with SMTP id y4so12066957wrm.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2019 00:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cz/G7Bg4/gbCpeRyYKiO6sZWGDg0f1xOoi3Ahb9p1bU=;
        b=WfjFG3cGPOhsFijjktNbadfXHVMkQX0JmnpPZbU+Cn6tafE7qcWhR2lkm2qO32sdHY
         uQ9k1Yw4OwmFRSlsR4TQ4yH39o+XmVouFRyfOidFo3atrvLHi5nfvEjKdAyWZg2zN1pz
         7fcBBVPjdA4kQpHjA6KOdUnuxs584TsZeF5/LLETM58a2aHKxyO2FCrne/CucR/skiHX
         icJbVKNkVtMVU4Mtv4PEDmVcPmCpKCHFELSp+irB9ZqPzBxPb9Gz3AJx2+ZvfW9OOXtn
         KGR7fmYKKlwAo1+tvOKmJhFNHeN9ZV6Tf7cWp5Qcap6xh+e607uLCK4to7zxuWPiThwS
         rYtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cz/G7Bg4/gbCpeRyYKiO6sZWGDg0f1xOoi3Ahb9p1bU=;
        b=j/bQ44M7J0XdWKPQjClqdB7m4WYVJLxx71F84XioLa+nOeA+lcJk4+nmDK5S5ibLWF
         yuqqhLqRg41JrmgTKJScL9eiBQvCK6YR/U1omQOkP10DNl+t2dMYW34OzTpkCfoZDyq+
         zJoo94vFERZTuoxaQWGhLamB0Gudr+XZl7bU/TD7SRoRF+/ovTiHlUpj6fXIqo6Nl2Lf
         OPK+9P1ewoQd+ji00sd/Dr0KZbVeJ0pNU2Swk7Kac7uRQxrQL4jJKqQ1lQG810jp6quf
         touI9r2pnXSppFyKY651GZFfgZXl+ULyG/JHxubhzW3yVDZoG00Mw2sk9ox3WbsU6tMA
         Bwrg==
X-Gm-Message-State: APjAAAVkYI9c2yP2WJofM+wAkZxsh09Vjxk+ye7Ii+yorv+1m6sRN/3r
        Cb9dKIGF/AA1OGEk8s12CNlgweI=
X-Google-Smtp-Source: APXvYqz9pNjv5cEnC9/KNZ70hZ/Ii4y2KQkBogC51IbtEXMpjc01XfuQjN3zcjFOM4GCN5cEYlEEjw==
X-Received: by 2002:adf:dd8e:: with SMTP id x14mr15982354wrl.344.1563003132293;
        Sat, 13 Jul 2019 00:32:12 -0700 (PDT)
Received: from avx2 ([46.53.248.114])
        by smtp.gmail.com with ESMTPSA id g8sm10176466wmf.17.2019.07.13.00.32.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Jul 2019 00:32:11 -0700 (PDT)
Date:   Sat, 13 Jul 2019 10:32:09 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     izbyshev@ispras.ru, oleg@redhat.com, mkubecek@suse.cz,
        torvalds@linux-foundation.org, shasta@toxcorp.com,
        linux-kernel@vger.kernel.org, security@kernel.org
Subject: [PATCH] proc: revert /proc/*/cmdline rewrite
Message-ID: <20190713073209.GC23167@avx2>
References: <20190713072855.GB23167@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190713072855.GB23167@avx2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

/proc/*/cmdline continues to cause problems:

	https://lkml.org/lkml/2019/4/5/825
	Subject get_mm_cmdline and userspace (Perl) changing argv0

	https://marc.info/?l=linux-kernel&m=156294831308786&w=4
	[PATCH] proc: Fix uninitialized byte read in get_mm_cmdline()

This patch reverts implementation to the last known good state.
Revert

	commit f5b65348fd77839b50e79bc0a5e536832ea52d8d
	proc: fix missing final NUL in get_mm_cmdline() rewrite

	commit 5ab8271899658042fabc5ae7e6a99066a210bc0e
	fs/proc: simplify and clarify get_mm_cmdline() function

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

	Cc lists

 fs/proc/base.c |  198 +++++++++++++++++++++++++++++++++------------------------
 1 file changed, 118 insertions(+), 80 deletions(-)

--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -210,16 +210,24 @@ static int proc_root_link(struct dentry *dentry, struct path *path)
 }
 
 static ssize_t get_mm_cmdline(struct mm_struct *mm, char __user *buf,
-			      size_t count, loff_t *ppos)
+			      size_t _count, loff_t *pos)
 {
+	unsigned long count = _count;
 	unsigned long arg_start, arg_end, env_start, env_end;
-	unsigned long pos, len;
+	unsigned long len1, len2, len;
+	unsigned long p;
 	char *page;
+	ssize_t rv;
+	char c;
 
 	/* Check if process spawned far enough to have cmdline. */
 	if (!mm->env_end)
 		return 0;
 
+	page = (char *)__get_free_page(GFP_KERNEL);
+	if (!page)
+		return -ENOMEM;
+
 	spin_lock(&mm->arg_lock);
 	arg_start = mm->arg_start;
 	arg_end = mm->arg_end;
@@ -227,96 +235,126 @@ static ssize_t get_mm_cmdline(struct mm_struct *mm, char __user *buf,
 	env_end = mm->env_end;
 	spin_unlock(&mm->arg_lock);
 
-	if (arg_start >= arg_end)
-		return 0;
+	BUG_ON(arg_start > arg_end);
+	BUG_ON(env_start > env_end);
+
+	len1 = arg_end - arg_start;
+	len2 = env_end - env_start;
 
+	/* Empty ARGV. */
+	if (len1 == 0) {
+		rv = 0;
+		goto out_free_page;
+	}
 	/*
-	 * We have traditionally allowed the user to re-write
-	 * the argument strings and overflow the end result
-	 * into the environment section. But only do that if
-	 * the environment area is contiguous to the arguments.
+	 * Inherently racy -- command line shares address space
+	 * with code and data.
 	 */
-	if (env_start != arg_end || env_start >= env_end)
-		env_start = env_end = arg_end;
-
-	/* .. and limit it to a maximum of one page of slop */
-	if (env_end >= arg_end + PAGE_SIZE)
-		env_end = arg_end + PAGE_SIZE - 1;
-
-	/* We're not going to care if "*ppos" has high bits set */
-	pos = arg_start + *ppos;
-
-	/* .. but we do check the result is in the proper range */
-	if (pos < arg_start || pos >= env_end)
-		return 0;
-
-	/* .. and we never go past env_end */
-	if (env_end - pos < count)
-		count = env_end - pos;
-
-	page = (char *)__get_free_page(GFP_KERNEL);
-	if (!page)
-		return -ENOMEM;
-
-	len = 0;
-	while (count) {
-		int got;
-		size_t size = min_t(size_t, PAGE_SIZE, count);
-		long offset;
+	rv = access_remote_vm(mm, arg_end - 1, &c, 1, FOLL_ANON);
+	if (rv <= 0)
+		goto out_free_page;
+
+	rv = 0;
+
+	if (c == '\0') {
+		/* Command line (set of strings) occupies whole ARGV. */
+		if (len1 <= *pos)
+			goto out_free_page;
+
+		p = arg_start + *pos;
+		len = len1 - *pos;
+		while (count > 0 && len > 0) {
+			unsigned int _count;
+			int nr_read;
+
+			_count = min3(count, len, PAGE_SIZE);
+			nr_read = access_remote_vm(mm, p, page, _count, FOLL_ANON);
+			if (nr_read < 0)
+				rv = nr_read;
+			if (nr_read <= 0)
+				goto out_free_page;
+
+			if (copy_to_user(buf, page, nr_read)) {
+				rv = -EFAULT;
+				goto out_free_page;
+			}
 
+			p	+= nr_read;
+			len	-= nr_read;
+			buf	+= nr_read;
+			count	-= nr_read;
+			rv	+= nr_read;
+		}
+	} else {
 		/*
-		 * Are we already starting past the official end?
-		 * We always include the last byte that is *supposed*
-		 * to be NUL
+		 * Command line (1 string) occupies ARGV and
+		 * extends into ENVP.
 		 */
-		offset = (pos >= arg_end) ? pos - arg_end + 1 : 0;
-
-		got = access_remote_vm(mm, pos - offset, page, size + offset, FOLL_ANON);
-		if (got <= offset)
-			break;
-		got -= offset;
-
-		/* Don't walk past a NUL character once you hit arg_end */
-		if (pos + got >= arg_end) {
-			int n = 0;
-
-			/*
-			 * If we started before 'arg_end' but ended up
-			 * at or after it, we start the NUL character
-			 * check at arg_end-1 (where we expect the normal
-			 * EOF to be).
-			 *
-			 * NOTE! This is smaller than 'got', because
-			 * pos + got >= arg_end
-			 */
-			if (pos < arg_end)
-				n = arg_end - pos - 1;
-
-			/* Cut off at first NUL after 'n' */
-			got = n + strnlen(page+n, offset+got-n);
-			if (got < offset)
-				break;
-			got -= offset;
-
-			/* Include the NUL if it existed */
-			if (got < size)
-				got++;
+		struct {
+			unsigned long p;
+			unsigned long len;
+		} cmdline[2] = {
+			{ .p = arg_start, .len = len1 },
+			{ .p = env_start, .len = len2 },
+		};
+		loff_t pos1 = *pos;
+		unsigned int i;
+
+		i = 0;
+		while (i < 2 && pos1 >= cmdline[i].len) {
+			pos1 -= cmdline[i].len;
+			i++;
 		}
+		while (i < 2) {
+			p = cmdline[i].p + pos1;
+			len = cmdline[i].len - pos1;
+			while (count > 0 && len > 0) {
+				unsigned int _count, l;
+				int nr_read;
+				bool final;
+
+				_count = min3(count, len, PAGE_SIZE);
+				nr_read = access_remote_vm(mm, p, page, _count, FOLL_ANON);
+				if (nr_read < 0)
+					rv = nr_read;
+				if (nr_read <= 0)
+					goto out_free_page;
+
+				/*
+				 * Command line can be shorter than whole ARGV
+				 * even if last "marker" byte says it is not.
+				 */
+				final = false;
+				l = strnlen(page, nr_read);
+				if (l < nr_read) {
+					nr_read = l;
+					final = true;
+				}
+
+				if (copy_to_user(buf, page, nr_read)) {
+					rv = -EFAULT;
+					goto out_free_page;
+				}
+
+				p	+= nr_read;
+				len	-= nr_read;
+				buf	+= nr_read;
+				count	-= nr_read;
+				rv	+= nr_read;
+
+				if (final)
+					goto out_free_page;
+			}
 
-		got -= copy_to_user(buf, page+offset, got);
-		if (unlikely(!got)) {
-			if (!len)
-				len = -EFAULT;
-			break;
+			/* Only first chunk can be read partially. */
+			pos1 = 0;
+			i++;
 		}
-		pos += got;
-		buf += got;
-		len += got;
-		count -= got;
 	}
 
+out_free_page:
 	free_page((unsigned long)page);
-	return len;
+	return rv;
 }
 
 static ssize_t get_task_cmdline(struct task_struct *tsk, char __user *buf,
