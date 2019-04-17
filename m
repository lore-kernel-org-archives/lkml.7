Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE62C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 12:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2C222173C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 12:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rqj5p3VN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732070AbfDQMVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 08:21:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46327 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731790AbfDQMVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 08:21:39 -0400
Received: by mail-wr1-f68.google.com with SMTP id t17so31617588wrw.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 05:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CC+tRpdsI+a3D0fI2iQ23XwuzqysafA+XUzauMHmBi0=;
        b=Rqj5p3VNASRM06zPVlRTzFfUIjzAjXGZwJAu0OmYVenyW9vPoLe8JTGWrdzHe4qYTh
         1FegmSYnwoLWm0X16D6GKrljGDOnwkSocx5kHMMLV+vzFJKEYLKH3R/p5hZ4vW7CW4CE
         Lkr4GOzSt9ItSNCKJtD0L8VNuULcoRFSHp5+WWDEKv/3BbjSICv6JnymQjd+d2Mh1/tq
         ODDcWrHXVJ7OXv/woePmbvV9fwMOk0E2srwQFvB2poOBXusDe55zLKHGtCYJQGSBMArL
         sAlB9CiYGVI4h7CEb7oYH/6p5b1lD1wtaOVqkCmjq7Dlqu4tqUqBTjUbZSxKIPrH5zem
         Lz8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CC+tRpdsI+a3D0fI2iQ23XwuzqysafA+XUzauMHmBi0=;
        b=AYY/hcovXDIDb7kymU6W1KmRiwZ83FoMDjb5pI3zY2G+J6HcYYeTDtG15Dvhscpz8I
         133joOo7YZEjBfL8mCG1cp3iE6aK5vVlTOTdRduceGxDyyELZeiNZGkH+mGHpmfl/ntD
         rcSMkpz/YebbEqBActvr/5fRd9zLqcl4yY1Unh0g/vDjspQqdV4+zv3fTmHL1BPKkR4c
         y0m6gwqIKFNCcOi4ut0WGdzggh2Rb9Kk+g46Fhlg0mnNPNXL6DR1OFnOoZXHpmc2XHXy
         NQYpCBZkWlKTun948qIC9jMzTKzJjN61zuPoD3e/dqU7hvyQPDbi+RmjZu0MeNFGJ/5x
         ta1g==
X-Gm-Message-State: APjAAAV4xw7GukDT6DnL9DXg0NVUybp1le+KGpJi5aFR8JYv35wA/aTL
        gPVmViUD5uPgpZnFI7RhjGo=
X-Google-Smtp-Source: APXvYqzQANws2RTEQP1IhaLb1PJeYcSH116aG+7XwyzvzmFT3Cd78dcN2mShYkl+VhlL5WOGZCrxuw==
X-Received: by 2002:adf:dd82:: with SMTP id x2mr17003768wrl.214.1555503698147;
        Wed, 17 Apr 2019 05:21:38 -0700 (PDT)
Received: from ghost.lan ([94.11.212.240])
        by smtp.gmail.com with ESMTPSA id g84sm3810696wmf.25.2019.04.17.05.21.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 05:21:37 -0700 (PDT)
From:   Okash Khawaja <okash.khawaja@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Gregory Nowak <greg@gregn.net>, linux-kernel@vger.kernel.org
Cc:     Jiri Slaby <jslaby@suse.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Ben Hutchings <ben@decadent.org.uk>,
        William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        John Covici <covici@ccs.covici.com>,
        Peter Hurley <peter@hurleysoftware.com>,
        devel@driverdev.osuosl.org, speakup@linux-speakup.org,
        Okash Khawaja <okash.khawaja@gmail.com>
Subject: [PATCH v2 1/2] vt: selection: allow functions to be called from inside kernel
Date:   Wed, 17 Apr 2019 13:21:13 +0100
Message-Id: <1555503674-8219-2-git-send-email-okash.khawaja@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1555503674-8219-1-git-send-email-okash.khawaja@gmail.com>
References: <1555503674-8219-1-git-send-email-okash.khawaja@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch breaks set_selection() into two functions so that when
called from kernel, copy_from_user() can be avoided. The two functions
are called set_selection_user() and set_selection_kernel() in order to
be explicit about their purposes. This also means updating any
references to set_selection() and fixing for name change. It also
exports set_selection_kernel() and paste_selection().

