Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED071C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB628218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556125966;
	bh=QziVYLVHou1WD6Ya8vNKM4aeNELLpvnHmDNmfo0RWNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CdKjhmbqvnK57ggsO/8YbkpWWcuTJsdllR5b6aK9vMmIViD1tpHJCP/CvrFwFnsaO
	 YdD4Qi6Hp9wOkiccUMgV/ELSHTOSQ3CDOqIx8xFsbQUnP6k3vBeJBMmCA2n4e0TwGS
	 y48kXSlMP6zHQSLV63bAIhKTcWrR5IRp9MiE/EuU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387713AbfDXRMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:12:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:36616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387699AbfDXRMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:12:43 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48F4121904;
        Wed, 24 Apr 2019 17:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556125962;
        bh=QziVYLVHou1WD6Ya8vNKM4aeNELLpvnHmDNmfo0RWNc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f+y1E3jbRabElrGIYQ4Z70QkzLyKOAxx5Ou7AvBWPHzPZ2p0+2gPNcvqcAArZEabq
         2Frao2CIaCxOv9HJxqdSW6Wn0Uu7Uw+tI/TK02Slls2s/F3z94++WK9SWYYoQbro2C
         K0F3t2QCHxM/KPmGTY3Rjr1EhEl7QN/QvOhv8q7g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>
Subject: [PATCH 3.18 045/104] tty: ldisc: add sysctl to prevent autoloading of ldiscs
Date:   Wed, 24 Apr 2019 19:09:02 +0200
Message-Id: <20190424170900.484973164@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170839.996641496@linuxfoundation.org>
References: <20190424170839.996641496@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit 7c0cca7c847e6e019d67b7d793efbbe3b947d004 upstream.

By default, the kernel will automatically load the module of any line
dicipline that is asked for.  As this sometimes isn't the safest thing
to do, provide a sysctl to disable this feature.

By default, we set this to 'y' as that is the historical way that Linux
has worked, and we do not want to break working systems.  But in the
future, perhaps this can default to 'n' to prevent this functionality.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/Kconfig     |   23 +++++++++++++++++++++++
 drivers/tty/tty_io.c    |    3 +++
 drivers/tty/tty_ldisc.c |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+)

--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -419,4 +419,27 @@ config DA_CONSOLE
 	help
 	  This enables a console on a Dash channel.
 
+config LDISC_AUTOLOAD
+	bool "Automatically load TTY Line Disciplines"
+	default y
+	help
+	  Historically the kernel has always automatically loaded any
+	  line discipline that is in a kernel module when a user asks
+	  for it to be loaded with the TIOCSETD ioctl, or through other
+	  means.  This is not always the best thing to do on systems
+	  where you know you will not be using some of the more
+	  "ancient" line disciplines, so prevent the kernel from doing
+	  this unless the request is coming from a process with the
+	  CAP_SYS_MODULE permissions.
+
+	  Say 'Y' here if you trust your userspace users to do the right
+	  thing, or if you have only provided the line disciplines that
+	  you know you will be using, or if you wish to continue to use
+	  the traditional method of on-demand loading of these modules
+	  by any user.
+
+	  This functionality can be changed at runtime with the
+	  dev.tty.ldisc_autoload sysctl, this configuration option will
+	  only set the default value of this functionality.
+
 endif # TTY
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -492,6 +492,8 @@ static const struct file_operations hung
 static DEFINE_SPINLOCK(redirect_lock);
 static struct file *redirect;
 
+extern void tty_sysctl_init(void);
+
 /**
  *	tty_wakeup	-	request more data
  *	@tty: terminal
@@ -3625,6 +3627,7 @@ void console_sysfs_notify(void)
  */
 int __init tty_init(void)
 {
+	tty_sysctl_init();
 	cdev_init(&tty_cdev, &tty_fops);
 	if (cdev_add(&tty_cdev, MKDEV(TTYAUX_MAJOR, 0), 1) ||
 	    register_chrdev_region(MKDEV(TTYAUX_MAJOR, 0), 1, "/dev/tty") < 0)
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -151,6 +151,13 @@ static void put_ldops(struct tty_ldisc_o
  *		takes tty_ldiscs_lock to guard against ldisc races
  */
 
+#if defined(CONFIG_LDISC_AUTOLOAD)
+	#define INITIAL_AUTOLOAD_STATE	1
+#else
+	#define INITIAL_AUTOLOAD_STATE	0
+#endif
+static int tty_ldisc_autoload = INITIAL_AUTOLOAD_STATE;
+
 static struct tty_ldisc *tty_ldisc_get(struct tty_struct *tty, int disc)
 {
 	struct tty_ldisc *ld;
@@ -165,6 +172,8 @@ static struct tty_ldisc *tty_ldisc_get(s
 	 */
 	ldops = get_ldops(disc);
 	if (IS_ERR(ldops)) {
+		if (!capable(CAP_SYS_MODULE) && !tty_ldisc_autoload)
+			return ERR_PTR(-EPERM);
 		request_module("tty-ldisc-%d", disc);
 		ldops = get_ldops(disc);
 		if (IS_ERR(ldops))
@@ -831,3 +840,41 @@ void tty_ldisc_begin(void)
 	/* Setup the default TTY line discipline. */
 	(void) tty_register_ldisc(N_TTY, &tty_ldisc_N_TTY);
 }
+
+static int zero;
+static int one = 1;
+static struct ctl_table tty_table[] = {
+	{
+		.procname	= "ldisc_autoload",
+		.data		= &tty_ldisc_autoload,
+		.maxlen		= sizeof(tty_ldisc_autoload),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+		.extra1		= &zero,
+		.extra2		= &one,
+	},
+	{ }
+};
+
+static struct ctl_table tty_dir_table[] = {
+	{
+		.procname	= "tty",
+		.mode		= 0555,
+		.child		= tty_table,
+	},
+	{ }
+};
+
+static struct ctl_table tty_root_table[] = {
+	{
+		.procname	= "dev",
+		.mode		= 0555,
+		.child		= tty_dir_table,
+	},
+	{ }
+};
+
+void tty_sysctl_init(void)
+{
+	register_sysctl_table(tty_root_table);
+}


