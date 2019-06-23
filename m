Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C06E3C43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 16:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BF5F20652
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 16:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="MOUMU729"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfFWQTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 12:19:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36107 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbfFWQTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 12:19:37 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5NGJOWu2708449
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 23 Jun 2019 09:19:25 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5NGJOWu2708449
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561306765;
        bh=C1Kv2nk7aXwpcGMAiNdwZsLrtNiio7MlvKQqLw/vd/Y=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=MOUMU729rpr6ey5G4ncXppoeyxc7EJlp2cLdzYJDdllObkBhPudoKwdBZt+KeUThu
         G/48AX4Y1YZ3AhUKVIBuX1bVbft2OWYQEg+KkZaeIxRzlaf8BP9En42oIYuNhCwA5o
         UibUguanRggLIdWmH9X8RVv3dWI7GUqEXCCRyv9PhbLQUStBfBNpWDojQjQTxikYik
         FfkqrIMG+JjS4Uv3HOFUKyCpIrHB8BMhsOq9Y+8FW2RDbplFI59dbjsbBOQlvfvwAR
         vBqrBVn+81gCJvgvnDtTogaEDgWgfaAI9yCUi4LGLOT/DIK0sPUHpirUCVDvGioQS/
         S2KNIM6H4kskg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5NGJO0b2708446;
        Sun, 23 Jun 2019 09:19:24 -0700
Date:   Sun, 23 Jun 2019 09:19:24 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Muchun Song <tipbot@zytor.com>
Message-ID: <tip-8afecaa68df1e94a9d634f1f961533a925f239fc@git.kernel.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        smuchun@gmail.com, hpa@zytor.com
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org,
          smuchun@gmail.com, hpa@zytor.com, tglx@linutronix.de
In-Reply-To: <20190618143305.2038-1-smuchun@gmail.com>
References: <20190618143305.2038-1-smuchun@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] softirq: Use __this_cpu_write() in
 takeover_tasklets()
Git-Commit-ID: 8afecaa68df1e94a9d634f1f961533a925f239fc
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  8afecaa68df1e94a9d634f1f961533a925f239fc
Gitweb:     https://git.kernel.org/tip/8afecaa68df1e94a9d634f1f961533a925f239fc
Author:     Muchun Song <smuchun@gmail.com>
AuthorDate: Tue, 18 Jun 2019 22:33:05 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 23 Jun 2019 18:14:27 +0200

softirq: Use __this_cpu_write() in takeover_tasklets()

The code is executed with interrupts disabled, so it's safe to use
__this_cpu_write().

[ tglx: Massaged changelog ]

Signed-off-by: Muchun Song <smuchun@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: joel@joelfernandes.org
Cc: rostedt@goodmis.org
Cc: frederic@kernel.org
Cc: paulmck@linux.vnet.ibm.com
Cc: alexander.levin@verizon.com
Cc: peterz@infradead.org
Link: https://lkml.kernel.org/r/20190618143305.2038-1-smuchun@gmail.com

---
 kernel/softirq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 2c3382378d94..eaf3bdf7c749 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -650,7 +650,7 @@ static int takeover_tasklets(unsigned int cpu)
 	/* Find end, append list for that CPU. */
 	if (&per_cpu(tasklet_vec, cpu).head != per_cpu(tasklet_vec, cpu).tail) {
 		*__this_cpu_read(tasklet_vec.tail) = per_cpu(tasklet_vec, cpu).head;
-		this_cpu_write(tasklet_vec.tail, per_cpu(tasklet_vec, cpu).tail);
+		__this_cpu_write(tasklet_vec.tail, per_cpu(tasklet_vec, cpu).tail);
 		per_cpu(tasklet_vec, cpu).head = NULL;
 		per_cpu(tasklet_vec, cpu).tail = &per_cpu(tasklet_vec, cpu).head;
 	}
