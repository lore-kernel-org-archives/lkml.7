Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4CCC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 00:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEF0320823
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 00:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="au5hNF3e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbfCBAst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 19:48:49 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:41930 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727717AbfCBAss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 19:48:48 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x220iiOI029815
        for <linux-kernel@vger.kernel.org>; Fri, 1 Mar 2019 16:48:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=DJhbwneO24lSmxkJcvIcWnQBpsW7F7qzOnjvIyoLF6A=;
 b=au5hNF3e+tBAV4IEePEEcXKcV7077b+AVan51sznqKjsdu2yJrCukTd7OzrNOhlhgAhs
 B5Ktx0sXSc4LHER5jMpmkB6QehmRe2RYiPv3KG+maXpz+hGOTNmrceEnw10uxJ86bo0h
 v4yMs95wMzR6D2J3xyBBvwde1xLwF4K1zrw= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qycvd8grt-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 16:48:46 -0800
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Fri, 1 Mar 2019 16:48:34 -0800
Received: by devbig008.ftw2.facebook.com (Postfix, from userid 10532)
        id ED49123A5AB2; Fri,  1 Mar 2019 16:48:31 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Calvin Owens <calvinowens@fb.com>
Smtp-Origin-Hostname: devbig008.ftw2.facebook.com
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        Calvin Owens <calvinowens@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH 2/4] printk: Add ability to set loglevel via "console=" cmdline
Date:   Fri, 1 Mar 2019 16:48:18 -0800
Message-ID: <e1311e98d6803f678cdcaa2be1cfb58d667fe3fd.1551486732.git.calvinowens@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1551486732.git.calvinowens@fb.com>
References: <cover.1551486732.git.calvinowens@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-01_16:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This extends the "console=" interface to allow setting the per-console
loglevel by adding "/N" to the string, where N is the desired loglevel
expressed as a base 10 integer. Invalid values are silently ignored.

Signed-off-by: Calvin Owens <calvinowens@fb.com>
---
 .../admin-guide/kernel-parameters.txt         |  6 ++--
 kernel/printk/console_cmdline.h               |  1 +
 kernel/printk/printk.c                        | 30 +++++++++++++++----
 3 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 858b6c0b9a15..afada61dcbce 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -612,10 +612,10 @@
 		ttyS<n>[,options]
 		ttyUSB0[,options]
 			Use the specified serial port.  The options are of
-			the form "bbbbpnf", where "bbbb" is the baud rate,
+			the form "bbbbpnf/l", where "bbbb" is the baud rate,
 			"p" is parity ("n", "o", or "e"), "n" is number of
-			bits, and "f" is flow control ("r" for RTS or
-			omit it).  Default is "9600n8".
+			bits, "f" is flow control ("r" for RTS or omit it),
+			and "l" is the loglevel on [0,7]. Default is "9600n8".
 
 			See Documentation/admin-guide/serial-console.rst for more
 			information.  See
diff --git a/kernel/printk/console_cmdline.h b/kernel/printk/console_cmdline.h
index 11f19c466af5..fbf9b539366e 100644
--- a/kernel/printk/console_cmdline.h
+++ b/kernel/printk/console_cmdline.h
@@ -6,6 +6,7 @@ struct console_cmdline
 {
 	char	name[16];			/* Name of the driver	    */
 	int	index;				/* Minor dev. to use	    */
+	int	loglevel;			/* Loglevel to use */
 	char	*options;			/* Options for the driver   */
 #ifdef CONFIG_A11Y_BRAILLE_CONSOLE
 	char	*brl_options;			/* Options for braille driver */
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 6ead14f8c2bc..2e0eb89f046c 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2057,7 +2057,7 @@ asmlinkage __visible void early_printk(const char *fmt, ...)
 #endif
 
 static int __add_preferred_console(char *name, int idx, char *options,
-				   char *brl_options)
+				   int loglevel, char *brl_options)
 {
 	struct console_cmdline *c;
 	int i;
@@ -2083,6 +2083,7 @@ static int __add_preferred_console(char *name, int idx, char *options,
 	c->options = options;
 	braille_set_options(c, brl_options);
 
+	c->loglevel = loglevel;
 	c->index = idx;
 	return 0;
 }
@@ -2104,8 +2105,8 @@ __setup("console_msg_format=", console_msg_format_setup);
 static int __init console_setup(char *str)
 {
 	char buf[sizeof(console_cmdline[0].name) + 4]; /* 4 for "ttyS" */
-	char *s, *options, *brl_options = NULL;
-	int idx;
+	char *s, *options, *llevel, *brl_options = NULL;
+	int idx, loglevel = LOGLEVEL_EMERG;
 
 	if (_braille_console_setup(&str, &brl_options))
 		return 1;
@@ -2123,6 +2124,14 @@ static int __init console_setup(char *str)
 	options = strchr(str, ',');
 	if (options)
 		*(options++) = 0;
+
+	llevel = strchr(str, '/');
+	if (llevel) {
+		*(llevel++) = 0;
+		if (kstrtoint(llevel, 10, &loglevel))
+			loglevel = LOGLEVEL_EMERG;
+	}
+
 #ifdef __sparc__
 	if (!strcmp(str, "ttya"))
 		strcpy(buf, "ttyS0");
@@ -2135,7 +2144,7 @@ static int __init console_setup(char *str)
 	idx = simple_strtoul(s, NULL, 10);
 	*s = 0;
 
-	__add_preferred_console(buf, idx, options, brl_options);
+	__add_preferred_console(buf, idx, options, loglevel, brl_options);
 	console_set_on_cmdline = 1;
 	return 1;
 }
@@ -2156,7 +2165,8 @@ __setup("console=", console_setup);
  */
 int add_preferred_console(char *name, int idx, char *options)
 {
-	return __add_preferred_console(name, idx, options, NULL);
+	return __add_preferred_console(name, idx, options, LOGLEVEL_EMERG,
+				       NULL);
 }
 
 bool console_suspend_enabled = true;
@@ -2574,6 +2584,7 @@ void register_console(struct console *newcon)
 	struct console *bcon = NULL;
 	struct console_cmdline *c;
 	static bool has_preferred;
+	bool cmdline_exists = false;
 
 	if (console_drivers)
 		for_each_console(bcon)
@@ -2640,6 +2651,12 @@ void register_console(struct console *newcon)
 			if (newcon->index < 0)
 				newcon->index = c->index;
 
+			/*
+			 * Carry over the loglevel from the cmdline
+			 */
+			newcon->level = c->loglevel;
+			cmdline_exists = true;
+
 			if (_braille_register_console(newcon, c))
 				return;
 
@@ -2671,7 +2688,8 @@ void register_console(struct console *newcon)
 	/*
 	 * By default, the per-console minimum forces no messages through.
 	 */
-	newcon->level = LOGLEVEL_EMERG;
+	if (!cmdline_exists)
+		newcon->level = LOGLEVEL_EMERG;
 
 	/*
 	 *	Put this console in the list - keep the
-- 
2.17.1

