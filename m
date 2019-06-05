Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02177C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 08:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC5D5206B8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 08:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.msu.ru header.i=@cs.msu.ru header.b="CyUWE9M+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfFEIjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 04:39:10 -0400
Received: from mx.cs.msu.ru ([188.44.42.42]:50355 "EHLO mail.cs.msu.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726784AbfFEIjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 04:39:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cs.msu.ru;
         s=dkim; h=Subject:Content-Transfer-Encoding:Content-Type:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=WbHNl0iqFS+h/Y/NRQf+DQGfBRp0QLmLg6AqzLkUiMk=; b=CyUWE9M+1do1YtGsN8aHK9+ZLW
        AbEmO1u+9iEKW2kzwDSNNxWO8HryXIebKAjfDHV/qchPewyRNTgCUt44qvdrMjO2VSWJJ+8j2JRyK
        orbZ/ebhUJzQgKGYS2dlgUStSxZLb0+L7gOyyWVZx3fNCBxxiMHFxugjL/E+rOQshiUSx9VahdhHj
        zTVphjB0sIwutmFBdf7XwxoBCaCXWiRiZ57Om7iS8qE3cNX2v9ABp6pSLCYxl+tK9ViZOkHdX9UGz
        0C9sBKDE/vi2VHzPr+EOi8Giz0JFbEaIear9e2xPRw82gGvrCHBOxkOBX/whiVIdMOEnihqUvXxce
        0TNhlniQ==;
Received: from [37.204.119.143] (port=55354 helo=localhost.localdomain)
        by mail.cs.msu.ru with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92 (FreeBSD))
        (envelope-from <ar@cs.msu.ru>)
        id 1hYR9Q-0008s7-HJ; Wed, 05 Jun 2019 11:20:06 +0300
From:   Arseny Maslennikov <ar@cs.msu.ru>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     "Vladimir D . Seleznev" <vseleznv@altlinux.org>,
        Arseny Maslennikov <ar@cs.msu.ru>
Date:   Wed,  5 Jun 2019 11:19:03 +0300
Message-Id: <20190605081906.28938-5-ar@cs.msu.ru>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190605081906.28938-1-ar@cs.msu.ru>
References: <20190605081906.28938-1-ar@cs.msu.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 37.204.119.143
X-SA-Exim-Mail-From: ar@cs.msu.ru
Subject: [PATCH 4/7] linux/signal.h: Ignore SIGINFO by default in new tasks
X-SA-Exim-Version: 4.2
X-SA-Exim-Scanned: No (on mail.cs.msu.ru); Unknown failure
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This matches the behaviour of other Unix-like systems that have SIGINFO
and causes less harm to processes that do not install handlers for this
signal, making the keyboard status character non-fatal for them.

This is implemented with the assumption that SIGINFO is defined
to be equivalent to SIGPWR; still, there is no reason for PWR to
result in termination of the signal recipient anyway — it does not
indicate there is a fatal problem with the recipient's execution
context (like e.g. FPE/ILL do), and we have TERM/KILL for explicit
termination requests.

Signed-off-by: Arseny Maslennikov <ar@cs.msu.ru>
---
 include/linux/signal.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/signal.h b/include/linux/signal.h
index 9702016734b1..c365754ea647 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -360,7 +360,7 @@ extern bool unhandled_signal(struct task_struct *tsk, int sig);
  *	|  SIGSYS/SIGUNUSED  |	coredump 	|
  *	|  SIGSTKFLT         |	terminate	|
  *	|  SIGWINCH          |	ignore   	|
- *	|  SIGPWR            |	terminate	|
+ *	|  SIGPWR            |	ignore   	|
  *	|  SIGRTMIN-SIGRTMAX |	terminate       |
  *	+--------------------+------------------+
  *	|  non-POSIX signal  |  default action  |
@@ -411,7 +411,8 @@ extern bool unhandled_signal(struct task_struct *tsk, int sig);
 
 #define SIG_KERNEL_IGNORE_MASK (\
         rt_sigmask(SIGCONT)   |  rt_sigmask(SIGCHLD)   | \
-	rt_sigmask(SIGWINCH)  |  rt_sigmask(SIGURG)    )
+	rt_sigmask(SIGWINCH)  |  rt_sigmask(SIGURG)    | \
+	rt_sigmask(SIGINFO)			       )
 
 #define SIG_SPECIFIC_SICODES_MASK (\
 	rt_sigmask(SIGILL)    |  rt_sigmask(SIGFPE)    | \
-- 
2.20.1

