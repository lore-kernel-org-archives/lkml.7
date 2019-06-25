Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2006C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 885892080C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.msu.ru header.i=@cs.msu.ru header.b="pkPsUBvL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732526AbfFYQMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 12:12:40 -0400
Received: from mx.cs.msu.ru ([188.44.42.42]:28040 "EHLO mail.cs.msu.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729583AbfFYQMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 12:12:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cs.msu.ru;
         s=dkim; h=Subject:Content-Transfer-Encoding:Content-Type:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=hzE1VNpnn5mxhjNCPcsJYlFRxK3YPhV+NqNkyq2FbmY=; b=pkPsUBvLlUEzGFFRyBRbWbRmT2
        lPGi49SDzDjYqKcarAoBR7QBBDXorJ4coivYCeBBrtZ7AEV+DNE51vQ3VF9WJO7+DEXvcwMTwQQk/
        +Icf4JbSdVChCuRB1VrFnpSTLWIhvD+qyEW/SSRb3Ad+4vbhszUtGHHZuTvR4Lpr5xGKD4YRJhIgK
        Gui+HQnT4iw7MPfE2YrOXjOBXwgb/ydXnQECMJxWAR9Won6bw56qvepne3X7gayclGTM5WlocgQHa
        tBkTWDviex5W154FXrae7DGkY9EenaM9wLxiUHYn0FegBLy66tbZydCi4H81EMuRz0t+J+HLXbxKu
        TNcFoWyQ==;
Received: from [10.7.4.141] (port=44632 helo=cello.cs.msu.ru)
        by mail.cs.msu.ru with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92 (FreeBSD))
        (envelope-from <ar@cs.msu.ru>)
        id 1hfo3F-0006Uf-DC; Tue, 25 Jun 2019 19:12:09 +0300
From:   Arseny Maslennikov <ar@cs.msu.ru>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Vladimir D. Seleznev" <vseleznv@altlinux.org>,
        Rob Landley <rob@landley.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Pavel Machek <pavel@ucw.cz>, Arseny Maslennikov <ar@cs.msu.ru>
Date:   Tue, 25 Jun 2019 19:11:49 +0300
Message-Id: <20190625161153.29811-4-ar@cs.msu.ru>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190625161153.29811-1-ar@cs.msu.ru>
References: <20190625161153.29811-1-ar@cs.msu.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 10.7.4.141
X-SA-Exim-Mail-From: ar@cs.msu.ru
Subject: [PATCH v2 3/7] n_tty: Send SIGINFO to fg pgrp on status request character
X-SA-Exim-Version: 4.2
X-SA-Exim-Scanned: Yes (on mail.cs.msu.ru)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No kerninfo line is printed yet.

No existing implementation of this on any Unix-like system echoes
the status character; no existing implementation discards or flushes
pending input on VSTATUS receipt.

There are existing popular TUI applications (e. g. mutt) that only
turn off icanon and not iexten, but still do not expect any special
treatment of the status request character — thus we require all three:
isig, icanon and iexten to trigger this.

Signed-off-by: Arseny Maslennikov <ar@cs.msu.ru>
---
 drivers/tty/n_tty.c | 15 +++++++++++++--
 include/linux/tty.h |  1 +
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index f9c584244f72..29f33798a6cd 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -79,6 +79,10 @@
 #define ECHO_BLOCK		256
 #define ECHO_DISCARD_WATERMARK	N_TTY_BUF_SIZE - (ECHO_BLOCK + 32)
 
+#define SIG_FLUSHING_MASK ( \
+	rt_sigmask(SIGINT) | rt_sigmask(SIGQUIT) | \
+	rt_sigmask(SIGTSTP)			 )
+#define SIG_FLUSHING(sig) ((1 << sig) & SIG_FLUSHING_MASK)
 
 #undef N_TTY_TRACE
 #ifdef N_TTY_TRACE
@@ -1122,7 +1126,7 @@ static void isig(int sig, struct tty_struct *tty)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 
-	if (L_NOFLSH(tty)) {
+	if (L_NOFLSH(tty) || (!SIG_FLUSHING(sig))) {
 		/* signal only */
 		__isig(sig, tty);
 
@@ -1244,7 +1248,8 @@ n_tty_receive_signal_char(struct tty_struct *tty, int signal, unsigned char c)
 	if (I_IXON(tty))
 		start_tty(tty);
 	if (L_ECHO(tty)) {
-		echo_char(c, tty);
+		if (c != STATUS_CHAR(tty))
+			echo_char(c, tty);
 		commit_echoes(tty);
 	} else
 		process_echoes(tty);
@@ -1294,6 +1299,9 @@ n_tty_receive_char_special(struct tty_struct *tty, unsigned char c)
 		} else if (c == SUSP_CHAR(tty)) {
 			n_tty_receive_signal_char(tty, SIGTSTP, c);
 			return 0;
+		} else if (c == STATUS_CHAR(tty)) {
+			n_tty_receive_signal_char(tty, SIGINFO, c);
+			return 0;
 		}
 	}
 
@@ -1848,6 +1856,9 @@ static void n_tty_set_termios(struct tty_struct *tty, struct ktermios *old)
 			set_bit(INTR_CHAR(tty), ldata->char_map);
 			set_bit(QUIT_CHAR(tty), ldata->char_map);
 			set_bit(SUSP_CHAR(tty), ldata->char_map);
+			if (L_ICANON(tty) && L_IEXTEN(tty)) {
+				set_bit(STATUS_CHAR(tty), ldata->char_map);
+			}
 		}
 		clear_bit(__DISABLED_CHAR, ldata->char_map);
 		ldata->raw = 0;
diff --git a/include/linux/tty.h b/include/linux/tty.h
index bfa4e2ee94a9..38d8ffe7f0e3 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -120,6 +120,7 @@ struct tty_bufhead {
 #define WERASE_CHAR(tty) ((tty)->termios.c_cc[VWERASE])
 #define LNEXT_CHAR(tty)	((tty)->termios.c_cc[VLNEXT])
 #define EOL2_CHAR(tty) ((tty)->termios.c_cc[VEOL2])
+#define STATUS_CHAR(tty) ((tty)->termios.c_cc[VSTATUS])
 
 #define _I_FLAG(tty, f)	((tty)->termios.c_iflag & (f))
 #define _O_FLAG(tty, f)	((tty)->termios.c_oflag & (f))
-- 
2.20.1

