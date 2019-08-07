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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833E0C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 22:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DA4B214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 22:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389502AbfHGW13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 18:27:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51819 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388848AbfHGW12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 18:27:28 -0400
Received: from [5.158.153.52] (helo=g2noscherz.tec.linutronix.de.)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1hvUOg-0007mg-R5; Thu, 08 Aug 2019 00:27:08 +0200
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
Subject: [RFC PATCH v4 5/9] printk-rb: remove extra data buffer size allocation
Date:   Thu,  8 Aug 2019 00:32:30 +0206
Message-Id: <20190807222634.1723-6-john.ogness@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807222634.1723-1-john.ogness@linutronix.de>
References: <20190807222634.1723-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The buffer for the raw data storage included extra space at the
end for a long. This was meant to guarantee space for the ID of a
wrapping datablock. However, since datablocks are padded and the
dataring is implemented such that no datablock can end at exactly
the end of the data buffer:
	 DATA_WRAPS(begin) != DATA_WRAPS(next)
there will always be space available for the ID of a wrapping
datablock.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/ringbuffer.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/printk/ringbuffer.h b/kernel/printk/ringbuffer.h
index 462b4d3a3ee2..698d2328ea9e 100644
--- a/kernel/printk/ringbuffer.h
+++ b/kernel/printk/ringbuffer.h
@@ -175,8 +175,7 @@ struct dr_desc *prb_getdesc(unsigned long id, void *arg);
  * * descriptor 1 will be the next descriptor
  */
 #define DECLARE_PRINTKRB(name, avgdatabits, descbits)			\
-char _##name##_data[(1 << ((avgdatabits) + (descbits))) +		\
-				 sizeof(long)]				\
+char _##name##_data[1 << ((avgdatabits) + (descbits))]			\
 	__aligned(__alignof__(long));					\
 struct prb_desc _##name##_descs[1 << (descbits)] = {			\
 		{							\
-- 
2.20.1

