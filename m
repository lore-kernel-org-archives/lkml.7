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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F399BC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF5DF20882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qIu33DSY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730317AbfDDTq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 15:46:57 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55455 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730403AbfDDTq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 15:46:56 -0400
Received: by mail-wm1-f65.google.com with SMTP id o25so4371574wmf.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 12:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3XA/q0F+OjZv6wyBp24cyId1qh4YjJhW8qsp5NOxJfk=;
        b=qIu33DSYmocs15mMk5r8IOrhx5pc7dPv7iAiH0IkyFyTONUQjIexnjxw4Wo1+/V3Hs
         U5TMmdmFONi+SMqwMh03mAffZIEkQhnwMmnUbOCkFdTLctjZFQtfkA/GQAiPI77sfRMc
         HlZ/Ura/GRujsOYpnad6SfJWD5VjY156SXpaay/gBWNeRPwICqDfd0Y/6et7eUdUNTgx
         4pXJL2hLcs00p94Sn5/w+uuqjUQnjNUhpIhgwR7K3ZXZGKhfCalqSpGgS+j+OsVkG8Ts
         R1kbOX5RN7N6vzRjgMWqMsW4hLHHjkjL0CDuAlDQsieRBl5LAyiTBy+gOoOPghFGeEob
         Jgtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3XA/q0F+OjZv6wyBp24cyId1qh4YjJhW8qsp5NOxJfk=;
        b=SPfMjfUJj91Y82UepDF7v4n/EiYIwNJCrrHu2aDxTovrbAKQcoqcNIe4vZ3vJhUrWi
         qKwWUj1W2/6DEsYzYjseTggkAWvrZ0udSA/Ux/0ubzw0uDccLKyjkM2CeKtAmLuMytTa
         drKvG/+nT/Mns/04nlBiHnDvliCIneH/VqLledouvwBgfrVVb/qfP6WzqkS+4waBRjE4
         i6UetaHC7DyiBLEnbhfwjqs+tGmwxx3n/OHeLg7Jn+Utt13BNEkq92XaKf5T5BypjhM4
         yVQJx1gi0tAF1gvt8jAx2OAxoY8OWHgMJGk9FkBHtyKywzbTFm01nGWr1UyxDyTEZy5X
         NSPQ==
X-Gm-Message-State: APjAAAX0pQn2x8eA8vOtRuD3zQFoOm9uqb39Jjuw0r//ErYVu4bx4JGH
        NJh3zDExMQO2iLCDkeEhwTw=
X-Google-Smtp-Source: APXvYqx05JEfa911fnLhQe9OnTuEk4YGLLvpfFD7m8WX56NyrJ4OweZ0Efx3RRLRNMpTquWe7kXlSg==
X-Received: by 2002:a05:600c:ca:: with SMTP id u10mr5456341wmm.122.1554407213349;
        Thu, 04 Apr 2019 12:46:53 -0700 (PDT)
Received: from localhost.localdomain ([185.219.177.201])
        by smtp.gmail.com with ESMTPSA id f11sm23047400wrm.30.2019.04.04.12.46.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 12:46:52 -0700 (PDT)
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
Subject: [PATCH 2/2] staging: speakup: refactor to use existing code in vt
Date:   Thu,  4 Apr 2019 20:45:30 +0100
Message-Id: <20190404194530.1170-3-okash.khawaja@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404194530.1170-1-okash.khawaja@gmail.com>
References: <20190404194530.1170-1-okash.khawaja@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces speakup's implementations with calls to functions
in tty/vt/selection.c. Those functions are:

cancel_selection()
do_set_selection()
paste_selection()

Currently setting selection is done in interrupt context. However,
do_set_selection() can sleep - for instance, it requires console_lock
which can sleep. Therefore we offload that work to a work_struct thread,
following the same pattern which was already set for paste_selection().
When setting selection, we also get a reference to tty and make sure to
release the reference before returning.

