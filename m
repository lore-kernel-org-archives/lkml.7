Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B302CC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 18:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8809B206BF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 18:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/X0HDeH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfEMSPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 14:15:30 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33898 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbfEMSPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 14:15:30 -0400
Received: by mail-wm1-f66.google.com with SMTP id j187so551860wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 11:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DMklEuq6jJfcpdLRrRDndcHFAX+tf+f2K3CXJmVTE5E=;
        b=l/X0HDeHHcZgoN5AXz/Nk4f0b4WlB/sBoUTnj1x5e0gLc6gQG5cFzAiIDEFZuc4I3k
         kv6u6xZyvvwYR0FsmyHHna25ClfE30CHaKmjheNOG+g8l4WXcu8f6YuluLvIPxbreb/w
         BmJkc+vKGI9K0AvEozG+pYwvazU0V5U07RDJuXpoVifaJOnFLIoszh7mSZnUOKfUzcIo
         SFZddn2TmOYaTq5z+eGLnCyk8fqEMX748hK0vmCvFZMi5HEfEBkFiMrP2CSfQU9z+84T
         /E+1cOtyKKqgb0oi0IM10J3yfGTtSSF2vND2ksnBwcRMzMVWxFsxoZNXp4BhCgUWFMQc
         /hfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DMklEuq6jJfcpdLRrRDndcHFAX+tf+f2K3CXJmVTE5E=;
        b=RXpCk3aeunRgstl5Cgg7WNe1TeyoRUqs5ozVLzTuw3pR7k1RXE1BBnYrOHHRxNWZBf
         PBeM8CLBvcRd00JEhTYL7/QAm4UFnquyf/yJuGyULfyC8GihTEhKEhiwCOHf2Ku8ImXQ
         I0K46Kb5PP9gfOgV/PyRoxjJKUbJeyNK6QtN0GvN5W4h6R7z/P1ExC49AnGEHPlJu6ts
         8+/1ELFCD2FCKH80bSmFT9U1zyelJK2za4vzcfFG54s06p1or0Exbe7FnaNrDtsfb6K4
         rqJib0sfSXw9DP/7cPQhv7+c4vViAkGN2eIPaIWqMyS9d7W992HvHarFluFnX+ozc+G1
         gGuA==
X-Gm-Message-State: APjAAAVj4jlGgiyokIDR/ENWvuoUiduRvJNYteEO59iQJftk7S9J2myJ
        LRBDeADNtf/I33XVEXY71tY=
X-Google-Smtp-Source: APXvYqzlspmdxfffwTdM18e6oF3r5JHggAnrEJuiN84CiNjxFan3YOFVMG4n9pE4taLjYUHr7YP0Tw==
X-Received: by 2002:a1c:65c3:: with SMTP id z186mr14122834wmb.93.1557771327593;
        Mon, 13 May 2019 11:15:27 -0700 (PDT)
Received: from localhost.localdomain (lfbn-1-3343-169.w90-127.abo.wanadoo.fr. [90.127.110.169])
        by smtp.googlemail.com with ESMTPSA id n4sm381483wmb.22.2019.05.13.11.15.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 11:15:27 -0700 (PDT)
From:   sterchelen <sterchelen@gmail.com>
Cc:     sterchelen <sterchelen@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: [PATCH] kernel: Fix acct coding style
Date:   Mon, 13 May 2019 20:15:15 +0200
Message-Id: <20190513181516.11131-1-sterchelen@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve readability by applying coding style

Signed-off-by: Nicolas Sterchele <sterchelen@gmail.com>
---
 kernel/acct.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/kernel/acct.c b/kernel/acct.c
index 81f9831a7859..7369960a9555 100644
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -111,6 +111,7 @@ static int check_free_space(struct bsd_acct_struct *acct)
 
 	if (acct->active) {
 		u64 suspend = sbuf.f_blocks * SUSPEND;
+
 		do_div(suspend, 100);
 		if (sbuf.f_bavail <= suspend) {
 			acct->active = 0;
@@ -118,6 +119,7 @@ static int check_free_space(struct bsd_acct_struct *acct)
 		}
 	} else {
 		u64 resume = sbuf.f_blocks * RESUME;
+
 		do_div(resume, 100);
 		if (sbuf.f_bavail >= resume) {
 			acct->active = 1;
@@ -170,6 +172,7 @@ static struct bsd_acct_struct *acct_get(struct pid_namespace *ns)
 static void acct_pin_kill(struct fs_pin *pin)
 {
 	struct bsd_acct_struct *acct = to_acct(pin);
+
 	mutex_lock(&acct->lock);
 	do_acct_process(acct);
 	schedule_work(&acct->work);
@@ -182,8 +185,12 @@ static void acct_pin_kill(struct fs_pin *pin)
 
 static void close_work(struct work_struct *work)
 {
-	struct bsd_acct_struct *acct = container_of(work, struct bsd_acct_struct, work);
+	struct bsd_acct_struct *acct = container_of(
+			work,
+			struct bsd_acct_struct,
+			work);
 	struct file *file = acct->file;
+
 	if (file->f_op->flush)
 		file->f_op->flush(file, NULL);
 	__fput_sync(file);
@@ -389,8 +396,8 @@ static comp2_t encode_comp2_t(u64 value)
  */
 static u32 encode_float(u64 value)
 {
-	unsigned exp = 190;
-	unsigned u;
+	unsigned int exp = 190;
+	unsigned int u;
 
 	if (value == 0)
 		return 0;
@@ -449,7 +456,7 @@ static void fill_ac(acct_t *ac)
 #endif
 	do_div(elapsed, AHZ);
 	ac->ac_btime = get_seconds() - elapsed;
-#if ACCT_VERSION==2
+#if ACCT_VERSION == 2
 	ac->ac_ahz = AHZ;
 #endif
 
@@ -505,8 +512,9 @@ static void do_acct_process(struct bsd_acct_struct *acct)
 
 		ac.ac_pid = task_tgid_nr_ns(current, ns);
 		rcu_read_lock();
-		ac.ac_ppid = task_tgid_nr_ns(rcu_dereference(current->real_parent),
-					     ns);
+		ac.ac_ppid = task_tgid_nr_ns(
+			rcu_dereference(current->real_parent),
+			ns);
 		rcu_read_unlock();
 	}
 #endif
@@ -517,6 +525,7 @@ static void do_acct_process(struct bsd_acct_struct *acct)
 	if (file_start_write_trylock(file)) {
 		/* it's been opened O_APPEND, so position is irrelevant */
 		loff_t pos = 0;
+
 		__kernel_write(file, &ac, sizeof(acct_t), &pos);
 		file_end_write(file);
 	}
@@ -575,6 +584,7 @@ static void slow_acct_process(struct pid_namespace *ns)
 {
 	for ( ; ns; ns = ns->parent) {
 		struct bsd_acct_struct *acct = acct_get(ns);
+
 		if (acct) {
 			do_acct_process(acct);
 			mutex_unlock(&acct->lock);
-- 
2.21.0

