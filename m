Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6448BC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 21:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2763120857
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 21:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JXQLHJfB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbfDAV1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 17:27:17 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36787 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbfDAV1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 17:27:13 -0400
Received: by mail-pl1-f195.google.com with SMTP id ck15so3914932plb.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 14:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=GUOToY2AISTMkTZVQeqAwtOJEJi4QfGi9mN01H/uGNk=;
        b=JXQLHJfBQi/9jMUzDHOgwv8V/sdb5tE7wZZi/L/zcdqxnHS6YW5SUdh3aLeG4OkpBG
         vrlImSO37ENJGOGNPu6dkVCchrShASWMkoCfxBi2BGO7BiDtbbBuV6iyaNg1DniXMbD1
         6KYJ2AGBn0XoynVFgMhahpQCVP6/GO6+ptx4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=GUOToY2AISTMkTZVQeqAwtOJEJi4QfGi9mN01H/uGNk=;
        b=rZ88Dddbm3EsA4WybVeRqW4IHgLJfMKKa8g4uCnZSoteTBbdnpE02UeuCSuahFzBse
         MMh+RA0JpZFNosoWBJz7EfcoNlSzCLPNAhBO5qQL3ccVcJAVCmWvp9V2MfP+einIqu80
         beuVIKz8W+7i2HjGEeJSm2Ten7TZXXDnToeqo+vP31Jqg+3WQY6s0Y4QK5SeEkx7Eh4G
         RaKN4wLMGmxZ4vP5yY5pk3WUF44kRRhOOVAtFSg8Is6n091UlZIb9N+rM2tZxjqRiFls
         Z/bEC5T+eFcqrRKjDfAd29Szgn/R04jROXUG06UuJaESwiut3wvVA/ALLznGmYWGJcHO
         bZ0g==
X-Gm-Message-State: APjAAAUcdpo4LPvQitfeGxfkB+wfYm9nuosfa7xy71Y27vHoV8bEIWE7
        gBFQxRT4PCJQH9TXif/HtwHEww==
X-Google-Smtp-Source: APXvYqyGqKdGW893dTJObpqyRKR1Cf78UPHQcU5M1sxStlloT1D0Sv67WqFl5vk6MeGfByCnLtzeQg==
X-Received: by 2002:a17:902:a98b:: with SMTP id bh11mr66436671plb.63.1554154032770;
        Mon, 01 Apr 2019 14:27:12 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id u26sm15866069pfn.5.2019.04.01.14.27.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 14:27:11 -0700 (PDT)
Date:   Mon, 1 Apr 2019 14:27:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Johannes Thumshirn <jthumshirn@suse.de>,
        Nikolay Borisov <nborisov@suse.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux FSDEVEL Mailinglist <linux-fsdevel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: [PATCH] fs/open: Fix most outstanding security bugs
Message-ID: <20190401212710.GA28345@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACT4Y+Yh-bbrn1x139gxo8B0MqR9NbMoZJeN6iJMTgAnDKp9EA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 1, 2019 at 10:50 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Mon, Apr 1, 2019 at 4:14 PM Nikolay Borisov <nborisov@suse.com> wrote:
> > On 1.04.19 г. 12:01 ч., Johannes Thumshirn wrote:
> > > One common pattern in most of these security related reports is processes
> > > called "syzkaller", "trinity" or "syz-executor" opening files and then
> > > abuse kernel interfaces causing kernel crashes or even worse threats using
> > > memory overwrites or by exploiting race conditions.
> > >
> > > Hunting down these bugs has become time consuming and very expensive, so
> > > I've decided to put an end to it.
> > >
> > > If one of the above mentioned processes tries opening a file, return -EPERM
> > > indicating this process does not have the permission to open files on Linux
> > > anymore.
> > >
> > > Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> >
> > Ack-by: Nikolay Borisov <nborisov@suse.com>
>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> Cc: stable@vger.kernel.org # v1.0+
>
> Do we want to extend this to other subsystems?
> Should it be a default secomp filter?