struct speakup_paste_work has been renamed to the more generic
speakup_selection_work because it is now used for both pasting as well
as setting selection. When paste work is cancelled, the code wasn't
setting tty to NULL. This patch also fixes that by setting tty to NULL
so that in case of failure we don't get EBUSY forever.

Signed-off-by: Okash Khawaja <okash.khawaja@gmail.com>
Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Tested-by: Gregory Nowak <greg@gregn.net>
---
 drivers/staging/speakup/main.c      |   1 +
 drivers/staging/speakup/selection.c | 212 +++++++++++-----------------
 drivers/staging/speakup/speakup.h   |   1 +
 3 files changed, 88 insertions(+), 126 deletions(-)

diff --git a/drivers/staging/speakup/main.c b/drivers/staging/speakup/main.c
index b6a65b0c1896..488f2539aa9a 100644
--- a/drivers/staging/speakup/main.c
+++ b/drivers/staging/speakup/main.c
@@ -2319,6 +2319,7 @@ static void __exit speakup_exit(void)
 	unregister_keyboard_notifier(&keyboard_notifier_block);
 	unregister_vt_notifier(&vt_notifier_block);
 	speakup_unregister_devsynth();
+	speakup_cancel_selection();
 	speakup_cancel_paste();
 	del_timer_sync(&cursor_timer);
 	kthread_stop(speakup_task);
diff --git a/drivers/staging/speakup/selection.c b/drivers/staging/speakup/selection.c
index 0ed1fefee0e9..6c6d77f8bc24 100644
--- a/drivers/staging/speakup/selection.c
+++ b/drivers/staging/speakup/selection.c
@@ -9,178 +9,138 @@
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
 #include <linux/atomic.h>
+#include <linux/console.h>
 
 #include "speakup.h"
 
-/* ------ cut and paste ----- */
-/* Don't take this from <ctype.h>: 011-015 on the screen aren't spaces */
-#define ishardspace(c)      ((c) == ' ')
-
 unsigned short spk_xs, spk_ys, spk_xe, spk_ye; /* our region points */
-
-/* Variables for selection control. */
-/* must not be deallocated */
 struct vc_data *spk_sel_cons;
-/* cleared by clear_selection */
-static int sel_start = -1;
-static int sel_end;
-static int sel_buffer_lth;
-static char *sel_buffer;
 
-static unsigned char sel_pos(int n)
-{
-	return inverse_translate(spk_sel_cons,
-		screen_glyph(spk_sel_cons, n), 0);
-}
+struct speakup_selection_work {
+	struct work_struct work;
+	struct tiocl_selection sel;
+	struct tty_struct *tty;
+};
 
 void speakup_clear_selection(void)
 {
-	sel_start = -1;
+	console_lock();
+	clear_selection();
+	console_unlock();
 }
 
-/* does screen address p correspond to character at LH/RH edge of screen? */
-static int atedge(const int p, int size_row)
+static void __speakup_set_selection(struct work_struct *work)
 {
-	return !(p % size_row) || !((p + 2) % size_row);
-}
+	struct speakup_selection_work *ssw =
+		container_of(work, struct speakup_selection_work, work);
 
-/* constrain v such that v <= u */
-static unsigned short limit(const unsigned short v, const unsigned short u)
-{
-	return (v > u) ? u : v;
-}
+	struct tty_struct *tty;
+	struct tiocl_selection sel;
 
