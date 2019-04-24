Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98901C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63E9221905
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126341;
	bh=xZRO2nttMVX1PSkfMW7B1iRvG+br0ANEvUGGvxASUE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d1RWFPTYnfmuhw+e87tIl8BWWJQfV12LO04fV+eeE/6vvuzzVUUrSi1MsSTwP+j9e
	 tMngvyRjW1SHJAd7HSo9ze0q2gLBiTGzcfnx5TfnEQdhrzn+vK5NqKVlxa3HiE13AJ
	 rLEDEE0gjg3Ouf0UpU4HOKyf2oKCrSfkOC03jjus=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388926AbfDXRTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:19:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:44144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388239AbfDXRS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:18:58 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98FE4218B0;
        Wed, 24 Apr 2019 17:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126337;
        bh=xZRO2nttMVX1PSkfMW7B1iRvG+br0ANEvUGGvxASUE0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SEup2TZcSpjXT82vCThXBquk8uOYZApubNBZyFvYFtnMLalL1zD9THfW6vgkc7L4a
         pZyqm5YyuLOhsprcnfxKQWfITICMvg0yIOVBc0ND4xpxPD3Qvk56uyJrbtOOgFM397
         EcGL3Kkd6UpZEFEx1rvCEk2IU1COTckGIU2TcEvA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.4 076/168] tty: ldisc: add sysctl to prevent autoloading of ldiscs
Date:   Wed, 24 Apr 2019 19:08:40 +0200
Message-Id: <20190424170928.415407422@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170923.452349382@linuxfoundation.org>
References: <20190424170923.452349382@linuxfoundation.org>
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
@@ -466,4 +466,27 @@ config MIPS_EJTAG_FDC_KGDB_CHAN
 	help
 	  FDC channel number to use for KGDB.
 
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
@@ -513,6 +513,8 @@ void proc_clear_tty(struct task_struct *
 	tty_kref_put(tty);
 }
 
+extern void tty_sysctl_init(void);
+
 /**
  * proc_set_tty -  set the controlling terminal
  *
@@ -3689,6 +3691,7 @@ void console_sysfs_notify(void)
  */
 int __init tty_init(void)
 {
+	tty_sysctl_init();
 	cdev_init(&tty_cdev, &tty_fops);
 	if (cdev_add(&tty_cdev, MKDEV(TTYAUX_MAJOR, 0), 1) ||
 	    register_chrdev_region(MKDEV(TTYAUX_MAJOR, 0), 1, "/dev/tty") < 0)
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -148,6 +148,13 @@ static void put_ldops(struct tty_ldisc_o
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
@@ -162,6 +169,8 @@ static struct tty_ldisc *tty_ldisc_get(s
 	 */
 	ldops = get_ldops(disc);
 	if (IS_ERR(ldops)) {
+		if (!capable(CAP_SYS_MODULE) && !tty_ldisc_autoload)
+			return ERR_PTR(-EPERM);
 		request_module("tty-ldisc-%d", disc);
 		ldops = get_ldops(disc);
 		if (IS_ERR(ldops))
@@ -830,3 +839,41 @@ void tty_ldisc_begin(void)
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


