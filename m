Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0
	tests=BUG6152_INVALID_DATE_TZ_ABSURD,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A62C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 22:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0F78214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 22:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389530AbfHGW1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 18:27:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51821 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388848AbfHGW1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 18:27:31 -0400
Received: from [5.158.153.52] (helo=g2noscherz.tec.linutronix.de.)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1hvUOm-0007mg-EJ; Thu, 08 Aug 2019 00:27:14 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>
Subject: [RFC PATCH v4 6/9] printk-rb: adjust test module ringbuffer sizes
Date:   Thu,  8 Aug 2019 00:32:31 +0206
Message-Id: <20190807222634.1723-7-john.ogness@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807222634.1723-1-john.ogness@linutronix.de>
References: <20190807222634.1723-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ringbuffer documents that the expected average size value
should be lower than the actual average. For the test module the
average should be 64, so set the expected average to 5 bits (32).

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/test_prb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/printk/test_prb.c b/kernel/printk/test_prb.c
index 1ecb4fcbf823..77d298b6990a 100644
--- a/kernel/printk/test_prb.c
+++ b/kernel/printk/test_prb.c
@@ -63,7 +63,7 @@ static void dump_rb(struct printk_ringbuffer *rb)
 	trace_printk("END full dump\n");
 }
 
-DECLARE_PRINTKRB(test_rb, 7, 5);
+DECLARE_PRINTKRB(test_rb, 5, 7);
 
 static int prbtest_writer(void *data)
 {
-- 
2.20.1