-int speakup_set_selection(struct tty_struct *tty)
-{
-	int new_sel_start, new_sel_end;
-	char *bp, *obp;
-	int i, ps, pe;
-	struct vc_data *vc = vc_cons[fg_console].d;
+	sel = ssw->sel;
 
-	spk_xs = limit(spk_xs, vc->vc_cols - 1);
-	spk_ys = limit(spk_ys, vc->vc_rows - 1);
-	spk_xe = limit(spk_xe, vc->vc_cols - 1);
-	spk_ye = limit(spk_ye, vc->vc_rows - 1);
-	ps = spk_ys * vc->vc_size_row + (spk_xs << 1);
-	pe = spk_ye * vc->vc_size_row + (spk_xe << 1);
+	/* this ensures we copy sel before releasing the lock below */
+	rmb();
 
-	if (ps > pe)	/* make sel_start <= sel_end */
-		swap(ps, pe);
+	/* release the lock by setting tty of the struct to NULL */
+	tty = xchg(&ssw->tty, NULL);
 
 	if (spk_sel_cons != vc_cons[fg_console].d) {
-		speakup_clear_selection();
 		spk_sel_cons = vc_cons[fg_console].d;
-		dev_warn(tty->dev,
-			 "Selection: mark console not the same as cut\n");
-		return -EINVAL;
+		pr_warn("Selection: mark console not the same as cut\n");
+		goto unref;
 	}
 
-	new_sel_start = ps;
-	new_sel_end = pe;
-
-	/* select to end of line if on trailing space */
-	if (new_sel_end > new_sel_start &&
-	    !atedge(new_sel_end, vc->vc_size_row) &&
-	    ishardspace(sel_pos(new_sel_end))) {
-		for (pe = new_sel_end + 2; ; pe += 2)
-			if (!ishardspace(sel_pos(pe)) ||
-			    atedge(pe, vc->vc_size_row))
-				break;
-		if (ishardspace(sel_pos(pe)))
-			new_sel_end = pe;
-	}
-	if ((new_sel_start == sel_start) && (new_sel_end == sel_end))
-		return 0; /* no action required */
-
-	sel_start = new_sel_start;
-	sel_end = new_sel_end;
-	/* Allocate a new buffer before freeing the old one ... */
-	bp = kmalloc((sel_end - sel_start) / 2 + 1, GFP_ATOMIC);
-	if (!bp) {
-		speakup_clear_selection();
-		return -ENOMEM;
-	}
-	kfree(sel_buffer);
-	sel_buffer = bp;
-
-	obp = bp;
-	for (i = sel_start; i <= sel_end; i += 2) {
-		*bp = sel_pos(i);
-		if (!ishardspace(*bp++))
-			obp = bp;
-		if (!((i + 2) % vc->vc_size_row)) {
-			/* strip trailing blanks from line and add newline,
-			 * unless non-space at end of line.
-			 */
-			if (obp != bp) {
-				bp = obp;
-				*bp++ = '\r';
-			}
-			obp = bp;
-		}
+	console_lock();
+	do_set_selection(&sel, tty);
+	console_unlock();
+
+unref:
+	tty_kref_put(tty);
+}
+
+static struct speakup_selection_work speakup_sel_work = {
+	.work = __WORK_INITIALIZER(speakup_sel_work.work,
+				   __speakup_set_selection)
+};
+
+int speakup_set_selection(struct tty_struct *tty)
+{
+	/* we get kref here first in order to avoid a subtle race when
+	 * cancelling selection work. getting kref first establishes the
+	 * invariant that if speakup_sel_work.tty is not NULL when
+	 * speakup_cancel_selection() is called, it must be the case that a put
+	 * kref is pending.
+	 */
+	tty_kref_get(tty);
+	if (cmpxchg(&speakup_sel_work.tty, NULL, tty)) {
+		tty_kref_put(tty);
+		return -EBUSY;
 	}
-	sel_buffer_lth = bp - sel_buffer;
+	/* now we have the 'lock' by setting tty member of
+	 * speakup_selection_work. wmb() ensures that writes to
+	 * speakup_sel_work don't happen before cmpxchg() above.
+	 */
+	wmb();
+
+	speakup_sel_work.sel.xs = spk_xs + 1;
+	speakup_sel_work.sel.ys = spk_ys + 1;
+	speakup_sel_work.sel.xe = spk_xe + 1;
+	speakup_sel_work.sel.ye = spk_ye + 1;
+	speakup_sel_work.sel.sel_mode = TIOCL_SELCHAR;
+
+	schedule_work_on(WORK_CPU_UNBOUND, &speakup_sel_work.work);
+
 	return 0;
 }
 
-struct speakup_paste_work {
-	struct work_struct work;
+void speakup_cancel_selection(void)
+{
 	struct tty_struct *tty;
-};
+
+	cancel_work_sync(&speakup_sel_work.work);
+	/* setting to null so that if work fails to run and we cancel it,
+	 * we can run it again without getting EBUSY forever from there on.
+	 * we need to use xchg here to avoid race with speakup_set_selection()
+	 */
+	tty = xchg(&speakup_sel_work.tty, NULL);
+	if (tty)
+		tty_kref_put(tty);
+}
 
 static void __speakup_paste_selection(struct work_struct *work)
 {
-	struct speakup_paste_work *spw =
-		container_of(work, struct speakup_paste_work, work);
-	struct tty_struct *tty = xchg(&spw->tty, NULL);
-	struct vc_data *vc = (struct vc_data *)tty->driver_data;
-	int pasted = 0, count;
-	struct tty_ldisc *ld;
-	DECLARE_WAITQUEUE(wait, current);
-
-	ld = tty_ldisc_ref(tty);
-	if (!ld)
-		goto tty_unref;
-	tty_buffer_lock_exclusive(&vc->port);
-
-	add_wait_queue(&vc->paste_wait, &wait);
-	while (sel_buffer && sel_buffer_lth > pasted) {
-		set_current_state(TASK_INTERRUPTIBLE);
-		if (tty_throttled(tty)) {
-			schedule();
-			continue;
-		}
-		count = sel_buffer_lth - pasted;
-		count = tty_ldisc_receive_buf(ld, sel_buffer + pasted, NULL,
-					      count);
-		pasted += count;
-	}
-	remove_wait_queue(&vc->paste_wait, &wait);
-	__set_current_state(TASK_RUNNING);
+	struct speakup_selection_work *ssw =
+		container_of(work, struct speakup_selection_work, work);
+	struct tty_struct *tty = xchg(&ssw->tty, NULL);
 
-	tty_buffer_unlock_exclusive(&vc->port);
-	tty_ldisc_deref(ld);
-tty_unref:
+	paste_selection(tty);
 	tty_kref_put(tty);
 }
 
-static struct speakup_paste_work speakup_paste_work = {
+static struct speakup_selection_work speakup_paste_work = {
 	.work = __WORK_INITIALIZER(speakup_paste_work.work,
 				   __speakup_paste_selection)
 };
 
 int speakup_paste_selection(struct tty_struct *tty)
 {
-	if (cmpxchg(&speakup_paste_work.tty, NULL, tty))
+	tty_kref_get(tty);
+	if (cmpxchg(&speakup_paste_work.tty, NULL, tty)) {
+		tty_kref_put(tty);
 		return -EBUSY;
+	}
 
-	tty_kref_get(tty);
 	schedule_work_on(WORK_CPU_UNBOUND, &speakup_paste_work.work);
 	return 0;
 }
 
 void speakup_cancel_paste(void)
 {
+	struct tty_struct *tty;
+
 	cancel_work_sync(&speakup_paste_work.work);
-	tty_kref_put(speakup_paste_work.tty);
+	tty = xchg(&speakup_paste_work.tty, NULL);
+	if (tty)
+		tty_kref_put(tty);
 }
diff --git a/drivers/staging/speakup/speakup.h b/drivers/staging/speakup/speakup.h
index e4f4f00be2dc..74fe49c2c511 100644
--- a/drivers/staging/speakup/speakup.h
+++ b/drivers/staging/speakup/speakup.h
@@ -72,6 +72,7 @@ void synth_buffer_add(u16 ch);
 void synth_buffer_clear(void);
 void speakup_clear_selection(void);
 int speakup_set_selection(struct tty_struct *tty);
+void speakup_cancel_selection(void);
 int speakup_paste_selection(struct tty_struct *tty);
 void speakup_cancel_paste(void);
 void speakup_register_devsynth(void);
-- 
2.21.0

