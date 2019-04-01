Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB07EC10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB9E02084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554141665;
	bh=amFmY2QgCsQjhksCSXw5n/G8VWsY0QpeM4VwtuHpIzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YGERoJf09CmeEONzOc/ac6vps8pE8Vo7eJ/kNy1fsLaPHSjWAvRbFfSDNhYLrYu7X
	 m1rii2XYtn1gDf/a+iXirdBynhVoOiDF+ESaOUbWKAjk0g7a0yFAoi+Q6UMQBeyq3B
	 RG7rSSZP/NGd90nOqHVFimSv+oKsi8PzoXbuwHs0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731057AbfDARQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:16:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:41930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730587AbfDARQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:16:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 438B520856;
        Mon,  1 Apr 2019 17:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138993;
        bh=amFmY2QgCsQjhksCSXw5n/G8VWsY0QpeM4VwtuHpIzU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pWSsdOfibCf0JhpYQ2V/VO8fEAvzmK5kf1TTUUOo8RiHQCocQydx7C6403tvxRSyG
         HHyo3mZVrrhB1/QmmyZYgdN3oM3ujsDbglpwVZeWaHDkiodlZuLT6AVHwgkSQ1oVf8
         16sWpIARKXBHOEIL8gfRkBlpYRteCnC1eChy/YvE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [PATCH 4.19 082/134] staging: speakup_soft: Fix alternate speech with other synths
Date:   Mon,  1 Apr 2019 19:01:58 +0200
Message-Id: <20190401170052.020946605@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170044.243719205@linuxfoundation.org>
References: <20190401170044.243719205@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Samuel Thibault <samuel.thibault@ens-lyon.org>

commit 45ac7b31bc6c4af885cc5b5d6c534c15bcbe7643 upstream.

When switching from speakup_soft to another synth, speakup_soft would
keep calling synth_buffer_getc() from softsynthx_read.

Let's thus make synth.c export the knowledge of the current synth, so
that speakup_soft can determine whether it should be running.

speakup_soft also needs to set itself alive, otherwise the switch would
let it remain silent.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/speakup/speakup_soft.c |   16 +++++++++++-----
 drivers/staging/speakup/spk_priv.h     |    1 +
 drivers/staging/speakup/synth.c        |    6 ++++++
 3 files changed, 18 insertions(+), 5 deletions(-)

--- a/drivers/staging/speakup/speakup_soft.c
+++ b/drivers/staging/speakup/speakup_soft.c
@@ -208,12 +208,15 @@ static ssize_t softsynthx_read(struct fi
 		return -EINVAL;
 
 	spin_lock_irqsave(&speakup_info.spinlock, flags);
+	synth_soft.alive = 1;
 	while (1) {
 		prepare_to_wait(&speakup_event, &wait, TASK_INTERRUPTIBLE);
-		if (!unicode)
-			synth_buffer_skip_nonlatin1();
-		if (!synth_buffer_empty() || speakup_info.flushing)
-			break;
+		if (synth_current() == &synth_soft) {
+			if (!unicode)
+				synth_buffer_skip_nonlatin1();
+			if (!synth_buffer_empty() || speakup_info.flushing)
+				break;
+		}
 		spin_unlock_irqrestore(&speakup_info.spinlock, flags);
 		if (fp->f_flags & O_NONBLOCK) {
 			finish_wait(&speakup_event, &wait);
@@ -233,6 +236,8 @@ static ssize_t softsynthx_read(struct fi
 
 	/* Keep 3 bytes available for a 16bit UTF-8-encoded character */
 	while (chars_sent <= count - bytes_per_ch) {
+		if (synth_current() != &synth_soft)
+			break;
 		if (speakup_info.flushing) {
 			speakup_info.flushing = 0;
 			ch = '\x18';
@@ -329,7 +334,8 @@ static __poll_t softsynth_poll(struct fi
 	poll_wait(fp, &speakup_event, wait);
 
 	spin_lock_irqsave(&speakup_info.spinlock, flags);
-	if (!synth_buffer_empty() || speakup_info.flushing)
+	if (synth_current() == &synth_soft &&
+	    (!synth_buffer_empty() || speakup_info.flushing))
 		ret = EPOLLIN | EPOLLRDNORM;
 	spin_unlock_irqrestore(&speakup_info.spinlock, flags);
 	return ret;
--- a/drivers/staging/speakup/spk_priv.h
+++ b/drivers/staging/speakup/spk_priv.h
@@ -72,6 +72,7 @@ int synth_request_region(unsigned long s
 int synth_release_region(unsigned long start, unsigned long n);
 int synth_add(struct spk_synth *in_synth);
 void synth_remove(struct spk_synth *in_synth);
+struct spk_synth *synth_current(void);
 
 extern struct speakup_info_t speakup_info;
 
--- a/drivers/staging/speakup/synth.c
+++ b/drivers/staging/speakup/synth.c
@@ -481,4 +481,10 @@ void synth_remove(struct spk_synth *in_s
 }
 EXPORT_SYMBOL_GPL(synth_remove);
 
+struct spk_synth *synth_current(void)
+{
+	return synth;
+}
+EXPORT_SYMBOL_GPL(synth_current);
+
 short spk_punc_masks[] = { 0, SOME, MOST, PUNC, PUNC | B_SYM };


