Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E53C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DDBC2082E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="teP7Gokw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730455AbfDDTqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 15:46:54 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45879 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729793AbfDDTqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 15:46:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id s15so5224342wra.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 12:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9WqxniVDABz/b0GhzlvQtonIOetHKNsnB5PBHBwGIpQ=;
        b=teP7GokwhgBE+bxCO4L/NY0PZUjNI+Zr1EIFKESnVw27voBHV7/XUBz0eWXm0Tlqlu
         YRrQQAtGVuOpLEUkYzD1Zt2lH7cN+NhzX2bWJ6iOnrRRaiupLI3zfb6lO+elGFHkmNYz
         YgML/d0MxuZD6mEnBtuzgfOvRLbOW7avbOM7NQnxuZB1x8OfG9zE1y5ksYRMDztKvNrn
         t+J6f+gPFCR5fGTMSMHCmuueWC7t6PzsEvA3Jc8PcqSuUfeLng5Ch37233aqLOElOXrq
         oTPpzzVDpgmQJIrywKERPKwToEoWSz/pVK7yQ9we/N9Y4xX1khEPDfgDUQ3+5HnZE6fv
         vfig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9WqxniVDABz/b0GhzlvQtonIOetHKNsnB5PBHBwGIpQ=;
        b=WkBERyR2XlItG+KOwJ5Q3c1SIip4Un232eyevFaZe6xJ5ewJVtMOWuuzr40tT/F1/x
         ouWfHyiREVVa8NwKSprs0Z7bGINIOgc1cv+ExbGarLmFhOLpXqsPEcjRY6A/4iVLwavV
         IQOvMh1Ej8ObpgFLpTEOGazBPKHLnxZKKv7ZcurUn2PVwQELz4vwgCSrCAGDNKgE3avR
         im4uNP3nCKT7Lpj6X5Ro+S1/63MfBp4NKoKvhtPjBBxSLH0DhCdFxDc/lU3uG7UbWQfc
         38K+6tv8/JpPEYmch2Ur9jNA+ViePto2U3cxM+Qbwntr8bS816ykmuWwk7zG++iwbnjc
         35vQ==
X-Gm-Message-State: APjAAAVZ8rUQP7ccst/pfflxFdQ+biH4KKx/gwGWm90GaYBWD5KcGG6v
        bfZG1+ywG3ZY4KQJyDoZ+7A=
X-Google-Smtp-Source: APXvYqwu8y9c1Rd8XfKrBspOLi2lAb0fd54StpSUFpa/t01gMjYNeXsu+DOIH48EvBxV1htDOaS2Og==
X-Received: by 2002:adf:f48f:: with SMTP id l15mr5542962wro.248.1554407211015;
        Thu, 04 Apr 2019 12:46:51 -0700 (PDT)
Received: from localhost.localdomain ([185.219.177.201])
        by smtp.gmail.com with ESMTPSA id f11sm23047400wrm.30.2019.04.04.12.46.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 12:46:50 -0700 (PDT)
From:   Okash Khawaja <okash.khawaja@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Gregory Nowak <greg@gregn.net>, linux-kernel@vger.kernel.org
Cc:     Jiri Slaby <jslaby@suse.com>, Ben Hutchings <ben@decadent.org.uk>,
        William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        John Covici <covici@ccs.covici.com>,
        Peter Hurley <peter@hurleysoftware.com>,
        devel@driverdev.osuosl.org, speakup@linux-speakup.org,
        Okash Khawaja <okash.khawaja@gmail.com>
Subject: [PATCH 1/2] vt: selection: allow functions to be called from inside kernel
Date:   Thu,  4 Apr 2019 20:45:29 +0100
Message-Id: <20190404194530.1170-2-okash.khawaja@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404194530.1170-1-okash.khawaja@gmail.com>
References: <20190404194530.1170-1-okash.khawaja@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch breaks set_selection() into two functions so that when
called from kernel, copy_from_user() can be avoided. It also exports
set_selection() and paste_selection().

These changes are used the following patch where speakup's selection
functionality calls into the above functions, thereby doing away with
parallel implementation.

Signed-off-by: Okash Khawaja <okash.khawaja@gmail.com>
Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Tested-by: Gregory Nowak <greg@gregn.net>
---
 drivers/tty/vt/selection.c | 37 ++++++++++++++++++++++++-------------
 include/linux/selection.h  |  3 +--
 2 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
index 07496c711d7d..a43f9cd9bdd6 100644
--- a/drivers/tty/vt/selection.c
+++ b/drivers/tty/vt/selection.c
@@ -80,6 +80,7 @@ void clear_selection(void)
 		sel_start = -1;
 	}
 }
+EXPORT_SYMBOL_GPL(clear_selection);
 
 /*
  * User settable table: what characters are to be considered alphabetic?
@@ -164,34 +165,42 @@ static int store_utf8(u32 c, char *p)
  *	 a lot under the lock but its hardly a performance path
  */
 int set_selection(const struct tiocl_selection __user *sel, struct tty_struct *tty)
+{
+	struct tiocl_selection v;
+
+	if (copy_from_user(&v, sel, sizeof(*sel)))
+		return -EFAULT;
+
+	return do_set_selection(&v, tty);
+}
+
+int do_set_selection(struct tiocl_selection *v, struct tty_struct *tty)
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
 
@@ -208,7 +217,7 @@ int set_selection(const struct tiocl_selection __user *sel, struct tty_struct *t
 	else
 		use_unicode = 0;
 
-	switch (v.sel_mode)
+	switch (v->sel_mode)
 	{
 		case TIOCL_SELCHAR:	/* character-by-character selection */
 			new_sel_start = ps;
@@ -322,6 +331,7 @@ int set_selection(const struct tiocl_selection __user *sel, struct tty_struct *t
 	sel_buffer_lth = bp - sel_buffer;
 	return 0;
 }
+EXPORT_SYMBOL_GPL(do_set_selection);
 
 /* Insert the contents of the selection buffer into the
  * queue of the tty associated with the current console.
@@ -367,3 +377,4 @@ int paste_selection(struct tty_struct *tty)
 	tty_ldisc_deref(ld);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(paste_selection);
diff --git a/include/linux/selection.h b/include/linux/selection.h
index a8f5b97b216f..171d77dfc825 100644
--- a/include/linux/selection.h
+++ b/include/linux/selection.h
@@ -11,13 +11,12 @@
 #include <linux/tiocl.h>
 #include <linux/vt_buffer.h>
 
-struct tty_struct;
-
 extern struct vc_data *sel_cons;
 struct tty_struct;
 
 extern void clear_selection(void);
 extern int set_selection(const struct tiocl_selection __user *sel, struct tty_struct *tty);
+extern int do_set_selection(struct tiocl_selection *v, struct tty_struct *tty);
 extern int paste_selection(struct tty_struct *tty);
 extern int sel_loadlut(char __user *p);
 extern int mouse_reporting(void);
-- 
2.21.0

