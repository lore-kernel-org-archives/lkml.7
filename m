Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E92AC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBB74218FE
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355191;
	bh=zs877YgpGygAIbAjzA/5oGiiO+7HH/6rhHZ70NKLxvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eyIO3oYxPlpmivW+kruVf5DPMA3Ju71+WcVlpt/I6arlxiDRr6gXE+MaQ+3sTTFQE
	 BbUHN5qt6sQYL8zSgRscKlVamkj+sYrGg8zZ++Iz3D3xNqH+1PbjdGuAfjiCmAAF9M
	 qQZWX78ZBKNVX2XgpDaD4icbDSDaqk1AE2xRxPwI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729959AbfDOTGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:06:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:40892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729924AbfDOTG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:06:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52920218A1;
        Mon, 15 Apr 2019 19:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355187;
        bh=zs877YgpGygAIbAjzA/5oGiiO+7HH/6rhHZ70NKLxvY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z6UnPpzbAX+w3BV0cMtmXNJm6gzCZuUJzv94OV2IdfhcVet2GuimlSfPFIGiTkmn1
         AmGRWGMgMtmKNkoHq+4uqzCUJ5OSelYHZUU2lo6et54IpmieP3PBH6YENSlPeGgeMw
         CVPdwBaQgxQA49GuYzxKA8Ko14eNZMKctFbnohws=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.19 046/101] tty: ldisc: add sysctl to prevent autoloading of ldiscs
Date:   Mon, 15 Apr 2019 20:58:44 +0200
Message-Id: <20190415183743.023183415@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183740.341577907@linuxfoundation.org>
References: <20190415183740.341577907@linuxfoundation.org>
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
 drivers/tty/Kconfig     |   24 ++++++++++++++++++++++++
 drivers/tty/tty_io.c    |    3 +++
 drivers/tty/tty_ldisc.c |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 74 insertions(+)

--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -441,4 +441,28 @@ config VCC
 	depends on SUN_LDOMS
 	help
 	  Support for Sun logical domain consoles.
+
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
@@ -512,6 +512,8 @@ static const struct file_operations hung
 static DEFINE_SPINLOCK(redirect_lock);
 static struct file *redirect;
 
+extern void tty_sysctl_init(void);
+
 /**
  *	tty_wakeup	-	request more data
  *	@tty: terminal
@@ -3340,6 +3342,7 @@ void console_sysfs_notify(void)
  */
 int __init tty_init(void)
 {
+	tty_sysctl_init();
 	cdev_init(&tty_cdev, &tty_fops);
 	if (cdev_add(&tty_cdev, MKDEV(TTYAUX_MAJOR, 0), 1) ||
 	    register_chrdev_region(MKDEV(TTYAUX_MAJOR, 0), 1, "/dev/tty") < 0)
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -156,6 +156,13 @@ static void put_ldops(struct tty_ldisc_o
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
@@ -170,6 +177,8 @@ static struct tty_ldisc *tty_ldisc_get(s
 	 */
 	ldops = get_ldops(disc);
 	if (IS_ERR(ldops)) {
+		if (!capable(CAP_SYS_MODULE) && !tty_ldisc_autoload)
+			return ERR_PTR(-EPERM);
 		request_module("tty-ldisc-%d", disc);
 		ldops = get_ldops(disc);
 		if (IS_ERR(ldops))
@@ -829,3 +838,41 @@ void tty_ldisc_deinit(struct tty_struct
 		tty_ldisc_put(tty->ldisc);
 	tty->ldisc = NULL;
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


