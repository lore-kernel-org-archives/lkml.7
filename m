Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC96C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 08:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15218206B8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 08:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.msu.ru header.i=@cs.msu.ru header.b="ZMlCrKZB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbfFEIkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 04:40:45 -0400
Received: from mx.cs.msu.ru ([188.44.42.42]:51120 "EHLO mail.cs.msu.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726636AbfFEIko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 04:40:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cs.msu.ru;
         s=dkim; h=Subject:Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=JBtc314UesgooPBehJ4MgN+ovha9N0zjMaGxUg7Avfs=; b=ZMlCrKZBdN2eB6AijUgU4Mgf1O
        82mHsoM2IbV5rxn9iCL5JWbICQQrj9ZK7ObCGZBJE6SJKmyaa9CFkmQMJ/aUKLzsVJvRsWDcsf6VU
        QZPrhWMEB8pFMM/GDs++eeHS1qHO13GHqsIcg3WwD4JuU+Z98E941D/NMZ64gqXEsO2DiMEcTy91y
        RZOAbmCAa3Gza9x8h5YfNAE+2noTawb8+5UznHfn/p/VEA+5A3Uikya4tISmlH4NQUtIBiIp4vnNm
        pSSpSLL9nTNSAHA1Xsyke7etkZ8qAavhHRHRqYQ4P5QOgJRiH6NymV0TCuRZFI3S3i6DSvictKkl4
        Y9CWPNpQ==;
Received: from [37.204.119.143] (port=55354 helo=localhost.localdomain)
        by mail.cs.msu.ru with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92 (FreeBSD))
        (envelope-from <ar@cs.msu.ru>)
        id 1hYR9U-0008s7-Uv; Wed, 05 Jun 2019 11:20:11 +0300
From:   Arseny Maslennikov <ar@cs.msu.ru>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     "Vladimir D . Seleznev" <vseleznv@altlinux.org>,
        Arseny Maslennikov <ar@cs.msu.ru>
Date:   Wed,  5 Jun 2019 11:19:05 +0300
Message-Id: <20190605081906.28938-7-ar@cs.msu.ru>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190605081906.28938-1-ar@cs.msu.ru>
References: <20190605081906.28938-1-ar@cs.msu.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 37.204.119.143
X-SA-Exim-Mail-From: ar@cs.msu.ru
Subject: [PATCH 6/7] n_tty: ->ops->write: Cut core logic out to a separate function
X-SA-Exim-Version: 4.2
X-SA-Exim-Scanned: No (on mail.cs.msu.ru); Unknown failure
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To simplify internal re-use of the line discipline's write method,
we isolate the work it does to its own function.

Since in-kernel callers might not refer to the tty through a file,
the struct file* argument might make no sense, so we also stop
tty_io_nonblock() from dereferencing file too early, allowing
to pass NULL as the referring file here.

Signed-off-by: Arseny Maslennikov <ar@cs.msu.ru>
---
 drivers/tty/n_tty.c | 33 ++++++++++++++++++++++-----------
 include/linux/tty.h |  2 +-
 2 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 29f33798a6cd..7d7d84adcffe 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -2309,22 +2309,15 @@ static ssize_t n_tty_read(struct tty_struct *tty, struct file *file,
  *		  lock themselves)
  */
 
-static ssize_t n_tty_write(struct tty_struct *tty, struct file *file,
-			   const unsigned char *buf, size_t nr)
+static ssize_t do_n_tty_write(struct tty_struct *tty, struct file *file,
+			      const unsigned char *buf, size_t nr)
 {
 	const unsigned char *b = buf;
 	DEFINE_WAIT_FUNC(wait, woken_wake_function);
 	int c;
 	ssize_t retval = 0;
 
-	/* Job control check -- must be done at start (POSIX.1 7.1.1.4). */
-	if (L_TOSTOP(tty) && file->f_op->write != redirected_tty_write) {
-		retval = tty_check_change(tty);
-		if (retval)
-			return retval;
-	}
-
-	down_read(&tty->termios_rwsem);
+	lockdep_assert_held_read(&tty->termios_rwsem);
 
 	/* Write out any echoed characters that are still pending */
 	process_echoes(tty);
@@ -2392,10 +2385,28 @@ static ssize_t n_tty_write(struct tty_struct *tty, struct file *file,
 	remove_wait_queue(&tty->write_wait, &wait);
 	if (nr && tty->fasync)
 		set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
-	up_read(&tty->termios_rwsem);
 	return (b - buf) ? b - buf : retval;
 }
 
+static ssize_t n_tty_write(struct tty_struct *tty, struct file *file,
+			   const unsigned char *buf, size_t nr)
+{
+	ssize_t retval = 0;
+
+	/* Job control check -- must be done at start (POSIX.1 7.1.1.4). */
+	if (L_TOSTOP(tty) && file->f_op->write != redirected_tty_write) {
+		retval = tty_check_change(tty);
+		if (retval)
+			return retval;
+	}
+
+	down_read(&tty->termios_rwsem);
+	retval = do_n_tty_write(tty, file, buf, nr);
+	up_read(&tty->termios_rwsem);
+
+	return retval;
+}
+
 /**
  *	n_tty_poll		-	poll method for N_TTY
  *	@tty: terminal device
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 07189f18f93d..ddb97704956d 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -388,7 +388,7 @@ static inline void tty_set_flow_change(struct tty_struct *tty, int val)
 
 static inline bool tty_io_nonblock(struct tty_struct *tty, struct file *file)
 {
-	return file->f_flags & O_NONBLOCK ||
+	return (file && file->f_flags & O_NONBLOCK) ||
 		test_bit(TTY_LDISC_CHANGING, &tty->flags);
 }
 
-- 
2.20.1

