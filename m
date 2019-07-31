Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72EC7C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 06:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E8A6206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 06:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387600AbfGaGrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 02:47:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59254 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfGaGrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 02:47:23 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1hsiO5-0007ZR-Rq; Wed, 31 Jul 2019 08:47:01 +0200
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
Subject: Re: [RFC PATCH v3 2/2] printk-rb: add test module
References: <20190727013333.11260-1-john.ogness@linutronix.de>
        <20190727013333.11260-3-john.ogness@linutronix.de>
Date:   Wed, 31 Jul 2019 08:46:58 +0200
In-Reply-To: <20190727013333.11260-3-john.ogness@linutronix.de> (John Ogness's
        message of "Sat, 27 Jul 2019 03:33:33 +0200")
Message-ID: <878ssen1jx.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing includes and exports.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 In case anyone wants to build/run my test module, this patch needs to
 be applied. For my arm64 tests I need to build the module slightly
 different, which is why I didn't catch this. Sorry.

 Tested on 5.3-rc2.

 kernel/printk/dataring.c   |  1 +
 kernel/printk/numlist.c    |  1 +
 kernel/printk/ringbuffer.c |  4 ++++

diff --git a/kernel/printk/dataring.c b/kernel/printk/dataring.c
index 911bac593ec1..6642e085a05d 100644
--- a/kernel/printk/dataring.c
+++ b/kernel/printk/dataring.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/kernel.h>
 #include "dataring.h"
 
 /**
diff --git a/kernel/printk/numlist.c b/kernel/printk/numlist.c
index df3f89e7f7fd..d5e224dafc0c 100644
--- a/kernel/printk/numlist.c
+++ b/kernel/printk/numlist.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/kernel.h>
 #include <linux/sched.h>
 #include "numlist.h"
 
diff --git a/kernel/printk/ringbuffer.c b/kernel/printk/ringbuffer.c
index 59bf59aba3de..b9fc13597b10 100644
--- a/kernel/printk/ringbuffer.c
+++ b/kernel/printk/ringbuffer.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/kernel.h>
 #include <linux/irqflags.h>
 #include <linux/string.h>
 #include <linux/err.h>
@@ -222,6 +223,7 @@ struct nl_node *prb_desc_node(unsigned long id, void *arg)
 
 	return &d->list;
 }
+EXPORT_SYMBOL(prb_desc_node);
 
 /**
  * prb_desc_busy() - Numbered list callback to report if a node is busy.
@@ -262,6 +264,7 @@ bool prb_desc_busy(unsigned long id, void *arg)
 	/* hC: */
 	return (id == atomic_long_read(&d->id));
 }
+EXPORT_SYMBOL(prb_desc_busy);
 
 /**
  * prb_getdesc() - Data ringbuffer callback to lookup a descriptor from an ID.
@@ -296,6 +299,7 @@ struct dr_desc *prb_getdesc(unsigned long id, void *arg)
 	/* iB: */
 	return &d->desc;
 }
+EXPORT_SYMBOL(prb_getdesc);
 
 /**
  * assign_desc() - Assign a descriptor to the caller.
-- 
2.11.0
