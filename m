Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED99C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 431AF205ED
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560100106;
	bh=+SaQOnpuc3KYK1Uzlk7Tb/UZnbTi3fsoVUAx8VBchwk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yulROacbPoQfbk/a7Phlikk80+wNkzxqIz8sjsoZe1c5VRTMpx3ktkl3qTJGZgVWA
	 oY6p3JVLce5qKSaHdCYOVuhZMZcVRD7/f4YjbVaiN6RduVSQfqN78JNk/ixYu2U5F7
	 MNm6cIIJaKG3Kjgtz9vjwXOFDO+rufEBmwsGmqjA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388802AbfFIRFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 13:05:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:44432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388776AbfFIRFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 13:05:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA860206DF;
        Sun,  9 Jun 2019 17:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560099915;
        bh=+SaQOnpuc3KYK1Uzlk7Tb/UZnbTi3fsoVUAx8VBchwk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rnpQ0yASeneioNk+zWwVCUympFR6+oH6jvM+0c46h8zP/K91s0VgdzL7ZAkOiiFiX
         XQJX39ZrfP8xzdtyRMv4A2lK9mho4ysO5BA24Xyg403cjWMgk2nrNs3F/04DDqkEZP
         NiMkK+dU18X6fRFiRy0QRv61imqCUlusSjWYkn70=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhenliang Wei <weizhenliang@huawei.com>,
        Christian Brauner <christian@brauner.io>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Ivan Delalande <colona@arista.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.4 212/241] kernel/signal.c: trace_signal_deliver when signal_group_exit
Date:   Sun,  9 Jun 2019 18:42:34 +0200
Message-Id: <20190609164154.784342867@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164147.729157653@linuxfoundation.org>
References: <20190609164147.729157653@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhenliang Wei <weizhenliang@huawei.com>

commit 98af37d624ed8c83f1953b1b6b2f6866011fc064 upstream.

In the fixes commit, removing SIGKILL from each thread signal mask and
executing "goto fatal" directly will skip the call to
"trace_signal_deliver".  At this point, the delivery tracking of the
SIGKILL signal will be inaccurate.

Therefore, we need to add trace_signal_deliver before "goto fatal" after
executing sigdelset.

Note: SEND_SIG_NOINFO matches the fact that SIGKILL doesn't have any info.

Link: http://lkml.kernel.org/r/20190425025812.91424-1-weizhenliang@huawei.com
Fixes: cf43a757fd4944 ("signal: Restore the stop PTRACE_EVENT_EXIT")
Signed-off-by: Zhenliang Wei <weizhenliang@huawei.com>
Reviewed-by: Christian Brauner <christian@brauner.io>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Ivan Delalande <colona@arista.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/signal.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2244,6 +2244,8 @@ relock:
 	if (signal_group_exit(signal)) {
 		ksig->info.si_signo = signr = SIGKILL;
 		sigdelset(&current->pending.signal, SIGKILL);
+		trace_signal_deliver(SIGKILL, SEND_SIG_NOINFO,
+				&sighand->action[SIGKILL - 1]);
 		recalc_sigpending();
 		goto fatal;
 	}


