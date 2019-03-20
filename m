Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6B0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 22:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66E97218D4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 22:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553120948;
	bh=oRaK19O3D9ZrwFghZnb18XXfv9+3H162NAdYdMdF4ks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=obUobNUMJeHWnChIUy9PVks1poefVwt02RsDd2a5ksnnhgyV+647NJcrI3fucc3w1
	 98V4dWqhmJCL0399n6FQwTqkuuMJKwvQ2fFoXiCCI1VX10WRzvLTbQwPGUVssHziT0
	 JHbJ39HvlsnytvENWeTid8qrm3YOc67Wkd7JIRag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfCTW3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 18:29:07 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:41487 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727564AbfCTW3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 18:29:05 -0400
Received: by mail-yw1-f67.google.com with SMTP id q128so3330609ywg.8;
        Wed, 20 Mar 2019 15:29:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DYaa3sSap9EzNyPtF8ZXKlbzOxq4cInzBuykp6Ou0k8=;
        b=D3cUyCL5f3Uq6Pwh6F8E7U4Y+laz4LNCpxp4+99ssEfXQITBwb1pFomrd1XEMlEyy4
         eidjmU31Ses8TOzr40HRTfBLKp9Ozf2uAXoiOF/ZZa6k/j4HgahqF66J9QtQLxSQBX/E
         6IguPBSvxmZyTIqrC1C/SREpHhsInaRzu7shmK8JUq21w+1LDZaNNYG0acsiDnMJ/DnE
         qMv/SHyWqWq/2z3of0Wbnqlkd4CDUccMxaoQwi7iw6OLfsNAPEACuwBZxg7GvWlTMJtF
         2chj1Sx8M820E/3dbYGcJ8PvpK9T3tx4Onup20B/HVqPM3pcM2az2nZIndMVK3EQCwdJ
         tCbA==
X-Gm-Message-State: APjAAAXyh4AxnmmLWOIWk+qKZ8tkUpIrYWTN4c3rxQy31Qm7bVIVnqYu
        7hNmezsJf65SL2XW4ZRs6AA=
X-Google-Smtp-Source: APXvYqxfpambTscKeen7xjavbFX57ULo+udBKXVmK3Us74m4heYIPhQWwo6aDaGNPVr52HGayqMZGQ==
X-Received: by 2002:a5b:51:: with SMTP id e17mr386715ybp.64.1553120943931;
        Wed, 20 Mar 2019 15:29:03 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id g1sm1052184ywf.0.2019.03.20.15.29.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 15:29:02 -0700 (PDT)
Received: by 42.do-not-panic.com (sSMTP sendmail emulation); Wed, 20 Mar 2019 22:29:00 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     akpm@linux-foundation.org, keescook@chromium.org
Cc:     sandeen@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 6/6] sysctl: Fix proc_do_large_bitmap for large input buffers
Date:   Wed, 20 Mar 2019 22:28:31 +0000
Message-Id: <20190320222831.8243-7-mcgrof@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190320222831.8243-1-mcgrof@kernel.org>
References: <20190320222831.8243-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Sandeen <sandeen@redhat.com>

Today, proc_do_large_bitmap() truncates a large write input buffer
to PAGE_SIZE - 1, which may result in misparsed numbers at the
(truncated) end of the buffer.  Further, it fails to notify the caller
that the buffer was truncated, so it doesn't get called iteratively
to finish the entire input buffer.

Tell the caller if there's more work to do by adding the skipped
amount back to left/*lenp before returning.

To fix the misparsing, reset the position if we have completely
consumed a truncated buffer (or if just one char is left, which
may be a "-" in a range), and ask the caller to come back for
more.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kernel/sysctl.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index e1a8d785b839..ddc6c717355d 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -3159,9 +3159,13 @@ int proc_do_large_bitmap(struct ctl_table *table, int write,
 
 	if (write) {
 		char *kbuf, *p;
+		size_t skipped = 0;
 
-		if (left > PAGE_SIZE - 1)
+		if (left > PAGE_SIZE - 1) {
 			left = PAGE_SIZE - 1;
+			/* How much of the buffer we'll skip this pass */
+			skipped = *lenp - left;
+		}
 
 		p = kbuf = memdup_user_nul(buffer, left);
 		if (IS_ERR(kbuf))
@@ -3178,9 +3182,22 @@ int proc_do_large_bitmap(struct ctl_table *table, int write,
 		while (!err && left) {
 			unsigned long val_a, val_b;
 			bool neg;
+			size_t saved_left;
 
+			/* In case we stop parsing mid-number, we can reset */
+			saved_left = left;
 			err = proc_get_long(&p, &left, &val_a, &neg, tr_a,
 					     sizeof(tr_a), &c);
+			/*
+			 * If we consumed the entirety of a truncated buffer or
+			 * only one char is left (may be a "-"), then stop here,
+			 * reset, & come back for more.
+			 */
+			if ((left <= 1) && skipped) {
+				left = saved_left;
+				break;
+			}
+
 			if (err)
 				break;
 			if (val_a >= bitmap_len || neg) {
@@ -3198,6 +3215,15 @@ int proc_do_large_bitmap(struct ctl_table *table, int write,
 				err = proc_get_long(&p, &left, &val_b,
 						     &neg, tr_b, sizeof(tr_b),
 						     &c);
+				/*
+				 * If we consumed all of a truncated buffer or
+				 * then stop here, reset, & come back for more.
+				 */
+				if (!left && skipped) {
+					left = saved_left;
+					break;
+				}
+
 				if (err)
 					break;
 				if (val_b >= bitmap_len || neg ||
@@ -3216,6 +3242,7 @@ int proc_do_large_bitmap(struct ctl_table *table, int write,
 			proc_skip_char(&p, &left, '\n');
 		}
 		kfree(kbuf);
+		left += skipped;
 	} else {
 		unsigned long bit_a, bit_b = 0;
 
-- 
2.18.0

