Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B0DC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 05:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D15742189D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 05:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8bPwDes"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbfH2Ft6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 01:49:58 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41390 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbfH2Ft6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 01:49:58 -0400
Received: by mail-pf1-f196.google.com with SMTP id 196so1288782pfz.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 22:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=sn18T6uMLTeD/3sTDPtUsx+jMMfL+K1l3kGQTvhv0uI=;
        b=P8bPwDesXfZFakhgCIpWD7/icUFb4CELeLHTllKMNRPA/vHH+3GDVdMhh4HSp/2D0P
         t5P+tMbua+DbBxFOzjP1i6KkM5eNnGgvCMgV0OT7oqmcGhUDoF9paKSso+LQj3aKu62f
         NlKQeA6M/h+LzKU5RIeskY3pZSbQ8IUZGo1gaOGzGmB8dKLeWJwWx+QwK+IJ1VpfGq/f
         56zxQLfuPtKEL2pH0brnbyoZvMw/t8CJ4oOxn3UuuO1V+wSm84TLXVAWLd4u9QsAn6/D
         CPSzBvqoroYOgtL/HRDW3h51ZV+SVx2Q3b6+r/xQ/LpYhCGBsm7g8q+CdgQg7Gh7FQL4
         rMYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=sn18T6uMLTeD/3sTDPtUsx+jMMfL+K1l3kGQTvhv0uI=;
        b=JWnfC5Slu7ifDn1ROVs8BH5rnmSY1eNw9rM1HMwDmh+2QUXT4Ds5nQAmsqt3mkGrPW
         gEdIXMs3G5qU4d0Wk2ElpwtEbK4D9fE8JFFcpcHME2Bd8lmrKeUJshN0xL3cTqtky1d6
         Q7MPQJ7YJVCf5iboVR3JiPA3TQG00C/QXbHuut4qekxHk7C0wQxPIUmanHF1EJTNpCRO
         VI8hwe2Xc46syzxpFAEcHXwPj9ZVuQOO1wfbALEuoz2Szcevmfd1eUboRTXXdItFh39p
         +BM6TadVFNJvwsKzhCyTyaXyTBjYzDz7zWD7KFqX9b+yCP7AQ/jbmIACwCb6qt122Uo8
         RXnA==
X-Gm-Message-State: APjAAAUZ0q+yn8Jz6SHk53JMoC9o7k3zOMWwSF+Oqf3exYqOo5dk2FB0
        HNr0DVWgV5dPpMokfP2b4g==
X-Google-Smtp-Source: APXvYqww+w/+6/x7PHnaGwc7CyPWqgAjbP3WyGmOhEEx38YY/cvtJm4W+f9+KbtvMU/+rFm1SB/6mg==
X-Received: by 2002:a63:3c5:: with SMTP id 188mr6567335pgd.394.1567057797661;
        Wed, 28 Aug 2019 22:49:57 -0700 (PDT)
Received: from mark-All-Series (114-32-231-59.HINET-IP.hinet.net. [114.32.231.59])
        by smtp.gmail.com with ESMTPSA id v7sm1324033pff.87.2019.08.28.22.49.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Aug 2019 22:49:57 -0700 (PDT)
Date:   Thu, 29 Aug 2019 13:49:53 +0800
From:   Peikan Tsai <peikantsai@gmail.com>
To:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org, christian@brauner.io
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] binder: Use kmem_cache for binder_thread
Message-ID: <20190829054953.GA18328@mark-All-Series>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The allocated size for each binder_thread is 512 bytes by kzalloc.
Because the size of binder_thread is fixed and it's only 304 bytes.
It will save 208 bytes per binder_thread when use create a kmem_cache
for the binder_thread.

Signed-off-by: Peikan Tsai <peikantsai@gmail.com>
---
 drivers/android/binder.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index dc1c83eafc22..043e0ebd0fe7 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -87,6 +87,8 @@ static struct dentry *binder_debugfs_dir_entry_root;
 static struct dentry *binder_debugfs_dir_entry_proc;
 static atomic_t binder_last_id;

+static struct kmem_cache *binder_thread_cachep;
+
 static int proc_show(struct seq_file *m, void *unused);
 DEFINE_SHOW_ATTRIBUTE(proc);

@@ -4696,14 +4698,15 @@ static struct binder_thread *binder_get_thread(struct binder_proc *proc)
 	thread = binder_get_thread_ilocked(proc, NULL);
 	binder_inner_proc_unlock(proc);
 	if (!thread) {
-		new_thread = kzalloc(sizeof(*thread), GFP_KERNEL);
+		new_thread = kmem_cache_zalloc(binder_thread_cachep,
+					       GFP_KERNEL);
 		if (new_thread == NULL)
 			return NULL;
 		binder_inner_proc_lock(proc);
 		thread = binder_get_thread_ilocked(proc, new_thread);
 		binder_inner_proc_unlock(proc);
 		if (thread != new_thread)
-			kfree(new_thread);
+			kmem_cache_free(binder_thread_cachep, new_thread);
 	}
 	return thread;
 }
@@ -4723,7 +4726,7 @@ static void binder_free_thread(struct binder_thread *thread)
 	BUG_ON(!list_empty(&thread->todo));
 	binder_stats_deleted(BINDER_STAT_THREAD);
 	binder_proc_dec_tmpref(thread->proc);
-	kfree(thread);
+	kmem_cache_free(binder_thread_cachep, thread);
 }

 static int binder_thread_release(struct binder_proc *proc,
@@ -6095,6 +6098,12 @@ static int __init binder_init(void)
 	if (ret)
 		return ret;

+	binder_thread_cachep = kmem_cache_create("binder_thread",
+						 sizeof(struct binder_thread),
+						 0, 0, NULL);
+	if (!binder_thread_cachep)
+		return -ENOMEM;
+
 	atomic_set(&binder_transaction_log.cur, ~0U);
 	atomic_set(&binder_transaction_log_failed.cur, ~0U);

@@ -6167,6 +6176,7 @@ static int __init binder_init(void)

 err_alloc_device_names_failed:
 	debugfs_remove_recursive(binder_debugfs_dir_entry_root);
+	kmem_cache_destroy(binder_thread_cachep);

 	return ret;
 }
--
2.17.1