Yes, this protection could make those processes fail too many syscalls. I
agree: it would be better to have all syscalls return 0 with a seccomp
filter. I have updated the patch:


Subject: [PATCH] exec: Fix most outstanding security bugs
From: Kees Cook <keescook@chromium.org>

Over the last 20 years, the Linux kernel has accumulated hundreds if
not thousands of security vulnerabilities.

One common pattern in most of these security related reports is processes
called "syzkaller", "trinity" or "syz-executor" opening files and then
abuse kernel interfaces causing kernel crashes or even worse threats
using memory overwrites or by exploiting race conditions.

Hunting down these bugs has become time consuming and very expensive,
so we've decided to put an end to it.

If one of the above mentioned processes tries to execute a system
call, the call will be skipped but will return zero. This will keep
the process happy without changing kernel state, keeping things safe.

Co-developed-by: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Suggested-by: Dmitry Vyukov <dvyukov@google.com>
Singed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/exec.c               |  1 +
 include/linux/seccomp.h |  2 ++
 kernel/seccomp.c        | 39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+)

diff --git a/fs/exec.c b/fs/exec.c
index 2e0033348d8e..c0a73c8e22ff 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1393,6 +1393,7 @@ void finalize_exec(struct linux_binprm *bprm)
 	task_lock(current->group_leader);
 	current->signal->rlim[RLIMIT_STACK] = bprm->rlim_stack;
 	task_unlock(current->group_leader);
+	seccomp_default(current);
 }
 EXPORT_SYMBOL(finalize_exec);
 
diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
index 84868d37b35d..2d98cd0d79ed 100644
--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -45,6 +45,7 @@ extern void secure_computing_strict(int this_syscall);
 
 extern long prctl_get_seccomp(void);
 extern long prctl_set_seccomp(unsigned long, void __user *);
+extern void seccomp_default(struct task_struct *task);
 
 static inline int seccomp_mode(struct seccomp *s)
 {
@@ -73,6 +74,7 @@ static inline long prctl_set_seccomp(unsigned long arg2, char __user *arg3)
 {
 	return -EINVAL;
 }
+static inline void seccomp_default(struct task_struct *task) { }
 
 static inline int seccomp_mode(struct seccomp *s)
 {
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 54a0347ca812..92faee4cded4 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1395,6 +1395,45 @@ SYSCALL_DEFINE3(seccomp, unsigned int, op, unsigned int, flags,
 	return do_seccomp(op, flags, uargs);
 }
 
+/* Certain processes should see all syscalls succeed. */
+void seccomp_default(struct task_struct *task)
+{
+	struct sock_filter filter[] = {
+		BPF_STMT(BPF_RET+BPF_K, SECCOMP_RET_ERRNO | 0),
+	};
+	struct sock_fprog prog = {
+		.len = ARRAY_SIZE(filter),
+		.filter = filter,
+	};
+	static const char * const list[] = {
+		"syzkaller",
+		"syz-executor",
+		"trinity",
+	};
+	char comm[TASK_COMM_LEN];
+	mm_segment_t old_fs;
+	bool found = false;
+	int i;
+
+	get_task_comm(comm, task);
+
+	for (i = 0; i < ARRAY_SIZE(list); i++) {
+		if (!strncmp(comm, list[i], strlen(list[i]))) {
+			found = true;
+			break;
+		}
+	}
+
+	if (!found)
+		return;
+
+	old_fs = get_fs();
+	set_fs(KERNEL_DS);
+	seccomp_set_mode_filter(0, (void * __user)&prog);
+	set_fs(old_fs);
+}
+EXPORT_SYMBOL_GPL(seccomp_default);
+
 /**
  * prctl_set_seccomp: configures current->seccomp.mode
  * @seccomp_mode: requested mode to use
-- 
2.17.1


-- 
Kees Cook