These changes are used the following patch where speakup's selection
functionality calls into the above functions, thereby doing away with
parallel implementation.

Signed-off-by: Okash Khawaja <okash.khawaja@gmail.com>
Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Tested-by: Gregory Nowak <greg@gregn.net>
---
 drivers/tty/vt/selection.c | 46 ++++++++++++++++++++++++++++++----------------
 drivers/tty/vt/vt.c        |  7 ++++---
 include/linux/selection.h  |  7 ++++---
 3 files changed, 38 insertions(+), 22 deletions(-)

diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
index 07496c7..78732fe 100644
--- a/drivers/tty/vt/selection.c
+++ b/drivers/tty/vt/selection.c
@@ -2,7 +2,9 @@
 /*
  * This module exports the functions:
  *
- *     'int set_selection(struct tiocl_selection __user *, struct tty_struct *)'
+ *     'int set_selection_user(struct tiocl_selection __user *,
+ *			       struct tty_struct *)'
+ *     'int set_selection_kernel(struct tiocl_selection *, struct tty_struct *)'
  *     'void clear_selection(void)'
  *     'int paste_selection(struct tty_struct *)'
  *     'int sel_loadlut(char __user *)'
@@ -80,6 +82,7 @@ void clear_selection(void)
 		sel_start = -1;
 	}
 }
+EXPORT_SYMBOL_GPL(clear_selection);
 
 /*
  * User settable table: what characters are to be considered alphabetic?
@@ -154,7 +157,7 @@ static int store_utf8(u32 c, char *p)
 }
 
 /**
- *	set_selection		- 	set the current selection.
+ *	set_selection_user	-	set the current selection.
  *	@sel: user selection info
  *	@tty: the console tty
  *
@@ -163,35 +166,44 @@ static int store_utf8(u32 c, char *p)
  *	The entire selection process is managed under the console_lock. It's
  *	 a lot under the lock but its hardly a performance path
  */
