Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9F7C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBCC121925
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138563;
	bh=nOSG1qcLBRM42UoaVa5NOGr5SNgBk9OV0sZMm4x3m8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LzE0S1pnO825CIT90r05/jTsChQeOP5YORNxnGQcmKo7SMb6J07YuOGpbbtVheEWZ
	 jlPbopL1N5VdyvlaspKySspG3vYxfWL1AL2d3TVuBZZF/giNC5+JMw9wcdH//GjfF8
	 LMZBfmFj02PKVNjQrMHxhSrL2qH9Gsl8nQenBpJA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729770AbfDARJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:09:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:56230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728940AbfDARJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:09:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14B1F206B8;
        Mon,  1 Apr 2019 17:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138557;
        bh=nOSG1qcLBRM42UoaVa5NOGr5SNgBk9OV0sZMm4x3m8Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V3gXzEJExFjYK8lz7nBbAcq+d+VPtOoY2ItFgGTzB/YLVaAKo31Mj3HuL6FJeC0v1
         nVoJywMkGfr0d+pzZLxUfW8h1RHJMpuKFY1RIao1PvjkhlTE9JS8xGqrx5ulMQ/Yp3
         f0MF3p6Mc0LQvExJKi/9xGatkfZFRSyM+AyBqmhA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [PATCH 5.0 084/146] staging: speakup_soft: Fix alternate speech with other synths
Date:   Mon,  1 Apr 2019 19:01:36 +0200
Message-Id: <20190401170055.947787860@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

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
@@ -74,6 +74,7 @@ int synth_request_region(unsigned long s
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