-int set_selection(const struct tiocl_selection __user *sel, struct tty_struct *tty)
+int set_selection_user(const struct tiocl_selection __user *sel,
+		       struct tty_struct *tty)
+{
+	struct tiocl_selection v;
+
+	if (copy_from_user(&v, sel, sizeof(*sel)))
+		return -EFAULT;
+
+	return set_selection_kernel(&v, tty);
+}
+
+int set_selection_kernel(struct tiocl_selection *v, struct tty_struct *tty)
 {
 	struct vc_data *vc = vc_cons[fg_console].d;
 	int new_sel_start, new_sel_end, spc;
-	struct tiocl_selection v;
 	char *bp, *obp;
 	int i, ps, pe, multiplier;
 	u32 c;
 	int mode;
 
 	poke_blanked_console();
-	if (copy_from_user(&v, sel, sizeof(*sel)))
-		return -EFAULT;
 
-	v.xs = min_t(u16, v.xs - 1, vc->vc_cols - 1);
-	v.ys = min_t(u16, v.ys - 1, vc->vc_rows - 1);
-	v.xe = min_t(u16, v.xe - 1, vc->vc_cols - 1);
-	v.ye = min_t(u16, v.ye - 1, vc->vc_rows - 1);
-	ps = v.ys * vc->vc_size_row + (v.xs << 1);
-	pe = v.ye * vc->vc_size_row + (v.xe << 1);
+	v->xs = min_t(u16, v->xs - 1, vc->vc_cols - 1);
+	v->ys = min_t(u16, v->ys - 1, vc->vc_rows - 1);
+	v->xe = min_t(u16, v->xe - 1, vc->vc_cols - 1);
+	v->ye = min_t(u16, v->ye - 1, vc->vc_rows - 1);
+	ps = v->ys * vc->vc_size_row + (v->xs << 1);
+	pe = v->ye * vc->vc_size_row + (v->xe << 1);
 
-	if (v.sel_mode == TIOCL_SELCLEAR) {
+	if (v->sel_mode == TIOCL_SELCLEAR) {
 		/* useful for screendump without selection highlights */
 		clear_selection();
 		return 0;
 	}
 
-	if (mouse_reporting() && (v.sel_mode & TIOCL_SELMOUSEREPORT)) {
-		mouse_report(tty, v.sel_mode & TIOCL_SELBUTTONMASK, v.xs, v.ys);
+	if (mouse_reporting() && (v->sel_mode & TIOCL_SELMOUSEREPORT)) {
+		mouse_report(tty, v->sel_mode & TIOCL_SELBUTTONMASK, v->xs,
+			     v->ys);
 		return 0;
 	}
 
@@ -208,7 +220,7 @@ int set_selection(const struct tiocl_selection __user *sel, struct tty_struct *t
 	else
 		use_unicode = 0;
 
-	switch (v.sel_mode)
+	switch (v->sel_mode)
 	{
 		case TIOCL_SELCHAR:	/* character-by-character selection */
 			new_sel_start = ps;
@@ -322,6 +334,7 @@ int set_selection(const struct tiocl_selection __user *sel, struct tty_struct *t
 	sel_buffer_lth = bp - sel_buffer;
 	return 0;
 }
+EXPORT_SYMBOL_GPL(set_selection_kernel);
 
 /* Insert the contents of the selection buffer into the
  * queue of the tty associated with the current console.
@@ -367,3 +380,4 @@ int paste_selection(struct tty_struct *tty)
 	tty_ldisc_deref(ld);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(paste_selection);
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index d34984a..f3c369a 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1804,7 +1804,7 @@ void mouse_report(struct tty_struct *tty, int butt, int mrx, int mry)
 	respond_string(buf, tty->port);
 }
 
-/* invoked via ioctl(TIOCLINUX) and through set_selection */
+/* invoked via ioctl(TIOCLINUX) and through set_selection_user */
 int mouse_reporting(void)
 {
 	return vc_cons[fg_console].d->vc_report_mouse;
@@ -3008,7 +3008,7 @@ static struct tty_driver *vt_console_device(struct console *c, int *index)
  * There are some functions which can sleep for arbitrary periods
  * (paste_selection) but we don't need the lock there anyway.
  *
- * set_selection has locking, and definitely needs it
+ * set_selection_user has locking, and definitely needs it
  */
 
 int tioclinux(struct tty_struct *tty, unsigned long arg)
@@ -3028,7 +3028,8 @@ int tioclinux(struct tty_struct *tty, unsigned long arg)
 	{
 		case TIOCL_SETSEL:
 			console_lock();
-			ret = set_selection((struct tiocl_selection __user *)(p+1), tty);
+			ret = set_selection_user((struct tiocl_selection
+						 __user *)(p+1), tty);
 			console_unlock();
 			break;
 		case TIOCL_PASTESEL:
diff --git a/include/linux/selection.h b/include/linux/selection.h
index a8f5b97..e2c1f96 100644
--- a/include/linux/selection.h
+++ b/include/linux/selection.h
@@ -11,13 +11,14 @@
 #include <linux/tiocl.h>
 #include <linux/vt_buffer.h>
 
-struct tty_struct;
-
 extern struct vc_data *sel_cons;
 struct tty_struct;
 
 extern void clear_selection(void);
-extern int set_selection(const struct tiocl_selection __user *sel, struct tty_struct *tty);
+extern int set_selection_user(const struct tiocl_selection __user *sel,
+			      struct tty_struct *tty);
+extern int set_selection_kernel(struct tiocl_selection *v,
+				struct tty_struct *tty);
 extern int paste_selection(struct tty_struct *tty);
 extern int sel_loadlut(char __user *p);
 extern int mouse_reporting(void);
-- 
1.8.3.1

